Return-Path: <linux-kernel+bounces-533066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA4A4555B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1260C1785AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C276E267B18;
	Wed, 26 Feb 2025 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAwU6wZd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB53219DF53
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550562; cv=none; b=fF8R6ptCVDNarPho2B4pSIKw/AkHx7Qic1rSaXVQHbPmJbmiGRaERQHuKaoooU4N8ND+LJK9N33StZqO2huPsIoie78BkLyI74pqycz1HMLv/3qEVwsYwbbcKdMh11wbebBlQPCRCt9qv5K7BvhC102bQNiQatUVH37SJjv8zwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550562; c=relaxed/simple;
	bh=+wmqNzsPb9JNb7hDRUOSQbXWp2AYZYjt9EsKtcDB9mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adjBbzY5Hr+VzT+WW8OALo3up61RbZYSyRv5jDz49xcUGGf7BhK/0tM2FjPDLM9VryMIIf76lzrjAGOqGMjQtye3moDDSUQsJMTUfDtj4wGajwDgy7VTrvhLPDeJsoSFg9Jk6bqBSncJSJhj9VJ53p4qiz3PCOJKIHF8ISVcNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAwU6wZd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740550561; x=1772086561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+wmqNzsPb9JNb7hDRUOSQbXWp2AYZYjt9EsKtcDB9mg=;
  b=lAwU6wZdojB3z+Foa5jxvDXV39H64M1ykXSzjBoSLnRHvRiUrtM1fu2Y
   Z5vS/S0xC9Hvw6Nrg2UQtWGQhdvxL3P9B7pu6R+c4dEFHF1qA3uCucAyh
   LY2Jn897M2VB661ageL/Nu4iRfJYdsEBpcRRaPlD1IBncVmhRHcKqDQ3y
   pwrRugYYA2Bymqd7NZ0of16dQg9PfEozAuMZXFzKZXL8GxDjNR5VHVWxH
   UQWaU1HvcepmCxPhgwunkMIIznPhHEpFdDlvYy3LkZJuryGIFZTLucMnM
   kj5qHCM8YZMK5v4HYCN9aig7g+tpkSQuG3B8ZdH0FatzIwRezdUJriT99
   A==;
X-CSE-ConnectionGUID: dnwwHLymRMmkVvVsL4uwRA==
X-CSE-MsgGUID: 0t3s7q+SSKSg9mq+vAb5+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41636473"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41636473"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:16:01 -0800
X-CSE-ConnectionGUID: kRI8l5sJQL6q9HKMpfY+qA==
X-CSE-MsgGUID: U3FvgqJcSYWr37upsTpAdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="147434825"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa002.jf.intel.com with ESMTP; 25 Feb 2025 22:15:58 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: lee@kernel.org,
	giometti@enneenne.com,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	raymond.tan@intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/4] pps: generators: tio: split pps_gen_tio.h
Date: Wed, 26 Feb 2025 11:45:24 +0530
Message-Id: <20250226061527.3031250-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226061527.3031250-1-raag.jadav@intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split macros and structure definition to header file for better
maintainability.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pps/generators/pps_gen_tio.c | 30 +------------------
 drivers/pps/generators/pps_gen_tio.h | 45 ++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 29 deletions(-)
 create mode 100644 drivers/pps/generators/pps_gen_tio.h

diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
index 6c46b46c66cd..7f2aab1219af 100644
--- a/drivers/pps/generators/pps_gen_tio.c
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2024 Intel Corporation
  */
 
-#include <linux/bitfield.h>
-#include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/container_of.h>
 #include <linux/device.h>
@@ -21,33 +19,7 @@
 
 #include <asm/cpu_device_id.h>
 
-#define TIOCTL			0x00
-#define TIOCOMPV		0x10
-#define TIOEC			0x30
-
-/* Control Register */
-#define TIOCTL_EN			BIT(0)
-#define TIOCTL_DIR			BIT(1)
-#define TIOCTL_EP			GENMASK(3, 2)
-#define TIOCTL_EP_RISING_EDGE		FIELD_PREP(TIOCTL_EP, 0)
-#define TIOCTL_EP_FALLING_EDGE		FIELD_PREP(TIOCTL_EP, 1)
-#define TIOCTL_EP_TOGGLE_EDGE		FIELD_PREP(TIOCTL_EP, 2)
-
-/* Safety time to set hrtimer early */
-#define SAFE_TIME_NS			(10 * NSEC_PER_MSEC)
-
-#define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
-#define ART_HW_DELAY_CYCLES		2
-
-struct pps_tio {
-	struct pps_gen_source_info gen_info;
-	struct pps_gen_device *pps_gen;
-	struct hrtimer timer;
-	void __iomem *base;
-	u32 prev_count;
-	spinlock_t lock;
-	struct device *dev;
-};
+#include "pps_gen_tio.h"
 
 static inline u32 pps_tio_read(u32 offset, struct pps_tio *tio)
 {
diff --git a/drivers/pps/generators/pps_gen_tio.h b/drivers/pps/generators/pps_gen_tio.h
new file mode 100644
index 000000000000..78d4d7c25221
--- /dev/null
+++ b/drivers/pps/generators/pps_gen_tio.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Intel PPS signal Generator Driver
+ *
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#ifndef _PPS_GEN_TIO_H_
+#define _PPS_GEN_TIO_H_
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/hrtimer.h>
+#include <linux/pps_gen_kernel.h>
+#include <linux/spinlock_types.h>
+
+#define TIOCTL			0x00
+#define TIOCOMPV		0x10
+#define TIOEC			0x30
+
+/* Control Register */
+#define TIOCTL_EN			BIT(0)
+#define TIOCTL_DIR			BIT(1)
+#define TIOCTL_EP			GENMASK(3, 2)
+#define TIOCTL_EP_RISING_EDGE		FIELD_PREP(TIOCTL_EP, 0)
+#define TIOCTL_EP_FALLING_EDGE		FIELD_PREP(TIOCTL_EP, 1)
+#define TIOCTL_EP_TOGGLE_EDGE		FIELD_PREP(TIOCTL_EP, 2)
+
+/* Safety time to set hrtimer early */
+#define SAFE_TIME_NS			(10 * NSEC_PER_MSEC)
+
+#define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
+#define ART_HW_DELAY_CYCLES		2
+
+struct pps_tio {
+	struct pps_gen_source_info gen_info;
+	struct pps_gen_device *pps_gen;
+	struct hrtimer timer;
+	void __iomem *base;
+	u32 prev_count;
+	spinlock_t lock;
+	struct device *dev;
+};
+
+#endif /* _PPS_GEN_TIO_H_ */
-- 
2.34.1


