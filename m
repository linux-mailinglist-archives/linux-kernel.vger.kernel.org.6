Return-Path: <linux-kernel+bounces-557514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 696E8A5DA3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997C41756BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F8F23E235;
	Wed, 12 Mar 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAoOoDZW"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59D23CEE8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774316; cv=none; b=HCSSH91UjJiJJ+2/tPgs93ZLVZPxcG06bT2BBDjOi41SntbDZL63Gu4U8dNEuiZux6awqbzfqIr5VPY4SqAKFeSbGRuqa5IjGHo56ZiXhNmnCv84sRiZ0TrxaVoPHvhwe1byH8zKbs0pGHvFRLwrjjsiikIi4KnuUZaS5chl+aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774316; c=relaxed/simple;
	bh=85oNLfRWbsZVqcvlZKLbA6r3ZEzVL8yQLM1Doy48UOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pAncMGwPitHHjxA+XCa/dAEgHkFnsXEInTIRAJyhCmVvtZPjthSFFmgl266sNOtqna6aVQuhZfiRNx3sDE4ioPDHKI0l2ccsAfreHxWfsHUr+5zeZcWZdhQ6wnwMcfhe6Qs1WSzwVv6fu6jiDTU7u0ZBnyISfgy9xKUEzBA2fQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JAoOoDZW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0782d787so11856035e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741774312; x=1742379112; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZlYkby+d99WJO4NkP3kGBlnCGizroPklc0vRuBvEQU=;
        b=JAoOoDZWT8A3Z8+XTW7CXi9Ho/kAqY5PMxpESYzjf/pl2janwh/XjZNVO0OqV+3gSL
         VWWVmssg2M7W3DtjC9EjnNIFE5bTBHUb8AKQofEbdIZhoRAeAsr6iA+LulVNeRQJWMto
         AMcVutdDWxHKBF2SZKYFqh1wYaVXZ1SrUizClcSRkn4Gi1OT1SBhIZpLbm4vXOP6Xcxj
         4PMFCEcFz5r2d5fB9O9Ap9R6Je1APvasKgBBiYMKZHr5DWSjfuyapRwe2vZOuS2UBDVl
         daUubxLn6DG4/npbDeWp4Wk/B465WbtXG6f6OGgR1gu98UYZ04SmuAwhXJIQZHp0uPIZ
         7Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741774312; x=1742379112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZlYkby+d99WJO4NkP3kGBlnCGizroPklc0vRuBvEQU=;
        b=VQNxvWHMXyC/eh+I+2ycwYfu2i1jiLk625tQ72ka6njAF53JilfJU02DF34VUiFgmH
         KcVgKMfVeGnTnznIxbTLXcK1dpX/uqrBh5aY+khDu/dXu0/gT7kczuefJG52HnSDgeQQ
         mRj+Th9LLLSFbehV/EyfFHMjQrS82Vs2gkoO9TMl61MDzxpz5VIgWeMA8W/HdmoBWQ5l
         gAAUPL1LRV0bKFLuwiO0IevnxVcPn0u53tmqH/r6z6nNYv19HcweQmXd3+44ZBx3yd1Z
         yO6Nvs8c9qN6M7DxcD5s5p2T2+QUc4+6erNWY12cDVwJrSlUtuCn2by7Dq15rHahKOmG
         fT6Q==
X-Gm-Message-State: AOJu0YyMoL/+01gHAZo12Hg0NI0X8qGmPS2xy0xJveuzoSGWP3FuJHcZ
	Qy6PcqqcriXZaY4wvUssxwy/60ZTUFQn2pPMxozNZ2KRLO38i79IARj0oHi1RhE=
X-Gm-Gg: ASbGnct/fi3xFEBMGfvePzSMejA+uLtl2pPtrwNBq1qHyy/4Dn3S/pOKj6LnNLRKXFK
	2Cxs4E/7E/Mq4gLx3J3dqlNJruBEPDFfU9kW3iG2Ta5OkVR+8MsWt+VOR11E0BwjXg4U9SYjYCH
	yyKve+ApPRvWPGX71eR/wmQ90D1HR2YvPbcvPq4oFryZfPzzlVmeKAGpX+eVZKQ930h/iT+GoFc
	Uw/f0lBAieWAdHvyAl36AblNvumBNhQx5p1frvR3uFchbyR6O895IqkiZSOdjmCh4OdJuKrqHpe
	UiirITiDikzS+EMf7rRmLSlts0mi1oExAiz0dYPlNAURWI8=
X-Google-Smtp-Source: AGHT+IEyqbXNIu5wRSJYhj/1fQ2mgsIresA2gnO6jS+UIi0uHFNrXyMS7z2i3K6uTFq/1oJ7VnktOg==
X-Received: by 2002:a05:600c:524c:b0:43d:b32:40aa with SMTP id 5b1f17b1804b1-43d0b32419amr11170515e9.3.1741774312077;
        Wed, 12 Mar 2025 03:11:52 -0700 (PDT)
Received: from pop-os.lan ([209.198.129.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74c2efsm16243635e9.9.2025.03.12.03.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:11:51 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Mar 2025 10:11:29 +0000
Subject: [PATCH v3] coresight: Add a KUnit test for
 coresight_find_default_sink()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-james-cs-kunit-test-v3-1-dcfb69730161@linaro.org>
X-B4-Tracking: v=1; b=H4sIANBd0WcC/3XOQQ6DIBAF0Ks0rIuBQVC76j2aLlBRqRYaoKSN8
 e5FXTRddPkn+e/PjLxyWnl0OszIqai9tiYFdjygZpCmV1i3KSMgwAkjHN/kXXnceDw+jQ44KB8
 wkx1tO8gJVQKl5sOpTr829XJNedA+WPfeRiJdr7sHwKnIBasyDlDkFNOdz5pJuvE8aSOdzazr0
 apE+Db/fRIhGSWrpSihrgrR/CDLsnwAusQmm/EAAAA=
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
index 000000000000..87439769207c
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
+	struct coresight_ops_source src_ops = {};
+	struct coresight_ops etm_cs_ops = { .source_ops	= &src_ops };
+
+	etm->type = CORESIGHT_DEV_TYPE_SOURCE;
+	/*
+	 * Don't use CORESIGHT_DEV_SUBTYPE_SOURCE_PROC, that would always return
+	 * a TRBE sink if one is registered.
+	 */
+	etm->subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_BUS;
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


