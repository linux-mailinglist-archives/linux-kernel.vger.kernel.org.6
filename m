Return-Path: <linux-kernel+bounces-369945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BCE9A24B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879492854AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2D1DE8AD;
	Thu, 17 Oct 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg7MCsby"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C601DE8A0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174431; cv=none; b=Qox4nuzCRSuAEvusuHDb6CvAVMnH7SGwKnLH5piNubKBiDg7a2aNZ+pSnF4aoUFU9joB/fs0dY78rIVYNu0MXnNoyvIvajZ16CTXXHncITuRsopidbb46LjTgOhFS/2b3AMxLRVFtJS2oLwZi6vudsRhlsFMdB6MTBFef7x6p14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174431; c=relaxed/simple;
	bh=uhxh3JUCG0oQRwCOMgKyOtV3TGDTfiLNPFLXOAtoaTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=C/k/rmtFbxNbdI8Jd+VS92vbv8+bgRpwDF5taYDA8E9klj18r5N2GZ2TiOiuRCVGQhFPWFOIu4lAblHf01C28LTJ0URqlEVr4Qrczgy9yhOmFecfUorVqalVsr1fWXMCG8dTczzp9+M1ls5Mikv6zxHqwONEJL0/ZjO4VswfvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg7MCsby; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c5acb785f2so5483416d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729174429; x=1729779229; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+jO1c0kb/AbwFJdjaltlnmUBq08FYTcvMJpLmtEWhT0=;
        b=Xg7MCsbyj2HgKmceq5CBJpBOB+F1UuhQ1HkFHs6SwGa3LtxwAEQ9dCoOkRLtF/HHC4
         NpHV0v91aFtWo/5eHY+1rmsFuW9jnt5poFbDll0kdpXfAtztcR7nJMRmGy/FXixX3F4Y
         xrLpGkYCP/qry7ST2AXipMEtbUie8xHQ3c5kmBCQi7zU+eQMnera2PzVVcvQGWyRdodQ
         L21+qduiCxSYpwX4NfeCIZhC5JBsM1ixjvO+nXGAx8MBfDE9D5ftFeWPkIwZwKsn87n5
         DZh51jnqyGf4fN4IeeC2rSeicYu/o8zCwbevoBrel3eC5uWdd64ItuvPh1MIgeqgKmXj
         my/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729174429; x=1729779229;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jO1c0kb/AbwFJdjaltlnmUBq08FYTcvMJpLmtEWhT0=;
        b=H2qqmDWOqRKMr29mM6cKOkdnsr3dJgBwpo5RjUiCu2LEFF/r3LRf/vEPUlL27AjTS2
         deeSpESVPKZ1dFLacS6bLCs8nj90WMCDn1hGsAvcd40/N73KsSrRZDzyynV8/3OSTSjO
         h1db6Ej8OOOzGsGoQQFHdR2ImGFKZfgLBUZiSyd281R1+MUHp+5sbo//YOLCwp77CZlG
         TTB863zgBnrqswUKNwRbkf3qfXB4ap746u4R+zeDaIhKQgTFvv7JwRGlrsYGUI2dTy6o
         EYookzI6nGtvzJnY6ohyOBxkYBiptOB2Dtujgc2+l7qfUm8pEhgG9eZsV59r4xWE/BoK
         FJow==
X-Gm-Message-State: AOJu0YzueBQuhifymYPz5KljczOCI2cKkegu2eoW4joBHbIXq/X/I41b
	V783JA8SnI+k/jNQTGhmrbA1pzoAh2aXlZlgiMUZOO05Dfcu93vTGsp6fHCf
X-Google-Smtp-Source: AGHT+IFF/dyWOdfBZjL8Vrtad48yEgJ/2bWR7J9EGmLqOFSlO5DBm85tHXXOBnLoq7Xj12nDZ/9p4A==
X-Received: by 2002:a05:6214:3d98:b0:6cb:e947:2d12 with SMTP id 6a1803df08f44-6cc2b8d714bmr120292956d6.25.1729174428626;
        Thu, 17 Oct 2024 07:13:48 -0700 (PDT)
Received: from localhost.localdomain ([66.198.16.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc229654c4sm28549916d6.128.2024.10.17.07.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:13:48 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	quic_jjohnson@quicinc.com,
	dan.carpenter@linaro.org
Cc: avimalin@gmail.com,
	vimal.agrawal@sophos.com
Subject: [PATCH v4 2/2] misc:minor basic kunit tests
Date: Thu, 17 Oct 2024 14:13:29 +0000
Message-Id: <20241017141329.95508-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2024101722-uncharted-wages-5759@gregkh>
References: <2024101722-uncharted-wages-5759@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

basic kunit tests for misc minor

Signed-off-by: Vimal Agrawal <avimalin@gmail.com>
---
v2: Split from previous patch
v3:
v4: Match patch version for whole patch series

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


