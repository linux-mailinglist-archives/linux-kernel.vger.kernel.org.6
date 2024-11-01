Return-Path: <linux-kernel+bounces-392759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD09B97CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3651F21327
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F81CEE82;
	Fri,  1 Nov 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIZ9N9qT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888C1CF28A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486429; cv=none; b=mZeyaXazLvOFoU05h2dtayNtCzfDy6yX2otJayx5Ft7DasZqt6POK8jTH9+YTM4QW6W0VeXy5BUqmXZsW+5Bhiwim4G7RAlAYElwm9wVX7sVPZXiy5+WvB7p0jHB3iZbPiET9z0edFKjx9JyzIjeN6mnwlR1fk5aMPPmnENWTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486429; c=relaxed/simple;
	bh=yMw8MTT0I1LHUDAJJo8zzbA9SWPL1RqvGrM6i8mOkzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdOxJI5zVn1v5V6wQc6zBMUwnuOqKQeUMrQGBUZwYMIe41kXkpO33/EEGE871nbJQDjzxBMV1AUBp02GoHZ7wVF2JaQVwUagfb5hxQXsFti0ovHGUEH6pVgSJxHEWK5soG+4+wKMfRmcxvKwdy6MAg8rLm80n8L/0Kopq/hBoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIZ9N9qT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e7e73740so101125e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730486424; x=1731091224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvvOwVHZ4i14J6dT/7UuF/SG7t5JsDpEeQt8L7cE6aI=;
        b=eIZ9N9qTeiF1DZ4QkLf5XX8tBXm/qdhjLoR/8ncfHq7YHgaGyUUETrrEEzUvEh2gWF
         JY02CYg0efiPevPDQFmwalLvV8w6SWxDX8Uwps6qbFOBI9rU5/zKgWb1udkW7ljlKKPH
         mhH2G6/SDw3CIXTwzNYZUyJv2uXPthfCZoWfojhgJ11m/EhZC8bp9R7CdgDDwsqDkAmT
         jii0APOMlPSIONVfXdbL3yusmwXnMYUYNh0afMmDKcjRxIreS9v0ZDsh6fhMkb3lKZ8H
         36pT6zMBD9H5dRuGblCIXMnzkeQuFb+Vn/fuHqb7OKgklKujtuAWWY44FYbprVEZ3K21
         UwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486424; x=1731091224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvvOwVHZ4i14J6dT/7UuF/SG7t5JsDpEeQt8L7cE6aI=;
        b=hO87zpZqLEctM65eILtdWECBnT+11CCmYve+3ePZ8uvM+FxPYXl93EU9CxuwKR6Bw/
         ASNJZQujQ7+oYbflo/w1e15YZELEzHBgmZ50P8BWjqaSUzJvQA4Z3YRBV//NspTRTCx6
         KxcHtWothgMz6tm5uaUZZFX6zYvIY2b4KrjupXYUfix6XKhYNjVJ5COXFf8Ar8uZoRcr
         sJMOjubWI0TDh3/ylFrkYlmGJP6l7suC5Y+CNQmEq39cRhyiQ10AZPLIcGrbv791dReB
         Qdm3OJ1iL9TeKkokjLtqLP7ccMfMDwSILVeWPj5/brrGzuyCX/f2YD+SbPALtLZcerrS
         JMYg==
X-Forwarded-Encrypted: i=1; AJvYcCUlzFlcrOqFzEkVPVht+jZiFld3aBr3fccDvgejW6oCIuhln2DjRD3b0EWQaIFlbCl5rM0fWqnMPyl8494=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8E55Nc4U2pZkaSPtN/Rfx2B7+D70zif8UETDL8SfQ4fi51A7w
	hnX3hbH3Plai0S2RmpXhcmK5/eqVQvy+H8dF2xy2i46zV3DOnVjc
X-Google-Smtp-Source: AGHT+IH5fcF8BYzg6W5STIyYo1fvvKvw1DJ0Of90pEW3zppY2vMeDONybXD+PH9MpX9iAFVv+lPGvw==
X-Received: by 2002:a05:6512:a87:b0:53b:27ba:2d11 with SMTP id 2adb3069b0e04-53b7ece09bamr7284478e87.16.1730486423951;
        Fri, 01 Nov 2024 11:40:23 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc957cbsm646821e87.60.2024.11.01.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:40:23 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	elver@google.com
Cc: arnd@kernel.org,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	snovitoll@gmail.com
Subject: [PATCH 2/2] kasan: change kasan_atomics kunit test as KUNIT_CASE_SLOW
Date: Fri,  1 Nov 2024 23:40:11 +0500
Message-Id: <20241101184011.3369247-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101184011.3369247-1-snovitoll@gmail.com>
References: <20241101184011.3369247-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During running KASAN Kunit tests with CONFIG_KASAN enabled, the
following "warning" is reported by kunit framework:

	# kasan_atomics: Test should be marked slow (runtime: 2.604703115s)

It took 2.6 seconds on my PC (Intel(R) Core(TM) i7-7700K CPU @ 4.20GHz),
apparently, due to multiple atomic checks in kasan_atomics_helper().

Let's mark it with KUNIT_CASE_SLOW which reports now as:

	# kasan_atomics.speed: slow

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 mm/kasan/kasan_test_c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 3e495c09342e..3946fc89a979 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -2020,7 +2020,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_strings),
 	KUNIT_CASE(kasan_bitops_generic),
 	KUNIT_CASE(kasan_bitops_tags),
-	KUNIT_CASE(kasan_atomics),
+	KUNIT_CASE_SLOW(kasan_atomics),
 	KUNIT_CASE(vmalloc_helpers_tags),
 	KUNIT_CASE(vmalloc_oob),
 	KUNIT_CASE(vmap_tags),
-- 
2.34.1


