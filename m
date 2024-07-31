Return-Path: <linux-kernel+bounces-269342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456739431C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E92281695
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B17E1B3F0B;
	Wed, 31 Jul 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpTFnEPT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921CB1B373D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435210; cv=none; b=pqfGaM4k2xx/OwtC/uqWGXgQk1NmbDG91EAw6DSh9ngZzFIsPui16mrC66izK6sc9t3r8pdyqq06zg9w+4wYRLPkOUQOgu2hVvKwqv6CgU7fs0FURLXlvs9oDtUIHLJ6HVEJ7rSSTKapyQS1cXSLfw215EI4eM2z8tk0jvXE/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435210; c=relaxed/simple;
	bh=mngt3BW+BIWdKvcOiCDQrrn9zTwGkfCgrTiQlrBag/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nsZg1xu97+H26xGsiEdz6jdBkXQ/D7Se/55c2kDEZreDj1s5Bdyfog9Whs0n+SngYbi7ZJGpaa5gI8ZhFFyALL9aWsX7FJJHeHbScj/1N1oFUSxoU0OvlA/uGhR4Fv40ylh3DyWTgLXqt9hSZjTA2iHr0ThCrSo05fk6wsF0JNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpTFnEPT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722435208; x=1753971208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mngt3BW+BIWdKvcOiCDQrrn9zTwGkfCgrTiQlrBag/w=;
  b=CpTFnEPTBy+qeGdKw1Z8PNeASIGyOGOs5RPEB+bZMNTtolJk6G3Y0Dxr
   3m84MlcgNMKrlMNkmhU1cZSv3ouB/FYH8I1jXpQa6IsN/CQm+EngrGQMz
   9C1lA9P2061VmTFHh3L2A63qfXxyKCCG7rosT6pwcCYuVKT94FCfoTDKK
   lFNrhFPq7TIPPfL3f/1vK4ieOZ3jcIL6WIYbdqmMo5v8RXXrj0TWJf//z
   ub64Lx1+ydD2ceeGE3IRqDb9AwGdRXGKMuYpULVCF8UFUqAvi1A8zO7zT
   4VxQrmj/eaLvouj7XMOTUspqpkmgd/fouxajh+msQuv2MQtI6Li1Mf0Uy
   A==;
X-CSE-ConnectionGUID: scqusNdkS5iV6UiwWx+ycA==
X-CSE-MsgGUID: ScLQeVXSQ3y23p4atNemcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20011618"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20011618"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:13:26 -0700
X-CSE-ConnectionGUID: OG5Xp1HgRgWh5D9/ovuJOQ==
X-CSE-MsgGUID: +cUPXhlhSViCdHf3XyIfsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54357881"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 31 Jul 2024 07:13:25 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/5] perf/x86/intel/uncore: Factor out common MMIO init and ops functions
Date: Wed, 31 Jul 2024 07:13:50 -0700
Message-Id: <20240731141353.759643-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240731141353.759643-1-kan.liang@linux.intel.com>
References: <20240731141353.759643-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Some uncore PMON registers are located in the MMIO space. For the client
machine, the MMIO space is usually located at D0:F0 but in a different
BAR. For example, some uncore PMON registers are located in the SAF BAR,
not the MCHBAR in the Lunar Lake.

The current __uncore_imc_init_box() hard code the BAR information.
Factor out the uncore_get_box_mmio_addr() which uses the BAR information
as a parameter.
The only change is the error output message. The hardcode name 'MCHBAR'
is replaced by the offset of a BAR.

Add a new macro, MMIO_UNCORE_COMMON_OPS(), since the MMIO ops functions
are usually the same among different generations.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 47 +++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 9462fd9f3b7a..05fe6e90bd8e 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1481,33 +1481,35 @@ static struct pci_dev *tgl_uncore_get_mc_dev(void)
 #define TGL_UNCORE_MMIO_IMC_MEM_OFFSET		0x10000
 #define TGL_UNCORE_PCI_IMC_MAP_SIZE		0xe000
 
-static void __uncore_imc_init_box(struct intel_uncore_box *box,
-				  unsigned int base_offset)
+static void
+uncore_get_box_mmio_addr(struct intel_uncore_box *box,
+			 unsigned int base_offset,
+			 int bar_offset, int step)
 {
 	struct pci_dev *pdev = tgl_uncore_get_mc_dev();
 	struct intel_uncore_pmu *pmu = box->pmu;
 	struct intel_uncore_type *type = pmu->type;
 	resource_size_t addr;
-	u32 mch_bar;
+	u32 bar;
 
 	if (!pdev) {
 		pr_warn("perf uncore: Cannot find matched IMC device.\n");
 		return;
 	}
 
-	pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET, &mch_bar);
-	/* MCHBAR is disabled */
-	if (!(mch_bar & BIT(0))) {
-		pr_warn("perf uncore: MCHBAR is disabled. Failed to map IMC free-running counters.\n");
+	pci_read_config_dword(pdev, bar_offset, &bar);
+	if (!(bar & BIT(0))) {
+		pr_warn("perf uncore: BAR 0x%x is disabled. Failed to map %s counters.\n",
+			bar_offset, type->name);
 		pci_dev_put(pdev);
 		return;
 	}
-	mch_bar &= ~BIT(0);
-	addr = (resource_size_t)(mch_bar + TGL_UNCORE_MMIO_IMC_MEM_OFFSET * pmu->pmu_idx);
+	bar &= ~BIT(0);
+	addr = (resource_size_t)(bar + step * pmu->pmu_idx);
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
-	pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET + 4, &mch_bar);
-	addr |= ((resource_size_t)mch_bar << 32);
+	pci_read_config_dword(pdev, bar_offset + 4, &bar);
+	addr |= ((resource_size_t)bar << 32);
 #endif
 
 	addr += base_offset;
@@ -1518,6 +1520,14 @@ static void __uncore_imc_init_box(struct intel_uncore_box *box,
 	pci_dev_put(pdev);
 }
 
+static void __uncore_imc_init_box(struct intel_uncore_box *box,
+				  unsigned int base_offset)
+{
+	uncore_get_box_mmio_addr(box, base_offset,
+				 SNB_UNCORE_PCI_IMC_BAR_OFFSET,
+				 TGL_UNCORE_MMIO_IMC_MEM_OFFSET);
+}
+
 static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
 	__uncore_imc_init_box(box, 0);
@@ -1612,14 +1622,17 @@ static void adl_uncore_mmio_enable_box(struct intel_uncore_box *box)
 	writel(0, box->io_addr + uncore_mmio_box_ctl(box));
 }
 
+#define MMIO_UNCORE_COMMON_OPS()				\
+	.exit_box	= uncore_mmio_exit_box,		\
+	.disable_box	= adl_uncore_mmio_disable_box,	\
+	.enable_box	= adl_uncore_mmio_enable_box,	\
+	.disable_event	= intel_generic_uncore_mmio_disable_event,	\
+	.enable_event	= intel_generic_uncore_mmio_enable_event,	\
+	.read_counter	= uncore_mmio_read_counter,
+
 static struct intel_uncore_ops adl_uncore_mmio_ops = {
 	.init_box	= adl_uncore_imc_init_box,
-	.exit_box	= uncore_mmio_exit_box,
-	.disable_box	= adl_uncore_mmio_disable_box,
-	.enable_box	= adl_uncore_mmio_enable_box,
-	.disable_event	= intel_generic_uncore_mmio_disable_event,
-	.enable_event	= intel_generic_uncore_mmio_enable_event,
-	.read_counter	= uncore_mmio_read_counter,
+	MMIO_UNCORE_COMMON_OPS()
 };
 
 #define ADL_UNC_CTL_CHMASK_MASK			0x00000f00
-- 
2.38.1


