Return-Path: <linux-kernel+bounces-278251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7603F94ADF1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EB51C21599
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B38E136E0E;
	Wed,  7 Aug 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpiFuHDu"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74EA78C9E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047703; cv=none; b=oJws0tS8jvx+sg9VD3OtvQ8rVOzI3vQn293/4Uj3QveCWwfyk4uhUQOwL6976rXadJ/J5XwaWTvLJSsv1AVrwS+NsyLfLGRoXoBAhqGUT/N5fFHVthdZQjUMJGqr9AQPlS2sxN0EzZGRaqg2pvcjr+1Iw1HWED3eSwdKObsdkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047703; c=relaxed/simple;
	bh=e2BMUCP22nzpip6gGAFjR0ReLzujdgZiwSNIB994pVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2pxFx9FqpRcbwOxuU1l9q8P1sUlCNlZr+AN+F468Cqg1UuDc1nxsLWOOBuNvQ10MUZktLmouMvOfqUw+GobY1nb/HUBavF/+Lfld6i19zsBvnonZYos1RFz1ayQ2JEOwqgDF6Oawq2h58y2+GiPW20Q43gpgvwqTGeaMbzdGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpiFuHDu; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef23d04541so21859311fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723047700; x=1723652500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFVsH6L0jMNTWXXKT1BLSqXh6RkHJccF6iCiCH3zZKA=;
        b=OpiFuHDuY/cjnDFzFJPELc/cjeLHDC/YyXd2MzYO3QCGdvEWp+8WcEbUFxzow98XL+
         5FeUeqxgGKB3+AaflRRaFgZMzMLnjFNSXvIqmTgtaUeU+N/iT+wvXSdhrS+3GtzrwVP7
         GqCBnit5dKZeq6XFuqXujnC6kjMNnuoTN7H+jYPH/TAnXoxy2tJQcYQZWEYH7TUpOd/1
         SLFupiQAem5PJdNn8BApz+alatfcTP/gMdzwopw6q2H0jOpW2cv3pQwwEJ8UGPdvFHE7
         kSnidN5wyOTt/biVqlJV4Hhzkq/0szD0SuftZhFJuVgf02gPB34pAmMAk5U9CtEhJy0U
         Jqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723047700; x=1723652500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFVsH6L0jMNTWXXKT1BLSqXh6RkHJccF6iCiCH3zZKA=;
        b=a9RzuNhWRFE+/dutdM6ib8B8UqYySMM8rrneYQtRKYwhJx91EFXmzSifVoSX0eU7/N
         VHToFyVIE+xfRtAkNfpkzlY21RMl0GkRWZPuUpbSfohnc9gMBmxR0k9cqLikjpD6FIQT
         nlP6AfnikV8G2NEylUxLFKQiiN22MCeNwAn3/BwG9x1grgTJwB3aZ7esveRbbSMkhD5C
         1foY2OpetlRJLpWVU6X//u68O0ecDVyD9qHRNsNwkDvjlHFnThxSV+PO2mCErRjTr0AT
         0X39lqSw3m+2k+LMD4PGj6sunedRLu82nyyOiLYRW0fHGeA731rAG5Fvb7s73BjD3njW
         mx8Q==
X-Gm-Message-State: AOJu0YxPYs5v6iMGrANkg/XXI7Wgg+a6+UIMrAL9dCzqoOzqEQ009tF4
	Vz/EdLDfHEopcCOX0SBxfvdl+IOTqxEykEsZN+YUS/chJ5wz3ySeUXGx33wBFBOQHcl5+leLqjQ
	y4IzLMMz8oaL+Y/lTnf7+5/0flA==
X-Google-Smtp-Source: AGHT+IE9Nndbm2L5fAg3mjcHsRaZ8ESNyO3nwZiAlnvvyqIXRXQojBsEamQqNY1BEVTfMpFm1hEbRQHzrl1g8A43yP8=
X-Received: by 2002:a2e:8718:0:b0:2ef:2f17:9ede with SMTP id
 38308e7fff4ca-2f15ab6a35fmr125248961fa.49.1723047699395; Wed, 07 Aug 2024
 09:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807054722.682375-1-xin@zytor.com> <20240807054722.682375-2-xin@zytor.com>
In-Reply-To: <20240807054722.682375-2-xin@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 7 Aug 2024 12:21:27 -0400
Message-ID: <CAMzpN2iS076ysZ37gjrz6MGWc62sD9uw0ODTJtzOO1U4kp309A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] x86/entry: Test ti_work for zero before processing
 individual bits
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, andrew.cooper3@citrix.com, seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 1:51=E2=80=AFAM Xin Li (Intel) <xin@zytor.com> wrote=
:
>
> In most cases, ti_work values passed to arch_exit_to_user_mode_prepare()
> are zeros, e.g., 99% in kernel build tests.  So an obvious optimization
> is to test ti_work for zero before processing individual bits in it.
>
> In addition, Intel 0day tests find no perf regression with this change.
>
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  arch/x86/include/asm/entry-common.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/e=
ntry-common.h
> index fb2809b20b0a..4c78b99060b5 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -47,15 +47,17 @@ static __always_inline void arch_enter_from_user_mode=
(struct pt_regs *regs)
>  static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>                                                   unsigned long ti_work)
>  {
> -       if (ti_work & _TIF_USER_RETURN_NOTIFY)
> -               fire_user_return_notifiers();
> +       if (unlikely(ti_work)) {
> +               if (ti_work & _TIF_USER_RETURN_NOTIFY)
> +                       fire_user_return_notifiers();
>
> -       if (unlikely(ti_work & _TIF_IO_BITMAP))
> -               tss_update_io_bitmap();
> +               if (unlikely(ti_work & _TIF_IO_BITMAP))
> +                       tss_update_io_bitmap();
>
> -       fpregs_assert_state_consistent();
> -       if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
> -               switch_fpu_return();
> +               fpregs_assert_state_consistent();

This call was originally unconditional, and does nothing if
TIF_NEED_FPU_LOAD is set.

> +               if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
> +                       switch_fpu_return();
> +       }
>
>  #ifdef CONFIG_COMPAT
>         /*
> --
> 2.45.2
>
>

Brian Gerst

