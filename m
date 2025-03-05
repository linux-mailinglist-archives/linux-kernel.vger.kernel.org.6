Return-Path: <linux-kernel+bounces-547117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6512A50329
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0560D162771
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA0724EF66;
	Wed,  5 Mar 2025 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A004SGrZ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD624887F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187270; cv=none; b=p1hmJY6GMaGDp38SQHpQSrLUOnDcRU/ngw2UcvDU+4AZN3uzdn891vog9yjO9+9EWLUUavJv8CthTh6SvGKo9fQ20HRC7+5rRyAjDMZMsgsBGVjNF478AjK8P4e5nbYXbWa0lzT5CbPRZ2hO5RT/F5e5kjNfFd9oyTvL44sk6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187270; c=relaxed/simple;
	bh=8X8tCRxnfrXE7+LnA3g5/pMoN4Xsv7iWEWPuk3orjyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=flk7/Yo2S70Sv8zqmQ40twXttVK+xFtKHlUA492S8uoy6NaboPZDupJYJfpIV7KKcDZr5+qAAHUYsCkgZSFsENkb6KQd+O5e4u4ZPHpr9dGWiQnnTt1MIelXNIYI4F/dynJbl6YKfvuUIQQTf+nXCAucSgnvP1Bu94qdhElOMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A004SGrZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bc31227ecso21619055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741187266; x=1741792066; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yT+d5B3DzOfQ1A2yZzKZbhntYkBCfJHpxkupFuJwOC0=;
        b=A004SGrZw9vyeXMzAwvOoWJLE6qrqlbeySD6TvuVW9eDyAt8trpxPMl1qEHu8SpSTA
         JWh8UHPZDh9e4KCUEa3UAtHiLQWA9ccicNUtsudNF+P22MDNnOHAVOoo/MEt2LYZPZ39
         bivK6hNvDTA6PA8/LFdRquk21ys4YXrcAsa3P63S0BH9ydOGsx3JFQZ7ma4L6fkRkBVP
         uwt3ZXQEQ3tGRNHgfgjyNSf09g6zjy/lmyZvd6/p9HIz8pt19DJRdiCyOn8pmgrUTflv
         /y2e9xxrK9Ic4E8YcY8s+drPiIoFiXih/bde+j4f26qGPOrwvaVqCDHdRkH9D8xe9Jug
         Al3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741187266; x=1741792066;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yT+d5B3DzOfQ1A2yZzKZbhntYkBCfJHpxkupFuJwOC0=;
        b=LHiq85ForefBvMQ9Mg9RCpNB6rJIW+FfMz0IeKqUc+Jk6t2c19uEnfyLkMKZXnjpv2
         GcXRC2By24DRYxqxSoVoG/XHFpoYWSNoSusSv4E/s5koWJ5Mf34tNNKxNnrrs00+mPxU
         97onQZTtEGG9zV0bsU97YrUAjjx9sr9OWVyvB3L5ym+Ct53xol6dnhmfWh657p6KYniU
         mBOHRFbhebfeDZpVBP6WuHGWA4mKTc7hWfUY/Hj1x2Jqv8oJKAfsrmmZv3MMDKA4q88t
         lMgvzDVgQv8tfsdr6e1kVHgkGfZp7vxQsBg/D3PmZpktQkp8pYugNd3/d7Q04EvRg6tk
         m9LQ==
X-Gm-Message-State: AOJu0Yy+H216zL6vyyCP95jJlOUJQrB+KSJwIMmxom0rPaFvFNU1dOzt
	/3X8BSXwJ8DehhsTHOFDXUMCD8Ldtlvgo3SwwOPA3MoEUmKyGray2topgnvofeU=
X-Gm-Gg: ASbGncup6OinbdhrKKDzoywfi454HJ7PAb8gT/d10b2+gIJBt4aioQ3FDQQeZkbJQWi
	tiM4eAUmgYxaKJKLxbVbbK0QtN1RoysvWF3PyWz81dl/OIgJojzU+vHCwATbWjtrH8fb8zOxHTR
	y3bnIioTkToGX/yPE0SDH5bAMKHqg0QAkp7DeBcy/Rkm1yP2l6EjwsoY+GoJJyMCZosT0HnIRHc
	Ma5fJqjy48RRxqxlg6ux/BoqGtHDkweUpu/N7CJtmi/3pN/sKvYZ920FjS8DO6+VVEnGUigkxYc
	iMAjah5TaYPz60a3+rKwrMjyRqQgX1Wozqi1IaJNd6p08BUJ
X-Google-Smtp-Source: AGHT+IHzIPW0COtsbKy6olSoxC0NNJSd1yTzQfzQ9tFbnZt+lQ9G+iYYH4v0xt6Hk5YVZ6vJEql6xQ==
X-Received: by 2002:a05:600c:2e48:b0:439:98ca:e3a4 with SMTP id 5b1f17b1804b1-43bd29b4cdbmr26703275e9.19.1741187265872;
        Wed, 05 Mar 2025 07:07:45 -0800 (PST)
Received: from pop-os.lan ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-391288b54cbsm155121f8f.28.2025.03.05.07.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:07:45 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 05 Mar 2025 15:07:19 +0000
Subject: [PATCH v2] coresight: Add a KUnit test for
 coresight_find_default_sink()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-james-cs-kunit-test-v2-1-83ba682b976c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKZoyGcC/yWNQQ6CMBBFr0K6tqQdKEZX3sOwaGCAEWxNpxIN6
 d2tsHwv+e9vgjEQsrgWmwi4EpN3GeBUiG6ybkRJfWYBCoyqlJEP+0SWHcv57SjKiBxlZQfdD1A
 rjY3Iy1fAgT579d5mnoijD9/9ZNV/e/QAjG7qprqUBuBca6mPfNktNsy3hZwNvvRhFG1K6Qemt
 o2JrAAAAA==
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

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v2:
- Let devm free everything rather than doing individual kfrees:
  "Like with managed drivers, KUnit-managed fake devices are
  automatically cleaned up when the test finishes, but can be manually
  cleaned up early with kunit_device_unregister()."
- Link to v1: https://lore.kernel.org/r/20250225164639.522741-1-james.clark@linaro.org
---
 drivers/hwtracing/coresight/Kconfig                |  9 +++
 drivers/hwtracing/coresight/Makefile               |  3 +-
 drivers/hwtracing/coresight/coresight-core.c       |  1 +
 .../hwtracing/coresight/coresight-kunit-tests.c    | 77 ++++++++++++++++++++++
 4 files changed, 88 insertions(+), 2 deletions(-)

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
index 8e62c3150aeb..96f0dfedb1bf 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -51,5 +51,4 @@ coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 		   coresight-cti-sysfs.o
 obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
 obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
-obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
-coresight-ctcu-y := coresight-ctcu-core.o
+obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index bd0a7edd38c9..b101aa133ceb 100644
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
index 000000000000..a136af05eaf4
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-kunit-tests.c
@@ -0,0 +1,77 @@
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
base-commit: eeafe6a8790ea125252ca2e23c1a2469eaff1d9a
change-id: 20250305-james-cs-kunit-test-3af1df2401e6

Best regards,
-- 
James Clark <james.clark@linaro.org>


