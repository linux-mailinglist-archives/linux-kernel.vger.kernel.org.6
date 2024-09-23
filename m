Return-Path: <linux-kernel+bounces-336211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4680D97F0A0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B7A281CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27E1A01C3;
	Mon, 23 Sep 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el6xiQBq"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E9101DE
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727116092; cv=none; b=U5iVipbqmbnhRYVkQWMSsdNCTOn7gMQ+a5MvqukvpAN0MMsdh2IaoWXRO396m6ZfSbWxt2hYG4x/fTdzYzhV0jhErJkzzRa6/S1uwDrHbt6MvZKBCcLhxAfOWiZ6l5ju9BAIuSN3GJr97KtHT0KTuImIsE44UNuuKLYVLsm3e6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727116092; c=relaxed/simple;
	bh=QbRqjtxOB3MHaRJ1QgYEDpdPYgM7DU/nYJWS2/l99G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UVLk+JlXVOgfbqxOmgsbNa3kyQtEcZFcSZYEZwm9LJe39ITN2dLhvO80U1ruiMCvIle5eZ0Ih927/DPxCzxWGd4bpnyjY9YS7tHuKB3wTPwXHNxjIzFmjXqN/1P+ESJWbeiGw0VouE4MbL5v68zKGv/Lf1QyL9Zyri2SXL+qyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el6xiQBq; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-49bd76fa981so1800428137.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727116089; x=1727720889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvC8OpRVu7RcWevPpe6zlyuw6fQztO2vgcY7rQ0WA6E=;
        b=el6xiQBqKlglk/wrlNNlRaEDcNgB7GhhINRemlifwnRIdvyav7roiL+CpUGls1hz5Q
         epVv2BM0qB70h1sHRrOkgGQ5opKDtOdMkuahhgu0C2crofV6CCtAiFPYkUaVy4O12bHc
         NDl79kpbQYE5dpu6KCFo5FBtEE4DK2Bqpq8wyCQfpGrxwvw5lcC0oVEqQnGIdh2PzTD0
         /CoTRruAYjKAOVFlLQlJWkCniU6uloqK7JMrxeA7QcKHKdDiYmhgYdJMcp8CDhEjJIOd
         7Tq2Xx3Q2ZLX9ADcfc1XjXy+nAVuZZvoOzvKrLB9h1S30PcT+bQoksoK2wQSQkTrxPp3
         2MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727116089; x=1727720889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvC8OpRVu7RcWevPpe6zlyuw6fQztO2vgcY7rQ0WA6E=;
        b=jl2ZKihGeiMA70Elakg2inXlUmIKhN+lLvZSDXUGZ9cYGUHWNM3lb7niVm4j89oSDa
         OXkY3R/5w6lRFzzlI9lA1IwdNWH3vtUv6sSloWUfUGcrON1T4eBsg9Is1TatrBNhov0K
         LIZY4qIwBx6cWle7mtJoYzNeyy8il6H4aRuhBPTbGiJscr9F24/Jk+MOYPI8vLK+NZaR
         Uqyj7a2h2grj7edm4MjTjLY9WiuPoDuIeW8T1Ew7XNsEhlf0ldGkA7RFuzoodSTCo0os
         gj0aNfloYC+QM7oLOcyMNvUIUHP8xkpQlE+2/UG7GV+MjUXlcdB+xAAcQFnyf0YHctUe
         vn8g==
X-Forwarded-Encrypted: i=1; AJvYcCXHVy8rvBnyiDMmR7yYB76T1d8cAiOJWz3gMjaqaIZybG452TNnN23haE2lAxIGe/w6vwVcP/OGBUqGoiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiFrzBMmutccci+uscpRnfC2y3Zie3VGGx42+clxSmU/Q0OwG
	Ied0a9HA6i79+qeF2coKqFW92r0Bjc8+d+Q3OEbttwIjCS4MZ2h7In7FGw==
X-Google-Smtp-Source: AGHT+IExJyb740zkCQVp6XC9+Z56SOW92gmYPETjHCLM9ypiku8Mb1zqeKoMl+NsUrB4+WyBJ+yNyQ==
X-Received: by 2002:a05:6102:94c:b0:493:b719:efaf with SMTP id ada2fe7eead31-49fc7678485mr8621012137.20.1727116089541;
        Mon, 23 Sep 2024 11:28:09 -0700 (PDT)
Received: from hilb.unicamp.br ([143.106.58.82])
        by smtp.googlemail.com with ESMTPSA id a1e0cc1a2514c-8493999717esm3354397241.31.2024.09.23.11.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 11:28:09 -0700 (PDT)
From: =?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
To: akpm@linux-foundation.org,
	davidgow@google.com,
	linux-kernel@vger.kernel.org,
	rmoar@google.com
Cc: kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
Subject: [PATCH v2] lib/math: Add int_log test suite
Date: Mon, 23 Sep 2024 18:28:01 +0000
Message-ID: <20240923182801.37747-1-brunofrancadevsec@gmail.com>
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
Changes in v2:
  - Fix the overflow warning reported by the kernel test robot
---
 lib/Kconfig.debug              | 11 +++++
 lib/math/Makefile              |  3 +-
 lib/math/tests/Makefile        |  1 +
 lib/math/tests/int_log_kunit.c | 75 ++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 lib/math/tests/int_log_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bc8faa4509e1..b0f658b0f29f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3089,3 +3089,14 @@ config INT_POW_TEST
 	  function.
 
 	  If unsure, say N
+
+config INT_LOG_TEST
+	tristate "Integer log (int_log) test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the int_log library, which 
+	  provides two functions to compute the integer logarithm in base 2 and 
+	  base 10, called respectively as intlog2 and intlog10.
+
+	  If unsure, say N
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 3ef11305f8d2..c3fd967bc49b 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,7 +5,8 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
-obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
+obj-$(CONFIG_INT_POW_TEST)  	+= tests/int_pow_kunit.o
+obj-$(CONFIG_INT_LOG_TEST) 	+= tests/int_log_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index 6a169123320a..83bbf1e47940 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
+obj-$(CONFIG_INT_LOG_TEST) += int_log_kunit.o
diff --git a/lib/math/tests/int_log_kunit.c b/lib/math/tests/int_log_kunit.c
new file mode 100644
index 000000000000..025748cd0bbe
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
+       	{16, 67108864, "Log base 2 of 16"},
+	{32, 83886080, "Log base 2 of 32"},	
+	{U32_MAX, 536870911, "Log base 2 of MAX"},
+};
+
+static const struct test_case_params intlog10_params[] = {
+	{0, 0, "Log base 10 of 0"},
+	{1, 0, "Log bsae 10 of 1"},
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


