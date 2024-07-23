Return-Path: <linux-kernel+bounces-259723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AEA939C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00987B21DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6935714B94F;
	Tue, 23 Jul 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1TADBwdx"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FE36130
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721415; cv=none; b=ATGEwbR2P58H8TEQSSxBjSJfR5hFWdhAuEZ/kSX0h5JvWFGIctZhmWVU4O28tbR9zcCL3CQiATCQZp6caNUjphoHHo1tQUOPQwc4FQhNMbRbe7AQrioXYKz6jvSyGiOgXugh7bXyev0XekkG6GR6z3YMINvdFY7RniQz99sR/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721415; c=relaxed/simple;
	bh=GztInIMhpwal4uCTespY8mGyrf4cWd+h3YKbdtXteZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=octRRXJ624C6qfSrZ/vAm6qopeZSJOvQTmeaQ6qTbkADrj7DBYdCfRqM8eDB8ej3MdVAmnBaTX4GdfHVY0mJiIIE6VTsvkq0szMTmuVGJM91Wrasc85PyagLHUaG27yRKHiuqCNdnmlyT8KrEQLi1w3t+i3Wu9ZZJJUxzj5oiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1TADBwdx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52fc14aa5f5so1689e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721721412; x=1722326212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1GR/uOEg6eBIIHTSjN+mU57G2H8hU3EN0wvpjh4VCBE=;
        b=1TADBwdxw6WHr+VhUNI4TKoXHiXzUy2NCBuPaNxbL1G8pQ+QR7f/Mf7nY0LDciv6K+
         WnN/+O0WFH67JQFwUN/aW/QG6QDaiwUT2flxbD4gsD6pyzZC7Yafss+QRuSuv+zh6TMI
         f9Ed5NhzxjeopuqfiKm2JRMHam3Iel98Es4/zR37ZE3Gh6zEf9BJG7uoTcCzCsv/e5KU
         x+6l2uDWYD1fVS4Wd+EGfWM26935wK9YJ0P1dLllRmIiqna/2LXsobtEX2n6MaVrK2RE
         ypYlGC1HCNngeLKPXnfC2liIEos0dsJIFLj2N924hQEe/dT9OgsqKT9jIEe6BB1FC1Sy
         xjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721721412; x=1722326212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GR/uOEg6eBIIHTSjN+mU57G2H8hU3EN0wvpjh4VCBE=;
        b=QPG8qESMjKt5LeLnu1jBr2oBtlGJkaYpLL3SnhxWLj12cKhMgX8MOYCUX2FHL5BRy6
         N5AyYIIOk+JPD04hhgOpx9kNvh6ZD6kmjJo1F5zFOmfHm6HVqGrlAOHDqPx1+xmKQc3q
         NUskhKTyGCkmxdE9v1P1Fpd1b/9TF2grl46P81Kym6e7js+R0EBLz6PQNyJZxZpdF4ZS
         Ce9ltoLty8mLFGryo5zo99qt1ZCC6xi3cphkedNpPoQxuc2tbBoEZn/Kc/qL0eydDwxC
         m6VjdRWpstwg+SQEoFM0Wwu7EV833vXSt2PUNeBPP+JTFnudu6Ssb+/bfHpVbzvRzK3D
         Hwvw==
X-Forwarded-Encrypted: i=1; AJvYcCUznbyuxhOrDnyT8KeL9TDBKSBYRmjfcJx0rcM4sJSdJkcLlbCmE5df7VpaibhtId78q8eaWMJKbjUpDovu0n6GocQqQcdLZ2yLuyR0
X-Gm-Message-State: AOJu0YyaFTxpcYpZ4LbQEA73BRYhP7KyhxmDGZ5VjgNrVVLewqjA/AU9
	9u5Htqbhqa4+kPay6Id7gM+zzxF/oWSFDW3zvTh8Gyoc5FoCyAhWGOI0reyMJkWiOP7SzUmYspS
	ntCSTC6R+bUJPwA7bfiiZ/nNMN9nh+UcrrqYY
X-Google-Smtp-Source: AGHT+IEsJ0U2aPAMB8nGkLErXNJERzT0LGcb+DjEDexXYysAF7ANmfr0OQk3jYSlfR5yTHQMnw8D59nZVIwF/W8NcGs=
X-Received: by 2002:a05:6512:6c7:b0:52c:ea5c:fb8c with SMTP id
 2adb3069b0e04-52efa181580mr249357e87.2.1721721411790; Tue, 23 Jul 2024
 00:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722223726.194658-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240722223726.194658-1-andrey.konovalov@linux.dev>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 23 Jul 2024 09:56:39 +0200
Message-ID: <CACT4Y+bA9mMmU1ZvNB2OgoDZ0jDBvFH38FQmxCKee7L_TNpvXQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: don't instrument lib/find_bit.c
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 00:37, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> This file produces large amounts of flaky coverage not useful for the
> KCOV's intended use case (guiding the fuzzing process).
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>
> I noticed this while running one of the syzkaller's programs.
>
> In one run of the program, the number of KCOV entries amounts to ~300k,
> with the top ones:
>
>  117285 /home/user/src/lib/find_bit.c:137 (discriminator 10)
>  116752 /home/user/src/lib/find_bit.c:137 (discriminator 3)
>    2455 /home/user/src/lib/vsprintf.c:2559
>    2033 /home/user/src/fs/kernfs/dir.c:317
>    1662 /home/user/src/fs/kernfs/kernfs-internal.h:72
>    ...
>
> In another run (that triggers exactly the same behavior in the kernel),
> the amount of entries drops to ~110k:
>
>    7141 /home/user/src/lib/find_bit.c:137 (discriminator 10)
>    7110 /home/user/src/lib/find_bit.c:137 (discriminator 3)
>    2455 /home/user/src/lib/vsprintf.c:2559
>    2033 /home/user/src/fs/kernfs/dir.c:317
>    1662 /home/user/src/fs/kernfs/kernfs-internal.h:72
>     ...
>
> With this patch applied, the amount of KCOV entries for the same program
> remains somewhat stable at ~100k.
> ---
>  lib/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 322bb127b4dc..0fde1c360f32 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -14,6 +14,7 @@ KCOV_INSTRUMENT_list_debug.o := n
>  KCOV_INSTRUMENT_debugobjects.o := n
>  KCOV_INSTRUMENT_dynamic_debug.o := n
>  KCOV_INSTRUMENT_fault-inject.o := n
> +KCOV_INSTRUMENT_find_bit.o := n
>
>  # string.o implements standard library functions like memset/memcpy etc.
>  # Use -ffreestanding to ensure that the compiler does not try to "optimize"
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20240722223726.194658-1-andrey.konovalov%40linux.dev.

