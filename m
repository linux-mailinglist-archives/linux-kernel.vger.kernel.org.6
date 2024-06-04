Return-Path: <linux-kernel+bounces-201390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0068B8FBDF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234991C24EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189B14B97B;
	Tue,  4 Jun 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FeI+DFod"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5514291B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535890; cv=none; b=UR83/wn/W8+WCR2tkYls/sZiKhF+/6xW/+d3L9mcGtWn1fd2YMJfG+gowffykdrGxLGZ4Xk2uw+2TcL95xj2aoF2MELi2K0fITuJEbhViItJlLJAkqf7uW0Pjw5I9zVCOD3T0QfxsCnhP81LBW5LNNTB8MbpIIyx28TZ0FiKjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535890; c=relaxed/simple;
	bh=EgRuah0/TRiXG54boWXHiSKTgeu2TjH60bxBlJq2m+Q=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=EzYYPJArR3J6aJuk7Ps6LIpFO/zXiTkrXmOyyKXRuwcs9PFYWihsZO1dfVhd4YE3Vqp5oytFloPhka5LpsSRvafuLWewDefD8FDkfuYz+f7O02WJ5FR2O8ujuMaeSMqp+DvXkEaaC/Bj7r4iiu41I0rDhIOMvuAo3x0WtwXV6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FeI+DFod; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-701c82dadc6so5434895b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717535888; x=1718140688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JXzykZZ9JJXw7AgnDk6GCl6oohCsbGImlRtIa4olDvk=;
        b=FeI+DFodfEzFzcfuQJs8MuvX4S6RwW+dMzH9RXoMSmITWvz0E1EIE6FpwhpSSTOAfp
         FGq+7VLSUnEZ/me5GwgZybc8/auHz0C7Bgaly3CxethUknhA3FqnGR5n24HH43GySwn8
         Y43dW9NIrLJyMmqg5tpgq1XjtsiAVbptnolYJaBA9ZDhF2BogkFtPoQ1BM35Fhdkm8YI
         vjXBbQtdh42Fx+5l48/h3J1KVwiGlwb5z7b84kJaBEPUHgkqAN1z+NJKlsAA9hs4T0pp
         yYpRYico1nGLK3X/3bUrRnR1OVzdLVSdaSx5eNSBUK1tgIx3v3YPWSTNTuNgUPVOLxnb
         fjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717535888; x=1718140688;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXzykZZ9JJXw7AgnDk6GCl6oohCsbGImlRtIa4olDvk=;
        b=BqlxmJFX9PtRtvr+Lw4OSD3FFXStKFcMuB5LihsBSSIcJ55espDNt2j5l/qbwYJ7PZ
         qRdLXhmq7mcpUykl3jyJLq7A0FM2JTLLJdZDiATW1bm0uBHl906mIkeZXafiS3cVrEHN
         ZiI4qPXnCruMBYZbhRul4HMGdO220Fp2y8sswcqtdQ4q2IOxKeuygmX+tAMRp4NtwWdI
         6LyiGPkLn8tO4dekevzzJCiwAeJi6RC4OkfN9FmyKGoZzk4/CJIVyRJvzVbXw0CI/fbP
         eP5vExsnauKa45hSdJlIJ6kECN1mkNQpX1wasMYQ12HpJiNrRV7I5uYH0GXubraIG0lR
         vDlw==
X-Forwarded-Encrypted: i=1; AJvYcCU9lXZRXQXPZVdFAVynXV2a6x6iG97zhiTaT0g57kRwhHjJBI8JTK+8P3N9emd3kU6bvRkZphOXPvepK7ynhLyTv6+nLCvachQeo96q
X-Gm-Message-State: AOJu0YwAhkN8Y0g1wha2dNHrnl8clHmwcHmoUij/NaNdprogu7XDnwmh
	P3aFcXaFp25/sa/U+oh0570ITORgvWHBwTeXwGyWX8jTG3nlFt5+cFSI0tCUtUq4bHEgPGNRwpG
	TGQ==
X-Google-Smtp-Source: AGHT+IG1fFwR8lR801PpAJE2pvdJcatHkMcU5d4DGeT5QbazeoQ/iCgq2FlISNqWLoU2mRIVMMZp7+XVmUg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2d93:b0:702:2ab4:b12f with SMTP id
 d2e1a72fcca58-703e59dd3femr2814b3a.2.1717535887888; Tue, 04 Jun 2024 14:18:07
 -0700 (PDT)
Date: Tue,  4 Jun 2024 21:18:00 +0000
In-Reply-To: <20240527211622.290635-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240604211801.404181-1-edliaw@google.com>
Subject: Re: [v2] selftests/vDSO: fix clang build errors and warnings
From: Edward Liaw <edliaw@google.com>
To: jhubbard@nvidia.com, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, 
	Edward Liaw <edliaw@google.com>
Content-Type: text/plain; charset="UTF-8"

> When building with clang, via:
>
>     make LLVM=1 -C tools/testing/selftests
>
> ...there are several warnings, and an error. This fixes all of those and
> allows these tests to run and pass.
>
> 1. Fix linker error (undefined reference to memcpy) by providing a local
>    version of memcpy.
>
> 2. clang complains about using this form:
>
>     if (g = h & 0xf0000000)
>
> ...so factor out the assignment into a separate step.
>
> 3. The code is passing a signed const char* to elf_hash(), which expects
>    a const unsigned char *. There are several callers, so fix this at
>    the source by allowing the function to accept a signed argument, and
>    then converting to unsigned operations, once inside the function.
>
> 4. clang doesn't have __attribute__((externally_visible)) and generates
>    a warning to that effect. Fortunately, gcc 12 and gcc 13 do not seem
>    to require that attribute in order to build, run and pass tests here,
>    so remove it.
>
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>
> Changes since the first version:
>
> 1) Rebased onto Linux 6.10-rc1
>
> thanks,
> John Hubbard
>
>  tools/testing/selftests/vDSO/parse_vdso.c      | 16 +++++++++++-----
>  .../selftests/vDSO/vdso_standalone_test_x86.c  | 18 ++++++++++++++++--
>  2 files changed, 27 insertions(+), 7 deletions(-)
>
>
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 413f75620a35..4ae417372e9e 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -55,14 +55,20 @@ static struct vdso_info
>  	ELF(Verdef) *verdef;
>  } vdso_info;
>
> -/* Straight from the ELF specification. */
> -static unsigned long elf_hash(const unsigned char *name)
> +/*
> + * Straight from the ELF specification...and then tweaked slightly, in order to
> + * avoid a few clang warnings.
> + */
> +static unsigned long elf_hash(const char *name)
>  {
>  	unsigned long h = 0, g;
> -	while (*name)
> +	const unsigned char *uch_name = (const unsigned char *)name;
> +
> +	while (*uch_name)
>  	{
> -		h = (h << 4) + *name++;
> -		if (g = h & 0xf0000000)
> +		h = (h << 4) + *uch_name++;
> +		g = h & 0xf0000000;
> +		if (g)
>  			h ^= g >> 24;
>  		h &= ~g;
>  	}
> diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> index 8a44ff973ee1..27f6fdf11969 100644
> --- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> +++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> @@ -18,7 +18,7 @@
>
>  #include "parse_vdso.h"
>
> -/* We need a libc functions... */
> +/* We need some libc functions... */
>  int strcmp(const char *a, const char *b)
>  {
>  	/* This implementation is buggy: it never returns -1. */
> @@ -34,6 +34,20 @@ int strcmp(const char *a, const char *b)
>  	return 0;
>  }
>
> +/*
> + * The clang build needs this, although gcc does not.
> + * Stolen from lib/string.c.
> + */
> +void *memcpy(void *dest, const void *src, size_t count)
> +{
> +	char *tmp = dest;
> +	const char *s = src;
> +
> +	while (count--)
> +		*tmp++ = *s++;
> +	return dest;
> +}
> +
>  /* ...and two syscalls.  This is x86-specific. */
>  static inline long x86_syscall3(long nr, long a0, long a1, long a2)
>  {
> @@ -70,7 +84,7 @@ void to_base10(char *lastdig, time_t n)
>  	}
>  }
>
> -__attribute__((externally_visible)) void c_main(void **stack)
> +void c_main(void **stack)
>  {
>  	/* Parse the stack */
>  	long argc = (long)*stack;
>

These work for me for compiling with clang.

Reviewed-by: Edward Liaw <edliaw@google.com>

