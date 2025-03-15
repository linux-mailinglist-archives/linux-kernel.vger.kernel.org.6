Return-Path: <linux-kernel+bounces-562494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04EDA629AB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F871895484
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C45F1F427D;
	Sat, 15 Mar 2025 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C103dIlf"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC21F55FA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029973; cv=none; b=sITetf8/iDE02QYPJkYvH7WxBOqdiqVURTGAWu0tsyVU18Zo1A0CdzyOY6dTd+39sZHyy4LZEQVkL1y+uHI4z/W+s6DGvHPqd8TaJTINkHLgkUNs8wpieXIcQ/eop534VyS4bfF+uO3iVqVwpW2wF8dl6Qqxv0VnCX1FJf0+Tjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029973; c=relaxed/simple;
	bh=L92qco84CWL7uFXVkCHAxdw7s5REitNfWSyJNFf/Wcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iybN5rYN2NZShQXjIUl/oEdyn0WRhkwHXEOQC+FEIAZvCOQJ7a1tngB2x+xhnI6g4FuJFbYnAC2SGwSaZ1NUqV2bVrPFgzjUTHkTDiPdkQb5EJHX2JdNepyg7tCZYGULM/at3y75wtvp1iKjirBsPkujz+qkTp6vw4TiQqJXox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C103dIlf; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso31297351fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742029970; x=1742634770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g2B4t4HiJQ2U+5S2eMbCFARLSXn6w/5RiX5lAU9RfE=;
        b=C103dIlfJHIgcAavlyMb4mHDHkt6le5qPNjhcXqwWRiSAGh8qA6uSu8Gz/zUPnfr/z
         l/BmjeysgA0nP08A1pUiU6vGcWy7viHNTeXsLrBRnK15vCeNU/q73KywL5+OmOKm1Io2
         HCkpzFJAOgakTJgzGbqSw9ptKnLx98lXQMezjc03xud0Ixg2nEtWiKsxXM0PDV2J7wd6
         t0p0Cra5IxinYP5GcbRS6lNa9qawsLmrBBADIw3O/BvZ9xsDzZRSSmHfTzf1cLcbNMm3
         Rg6tJ15KkGmKMF3z6esLtLKbLySooi+XaFjWtLcHFCpP+dNEwPjddh2vMGMPb9nPUp7A
         GoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742029970; x=1742634770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5g2B4t4HiJQ2U+5S2eMbCFARLSXn6w/5RiX5lAU9RfE=;
        b=WijU/nKJq9FFv6DfODNiba38rtjTOcUl+jwbYx4LxU6We9iSr7V8VUrcWEM8nE24Dg
         d9wLQrPWx5iKLTW/gPvQiM93QdYflpa34hDrOqkmDOA9mng4+jSRPCZ/gJmBCCCRHuyd
         g24Gpv/v9R1yJ8CKQSaw8Yrq2El5pC9XDJp3oHTyK+CAwudemwbff0+H2ASepIZXaswJ
         leQWWhXdaEXvze/DT2fNtTg/o1xBjPzjqft9kulRcbNjYU02ZRgx36XOioUx9ZwrZR3j
         zQ+zl3rCQqfR1F2GkDAL7pjiamspjQ/pOdgxhfwVsBJ/zpl88//4ibY6rGuiSuMLqTtj
         +yCw==
X-Forwarded-Encrypted: i=1; AJvYcCUKiKj3S6CSzo6sXrig0he41DYsvf1lTg+d5nC9Vb8Q7iTnnDNYoE6iYFma7WL309qU9Fu2+qGtqQvSx7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaMCh2+tfewNkeVFCcRGkBXLWrGxvi/cJGcy9pQcQWpKNKZ1mL
	QCm2eQ/yzqihjLLAET36rdDO9kNqMRIiCn0RCPyFicMtBwvqqcrfBZwfLQpoeD0A6SVr9s01lDH
	suLVyIz7zrlgnXWzRpPdFt7XfJoo=
X-Gm-Gg: ASbGnctY+4u+zBiJZzuMp7gpcNFKB2u3AvIPUZansUNOYb4Gjv/NCGPiJYdW+8STs8N
	XA6E+2HOc9LI/FTt1Q7wWuINHKzrLwBkZGSdqZ1dMLBeMhhGcgwsHXzQzR7r1/4YWZ2YcmA6Via
	1Cnn+WLZz5kQhBwm4cnSDLx36YbA==
X-Google-Smtp-Source: AGHT+IF9Y8nUZNx9D0b1E0Ql82tIUFyHSrx/ko+z+EhjUe6xmXdfhub7gHrmFcWG2QTKHlc+J90US7H4Yztk3/8eEs0=
X-Received: by 2002:a2e:b784:0:b0:30b:fca2:6ac1 with SMTP id
 38308e7fff4ca-30c4a877b8fmr19476041fa.22.1742029969672; Sat, 15 Mar 2025
 02:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <df08c856d0f2b7f2db503249d551d09408393cc3.1741988314.git.jpoimboe@kernel.org>
In-Reply-To: <df08c856d0f2b7f2db503249d551d09408393cc3.1741988314.git.jpoimboe@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 15 Mar 2025 10:12:43 +0100
X-Gm-Features: AQ5f1JqgdUgGL1_uREtYDCKl7r0l8ZyIFizYRgot8i7kQSIYXFVg7Q-xY3vj5Cs
Message-ID: <CAFULd4akhhuDDj0H0VS88VNEF1PYgQvySsNHv37XSmVorpzVng@mail.gmail.com>
Subject: Re: [PATCH 19/20] x86/uaccess: Use alternative_io() in __untagged_addr()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:42=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> Use the standard alternative_io() interface.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/include/asm/uaccess_64.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uac=
cess_64.h
> index c52f0133425b..b507d5fb5443 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -26,10 +26,10 @@ extern unsigned long USER_PTR_MAX;
>   */
>  static inline unsigned long __untagged_addr(unsigned long addr)
>  {
> -       asm (ALTERNATIVE("",
> -                        "and " __percpu_arg([mask]) ", %[addr]", X86_FEA=
TURE_LAM)
> -            : [addr] "+r" (addr)
> -            : [mask] "m" (__my_cpu_var(tlbstate_untag_mask)));
> +       alternative_io("",

No, alternative_io() declares asm as volatile. Please define
alternative_io_nv (or something like that)  that will not use
volatile. You will penalize the above asm unnecessarily with volatile.

Thanks,
Uros.

