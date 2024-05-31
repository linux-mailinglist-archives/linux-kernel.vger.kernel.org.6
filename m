Return-Path: <linux-kernel+bounces-197211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CACD8D6792
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAD11F272CD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F52172777;
	Fri, 31 May 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA0rfTWW"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D92770FC
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174872; cv=none; b=HvMsTgp1cTKFk9EgdgLfTgzir+mC6+ZrRUazkYUx2a7LWGwv0BXxlH+gcQJvMUsabFVrghRQNTnn52rNG75pvqzPE6+y7N3BlAsc+GtbyicSY4hyzyb/qB3ZvZAw53IQCS/wNk36HfyKs7NAKFPwL/ifG2qwDRLLHLOfyNi/5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174872; c=relaxed/simple;
	bh=MCVV0IUaW6kQ8ECcAxm/dAlg6y+EfifG6LVOd37rQi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aloX3b4oZmS49sFuMNQuZkvjYSqrGBbf6QlNFCUcZbfKLpUWrI+C35RBf1n7rtVZvfsR4xhNzdLwn1gybLVFOjNgg4MR+hjOmjvFo1SJv80R6ZYL+Z1Ll+ZQKKWoU+cKZ07lDki0iL743aXtBt/SlnuJzaldgVsoX8v8VJxBymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DA0rfTWW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b03d66861so2525483e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717174869; x=1717779669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kk2OxyZMtbnZSm/LI3qv3dX7yiLbidrXsgXiEDTxDig=;
        b=DA0rfTWWcvBvcBoNvMczGEq2EA1zSt0lhuwkTXpqsyrYwEOEoSTQiQ+qdxCAJpwj/0
         2cPW8GojcRxWyxUQVX+a5y9ONBFlXCKcfRUJr0CIHURKfb4rb/LSlMYzya/sQI67QQpK
         Bp3mfK+fqI3bmi1McqJJ+1iJrp8exZfOkQC8Jq8SjOK5Cc8IOtSJjQBwhM1SqaHbgfX4
         A7TxOH2LddqRxFok6hBIurO0L9eHRTZNtQ6RtOU8Iy3RUyDkmIEfylR3DHlndLRl6mfL
         BwCzvGXfObZWATE0Col1sZEGNVpBAoAw5mzGgM9gBp/5fG2o58oYPjYFMgMv/b1yg31s
         i0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717174869; x=1717779669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kk2OxyZMtbnZSm/LI3qv3dX7yiLbidrXsgXiEDTxDig=;
        b=EdUtFNpOwJHFxDFBqtDC8Hiovfsf2mbNiYm8XP31jhfqDPaoOZcsBsmQkz32GyoLQo
         8zgEsaqPM+BlIj1kTuEunaw0sLs/TJtMmS7vqOrKx2X/eeY78bnM0QQp8pO5JmrB3+at
         kwjxRY+C8Bcc5Je/PkqKIn2FD1AVTrXyvdwdXKcVotHOkjonRFggDs2PYWYMcXD5YQf4
         3MmnWajS6dIGtmGLEwTUqwsma3Ek19QXsr6zcmWwVB0hAfxJUEoNrOX/yNZ8ZnPJYpDQ
         pTgP0d15adGBgOI2KLnATn4EbiyoIk0U1YOIYoJuiz6DdiH0s9HnGsAJkpSsUalpluyM
         Svlw==
X-Forwarded-Encrypted: i=1; AJvYcCUIQ05vy2DegHYNBnQ+32f7fMPmGtVLvlKnXYuJYOsXzaNUegYUA/XN9zceSVY40yaiA/PbEPCrgwZcXRq9h2YOPbNByY3XUxvdMy0P
X-Gm-Message-State: AOJu0YzizrJjp2FYaT2iPCPBNY2IalwEBJ6iquLsnq8gaG235kFXuJdT
	oT+MeuFUCtlBuLx61eJIbdqv39a2DLr3+JRkEXVFK2WMFtNzhbyBdYN4WQgNTWCrw/b2R7b6oe1
	5paGmYZUK/PkA0FqXMso8+DComVdSiS8=
X-Google-Smtp-Source: AGHT+IHxCIgS6NYmvG5MEiRmRGa6oGdPbwXQEDnCthSbwzaPYTdBq5ujEa1G9dE1/1TycMBDAriadVrN+vFmEGzfsiI=
X-Received: by 2002:a05:6512:21c:b0:52b:8610:a7fd with SMTP id
 2adb3069b0e04-52b8980f6a3mr1349589e87.67.1717174868719; Fri, 31 May 2024
 10:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531123512.21427-1-bp@kernel.org> <20240531123512.21427-11-bp@kernel.org>
In-Reply-To: <20240531123512.21427-11-bp@kernel.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 31 May 2024 13:00:55 -0400
Message-ID: <CAMzpN2i4oJ-Dv0qO46Fd-DxNv5z9=x+vO+8g=47NiiAf8QEJYA@mail.gmail.com>
Subject: Re: [PATCH 10/14] x86/alternative: Convert ALTERNATIVE_3()
To: Borislav Petkov <bp@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 8:41=E2=80=AFAM Borislav Petkov <bp@kernel.org> wro=
te:
>
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>
> Fixup label numbering too as the new macros have new label numbers.
>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/include/asm/alternative.h | 24 ++++--------------------
>  arch/x86/kernel/fpu/xstate.h       |  4 ++--
>  2 files changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/al=
ternative.h
> index 73ee18705ef1..0df99855e003 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -277,26 +277,10 @@ static inline int alternatives_text_reserved(void *=
start, void *end)
>         N_ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,      \
>                       newinstr_yes, ft_flags)
>
> -#define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2,=
 \
> -                       newinsn3, ft_flags3)                            \
> -       OLDINSTR_3(oldinsn, 1, 2, 3)                                    \
> -       ".pushsection .altinstructions,\"a\"\n"                         \
> -       ALTINSTR_ENTRY(ft_flags1, 1)                                    \
> -       ALTINSTR_ENTRY(ft_flags2, 2)                                    \
> -       ALTINSTR_ENTRY(ft_flags3, 3)                                    \
> -       ".popsection\n"                                                 \
> -       ".pushsection .altinstr_replacement, \"ax\"\n"                  \
> -       ALTINSTR_REPLACEMENT(newinsn1, 1)                               \
> -       ALTINSTR_REPLACEMENT(newinsn2, 2)                               \
> -       ALTINSTR_REPLACEMENT(newinsn3, 3)                               \
> -       ".popsection\n"
> -
> -
> -#define N_ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,     \
> -                     newinst3, flag3)                                  \
> -       N_ALTERNATIVE(N_ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2,=
 flag2), \
> -                     newinst3, flag3)
> -
> +#define ALTERNATIVE_3(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flag=
s2, \
> +                       newinstr3, ft_flags3)                           \
> +       N_ALTERNATIVE(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, new=
instr2, ft_flags2), \
> +                     newinstr3, ft_flags3)
>  /*
>   * Alternative instructions for different CPU types or capabilities.
>   *
> diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
> index 05df04f39628..4fe8501efc6c 100644
> --- a/arch/x86/kernel/fpu/xstate.h
> +++ b/arch/x86/kernel/fpu/xstate.h
> @@ -108,7 +108,7 @@ static inline u64 xfeatures_mask_independent(void)
>   *
>   * We use XSAVE as a fallback.
>   *
> - * The 661 label is defined in the ALTERNATIVE* macros as the address of=
 the
> + * The 771 label is defined in the ALTERNATIVE* macros as the address of=
 the
>   * original instruction which gets replaced. We need to use it here as t=
he
>   * address of the instruction where we might get an exception at.
>   */
> @@ -120,7 +120,7 @@ static inline u64 xfeatures_mask_independent(void)
>                      "\n"                                               \
>                      "xor %[err], %[err]\n"                             \
>                      "3:\n"                                             \
> -                    _ASM_EXTABLE_TYPE_REG(661b, 3b, EX_TYPE_EFAULT_REG, =
%[err]) \
> +                    _ASM_EXTABLE_TYPE_REG(771b, 3b, EX_TYPE_EFAULT_REG, =
%[err]) \
>                      : [err] "=3Dr" (err)                                =
 \
>                      : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)    \
>                      : "memory")
> --
> 2.43.0
>
>

Just add a label at the start of this macro, so it doesn't depend on
the internal labels of ALTERNATIVE().  Something like:
    asm volatile("1:" ALTERNATIVE_3(XSAVE, \
    ...
     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
    ...


Brian Gerst

