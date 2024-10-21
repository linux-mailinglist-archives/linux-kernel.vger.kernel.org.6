Return-Path: <linux-kernel+bounces-374829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FAD9A70BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0F1282AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC21EE006;
	Mon, 21 Oct 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isDoi9fC"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668A1EBFE8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530800; cv=none; b=rNqrgCdAS5WE+7jkw37jBEYeMj5nZi9g81i2+kJUUUultv8R+sBbZwKjfPDphIxfDRxh8HKF6KueRoObdV9qSVLo1XpJHFjvxbVdGj09W8DBjwPxLmKijxKcTVutWUURSDi/5hxxJ6KRkaVZKMClsGrIxRt13r6mseIzQ7GGxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530800; c=relaxed/simple;
	bh=AKGUa9HVhL1DgtmZqXIpB957RrjigEuHhMqNpUgoZNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMmheUnUQk4U/IkOg7JRPGKzA9BnmlmA+SSF49ruYfaZAif2Qr8ibTIwankB/SzBA19hNbN3hXgyeNxuzttbrVDX1/T0RtVUYGHurr3ycqQ/IB5o+5IbKpa8G9E5C8VJZt/Bo/vDzf6Pkh3jGXdUYadC+4u8MTMdzvKUyVXyEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isDoi9fC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43152b79d25so45664275e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729530796; x=1730135596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIluIAwMUTUE/eR1vRRj+RdoUmdMgjbC2v9uVOonL6s=;
        b=isDoi9fCADHtA4KOefzDCoLR3SoaTGKg6CwxuvJUoP6fUc3OSr5zCEZ5LpTPNgSpqc
         25fg64nZxHP5EJju9Bg9xKXbl+gHr2YvNsPgsshR1oBWorFm5fPX3j2hZiy1xPyLmaGf
         5w/XT7Y78F6gbIXRAZjvajwkfvm1LC9kysmSc3jAagA7PZnwnNWa+OT6l2cMoU0cvPEK
         UapSEdyIkiABTfYJLdmCAj44qMk+DqZqMbjp4F3JWCR5GOxHMT/MHU07t5hu1AZu9UaV
         SUsfUyv6QNYvUa+Llr1OtW00+9AMuY2twPNKmMVgD1gd3InyrV7AjWF0d72ojS2cisdO
         7n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530796; x=1730135596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIluIAwMUTUE/eR1vRRj+RdoUmdMgjbC2v9uVOonL6s=;
        b=QYtNMAm8e+twtk6/WoB4B43uSfPgOHntL00apoMaea9W8p3KqD8C0n7vBKr62Cqn3c
         zN1S6N5B9nQ5ETKahhV7inBYJncnpC/4stxxN7fqHT3kHPEwQokXlqJETRUJchlNCI6t
         yi2tutxvhypnHZRw8XJ48oCRiQjfyrZUkaqGgnGv4lfhLJ6hSdEoyn2zj2AqYtp+1i1h
         DYJLzN5AQ2c1s5zzG8hbZK/EuQAyJRag2D0BhCI8IszGK35rIKFd1BjB/uyixDGuUdbX
         pt8nMf3l7Ru+uHLgM1pyDE0ZeAq7vDp3HoC9zvfRICRJD/QHRQawg6VHJ8iBzUOEchrw
         o3mA==
X-Forwarded-Encrypted: i=1; AJvYcCWUFA5Z6Orb3EXlJdKG56P25C3FUR36trD7mBynx0m07zve4cZspLXT3t94dLnlmBnbfbsknvPU57meFOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZW+CtYfDu6pDIePiQPysrLYKHXvlMy9NQwzn9E4yo52ahZh9
	hPUNvo6nYMyChQHfEGiU/HMZE8UPETneivZh7sbBho9b+nrtMjB5qNcTd9ZUiWTswhpU8xQ5JQG
	ApQgdUGEZSXWYj53ETkUz30Yzs4c=
X-Google-Smtp-Source: AGHT+IFvFFwCBZPEFVvJfGZmKvzpSgoyd0lix8VnZz9h/ZZELYJi0jCL2irDzbC73GlnOsRJ1sx57L07id50l89bL6w=
X-Received: by 2002:a05:600c:19d2:b0:431:3c67:fb86 with SMTP id
 5b1f17b1804b1-431616a404dmr89446045e9.33.1729530795938; Mon, 21 Oct 2024
 10:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021120013.3209481-1-elver@google.com> <20241021120013.3209481-2-elver@google.com>
In-Reply-To: <20241021120013.3209481-2-elver@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 21 Oct 2024 19:13:05 +0200
Message-ID: <CA+fCnZcU1P5RxLmHekgsWGWQZ+oOQQLqH_LC0JxqBtLJqR3c7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "kasan: Disable Software Tag-Based KASAN with GCC"
To: Marco Elver <elver@google.com>
Cc: Will Deacon <will@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 2:00=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> This reverts commit 7aed6a2c51ffc97a126e0ea0c270fab7af97ae18.
>
> Now that __no_sanitize_address attribute is fixed for KASAN_SW_TAGS with
> GCC, allow re-enabling KASAN_SW_TAGS with GCC.
>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrew Pinski <pinskia@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/Kconfig.kasan | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 233ab2096924..98016e137b7f 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -22,11 +22,8 @@ config ARCH_DISABLE_KASAN_INLINE
>  config CC_HAS_KASAN_GENERIC
>         def_bool $(cc-option, -fsanitize=3Dkernel-address)
>
> -# GCC appears to ignore no_sanitize_address when -fsanitize=3Dkernel-hwa=
ddress
> -# is passed. See https://bugzilla.kernel.org/show_bug.cgi?id=3D218854 (a=
nd
> -# the linked LKML thread) for more details.
>  config CC_HAS_KASAN_SW_TAGS
> -       def_bool !CC_IS_GCC && $(cc-option, -fsanitize=3Dkernel-hwaddress=
)
> +       def_bool $(cc-option, -fsanitize=3Dkernel-hwaddress)
>
>  # This option is only required for software KASAN modes.
>  # Old GCC versions do not have proper support for no_sanitize_address.
> @@ -101,7 +98,7 @@ config KASAN_SW_TAGS
>         help
>           Enables Software Tag-Based KASAN.
>
> -         Requires Clang.
> +         Requires GCC 11+ or Clang.
>
>           Supported only on arm64 CPUs and relies on Top Byte Ignore.
>
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

