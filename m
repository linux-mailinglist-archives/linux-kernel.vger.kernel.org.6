Return-Path: <linux-kernel+bounces-559556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DA9A5F57E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6355B3AD355
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0483A26773B;
	Thu, 13 Mar 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLYItywp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3DB267707
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871326; cv=none; b=VT9lY7o1s+m435WoWVSm9UUtUUTqobsI3AberRoMD28+oZugdmNr4n2IenGTOlpm18zSCRSmWMiI82WO1CHMUQGqnwsfWKQv7CJEsGSFx2m5DVD5Ix2XHgpj3zgwL+G6x/qOVd31SCDMWBPryb70HEPIRcXazLNMEtL27gVbpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871326; c=relaxed/simple;
	bh=X6h+7U18PDU6b6MQCOZeQMzhvNwkAC2Y7364FXjX+js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uksivWrhcIevgn87/1ArY9ooLl+vZy1Nl7PW52pq9Q/UNGLA6M0DQdA80C4JksO30o+hWL+xMlsC2HmWlVbRgd0UPpvwXVfm9wLVLzeUTYhOWfkSFgm45KEurACzxyxl/LKWNJVw9CHPLkECGw0bxmUX+vPgRshqF0xwD7DaFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLYItywp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741871325; x=1773407325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X6h+7U18PDU6b6MQCOZeQMzhvNwkAC2Y7364FXjX+js=;
  b=fLYItywpUJBl3qDNSoM+KWYUkFyRyiN1Pi94/ZqMvozGvPIZ5XsrgZKL
   cwyqAJDujCAOW1W68LreCWoT5apWxs60RmRynFPetJC+Fa2XAzs+jz2E6
   EBLrjsmQYHmT/cxWNd+tZqqUu8k6m2Fh1lKt+vwpup6Ke3Isa9sINTyvM
   rjGWkrnqqzhGjjTmHOquqJKv5CFdzPRPf615RfHuGw6Gd83uHxxHiMvdW
   PxmOdLNldUEdd042BVIKUUCEUnvP1Ik7CfgeheFvboiZcvBrIuRV4bbWd
   bmGFa79BDyzwIvZ/i+Qknk4De0/9UZX0YxfKcxV4NNIUxOR5dpMgH1se+
   Q==;
X-CSE-ConnectionGUID: uI/dU8FaSaiosXEF2dbaQA==
X-CSE-MsgGUID: 7whNhvSYQxy1IbhJFNCQdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53191640"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53191640"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:08:41 -0700
X-CSE-ConnectionGUID: 4byIzV0yRtyqzMd51mIp3w==
X-CSE-MsgGUID: fZNumwTURySm8kPm3UMEKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126011499"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 06:08:41 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/4] perf/x86/intel/uncore: Add Panther Lake support
Date: Thu, 13 Mar 2025 06:08:46 -0700
Message-Id: <20250313130847.4081079-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250313130847.4081079-1-kan.liang@linux.intel.com>
References: <20250313130847.4081079-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The Panther Lake supports CBOX, MC, sNCU, and HBO uncore PMON.

The CBOX is similar to Lunar Lake. The only difference is the number of
CBOX.

The other three uncore PMON can be retrieved from the discovery table.
The global control register resides in the sNCU. The global freeze bit
is set by default. It must be cleared before monitoring any uncore
counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1
- Update the unit ID of sNCU and HBO

 arch/x86/events/intel/uncore.c           |  7 +++
 arch/x86/events/intel/uncore.h           |  2 +
 arch/x86/events/intel/uncore_discovery.h |  4 ++
 arch/x86/events/intel/uncore_snb.c       | 71 ++++++++++++++++++++++++
 arch/x86/events/intel/uncore_snbep.c     |  2 +-
 5 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 24372cf7fdfb..30e1d261307d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1815,6 +1815,12 @@ static const struct intel_uncore_init_fun lnl_uncore_init __initconst = {
 	.mmio_init = lnl_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun ptl_uncore_init __initconst = {
+	.cpu_init = ptl_uncore_cpu_init,
+	.mmio_init = ptl_uncore_mmio_init,
+	.use_discovery = true,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1896,6 +1902,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&ptl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 3dcb88c0ecfa..d8815fff7588 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -612,10 +612,12 @@ void tgl_uncore_cpu_init(void);
 void adl_uncore_cpu_init(void);
 void lnl_uncore_cpu_init(void);
 void mtl_uncore_cpu_init(void);
+void ptl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
 void adl_uncore_mmio_init(void);
 void lnl_uncore_mmio_init(void);
+void ptl_uncore_mmio_init(void);
 int snb_pci2phy_map_init(int devid);
 
 /* uncore_snbep.c */
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 690f737e6837..dff75c98e22f 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -171,3 +171,7 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 					  struct intel_uncore_box *box);
 void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
 			  struct rb_root *root, u16 *num_units);
+struct intel_uncore_type **
+uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
+		   struct intel_uncore_type **extra, int max_num_types,
+		   struct intel_uncore_type **uncores);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index edb7fd50efe0..b9c0e02b7da4 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1854,3 +1854,74 @@ void lnl_uncore_mmio_init(void)
 }
 
 /* end of Lunar Lake MMIO uncore support */
+
+/* Panther Lake uncore support */
+
+#define UNCORE_PTL_MAX_NUM_UNCORE_TYPES		42
+#define UNCORE_PTL_TYPE_IMC			6
+#define UNCORE_PTL_TYPE_SNCU			34
+#define UNCORE_PTL_TYPE_HBO			41
+
+#define PTL_UNCORE_GLOBAL_CTL_OFFSET		0x380
+
+static struct intel_uncore_type ptl_uncore_imc = {
+	.name			= "imc",
+	.mmio_map_size		= 0xf00,
+};
+
+static void ptl_uncore_sncu_init_box(struct intel_uncore_box *box)
+{
+	intel_generic_uncore_mmio_init_box(box);
+
+	/* Clear the global freeze bit */
+	if (box->io_addr)
+		writel(0, box->io_addr + PTL_UNCORE_GLOBAL_CTL_OFFSET);
+}
+
+static struct intel_uncore_ops ptl_uncore_sncu_ops = {
+	.init_box		= ptl_uncore_sncu_init_box,
+	.exit_box		= uncore_mmio_exit_box,
+	.disable_box		= intel_generic_uncore_mmio_disable_box,
+	.enable_box		= intel_generic_uncore_mmio_enable_box,
+	.disable_event		= intel_generic_uncore_mmio_disable_event,
+	.enable_event		= intel_generic_uncore_mmio_enable_event,
+	.read_counter		= uncore_mmio_read_counter,
+};
+
+static struct intel_uncore_type ptl_uncore_sncu = {
+	.name			= "sncu",
+	.ops			= &ptl_uncore_sncu_ops,
+	.mmio_map_size		= 0xf00,
+};
+
+static struct intel_uncore_type ptl_uncore_hbo = {
+	.name			= "hbo",
+	.mmio_map_size		= 0xf00,
+};
+
+static struct intel_uncore_type *ptl_uncores[UNCORE_PTL_MAX_NUM_UNCORE_TYPES] = {
+	[UNCORE_PTL_TYPE_IMC] = &ptl_uncore_imc,
+	[UNCORE_PTL_TYPE_SNCU] = &ptl_uncore_sncu,
+	[UNCORE_PTL_TYPE_HBO] = &ptl_uncore_hbo,
+};
+
+void ptl_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+						 UNCORE_PTL_MAX_NUM_UNCORE_TYPES,
+						 ptl_uncores);
+}
+
+static struct intel_uncore_type *ptl_msr_uncores[] = {
+	&mtl_uncore_cbox,
+	NULL
+};
+
+void ptl_uncore_cpu_init(void)
+{
+	mtl_uncore_cbox.num_boxes = 6;
+	mtl_uncore_cbox.ops = &lnl_uncore_msr_ops;
+	uncore_msr_uncores = ptl_msr_uncores;
+}
+
+/* end of Panther Lake uncore support */
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 48e19b26dca6..229c7fe51c32 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6499,7 +6499,7 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 		to_type->mmio_map_size = from_type->mmio_map_size;
 }
 
-static struct intel_uncore_type **
+struct intel_uncore_type **
 uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
 		   struct intel_uncore_type **extra, int max_num_types,
 		   struct intel_uncore_type **uncores)
-- 
2.38.1


