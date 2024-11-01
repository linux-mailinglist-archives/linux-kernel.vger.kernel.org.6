Return-Path: <linux-kernel+bounces-393037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8DB9B9B3B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937991F21FF3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AFA18A6A0;
	Fri,  1 Nov 2024 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkhESd7F"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065131D555
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730504319; cv=none; b=DgkxH+nHyyDPuWm4j59X53duXqZZFzbPOOE9a+/D3eqqVdS+JD97b5+W1n2dEdjWnJeeMUTdddpi3G7T61UNi58U0QvZ+x465ZKhurTzxsYqKzoqfXg1X1eGoUHFCUGkZ3n58lTECg2Ck50JFjxSWESfDQfygNJOBgeXr8QruIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730504319; c=relaxed/simple;
	bh=VrxA82Et/EV40DHgQd645NW/CqTU0aBpxBRZenqU9uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNtQFqF859/JTdc8r/opTUmhUr/NRnqNy78UW97k89G2SCUrLU2DJAf60AIkaVaMWB/cN7tfDXqXir62tFO2TmfZmGe/d3OnK/U+ypzUSqa+Nn5nNQrF0zpkjjsmGAukq134Ng4qi3Ib14dUmPfah8D0JslC2aleoonccKlFmI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkhESd7F; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431ac30d379so19521565e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 16:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730504316; x=1731109116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5rcjHrmlWR+LzcpKryq3ZwD/HvuZwE0xyR9heRD69s=;
        b=OkhESd7FU68py8aJD7FdadgMD5FlLDdn9kbv9ZGMKerD6sDOP595v19tiuUa37RYX2
         VEytJzW9+pmZZo6Qr5rCkCK7ue8CEuP6C/gdnpYPBj5QaPFFiT1Y4V1lFmisiiM6/jvy
         ShQ30kB5JuY+nClWa+gHGgl6yyiU+FDisVIkbriK0RtqiX+yVzkU2006RAQc2lCQhR1h
         pXJMqfT/I+UUztmgFjYpnplNnUPdnBt3MDnFdhT0f/M9kHNPS2HtePp6UDqTNAFdqC8P
         SOx9dvxgvhOhC+eGmN+wGrsROGa8kV+fi4r5FRI8ANmStveVLgDk4xoVvo+bInUUF5PQ
         LFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730504316; x=1731109116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5rcjHrmlWR+LzcpKryq3ZwD/HvuZwE0xyR9heRD69s=;
        b=U/jq4OjxgC9GItUtz0pI6TXkGXaGm3xLDVxTr019ICnGmEIiK7a4H7pJ461WKLOH+4
         /8QJIsDnTkNF4v5qfzOlrPNE6A6wrW4kq6l3KMKWMCgpekDGqYj/ztSh7NT7tdyQd29j
         1BqF9zY8v625peDpiWQ8jBmx2DjPti9hFlw1/FKUwAMN3jepkOCy0lHWyDM+ixFZCTe1
         jqHNYIFt+2eg6OfVS3D8JNxiSfnEVJifaN0t2hzygp9GOflzUEK/wu8XNymkQKTVdV4H
         ydNNCJbsFPzAwp4k97AiDyyKUqzpfVdpJegJdUmjYebgzXeYj0waKeUqlg+ukfSFgN2A
         VAJA==
X-Forwarded-Encrypted: i=1; AJvYcCX95cpJ7EMm3+Dv5Tq8xmPvc69jSM+XMMMQdqPi3NYM5eP8P3UXGZeOa+Iw7qbI/CdYfxlRr0SsdzbKpBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwchLVhyBQvSOB36DbXdmVzVPPfvYW/pVbBN5A8Q24YLpuneGNQ
	BgrU1OyJc0VJ+iRPTV4oO3cATszR7eeJkMtn4QLKtq6dA5KR2CUSthfEbMM4g+xMaMt8ju9UB9h
	SQBj2YLBFfIYudFzq6by0WE+1TDw=
X-Google-Smtp-Source: AGHT+IEVeOhuTN1DkEBQ8XjGr9sip5JeKBjAy4hzGpo17c0t1m1d24S2PEf/M6lGQcJaBNOT2uNkU8x7ObeDEuK3JQM=
X-Received: by 2002:a05:600c:1d1c:b0:431:55bf:fe4 with SMTP id
 5b1f17b1804b1-431b17365ffmr149672825e9.24.1730504316102; Fri, 01 Nov 2024
 16:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101184011.3369247-1-snovitoll@gmail.com> <20241101184011.3369247-2-snovitoll@gmail.com>
In-Reply-To: <20241101184011.3369247-2-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 2 Nov 2024 00:38:25 +0100
Message-ID: <CA+fCnZchoBgJp417G8dtNkiYnSY75hBmM=beDrxhJJyuPw=7iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: use EXPORT_SYMBOL_IF_KUNIT to export symbols
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, elver@google.com, arnd@kernel.org, 
	glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:40=E2=80=AFPM Sabyrzhan Tasbolatov <snovitoll@gmai=
l.com> wrote:
>
> Replace EXPORT_SYMBOL_GPL with EXPORT_SYMBOL_IF_KUNIT to mark the
> symbols as visible only if CONFIG_KUNIT is enabled.
>
> KASAN Kunit test should import the namespace EXPORTED_FOR_KUNIT_TESTING
> to use these marked symbols.
>
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218315
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  mm/kasan/hw_tags.c      |  7 ++++---
>  mm/kasan/kasan_test_c.c |  2 ++
>  mm/kasan/report.c       | 17 +++++++++--------
>  3 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 9958ebc15d38..ccd66c7a4081 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -8,6 +8,7 @@
>
>  #define pr_fmt(fmt) "kasan: " fmt
>
> +#include <kunit/visibility.h>
>  #include <linux/init.h>
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
> @@ -394,12 +395,12 @@ void kasan_enable_hw_tags(void)
>
>  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
>
> -EXPORT_SYMBOL_GPL(kasan_enable_hw_tags);
> +EXPORT_SYMBOL_IF_KUNIT(kasan_enable_hw_tags);
>
> -void kasan_force_async_fault(void)
> +VISIBLE_IF_KUNIT void kasan_force_async_fault(void)
>  {
>         hw_force_async_tag_fault();
>  }
> -EXPORT_SYMBOL_GPL(kasan_force_async_fault);
> +EXPORT_SYMBOL_IF_KUNIT(kasan_force_async_fault);
>
>  #endif
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..3e495c09342e 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -33,6 +33,8 @@
>
>  #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANUL=
E_SIZE)
>
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> +
>  static bool multishot;
>
>  /* Fields set based on lines observed in the console. */
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index b48c768acc84..e5bc4e3ee198 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -10,6 +10,7 @@
>   */
>
>  #include <kunit/test.h>
> +#include <kunit/visibility.h>
>  #include <linux/bitops.h>
>  #include <linux/ftrace.h>
>  #include <linux/init.h>
> @@ -134,18 +135,18 @@ static bool report_enabled(void)
>
>  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST) || IS_ENABLED(CONFIG_KASAN_MODUL=
E_TEST)
>
> -bool kasan_save_enable_multi_shot(void)
> +VISIBLE_IF_KUNIT bool kasan_save_enable_multi_shot(void)
>  {
>         return test_and_set_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
>  }
> -EXPORT_SYMBOL_GPL(kasan_save_enable_multi_shot);
> +EXPORT_SYMBOL_IF_KUNIT(kasan_save_enable_multi_shot);
>
> -void kasan_restore_multi_shot(bool enabled)
> +VISIBLE_IF_KUNIT void kasan_restore_multi_shot(bool enabled)
>  {
>         if (!enabled)
>                 clear_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
>  }
> -EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
> +EXPORT_SYMBOL_IF_KUNIT(kasan_restore_multi_shot);
>
>  #endif
>
> @@ -157,17 +158,17 @@ EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
>   */
>  static bool kasan_kunit_executing;
>
> -void kasan_kunit_test_suite_start(void)
> +VISIBLE_IF_KUNIT void kasan_kunit_test_suite_start(void)
>  {
>         WRITE_ONCE(kasan_kunit_executing, true);
>  }
> -EXPORT_SYMBOL_GPL(kasan_kunit_test_suite_start);
> +EXPORT_SYMBOL_IF_KUNIT(kasan_kunit_test_suite_start);
>
> -void kasan_kunit_test_suite_end(void)
> +VISIBLE_IF_KUNIT void kasan_kunit_test_suite_end(void)
>  {
>         WRITE_ONCE(kasan_kunit_executing, false);
>  }
> -EXPORT_SYMBOL_GPL(kasan_kunit_test_suite_end);
> +EXPORT_SYMBOL_IF_KUNIT(kasan_kunit_test_suite_end);
>
>  static bool kasan_kunit_test_suite_executing(void)
>  {
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

