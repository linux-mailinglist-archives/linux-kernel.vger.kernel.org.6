Return-Path: <linux-kernel+bounces-351283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BAD990F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213831C22FED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124621EBA1F;
	Fri,  4 Oct 2024 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZRUuA4d"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82381DD863
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067645; cv=none; b=hdSM5ZwmEix3LVdbHEE2gEU6iKH+Lo/Rvzjdj74+wwFzcgVpOto4t5WpPIlk7CcfvqxWqArrGKvUBelZhhaEcLUKg9cT4CCDMz5OUijnDarqZmuClxXPxFafp/jWLgOBD6H00LMb+WwZrTEagSDGlGgyKj/z5+4K4o5np5itQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067645; c=relaxed/simple;
	bh=V03GFNzD11CECPmUTDDQ0S68l5jzC/7sxNfkJ3eRzXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j7f9gcdSU4W+lUGGUniTzFuSmru7Qf1qTdeXssCZBaqgwGURtOInIptukUkU8/aOyExOVbWNH8EzRT/4ghEHyWkVfqn0RPhP52H6zkHK7Fj++x8fFxEcq3aydsAKsy8PZvl6xi+Wg+rt0fu7cVskvmnuugdl6BUtVplb+d5JCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZRUuA4d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-207115e3056so23343285ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728067643; x=1728672443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFdjl4nnT3iOUyZk1xlx2SlCDfY3Jc7r1BLQPkD7dFI=;
        b=VZRUuA4dK1fFASt+Ls8P0TkEMHL9WuLae89f50D0OZmGvHlPc9m4iwCQ01XF10en2N
         EOcuX0/a4wmb0p/jMuGB4viMr42seeMieiviykh2fqqjcOQDyOZ2P7LoiyTRNNN4M/4q
         0c8ZVD7ouz1ZmL1sUKVdmupoJssoZMbdkxlQObujqMnXRlxMamPgw8tWdQdYBuxetO9I
         33xCpXjmfH+huWlnU7jXuS5XypaoFuPeROCKxgSUh9LqUL9G7LayEVotk5OQeBhfH0eC
         DiTyrHshSbH9isiGS2sLFS856Qz604YUJ102j/1CLsL0yGVcYQFab9D2rxCRzJTMB0Ys
         X8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728067643; x=1728672443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFdjl4nnT3iOUyZk1xlx2SlCDfY3Jc7r1BLQPkD7dFI=;
        b=hel8raA4ikTHg+S+Tqua0l/Qsg1rFF/IQQnGVizvGEV+16513RzRIe5X21KDCDXOz0
         +WUhglyFlHpprJeR/yrCbMOAnJ/ozWX9J6BffD6dGOBhVOdgt50t36Tk/8WA3LAhK8/o
         Pv7aNlsDoAY3vxBvu3O7ppfaghY3w0jg+uCMNbj//6SYeMrZbZK7zkaVY030ZvmCpQ5y
         I44TrnLvr1vYQEkKwYSCdaAfbXV880AAd/J2aAuKr2eX0fqXZ6D2+pdmyqxNt7t+wP48
         JeixuKyQgOjoZZZvgsbjStj5n6jPdJvSz2j6OI+SeCzSS3cWHwfRljYnKQ72r3w0Dv6P
         Luqg==
X-Forwarded-Encrypted: i=1; AJvYcCWR/pKNcf9fU4TYBLX7eHkd1Gyj89VSK0kH9I219r2+9ybqZQfU0kjYpU7eNbW+YSz9Q4lLuZcAyjQgzls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJje3JbNboNGb9pCWQ12zLU/f0B+RgibO0oEx3EH4BfxoeaBw
	HF2y1Ux9H3j3qdoVkuMjmezH1TdtRJidESmlD+ygiDlt5MQ4+NNvOs4WOQ==
X-Google-Smtp-Source: AGHT+IE0R45d5ZL7xzZwuhvtXQOf1xTSCs3ElYiEDg7HQMY+coEv+ZPf5ecm+PFaWRxFNyOKSd8k8g==
X-Received: by 2002:a17:902:fb0b:b0:20b:9224:11c9 with SMTP id d9443c01a7336-20bff047bbfmr44710025ad.39.1728067643119;
        Fri, 04 Oct 2024 11:47:23 -0700 (PDT)
Received: from hilb.unicamp.br ([143.106.58.82])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e9f678202asm314295a12.0.2024.10.04.11.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 11:47:22 -0700 (PDT)
From: =?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
To: akpm@linux-foundation.org,
	davidgow@google.com,
	linux-kernel@vger.kernel.org,
	rmoar@google.com
Cc: kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
Subject: [PATCH v4] lib/math: Add int_log test suite
Date: Fri,  4 Oct 2024 18:47:13 +0000
Message-ID: <20241004184713.25262-1-brunofrancadevsec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit introduces KUnit tests for the intlog2 and intlog10
functions, which compute logarithms in base 2 and base 10, respectively.
The tests cover a range of inputs to ensure the correctness of these
functions across common and edge cases.

Signed-off-by: Bruno Sobreira França <brunofrancadevsec@gmail.com>
---
Changes in v4:
  - Rebase on top of linux-kselftest kunit branch
  - Fix spelling mistake in a literal string
Changes in v3:
  - Fix checkpatch issues reintroduced in v2
Changes in v2:
  - Fix the overflow warning reported by the kernel test robot
---
 lib/Kconfig.debug              | 11 +++++
 lib/math/tests/Makefile        |  1 +
 lib/math/tests/int_log_kunit.c | 75 ++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 lib/math/tests/int_log_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d6c979f0..1d7dc494c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3104,3 +3104,14 @@ config INT_POW_KUNIT_TEST
 	  function.
 
 	  If unsure, say N
+
+config INT_LOG_KUNIT_TEST
+        tristate "Integer log (int_log) test" if !KUNIT_ALL_TESTS
+        depends on KUNIT
+        default KUNIT_ALL_TESTS
+        help
+          This option enables the KUnit test suite for the int_log library, which
+          provides two functions to compute the integer logarithm in base 2 and
+          base 10, called respectively as intlog2 and intlog10.
+
+          If unsure, say N
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index f9a0a0e6b..89a266241 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -2,5 +2,6 @@
 
 obj-$(CONFIG_DIV64_KUNIT_TEST)    += div64_kunit.o
 obj-$(CONFIG_INT_POW_KUNIT_TEST)  += int_pow_kunit.o
+obj-$(CONFIG_INT_LOG_KUNIT_TEST)  += int_log_kunit.o
 obj-$(CONFIG_MULDIV64_KUNIT_TEST) += mul_u64_u64_div_u64_kunit.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational_kunit.o
diff --git a/lib/math/tests/int_log_kunit.c b/lib/math/tests/int_log_kunit.c
new file mode 100644
index 000000000..40b5a6813
--- /dev/null
+++ b/lib/math/tests/int_log_kunit.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/int_log.h>
+
+struct test_case_params {
+	u32 value;
+	unsigned int expected_result;
+	const char *name;
+};
+
+
+/* The expected result takes into account the log error */
+static const struct test_case_params intlog2_params[] = {
+	{0, 0, "Log base 2 of 0"},
+	{1, 0, "Log base 2 of 1"},
+	{2, 16777216, "Log base 2 of 2"},
+	{3, 26591232, "Log base 2 of 3"},
+	{4, 33554432, "Log base 2 of 4"},
+	{8, 50331648, "Log base 2 of 8"},
+	{16, 67108864, "Log base 2 of 16"},
+	{32, 83886080, "Log base 2 of 32"},
+	{U32_MAX, 536870911, "Log base 2 of MAX"},
+};
+
+static const struct test_case_params intlog10_params[] = {
+	{0, 0, "Log base 10 of 0"},
+	{1, 0, "Log base 10 of 1"},
+	{6, 13055203, "Log base 10 of 6"},
+	{10, 16777225, "Log base 10 of 10"},
+	{100, 33554450, "Log base 10 of 100"},
+	{1000, 50331675, "Log base 10 of 1000"},
+	{10000, 67108862, "Log base 10 of 10000"},
+	{U32_MAX, 161614247, "Log base 10 of MAX"}
+};
+
+static void get_desc(const struct test_case_params *tc, char *desc)
+{
+	strscpy(desc, tc->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+
+KUNIT_ARRAY_PARAM(intlog2, intlog2_params, get_desc);
+
+static void intlog2_test(struct kunit *test)
+{
+	const struct test_case_params *tc = (const struct test_case_params *)test->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, intlog2(tc->value));
+}
+
+KUNIT_ARRAY_PARAM(intlog10, intlog10_params, get_desc);
+
+static void intlog10_test(struct kunit *test)
+{
+	const struct test_case_params *tc = (const struct test_case_params *)test->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, intlog10(tc->value));
+}
+
+static struct kunit_case math_int_log_test_cases[] = {
+	KUNIT_CASE_PARAM(intlog2_test, intlog2_gen_params),
+	KUNIT_CASE_PARAM(intlog10_test, intlog10_gen_params),
+	{}
+};
+
+static struct kunit_suite int_log_test_suite = {
+	.name = "math-int_log",
+	.test_cases =  math_int_log_test_cases,
+};
+
+kunit_test_suites(&int_log_test_suite);
+
+MODULE_DESCRIPTION("math.int_log KUnit test suite");
+MODULE_LICENSE("GPL");
+
-- 
2.43.0


