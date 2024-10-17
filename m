Return-Path: <linux-kernel+bounces-369703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB669A215F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927B11C20754
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5051D4173;
	Thu, 17 Oct 2024 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDgrc3sa"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9331D365B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165488; cv=none; b=fQ+DmlshyuqBRzNcobgTce2iDYRf61UMl+9wufFnbwFydMfXlxI7onO9zd941KKVCyojxjFr7+Ju/cqU3J5/c02ThRT9TUKxTkePQQ0xyBsuPzl1P2Y7CoEtbA7KLthr1Cv1+xDbxrGUfo6dU4jY0urvpAwcksGLUTXjzbWvAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165488; c=relaxed/simple;
	bh=K1UBw59nAZFfL+69V4aH8rqa9eIt0v0Z6bBihXpf7Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QGtBUbXiXaYLRnADLEolw+2GfD8kiyFg7buHX82jpFQSfcGKfeby219D5M37JMoXFN9uxXrTouuJ/0GoerSPZNOENWcAPmBPDTVEGzu2WLMbMDVxmIN/Pd7/y3XrLuvYuQVev7wy3tcdM6o8p7LkXKO0yv7GlSWL5Gk/M2MFqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDgrc3sa; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b150dc7bc0so36507685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729165483; x=1729770283; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kd6DFKsFGyCeOTpexQNILtoJAiJcykx9DeZVNUWkaxc=;
        b=iDgrc3sa7kiOuX9xIo3X/Ikml0msoCocpGdcSuVp3cgID+yJmuKoT8gBRHuQbnX5o2
         Yf2L2V/WYaZJZH/oY+JuECF5rqB1yNhigUrkJeILGH/CseAZBDH/oX2XEQsyUd7hoI2D
         JvdAIniKtio1qeFZneK5KkKLMzPQTgXdD61smISyfTzB47W5uSy4p8XiZSLy9N817oYk
         m2ugnHw+gsQFT+7l6eiL+P9ZdRS4o1LaBueSeolYWnjsNv/cp5d8Xr6Hb/KbkgbeBZxe
         2wxFTWHYD+YulnxNSXyuGNckuz0kBy/+fhS2+KgC2T+yCDG2yv1gDbDpCGo4pdNJ/5UX
         JLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729165483; x=1729770283;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd6DFKsFGyCeOTpexQNILtoJAiJcykx9DeZVNUWkaxc=;
        b=WPbov1mgs3lkJ/s6lSLc9FWZyObizKfcf8C1+JURqMuAUz3Evz45ioA+bQH4xirnuU
         ntlesZON/s6SowoOUCw/fxbnQVgWJcP6E6acZ5Ad/EvtuTJIuBZCoZpay843ivkbRlCP
         gMw39gubgrBcyBt303CS14zJr4DoGbEgcQbXrqmQgPzih/sJAXYOsIvbN41O8dXbXpwl
         hPhJyhsfeVdQ2ygaJYzZpQYskquEG0jDNU5cc9qhxTlhcgmpoElwvWoU46l4Eh2YjRPa
         hWZQ41M/pKZvehz4dVKAwUc3QD1sO5b/y1YP4PyNAoXkOf7k6CBx/GG6ILhl892bcPJ0
         aY7w==
X-Gm-Message-State: AOJu0YxKavr6uM0aX9EOqxROmXbJPNvlGamkFeAnqp4xNVQNYU1xzxgG
	LnoYMwXdLpW145HFSn570Y8OHfu0cIXE73C2injCkr/z4RHrAe8Ukz3DPGb8
X-Google-Smtp-Source: AGHT+IEJwWB2u3yoJiSAY3HZFLS5N0tecVfuRaWpjp/mpm5YGXTBl45a1XYdkpjdgaLbCJ6b51732w==
X-Received: by 2002:a05:620a:1a9f:b0:7b1:1184:a6b6 with SMTP id af79cd13be357-7b120fa91c6mr2991586985a.4.1729165483118;
        Thu, 17 Oct 2024 04:44:43 -0700 (PDT)
Received: from localhost.localdomain ([4.15.194.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1540f9075sm14070185a.78.2024.10.17.04.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:44:42 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	quic_jjohnson@quicinc.com,
	dan.carpenter@linaro.org
Cc: avimalin@gmail.com,
	vimal.agrawal@sophos.com
Subject: [PATCH v1 2/2] misc:minor basic kunit tests
Date: Thu, 17 Oct 2024 11:43:28 +0000
Message-Id: <20241017114329.22351-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALkUMdS3wEuSi5SGqsRKt3nSb4mHue1bJTJm8=QL3OLYU2GWig@mail.gmail.com>
References: <CALkUMdS3wEuSi5SGqsRKt3nSb4mHue1bJTJm8=QL3OLYU2GWig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

basic kunit tests for misc minor

Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
---
 lib/Kconfig.debug     | 11 +++++++
 lib/Makefile          |  1 +
 lib/test_misc_minor.c | 69 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 lib/test_misc_minor.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..5a5d27284e0a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2488,6 +2488,17 @@ config TEST_RHASHTABLE
 config TEST_IDA
 	tristate "Perform selftest on IDA functions"
 
+config TEST_MISC_MINOR
+	tristate "Basic misc minor Kunit test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Kunit test for the misc minor.
+	  It tests misc minor functions for dynamic and misc dynamic minor.
+	  This include misc_xxx functions
+
+	  If unsure, say N.
+
 config TEST_PARMAN
 	tristate "Perform selftest on priority array manager"
 	depends on PARMAN
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..631d73f96f76 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
+obj-$(CONFIG_TEST_MISC_MINOR) += test_misc_minor.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, unused-but-set-variable)
diff --git a/lib/test_misc_minor.c b/lib/test_misc_minor.c
new file mode 100644
index 000000000000..293e0fb7e43e
--- /dev/null
+++ b/lib/test_misc_minor.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+
+/* dynamic minor (2) */
+static struct miscdevice dev_dynamic_minor = {
+	.minor  = 2,
+	.name   = "dev_dynamic_minor",
+};
+
+/* static minor (LCD_MINOR) */
+static struct miscdevice dev_static_minor = {
+	.minor  = LCD_MINOR,
+	.name   = "dev_static_minor",
+};
+
+/* misc dynamic minor */
+static struct miscdevice dev_misc_dynamic_minor = {
+	.minor  = MISC_DYNAMIC_MINOR,
+	.name   = "dev_misc_dynamic_minor",
+};
+
+static void kunit_dynamic_minor(struct kunit *test)
+{
+	int ret;
+
+	ret = misc_register(&dev_dynamic_minor);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 2, dev_dynamic_minor.minor);
+	misc_deregister(&dev_dynamic_minor);
+}
+
+static void kunit_static_minor(struct kunit *test)
+{
+	int ret;
+
+	ret = misc_register(&dev_static_minor);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, LCD_MINOR, dev_static_minor.minor);
+	misc_deregister(&dev_static_minor);
+}
+
+static void kunit_misc_dynamic_minor(struct kunit *test)
+{
+	int ret;
+
+	ret = misc_register(&dev_misc_dynamic_minor);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	misc_deregister(&dev_misc_dynamic_minor);
+}
+
+static struct kunit_case test_cases[] = {
+	KUNIT_CASE(kunit_dynamic_minor),
+	KUNIT_CASE(kunit_static_minor),
+	KUNIT_CASE(kunit_misc_dynamic_minor),
+	{}
+};
+
+static struct kunit_suite test_suite = {
+	.name = "misc_minor_test",
+	.test_cases = test_cases,
+};
+kunit_test_suite(test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Vimal Agrawal");
+MODULE_DESCRIPTION("misc minor testing");
-- 
2.17.1


