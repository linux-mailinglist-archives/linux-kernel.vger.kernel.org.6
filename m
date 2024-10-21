Return-Path: <linux-kernel+bounces-374828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001569A70BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1261A1C22825
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B71EF09F;
	Mon, 21 Oct 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxVerEbU"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E91EE029
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530787; cv=none; b=mEF3qugH1WIxHhBxM8yzlz8mU+HTof+Fi8V9YcgU8DThpPvRjg784CIJ20f0cWxTRlhIsPp9uO37tkwniIMkalATpa6hL0XXFyf3mNAMtbVCxD8aJTWgGYR9OBhyh78GCHip5XQxPoPGapslt7rOEt+dAyiD6vFukR5DIWEp+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530787; c=relaxed/simple;
	bh=StgDsdmjWTJEqKodEWbwepqiFWVBxNKa8zEwL3TWimY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgTP55qpTZ1SOiuZy7Y7b0saJGdIrLOWAi5Rz14yw4bhF3IFdqFHRMKZsdXCkPqgMUFH6iwhNBr4Qhq1j9viUv0JMBx8M0C6Js3Ppke8kEJt+tjMSsKbkN+fDxQJGdBeupbiRaBgyQNebaUwxHqIQMFlT5tYoDXZiXN5VKWoHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxVerEbU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so52222905e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729530783; x=1730135583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yu/DhZu6HvkLJQug5aPr8YQgLzNKRwKw+qMAOmhuUh8=;
        b=mxVerEbUyhJKhMNoufsHpPI2l4xte1WnL28popCmGZCYOsZD6paEF8L6uoACinEX1p
         TLa54YjPpfwCbdDgsO6sXJUGcvEr2rGkAhRZCNStV59t7nwXHR0q5qzbStxgmvupGLdQ
         3hYed6H3SNEVBHN15g5EstHLVrEencDFhz2FRzOBg6OoYo3XrKDGeCB3/87faGEI40EX
         1o+q1s6/9pMuc70dX2tUwAZvp41kB+SwYOkTNXROoJV9eT5ZOqDD7etAZyoDrSqe1hSZ
         2sPlAj0YvAWuFczNbD/YV4wes0k/CLCvvpuNul+O47RPmMI53/abhpa6c4XQNp7obgPl
         fPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530783; x=1730135583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yu/DhZu6HvkLJQug5aPr8YQgLzNKRwKw+qMAOmhuUh8=;
        b=HxUbpis0vveLkGixE8cj9YX1+sfiniDmd4OgA4856I3TrmOxLezb0y0TXmayIzxR4M
         rfiMJJvTVe7PPmHpxWzz6dqBiu/hsl8X8VA8tMA5cRqeMVb1wUBYxBrOG7w75Tr+T8wO
         CzZKU/c+iA6gah3bcTpg4zzRxg5yNN+U1HKVknvK63sGcYH48u/ijJlvCnyp67aE3qr8
         lbmaJP0CJsDnZv0w8HafqCqx/6E2+l1tjcpeQInfOTrHWJ2wyQ6Ka+HiAXsthUysJkwQ
         /nfmoF4pUEBYH313tIDDmxUw8yxzuoMoegzoc8uc7P49NhH2Vz+hIenkYTMUxqMfMDNp
         Ozcw==
X-Forwarded-Encrypted: i=1; AJvYcCXYbsgxAiN66NMIPg7k9ffLFBdcpvx8S1xfq/qV06vBtnMZPnjIbrGCLE73x869oZO2YLC8n66jN/7yoZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2qc6KCNLVBJzxXIScNfw/5S1OQdf9mBWVWMfoKyd98IGAJ7AV
	toVor1/lra0ogfizctoZ4K6EMqLKG2vpCdKFuhURcNDUrfwGcZSkRxXnAa9HFvnFGocvVK7Y6sa
	s1SKZJLCkobP61QLoxjWid0Viaak=
X-Google-Smtp-Source: AGHT+IGvg+ZOjt+aJJtnJj8yzwXxnCSUxiSwTE4yQInYvSm883y1SLFNZiKzJVLqmUO1MDxA7cME3bK/dnoIqpAcfXY=
X-Received: by 2002:a05:6000:4013:b0:371:8319:4dbd with SMTP id
 ffacd0b85a97d-37eab7436f6mr9252003f8f.17.1729530783265; Mon, 21 Oct 2024
 10:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021120013.3209481-1-elver@google.com>
In-Reply-To: <20241021120013.3209481-1-elver@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 21 Oct 2024 19:12:52 +0200
Message-ID: <CA+fCnZdr4drxL9UDjAS7sCaDCG_nBJkg=wfX8j=itvo9RdbOsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: Fix Software Tag-Based KASAN with GCC
To: Marco Elver <elver@google.com>
Cc: Will Deacon <will@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, syzbot+908886656a02769af987@syzkaller.appspotmail.com, 
	Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 2:00=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> Per [1], -fsanitize=3Dkernel-hwaddress with GCC currently does not disabl=
e
> instrumentation in functions with __attribute__((no_sanitize_address)).
>
> However, __attribute__((no_sanitize("hwaddress"))) does correctly
> disable instrumentation. Use it instead.
>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117196 [1]
> Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
> Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218854
> Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrew Pinski <pinskia@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/compiler-gcc.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index f805adaa316e..cd6f9aae311f 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -80,7 +80,11 @@
>  #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
>  #endif
>
> +#ifdef __SANITIZE_HWADDRESS__
> +#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddress"=
)))
> +#else
>  #define __no_sanitize_address __attribute__((__no_sanitize_address__))
> +#endif
>
>  #if defined(__SANITIZE_THREAD__)
>  #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

