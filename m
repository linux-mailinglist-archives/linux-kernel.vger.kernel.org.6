Return-Path: <linux-kernel+bounces-227912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75822915808
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D841C22BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FCB1A0B10;
	Mon, 24 Jun 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrIdvnST"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BE1A0737;
	Mon, 24 Jun 2024 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261148; cv=none; b=Tm/ZvYDXW2/T+1NRDGOPR30aXvJSdmkox62Xbqmhr6mARw8maaqrkmu+jAYUulHZFUlyBWQvYAr0FDrHFcVvnylLl7rQfn8E5NYiTgIJzjLMEt0HRAwHTsHqP3ajMyi9fYqZftOwjhctP/c/18X2VzLgJZI+uTz5gmeRvxEmNVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261148; c=relaxed/simple;
	bh=aXU8/ZpQ/JHZoaWu0IwWPRoNXE313qwJIgjhnRWNXOg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jk1EdS7CQoPcfRIxRB1/XvVO53NVIISS3g5CkiNMUTR2Yi+k65BM85xUaZIPUNpLo6qCfXcDyCFfGRPh7mMcE+GdKUkfovQz53c7GFSIXf4k7SogRNbbAwq8FEpvyz2yoy8KwZthQHc+u5phiirwcqpeR5ja4Bm0/MT/4ruyAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrIdvnST; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261146; x=1750797146;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=aXU8/ZpQ/JHZoaWu0IwWPRoNXE313qwJIgjhnRWNXOg=;
  b=FrIdvnSThgLYpSAGl0HLJf/WiQo/25eyhQmfNXutIjRqzk+MYnpgjcH8
   /FfCDzwisnjJM48Qt3U1NnIdosxZy6jPqOAzH0AuDAof8FgU4ZBFTgxD/
   uadZQ37hNxXZ5vBob4aBiGY4YulXwqFcT/80gVq1Mf6JBWW3R7L00/V7+
   Iqyk1YZSmICeiAgED5q6+0R45ZMRoBEhYOPw73xv+meZwMD5/PDCevemq
   yRSAIQsgj1yxqiDgv2uuq38A2fa/++djdvJnxaLku00bL+mtdAi601cUY
   SdQqI8dx2sQr4E3GBFiOz+x4L0ZTYkNpCnrLyslNyYO7EscyF3i0YCbR+
   w==;
X-CSE-ConnectionGUID: 1UVKbiPaQXKWHW4Z5fkiRw==
X-CSE-MsgGUID: Pzi3ohC7QS+RXo8dR22Rvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33792332"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33792332"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:23 -0700
X-CSE-ConnectionGUID: 56Oth7uPTnW/L3wycxAi3Q==
X-CSE-MsgGUID: D8qEQ1Y1ROe7SRGrFztp5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47949135"
Received: from ticela-or-265.amr.corp.intel.com (HELO xpardee-test1.amr.corp.intel.com) ([10.209.54.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:23 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] platform/x86:intel/pmc: Convert index variables to be unsigned
Date: Mon, 24 Jun 2024 13:32:12 -0700
Message-Id: <20240624203218.2428475-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624203218.2428475-1-xi.pardee@linux.intel.com>
References: <20240624203218.2428475-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xi Pardee <xi.pardee@intel.com>

Convert the index variables type to unsigned to avoid confusion and
errors.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 51 ++++++++++++++++-----------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index b524b74293ca..cbdcbf288f67 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -247,7 +247,7 @@ static void pmc_core_slps0_display(struct pmc *pmc, struct device *dev,
 
 static int pmc_core_lpm_get_arr_size(const struct pmc_bit_map **maps)
 {
-	int idx;
+	unsigned int idx;
 
 	for (idx = 0; maps[idx]; idx++)
 		;/* Nothing */
@@ -260,8 +260,8 @@ static void pmc_core_lpm_display(struct pmc *pmc, struct device *dev,
 				 const char *str,
 				 const struct pmc_bit_map **maps)
 {
-	int index, idx, len = 32, bit_mask, arr_size;
-	u32 *lpm_regs;
+	unsigned int index, idx, len = 32, arr_size;
+	u32 bit_mask, *lpm_regs;
 
 	arr_size = pmc_core_lpm_get_arr_size(maps);
 	lpm_regs = kmalloc_array(arr_size, sizeof(*lpm_regs), GFP_KERNEL);
@@ -314,13 +314,13 @@ static void pmc_core_display_map(struct seq_file *s, int index, int idx, int ip,
 static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
 		struct pmc *pmc = pmcdev->pmcs[i];
 		const struct pmc_bit_map **maps;
 		u8 pf_regs[PPFEAR_MAX_NUM_ENTRIES];
-		int index, iter, idx, ip = 0;
+		unsigned int index, iter, idx, ip = 0;
 
 		if (!pmc)
 			continue;
@@ -379,7 +379,8 @@ static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
 	const struct pmc_bit_map *map = pmc->map->mphy_sts;
 	u32 mphy_core_reg_low, mphy_core_reg_high;
 	u32 val_low, val_high;
-	int index, err = 0;
+	unsigned int index;
+	int err = 0;
 
 	if (pmcdev->pmc_xram_read_bit) {
 		seq_puts(s, "Access denied: please disable PMC_READ_DISABLE setting in BIOS.");
@@ -429,7 +430,8 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	const struct pmc_bit_map *map = pmc->map->pll_sts;
 	u32 mphy_common_reg, val;
-	int index, err = 0;
+	unsigned int index;
+	int err = 0;
 
 	if (pmcdev->pmc_xram_read_bit) {
 		seq_puts(s, "Access denied: please disable PMC_READ_DISABLE setting in BIOS.");
@@ -462,7 +464,8 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
 	struct pmc *pmc;
 	const struct pmc_reg_map *map;
 	u32 reg;
-	int pmc_index, ltr_index;
+	unsigned int pmc_index;
+	int ltr_index;
 
 	ltr_index = value;
 	/* For platforms with multiple pmcs, ltr index value given by user
@@ -615,7 +618,7 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 	u64 decoded_snoop_ltr, decoded_non_snoop_ltr;
 	u32 ltr_raw_data, scale, val;
 	u16 snoop_ltr, nonsnoop_ltr;
-	int i, index, ltr_index = 0;
+	unsigned int i, index, ltr_index = 0;
 
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
 		struct pmc *pmc = pmcdev->pmcs[i];
@@ -703,7 +706,8 @@ static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	const int lpm_adj_x2 = pmc->map->lpm_res_counter_step_x2;
 	u32 offset = pmc->map->lpm_residency_offset;
-	int i, mode;
+	unsigned int i;
+	int mode;
 
 	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
 
@@ -719,7 +723,7 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_res);
 static int pmc_core_substate_sts_regs_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
 		struct pmc *pmc = pmcdev->pmcs[i];
@@ -740,7 +744,7 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_sts_regs);
 static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
 		struct pmc *pmc = pmcdev->pmcs[i];
@@ -761,7 +765,8 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
 static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
 {
 	struct pmc_dev *pmcdev = s->private;
-	int i, mode;
+	unsigned int i;
+	int mode;
 
 	seq_printf(s, "%30s |", "Element");
 	pmc_for_each_mode(i, mode, pmcdev)
@@ -775,7 +780,8 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 	struct pmc_dev *pmcdev = s->private;
 	u32 sts_offset;
 	u32 *lpm_req_regs;
-	int num_maps, mp, pmc_index;
+	unsigned int mp, pmc_index;
+	int num_maps;
 
 	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs); ++pmc_index) {
 		struct pmc *pmc = pmcdev->pmcs[pmc_index];
@@ -897,9 +903,10 @@ static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
+	unsigned int idx;
 	bool c10;
 	u32 reg;
-	int idx, mode;
+	int mode;
 
 	reg = pmc_core_reg_read(pmc, pmc->map->lpm_sts_latch_en_offset);
 	if (reg & LPM_STS_LATCH_MODE) {
@@ -931,7 +938,8 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	bool clear = false, c10 = false;
 	unsigned char buf[8];
-	int idx, m, mode;
+	unsigned int idx;
+	int m, mode;
 	u32 reg;
 
 	if (count > sizeof(buf) - 1)
@@ -999,7 +1007,7 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 	struct pmc *pmc = s->private;
 	const struct pmc_bit_map *map = pmc->map->msr_sts;
 	u64 pcstate_count;
-	int index;
+	unsigned int index;
 
 	for (index = 0; map[index].name ; index++) {
 		if (rdmsrl_safe(map[index].bit_mask, &pcstate_count))
@@ -1017,7 +1025,7 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
 
 static bool pmc_core_pri_verify(u32 lpm_pri, u8 *mode_order)
 {
-	int i, j;
+	unsigned int i, j;
 
 	if (!lpm_pri)
 		return false;
@@ -1052,7 +1060,8 @@ void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
 	u8 mode_order[LPM_MAX_NUM_MODES];
 	u32 lpm_pri;
 	u32 lpm_en;
-	int mode, i, p;
+	unsigned int i;
+	int mode, p;
 
 	/* Use LPM Maps to indicate support for substates */
 	if (!pmc->map->lpm_num_maps)
@@ -1344,7 +1353,7 @@ static void pmc_core_do_dmi_quirks(struct pmc *pmc)
 static void pmc_core_clean_structure(struct platform_device *pdev)
 {
 	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
 		struct pmc *pmc = pmcdev->pmcs[i];
@@ -1507,7 +1516,7 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	const struct pmc_bit_map **maps = pmc->map->lpm_sts;
 	int offset = pmc->map->lpm_status_offset;
-	int i;
+	unsigned int i;
 
 	/* Check if the syspend used S0ix */
 	if (pm_suspend_via_firmware())
-- 
2.34.1


