Return-Path: <linux-kernel+bounces-449635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D49F5214
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A1916D585
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ECE1F76C4;
	Tue, 17 Dec 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxfS54UY"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAA1F707D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455564; cv=none; b=Ai10I2o0lVmphUDn9QvX/t/cz0plRguH9tHccdh+Cwke80cdx2fomW5hANM35j/xlVLRcXEhicN2tz26xj3zp2Y4Ms7LbbwcWsgSygY6T5gFiI29Zr+RVzBq04yMpwcG9W5UO+qzVd9zKc4sJFYJ+FcYQSDLEr3BeImt0JlnA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455564; c=relaxed/simple;
	bh=9jCccRHUiglTN0cPKNY7Jp4r0KX1/0M6ivDsZeacZFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jdLoBph6tiDYkahdBIDsyXccetzJF1HTem+mb6+5AQZhUQDcq0Pw3vPay4F9cHjbRxr+dNEATjQCU+SI0lkVFFbu4gb0RX2sQuHI5+0qS9NjvGSXVUoKinQveLIdV2AYziCrtV/DbZi6++qE9hlpe6pdDOMvwNbctdK4qQugJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxfS54UY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43618283dedso54338705e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734455561; x=1735060361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7BNxMzvyJQq1OSf1JXsrJtur5eicGSEc5DxJyV8C/PE=;
        b=gxfS54UYPT6OS2B73ntB8d46ExlgaJAgQDQ+uaBYbjjGorrSxZbVFw0G5oNwPysUJ4
         VHGhd7YEqBEQc2PBhwuwXI3xr70NOaqaveh8/gkwFUMfQkq0FRzpZh5BIKF6MfLb9MZH
         IK3uNWNiCntlpTWtFfMwg8tBFdYBjT4vXz7SPT/YP1VmWvy1EgWuBEZW5Lmx4QJxBBXc
         fIOPNctEOZ+BPDHwTJnoDkL9+nM9kLxMVOCDHNH8XaoG9w5i3FS2Lv9oLp8uS5H72TLj
         hlAeKheO1nRTYVD5IRrQZ20QSIdORhI9699wLDSlnKvYfzmUAo6C9KpDP0eDK+sFRVme
         725A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455561; x=1735060361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BNxMzvyJQq1OSf1JXsrJtur5eicGSEc5DxJyV8C/PE=;
        b=qbkzD7N5QVHc76/OQu4MnmLrzxjaDb6hGcqyaqgnoX/DfxGeQVWq8Pgi1P4DYvcZAh
         eB3Bt+S83HLvdpZy9yzonQkp/tFt1JeLIouxHVFAwuAybybW1QsUq0iPUz+PsFtbI3qI
         2kdhDWf7qO+XEfIdNm8/Vhji3q7U5EzIDeW1BrPUo6ZScasAxKcNvhIhJpRzA2X7zSGO
         RTX2KFY76xYg1m2gY6oJIBoNjTmvNowLGHB8lOcoxF4yn9W3kKs1URgse2r6cB+CDeze
         7PyCTN8b9XtXZKpTYsaQDo4Zabas/JYc6Mq0qS888BPVk1U9/lQTngR/QQkZ23dLP27U
         08pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2R4MyLY6VHZU2Mj05yCnQJmFPCZGfONEkFcC8zUY5EEY3E1iwEQoBmIVClCzZ8u49QlYgFZkAe0M6Jzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzemiHJ7vBA3/mgMRmI1g/lnKJ5XoKTLA76OFq2RKKgNbdDERHU
	81w/h43mCMoxQhcJhW1e4HGJEWTe6793DKscVLMOu7L8MaMnc8lxEVZ88tM1+sc=
X-Gm-Gg: ASbGncv6aluih5grFap0gy7ZBmioqsFRNynVWNjmq52RE5R3AA83oS+i+5VeOJ/Exxo
	nrO3uokZLVsfRU4CnspaakNjmlbuUkQjGKbPtDfYgsdr3/1WT2njp3qUasRZfNNUb4MXX3JqVjB
	5FnRCyLjxDLlct6jCIObH5eSrrABsNZPq67Hlrz235OG2XOtEXBRSkzSP7U+23VhsuP0H86g/49
	c1q9m9nzUlKFnUDJEQ8FAONu+NTmFV8+tZ+cQm7QeNbU21+3UeJyjqz
X-Google-Smtp-Source: AGHT+IGSiqAXtYo/k8MN0k8v0TOiO3K7Mj9/v3WC0hPOafHJZMJVxrDNJwoO8nu2w8km+EC2EBgFBQ==
X-Received: by 2002:a05:600c:1e0d:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-4362aa27057mr155476905e9.4.1734455560865;
        Tue, 17 Dec 2024 09:12:40 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363601574bsm122566915e9.7.2024.12.17.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:12:40 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	scclevenger@os.amperecomputing.com
Cc: yeoreum.yun@arm.com,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] coresight: Add a KUnit test for coresight_find_default_sink()
Date: Tue, 17 Dec 2024 17:11:31 +0000
Message-Id: <20241217171132.834943-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to confirm that default sink selection skips over an ETF
and returns an ETR even if it's further away.

This also makes it easier to add new unit tests in the future.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  9 ++
 drivers/hwtracing/coresight/Makefile          |  1 +
 drivers/hwtracing/coresight/coresight-core.c  |  1 +
 .../coresight/coresight-kunit-tests.c         | 90 +++++++++++++++++++
 4 files changed, 101 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-kunit-tests.c

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 06f0a7594169..056d04bc540a 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -247,4 +247,13 @@ config CORESIGHT_DUMMY
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called coresight-dummy.
+
+config CORESIGHT_KUNIT_TESTS
+	  tristate "Enable Coresight unit tests"
+	  depends on KUNIT
+	  default KUNIT_ALL_TESTS
+	  help
+	    Enable Coresight unit tests. Only useful for development and not
+	    intended for production.
+
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 4ba478211b31..c170a41b3056 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -51,3 +51,4 @@ coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 		   coresight-cti-sysfs.o
 obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
 obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
+obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index ea38ecf26fcb..ce63b68d5503 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -869,6 +869,7 @@ coresight_find_default_sink(struct coresight_device *csdev)
 	}
 	return csdev->def_sink;
 }
+EXPORT_SYMBOL_GPL(coresight_find_default_sink);
 
 static int coresight_remove_sink_ref(struct device *dev, void *data)
 {
diff --git a/drivers/hwtracing/coresight/coresight-kunit-tests.c b/drivers/hwtracing/coresight/coresight-kunit-tests.c
new file mode 100644
index 000000000000..d022bacc8357
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-kunit-tests.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/test.h>
+#include <kunit/device.h>
+#include <linux/coresight.h>
+
+#include "coresight-priv.h"
+
+static struct coresight_device *coresight_test_device(struct device *dev)
+{
+	struct coresight_device *csdev = devm_kcalloc(dev, 1,
+						     sizeof(struct coresight_device),
+						     GFP_KERNEL);
+	csdev->pdata = devm_kcalloc(dev, 1,
+				   sizeof(struct coresight_platform_data),
+				   GFP_KERNEL);
+	return csdev;
+}
+
+static void coresight_free_test_device(struct device *dev,
+				       struct coresight_device *csdev)
+{
+	devm_kfree(dev, csdev->pdata->out_conns);
+	devm_kfree(dev, csdev->pdata);
+	devm_kfree(dev, csdev);
+}
+
+static int coresight_test_cpuid(struct coresight_device *csdev)
+{
+	return 0;
+}
+
+static void test_default_sink(struct kunit *test)
+{
+	/*
+	 * ETM -> ETF -> ETR -> CATU
+	 *                ^
+	 *                | default
+	 */
+	struct device *dev = kunit_device_register(test, "coresight_kunit");
+	struct coresight_device *etm = coresight_test_device(dev),
+				*etf = coresight_test_device(dev),
+				*etr = coresight_test_device(dev),
+				*catu = coresight_test_device(dev);
+	struct coresight_connection conn = {};
+	struct coresight_ops_source src_ops = {.cpu_id = coresight_test_cpuid };
+	struct coresight_ops etm_cs_ops = { .source_ops	= &src_ops };
+
+	etm->type = CORESIGHT_DEV_TYPE_SOURCE;
+	etm->ops = &etm_cs_ops;
+	etf->type = CORESIGHT_DEV_TYPE_LINKSINK;
+	etf->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
+	etr->type = CORESIGHT_DEV_TYPE_SINK;
+	etr->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
+	catu->type = CORESIGHT_DEV_TYPE_HELPER;
+
+	conn.src_dev = etm;
+	conn.dest_dev = etf;
+	coresight_add_out_conn(dev, etm->pdata, &conn);
+
+	conn.src_dev = etf;
+	conn.dest_dev = etr;
+	coresight_add_out_conn(dev, etf->pdata, &conn);
+
+	conn.src_dev = etr;
+	conn.dest_dev = catu;
+	coresight_add_out_conn(dev, etr->pdata, &conn);
+
+	KUNIT_ASSERT_PTR_EQ(test, coresight_find_default_sink(etm), etr);
+
+	coresight_free_test_device(dev, etm);
+	coresight_free_test_device(dev, etf);
+	coresight_free_test_device(dev, etr);
+	coresight_free_test_device(dev, catu);
+}
+
+static struct kunit_case coresight_testcases[] = {
+	KUNIT_CASE(test_default_sink),
+	{}
+};
+
+static struct kunit_suite coresight_test_suite = {
+	.name = "coresight_test_suite",
+	.test_cases = coresight_testcases,
+};
+
+kunit_test_suites(&coresight_test_suite);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("James Clark <james.clark@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight KUnit tests");
-- 
2.34.1


