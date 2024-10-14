Return-Path: <linux-kernel+bounces-363221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C651A99BF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933932812E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559A54503C;
	Mon, 14 Oct 2024 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF/Avfjx"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4FA231C9A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728880375; cv=none; b=RODp7oCORb2qmmmXwWTIh85KazR1wKNxv9A0wcM+8dnf1SEtbV7/ZA6WO9J8cy/DeURtm/LdKd0uwkR4n9r6h956+l3qkmSKb/9eZ++6OVtRLqu5FkllUwj/1ZK2aSNjb1xi8msUX49WKNj5PpMbMagpotP4QcCkHA3xaCjD3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728880375; c=relaxed/simple;
	bh=6DstLcntsNKP/w5Q3gCa0WUbUnJphgf47z+hUal9gHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B8ne6flRIxHHRwEgqoD6j+Id59g7OxsCO8rMDLX2/JgJ+7T8uoKRmllj5iLOPUG0D8jEfbCrOrAnmIKZTBn9/Z59lOTMkryjm7m1atlK/CQrOEzt+068JQMWT0AHLQE8ReMwS68bD2Cph76IniGl2S1aQXOv3ZMuyxnl54AjNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF/Avfjx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e29497f11cso780172a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728880374; x=1729485174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pUgdOnTMHFVpme+dAscM8QajZI3+HzzTGGVOmH4CSw=;
        b=GF/AvfjxGwwLMNcEJqO2EY1pjm/E96MxjGo3MfRtpGCVFYWYphzetyuSaGPI8QT/eS
         a4laRT1v54qmugPFFDYcYc7TBGlmiUdxcTxG9y76XwHiozdV1wRgVK9tLpmfbIN9kLyA
         ix4FIblz6l/5xAhR6WDT3bcWQeMKJ6uZjdvg/wii4ulrEJLzQQJzGaRbr/ha6HpL219o
         h2sXHxbUhcXx5oAhqkGloXJJEPohuImUygMHCWZTRKDLHr0qLdvtW3+6PIc2ZYMgw2al
         yQTyw8qzPTMKNriiUD0Uio02Bao57CXhkXhoMJxK4ZkE32VEQPczMopbxA9i8uZNjZh0
         zcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728880374; x=1729485174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pUgdOnTMHFVpme+dAscM8QajZI3+HzzTGGVOmH4CSw=;
        b=cfeyYPs80nKIyM6P2VKmJMY86Znl1NiHVKGA9H5TdkFHwXcGQBBgWxoIoh6QLOA7Zd
         lOpxa46KDCYjIVVecZyS8heUb7CjYTAObE1l3kCNxXJ7NE+HUEDDY4cgad13+HThtaKl
         1tyWbmdT6gjcqX+x/fdhY1TBb+Uu4RXyDZh2Eu3WQEKH9P1XLZupZINTA58cOOTVBRG2
         9QLRHSpx42Kvo/ylNrfi1QFDHXn2bdqaqut+cyKv+Fp0br45tqibnckDkSNzoVz7VtDe
         Lwdl2IP50N6GEXaP2Jxafc/u/WhFSmC013C7MxOA+eO+rFytPgEBvmnKWFm9+K7oNEsY
         8xkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgfMH33tSN+mHNgKA5PAqSYL0vHUTaU4wzner+AjXp4K/N6e4vf7yF2wl7ua9N5rxZZIhPMqdkuoJb0FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65UklKA5rVLPWZr0bIqT2oF9eGhmISBVP9VDl/rF3ueVZUaqR
	vcs7hUmjssoBodtW+2gyl20Vpd+JAwK/f7/ZrIAsEE4bQUZxzL3z
X-Google-Smtp-Source: AGHT+IG/v3hGxTQj4fb2jWcXCVV6MIYHvh0Vc+hOQIubMw63hLRQu8Zl9lue5f9meGkwXPD8g9at2A==
X-Received: by 2002:a17:90a:c7c4:b0:2e2:a60f:289e with SMTP id 98e67ed59e1d1-2e2f0811b98mr5091735a91.0.1728880373672;
        Sun, 13 Oct 2024 21:32:53 -0700 (PDT)
Received: from ice.. ([171.76.87.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5eeb082sm7700190a91.21.2024.10.13.21.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 21:32:53 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: ryabinin.a.a@gmail.com
Cc: andreyknvl@gmail.com,
	dvyukov@google.com,
	skhan@linuxfoundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>
Subject: [PATCH v2] kasan: add kunit tests for kmalloc_track_caller, kmalloc_node_track_caller
Date: Mon, 14 Oct 2024 09:41:36 +0530
Message-Id: <20241014041130.1768674-1-niharchaithanya@gmail.com>
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
v1->v2: Simplified the three separate out-of-bounds tests to a single test for
kmalloc_track_caller.

Link to v1: https://lore.kernel.org/all/20241013172912.1047136-1-niharchaithanya@gmail.com/

 mm/kasan/kasan_test_c.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..62efc1ee9612 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -213,6 +213,37 @@ static void kmalloc_node_oob_right(struct kunit *test)
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
+	size = 4096;
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
@@ -1958,6 +1989,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
 	KUNIT_CASE(kmalloc_node_oob_right),
+	KUNIT_CASE(kmalloc_track_caller_oob_right),
 	KUNIT_CASE(kmalloc_big_oob_right),
 	KUNIT_CASE(kmalloc_large_oob_right),
 	KUNIT_CASE(kmalloc_large_uaf),
-- 
2.34.1


