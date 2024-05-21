Return-Path: <linux-kernel+bounces-185111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59FF8CB0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371DE1F21F17
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC40E142E61;
	Tue, 21 May 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxJlLqkt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3714290C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302690; cv=none; b=SGSqwyRCYB5ZUmxehCJXqO7STL1KYvQq+AqmMHSV9kxnpcKpYF1BrT8L/4wi3NtZjV1GggWFfhNq/nnJ1w4QmlLLw+Y46pWH77dymKnMD6jOYbVYk83FT9zNit1G3r/nrTqD4ks50LHRojb6GLGyMRZhFnRm41x2oY4h/ttE5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302690; c=relaxed/simple;
	bh=WW/wWfwIAXuathzXrZxgGxyNReuBIEcfFsBlfMQ7nj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1XkV9ifDk2LNbUR8LKXLeCz09cY+8Ts0+j5+NNSi2uN9KrGCXv6HhIwKBfMOscnVdG8Y+asW9mNsHA7tAZFbM8X0LtQwT9YmQfpMDXT0z+Lu207ExCbF1eIcuyenknhps/VTw0FOiP1tUoKOXjwt/5IKZdWxN31yIcJuiL0xP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxJlLqkt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716302687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1X3c6n+iDpwiHAzB2IaUrYZoxIhd6QM99ksN9JVqPE=;
	b=QxJlLqktCuiMcGwSzqx2oyUBCsm+8fR/uZoqELWaF14xdkJ6i8cqWvlPomQNtL8qv043w5
	STpnPG9LlQZdr94341YO5Pmq0qoBvWHq7MVg1QMcV0UkmvnAvgBMsRAIUjBlqf5TXLLI6t
	aLpV5ax2w/PVQnVw5rZZqKuDW78NQb0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-VCgoGZMrME-epKiAcYxJzQ-1; Tue, 21 May 2024 10:44:46 -0400
X-MC-Unique: VCgoGZMrME-epKiAcYxJzQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41ff4ec2bb5so51351895e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302685; x=1716907485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1X3c6n+iDpwiHAzB2IaUrYZoxIhd6QM99ksN9JVqPE=;
        b=KdnnB9RLPlApCI04hd0Z0fKCDkKpP1vCEL/Naf12A5+oTuEPa6z0WA/fpepmg9o4bV
         N1SpPEvHMgF+FF83+QyjPowSdBb6FCxHe2tLbhU/SHR+gTYqeVwhEtSFEBD6o/tK/6rJ
         zO1nWfOimPGMAEgZuleyCuMhTWj6DtXKzn/qJ5PpLDFFH85XCSluOSQ7TNHeR+1Y8x/p
         ZRCrVEkFHhcDGbVJRZbJS/kWDysw42kfFKAzjNWSQhtGnNQYoSGvMOgqtnvqvaNTbgRh
         nL5ErMUnsKK2lwjwBkcWjYBbBfT63jXQfCthgxyk9lLxRkTY0MLkjN+xrSWEF/vrSzST
         F5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwiQJX7cr8/R3PeFkL1QPoTlP+aNnxosTyFYjwDMDmvY1NNVrzM+1+jHPIHVjSGlgjx53csqqM5jHhOHteHmjtec8fSlaGtMLwdBd3
X-Gm-Message-State: AOJu0YxSqdxoxjfmH+EJTvt7QZGgiPzDi48ocSt7W1GVys6HZ4S9L4tH
	ivCwi5HftIJs3jtEQ87H4EsOkcSlt2XL46sDSLwts/+nrpkpjMaMKmo6+JwhYKj/UfFlkFIRxG0
	KJelmb/4dv7LsbNg6g+sCkSBOGEIvfAwEmJmfDWvI1RsKoM8iFqKtNkr4lKA5ytEcc/SkGVz/MF
	9fUscPKBxqNJs5lwFdCFsxaSc2YHswh0R1mzRB
X-Received: by 2002:a7b:cbcf:0:b0:416:7470:45ad with SMTP id 5b1f17b1804b1-41feaa43707mr284059415e9.17.1716302685252;
        Tue, 21 May 2024 07:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTjL2fo3hQEuqgFCW5ZUyIqz5CujBW9vBhPHEzfxdC96YXjrWdbBEyvHLsJ67A/H3kgeZYDxRhs4OuKQRSMa4=
X-Received: by 2002:a7b:cbcf:0:b0:416:7470:45ad with SMTP id
 5b1f17b1804b1-41feaa43707mr284059105e9.17.1716302684771; Tue, 21 May 2024
 07:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515172732.288391-1-mschmidt@redhat.com> <Zkuksm3K+pKugjgF@yury-ThinkPad>
 <3f3b75df-3488-4915-bc21-54cb6a6e2a74@linaro.org>
In-Reply-To: <3f3b75df-3488-4915-bc21-54cb6a6e2a74@linaro.org>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 21 May 2024 16:44:33 +0200
Message-ID: <CADEbmW0BZbJQbaycqq+vfisEJyGd57uzEgFEckusGLJSLvmYDA@mail.gmail.com>
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX_CONST
To: Alex Elder <elder@linaro.org>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 2:33=E2=80=AFPM Alex Elder <elder@linaro.org> wrote=
:
> On 5/20/24 2:29 PM, Yury Norov wrote:
> > + Alex Elder <elder@linaro.org>, Jakub Kicinski <kuba@kernel.org> and
> > David S. Miller <davem@davemloft.net>
>
> Thanks for adding me to this.
>
> My bottom line response is that I don't understand exactly
> what problem this is solving (but I trust it solves a
> problem for you).  It *seems* like the existing macro(s)
> should work for you, and if they don't, you might not be
> using it (them) correctly.  And... if a fix is needed, it
> should be made to the existing macro if possible.

Yury, Jakub, Alex,
thanks for your reviews so far.

All of you want to avoid adding another macro. I agree and I will be back
with v2.

To clarify where exactly I ran into the current limitations of FIELD_MAX:
I am reworking drivers/net/ethernet/intel/ice/ice_gnss.c:ice_gnss_read().
There, I will be changing "buf" to a small on-stack array:
  char buf[ICE_MAX_I2C_DATA_SIZE];
where ICE_MAX_I2C_DATA_SIZE is defined using FIELD_MAX.

There are a few more issues. I extracted them into this test case that
I would like to make compilable:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
#define TEST_REG_1 GENMASK(3,0)
#define TEST_MAX_1 FIELD_MAX(TEST_REG_1)

#define TEST_REG_2 GENMASK(BITS_PER_LONG - 1, BITS_PER_LONG - 2)
#define TEST_MAX_2 FIELD_MAX(TEST_REG_2)

/* Using FIELD_MAX inside a static_assert yields:
 *   error: braced-group within expression allowed only inside a function
 */
static_assert(TEST_MAX_1 =3D=3D 15);

/* Even after the above is solved, using a mask that has the highest bit se=
t
 * will expose another issue:
 *   error: bit-field =E2=80=98<anonymous>=E2=80=99 width not an integer co=
nstant
 * This one *might* be a gcc bug triggered by -fsanitize=3Dshift.
 * It does not appear with clang.
 * Defining __bf_shf as __builtin_ctzll(x) instead of __builtin_ffsll(x)-1 =
can
 * work around it, apparently.
 */
static_assert(TEST_MAX_2 =3D=3D 3);

int test_field_max_array(void);
int test_field_max_array(void)
{
        /* Using FIELD_MAX for sizing a local array yields:
         *   error: ISO C90 forbids variable length array =E2=80=98buf=E2=
=80=99 [-Werror=3Dvla]
         */
        char buf[TEST_MAX_1];

        /* This line compiles OK in the current implementation and must kee=
p
         * working.
         */
        WARN_ON(TEST_MAX_2 > 3);

        return sizeof(buf);
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D


> > On Wed, May 15, 2024 at 07:27:31PM +0200, Michal Schmidt wrote:
> >> FIELD_MAX_CONST is like FIELD_MAX, but it can be used where statement
> >> expressions are forbidden. For example, using FIELD_MAX in a
> >> static_assert gives:
> >>    error: braced-group within expression allowed only inside a functio=
n
>
> So you want to use FIELD_MAX() in the outer scope in a file,
> not within a function?  And the way it's currently defined
> doesn't permit that?

Right. Although, I don't *really* need to use it in outer scope.
It would be just nice to have. I just need the next thing:

> >> It can be used also in array declarations, where using FIELD_MAX would
> >> trigger a warning :
> >>    warning: ISO C90 forbids variable length array =E2=80=98buf=E2=80=
=99 [-Wvla]
>
> Are you passing a constant to FIELD_MAX() when computing the
> array size?  If so, I don't understand this warning.

Yes, the array is an automatic variable and its size is calculated with
FIELD_MAX from a constant GENMASK. Indeed, the warning is surprising.

> >> (It's a bit surprising, because despite the warning, gcc calculated
> >> the array size correctly at compile time.)
> >>
> >> A simplified example of what I actually want to use in a driver:
> >>    #define DATA_SIZE_M GENMASK(3, 0)
> >>    #define MAX_DATA_SIZE FIELD_MAX_CONST(DATA_SIZE_M)
>
> FIELD_MAX() returns the maximum representable value, not the
> number of possible values.
>
> >>    static void f(void) {
> >>      char buf[MAX_DATA_SIZE];
> >>      /* ... */
> >>    }
> >>
> >> In the implementation, reuse the existing compile-time checks from
> >> FIELD_PREP_CONST.
> >>
> >> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> >
> > Hi Michal,
> >
> > So... FIELD_MAX() already requires the _mask to be a const value.
> > Now you add a FIELD_MAX_CONST(), which makes it more confusing.
>
> Yes, it's not clear when you would use one rather than the other.
> I think a better fix is to fix the existing FIELD_MAX() (and
> field_max(), defined later in that file).
>
> > It looks like your new _CONST() macro would work anywhere where the
> > existing FIELD_MAX() works. At least for me, if I apply your patch
> > and do:
> >
> >          #define FIELD_MAX FIELD_MAX_CONST
> >
> > The implementation of the 'const' version looks the same as the
> > 'variable' one, except for that sanity checking business.
> >
> > I think the right path to go would be making the __BF_FIELD_CHECK()
> > a structure initializers friendly by using the BUILD_BUG_ON_ZERO(),
> > just like you did with the __BF_FIELD_CHECK_CONST(), so that the
> > FIELD_MAX() would work in all cases.
>
> I haven't investigated this much further, but yes, I agree that
> you should fix what's there to work the way you like if possible,
> while preserving all guarantees provided before.
>
> Still, I'll provide some comments on the patch below.
>
> > Thanks,
> > Yury
> >
> >> ---
> >>   include/linux/bitfield.h | 34 +++++++++++++++++++++++++++-------
> >>   1 file changed, 27 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> >> index 63928f173223..50bbab317319 100644
> >> --- a/include/linux/bitfield.h
> >> +++ b/include/linux/bitfield.h
> >> @@ -76,6 +76,16 @@
> >>                                            (1ULL << __bf_shf(_mask)));=
 \
> >>      })
> >>
> >> +#define __BF_FIELD_CHECK_CONST(_mask, _val)                         \
> >> +    (                                                               \
> >> +            /* mask must be non-zero */                             \
> >> +            BUILD_BUG_ON_ZERO((_mask) =3D=3D 0) +                    =
   \
>
> This ^^^ implements the opposite of what the comment says.  Use:
>                 BUILD_BUG_ON_ZERO(_mask);

No, I think you're misunderstanding what BUILD_BUG_ON_ZERO does.
It does not mean "BUG if the argument is zero".
It means "BUG if the argument is true. Otherwise, the value is 0."

> Also, why are you adding?  The way this macro is defined, it
> really should return Boolean, but you're returning an integer
> sum.
>
> >> +            /* check if value fits */                               \
> >> +            BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val))=
 + \
> >> +            /* check if mask is contiguous */                       \
> >> +            __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask)))    \
>
> I don't really see why __BUILD_BUG_ON_NOT_POWER_OF_2() isn't used
> here (and in FIELD_PREP_CONST() for that matter--other than line
> length).
>
> Each of the above checks can stand alone, and if they all pass,
> you can simply return true (or return the result of the last
> check, but I really think they should be treated as void type).

Note that I did not come up with the addition pattern. I just moved it
from FIELD_PREP_CONST. Its purpose is to avoid using a statement expression=
,
because that has certains limitations on where it can be used.

> >> +    )
> >> +
> >>   /**
> >>    * FIELD_MAX() - produce the maximum value representable by a field
> >>    * @_mask: shifted mask defining the field's length and position
> >> @@ -89,6 +99,22 @@
> >>              (typeof(_mask))((_mask) >> __bf_shf(_mask));            \
> >>      })
> >>
> >> +/**
> >> + * FIELD_MAX_CONST() - produce the maximum value representable by a f=
ield
> >> + * @_mask: shifted mask defining the field's length and position
> >> + *
> >> + * FIELD_MAX_CONST() returns the maximum value that can be held in
> >> + * the field specified by @_mask.
>
> I don't think this part of the description adds much; it
> basically restates what the one-liner does.

Right.
Anyway, v2 won't add the new macro.

Thanks!
Michal

>                                         -Alex
>
> >> + *
> >> + * Unlike FIELD_MAX(), it can be used where statement expressions can=
't.
> >> + * Error checking is less comfortable for this version.
> >> + */
> >> +#define FIELD_MAX_CONST(_mask)                                       =
       \
> >> +    (                                                               \
> >> +            __BF_FIELD_CHECK_CONST(_mask, 0ULL) +                   \
> >> +            (typeof(_mask))((_mask) >> __bf_shf(_mask))             \
> >> +    )
> >> +
> >>   /**
> >>    * FIELD_FIT() - check if value fits in the field
> >>    * @_mask: shifted mask defining the field's length and position
> >> @@ -132,13 +158,7 @@
> >>    */
> >>   #define FIELD_PREP_CONST(_mask, _val)                               =
       \
> >>      (                                                               \
> >> -            /* mask must be non-zero */                             \
> >> -            BUILD_BUG_ON_ZERO((_mask) =3D=3D 0) +                    =
   \
> >> -            /* check if value fits */                               \
> >> -            BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val))=
 + \
> >> -            /* check if mask is contiguous */                       \
> >> -            __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
> >> -            /* and create the value */                              \
> >> +            __BF_FIELD_CHECK_CONST(_mask, _val) +                   \
> >>              (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
> >>      )
> >>
> >> --
> >> 2.44.0
>


