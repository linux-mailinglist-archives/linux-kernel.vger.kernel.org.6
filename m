Return-Path: <linux-kernel+bounces-362878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C28E99BA8E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FA0B21513
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD82C146A83;
	Sun, 13 Oct 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkxTVsI2"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80913D508
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728840734; cv=none; b=EBaDxSOQI+7LJ64FahHBPVZhoUgoVmIRXmTh+yqEZxoJZuLUDU5gZjzSZt9lATnhL5cPwF3uW1RdXfaCbI5Rk2HV76RJEXFRj8GlZJ4mdjKrMM0QLjcD9DKJIqfX5lwGS7+htGkkZD2Dp4YtrZQrXjuPVisDTN84WP5IAZAc9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728840734; c=relaxed/simple;
	bh=cQVU6f8wnCL2ILiNK36kPei0H3TsfcSjVIyXM4qinDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GIG8Z9bbLfBAR1gl50RWIb+uApePD3PtRNHPVZJYiem1BaQ+4NH9H8cbzPqvFbRzr6Q0FLwt+X69Pi/ZKNXtJkHKpyaqkhNwfhJYqFSc2f3G9x3J3KiLXP4/gZZZHZLiBkzWVF7NM2rO+kTQdq3GgOksN+JLsDdsgkLrrGqnLIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkxTVsI2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2c2a17aa4so711518a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 10:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728840732; x=1729445532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxwHOtTydZ5pI077ASwiQ1w7C2c7W/JrF5E7on+jchM=;
        b=YkxTVsI2KIjxC5w4Sp2ZvE3de/0eppzhFx3gBIfaa1FDw9QJql+XVElHAPkNJ5FYjE
         1IgvnSvQa3+F7ZNdfaE/7TYl/Mv+W1z/p0CiS3IqSNamhaWRteFsrMUAAWuMNfngrW0A
         Iict4uDRoVycZ0gLSPqhYUfeV3lBuxX/2G4/LDKKQEFmZtCfa6gnNgcCDCtXr2lBX1XR
         ltts0ZSITMu56155pQ1LsV3rHWRXynUWovau08E0sbdv8ZcuEHP1t6AKP4RXM6mmPDqP
         TFp3mEAlv9h6kMcKtmNzjW6kvRe5rpotsqPgbjxrz9QEZH+ygFIyCV/xAbrODNbG5v4Q
         AFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728840732; x=1729445532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxwHOtTydZ5pI077ASwiQ1w7C2c7W/JrF5E7on+jchM=;
        b=wsMfzRmT+V6MuW3A5hwrOfBO0l/epx1AqJoOeOWIkCCsJczAdXxC2GwRIIZUgXAzhW
         HdAl+Eo+Lh0ZfYG9ddZlrYQZo7br2I2nZemWDuat/8k/8EfZZjMitLRg43o1hi9yanBv
         bIBamzvsqg855b8sDEz245EOSRIGjfztyb87ez7G7zZYF7ulC6Oyvld0SMZOh4DqpU2I
         YRojwEmuGl/QaAa6DEeHy6maE5CSKZSUsWFIhqLuHVpPYHWxMKkDqaND+W3VJPrMd8Xl
         UyfTsu083itqUreJ4W2ZpbvzK9w+R6NxVOjPtWb8i7MnNscfTGswwtUPppjui2hRHgB6
         +/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoio6WpSfi+zqOkDKmykBZ0/9brQ8FjI/6MEjeQ4WrbdF1aHqlxnDTVbJnWbq5uyA1UpwF1ZL1W2oI1zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXu7/ncRQhSY7h1bqTEzWFi2oo4Iwpw8Vdy7FfVwJHTt/jO0G
	55V7tM1l+iiAAZQQDJr6KbiviS3UEfEGYMkMEGnxrjZRQFzCP0Q4
X-Google-Smtp-Source: AGHT+IErt0UkozSWp0zld/TsECPH2kfNIanQwDugYB8qAvnJJXuX5NW/gc396WnChO0A7O9Zv1WGsQ==
X-Received: by 2002:a05:6a20:3d89:b0:1cf:4845:67f with SMTP id adf61e73a8af0-1d8bd014f12mr6349940637.9.1728840732003;
        Sun, 13 Oct 2024 10:32:12 -0700 (PDT)
Received: from ice.. ([171.76.87.218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea6bc08282sm2240999a12.49.2024.10.13.10.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 10:32:11 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: ryabinin.a.a@gmail.com
Cc: andreyknvl@gmail.com,
	dvyukov@google.com,
	skhan@linuxfoundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>
Subject: [PATCH] kasan: add kunit tests for kmalloc_track_caller, kmalloc_node_track_caller
Date: Sun, 13 Oct 2024 22:59:13 +0530
Message-Id: <20241013172912.1047136-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kunit tests for kmalloc_track_caller and kmalloc_node_track_caller
are missing in kasan_test_c.c, which check that these functions poison
the memory properly.

Add a Kunit test:
-> kmalloc_tracker_caller_oob_right(): This includes unaligned, aligned and
   beyond-aligned out-of-bounds access test for kmalloc_track_caller and
   out-of-bounds access test for kmalloc_node_track_caller.

Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
---
 mm/kasan/kasan_test_c.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..b418bdff5bdb 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -213,6 +213,39 @@ static void kmalloc_node_oob_right(struct kunit *test)
 	kfree(ptr);
 }
 
+static void kmalloc_track_caller_oob_right(struct kunit *test)
+{
+	char *ptr;
+	size_t size = 128 - KASAN_GRANULE_SIZE - 5;
+
+	/*
+	 * Check that KASAN detects out-of-bounds access for object allocated via
+	 * kmalloc_track_caller().
+	 */
+	ptr = kmalloc_track_caller(size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
+	OPTIMIZER_HIDE_VAR(ptr);
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 'x');
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + 5] = 'y');
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =
+					ptr[size + KASAN_GRANULE_SIZE + 5]);
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
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = ptr[size]);
+	kfree(ptr);
+}
+
 /*
  * Check that KASAN detects an out-of-bounds access for a big object allocated
  * via kmalloc(). But not as big as to trigger the page_alloc fallback.
@@ -1958,6 +1991,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
 	KUNIT_CASE(kmalloc_node_oob_right),
+	KUNIT_CASE(kmalloc_track_caller_oob_right),
 	KUNIT_CASE(kmalloc_big_oob_right),
 	KUNIT_CASE(kmalloc_large_oob_right),
 	KUNIT_CASE(kmalloc_large_uaf),
-- 
2.34.1


