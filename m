Return-Path: <linux-kernel+bounces-269343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369FD9431C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B95B22CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9EC1B3F2F;
	Wed, 31 Jul 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4HmG7BW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992D1B375D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435212; cv=none; b=Zitui9c8gT8sozkPWW9yhAowjg8Yr7VpHxeJLgLjWPEZyACcOUQwMpuEhPOHEaXIrWmrvI9+LFt0C2by5Kz69MFTIp3lTAFIH0T5hsgEAYZKhDz3J6RFDgNKWnBKKv7PObuA3m40NPdovB/QrPTys+xgy8ndS7DgRO7kixgMtd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435212; c=relaxed/simple;
	bh=lqp/yVpdv21m/AGqDP8Y06mcdeCz17J+NY/pADkqw30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ke0gJioQtxbXvKsP2FefVIFMRllz9w4SBoku8BjvRng8pMZCr/gWF9/RC/qTUr7kwx07/IcswQnP4lH/AnbG6lQYzNJWnt9ZLHdUfsn9cC1UIyBAu+fBJPCaftD98h5a12+npqB/snh10V8buaZT3wxatcj889VLBCFLUsXIrMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4HmG7BW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722435210; x=1753971210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lqp/yVpdv21m/AGqDP8Y06mcdeCz17J+NY/pADkqw30=;
  b=i4HmG7BWSHghnAlHp00KQ25awM5QYSuV74Si9TTfyhD+4FLOjOjeoeeD
   MU7quz63tny+Cv6RXzRrjYj1/a/VssduYKaA/V3aDvsyMs0GJ8P+bvOWh
   lxF5QG4pP8Rv4TbOk59YvwbD7t8EF0jVe51BrY0Uqu1lr4W0fve2CH9Yz
   kolPbjPCqdEywIA33VxMirlqEI4xQZUGb9mVjLeKZP1c4G7gorR49yL+Q
   rAG+2ZoeeY7v6TlBqqAKvou/oNWFqDKPyZ9yB1/ePnmIeYBFO6wT1zpPz
   Y98A9CvBBgUS0pNl0z7hitMMVB3SG/NbGLzcQkoYXccvQ61INLaBb1Gfd
   A==;
X-CSE-ConnectionGUID: lN/jSUhfTDS5aVqGR0kYUg==
X-CSE-MsgGUID: 5z/AyY0SSAKbEKlTPrvY2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20011624"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20011624"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:13:28 -0700
X-CSE-ConnectionGUID: bjEW+r92R36+sOFD/66urg==
X-CSE-MsgGUID: Igc/P7QWSrm/xt7OolTfUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54357884"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 31 Jul 2024 07:13:27 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/5] perf/x86/intel/uncore: Add Lunar Lake support
Date: Wed, 31 Jul 2024 07:13:51 -0700
Message-Id: <20240731141353.759643-3-kan.liang@linux.intel.com>
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

The uncore subsystem for Lunar Lake is similar to the previous
Meteor Lake. The uncore PerfMon registers are located at both
MSR and MMIO space.

The ARB and iMC are kept. There is no difference from the Meteor Lake.
Move the global control initialization to the first box of the CBOX.

The sNCU is moved to the MMIO space.

The HBO is newly added and only be accessed from the MMIO space.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     |   6 ++
 arch/x86/events/intel/uncore.h     |   2 +
 arch/x86/events/intel/uncore_snb.c | 133 +++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index dd02f505f1ad..698d80ad7110 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1815,6 +1815,11 @@ static const struct intel_uncore_init_fun mtl_uncore_init __initconst = {
 	.mmio_init = adl_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun lnl_uncore_init __initconst = {
+	.cpu_init = lnl_uncore_cpu_init,
+	.mmio_init = lnl_uncore_mmio_init,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1895,6 +1900,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 027ef292c602..79ff32e13dcc 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -611,10 +611,12 @@ void skl_uncore_cpu_init(void);
 void icl_uncore_cpu_init(void);
 void tgl_uncore_cpu_init(void);
 void adl_uncore_cpu_init(void);
+void lnl_uncore_cpu_init(void);
 void mtl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
 void adl_uncore_mmio_init(void);
+void lnl_uncore_mmio_init(void);
 int snb_pci2phy_map_init(int devid);
 
 /* uncore_snbep.c */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 05fe6e90bd8e..e02603e468ac 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -252,6 +252,7 @@ DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
 DEFINE_UNCORE_FORMAT_ATTR(cmask5, cmask, "config:24-28");
 DEFINE_UNCORE_FORMAT_ATTR(cmask8, cmask, "config:24-31");
 DEFINE_UNCORE_FORMAT_ATTR(threshold, threshold, "config:24-29");
+DEFINE_UNCORE_FORMAT_ATTR(threshold2, threshold, "config:24-31");
 
 /* Sandy Bridge uncore support */
 static void snb_uncore_msr_enable_event(struct intel_uncore_box *box, struct perf_event *event)
@@ -746,6 +747,34 @@ void mtl_uncore_cpu_init(void)
 	uncore_msr_uncores = mtl_msr_uncores;
 }
 
+static struct intel_uncore_type *lnl_msr_uncores[] = {
+	&mtl_uncore_cbox,
+	&mtl_uncore_arb,
+	NULL
+};
+
+#define LNL_UNC_MSR_GLOBAL_CTL			0x240e
+
+static void lnl_uncore_msr_init_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(LNL_UNC_MSR_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+}
+
+static struct intel_uncore_ops lnl_uncore_msr_ops = {
+	.init_box	= lnl_uncore_msr_init_box,
+	.disable_event	= snb_uncore_msr_disable_event,
+	.enable_event	= snb_uncore_msr_enable_event,
+	.read_counter	= uncore_msr_read_counter,
+};
+
+void lnl_uncore_cpu_init(void)
+{
+	mtl_uncore_cbox.num_boxes = 4;
+	mtl_uncore_cbox.ops = &lnl_uncore_msr_ops;
+	uncore_msr_uncores = lnl_msr_uncores;
+}
+
 enum {
 	SNB_PCI_UNCORE_IMC,
 };
@@ -1716,3 +1745,107 @@ void adl_uncore_mmio_init(void)
 }
 
 /* end of Alder Lake MMIO uncore support */
+
+/* Lunar Lake MMIO uncore support */
+#define LNL_UNCORE_PCI_SAFBAR_OFFSET		0x68
+#define LNL_UNCORE_MAP_SIZE			0x1000
+#define LNL_UNCORE_SNCU_BASE			0xE4B000
+#define LNL_UNCORE_SNCU_CTR			0x390
+#define LNL_UNCORE_SNCU_CTRL			0x398
+#define LNL_UNCORE_SNCU_BOX_CTL			0x380
+#define LNL_UNCORE_GLOBAL_CTL			0x700
+#define LNL_UNCORE_HBO_BASE			0xE54000
+#define LNL_UNCORE_HBO_OFFSET			-4096
+#define LNL_UNCORE_HBO_CTR			0x570
+#define LNL_UNCORE_HBO_CTRL			0x550
+#define LNL_UNCORE_HBO_BOX_CTL			0x548
+
+#define LNL_UNC_CTL_THRESHOLD			0xff000000
+#define LNL_UNC_RAW_EVENT_MASK			(SNB_UNC_CTL_EV_SEL_MASK | \
+						 SNB_UNC_CTL_UMASK_MASK | \
+						 SNB_UNC_CTL_EDGE_DET | \
+						 SNB_UNC_CTL_INVERT | \
+						 LNL_UNC_CTL_THRESHOLD)
+
+static struct attribute *lnl_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_threshold2.attr,
+	NULL
+};
+
+static const struct attribute_group lnl_uncore_format_group = {
+	.name		= "format",
+	.attrs		= lnl_uncore_formats_attr,
+};
+
+static void lnl_uncore_hbo_init_box(struct intel_uncore_box *box)
+{
+	uncore_get_box_mmio_addr(box, LNL_UNCORE_HBO_BASE,
+				 LNL_UNCORE_PCI_SAFBAR_OFFSET,
+				 LNL_UNCORE_HBO_OFFSET);
+}
+
+static struct intel_uncore_ops lnl_uncore_hbo_ops = {
+	.init_box	= lnl_uncore_hbo_init_box,
+	MMIO_UNCORE_COMMON_OPS()
+};
+
+static struct intel_uncore_type lnl_uncore_hbo = {
+	.name		= "hbo",
+	.num_counters   = 4,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 64,
+	.perf_ctr	= LNL_UNCORE_HBO_CTR,
+	.event_ctl	= LNL_UNCORE_HBO_CTRL,
+	.event_mask	= LNL_UNC_RAW_EVENT_MASK,
+	.box_ctl	= LNL_UNCORE_HBO_BOX_CTL,
+	.mmio_map_size	= LNL_UNCORE_MAP_SIZE,
+	.ops		= &lnl_uncore_hbo_ops,
+	.format_group	= &lnl_uncore_format_group,
+};
+
+static void lnl_uncore_sncu_init_box(struct intel_uncore_box *box)
+{
+	uncore_get_box_mmio_addr(box, LNL_UNCORE_SNCU_BASE,
+				 LNL_UNCORE_PCI_SAFBAR_OFFSET,
+				 0);
+
+	if (box->io_addr)
+		writel(ADL_UNCORE_IMC_CTL_INT, box->io_addr + LNL_UNCORE_GLOBAL_CTL);
+}
+
+static struct intel_uncore_ops lnl_uncore_sncu_ops = {
+	.init_box	= lnl_uncore_sncu_init_box,
+	MMIO_UNCORE_COMMON_OPS()
+};
+
+static struct intel_uncore_type lnl_uncore_sncu = {
+	.name		= "sncu",
+	.num_counters   = 2,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 64,
+	.perf_ctr	= LNL_UNCORE_SNCU_CTR,
+	.event_ctl	= LNL_UNCORE_SNCU_CTRL,
+	.event_mask	= LNL_UNC_RAW_EVENT_MASK,
+	.box_ctl	= LNL_UNCORE_SNCU_BOX_CTL,
+	.mmio_map_size	= LNL_UNCORE_MAP_SIZE,
+	.ops		= &lnl_uncore_sncu_ops,
+	.format_group	= &lnl_uncore_format_group,
+};
+
+static struct intel_uncore_type *lnl_mmio_uncores[] = {
+	&adl_uncore_imc,
+	&lnl_uncore_hbo,
+	&lnl_uncore_sncu,
+	NULL
+};
+
+void lnl_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = lnl_mmio_uncores;
+}
+
+/* end of Lunar Lake MMIO uncore support */
-- 
2.38.1


