Return-Path: <linux-kernel+bounces-442040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E29639ED746
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A144281CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCEE20B7F4;
	Wed, 11 Dec 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/taYj62"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92682594B5;
	Wed, 11 Dec 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949270; cv=none; b=Y56PGp+/n7ogal1x+rRcTEJ4KCG2saMVwCzCfK1qLUxzuIHeCrcJ5Cjf485rS3uSOe4RhCoWAydeyCVKF5Yu1WmmiZOj9FsXHTQVfyHyDp8OyezvMKwbZFb0b581RAn8YHMsle09pSQaql5jVAuFul8IAOWfn/Oe10DwawwvW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949270; c=relaxed/simple;
	bh=5YmXEGP/cRY+RRUpDdkGmpMKmYheop2H/JG7afWhz/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1rI3/fXCJEK3h20/M6zc3GtBJRAxTtGrgmlFea086KMbevcaDv8XpW4oVWrFlttGAq4io60e4OHf1yWqJaDeZEPsB4jwi5+4AuKgJUkOS5po38hR6XLgJvfpzM18z8Gkxly4OIa3F8upGLsZbjR2B7OWTAWIXfWVhKRDHQxsxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/taYj62; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ef824f40dbso53490797b3.2;
        Wed, 11 Dec 2024 12:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733949268; x=1734554068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1BtG47wpF97tJaGwTw5HnbCfBrRILA4erhzS9QHvmhs=;
        b=a/taYj62ibJZxwKWFvBDLel+SrRc+zybQPBjR7JbcxIV2gOpMGnfFZsNOSj3Un2hrs
         tTcS1lsX/1lTJv5FDFyNV85ro508Vv7sqBIAXILzAwwZNtdLx/c1nzwJrMstMutAL73O
         aFSRItCoO01iUCqkMpBgmpnDklABD13NbsERKzb8oUxmewYlMQ68TfNJ4gJeYGXYrYrG
         zSIxxjjCe2M5niQ3qjBF9KrPm/Ehp88+k/fMwuJOj0aZ8YojQr0YiCXJaklSb7zrHP4w
         zs0X0J1wSqVR89Zt3brFGfIohtCCSLR/jTlSHsZxusV9/rC57z0Y5Z/lcrgcpFsYj08O
         AZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949268; x=1734554068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BtG47wpF97tJaGwTw5HnbCfBrRILA4erhzS9QHvmhs=;
        b=b9r8ctp47NfVZXaYqkVeEQuQ7+hr10WTyK+LvpvQlVSiAq7bvi2kiCLsMTGvyMMGTH
         MpZrISswowwALa6HF3iz1jqqi+7BbofriEINpScCGRVD/1cgl9MqhsyYSlgZKVXflG+E
         tSO+qYU1lPiiR90FTSP5ylnF8moQKuhMpg8BuGFnGRmFCYq2MU1h3k/Udu/DLNqj7mzO
         s0o6v2DICGGoSzHJG0MM4ite1/SVKQ6DLYg/zflqX0Shp4dxwxZIMt1HGFsE87LysmlJ
         QuLPHhFy+UHr34LnDQZ4L1R2lXCJnLy1L4z92by2jz6wL0+pFsM8gWhBcKJuG80a3QRZ
         lODA==
X-Forwarded-Encrypted: i=1; AJvYcCWhwFzFK/YQ2lHSHpn023Pfks3LNmA4OPcPmKbi45yEUIOpDxDUTXlx8DmZ8mh1xXZZ3uueRDDsAuuZ@vger.kernel.org, AJvYcCWoiOq7Hoxv7PiG0e4CsZi+9l5wt3EBTpcG0w1Zhce3I9KzuM7nqlRnZGdMJOk4n81Mc2Xo5hFvDTIIyjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybejyB6fCNrcKdvnHVa5Uzkqju8zbmK3fTdnFuuliWOLXr11Qw
	3bvR1jbtT5mCGFtS9V9yO7OMSbK8P8smAYTT5/JG+8TfuGcny8hj
X-Gm-Gg: ASbGncsxm1uz4JmtoswQlQoP07yIKPh25XZs5jJCUZO7pEnsLbiP3a0CiW1cSvXGpmf
	DNEC6cYZ6wsoOCH9EeYpFvSREtyixQac4E5eKcT3mK6TXD0y6GzNmbnFlqyRjYnz8Lf4vqFyHmz
	3tVXBSIZtnbOlaBWDMMf1jrKsx8M1PrrtUk+AY72k/76C1gdsg57RVZeqBPwxtuXR8s8OhjMq6m
	Uen8OuQjFlL7z3eIVW3BE5K1qS/GUAc3noyu8nRJ45nTZPoX9PHcRA=
X-Google-Smtp-Source: AGHT+IGkJHn8xVW0GUURiFqM8Cqzl0Yz4EdO59oL+4NxZBj9hxdo5M9IEBzLs92qQhEGeqBhpTyG+Q==
X-Received: by 2002:a05:690c:886:b0:6ef:800c:6394 with SMTP id 00721157ae682-6f19e50e402mr11025057b3.37.1733949267580;
        Wed, 11 Dec 2024 12:34:27 -0800 (PST)
Received: from x13.. ([157.23.249.72])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14cdaa101sm3978227b3.58.2024.12.11.12.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:34:27 -0800 (PST)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org,
	rbm@suse.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	skhan@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] lib/math: Add int_sqrt test suite
Date: Wed, 11 Dec 2024 15:34:24 -0500
Message-ID: <20241211203425.26136-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds test suite for integer based square root function.

The test suite is designed to verify the correctness of the int_sqrt()
math library function.

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
Changes in v2
  - Add new line at the end of int_sqrt_kunit.c
  - Add explicit header includes for MODULE_* macros, strscpy, and ULONG_MAX

Changes in v3
  - Remove unnecesary new line after Kconfig entry for INT_SQRT_KUNIT_TEST
  - Correct int_sqrt instances with int_sqrt() in commit message and kconfig
entry desc
  - Fix limits.h header include path

Changes in v4
  - Fix Kconfig entry: remove redundant word test

Changes in v5
  - Address review feedback by Nicolas Pitre
    - Make edge case portable by not relying on arch dependent macro
    - Add more edge cases
---
 lib/Kconfig.debug               | 15 +++++++++
 lib/math/Makefile               |  1 +
 lib/math/tests/Makefile         |  1 +
 lib/math/tests/int_sqrt_kunit.c | 60 +++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)
 create mode 100644 lib/math/tests/int_sqrt_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d723705879..147d9fef42e7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3161,6 +3161,21 @@ config INT_POW_TEST
 
 	  If unsure, say N
 
+config INT_SQRT_KUNIT_TEST
+	tristate "Integer square root test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the int_sqrt() function,
+	  which performs square root calculation. The test suite checks
+	  various scenarios, including edge cases, to ensure correctness.
+
+	  Enabling this option will include tests that check various scenarios
+	  and edge cases to ensure the accuracy and reliability of the square root
+	  function.
+
+	  If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 3ef11305f8d2..25bcb968b369 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
+obj-y  += tests/
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index 6a169123320a..e1a79f093b2d 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
+obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += int_sqrt_kunit.o
diff --git a/lib/math/tests/int_sqrt_kunit.c b/lib/math/tests/int_sqrt_kunit.c
new file mode 100644
index 000000000000..a94c68816a1a
--- /dev/null
+++ b/lib/math/tests/int_sqrt_kunit.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+struct test_case_params {
+	unsigned long x;
+	unsigned long expected_result;
+	const char *name;
+};
+
+static const struct test_case_params params[] = {
+	{ 0, 0, "edge case: square root of 0" },
+	{ 1, 1, "perfect square: square root of 1" },
+	{ 2, 1, "non-perfect square: square root of 2" },
+	{ 3, 1, "non-perfect square: sqaure root of 3" },
+	{ 4, 2, "perfect square: square root of 4" },
+	{ 5, 2, "non-perfect square: square  root of 5" },
+	{ 6, 2, "non-perfect square: square root of 6" },
+	{ 7, 2, "non-perfect square: square root of 7" },
+	{ 8, 2, "non-perfect square: square root of 8" },
+	{ 9, 3, "perfect square: square root of 9" },
+	{ 16, 4, "perfect square: square root of 16" },
+	{ 81, 9, "perfect square: square root of 81" },
+	{ 256, 16, "perfect square: square root of 256" },
+	{ 2147483648, 46340, "large input: square root of 2147483648" },
+	{ 4294967295, 65535, "edge case: ULONG_MAX for 32-bit" },
+};
+
+static void get_desc(const struct test_case_params *tc, char *desc)
+{
+	strscpy(desc, tc->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(int_sqrt, params, get_desc);
+
+static void int_sqrt_test(struct kunit *test)
+{
+	const struct test_case_params *tc = (const struct test_case_params *)test->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, int_sqrt(tc->x));
+}
+
+static struct kunit_case math_int_sqrt_test_cases[] = {
+	KUNIT_CASE_PARAM(int_sqrt_test, int_sqrt_gen_params),
+	{}
+};
+
+static struct kunit_suite int_sqrt_test_suite = {
+	.name = "math-int_sqrt",
+	.test_cases = math_int_sqrt_test_cases,
+};
+
+kunit_test_suites(&int_sqrt_test_suite);
+
+MODULE_DESCRIPTION("math.int_sqrt KUnit test suite");
+MODULE_LICENSE("GPL");
-- 
2.47.1


