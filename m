Return-Path: <linux-kernel+bounces-364620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A2B99D705
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D76B213E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61B11CB330;
	Mon, 14 Oct 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYESE+Xz"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34FF1CACFC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728932938; cv=none; b=Eqf5XwLyJ6zAHbCCcV/v/Yv+Qw/ssY780SZY21En/fIuVctVegjB/8Uv8rhKrfpiZzxJEbdHcVKQ18tVPckh754/QNmN6L7zrUhGE6eZhUMoazAef1Tmu7Klo3rOMeVbTxHZ54mllngs8WcOPiqB3bcjEwo0VlFepVlj6o7ct8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728932938; c=relaxed/simple;
	bh=cpZh4NBfiKPeA9AR0GaISnTFGTZ9w1x0tTKHjlKT45k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hp1AudfGNgCkXgEkSJ0FKRimmHn7/T5YihV2zTIzgb5yjNTqHg3/kRmIwOUd0r1ZS2i0QfsqmELqCKxJH4QZmY81FN58c2X9YKymrNjRUxnyF+AwJryYsWrsiTAIuXlHZuMJZwlhzfaJhR6OR4AZHeVqW+4bc6Jsu/A254zXISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYESE+Xz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db3e962c2aso333318a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728932936; x=1729537736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwggpQA75Ji4L7zAdfPb87y+vAtwZU5Fx5cuVPrXzvI=;
        b=bYESE+XzVNPUR7ANMiUr4r0THDUlAq5cYFN9LCg+8Zv5QKMUSiita0g197uWXsVBaw
         wYit0wvBkMhSPuGjkmqEn6OfR5y/1UcwZp5T9En5ejOlngxlzvcwjhRktFXa4ewMJJcd
         vL/lXc3k9aolHgshTZTyielw+ar9QmUU84zd/xbqncRlCpNbu5/tKIQ+gK2dv5XrgMFT
         gOeQqgmcAymRj6ALSmg+76v/ua2xaedVMPmZmBjIhplJZwEoCBQwqCmQ6xrdg2UxWfH9
         bi7g1FAf5LRoFv4CV+UY0YaT+x82MmC9jNDy4WloWqfsIvCOkTUV36MqdSJsIFpBA4HA
         bU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728932936; x=1729537736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwggpQA75Ji4L7zAdfPb87y+vAtwZU5Fx5cuVPrXzvI=;
        b=efJIUwlc44RZbcmmDXzwLmIviYgx7gF9vXbJyecPpUW5NeNPEcqJcSbjTLZpGF3JKx
         7PqghFLTxngc733pvEMFXsxNh9n+8yMwGSPslAKwFsVZiNtbc4mU3ctAti38bFoxdlPw
         LV3lIRQLSoTl+pBkjE7Gfg5Se7WDXifoA+sfEmHyMzW8codKpimhkwmgWI9o1dy5D+pi
         /5i9D/4Pv4sLStSLN4kn79H8WY2SrtHb8jebOzlQXTe+DFf0JD0CCYuqEAa6KsjtGHxf
         HCS+1Y3CdXaKhaKEi0o8TdKCHwXnpcvK1NfPOZsAOgHeOVQRr3tHThCYdV0hZpt0Bhgp
         qYRg==
X-Forwarded-Encrypted: i=1; AJvYcCXYiTgK89F3Y29f5us46+9tCUP1evQGxePwi/ZHsyH/4aUSksqK7epfSSjA8CO7F/WliDwijm+hpEE844c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqXMugLjypgNUbAZCxVbeIE4TFQx83Wu/Xen8K/4ifTC6iNUB9
	RtJi3fClwnw5Y11fXWiLWExAnWMNj106qOJLr8WomPxSXi8uh9/0
X-Google-Smtp-Source: AGHT+IH7I+prz8s3/btBQk/lhkhhtOiGMlV4NvsjkCqf29YOl5868G/eXwBOFn/j7VnT2qB7l2uniQ==
X-Received: by 2002:a05:6a21:9998:b0:1cf:5471:bbe1 with SMTP id adf61e73a8af0-1d8bd017b40mr8872998637.8.1728932935999;
        Mon, 14 Oct 2024 12:08:55 -0700 (PDT)
Received: from ice.. ([171.76.87.218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea775bf3easm2895833a12.94.2024.10.14.12.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:08:55 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: ryabinin.a.a@gmail.com
Cc: andreyknvl@gmail.com,
	dvyukov@google.com,
	skhan@linuxfoundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>
Subject: [PATCH v3] kasan: add kunit tests for kmalloc_track_caller, kmalloc_node_track_caller
Date: Tue, 15 Oct 2024 00:31:30 +0530
Message-Id: <20241014190128.442059-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kunit tests for kmalloc_track_caller and kmalloc_node_track_caller
were missing in kasan_test_c.c, which check that these functions poison
the memory properly.

Add a Kunit test:
-> kmalloc_tracker_caller_oob_right(): This includes out-of-bounds 
   access test for kmalloc_track_caller and kmalloc_node_track_caller.

Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=216509
---
v1->v2: Simplified the three separate out-of-bounds tests to a single
test for kmalloc_track_caller.

v2->v3: Used the same size for both the test cases.

Link to v1: https://lore.kernel.org/all/20241013172912.1047136-1-niharchaithanya@gmail.com/
Link to v2: https://lore.kernel.org/all/20241014041130.1768674-1-niharchaithanya@gmail.com/

 mm/kasan/kasan_test_c.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..7e7076e71de0 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -213,6 +213,36 @@ static void kmalloc_node_oob_right(struct kunit *test)
 	kfree(ptr);
 }
 
+static void kmalloc_track_caller_oob_right(struct kunit *test)
+{
+	char *ptr;
+	size_t size = 128 - KASAN_GRANULE_SIZE;
+
+	/*
+	 * Check that KASAN detects out-of-bounds access for object allocated via
+	 * kmalloc_track_caller().
+	 */
+	ptr = kmalloc_track_caller(size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
+	OPTIMIZER_HIDE_VAR(ptr);
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 'y');
+
+	kfree(ptr);
+
+	/*
+	 * Check that KASAN detects out-of-bounds access for object allocated via
+	 * kmalloc_node_track_caller().
+	 */
+	ptr = kmalloc_node_track_caller(size, GFP_KERNEL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
+	OPTIMIZER_HIDE_VAR(ptr);
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 'y');
+
+	kfree(ptr);
+}
+
 /*
  * Check that KASAN detects an out-of-bounds access for a big object allocated
  * via kmalloc(). But not as big as to trigger the page_alloc fallback.
@@ -1958,6 +1988,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
 	KUNIT_CASE(kmalloc_node_oob_right),
+	KUNIT_CASE(kmalloc_track_caller_oob_right),
 	KUNIT_CASE(kmalloc_big_oob_right),
 	KUNIT_CASE(kmalloc_large_oob_right),
 	KUNIT_CASE(kmalloc_large_uaf),
-- 
2.34.1


