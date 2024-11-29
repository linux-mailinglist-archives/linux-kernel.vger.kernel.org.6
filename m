Return-Path: <linux-kernel+bounces-425860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D705A9DEBF4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E0CB21E44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A71A2543;
	Fri, 29 Nov 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NK4Ql+DB"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2119F423;
	Fri, 29 Nov 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903959; cv=none; b=nCoPIWam6Trbbj/kG5YqkIgPGoCzQI1tvpF3e1eR35544+fd3Nd2c9MzrJivCDIdZfCBeRABFGJ8B7wmfGmtwwIRbaVDTbbz1BwZeyXSoJyx5PY+DCNeimIHHihXCyKhV/cv7Osb4MBHzWVCPACyqNPPtAb4vSXYn0dvdqhV1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903959; c=relaxed/simple;
	bh=65VjcgJ6W/nc4vLNB1ABhHSI9TMVRmLc7Ca4S3eBu00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7VvjFe6JoMJH0qIeRw6xvmTd0aNLjYPc8IfCASwW8kjzsZhB5wCZaMhx07epq0artwaYByGF2b4R57Xb1OEyKdR7RuWLi5AX3lHKe+aYfU265SEy7Ikr503IFaum/eoUOXr6T8G/JF2rOKZ4c2jaF4W3R36uj7ZqCsCaBVyj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NK4Ql+DB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21260209c68so21857405ad.0;
        Fri, 29 Nov 2024 10:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732903957; x=1733508757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j36qtzndjNfXOAp4ucPUgDYXmWkpix8KUSuouNFEhiE=;
        b=NK4Ql+DBqJmkP7OQhOvIo6yw8Tb3CDaAsEgLbzH6ONdGV1uGpcf6NZZGfZIFqip0vf
         UA1xMKv8wkS7DGP7GKq7UwaGoYkglDu/TgwqjAWn6qCPZKzWrttGcGUxkSYfVUlDYgd3
         C+ZubdKQ3LyUKa5GyFRLgpsjEcOtn7lQoft4SrRYKYVGo4N2RqHQ401X0KYr+ZbhWAFu
         XxN4aXamDyfewXJZv4ekzowj4KGPFqrxFh67lItuCqoiQt+zOTBj0I5dANyzijIKLwKq
         voWwAvK9mYI1B1nTjSA4mICkLFtBi0/DNt1BwmZ0i/DRueJhWEJ6uI/8wAeLFMBfvdfa
         F82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732903957; x=1733508757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j36qtzndjNfXOAp4ucPUgDYXmWkpix8KUSuouNFEhiE=;
        b=TUDAmchpEBunyBoWw+LByqap3OEuubIkJGITyYJW3m4xzEu73qs4kciohqvjAP/KNo
         2la1fwqWNTuWrKeRu8Af/PgvWP2vDR9ZrZfr5peDruZbfNWMmJKRnCFBTkW7dV8JBAOl
         TEBIoDDXdqHB+JFJtLYb8uPY0OAu7kBNvAL+14B6rrWAflLWXPlgs/b7ZAI2I+0d51QL
         4Tev/kj13i+rRgQsBXYyXKZJ0grzMswCfOleBf51na4Vs9NeCHF2qnkJh5S6GnNl4rG6
         GqrktIY1MotydhalzzQ0QdvXS0aLYIxbP9nGF3M+SXkglRUzNgowJffmITQp+PYOyuQh
         m1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkdxUW/m7Ik8x7/BvzXU2Z9hyShQS/wd9P3kBc1wIbiPWx02Abkw/eL5AltzBIQrl6HmC3n24G+BE=@vger.kernel.org, AJvYcCWuLdzbgz9j0RPuuH+yWhz0d/kooetn4g6PHjAApBGNCtQAAxNiESnxO8H5XezQnYMn5CYMZaUXVXr+oVyn@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGM83kedOB81tfc9Ixq8FyEjtDAh2oRQpvDyD04QRar0OngM1
	OCoI5bJIN1pFqECiSf5tY5h6Gb1RSSyVMKzrDd1Q3ZfLLuA/VIvx
X-Gm-Gg: ASbGnctaEz3YlVnlbp2fW+Pe31H7TZj2izbQJxJOmwY3qWiXkijgDj/rI+zum4S/9Mm
	olvaOhNIlUoERjF+52GW4SIRzhbj0mMBRrHgl5KkdmlsCTOrUMx6KJkQQnj1X2Cl6s44Zqn39wi
	m+JMFNHbUuNbRF9GK5SN2GMivUDS3d4BuNh16mWbPd/8PHgwN1nutN6sNa9gdJqhxbomDptznyl
	lXEpGdhMNcw9wmK7nhnrTsmytaYR+k8+wOCMxojHj0b9gvviEE+N3Q5Ptiq/K4QahLazq1FHrOi
	KM9w
X-Google-Smtp-Source: AGHT+IGfWF1zsFEaT/OEkL2tM23xJkcNnTjYHquCHSMTXSLbO2BgDhFqVHJxzAIQe2wbP9ZIzC7ZHg==
X-Received: by 2002:a17:902:dac4:b0:20b:6c1e:1e13 with SMTP id d9443c01a7336-2151d884f23mr105771405ad.23.1732903956938;
        Fri, 29 Nov 2024 10:12:36 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761474sm3760595b3a.32.2024.11.29.10.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:12:36 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	corbet@lwn.net
Cc: geert@linux-m68k.org,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/4] lib/test_min_heap: Use inline min heap variants to reduce attack vector
Date: Sat, 30 Nov 2024 02:12:20 +0800
Message-Id: <20241129181222.646855-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129181222.646855-1-visitorckw@gmail.com>
References: <20241129181222.646855-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To address concerns about increasing the attack vector, remove the
select MIN_HEAP dependency from TEST_MIN_HEAP in Kconfig.debug.

Additionally, all min heap test function calls in lib/test_min_heap.c
are replaced with their inline variants. By exclusively using inline
variants, we eliminate the need to enable CONFIG_MIN_HEAP for testing
purposes.

Link: https://lore.kernel.org/lkml/CAMuHMdVO5DPuD9HYWBFqKDHphx7+0BEhreUxtVC40A=8p6VAhQ@mail.gmail.com
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/Kconfig.debug   |  1 -
 lib/test_min_heap.c | 30 +++++++++++++++---------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f340017585c5..83a25c3220c9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2269,7 +2269,6 @@ config TEST_LIST_SORT
 config TEST_MIN_HEAP
 	tristate "Min heap test"
 	depends on DEBUG_KERNEL || m
-	select MIN_HEAP
 	help
 	  Enable this to turn on min heap function tests. This test is
 	  executed only once during system boot (so affects only boot time),
diff --git a/lib/test_min_heap.c b/lib/test_min_heap.c
index e6fbb798558b..a9c4a74d3898 100644
--- a/lib/test_min_heap.c
+++ b/lib/test_min_heap.c
@@ -32,7 +32,7 @@ static __init int pop_verify_heap(bool min_heap,
 	int last;
 
 	last = values[0];
-	min_heap_pop(heap, funcs, NULL);
+	min_heap_pop_inline(heap, funcs, NULL);
 	while (heap->nr > 0) {
 		if (min_heap) {
 			if (last > values[0]) {
@@ -48,7 +48,7 @@ static __init int pop_verify_heap(bool min_heap,
 			}
 		}
 		last = values[0];
-		min_heap_pop(heap, funcs, NULL);
+		min_heap_pop_inline(heap, funcs, NULL);
 	}
 	return err;
 }
@@ -69,7 +69,7 @@ static __init int test_heapify_all(bool min_heap)
 	int i, err;
 
 	/* Test with known set of values. */
-	min_heapify_all(&heap, &funcs, NULL);
+	min_heapify_all_inline(&heap, &funcs, NULL);
 	err = pop_verify_heap(min_heap, &heap, &funcs);
 
 
@@ -78,7 +78,7 @@ static __init int test_heapify_all(bool min_heap)
 	for (i = 0; i < heap.nr; i++)
 		values[i] = get_random_u32();
 
-	min_heapify_all(&heap, &funcs, NULL);
+	min_heapify_all_inline(&heap, &funcs, NULL);
 	err += pop_verify_heap(min_heap, &heap, &funcs);
 
 	return err;
@@ -102,14 +102,14 @@ static __init int test_heap_push(bool min_heap)
 
 	/* Test with known set of values copied from data. */
 	for (i = 0; i < ARRAY_SIZE(data); i++)
-		min_heap_push(&heap, &data[i], &funcs, NULL);
+		min_heap_push_inline(&heap, &data[i], &funcs, NULL);
 
 	err = pop_verify_heap(min_heap, &heap, &funcs);
 
 	/* Test with randomly generated values. */
 	while (heap.nr < heap.size) {
 		temp = get_random_u32();
-		min_heap_push(&heap, &temp, &funcs, NULL);
+		min_heap_push_inline(&heap, &temp, &funcs, NULL);
 	}
 	err += pop_verify_heap(min_heap, &heap, &funcs);
 
@@ -135,22 +135,22 @@ static __init int test_heap_pop_push(bool min_heap)
 	/* Fill values with data to pop and replace. */
 	temp = min_heap ? 0x80000000 : 0x7FFFFFFF;
 	for (i = 0; i < ARRAY_SIZE(data); i++)
-		min_heap_push(&heap, &temp, &funcs, NULL);
+		min_heap_push_inline(&heap, &temp, &funcs, NULL);
 
 	/* Test with known set of values copied from data. */
 	for (i = 0; i < ARRAY_SIZE(data); i++)
-		min_heap_pop_push(&heap, &data[i], &funcs, NULL);
+		min_heap_pop_push_inline(&heap, &data[i], &funcs, NULL);
 
 	err = pop_verify_heap(min_heap, &heap, &funcs);
 
 	heap.nr = 0;
 	for (i = 0; i < ARRAY_SIZE(data); i++)
-		min_heap_push(&heap, &temp, &funcs, NULL);
+		min_heap_push_inline(&heap, &temp, &funcs, NULL);
 
 	/* Test with randomly generated values. */
 	for (i = 0; i < ARRAY_SIZE(data); i++) {
 		temp = get_random_u32();
-		min_heap_pop_push(&heap, &temp, &funcs, NULL);
+		min_heap_pop_push_inline(&heap, &temp, &funcs, NULL);
 	}
 	err += pop_verify_heap(min_heap, &heap, &funcs);
 
@@ -163,7 +163,7 @@ static __init int test_heap_del(bool min_heap)
 			 -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
 	struct min_heap_test heap;
 
-	min_heap_init(&heap, values, ARRAY_SIZE(values));
+	min_heap_init_inline(&heap, values, ARRAY_SIZE(values));
 	heap.nr = ARRAY_SIZE(values);
 	struct min_heap_callbacks funcs = {
 		.less = min_heap ? less_than : greater_than,
@@ -172,9 +172,9 @@ static __init int test_heap_del(bool min_heap)
 	int i, err;
 
 	/* Test with known set of values. */
-	min_heapify_all(&heap, &funcs, NULL);
+	min_heapify_all_inline(&heap, &funcs, NULL);
 	for (i = 0; i < ARRAY_SIZE(values) / 2; i++)
-		min_heap_del(&heap, get_random_u32() % heap.nr, &funcs, NULL);
+		min_heap_del_inline(&heap, get_random_u32() % heap.nr, &funcs, NULL);
 	err = pop_verify_heap(min_heap, &heap, &funcs);
 
 
@@ -182,10 +182,10 @@ static __init int test_heap_del(bool min_heap)
 	heap.nr = ARRAY_SIZE(values);
 	for (i = 0; i < heap.nr; i++)
 		values[i] = get_random_u32();
-	min_heapify_all(&heap, &funcs, NULL);
+	min_heapify_all_inline(&heap, &funcs, NULL);
 
 	for (i = 0; i < ARRAY_SIZE(values) / 2; i++)
-		min_heap_del(&heap, get_random_u32() % heap.nr, &funcs, NULL);
+		min_heap_del_inline(&heap, get_random_u32() % heap.nr, &funcs, NULL);
 	err += pop_verify_heap(min_heap, &heap, &funcs);
 
 	return err;
-- 
2.34.1


