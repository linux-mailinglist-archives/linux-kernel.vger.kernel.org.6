Return-Path: <linux-kernel+bounces-281562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F9D94D82C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341BD284209
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C8A16B3A5;
	Fri,  9 Aug 2024 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIfsOsyY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4992168492;
	Fri,  9 Aug 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236417; cv=none; b=kqC966Lkkdad9QLcbArLOlgQQo0McGSTsqOi3sjp6+FVM7bX44eb1ELPCOSutD9lUZ9iyanKzD6czpTenb9qZxBJGRX1NHI1Z+OG4VHW0+RGHX0gkLyuR0NJnS8pFLum+nQ79Mmiu8XHpKtwfRqojytxemdm1hER0BoxTKjxe1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236417; c=relaxed/simple;
	bh=/zE+BSZ/3HMRCl2lK2FYfTGl+XHZf+n0s5cMsL0zoDk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfBs3IvGN9/y3eubfKbiWh2ppt94Kf5NueEmjVvvDsvC8QnNNd76e7UGDHMUsAQRFk21OsqceH6c9fZ4XuhESoP+iguPh//OKrLJrLoYvUdSmBQ2jSjJeqWMQTfSrP72jZQztms+rIU3cCWLaLJRJmHkmutB4Hw1c9Pvs0tpE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIfsOsyY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723236415; x=1754772415;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/zE+BSZ/3HMRCl2lK2FYfTGl+XHZf+n0s5cMsL0zoDk=;
  b=fIfsOsyYR0mjZXCp5q+6yziSZPqBEhyvzPev7i+rfPHxx7AweBulxgTH
   G+Ats0Z3tiJmkCog31ECa4oT6uoYfGKeqmPb/Qv9RUMr80aHi0O73k+1z
   kdkdff0s584OZpj9+5YztOttRb/Fm6Gq1kL8MfryLkA1t8h4yNczespWN
   NeFf4PY+9b+V5C9BNqCtlx7b+qYNO9fiz2dbg4WzVfYppblpdYhRF0te1
   drqBd3yT0D1HF9kTiGdGYZQC3uJJSM+m2KbLjZhmq2YUmlUUKJCttS83V
   EMLhUm+ILUoLXj+cG0fsO3YF7j3SjjXJMXp22Wh1T2Gk/XNaLJC2JoWMv
   Q==;
X-CSE-ConnectionGUID: rqC4fBXTSvuoCn1Pv1xnNg==
X-CSE-MsgGUID: 5E9ikdo3SA+odHRCqwc1uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32819022"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="32819022"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:54 -0700
X-CSE-ConnectionGUID: 9gd1eR9xSOqRxlbReCCF1A==
X-CSE-MsgGUID: bZJiWag4RjWaa2eyKEMkSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57650473"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.221.156])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:53 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] platform/x86:intel/pmc: Add support to get PMC information from SSRAM
Date: Fri,  9 Aug 2024 13:46:32 -0700
Message-ID: <20240809204648.1124545-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
References: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PWRMBASE address and devid for PMCs are available through API of
Intel PMC SSRAM Telemetry driver. Add support to discover and achieve
the information for each available PMC. Use PMC devid to find and
assign the corresponding register map.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Kconfig |  1 +
 drivers/platform/x86/intel/pmc/core.c  | 64 ++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h  |  1 +
 3 files changed, 66 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
index fe33348cd7e2..56c6d3650bf7 100644
--- a/drivers/platform/x86/intel/pmc/Kconfig
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -7,6 +7,7 @@ config INTEL_PMC_CORE
 	tristate "Intel PMC Core driver"
 	depends on PCI
 	depends on ACPI
+	depends on INTEL_PMC_SSRAM_TELEMETRY || !INTEL_PMC_SSRAM_TELEMETRY
 	depends on INTEL_PMT_TELEMETRY
 	help
 	  The Intel Platform Controller Hub for Intel Core SoCs provides access
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 5ecf55176734..634b4d939ed2 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -28,6 +28,7 @@
 #include <asm/tsc.h>
 
 #include "core.h"
+#include "ssram_telemetry.h"
 #include "../pmt/telemetry.h"
 
 /* Maximum number of modes supported by platfoms that has low power mode capability */
@@ -1146,6 +1147,69 @@ int get_primary_reg_base(struct pmc *pmc)
 	return 0;
 }
 
+static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
+{
+	for (; list->map; ++list)
+		if (devid == list->devid)
+			return list->map;
+
+	return NULL;
+}
+
+static int pmc_core_ssram_pmc_add(struct pmc_dev *pmcdev, int pmc_idx)
+{
+	const struct pmc_reg_map *map;
+	struct pmc_ssram_telemetry pmc_ssram_telemetry;
+	struct pmc *pmc;
+	int ret;
+
+	ret = pmc_ssram_telemetry_get_pmc_info(pmc_idx, &pmc_ssram_telemetry);
+	if (ret)
+		return ret;
+
+	map = pmc_core_find_regmap(pmcdev->regmap_list, pmc_ssram_telemetry.devid);
+	if (!map)
+		return -ENODEV;
+
+	pmc = pmcdev->pmcs[pmc_idx];
+	/* Memory for primary PMC has been allocated in core.c */
+	if (!pmc) {
+		pmc = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL);
+		if (!pmc)
+			return -ENOMEM;
+	}
+
+	pmc->map = map;
+	pmc->base_addr = pmc_ssram_telemetry.base_addr;
+	pmc->regbase = ioremap(pmc->base_addr, pmc->map->regmap_length);
+
+	if (!pmc->regbase) {
+		devm_kfree(&pmcdev->pdev->dev, pmc);
+		return -ENOMEM;
+	}
+
+	pmcdev->pmcs[pmc_idx] = pmc;
+
+	return 0;
+}
+
+int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev)
+{
+	int ret;
+
+	if (!pmcdev->regmap_list)
+		return -ENOENT;
+
+	ret = pmc_core_ssram_pmc_add(pmcdev, PMC_IDX_MAIN);
+	if (ret)
+		return ret;
+
+	pmc_core_ssram_pmc_add(pmcdev, PMC_IDX_IOE);
+	pmc_core_ssram_pmc_add(pmcdev, PMC_IDX_PCH);
+
+	return 0;
+}
+
 void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid)
 {
 	struct telem_endpoint *ep;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 1e5726745394..890caf558307 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -591,6 +591,7 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
+extern int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev);
 extern void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
 extern void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid);
 extern void pmc_core_set_device_d3(unsigned int device);
-- 
2.43.0


