Return-Path: <linux-kernel+bounces-189190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7FA8CECD8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884E11C20D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26473158868;
	Fri, 24 May 2024 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7k/SUeK"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C985936
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716593292; cv=none; b=Gs0ae8ttM3eGlC9tVRB67IDJToXUI/ZRx52DbFIU0zomc9XEFtMwcczPr1Zco/8Cg0X5h6TOjL2CHmIiOJ9iqrPEKa+9DdxECqYOeQu/sTjUCTrHT1Ab+tTPlnvk3oL7c4lpuUUE3PxN5ZdyNjYpZwYqBlU7iVXVG0oAvUDQz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716593292; c=relaxed/simple;
	bh=EbKDHv3vQK0BUS+6DbxXjZTs6L+G1bPVjQ69PXzOF7c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=W7tie6gWxJO3eIWPCHgtsf/R9n9BZL07psYrDu64CHGw4ZSV4VDTKiyAdiIGqTCfbXwBR+Br2rJYvys3E9eQCJ3P13NcPjPSFUcXlvpbDeaEM/wxLmwxDjICpGSykIidXR9N9KNZesRxubZiku8ZbZCu8CFf7ZqleMH1rMDlnD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7k/SUeK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a7d28555bso1375289866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716593289; x=1717198089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bt12rpmlnyDZwJcOrWI/kuwJtRd0gfXYj/S0LGrI6gk=;
        b=Q7k/SUeKsQSL9Sa0k31eawrGAdSuLuxDU91xsvTEg3Lcp+JOxBmnXh1ontgv3vr0Gh
         YhdgsVoVTtGc7nWcZI6lUxffWf2JdC9iDDDBs6oj7w5S/OnZqK3X9aWni799F+4JUP/B
         Yt7wrnyIDQHrcaKK2bsvC68Ha3pY3gpAO6aJ7gHcSt64m2DgP6CWN5tucd6jgs5Fzj3n
         G8ytq/kAQelkA8bTujXEQMHrWcK6xu0WjhrWNTh24EKF/b1GlkPxXt/ewvxCO85aiokG
         T02uCmvSlak+oGQSg+CJ//4W+Gk6Hu+W80wV3otct5xieuPywhdMQefXnPlleZ8UFtlg
         IqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716593289; x=1717198089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bt12rpmlnyDZwJcOrWI/kuwJtRd0gfXYj/S0LGrI6gk=;
        b=pHHvDVkWNmbRmKhoxC+WZTQfhB3D4YnYhNtbmT1UcGjFIG7Fy99JbnWAsGXkTV6I3U
         H5zaCXgAJB+sHNahVp8ZCIuYBVhRyiZsHYrvvwjQt+tWXHHRWSjEl2vqwEYbUasPwK57
         G7xBLup2RozIxqDWxwaC0m78fKYKfSkJgUu5NScLtuYil4WyGk/YRnuSIhcKSlTQj70w
         OvmwNc6D2vz4CYHzIijbOegAUHQryUElWAzetYxsLLZuJEsrYtnY5g2m0XrawhJvbqLG
         ouE9MV4PL0H3pIJa9x6sierhnU2udqWQlgEsmrgLbVXHWLCmfTCUH4qfNUSiVHB9ITRr
         fEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvaltyVK0UY4DhQhopsw04aURO+KXBjstaamq6j2GHa1D3F9UPl2CB1VGPtYZyZThk3WvRcmbRMgczYqpKAyOrJGBkfmB9x9uaBxHM
X-Gm-Message-State: AOJu0YzRYn8yjXeQQNNhni1Cy0jpZzFMjyFMiMJGAwGqEEedH2S+3C2h
	jvvblXz+Oc+DIa5LdlwES3fVItXKBWJQDu8Asirdc99Jiwsx+pzX
X-Google-Smtp-Source: AGHT+IGpfslAbfzk7VNl/6HnBSnB0wsBEY6xQRIZ0SSqJz5JQtuVi6nolKCIvGFzY4MR5Ttl539EoQ==
X-Received: by 2002:a17:906:c214:b0:a5a:8b8c:6203 with SMTP id a640c23a62f3a-a62646d7f32mr231676666b.45.1716593289010;
        Fri, 24 May 2024 16:28:09 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817714sm191389366b.29.2024.05.24.16.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 16:28:08 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kmsan: introduce test_unpoison_memory()
Date: Sat, 25 May 2024 01:28:04 +0200
Message-Id: <20240524232804.1984355-1-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test to ensure that kmsan_unpoison_memory() works the same
as an unpoisoning operation added by the instrumentation. (Of course,
please correct me if I'm misunderstanding how these should work).

The test has two subtests: one that checks the instrumentation, and one
that checks kmsan_unpoison_memory(). Each subtest initializes the first
byte of a 4-byte buffer, then checks that the other 3 bytes are
uninitialized. Unfortunately, the test for kmsan_unpoison_memory() fails to
identify the 3 bytes as uninitialized (i.e., the line with the comment
"Fail: No UMR report").

As to my guess why this is happening: From kmsan_unpoison_memory(), the
backing shadow is indeed correctly overwritten in
kmsan_internal_set_shadow_origin() via `__memset(shadow_start, b, size);`.
Instead, the issue seems to stem from overwriting the backing origin, in
the following `origin_start[i] = origin;` loop; if we return before that
loop on this specific call to kmsan_unpoison_memory(), then the test
passes.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 mm/kmsan/kmsan_test.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 07d3a3a5a9c5..c3ab90df0abf 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -614,6 +614,30 @@ static void test_stackdepot_roundtrip(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/*
+ * Test case: ensure that kmsan_unpoison_memory() and the instrumentation work
+ * the same
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
+	a[0] = 0;                                     // Initialize a[0]
+	kmsan_check_memory((char *)&a[1], 3);         // Check a[1]--a[3]
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect)); // Pass: UMR report
+
+	report_reset();
+
+	kmsan_unpoison_memory((char *)&b[0], 1);  // Initialize b[0]
+	kmsan_check_memory((char *)&b[1], 3);     // Check b[1]--b[3]
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect)); // Fail: No UMR report
+}
+
 static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_uninit_kmalloc),
 	KUNIT_CASE(test_init_kmalloc),
@@ -637,6 +661,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_memset64),
 	KUNIT_CASE(test_long_origin_chain),
 	KUNIT_CASE(test_stackdepot_roundtrip),
+	KUNIT_CASE(test_unpoison_memory),
 	{},
 };
 
-- 
2.34.1


