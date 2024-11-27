Return-Path: <linux-kernel+bounces-423009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D339DA12B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492CF168534
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6752441C71;
	Wed, 27 Nov 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cB/dW1Ka"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED62BAF9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732678733; cv=none; b=ul/rhwc1MDmSJz65Tt7P08mYuzCk24scjydTccpvLFzeVjbi6FBj58pr/3/mp/c+vYIY2yebhbQJ/Fhnp9EZAA0dL91ev3GxXeaUn0NazGaDSOIiAPqLIKaW2iBouZpQKgWi+45Nmk3E/qoGC2lHp4L1sgravXtyWAVNkkgiO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732678733; c=relaxed/simple;
	bh=fS8NQOHGJ0ogLcUGas01yt4cIbC36qC1c0kAb7nEjj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdDpNDp3PVPOyfG0WiXjkQYY+wXCoRP251BBgTH2ZvmAwetegujxyCDv/AsNseEm7E/zOs8NNxvtWPEp/lLJ3iJT/JBfxhGDoOlz0b3RXI3i/Ky/wDa9JB/YdzKh/W7mJiKYRl6QNCIBAlE9JS4AAHyt4SgugMvsMR5ovoetW2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cB/dW1Ka; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3882273bc8so5739905276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 19:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732678730; x=1733283530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn2mqiTffvoc/D8+m6E2ss000lrDjRnXwpfuiiix1M4=;
        b=cB/dW1Ka9C9lJ5J9Y8Acsl1+4xWXQWUfM1JTXDvq1vGIkVq46JYtzzWFpWXyG6cBMJ
         SXf678eDjuYbe8GpiNS+Rkxh8s28hQVXIJciGjEH3LpXG3Cp9FmNErUgiNOLvT5vEgei
         Vkj1O680lacSMDB7iq/DsG9vGrpRmX63BNKm8LzF5MBxI5agf0DUrDWE1N/JOKFqcUBw
         IP/LtYHK2sT2xNyvofuP+k7jnDHfaRn5X4HSbQ8FLlyV7KxsqvUnf8J96JUQlfrf16Yr
         I1d5LJlk9kpklPjsjtAzCyfsOPS2XMD8P91q3eEQ434o1FdmK+tRqFNBNdatCuUDHjTM
         vaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732678730; x=1733283530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn2mqiTffvoc/D8+m6E2ss000lrDjRnXwpfuiiix1M4=;
        b=VBl+rRp6rTbbAwH5cH8H1GMMFuRBxjScqFG6xDIIIl2GAw/d3SNciqUGQMBlP/OgrK
         vdkMrF7e5/PV3pVvOo+tKM60GsqACjmW6Hh6j+N6PX1UJqUtugF/fT0qj6tU/VMD9Dk/
         HBqpaSR/XzWgF8h4lcYphtw2QSZJ05dbtbIK9YD1CZEXHZJOPtjJw3x8jGYZ19Tu9gmS
         GZaLJqtghPoI3QfrQeZfiqQlOJho1Lnqwe+YpV/fsMQQv41DTCkpE9+HcpYZC9QKmFvy
         BgixBKooIqxVVCMLEkn54i7LzBFpK1/rHLsduVZ2VHh7O6/qqtDlgCAzA+F91CMKX8xR
         nUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPzhoKWfZgcl/KMM3rjlWOBEDUU9dQ6tcVBeBy/agurVBDVq7Wh2R6HhQ6WK5t7JUZUtD2mGx8HKlrWrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqcuIZahH1PolOGEsJ40wOP5Cq5PVeEDNN55sqLfu9B5f0EjOn
	nvTBs/5BzqkYZVGN04FScyrARg8r3ui5BtwLvur4PgGRjosNnedk35EVcqoYI0zpoRGwGrO6H70
	kcx9V13S5uQLsz0PTjnZg7LfoHG/rn+jZNhkb
X-Gm-Gg: ASbGnctUFqYkLa6dTHRd06qrMo+IH0SKTHNzfXQ4qABiVyl/pPT6rJc+g564/btd1et
	TymLBW6RlgjITtyzgVPk7/tpVnofiAw==
X-Google-Smtp-Source: AGHT+IGlxuYZ/LrsjfAgvwWFFpg3oOOBV7K+iujlFrnCdH+8elzoi/D8ZMqcY8qv4XgdvqDdz60wqZKADimRrgR9ovc=
X-Received: by 2002:a05:6902:110b:b0:e30:da65:723c with SMTP id
 3f1490d57ef6-e395b95633amr1331814276.45.1732678730497; Tue, 26 Nov 2024
 19:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112182810.24761-1-av2082000@gmail.com> <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
In-Reply-To: <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 22:38:39 -0500
Message-ID: <CAHC9VhTJERn54qNDDOwNrJ09VWrmq5Qn+sPQV__LyeEUgSi5pw@mail.gmail.com>
Subject: Re: [PATCH] selftests: lsm: Refactor `flags_overset_lsm_set_self_attr`
 test
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Amit Vadhavana <av2082000@gmail.com>, jmorris@namei.org, serge@hallyn.com, 
	casey@schaufler-ca.com, shuah@kernel.org, ricardo@marliere.net, 
	linux-kernel-mentees@lists.linux.dev, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:25=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
> On 11/12/24 11:28, Amit Vadhavana wrote:
> > - Remove unnecessary `tctx` variable, use `ctx` directly.
> > - Simplified code with no functional changes.
> >
>
> I would rephrase the short to simply say Remove unused variable,
> as refactor implies more extensive changes than what this patch
> is actually doing.
>
> Please write complete sentences instead of bullet points in the
> change log.
>
> How did you find this problem? Do include the details on how
> in the change log.
>
> > Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> > ---
> >   tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/too=
ls/testing/selftests/lsm/lsm_set_self_attr_test.c
> > index 66dec47e3ca3..732e89fe99c0 100644
> > --- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> > +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> > @@ -56,16 +56,15 @@ TEST(flags_zero_lsm_set_self_attr)
> >   TEST(flags_overset_lsm_set_self_attr)
> >   {
> >       const long page_size =3D sysconf(_SC_PAGESIZE);
> > -     char *ctx =3D calloc(page_size, 1);
> > +     struct lsm_ctx *ctx =3D calloc(page_size, 1);
>
> Why not name this tctx and avoid changes to the ASSERT_EQs
> below?
>
> >       __u32 size =3D page_size;
> > -     struct lsm_ctx *tctx =3D (struct lsm_ctx *)ctx;
> >
> >       ASSERT_NE(NULL, ctx);
> >       if (attr_lsm_count()) {
> > -             ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, tctx, &s=
ize,
> > +             ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &si=
ze,
> >                                              0));
> >       }
> > -     ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV,=
 tctx,
> > +     ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV,=
 ctx,
> >                                       size, 0));
> >
> >       free(ctx);
>
> You have to change this tctx for sure.
>
> With these changes:
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>
> Paul, James,
>
> Please do let me know if you would me to take this through
> kselftest tree.

Amit has already posted a v2 with the requested changes, but I wanted
to get back to you on this even if this patch is outdated ... Shuah,
what is your preference for things like this?  My general policy is
that patches only affecting one subsystem tree should be taken by the
associated subsystem to minimize merge headaches and other ugliness,
however, the kselftest is an interesting subsystem in that it relies
so heavily on others that I'm not sure my policy makes as much sense
here :)

--=20
paul-moore.com

