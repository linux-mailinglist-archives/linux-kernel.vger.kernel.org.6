Return-Path: <linux-kernel+bounces-533067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7141A4555C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46276178950
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800A019D884;
	Wed, 26 Feb 2025 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXssJtrD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBDE267B8C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550564; cv=none; b=SH610IT8AHDzIYnB85Gw/fk2JbXQ4fe1ysMo97EXaI5AWPiCqgGHw00w7uvEsZkDq1jL1xcXIOh3IV4F+why/DHDQd4gNzpygWczqNQGXVOlyJIwb1yJlEEI17n9eQO+2FBRSgDvrnNS1kAPbP4e2CX3GUe10mdQq/S+4KqTS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550564; c=relaxed/simple;
	bh=fL15Jsr61B1GQqgDCS/azMV/QxVm1WMx209HESNsFpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FI595bHnfiLN7AsffDu53/ZAlYyaOUtyPWM9lsNACotLr0sbn9yLPWHmjSBn3XshyaFkKUxc/fOPq2EUbIXukqSzEqUVt2FPL14sg1goKU9kNDUI1DZAVVCNC3fEvmBuJcdgRDvU05igbMZ0dBoy04u68T+9vRv/c5/XX4ot/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXssJtrD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740550563; x=1772086563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fL15Jsr61B1GQqgDCS/azMV/QxVm1WMx209HESNsFpk=;
  b=FXssJtrDbyBixvDwRUVqtY4XoESJ6gwAZ9fb+0PTsdO6Z9fzkRXTKZZd
   pYTon0JJr6WbzTpltw7HCg5vT4ru1Voq3taeoHGaVtGZQGKuIPsSW0/Z7
   60cwNkB6XMu8jVBha93qsblsx6UOwqcsQgclAcGG7lL2LVXSw3d7ak5Ii
   aNwYYfJKc6Z7XbrfyHUYEikCCM2wcy3fCpo15SZVQUoEKvsLo6cto5nfm
   mDnn1s+MY3kNkMVX7BP4oENq2lisgtxftpNk0hLXZrFr3PlFnebDWIeUy
   SVCViOzKlBtdOsuoc4ThUVwKbp+424MHLL8lpjisoHDcZtHfo93VB4aov
   w==;
X-CSE-ConnectionGUID: p/fudASURZOX1jinn7xqzw==
X-CSE-MsgGUID: eNF/yfTCSl2JYb2RWdBfKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41636477"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41636477"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:16:03 -0800
X-CSE-ConnectionGUID: U/jp8+iHQv+CPBOC/x7G+w==
X-CSE-MsgGUID: i6ODD32AQWStoGIa37nAhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="147434828"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa002.jf.intel.com with ESMTP; 25 Feb 2025 22:16:00 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: lee@kernel.org,
	giometti@enneenne.com,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	raymond.tan@intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/4] pps: generators: tio: move to match_data() model
Date: Wed, 26 Feb 2025 11:45:25 +0530
Message-Id: <20250226061527.3031250-3-raag.jadav@intel.com>
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

Use device_get_match_data() which allows configuring platform
specific data like number of pins and MMIO registers for TIO.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pps/generators/pps_gen_tio.c | 33 ++++++++++++++++++++--------
 drivers/pps/generators/pps_gen_tio.h | 19 +++++++++++++---
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
index 7f2aab1219af..89b08301d21e 100644
--- a/drivers/pps/generators/pps_gen_tio.c
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pps_gen_kernel.h>
+#include <linux/property.h>
 #include <linux/timekeeping.h>
 #include <linux/types.h>
 
@@ -21,6 +22,14 @@
 
 #include "pps_gen_tio.h"
 
+static const struct pps_tio_data pmc_data = {
+	.regs = {
+		.ctl = TIOCTL_PMC,
+		.compv = TIOCOMPV_PMC,
+		.ec = TIOEC_PMC,
+	},
+};
+
 static inline u32 pps_tio_read(u32 offset, struct pps_tio *tio)
 {
 	return readl(tio->base + offset);
@@ -28,7 +37,7 @@ static inline u32 pps_tio_read(u32 offset, struct pps_tio *tio)
 
 static inline void pps_ctl_write(u32 value, struct pps_tio *tio)
 {
-	writel(value, tio->base + TIOCTL);
+	writel(value, tio->base + tio->regs.ctl);
 }
 
 /*
@@ -37,7 +46,7 @@ static inline void pps_ctl_write(u32 value, struct pps_tio *tio)
  */
 static inline void pps_compv_write(u64 value, struct pps_tio *tio)
 {
-	hi_lo_writeq(value, tio->base + TIOCOMPV);
+	hi_lo_writeq(value, tio->base + tio->regs.compv);
 }
 
 static inline ktime_t first_event(struct pps_tio *tio)
@@ -49,7 +58,7 @@ static u32 pps_tio_disable(struct pps_tio *tio)
 {
 	u32 ctrl;
 
-	ctrl = pps_tio_read(TIOCTL, tio);
+	ctrl = pps_tio_read(tio->regs.ctl, tio);
 	pps_compv_write(0, tio);
 
 	ctrl &= ~TIOCTL_EN;
@@ -63,7 +72,7 @@ static void pps_tio_enable(struct pps_tio *tio)
 {
 	u32 ctrl;
 
-	ctrl = pps_tio_read(TIOCTL, tio);
+	ctrl = pps_tio_read(tio->regs.ctl, tio);
 	ctrl |= TIOCTL_EN;
 	pps_ctl_write(ctrl, tio);
 	tio->pps_gen->enabled = true;
@@ -112,7 +121,7 @@ static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
 	 * Check if any event is missed.
 	 * If an event is missed, TIO will be disabled.
 	 */
-	event_count = pps_tio_read(TIOEC, tio);
+	event_count = pps_tio_read(tio->regs.ec, tio);
 	if (tio->prev_count && tio->prev_count == event_count)
 		goto err;
 	tio->prev_count = event_count;
@@ -172,6 +181,7 @@ static int pps_tio_get_time(struct pps_gen_device *pps_gen,
 static int pps_gen_tio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct pps_tio_data *data;
 	struct pps_tio *tio;
 
 	if (!(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ) &&
@@ -184,6 +194,11 @@ static int pps_gen_tio_probe(struct platform_device *pdev)
 	if (!tio)
 		return -ENOMEM;
 
+	data = device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
+	tio->regs = data->regs;
 	tio->gen_info.use_system_clock = true;
 	tio->gen_info.enable = pps_tio_gen_enable;
 	tio->gen_info.get_time = pps_tio_get_time;
@@ -217,10 +232,10 @@ static void pps_gen_tio_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id intel_pmc_tio_acpi_match[] = {
-	{ "INTC1021" },
-	{ "INTC1022" },
-	{ "INTC1023" },
-	{ "INTC1024" },
+	{ "INTC1021", (kernel_ulong_t)&pmc_data },
+	{ "INTC1022", (kernel_ulong_t)&pmc_data },
+	{ "INTC1023", (kernel_ulong_t)&pmc_data },
+	{ "INTC1024", (kernel_ulong_t)&pmc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, intel_pmc_tio_acpi_match);
diff --git a/drivers/pps/generators/pps_gen_tio.h b/drivers/pps/generators/pps_gen_tio.h
index 78d4d7c25221..e652f976e455 100644
--- a/drivers/pps/generators/pps_gen_tio.h
+++ b/drivers/pps/generators/pps_gen_tio.h
@@ -14,9 +14,10 @@
 #include <linux/pps_gen_kernel.h>
 #include <linux/spinlock_types.h>
 
-#define TIOCTL			0x00
-#define TIOCOMPV		0x10
-#define TIOEC			0x30
+/* PMC Registers */
+#define TIOCTL_PMC			0x00
+#define TIOCOMPV_PMC			0x10
+#define TIOEC_PMC			0x30
 
 /* Control Register */
 #define TIOCTL_EN			BIT(0)
@@ -32,9 +33,21 @@
 #define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
 #define ART_HW_DELAY_CYCLES		2
 
+struct pps_tio_regs {
+	u32 ctl;
+	u32 compv;
+	u32 ec;
+};
+
+struct pps_tio_data {
+	struct pps_tio_regs regs;
+	u32 num_pins;
+};
+
 struct pps_tio {
 	struct pps_gen_source_info gen_info;
 	struct pps_gen_device *pps_gen;
+	struct pps_tio_regs regs;
 	struct hrtimer timer;
 	void __iomem *base;
 	u32 prev_count;
-- 
2.34.1


