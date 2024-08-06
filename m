Return-Path: <linux-kernel+bounces-275875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC92948B59
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFEAB24EFD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B991BD50F;
	Tue,  6 Aug 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIGhqMzm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A251BD4E5;
	Tue,  6 Aug 2024 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933059; cv=none; b=Qfl+xqMmQjGVRq7PaWNFEH/aOe6Gey69Ze5Dw9JRKXBSq5vBcDmB7ANvsck03VXlKAnRPdSief8lTC9lUPPXwCWWmkDXSXgsROcEHvDC9L4aJxxvK4cR2rEOXQ8AWsi2kySVGgE9H1No/yn6XkKaPKZ4Dvk/1xNMHLyK1fmHGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933059; c=relaxed/simple;
	bh=zXeKbpJ1OlI6R8Gluo/M21f4/B+Rydwt3JbrN4H78UU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pTcGoiT2guPKxUzLvktcsys4rfddNe2rcpLorTXz05r9b6nU/vowOuacBFcIBOmpfgVCSiy4l4gSNulueG1RO54Ywvo8euTNIOqFIb/T6zXSJFt5jJ6i8/wrYItrS4pmH0J53ngqjLcWxcgT5G/yjKquyxo3U+42db3hs9Gm7OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIGhqMzm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722933058; x=1754469058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zXeKbpJ1OlI6R8Gluo/M21f4/B+Rydwt3JbrN4H78UU=;
  b=HIGhqMzm7oOmCkvLPfIHnBm2mJlYuFkY5jSh4H7W9zayEDI4aWYbqRzT
   EVRhzmEDYWyMQqaWlaN1sTIU13X8nkH+VJPfddVxVfXtyEHO/9Zg5RyD3
   UqN/1OpFvorDK/WfsGHZFdo7nTBf9Ox5Ntusao8vy3oLVkoY++LI/keqM
   pM2YkZD+M9AKvD2IMZRgArYL+j1uu20IDiljYqur5azYPIJQZDX4hxi6S
   feHGEtsmxMW2vxQaPbu7vVHcD90ijkLwnWSuAmX/dWLJC5vSp9m/0Y8Az
   2VQTbaxfuuEOXP6XuaJnfL3tCM09bXet53TmEt+0DJbaTwW5vFkH9h1jv
   w==;
X-CSE-ConnectionGUID: gmRmMbEsQryBJ449FVmtWA==
X-CSE-MsgGUID: o8pZSUphTGCVsI1gwT1zRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20811203"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20811203"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 01:30:57 -0700
X-CSE-ConnectionGUID: yoY/xXEfSwC3B+jvAARDQw==
X-CSE-MsgGUID: Uw1OAaodSBK5JNuyBl+aHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="61304492"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 01:30:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Xi Pardee <xi.pardee@linux.intel.com>,
	Rajvi Jingar <rajvi.jingar@linux.intel.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kane Chen <kane.chen@intel.com>,
	=?UTF-8?q?Marek=20Ma=C5=9Blanka?= <mmaslanka@google.com>
Subject: [PATCH 1/1] platform/x86: intel/pmc: Remove unused param idx from pmc_for_each_mode()
Date: Tue,  6 Aug 2024 11:30:47 +0300
Message-Id: <20240806083047.1562-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pmc_for_each_mode() takes i (index) variable name as a parameter but
the loop index is not used by any of the callers. Make the index
variable internal to pmc_for_each_mode().

This also changes the loop logic such that ->lpm_en_modes[] is never
read beyond num_lpm_modes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c       | 18 +++++++-----------
 drivers/platform/x86/intel/pmc/core.h       | 10 ++++++----
 drivers/platform/x86/intel/pmc/core_ssram.c |  4 ++--
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 01ae71c6df59..0e88a89a236a 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -728,12 +728,11 @@ static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	const int lpm_adj_x2 = pmc->map->lpm_res_counter_step_x2;
 	u32 offset = pmc->map->lpm_residency_offset;
-	unsigned int i;
 	int mode;
 
 	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
 
-	pmc_for_each_mode(i, mode, pmcdev) {
+	pmc_for_each_mode(mode, pmcdev) {
 		seq_printf(s, "%-10s %-15llu\n", pmc_lpm_modes[mode],
 			   adjust_lpm_residency(pmc, offset + (4 * mode), lpm_adj_x2));
 	}
@@ -787,11 +786,10 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
 static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
 {
 	struct pmc_dev *pmcdev = s->private;
-	unsigned int i;
 	int mode;
 
 	seq_printf(s, "%30s |", "Element");
-	pmc_for_each_mode(i, mode, pmcdev)
+	pmc_for_each_mode(mode, pmcdev)
 		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
 
 	seq_printf(s, " %9s |\n", "Status");
@@ -833,14 +831,14 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 			u32 req_mask = 0;
 			u32 lpm_status;
 			const struct pmc_bit_map *map;
-			int mode, idx, i, len = 32;
+			int mode, i, len = 32;
 
 			/*
 			 * Capture the requirements and create a mask so that we only
 			 * show an element if it's required for at least one of the
 			 * enabled low power modes
 			 */
-			pmc_for_each_mode(idx, mode, pmcdev)
+			pmc_for_each_mode(mode, pmcdev)
 				req_mask |= lpm_req_regs[mp + (mode * num_maps)];
 
 			/* Get the last latched status for this map */
@@ -863,7 +861,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 				seq_printf(s, "pmc%d: %26s |", pmc_index, map[i].name);
 
 				/* Loop over the enabled states and display if required */
-				pmc_for_each_mode(idx, mode, pmcdev) {
+				pmc_for_each_mode(mode, pmcdev) {
 					bool required = lpm_req_regs[mp + (mode * num_maps)] &
 							bit_mask;
 					seq_printf(s, " %9s |", required ? "Required" : " ");
@@ -925,7 +923,6 @@ static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	unsigned int idx;
 	bool c10;
 	u32 reg;
 	int mode;
@@ -939,7 +936,7 @@ static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 		c10 = true;
 	}
 
-	pmc_for_each_mode(idx, mode, pmcdev) {
+	pmc_for_each_mode(mode, pmcdev) {
 		if ((BIT(mode) & reg) && !c10)
 			seq_printf(s, " [%s]", pmc_lpm_modes[mode]);
 		else
@@ -960,7 +957,6 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	bool clear = false, c10 = false;
 	unsigned char buf[8];
-	unsigned int idx;
 	int m, mode;
 	u32 reg;
 
@@ -979,7 +975,7 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
 	mode = sysfs_match_string(pmc_lpm_modes, buf);
 
 	/* Check string matches enabled mode */
-	pmc_for_each_mode(idx, m, pmcdev)
+	pmc_for_each_mode(m, pmcdev)
 		if (mode == m)
 			break;
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ea04de7eb9e8..c8851f128adc 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -604,10 +604,12 @@ int lnl_core_init(struct pmc_dev *pmcdev);
 void cnl_suspend(struct pmc_dev *pmcdev);
 int cnl_resume(struct pmc_dev *pmcdev);
 
-#define pmc_for_each_mode(i, mode, pmcdev)		\
-	for (i = 0, mode = pmcdev->lpm_en_modes[i];	\
-	     i < pmcdev->num_lpm_modes;			\
-	     i++, mode = pmcdev->lpm_en_modes[i])
+#define pmc_for_each_mode(mode, pmcdev)						\
+	for (unsigned int __i = 0, __cond;					\
+	     __cond = __i < (pmcdev)->num_lpm_modes,				\
+	     __cond && ((mode) = (pmcdev)->lpm_en_modes[__i]),			\
+	     __cond;								\
+	     __i++)
 
 #define DEFINE_PMC_CORE_ATTR_WRITE(__name)				\
 static int __name ## _open(struct inode *inode, struct file *file)	\
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 1bde86c54eb9..9eea5118653b 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -45,7 +45,7 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
 	struct telem_endpoint *ep;
 	const u8 *lpm_indices;
 	int num_maps, mode_offset = 0;
-	int ret, mode, i;
+	int ret, mode;
 	int lpm_size;
 	u32 guid;
 
@@ -116,7 +116,7 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
 	 *
 	 */
 	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
-	pmc_for_each_mode(i, mode, pmcdev) {
+	pmc_for_each_mode(mode, pmcdev) {
 		u32 *req_offset = pmc->lpm_req_regs + (mode * num_maps);
 		int m;
 
-- 
2.39.2


