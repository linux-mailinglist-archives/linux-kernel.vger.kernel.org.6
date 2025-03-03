Return-Path: <linux-kernel+bounces-542760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760A5A4CD59
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D163ACD27
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCF523A995;
	Mon,  3 Mar 2025 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzmT3ADl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7C23717D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036381; cv=none; b=oNTq81wruHwe0WeHonlQQPt+4tf3k4/XugDkZ3FTIATEvc62hZ9EXPjKXFh8wwOIRZGnYAOaK+sN9WSHd8j2WZLHfwr5rT0Mj0lPLvD0hPEUn9xlzcJVR+5kJmpXEGDOfwDf/0lTkRj4SYcv7fTy/wG+pgcAB52zTjSqoNEHgMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036381; c=relaxed/simple;
	bh=euHATCt+R4i/zhzGN33ryK/BvkP7gTgi86mruS8ktZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaNxPxUsWafYBDCb0hhGumgiHAJaP3Wukb2wracWi51gt3kTWNZcngzdk+z5vsACfmlTGa3i38pVWJ8q0+TQBC1E0UUB7moxleFDk6TScKFtX9e44HYrP72tjzSnwL0010YBn5muOjeRr2mA8hW4UrLv3rO2UAeK6Y+1OxrSVms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzmT3ADl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741036380; x=1772572380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=euHATCt+R4i/zhzGN33ryK/BvkP7gTgi86mruS8ktZA=;
  b=UzmT3ADlk296a7DpXfb81Jw8bW3UvhRIp5kAf69IjgUupNgSjrXzsHGz
   Gk7vhjOqck6v0Y7bmzItPz51vSFxVRAfA6IMIEiisbOH1hUAfoSGw+5xE
   7hnKbLxjCUAkIdHKI6NGGN6B/XYNXEDtj2C7ND8hCtqz3OWqJ8oKiCOuZ
   4CkrQhzR9ipeuYoNRyv5lLxcivZNR7mAsmc7KUcB0JEYp5EgmSajuxZDe
   2K1F53QAQh+qCbpKhTsygmMlo2yP/DkixVTjxT3rbShZ1ycI1uuuHwvUw
   tbYnmmVptxlfTqUaCOco7/2TwXbeoRqp6yzv01xw7Eq9xUoNscUHq867Z
   g==;
X-CSE-ConnectionGUID: vnkqMjFUTr62bvEufr8oIA==
X-CSE-MsgGUID: gwusOqL8Q/GOzaNo5l6a+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="67302369"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="67302369"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:12:54 -0800
X-CSE-ConnectionGUID: CosYBvpnRhugXrCkzIsgFQ==
X-CSE-MsgGUID: LQIeOCjuRK2/VSUhSPPL9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="123106904"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 03 Mar 2025 13:12:55 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 3/4] perf/x86/intel/uncore: Add Panther Lake support
Date: Mon,  3 Mar 2025 13:13:05 -0800
Message-Id: <20250303211306.3261160-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250303211306.3261160-1-kan.liang@linux.intel.com>
References: <20250303211306.3261160-1-kan.liang@linux.intel.com>
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
+#define UNCORE_PTL_MAX_NUM_UNCORE_TYPES		31
+#define UNCORE_PTL_TYPE_IMC			6
+#define UNCORE_PTL_TYPE_SNCU			24
+#define UNCORE_PTL_TYPE_HBO			30
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


