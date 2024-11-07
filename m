Return-Path: <linux-kernel+bounces-399963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7CA9C071D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ABB282A33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A615F20F5C8;
	Thu,  7 Nov 2024 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/6LpVKs"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57F20B1E2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985605; cv=none; b=g/rh/R0m+6ICLO+e9/NbFEId+rGJjwoHFc31mQHqvwx0wkuEjGz4+6wXcSvwu8AgmR6ufzxfYlOhVXcCqNK+trVIre/os6pTzJbEu5tifbAzehOM2X6tSHnZU+hCryBo8Ds950Gjodxgtyri/gi6vpe8ekz1IuKqE28VhLxqb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985605; c=relaxed/simple;
	bh=8Lih6DhehXBAqDMjsLTGIz7ix4IflIUk9DO9S82uEMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn5PHu3CUU2yZTNsKt8pgj7r6v0HgFakCeBzt9u4rhAykBQqD6aAGTNTHIo+TQSiSEltpOv/gmR6k4ihBNF5nEFpEyEuwbKcnp62WUKEGTvLYQOZ9t+HHwDzEgBreO+yNXRhKB+zoC1U03zS6fT2tDDaWhLWua+0keIxzGUpXhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/6LpVKs; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e63c8678so984820e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730985601; x=1731590401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDf2NcC0f0OAvQ6euts6Mr0SJI1EgmdWSDeyu54808c=;
        b=m/6LpVKs6Scl2FArngtTDOh+aWiPTYd6/THQgVBIaZfeEQ1L8q2vNZNBcUZYxX/png
         rqQDar5WyPl3ybL+AhYmDXgL9iw4VApR49MVEfPfvqLZj8oH2KBSBXaV6Icsr96rQcxL
         fcuorxm8Riu/UKk6RLW4isYGryoqN9OmLnB938+meI1Z06gzolwJJeC+FYYRx/Yqo5mn
         R67kQAvxz6zq+aLbpZnWUocNBkEOdEl222ECsIKRQ8Uvck8PKOrgr4uTbsVwl5vLHaj1
         WtyVuPYOE4TNs31i/T6J8xMlRVDqoygeTMVwW3/vx0pMCXTqyB1UIqxK0H3tFgdMgx+K
         POlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985601; x=1731590401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDf2NcC0f0OAvQ6euts6Mr0SJI1EgmdWSDeyu54808c=;
        b=S/UCCchc6gyLE5f8Ko/DXfpif1k01Crtq7VVA1AOlq0B+F8LIBoqcL4N7tdfrKN0UZ
         cWoM7LJ9tZ+WN2GX3Z4ciLgytYXJyLHqI53niBpuZxnqawevZPjCTed05wdB2xnj/xzK
         rfYBIHzgLPv/lN/JCkCLNIlWcuqofqpl3U1LAgvgYokkGsS4eYAgBLAtWg/Fj9b0vCKo
         X1jqvsQuYAjN/FR0d22g799CxZ8bjyPZ22HiaPi2PnUyarq25KiDZREv3CNTCidS45Qk
         rv8YKyAZ4GsOqnlO3vb7Bk43tazYt8QCljuh6ZcIiocU40AmOoJeDLst5EtmJHM7WhKw
         TpTQ==
X-Gm-Message-State: AOJu0YwXHVEbeevKi+0TA5ZbkAiljCgEXpne1rU7z1Q3ewffwqHYyB0P
	BAjSYc1na7hzLUieHdtwidLhbpSNr2Ws9EG2gLAMDJ6G5wUVU+AMNGeSBatMlqdG++jN+jfKR+0
	svQdmn7le0efASeVddKEFlBmOnsNSp0AyTMw=
X-Google-Smtp-Source: AGHT+IFdqNiLC15lQE/7sY8FBQ2TivwrpUK733HpgKSn3hHnJ9knQwIHuj3/iWbsp5LMUuWyBIJjj5rNtlzqQfak4iI=
X-Received: by 2002:a2e:a805:0:b0:2fb:3445:a4af with SMTP id
 38308e7fff4ca-2fedb791e43mr125012041fa.21.1730985601015; Thu, 07 Nov 2024
 05:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-4-brgerst@gmail.com>
In-Reply-To: <20241105155801.1779119-4-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 14:19:49 +0100
Message-ID: <CAFULd4YaLj4neQ-pK2UKSgBtn2HrtN03wh-9ahtS6CfVYP22jA@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] x86/stackprotector: Remove stack protector test scripts
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> With GCC 8.1 now the minimum supported compiler for x86, these scripts
> are no longer needed.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/Kconfig                          | 11 +----------
>  scripts/gcc-x86_32-has-stack-protector.sh |  8 --------
>  scripts/gcc-x86_64-has-stack-protector.sh |  4 ----
>  3 files changed, 1 insertion(+), 22 deletions(-)
>  delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
>  delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index aa7fac6817c5..45021d57fd9f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -278,7 +278,7 @@ config X86
>         select HAVE_FUNCTION_ARG_ACCESS_API
>         select HAVE_SETUP_PER_CPU_AREA
>         select HAVE_SOFTIRQ_ON_OWN_STACK
> -       select HAVE_STACKPROTECTOR              if CC_HAS_SANE_STACKPROTE=
CTOR
> +       select HAVE_STACKPROTECTOR
>         select HAVE_STACK_VALIDATION            if HAVE_OBJTOOL
>         select HAVE_STATIC_CALL
>         select HAVE_STATIC_CALL_INLINE          if HAVE_OBJTOOL
> @@ -418,15 +418,6 @@ config PGTABLE_LEVELS
>         default 3 if X86_PAE
>         default 2
>
> -config CC_HAS_SANE_STACKPROTECTOR
> -       bool
> -       default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protect=
or.sh $(CC) $(CLANG_FLAGS)) if 64BIT
> -       default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protect=
or.sh $(CC) $(CLANG_FLAGS))
> -       help
> -         We have to make sure stack protector is unconditionally disable=
d if
> -         the compiler produces broken code or if it does not let us cont=
rol
> -         the segment on 32-bit kernels.
> -
>  menu "Processor type and features"
>
>  config SMP
> diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_=
32-has-stack-protector.sh
> deleted file mode 100755
> index 9459ca4f0f11..000000000000
> --- a/scripts/gcc-x86_32-has-stack-protector.sh
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -# This requires GCC 8.1 or better.  Specifically, we require
> -# -mstack-protector-guard-reg, added by
> -# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D81708
> -
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m32 -O0 -f=
stack-protector -mstack-protector-guard-reg=3Dfs -mstack-protector-guard-sy=
mbol=3D__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
> diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_=
64-has-stack-protector.sh
> deleted file mode 100755
> index f680bb01aeeb..000000000000
> --- a/scripts/gcc-x86_64-has-stack-protector.sh
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m64 -O0 -m=
cmodel=3Dkernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%=
gs"
> --
> 2.47.0
>

