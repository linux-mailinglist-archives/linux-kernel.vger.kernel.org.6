Return-Path: <linux-kernel+bounces-557533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57137A5DA75
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F1B1748C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3123E345;
	Wed, 12 Mar 2025 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvzabY/j"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E21DF735
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775567; cv=none; b=EAgpqEUMYK1ChmB30Z7vHYo4B2VFIxfpszJKd7SqI//xvCCAyhLM+izF2HPxiPgSEUlT3gCI6qK8dMfrLj3hMLl5HbWU4Weqt2htCi4NoGMUs6ZcXPAqDpc7ZCwhkG4Sny0TNP/WosSBWwQ3wSjsHwfsNjAVUMlTjFqlwBi4N+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775567; c=relaxed/simple;
	bh=XGNhufp/P0Q8Q+TW0utBMugHRIX6fxVWb9Tf0tQVeGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DUGMBk8xUSXXXM15eXEzfIYDQ5FFIIn1/VRdpt16Xt1vRY81n/6ZEpL5Ma2F70X6cw8mrcC4aSDvJwAuNbg7vxdaurekWTAdFL4BEr2Uo3Kwk0kNd1F8h1pIM3KLDv+3DjLg+cQQsbC3MV3BgKJaMQOVDPro63bGQbdL9Y8MqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TvzabY/j; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39129fc51f8so5072281f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741775563; x=1742380363; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLNYJfrGVFfqNPfPze2ZbdlHRTv6KQKhBtISRpzv4Gk=;
        b=TvzabY/jZ+/WSOAJ5exe4rAtbVPt6Afy7Tw42ftSYNaHj31gsszeQWhUCqu3mZ7IRj
         gVCrFan27/ZgQuKaLHbEGMqP8o3R07HTur+yZP28WvvtvRVd7OAtG6UK/heFXMFTCZ+3
         Fk/m31J4MMx6yv2E0LdX0hfOK2SuJLJjjcil72CkAWr9wrRxjd/6RyYi5XL6DOxFWadd
         S+bbMjWW6hMJH7/CBX/HmlkRmYXD0318j5LI61dNSJS9lDSsxIFO+xR2hdpJFMKeckDH
         y0twanc5UdrmLl+2v1mHK2QM+ESvtTCp0/XMGRp6KHiRvCdmtxI4Zchl4YGo+aNRVnRU
         0XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775563; x=1742380363;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLNYJfrGVFfqNPfPze2ZbdlHRTv6KQKhBtISRpzv4Gk=;
        b=CAFf0gGcyHJHjDc6olrq/5RpfLENzMhdakuRyIgjZB8an+GhmRYfOy4E3K6MIiSYHF
         7XVu/Nu/hNNViQVE2e2bzFsujZ3ZThTWcOpjrAWPXk96/FnOfla7hKQR46MBwjeheJFg
         xxPK3QOXD27KVitSjg11yxS+efo67D3XTWb7gchK+F/tX/zGS8B32gwr6XiV2hPp2sxt
         vSL417Df0CeWuW5Wv+pE1vYPQFwYmBpxlXuG3N5rfO9enHQhRn5ww4zRJxiRyXi6aRgA
         EVeZVSSZ88E+FXxsdC0Wwk4uxOsFCBAFeCHqJZbbBba3holVnYk+u7jOwAyf4S1IzP7W
         Ex/A==
X-Gm-Message-State: AOJu0Yw4U8wS5Sfv7qsrOmhmEAauBhd+NEEXIqhfKd6jzQ2WrJxZSspV
	p6IY9a1e/mW0FXoXWhcyHmS0eFJbj7MBTPeQxfCb4gisM068bDrYaF7jgY+sI0w=
X-Gm-Gg: ASbGncvq/GpkppXhimH90XSQcNPm9LCh/U48MjIcIKxS+F/DWSJeKAvf6eQYlYMQ1K9
	nA+zLgpcVutUxrpVl+klzZmnjcj4Ae8n+SLZ3ZhycugVFaYzn0518dXHP31JrmCLMNU5Ub5NcF1
	5zjuDms8QPzpecXaNRaPjBzcf4Fwst/wK1zHzB866Q0xlwmoeroasIwz5acZmQHV+sCJ2bjWRSd
	cRUyigWKdssbld5Fkg+w8bbZJJqWmkWMlqcUboPxdBSzmGfNtN0lC0qUsSFg0dYw2QFQPcEtBdN
	mdl+0E4JYTrY3omBPXBksM0TKn0dhvAIJBLe+LbBIq48ga4=
X-Google-Smtp-Source: AGHT+IFstWyoNbU2Br602U//uo/eIeA/3WTixN2oQDEHm/zr4ekh3UaCUO2yHxeImVG1RDIzlOdHjA==
X-Received: by 2002:a5d:64e4:0:b0:391:4889:5045 with SMTP id ffacd0b85a97d-391488951femr9589432f8f.36.1741775563279;
        Wed, 12 Mar 2025 03:32:43 -0700 (PDT)
Received: from pop-os.lan ([209.198.129.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfca1sm20313128f8f.22.2025.03.12.03.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:32:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Mar 2025 10:31:57 +0000
Subject: [PATCH v4] coresight: Add a KUnit test for
 coresight_find_default_sink()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-james-cs-kunit-test-v4-1-ae3dd718a26a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJxi0WcC/3XOQQ6CMBAF0KuQri3pTKGAK+9hXJRSoIJgWiQaw
 t0tsFCjLv8k//2ZiNPWaEf2wUSsHo0zfedDtAuIqmVXaWoKnwkyjBlnMT3Li3ZUOdrcOjPQQbu
 BcllCUWLEQAvim1erS3Nf1ePJ59q4obePdWSE5bp5iDGISPAsjBGTCChsfKhaaZtDazpp+7C3F
 VmUEV/Nf5+M6I2U51KkmGeJUF8If0MAfyPcI4Uqc5ElnIGAD2Se5yfSVMziNgEAAA==
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.0

Add a test to confirm that default sink selection skips over an ETF
and returns an ETR even if it's further away.

This also makes it easier to add new unit tests in the future.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v4:
- Rename etm to src now that it's not CORESIGHT_DEV_SUBTYPE_SOURCE_PROC
- Remove the now empty src_ops too
- Fix a rebase mistake in the Makefile that removed CTCU
- Link to v3: https://lore.kernel.org/r/20250312-james-cs-kunit-test-v3-1-dcfb69730161@linaro.org

Changes in v3:
- Use CORESIGHT_DEV_SUBTYPE_SOURCE_BUS type instead of the default
  (CORESIGHT_DEV_SUBTYPE_SOURCE_PROC) so that the test still works even
  when TRBE sinks are registered. This also removes the need for the
  fake CPU ID callback.
- Link to v2: https://lore.kernel.org/r/20250305-james-cs-kunit-test-v2-1-83ba682b976c@linaro.org

Changes in v2:
- Let devm free everything rather than doing individual kfrees:
  "Like with managed drivers, KUnit-managed fake devices are
  automatically cleaned up when the test finishes, but can be manually
  cleaned up early with kunit_device_unregister()."
- Link to v1: https://lore.kernel.org/r/20250225164639.522741-1-james.clark@linaro.org
---
 drivers/hwtracing/coresight/Kconfig                |  9 +++
 drivers/hwtracing/coresight/Makefile               |  1 +
 drivers/hwtracing/coresight/coresight-core.c       |  1 +
 .../hwtracing/coresight/coresight-kunit-tests.c    | 74 ++++++++++++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ecd7086a5b83..f064e3d172b3 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -259,4 +259,13 @@ config CORESIGHT_DUMMY
 
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
index 8e62c3150aeb..4e6ea5b05b01 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
 obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
 obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
 coresight-ctcu-y := coresight-ctcu-core.o
+obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index fb43ef6a3b1f..47af75ba7a00 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -959,6 +959,7 @@ coresight_find_default_sink(struct coresight_device *csdev)
 	}
 	return csdev->def_sink;
 }
+EXPORT_SYMBOL_GPL(coresight_find_default_sink);
 
 static int coresight_remove_sink_ref(struct device *dev, void *data)
 {
diff --git a/drivers/hwtracing/coresight/coresight-kunit-tests.c b/drivers/hwtracing/coresight/coresight-kunit-tests.c
new file mode 100644
index 000000000000..c8f361767c45
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-kunit-tests.c
@@ -0,0 +1,74 @@
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
+static void test_default_sink(struct kunit *test)
+{
+	/*
+	 * Source -> ETF -> ETR -> CATU
+	 *                   ^
+	 *                   | default
+	 */
+	struct device *dev = kunit_device_register(test, "coresight_kunit");
+	struct coresight_device *src = coresight_test_device(dev),
+				*etf = coresight_test_device(dev),
+				*etr = coresight_test_device(dev),
+				*catu = coresight_test_device(dev);
+	struct coresight_connection conn = {};
+
+	src->type = CORESIGHT_DEV_TYPE_SOURCE;
+	/*
+	 * Don't use CORESIGHT_DEV_SUBTYPE_SOURCE_PROC, that would always return
+	 * a TRBE sink if one is registered.
+	 */
+	src->subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_BUS;
+	etf->type = CORESIGHT_DEV_TYPE_LINKSINK;
+	etf->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
+	etr->type = CORESIGHT_DEV_TYPE_SINK;
+	etr->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
+	catu->type = CORESIGHT_DEV_TYPE_HELPER;
+
+	conn.src_dev = src;
+	conn.dest_dev = etf;
+	coresight_add_out_conn(dev, src->pdata, &conn);
+
+	conn.src_dev = etf;
+	conn.dest_dev = etr;
+	coresight_add_out_conn(dev, etf->pdata, &conn);
+
+	conn.src_dev = etr;
+	conn.dest_dev = catu;
+	coresight_add_out_conn(dev, etr->pdata, &conn);
+
+	KUNIT_ASSERT_PTR_EQ(test, coresight_find_default_sink(src), etr);
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

---
base-commit: 3eadce8308bc8d808fd9e3a9d211c84215087451
change-id: 20250305-james-cs-kunit-test-3af1df2401e6

Best regards,
-- 
James Clark <james.clark@linaro.org>


