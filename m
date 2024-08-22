Return-Path: <linux-kernel+bounces-297390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B5F95B779
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8EA1C217F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CC01CC16E;
	Thu, 22 Aug 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jw2iSkyI"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA21CB31E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334599; cv=none; b=GhpRAUx1htpu6Bg1na9J4ZMYtmb2T+P5fRoNqgGcaRH+w6Cnw0asMQrpdIsnNaCG6lGfpzS4isZZMv9CQFg6lvft1TvyI2B5exMLNZQ6lLtT9dxK7n6i1h2W74N5TCXJmNffJAfxIJI567mZgVwTSOoow3J8wTNjmgqCc11PM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334599; c=relaxed/simple;
	bh=nhJ6BZSeobLpHrVtAXPYAEe8rxjUuJ58gPq9hycYzes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLMSbyKqik9V8Es3NBI8cjQvkk4ulV5y1kyFxcVYjUF0eyNpzNpEnZyI5mMoqA+HILoxK4LxmJnq6EulDNNpwb1InN+6y5tEHNVz/kYzJH14j+gB22O5g09TTCwJ4/m5Q7tzBqs0ZNELRpsMo+H/PzDdckekSXTU4y8sQ8iRVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jw2iSkyI; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4fc92316e1bso245319e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724334597; x=1724939397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ppKkVe0CCoZvohxPx6OHDazO83RnHbxwEsZp1jfSt0=;
        b=Jw2iSkyIDgrpeaxZHpZMok8IfZ7GD37R3LGNnBfrxqFM/UFgIIRx9e2sxMGoEhvBtr
         l+NeaOl+ZOtkvGQ6EsZAZZplkXWNjwnjtC99eMiOdGUdVYbn7uKtI/ISniXjNTSJBPSh
         evvE2ZL0CkWBGT5AWk6how4pF0KbQherIyqNAJROVzdBlSnTWUqwz3Oe616vp/e+uNfP
         dSJ3qZoKDDiNYbBVlQAQnrXSB7KERuU3WxBIHpIfLlKdYIpvGub9hfSgRuB+9LjyUF+L
         bZ52L8nSgWhozqTAquEpZQnZ1fqeuejyoO6y6HPcm8DWMTYtul+IW+sFbs9mNbL+p1uJ
         M9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334597; x=1724939397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ppKkVe0CCoZvohxPx6OHDazO83RnHbxwEsZp1jfSt0=;
        b=c2Tx5ei4Sf5YRHI8BaEWY5Y7z/sDrVlrLpnvmETiPgIe9WBU6kN/PnjgjqqV5x96MK
         XUrgN82VxfWPPLyqG4AVAPnJB0gEQ/hdl3OxdYaqzw/WmK2VmpsjGHYkxyvquf0/AKQ/
         VfRyYw6dDzyfit2ztgh9spkBqFmnWzyxrAfx14QIWrQDePATmBFr064iX1GTJZq3BPvO
         WccQu0AljtREr21uOo7AKo+BNoRdVaAUeCfsom3c5dxj+/y2nboQmP1R2vhRsNyx2IrP
         uQ9geB/zhQ7NI144TKFkiAIdXMNzW0WGRsPda3vKsZsDLdbHUxrA+yr0oNqecCc6oqSq
         m2hA==
X-Forwarded-Encrypted: i=1; AJvYcCXjPSTklVySBJd1IkwAznAMG8KnEK5jEdftN6B/ggjpQH8RovGNGPGFMdLiECs2VJhyS1tzab5CPEmy1YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqSu6ZgtK4tSpiAy9wlw+Wva21vER0ZyCs5gN5frKlVJGUceA
	eN+U/1XSvDwZ9eDmEE5i+sRv3JLmZeXFRC2bBWwSMkVQ7BMG/BdkTunp9uBq+4DKWaWYrawnpoX
	amdnXs649PtaU+boG2Cz0ujRvyw50cd3+luGU
X-Google-Smtp-Source: AGHT+IF1UXEKeoh9abtkbjAFOamRAl6saz7m+vyjqnH5wDBvpCMw/i2623dgQQ8KaAI5kVAXi9vIjE2gkVX8zHrBfzo=
X-Received: by 2002:a05:6122:3125:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-4fcf1b64a4fmr8813741e0c.12.1724334596612; Thu, 22 Aug 2024
 06:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814161052.10374-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240814161052.10374-1-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Thu, 22 Aug 2024 15:49:18 +0200
Message-ID: <CANpmjNM7p8-U1eh7m4vCh5M7pKODHExzw0EVtOXQRu-udb7qaA@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: simplify and clarify Makefile
To: andrey.konovalov@linux.dev
Cc: Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 18:11, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> When KASAN support was being added to the Linux kernel, GCC did not yet
> support all of the KASAN-related compiler options. Thus, the KASAN
> Makefile had to probe the compiler for supported options.
>
> Nowadays, the Linux kernel GCC version requirement is 5.1+, and thus we
> don't need the probing of the -fasan-shadow-offset parameter: it exists in
> all 5.1+ GCCs.
>
> Simplify the KASAN Makefile to drop CFLAGS_KASAN_MINIMAL.
>
> Also add a few more comments and unify the indentation.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Acked-by: Marco Elver <elver@google.com>

Just in case, did you test SW and HW tags modes as well?

> ---
>
> Changes v1->v2:
> - Comments fixes based on Miguel Ojeda's feedback.
> ---
>  scripts/Makefile.kasan | 45 +++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index 390658a2d5b74..aab4154af00a7 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -22,30 +22,31 @@ endif
>  ifdef CONFIG_KASAN_GENERIC
>
>  ifdef CONFIG_KASAN_INLINE
> +       # When the number of memory accesses in a function is less than this
> +       # call threshold number, the compiler will use inline instrumentation.
> +       # 10000 is chosen offhand as a sufficiently large number to make all
> +       # kernel functions to be instrumented inline.
>         call_threshold := 10000
>  else
>         call_threshold := 0
>  endif
>
> -CFLAGS_KASAN_MINIMAL := -fsanitize=kernel-address
> -
> -# -fasan-shadow-offset fails without -fsanitize
> -CFLAGS_KASAN_SHADOW := $(call cc-option, -fsanitize=kernel-address \
> -                       -fasan-shadow-offset=$(KASAN_SHADOW_OFFSET), \
> -                       $(call cc-option, -fsanitize=kernel-address \
> -                       -mllvm -asan-mapping-offset=$(KASAN_SHADOW_OFFSET)))
> -
> -ifeq ($(strip $(CFLAGS_KASAN_SHADOW)),)
> -       CFLAGS_KASAN := $(CFLAGS_KASAN_MINIMAL)
> -else
> -       # Now add all the compiler specific options that are valid standalone
> -       CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
> -        $(call cc-param,asan-globals=1) \
> -        $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
> -        $(call cc-param,asan-instrument-allocas=1)
> -endif
> -
> -CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
> +# First, enable -fsanitize=kernel-address together with providing the shadow
> +# mapping offset, as for GCC, -fasan-shadow-offset fails without -fsanitize
> +# (GCC accepts the shadow mapping offset via -fasan-shadow-offset instead of
> +# a --param like the other KASAN parameters).
> +# Instead of ifdef-checking the compiler, rely on cc-option.
> +CFLAGS_KASAN := $(call cc-option, -fsanitize=kernel-address \
> +               -fasan-shadow-offset=$(KASAN_SHADOW_OFFSET), \
> +               $(call cc-option, -fsanitize=kernel-address \
> +               -mllvm -asan-mapping-offset=$(KASAN_SHADOW_OFFSET)))
> +
> +# Now, add other parameters enabled similarly in both GCC and Clang.
> +# As some of them are not supported by older compilers, use cc-param.
> +CFLAGS_KASAN += $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
> +               $(call cc-param,asan-stack=$(stack_enable)) \
> +               $(call cc-param,asan-instrument-allocas=1) \
> +               $(call cc-param,asan-globals=1)
>
>  # Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
>  # instead. With compilers that don't support this option, compiler-inserted
> @@ -57,9 +58,9 @@ endif # CONFIG_KASAN_GENERIC
>  ifdef CONFIG_KASAN_SW_TAGS
>
>  ifdef CONFIG_KASAN_INLINE
> -    instrumentation_flags := $(call cc-param,hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET))
> +       instrumentation_flags := $(call cc-param,hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET))
>  else
> -    instrumentation_flags := $(call cc-param,hwasan-instrument-with-calls=1)
> +       instrumentation_flags := $(call cc-param,hwasan-instrument-with-calls=1)
>  endif
>
>  CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
> @@ -70,7 +71,7 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
>
>  # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
>  ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
> -CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
> +       CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
>  endif
>
>  endif # CONFIG_KASAN_SW_TAGS
> --
> 2.25.1
>

