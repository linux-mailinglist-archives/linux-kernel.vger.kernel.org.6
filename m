Return-Path: <linux-kernel+bounces-562125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FFDA61CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8713BDAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD74A204099;
	Fri, 14 Mar 2025 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+XftbNk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3313F434
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984427; cv=none; b=U4jaO4b17G1v1h+tVeAsdI2lJOtuc3rTREgg9Ja9gYeIMouyD5WgiG28E8hNLBSaHS7iNOr0vjggzQRFvDybCrzS/HQaBZNkwVS97998qEBS9UxFy2pSAIXd2rCy428+s4YYAQuC5INmHkYzxPvuJOe5Z3BVcpsH6MK920fzX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984427; c=relaxed/simple;
	bh=iQIsLNCRfj0lf5B/k9Tmzx0GpzuIboL4obpgXOujCuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3pxwDYz3lI5zXBwkCG/9T4Qscn6KR7M/LNeouWJ7g3luFlSRLjrgDYrQroChnIZfAaxkDzwYrjiqRGjU/OsPJ/wlOjpWPiZARCbSuglHK/Bel8S1X/Ks+rIjsbxXAJURp04tdJJ2Y0V2b6T9vEey1kCYh7JA5iwSN9DtKu7meM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+XftbNk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741984424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAErkp/IHtDQnLH6rRtdc4nR2qwmpdZc0Xlsth8r74U=;
	b=P+XftbNk7clGLoyYakR5FQ4v0ReJcBEoP2diUQjqk7e9ussV3ZtpnSFpN7im983ro9sKRI
	I9Y2DSyQD6rJJRPkEhKfO5gfe6pNHAHRd6V1fXAUj2PUZMQpLacuLj7YF+E8mZ/+0adYeK
	/JTkKwcVDrKo/qJ8EQfzyccS6tM7npM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-PhFp1sCnONigrctp0ximNA-1; Fri, 14 Mar 2025 16:33:42 -0400
X-MC-Unique: PhFp1sCnONigrctp0ximNA-1
X-Mimecast-MFC-AGG-ID: PhFp1sCnONigrctp0ximNA_1741984421
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30c4fd96a7bso4293651fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741984421; x=1742589221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAErkp/IHtDQnLH6rRtdc4nR2qwmpdZc0Xlsth8r74U=;
        b=fDBIGAWHFrECNYapIZ25ivHPi6kUQSIIgKXmoOjrYLTAYqngX0By6bAg7vfn3nRpkQ
         oWybSb9l5jIqzLrDOL4XvvRju7w+WbLR0itOx4sNRjrGySiyE/dVl3cbreqYYdTmkQ3U
         dkjQ3qhyD3ZeQKQn0c0q4XW6xe8/w9yIJi5MtdBc2pRj0NvDGBotrRbkrCXr0dRt/1Y6
         uPECIV3GPjzpmbHqiH4qhhpbyA/CUo6j3jEovQIgiXAioBaYtWT1bgUovvFi2dTip5I+
         2B0xwqfy+oFqePnIzXjEnOx45psA+tcahNuDFh6I4Mtb7L8SPyRP8wVgRdvFNJqPhNr/
         E5Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXw8injfhV+ao7rgDBhdIcTE6WK2pPO4povBFcKO9xYUoSbjJV2cZVxRnvC8/Y2CuHL9zh0u7flcH0wwyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWzNfPZX+nbaGsEV893f5DK7NfPgR7XzhhxDkLg6fme0E3iuu
	LXUB4nbXayu3xdv6WjKk9lqhUbOn2FXqz6AEtunkFWBGMXS9L1ROIh9VXgDJyyrzvJPutQW2sT8
	dtRvDkeR7rch9mbPiYvsNOHyTsZPbI91VZ5HguCjiacSXvuDEIXuWojxqfRUZboq1EjTYoob+Cu
	tRs1AY5qvv+gLRLOqkl4GLLiXvQzRdiHrWZceL
X-Gm-Gg: ASbGncv+n0U60IREsnM7DSqAv20szgC9I6i+ePD6uESdYcLf3T3+auPTso8c2M11eJJ
	8bdwwc3Mr4xluvj10CtpyYVbp0mNGnhpWflmhT2YJQ43PLqr7dFVAyhVwZuyXrTY1gJu4OEIwNJ
	TRT8/NBRrY640vmU/8P75zKh1Sh44wuQ==
X-Received: by 2002:a2e:a7c1:0:b0:30c:160b:c741 with SMTP id 38308e7fff4ca-30c4a74da1amr14129351fa.6.1741984420863;
        Fri, 14 Mar 2025 13:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmMV19jLgRxYwpf6HS3XIPOuRMlTpE74qaKThr7BSzT6rHOSH1XcLwVctEIyqGMZy7eFruCuehw2n955y/yT8=
X-Received: by 2002:a2e:a7c1:0:b0:30c:160b:c741 with SMTP id
 38308e7fff4ca-30c4a74da1amr14129241fa.6.1741984420441; Fri, 14 Mar 2025
 13:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314175309.2263997-1-herton@redhat.com> <20250314175309.2263997-2-herton@redhat.com>
 <CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
In-Reply-To: <CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
From: Herton Krzesinski <hkrzesin@redhat.com>
Date: Fri, 14 Mar 2025 17:33:29 -0300
X-Gm-Features: AQ5f1JpAzkeh3xNGYnQlxoF50Om_DmXK5IGc21H2hdhQ9q-WbyPRWMspr_1NPZ8
Message-ID: <CAJmZWFFVL++yU1XJLkXSck=GRQXiim16xVSvdxjq1k=c=Aaiqg@mail.gmail.com>
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8 bytes
 in copy_user_generic()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	olichtne@redhat.com, atomasov@redhat.com, aokuliar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 4:06=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 14 Mar 2025 at 07:53, Herton R. Krzesinski <herton@redhat.com> wr=
ote:
> >
> > --- a/arch/x86/include/asm/uaccess_64.h
> > +++ b/arch/x86/include/asm/uaccess_64.h
> > @@ -130,7 +130,7 @@ copy_user_generic(void *to, const void *from, unsig=
ned long len)
> >                 "2:\n"
> >                 _ASM_EXTABLE_UA(1b, 2b)
> >                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAIN=
T
> > -               : : "memory", "rax");
> > +               : : "memory", "rax", "rdx", "r8");
>
> Please don't penalize the caller with the extra clobbers.
>
> Maybe it doesn't matter - these functions are marked always_inline,
> but they aren't inlined in very many places and maybe those places
> have registers to spare - but let's not penalize the FSRM case anyway.
>
> And we do call it "rep_movs_alternative", so let's keep it close to
> "rep movs" semantics (yes, we already clobber %rax, but let's not make
> it worse).
>
> As to the actual change to rep_movs - that should be done differently
> too. In particular, I doubt it makes any sense to try to align the
> destination for small writes or for the ERMS case when we use 'rep
> movsb', so I think this should all go into just the ".Llarge_movsq"
> case.
>
> .. and then the patch can be further optimized to just do the first -
> possibly unaligned - destination word unconditionally, and then
> updating the addresses and counts to make the rest be aligned.
>
> Something ENTIRELY UNTESTED like this, in other words. And I wrote it
> so that it doesn't need any new temporary registers, so no need for
> clobbers or for some save/restore code.
>
> NOTE! The patch below is very intentionally whitespace-damaged.
> Anybody who applies this needs to look at it very carefully, because I
> just threw this together with zero testing and only very limited
> thought.
>
> But if it works, and if it actually improves performance, I think it
> might be a fairly minimal approach to "align destination".

It does look good in my testing here, I built same kernel I
was using for testing the original patch (based on
6.14-rc6), this is one of the results I got in one of the runs
testing on the same machine:

             CPU      RATE          SYS          TIME     sender-receiver
Server bind   19: 20.8Gbits/sec 14.832313000 20.863476111 75.4%-89.2%
Server bind   21: 18.0Gbits/sec 18.705221000 23.996913032 80.8%-89.7%
Server bind   23: 20.1Gbits/sec 15.331761000 21.536657212 75.0%-89.7%
Server bind none: 24.1Gbits/sec 14.164226000 18.043132731 82.3%-87.1%

There are still some variations between runs, which is
expected as was the same when I tested my patch or in
the not aligned case, but it's consistently better/higher than
the no align case. Looks really it's sufficient to align for the
higher than or equal 64 bytes copy case.

>
>             Linus
>
> ----
>
>    arch/x86/lib/copy_user_64.S | 17 +++++++++++++++++
>    1 file changed, 17 insertions(+)
>
>   diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
>   index fc9fb5d06174..1c3090af3807 100644
>   --- a/arch/x86/lib/copy_user_64.S
>   +++ b/arch/x86/lib/copy_user_64.S
>   @@ -74,6 +74,23 @@ SYM_FUNC_START(rep_movs_alternative)
>         _ASM_EXTABLE_UA( 0b, 1b)
>
>    .Llarge_movsq:
>   +     /* Do the first possibly unaligned word */
>   +0:   movq (%rsi),%rax
>   +1:   movq %rax,(%rdi)
>   +        _ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
>   +        _ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
>   +
>   +     /* What would be the offset to the aligned destination? */
>   +     leaq 8(%rdi),%rax
>   +     andq $-8,%rax
>   +     subq %rdi,%rax
>   +
>   +     /* .. and update pointers and count to match */
>   +     addq %rax,%rdi
>   +     addq %rax,%rsi
>   +     subq %rax,%rcx
>   +
>   +     /* make %rcx contain the number of words, %rax the remainder */
>         movq %rcx,%rax
>         shrq $3,%rcx
>         andl $7,%eax
>


