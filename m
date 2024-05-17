Return-Path: <linux-kernel+bounces-182583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1118C8CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E771C21B38
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7C813FD83;
	Fri, 17 May 2024 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gr9jCqjK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE645007
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975442; cv=none; b=ekt45jPfJh8wQb6/ErzkWuQYCKi9VpKrNVZHsJD7umBVMBAUhmLFCCmYHOeEnYEljLenaRFXaJwKbCHGLOEFBM9/rnHNcirqvdC8cFyHQCQU+G8x8njxSkfyRyW7xp9zGRx3QboGKQTlct0Ut7MgzdXV9JVHfRq0DxNbMDzPYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975442; c=relaxed/simple;
	bh=XvCCKx8tFEqP1/BD+I3XNnGYNbZ5f6J3SCFAICBZd0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNotMG3VL99jlgirGIHQBsAW1mUHk8khvNht1uofiszM1tSEEyd6Brgd1ySl8QtFkUpdtc4M4VBQhi1D9HmDHVrKFmb8ANSpaT3YgQ/i+FF+QHw0LbECjnuvunyRMZDKHnFbDVtQiw5b80oIeGFYjMdZvzdTFTLbTat5uFAxsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gr9jCqjK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715975439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bxakr/BFBoeB5Z7JNvpJE420hX0IdbRkXcnTw/5V8o=;
	b=Gr9jCqjKifWM9mMN5HXKXVoXQhvJ144mbxGEjIK2YFLhK9rey1zwcuIbrEb83A8jdsOMhW
	3FlyYgnigTJtNglHkEKee7LI1UB2XHTAda7516xAw+hF1PB6P/hqhYQKIYi15/xGXI8SI/
	vuRifMwLFvhatGCUSWzsx2MN2QQZi0U=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-y-wtZTZDPSqU9-D7nbH0_A-1; Fri, 17 May 2024 15:50:37 -0400
X-MC-Unique: y-wtZTZDPSqU9-D7nbH0_A-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-61be452c62bso143785727b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715975437; x=1716580237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bxakr/BFBoeB5Z7JNvpJE420hX0IdbRkXcnTw/5V8o=;
        b=GtD1RDVoaXJHim2AtuGfKZzMm52fnho+cqTo9FseWATxVsKdyWIbOIIJiY+1n4pqqu
         YrI34n4ZJeaOeOHXaXVw1ah55WdWsG/YMwQMBBGk4OQgx+sp7GAqu7+2OTtQ/BDdzMP+
         c8l7jyaGSYXMWPU+lxNEO1gAJh3V4yNjhlp8nN1LtPg/DaKzFmPJczyyOFE7iJ5DAYUJ
         KvjN6ss12hAogOK/TjWNssGc0Ghmuf9eOIHFKzbr64ce1QK0EI0USou4YeRPKMsfXnCo
         cCfdI2ZDfOZBCT60bb7pHtzC/d3tcVPAXtY3bqgz0+8kopg4/3JjKS7PPxBXtlcW9IFF
         l1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXgdfOecO8a4ykX7eB+5AOGKZvftsO+mIpo56tvXVSw4MHS2F7MQ/+l9Bc2fEreNC9G39Z5fntW0DO5CUkzRwXeAyYEkNu7+ssg5gZq
X-Gm-Message-State: AOJu0YxtC9nBv0tPe0VDAI8OCUK0dpkr86mqGd5aVbLAydaKYebHpsZa
	N90JU9MMvA0VPFxXQOe95uul/Poq8QrAD97CpMVFtUf9omG0BzC8puXsUYA0+D2xWttldXCdQT5
	n6UlFkwWhsfjgnNJXeEWKGBwyiuhYNWjl5BgDKtpzlEBESkTg0n8VdWmKBpA9fhF/bmNDNcL9et
	ald8d/WQFWJi9cgre9Nn5SAsbwiFA/dbJOYYNK
X-Received: by 2002:a05:690c:6401:b0:615:35e1:e512 with SMTP id 00721157ae682-622afdb76b9mr250824487b3.0.1715975437070;
        Fri, 17 May 2024 12:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxZWsOAnMenqeD3LUnJgjbcNzOURcpVyRpjugF02QoP8oAeypq5/rysipjqCLig8Mwkfv+qKUEzIaY6M2epq0=
X-Received: by 2002:a05:690c:6401:b0:615:35e1:e512 with SMTP id
 00721157ae682-622afdb76b9mr250824237b3.0.1715975436677; Fri, 17 May 2024
 12:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517130118.759301-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240517130118.759301-1-andrey.konovalov@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Fri, 17 May 2024 13:50:10 -0600
Message-ID: <CAA1CXcAdG=OFkBzjPqr7M_kC7VZUdj-+vH_2W4UidfbQwfQbeA@mail.gmail.com>
Subject: Re: [PATCH] kasan, fortify: properly rename memintrinsics
To: andrey.konovalov@linux.dev
Cc: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Erhard Furtner <erhard_f@mailbox.org>, Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 7:02=E2=80=AFAM <andrey.konovalov@linux.dev> wrote:
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
> Closes: https://lore.kernel.org/all/20240501144156.17e65021@outsider.home=
/
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() funct=
ions")
> Fixes: 51287dcb00cc ("kasan: emit different calls for instrumentable memi=
ntrinsics")
> Fixes: 36be5cba99f6 ("kasan: treat meminstrinsic as builtins in uninstrum=
ented files")
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you for fixing this !! The test no longer panics :)

Now that the test progresses I also see rcu_uaf failing.
    # rcu_uaf: EXPECTATION FAILED at mm/kasan/kasan_test.c:870
    KASAN failure expected in "call_rcu(&global_rcu_ptr->rcu,
rcu_uaf_reclaim); rcu_barrier()", but none occurred
    not ok 31 rcu_uaf
 I can open a new thread for that if you'd like.

Tested-by: Nico Pache <npache@redhat.com>
Acked-by: Nico Pache <npache@redhat.com>

> ---
>  include/linux/fortify-string.h | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-strin=
g.h
> index 85fc0e6f0f7f..bac010cfc42f 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -75,17 +75,30 @@ void __write_overflow_field(size_t avail, size_t want=
ed) __compiletime_warning("
>         __ret;                                                  \
>  })
>
> -#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> +#if defined(__SANITIZE_ADDRESS__)
> +
> +#if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) && !defined(CONFIG=
_GENERIC_ENTRY)
> +extern void *__underlying_memset(void *p, int c, __kernel_size_t size) _=
_RENAME(memset);
> +extern void *__underlying_memmove(void *p, const void *q, __kernel_size_=
t size) __RENAME(memmove);
> +extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t=
 size) __RENAME(memcpy);
> +#elif defined(CONFIG_KASAN_GENERIC)
> +extern void *__underlying_memset(void *p, int c, __kernel_size_t size) _=
_RENAME(__asan_memset);
> +extern void *__underlying_memmove(void *p, const void *q, __kernel_size_=
t size) __RENAME(__asan_memmove);
> +extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t=
 size) __RENAME(__asan_memcpy);
> +#else /* CONFIG_KASAN_SW_TAGS */
> +extern void *__underlying_memset(void *p, int c, __kernel_size_t size) _=
_RENAME(__hwasan_memset);
> +extern void *__underlying_memmove(void *p, const void *q, __kernel_size_=
t size) __RENAME(__hwasan_memmove);
> +extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t=
 size) __RENAME(__hwasan_memcpy);
> +#endif
> +
>  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t s=
ize) __RENAME(memchr);
>  extern int __underlying_memcmp(const void *p, const void *q, __kernel_si=
ze_t size) __RENAME(memcmp);
> -extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t=
 size) __RENAME(memcpy);
> -extern void *__underlying_memmove(void *p, const void *q, __kernel_size_=
t size) __RENAME(memmove);
> -extern void *__underlying_memset(void *p, int c, __kernel_size_t size) _=
_RENAME(memset);
>  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat=
);
>  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy=
);
>  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strle=
n);
>  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_=
t count) __RENAME(strncat);
>  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_=
t size) __RENAME(strncpy);
> +
>  #else
>
>  #if defined(__SANITIZE_MEMORY__)
> @@ -110,6 +123,7 @@ extern char *__underlying_strncpy(char *p, const char=
 *q, __kernel_size_t size)
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


