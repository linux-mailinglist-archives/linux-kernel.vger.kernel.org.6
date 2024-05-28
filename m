Return-Path: <linux-kernel+bounces-192132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE658D18E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C2B25ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3767416C697;
	Tue, 28 May 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRVMaajs"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552916C683
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893299; cv=none; b=WQ3CHnO3munLxAd9z7qA/m2li5iiw6V82Y09XI5fFjX8FzOMvH4IGqCrR8Ne+4N1luEpAX+4+zlmT5x9uEfREjWL8/C3R5IbN8fDHWBaLZmjhFiY7B/Nx+wxmAKwgtfFDEX5FHKg9cGdjGfa7ZOvIFPHekxscUF9d13+baWi5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893299; c=relaxed/simple;
	bh=/K9BBxive3sS8BvywGTbjSYc7BG14dKbtYRg2rAsHCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dQB6ETGuMo/iz2Bo+N192DiNweXzcreYnlcLsw6RB6MncsXheho260vnRTafX6GPtfJPc4RjJjmOaF2A1Lc2j5fMs4J7EuVhCi6BDrVcYxlbSXu+mvIHCUWGNDtfo5Kc+c9kfA772Y7JDcXqBZi86VF9jJBXNK5Zdj5cbWWEiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRVMaajs; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a6269ad7288so36272766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716893296; x=1717498096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTgy0iA5o4eiMLkf5DZA1XVIVBf+wcR0MiDC6AwIp5o=;
        b=sRVMaajs0W0/gEj/EsK5SqZhX6DzUfrb2gUGPP2P8/UvvauPmrVxYahJWVWzRm9g66
         4JBvmkd9aYZuMRNLhHYso7Hfq0NATZUky7aRhPjI7E+DidM4DJw6dLPvh/aKpV2kkzWt
         xyZw7iMm7WSSCfujH4dWPSYMDaLwoYTY5q7nyaHZLs0SpfPJzMa9zSj21ZAwGXhYj4bH
         v1F3utl6xtdGpdistGQ20Fm2OQRdCkX7tKVHGCZZ1AIP4YPH4vccHQWxZdp1k9eMDm7b
         sCHQuxiWYrOt27CLQZ6pTNIfSi222TAgUwTGKJl26/D7pdGX4/HsDyEjRHgsm6thIUfa
         kD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716893296; x=1717498096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTgy0iA5o4eiMLkf5DZA1XVIVBf+wcR0MiDC6AwIp5o=;
        b=CIAb/WT6Hkpshf//4APF+dQ/9qXShp4xi+cinFJMPYMr4L3S8JwEWL/fgYyGKHykZK
         8xDkSZQrwrpAVTtDMo+VocT3C5aG/3VS5+VbCPOroU51ItqFgSJyi4lz2akPcuXb+06r
         NWxxgSkH8zZdksLIjWBrPG+V6OvKNBhnxy/rI0TauSF75pdAYa71Ai4aj8byC+zvHztH
         RwNX1UjK8Nlo7SinM5joODJSXnJIp7OOb4/qRxDaNGugIm6oO7Hm78Plc9hJdrz6Idz1
         CfB21RSv/1b/4zPI78Nk5hNdk3sfcuIFermabgVy65WUQsedjsLunZp/1Y6MzKgLNp58
         hFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ81VgjMl+un/gGjyEywt9nbGUi0vC4vInUgmMD+UzgHMZ0HTOY5E7rSDKLih00U98ov5yL2jLfRBMqsPjzmYyZGxKwO7ZSPoOktwN
X-Gm-Message-State: AOJu0YyfBBejl6GnIfVLC7pfRX19PeZPgqKsnb7FnxU7HddAEJHkPouw
	q88qwcbsqPxeh485EHdLuvCirp5TwDTR1gb4Ss7Jb0v1NKsrcWodAovVqtzlcXI9MPAFz1LCMNv
	uWA==
X-Google-Smtp-Source: AGHT+IET+wqbCwieBcRKi1iNrPHSEZCrZnq1lsNKlL4c9ImOIZieVkTk1hpvy/CeH7ks20L//eHDRYvdSOU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:6416:417e:596:420a])
 (user=glider job=sendgmr) by 2002:a17:906:478c:b0:a61:9678:91e2 with SMTP id
 a640c23a62f3a-a62642e76e2mr1061566b.9.1716893295944; Tue, 28 May 2024
 03:48:15 -0700 (PDT)
Date: Tue, 28 May 2024 12:48:07 +0200
In-Reply-To: <20240528104807.738758-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528104807.738758-1-glider@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528104807.738758-2-glider@google.com>
Subject: [PATCH 2/2] kmsan: introduce test_unpoison_memory()
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: elver@google.com, dvyukov@google.com, akpm@linux-foundation.org, 
	bjohannesmeyer@gmail.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>

Add a regression test to ensure that kmsan_unpoison_memory() works the same
as an unpoisoning operation added by the instrumentation.

The test has two subtests: one that checks the instrumentation, and one
that checks kmsan_unpoison_memory(). Each subtest initializes the first
byte of a 4-byte buffer, then checks that the other 3 bytes are
uninitialized.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Link: https://lore.kernel.org/lkml/20240524232804.1984355-1-bjohannesmeyer@gmail.com/T/
[glider@google.com: change description, remove comment about failing test case]
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/kmsan_test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 07d3a3a5a9c52..018069aba92be 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -614,6 +614,32 @@ static void test_stackdepot_roundtrip(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/*
+ * Test case: ensure that kmsan_unpoison_memory() and the instrumentation work
+ * the same.
+ */
+static void test_unpoison_memory(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE_FN(expect, "test_unpoison_memory");
+	volatile char a[4], b[4];
+
+	kunit_info(
+		test,
+		"unpoisoning via the instrumentation vs. kmsan_unpoison_memory() (2 UMR reports)\n");
+
+	/* Initialize a[0] and check a[1]--a[3]. */
+	a[0] = 0;
+	kmsan_check_memory((char *)&a[1], 3);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+
+	report_reset();
+
+	/* Initialize b[0] and check b[1]--b[3]. */
+	kmsan_unpoison_memory((char *)&b[0], 1);
+	kmsan_check_memory((char *)&b[1], 3);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
 static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_uninit_kmalloc),
 	KUNIT_CASE(test_init_kmalloc),
@@ -637,6 +663,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_memset64),
 	KUNIT_CASE(test_long_origin_chain),
 	KUNIT_CASE(test_stackdepot_roundtrip),
+	KUNIT_CASE(test_unpoison_memory),
 	{},
 };
 
-- 
2.45.1.288.g0e0cd299f1-goog


