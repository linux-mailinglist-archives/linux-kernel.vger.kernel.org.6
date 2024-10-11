Return-Path: <linux-kernel+bounces-360456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97E3999B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B9A1C229D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F11F1315;
	Fri, 11 Oct 2024 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxzGNJNv"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38D804
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728618014; cv=none; b=fFYU0FXOdtEFBQ02cpLdY929/QM7ddGl/kgf1H5FmtCQQdkj/tikqy+/d53JbaH4/bK/dqbdAycEJEP0MAjrzX6T+lcZpbpoF7r5Kvnr7uVCszNYILxrFk0SDeyiPTYntWiUfh3J6dEhE8vTjTR9qhs2TiBrle6LTiS4W16KW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728618014; c=relaxed/simple;
	bh=B1qnHBWeG9pFb45tuI6HwIcCw7NR+q4b2HPnOk+JMzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vx8oI7GrMFFRHyKHGA76BEFcqmX7K4eXi9KOMqc5A0F9H1cCgO5IjtANZMGWTyLB7Y4xH5/MNbfcxC8A25tlK2LTcJdvPgTND177cPZlCo7uZCRd2PMHaa2DgXdgnI/TtbG066WZIPkpvQ9rU/HppNFdTvkndlUMTMKIcWXpJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxzGNJNv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e269db566so91453b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728618012; x=1729222812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0vNJQtq/0joVNg50nUAMn3bpfuOpVBsQDBObE5W4mI=;
        b=lxzGNJNvo/yNWek4mPdcSnFM7v1SbR2hft08+jkGDLMX58zP1VsJLokPhX3xmy2pfR
         330zXJHMgHJ0ykRBIjd1EPDNr4mfQjfv6pFtZLhzBK4v/Cm/IhhGzQ+y5BzOl+B2CwOv
         a7FWvzPPvg4arrdz2xmEqjwGLDwJkM+NcbfvTTkH3OCsOo2Y9a29nsGUO4jGxsHQp3lR
         v8IGIkisOC28hcYq3EtCkbhAaLnQjfDwKx24m/aNae2FcGZPBpnb/ZLKfL3WATwUOCMp
         WE4uEy6nPNat10WXwQJyM/qexqvkbkRvUUjxch9ISQfi9ZoDYmx6dTjRwG0vWeMWOWnh
         xY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728618012; x=1729222812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0vNJQtq/0joVNg50nUAMn3bpfuOpVBsQDBObE5W4mI=;
        b=ZIyiQFxZwXGFWaFiGQplrMLG3UnyiOiHs5YnG4n055SKDpgRFXUE9FKi0pJxfvCW9R
         S/FeY21omPup3pa0dDFFTp6MocNKAI0u74gnZAHfLY8u4UZ7BiTUQZTiQ5pFUzW1MG4R
         eTdrxTssv+DP06B8tAMClj2a06o6jGVXeDgnFs9BKTF6gjiIV7iI0NSUBh3WdB8KIA31
         XJuUrWy8aff0Zk1DB7q+gMrjbnti9FJFCPuVwdv2jZ1TKf0iCYusdrJxOSC3xhZj6VEX
         fCEvPjyQYnsJaxlrzm2xhXopPTxNl2HegJLCOenhA+lLCmzQ8ePPPBDsJXVP7QNh0SvG
         gmLw==
X-Forwarded-Encrypted: i=1; AJvYcCW4j86ARWmopz9MseH2iCnYcu4XcgVXY5XnDQPXD+/hpoxLmPyHJMXZqlNoazWi7gBwCawgGD/3g3M/74Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTOQGj0SoH9mxWnChnN/dDXNIqembieUT+x/2f5HtrUOF2BzPZ
	wsIg/RPCAOaK1xF9iXl2M9PsiKsm8PSMuWbzT9MjykTRSL1FrkGZ
X-Google-Smtp-Source: AGHT+IHO0iRTnYEyvP/kfCKj/tD0MJe+T2vXtJSfDWaWVMc+UY+r4eFWiFnIFG4lnlHf/34UTOsj5g==
X-Received: by 2002:a05:6a00:66c6:b0:717:9443:9c70 with SMTP id d2e1a72fcca58-71e37e4fa3fmr793355b3a.2.1728618012052;
        Thu, 10 Oct 2024 20:40:12 -0700 (PDT)
Received: from ice.. ([171.76.87.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba3a7sm1777651b3a.169.2024.10.10.20.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 20:40:11 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: ryabinin.a.a@gmail.com
Cc: andreyknvl@gmail.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] mm:kasan: fix sparse warnings: Should it be static?
Date: Fri, 11 Oct 2024 09:06:05 +0530
Message-Id: <20241011033604.266084-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel test robot had found sparse warnings: Should it be static,
for the variables kasan_ptr_result and kasan_int_result. These were
declared globally and three functions in kasan_test_c.c use them currently.
Add them to be declared within these functions and remove the global
versions of these.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312261010.o0lRiI9b-lkp@intel.com/
Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
---
 mm/kasan/kasan_test_c.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..d0d3a9eea80b 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -41,13 +41,6 @@ static struct {
 	bool async_fault;
 } test_status;
 
-/*
- * Some tests use these global variables to store return values from function
- * calls that could otherwise be eliminated by the compiler as dead code.
- */
-void *kasan_ptr_result;
-int kasan_int_result;
-
 /* Probe for console output: obtains test_status lines of interest. */
 static void probe_console(void *ignore, const char *buf, size_t len)
 {
@@ -1488,6 +1481,7 @@ static void kasan_memchr(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 24;
+	void *kasan_ptr_result;
 
 	/*
 	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
@@ -1514,6 +1508,7 @@ static void kasan_memcmp(struct kunit *test)
 	char *ptr;
 	size_t size = 24;
 	int arr[9];
+	int kasan_int_result;
 
 	/*
 	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
@@ -1539,6 +1534,8 @@ static void kasan_strings(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 24;
+	void *kasan_ptr_result;
+	int kasan_int_result;
 
 	/*
 	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
@@ -1585,6 +1582,8 @@ static void kasan_bitops_modify(struct kunit *test, int nr, void *addr)
 
 static void kasan_bitops_test_and_modify(struct kunit *test, int nr, void *addr)
 {
+	int kasan_int_result;
+
 	KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit(nr, addr));
 	KUNIT_EXPECT_KASAN_FAIL(test, __test_and_set_bit(nr, addr));
 	KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit_lock(nr, addr));
-- 
2.34.1


