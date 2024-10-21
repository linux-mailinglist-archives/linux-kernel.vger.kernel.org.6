Return-Path: <linux-kernel+bounces-374248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7739A676F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEC11C2218F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E0B1E8859;
	Mon, 21 Oct 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqT5or3E"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20761E47A1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512036; cv=none; b=oXO4mxQMDm8t9T4E+wHQEFjxArQZWNW4SmoAcOidOI9MbUvoIkUab3tuc/dwxYkEAUujHCDXpbP1br/pT7GT4qIBKKMSXP4wItpwmDuDooiL56rjhIV90m2f6KGRBKHZMlVMFiZC9E/PXiY+kfY9x1gnWkpPa5OuvvtH7+WF2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512036; c=relaxed/simple;
	bh=zZ+RIEKJaeAzac64tOlAm+si4QUfJCxVQ2Zk4gbQ+hU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I0QGJrth1VuDGAOTR6RApIwzPhNuvYKXM2y3VsncngahD35ZuBv23mlIg0cjGDkmDmJec1qC3xwFqmREvx+RY48iRXTr4ZLjLmUYQuDupED5pL1o/puKZJmpdg1yVryaaDaBaPkotfyLOGqdi5xdAXNIi9J6v99T9rAKCwgmDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqT5or3E; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a7d2d414949so257211966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729512033; x=1730116833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RPnI/3Gz1Y4IhHQKOjsXLrlBegzE9vzRcMrKpdABMo=;
        b=aqT5or3E+p5nXTqwOYmaeIkx3EfhPx19AgUs0SsFtKoYDUFZcsgnMeLsv4CoyKsXQr
         5GckeW5h/NRnz9QC30C2oU8n7i30U09KI/rLQjGDKXEtavxm0Q1lOcdoLbTE+hUPCOmP
         JPkGH9QkDZaYCWTf3kxGVkEwiJjAGhzo3tNEQq63jPUCe0JpOGUMMuWNAHGgvkBRwN4x
         yStSJ1djNfo40hgWavPQpokZ83Pg8ZPwGdDGAgmCz1VdsgsfcLCRqKtw7rY27yYpuk5k
         0uWZReh+VommZ1oX8Hgd4IdXdLgb1XsZfUchY2dMOGSmMXx+Tqhr039t+RCG9wNUDuIa
         O/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729512033; x=1730116833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RPnI/3Gz1Y4IhHQKOjsXLrlBegzE9vzRcMrKpdABMo=;
        b=cKXzp4GF6fb8ZqOSXHPhzVPHiarGuCaa0pyYlolDEeKaRdML4dVLC+AjHQ+PRXe9mT
         IykqhzgmFHEx4vQlQnNeBnADENlJ7FcvMFiSPbB3jTKam5CqbGmin0zVfdS3PFosCfuF
         DHgFHpKyN+heWRU1UGMK1MJM/Ja0/QOV6oTnSKRYWa/lfBSL6Bekq/tNRgPw9UVa3yqR
         GIslIgtVwBXdKQwYLxrQigfzKN/KEWjxHoGpPT1Q1nuc3LTqZlV6UeuLolNsYVPesC7C
         e3JKULSIo/A7ElDK6amK9O/qzJLzpeNHd3v4OeB/s60cdjjKsiIG2XzXfuUjF+40vhH+
         3HTA==
X-Forwarded-Encrypted: i=1; AJvYcCW10q1J0+7jaRV3Ps6zNxbhsr77mxp+s97f2+GwKsZFaRPLtuE6rmcZfmzXTDK405Wa583LKtkhWohY47U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80C33AI+iELpXSR0tfDRm7pn2Sr/MEiqXuRPbagQFy2tCVNRH
	drdpiHsoA03WRAsA+01jw1XQnJnArRNzCapnfrRjMga4n31D7xW5NRH5WzaE7IsI1APrcrmz+Q=
	=
X-Google-Smtp-Source: AGHT+IExePDf+baL7jjY6BFnRt7a2CMIFgRxleUIxOO8K5rRpRCnjIukbvL698G8PB4qafOaxx6gC1grYA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3103:a9bb:c02c:c514])
 (user=elver job=sendgmr) by 2002:a05:6402:3888:b0:5cb:7780:f516 with SMTP id
 4fb4d7f45d1cf-5cb7780f61fmr57a12.8.1729512032815; Mon, 21 Oct 2024 05:00:32
 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:00:11 +0200
In-Reply-To: <20241021120013.3209481-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021120013.3209481-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241021120013.3209481-2-elver@google.com>
Subject: [PATCH 2/2] Revert "kasan: Disable Software Tag-Based KASAN with GCC"
From: Marco Elver <elver@google.com>
To: elver@google.com, Will Deacon <will@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit 7aed6a2c51ffc97a126e0ea0c270fab7af97ae18.

Now that __no_sanitize_address attribute is fixed for KASAN_SW_TAGS with
GCC, allow re-enabling KASAN_SW_TAGS with GCC.

Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrew Pinski <pinskia@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kasan | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 233ab2096924..98016e137b7f 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -22,11 +22,8 @@ config ARCH_DISABLE_KASAN_INLINE
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
-# GCC appears to ignore no_sanitize_address when -fsanitize=kernel-hwaddress
-# is passed. See https://bugzilla.kernel.org/show_bug.cgi?id=218854 (and
-# the linked LKML thread) for more details.
 config CC_HAS_KASAN_SW_TAGS
-	def_bool !CC_IS_GCC && $(cc-option, -fsanitize=kernel-hwaddress)
+	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
 
 # This option is only required for software KASAN modes.
 # Old GCC versions do not have proper support for no_sanitize_address.
@@ -101,7 +98,7 @@ config KASAN_SW_TAGS
 	help
 	  Enables Software Tag-Based KASAN.
 
-	  Requires Clang.
+	  Requires GCC 11+ or Clang.
 
 	  Supported only on arm64 CPUs and relies on Top Byte Ignore.
 
-- 
2.47.0.rc1.288.g06298d1525-goog


