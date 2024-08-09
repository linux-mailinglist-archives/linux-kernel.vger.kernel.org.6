Return-Path: <linux-kernel+bounces-281565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8CA94D834
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18355B23815
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8682516D4E9;
	Fri,  9 Aug 2024 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGLPVX1z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BBD16ABF3;
	Fri,  9 Aug 2024 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236419; cv=none; b=X5hHqP0orfp/cNPWS1zoYRAtwNmpA2viNSJV7vmi/WcsIYstQmyj8lrizG9ZXy7aWIV+66DfYBwkX5ykAMbITSfd0ZZj6AvJ5O9GxUbAAtr66bPf18eb9Cyz2jQlK5hl283c05Y9Wg5JZ1ElE5YXRj1kJvBocLKZh1lhqAZVdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236419; c=relaxed/simple;
	bh=w1RbDRKZWHheMY/7F5JOO8KYIhL1NQO34Q0BAnCPdAo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqEjFmIjs5CVJUzYH2UKcEnk5bKNX5Do2jKw5td8NxPHebrQZvrMd5bxdUbQHsBbUVDFz4kheERMIcJoviRWNp0LXS34XcC4+yh9BiazGK7aNKgvleLKFxFF2uRZKkmJMVB9uhXmRwhJPzIFvL2MgmQlGuFhmNzjUVvzGlOPWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGLPVX1z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723236418; x=1754772418;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=w1RbDRKZWHheMY/7F5JOO8KYIhL1NQO34Q0BAnCPdAo=;
  b=BGLPVX1zODYEOL2F3iuWXjkZugmjsLktJOWgs2/j1/ahC5KAp7wGmSC8
   yk1vKJyNrQdQHLUxqDcxnIId7mv0w03zes8VQ+xu8trugrL1zBa1Yt8Zu
   9aG8uHyUYtIoNQUueLNxMDo8rU8YgG/BnWbFvwZgFZ8t5DCA8NPhqDWLk
   06OYHO6W2jEYSxQoapkhYXXYYmHSdVkK/28dutLXd9/YHZDZSrIFS8DXk
   vZfBAihw7+ah94CkSc/OJlOtXeiDgj/Ysd8smZme8jsEbjSQ/Wa9ebqhD
   t36PEkf1sNtFdK7KboUfMu9fgjJHLDcwMZfRcTnvstAXn3YVsD5j5fV50
   Q==;
X-CSE-ConnectionGUID: bSQ9pK3oT9mNwRm2m21xEA==
X-CSE-MsgGUID: o03FRugVRO+iHje9iUX2cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32819037"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="32819037"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:57 -0700
X-CSE-ConnectionGUID: Qux7MxnUTqe13OyvvDdZnw==
X-CSE-MsgGUID: Oi0woNXWRlq9qV/C01kcfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57650476"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.221.156])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:55 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] platform/x86:intel/pmc: Add support to Retrieve LPM information
Date: Fri,  9 Aug 2024 13:46:35 -0700
Message-ID: <20240809204648.1124545-7-xi.pardee@linux.intel.com>
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

On supported platforms, the low power mode (LPM) requirements for entering
each idle substate are described in Platform Monitoring Technology (PMT)
telemetry entries. Add support to find and read the requirements from the
telemetry entries.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Kconfig |   2 +-
 drivers/platform/x86/intel/pmc/core.c  | 146 +++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h  |   6 +
 3 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
index 56c6d3650bf7..b77f1fb84b4d 100644
--- a/drivers/platform/x86/intel/pmc/Kconfig
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -8,7 +8,7 @@ config INTEL_PMC_CORE
 	depends on PCI
 	depends on ACPI
 	depends on INTEL_PMC_SSRAM_TELEMETRY || !INTEL_PMC_SSRAM_TELEMETRY
-	depends on INTEL_PMT_TELEMETRY
+	depends on INTEL_PMT_TELEMETRY || !INTEL_PMT_TELEMETRY
 	help
 	  The Intel Platform Controller Hub for Intel Core SoCs provides access
 	  to Power Management Controller registers via various interfaces. This
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 634b4d939ed2..379676d08136 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -785,6 +785,152 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
 
+static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *map)
+{
+	for (; list->map; ++list)
+		if (list->map == map)
+			return list->guid;
+
+	return 0;
+}
+
+static int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, int func)
+{
+	struct telem_endpoint *ep;
+	const u8 *lpm_indices;
+	int num_maps, mode_offset = 0;
+	struct pci_dev *pcidev;
+	int ret, mode, i;
+	int lpm_size;
+	u32 guid;
+
+	lpm_indices = pmc->map->lpm_reg_index;
+	num_maps = pmc->map->lpm_num_maps;
+	lpm_size = LPM_MAX_NUM_MODES * num_maps;
+
+	guid = pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
+	if (!guid)
+		return -ENXIO;
+
+	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
+	if (!pcidev)
+		return -ENODEV;
+
+	ep = pmt_telem_find_and_register_endpoint(pcidev, guid, 0);
+	if (IS_ERR(ep)) {
+		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
+			PTR_ERR(ep));
+		ret = -EPROBE_DEFER;
+		goto release_dev;
+	}
+
+	pmc->lpm_req_regs = devm_kzalloc(&pmcdev->pdev->dev,
+					 lpm_size * sizeof(u32),
+					 GFP_KERNEL);
+	if (!pmc->lpm_req_regs) {
+		ret = -ENOMEM;
+		goto unregister_ep;
+	}
+
+	/*
+	 * PMC Low Power Mode (LPM) table
+	 *
+	 * In telemetry space, the LPM table contains a 4 byte header followed
+	 * by 8 consecutive mode blocks (one for each LPM mode). Each block
+	 * has a 4 byte header followed by a set of registers that describe the
+	 * IP state requirements for the given mode. The IP mapping is platform
+	 * specific but the same for each block, making for easy analysis.
+	 * Platforms only use a subset of the space to track the requirements
+	 * for their IPs. Callers provide the requirement registers they use as
+	 * a list of indices. Each requirement register is associated with an
+	 * IP map that's maintained by the caller.
+	 *
+	 * Header
+	 * +----+----------------------------+----------------------------+
+	 * |  0 |      REVISION              |      ENABLED MODES         |
+	 * +----+--------------+-------------+-------------+--------------+
+	 *
+	 * Low Power Mode 0 Block
+	 * +----+--------------+-------------+-------------+--------------+
+	 * |  1 |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
+	 * +----+--------------+-------------+-------------+--------------+
+	 * |  2 |           LPM0 Requirements 0                           |
+	 * +----+---------------------------------------------------------+
+	 * |    |                  ...                                    |
+	 * +----+---------------------------------------------------------+
+	 * | 29 |           LPM0 Requirements 27                          |
+	 * +----+---------------------------------------------------------+
+	 *
+	 * ...
+	 *
+	 * Low Power Mode 7 Block
+	 * +----+--------------+-------------+-------------+--------------+
+	 * |    |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
+	 * +----+--------------+-------------+-------------+--------------+
+	 * | 60 |           LPM7 Requirements 0                           |
+	 * +----+---------------------------------------------------------+
+	 * |    |                  ...                                    |
+	 * +----+---------------------------------------------------------+
+	 * | 87 |           LPM7 Requirements 27                          |
+	 * +----+---------------------------------------------------------+
+	 *
+	 */
+	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
+	pmc_for_each_mode(i, mode, pmcdev) {
+		u32 *req_offset = pmc->lpm_req_regs + (mode * num_maps);
+		int m;
+
+		for (m = 0; m < num_maps; m++) {
+			u8 sample_id = lpm_indices[m] + mode_offset;
+
+			ret = pmt_telem_read32(ep, sample_id, req_offset, 1);
+			if (ret) {
+				dev_err(&pmcdev->pdev->dev,
+					"couldn't read Low Power Mode requirements: %d\n", ret);
+				devm_kfree(&pmcdev->pdev->dev, pmc->lpm_req_regs);
+				pmc->lpm_req_regs = NULL;
+				goto unregister_ep;
+			}
+			++req_offset;
+		}
+		mode_offset += LPM_REG_COUNT + LPM_MODE_OFFSET;
+	}
+
+unregister_ep:
+	pmt_telem_unregister_endpoint(ep);
+release_dev:
+	pci_dev_put(pcidev);
+
+	return ret;
+}
+
+int pmc_core_get_lpm_reqs(struct pmc_dev *pmcdev, int func)
+{
+	unsigned int i;
+	int ret;
+
+	if (!IS_REACHABLE(CONFIG_INTEL_PMC_SSRAM_TELEMETRY)) {
+		dev_dbg(&pmcdev->pdev->dev, "INTEL PMC SSRAM device driver is not reachable");
+		return 0;
+	}
+
+	if (!IS_REACHABLE(CONFIG_INTEL_PMT_TELEMETRY)) {
+		dev_dbg(&pmcdev->pdev->dev, "INTEL PMT TELEMETRY driver is not reachable");
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		if (!pmcdev->pmcs[i])
+			continue;
+
+		ret = pmc_core_pmt_get_lpm_req(pmcdev, pmcdev->pmcs[i], func);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
 {
 	struct pmc_dev *pmcdev = s->private;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 07f8c3070ab9..3dc640405590 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -24,6 +24,11 @@ struct telem_endpoint;
 #define MAX_NUM_PMC			3
 #define S0IX_BLK_SIZE			4
 
+/* PCH query */
+#define LPM_HEADER_OFFSET	1
+#define LPM_REG_COUNT		28
+#define LPM_MODE_OFFSET		1
+
 /* Sunrise Point Power Management Controller PCI Device ID */
 #define SPT_PMC_PCI_DEVICE_ID			0x9d21
 #define SPT_PMC_BASE_ADDR_OFFSET		0x48
@@ -590,6 +595,7 @@ extern const struct pmc_bit_map *arl_pchs_lpm_maps[];
 extern const struct pmc_reg_map arl_pchs_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
+extern int pmc_core_get_lpm_reqs(struct pmc_dev *pmcdev, int func);
 int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
-- 
2.43.0


