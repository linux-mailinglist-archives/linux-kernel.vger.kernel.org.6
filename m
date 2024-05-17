Return-Path: <linux-kernel+bounces-182289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F2A8C8942
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BE4280EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679D412D1EC;
	Fri, 17 May 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SS9A74wE"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1C96A8DE
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959361; cv=none; b=etfI438lch256RsBWir4lOvUnmzJUHn4Wj8LlJf7Zn7MglBmN13PFLPjHNZCSGdbdX9zxkYdU2iTNotiQajxQai7oKq3KauxdYKAOl81OqfNKQs2tS+I8wPx0QiA+T4nMqqzqslKAh8bbx5cvdmsvPZzJyGHIT0mRTCtpkez7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959361; c=relaxed/simple;
	bh=SoNjM+fZ7CTvIUU9FKqh2EWjcEbzvsg7sGSSi3DdsV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEtfHSGskeXSZnP2QrO70MVE/vR7VKt9vjIl2yGofA9rpgYQOq2bp29Gjn/QeFpmGNN8AbGjmND4ydQCSRpzYyE9jGw7C3fnW3r2dnTM2/YkXTm7BaLWtYRAZMDYtowDrhd2+EgmYQMeDlZlF/AtAE8J9EUHxJcNwP5LOqcBqWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SS9A74wE; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4df2a816455so254147e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715959359; x=1716564159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a0X1IdGrvgRbIDZDbKlklVPOFj9du4fG+oJBScJlx9I=;
        b=SS9A74wE6LHPNSRyFk6q77cTsqUE8hdfUeoiWp63dln8EqOYkAeDslONOwds9H93DA
         oJnV+RPME8knDHLPyOv7VCBCbjlMIB9+JCEorPj2qNflVw6Q3GP8AwvLDsyLOfN72aG4
         LCC6Mb1ZT/02JkrhPmNH8FXmlE2wMmTYby2mufeCIHPzdi2lgxW7ANVLRvhTS8zaUNei
         tEMupoxtfq98Ti7bsxtJb/HVLwTiDC8Nt0GmeZp9GGTWRvEYhiv2j92LO+sDKQLOWUqo
         Z/GtKij0O+5C3Lo8h1jTLsMsCuBiwzEXSS7KTHgkD5ABWSRTMZ1LN9R4qsqAG0Qj8Fu7
         c3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959359; x=1716564159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0X1IdGrvgRbIDZDbKlklVPOFj9du4fG+oJBScJlx9I=;
        b=LrQISJ9G/4TQUawvn+Vm8XgnFjm2LEB4sJg2b33RwvxSIZIauUfPLuNJcdQnQTy880
         45KLeqhH8NJ6WGu0Z3D9lpd1u2Si8EvFfqEuwhJzUBczFQx2ln43Vqc4PHA4N3YZWxFL
         B7IlrMP5GfYoodQubtATBjNmsYIxed83rAEZUweKMh6aYkJrH1Mplam8Lmy+q3RhgmmQ
         A4aYl7qyjmn4n2ZvT3DXg51mybY9nGf38zz9RHBlJt8c2CLD6EXe+REG3nVM/GiZUEZt
         je16DFvyntzEZORcgx3cRBKtxXwEFUxXlpT7KG25fnJR6433LyTS0PGtwXq499cTotT8
         rrkg==
X-Forwarded-Encrypted: i=1; AJvYcCVww9qHipMNpfTbquH6x7FvjnAc/2aAVdZg7bX0skmudWjaCiJ9Csoshh/q19Z9rQ4x8bntoBQVEZBv9GAqNDGSjnwm7BsN0cfbs+3p
X-Gm-Message-State: AOJu0Yzre8CemHD3qpW96JHyfP8sjcYMO7+miu+QlWIcjgAO79akEPqu
	sGvT8oIimaC2yBmVbubcmAIvMvdYKRimT6xKKQBQYaVW3Skf5rLmHq5InScs0C0HWVpLukO9tYJ
	gfWZgAgBpDI291cdLOrWaMI6owV3i5bi2WWtS
X-Google-Smtp-Source: AGHT+IHimgZxVAtnI+vF7pLVRq7Oh/c7g37qx4xedEDmPMvZxwY+/11EHWLfIn6MDIjYi7FNRJ9mzDpxRGtc3xtIs5c=
X-Received: by 2002:a05:6122:98a:b0:4d3:362f:f9c1 with SMTP id
 71dfb90a1353d-4df88359107mr21578723e0c.13.1715959357364; Fri, 17 May 2024
 08:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517130118.759301-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240517130118.759301-1-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Fri, 17 May 2024 17:21:58 +0200
Message-ID: <CANpmjNNNW-URJjyEpb9CYM2kvYdzNu-jbmk2V2fukbTU=PB29Q@mail.gmail.com>
Subject: Re: [PATCH] kasan, fortify: properly rename memintrinsics
To: andrey.konovalov@linux.dev
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Erhard Furtner <erhard_f@mailbox.org>, Nico Pache <npache@redhat.com>, Daniel Axtens <dja@axtens.net>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 15:01, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> After commit 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*()
> functions") and the follow-up fixes, with CONFIG_FORTIFY_SOURCE enabled,
> even though the compiler instruments meminstrinsics by generating calls
> to __asan/__hwasan_ prefixed functions, FORTIFY_SOURCE still uses
> uninstrumented memset/memmove/memcpy as the underlying functions.
>
> As a result, KASAN cannot detect bad accesses in memset/memmove/memcpy.
> This also makes KASAN tests corrupt kernel memory and cause crashes.
>
> To fix this, use __asan_/__hwasan_memset/memmove/memcpy as the underlying
> functions whenever appropriate. Do this only for the instrumented code
> (as indicated by __SANITIZE_ADDRESS__).
>
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Reported-by: Nico Pache <npache@redhat.com>
> Closes: https://lore.kernel.org/all/20240501144156.17e65021@outsider.home/
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Fixes: 51287dcb00cc ("kasan: emit different calls for instrumentable memintrinsics")
> Fixes: 36be5cba99f6 ("kasan: treat meminstrinsic as builtins in uninstrumented files")
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

This is getting rather complex, but I don't see a better way either.

> ---
>  include/linux/fortify-string.h | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 85fc0e6f0f7f..bac010cfc42f 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -75,17 +75,30 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
>         __ret;                                                  \
>  })
>
> -#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> +#if defined(__SANITIZE_ADDRESS__)
> +
> +#if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) && !defined(CONFIG_GENERIC_ENTRY)
> +extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
> +extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
> +extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
> +#elif defined(CONFIG_KASAN_GENERIC)
> +extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(__asan_memset);
> +extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(__asan_memmove);
> +extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(__asan_memcpy);
> +#else /* CONFIG_KASAN_SW_TAGS */
> +extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(__hwasan_memset);
> +extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(__hwasan_memmove);
> +extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(__hwasan_memcpy);
> +#endif
> +
>  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
>  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
> -extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
> -extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
> -extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
>  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
>  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
>  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
>  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
>  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
> +
>  #else
>
>  #if defined(__SANITIZE_MEMORY__)
> @@ -110,6 +123,7 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
>  #define __underlying_strlen    __builtin_strlen
>  #define __underlying_strncat   __builtin_strncat
>  #define __underlying_strncpy   __builtin_strncpy
> +
>  #endif
>
>  /**
> --
> 2.25.1
>

