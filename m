Return-Path: <linux-kernel+bounces-181630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992708C7EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 01:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C3A28142C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8C2E40D;
	Thu, 16 May 2024 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VaFVwiQQ"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066F27269
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715900902; cv=none; b=Yn05I+gME+w86s4cRyiTubjblDJl1yWI+iMM4x0DRrxgwFCbKHRM7sDxLqZ32V8GOBgbjpk+hZg0c3jKkG//GyGdHD2ls9GG8jNDoNSQUkxTpemRXJazrQzKLXcBjM8ECS8N+86KzRdtvNMJco3UHFatB+lAzvgXleHk24f0xtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715900902; c=relaxed/simple;
	bh=EP942SqgqU+2g95deuGJUqyAMQDCgoYsK8UTO8Gxpcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moZi04aLj4eN312vEFOJ5VP2Pk2alYA7whyEFSciqzopX2WEDw8I8p59LD3pJEjtLnzshNsAraVL+xEWheGyJ5JxCntOLyPGXSSbc6dk4a02ZikdwgX+PkiK6g2jtvZcdBV9QmfJP1Rab2Qn0b06cR79YVaoXupUu2sbTza3wOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VaFVwiQQ; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7f74cca5a2bso25083241.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715900899; x=1716505699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gak+/oovP81PfogPpqJsHd/1CwWJ9r/ylbJlVjZgFRo=;
        b=VaFVwiQQonng/gkW5JDVk2XG3oZJgOWtoLasmWZZXswJ8s/fuLmCQgzIeaVR3h5GkT
         CYHuxQ9+AoFU7VzYIrhrnxAn3RhTwzEpI2yfC3l8hxGWs9WsTvwra9ygVJPs2+7BXaYU
         NAK07jhm8354GuT0+u/nNofzFEUK6O+RTNoTbqVStDlylExqdUwDhauG8iqAG6EGmgam
         oroXw4d+WcTSyWCghGHd3/EEf3AQUPTss8+6EX8db4lAYzDakZr2J8kARtY0isCaicKC
         MUfMuKXapJuMRKaNaXbev+zfUoOb8y09JSPB5RR37a9Q1XH0OKWG8qRhTEi/ZsouDfx3
         GIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715900899; x=1716505699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gak+/oovP81PfogPpqJsHd/1CwWJ9r/ylbJlVjZgFRo=;
        b=fW8atax4aR4YwGECv4YHcNlS2CjOpqli8qtCT/iYQw0OnBXP0hYenQ7B2mhy4vzxgs
         DTrfaDV4WEu4VD599Z3kCMAZSrjnMDD0CFDZCsGYyMT4HFnAcfBmkgAIYUzEVoTA+yIF
         l56A7/VEueUX0HQGem8NAtC7KjAkE+v53crUGkyQ/8ludxHQ23ZsUU7PALZjdvMeBXQ0
         cIuBEXkcZFG9KEE5+mNfAyy+hW3HD0F5i/q5hDKgcgf+cDvI7F4/GsiTg6moRGwrZcJd
         xmNvHUFlGIZM5oGofMY8xwc95DUXX105jAYiLdHaGPC3SwicrMXlDD7bopSqesXSOx00
         2Rrw==
X-Forwarded-Encrypted: i=1; AJvYcCX7EwqWDtk+OCxy+dIGuPlr9rwF+GPEZoRaRIleJlwtDYF4lZHTQ3kuxC0/2KT1ARr0E70EjPBpf/8WBb+tvOJO8kz2hRfDP7jz0ZH+
X-Gm-Message-State: AOJu0YxhaolhVmB7IxYKnW32TQ2pXRdDiK1XJz5JzqArV+/GEA2zPBDP
	v2OnkI3x0Z8VMYFZ/NihlU2J3H+xqIIZV1UwDLQlZ+pHKAkLPM+QK0+/k8SikvEZCWjOue7pkQi
	eeWcE4nqxHtpImsPPecI9WZBquqJGsVRLVULE
X-Google-Smtp-Source: AGHT+IFMgTb54aBiq7xBfnDGVVGoTPJD2NkwNvHCirLNFVItNElpLuHUDLgn7UWhCRx47d2b9REE8C02r6/bHnLb5WM=
X-Received: by 2002:a05:6102:3e26:b0:47b:b8a7:7ddc with SMTP id
 ada2fe7eead31-48077eb4acdmr25780377137.30.1715900898508; Thu, 16 May 2024
 16:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516-x86-boot-fix-clang-implicit-fallthrough-v1-1-04dc320ca07c@kernel.org>
In-Reply-To: <20240516-x86-boot-fix-clang-implicit-fallthrough-v1-1-04dc320ca07c@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 16 May 2024 16:08:06 -0700
Message-ID: <CAFhGd8oAunv=+xT84hC2hCp3F-=Oy_gvK08eRmD6nk9xwCvWzQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Address clang -Wimplicit-fallthrough in vsprintf()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 7:03=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> After enabling -Wimplicit-fallthrough for the x86 boot code, clang
> warns:
>
>   arch/x86/boot/printf.c:257:3: warning: unannotated fall-through between=
 switch labels [-Wimplicit-fallthrough]
>     257 |                 case 'u':
>         |                 ^
>
> Clang is a little more pedantic than GCC, which does not warn when
> falling through to a case that is just break or return. Clang's version
> is more in line with the kernel's own stance in deprecated.rst, which
> states that all switch/case blocks must end in either break,
> fallthrough, continue, goto, or return. Add the missing break to silence
> the warning.
>
> Fixes: dd0716c2b877 ("x86/boot: Add a fallthrough annotation")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405162054.ryP73vy1-lkp@i=
ntel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Seems simple enough.

Acked-by: Justin Stitt <justinstitt@google.com>

> ---
>  arch/x86/boot/printf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/boot/printf.c b/arch/x86/boot/printf.c
> index c0ec1dc355ab..51dc14b714f6 100644
> --- a/arch/x86/boot/printf.c
> +++ b/arch/x86/boot/printf.c
> @@ -254,6 +254,8 @@ int vsprintf(char *buf, const char *fmt, va_list args=
)
>                 case 'd':
>                 case 'i':
>                         flags |=3D SIGN;
> +                       break;
> +
>                 case 'u':
>                         break;
>
>
> ---
> base-commit: dd0716c2b87792ebea30864e7ad1df461d4c1525
> change-id: 20240516-x86-boot-fix-clang-implicit-fallthrough-fc5c9bb19765
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

