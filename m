Return-Path: <linux-kernel+bounces-227910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776F915803
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEFD1F23070
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EB01A08CF;
	Mon, 24 Jun 2024 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChLFMFfD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CE419D88C;
	Mon, 24 Jun 2024 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261146; cv=none; b=RHqE8tWRenXyQSrDKN9D3JCXeNe6riO4yxHvghMGap/SpSdXW7Q+LdGJgp54wY9VMglunzIo4oUj5mh7N89J6cBNbCmp7GgZSeqyzUmWmoqEwxfJ4PKJpamfpFZArZPjPUYOpKPpElQV6oSeAee+uUA2+qFXlPr8WQuQuUyNjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261146; c=relaxed/simple;
	bh=kRxHJBluDx0FGrG3lo0kAuMpezjPWKo0SX9PIoboUCM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKm5m7wbZ7y6yFnZGtkqqNHpkX8thZ02HeWOYV3vDqHr6Or7Qdr5WR3htDY0NfbOCK6AW9cmZGgkNvjzYi4+lnxboEVqWDyhxvTw34haEUJigmH3vcVyqe6AdnAvxsE18DbAlYm3C5PEjAlSRYqTxT2oDGuKptb7/a+P1m9DCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChLFMFfD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261145; x=1750797145;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=kRxHJBluDx0FGrG3lo0kAuMpezjPWKo0SX9PIoboUCM=;
  b=ChLFMFfDoi0CdNNBgHb7VU/ENXVa3GKJuyDi8l1ajW45kOqZ1T5EXujn
   ZJf1P/Gg6ZzxtSTRoAcnrXDCtwQXeGj8QiP8Oe5rvrPJmlT7AFDp8CWpq
   LfXhExud15KD6gr8fWbYNK5hsrodaUHy9QDIvushrC+cSQwokpxjQit5C
   RYT58VwRam0n6IMFc73F3eNk1ZnSEG2Dkm1q95X71d4OQQh4+JLK5SWc3
   QpbnvJZD8NGX1ykkTIypWR38AYnMhGU/wJ1kNBJbrZoqb8tY8ubdepyo7
   HpOak2xrv/dJ3godSoqRZkFedKX/rHhm2gcgpwCi/b36cXfXgnsQZpwHN
   Q==;
X-CSE-ConnectionGUID: EW+JTDTVSNS5Xl2WW4wI5w==
X-CSE-MsgGUID: XAl4lXTcTS2tUMHmQ/uxdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33792328"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33792328"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:23 -0700
X-CSE-ConnectionGUID: QQT/z22rRkOug1i3em2ylw==
X-CSE-MsgGUID: iDTTzoeWRUaCi0EO/fGQtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47949132"
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
Subject: [PATCH 2/9] platform/x86:intel/pmc: Simplify mutex usage with cleanup helpers
Date: Mon, 24 Jun 2024 13:32:11 -0700
Message-Id: <20240624203218.2428475-3-xi.pardee@linux.intel.com>
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

Use macros defined in cleanup.h to automate the mutex lock/unlock flow.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 76 +++++++++------------------
 1 file changed, 25 insertions(+), 51 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e656d51e7ad5..b524b74293ca 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -87,35 +87,26 @@ static int set_etr3(struct pmc_dev *pmcdev)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	const struct pmc_reg_map *map = pmc->map;
 	u32 reg;
-	int err;
 
 	if (!map->etr3_offset)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&pmcdev->lock);
+	guard(mutex)(&pmcdev->lock);
 
 	/* check if CF9 is locked */
 	reg = pmc_core_reg_read(pmc, map->etr3_offset);
-	if (reg & ETR3_CF9LOCK) {
-		err = -EACCES;
-		goto out_unlock;
-	}
+	if (reg & ETR3_CF9LOCK)
+		return -EACCES;
 
 	/* write CF9 global reset bit */
 	reg |= ETR3_CF9GR;
 	pmc_core_reg_write(pmc, map->etr3_offset, reg);
 
 	reg = pmc_core_reg_read(pmc, map->etr3_offset);
-	if (!(reg & ETR3_CF9GR)) {
-		err = -EIO;
-		goto out_unlock;
-	}
-
-	err = 0;
+	if (!(reg & ETR3_CF9GR))
+		return -EIO;
 
-out_unlock:
-	mutex_unlock(&pmcdev->lock);
-	return err;
+	return 0;
 }
 static umode_t etr3_is_visible(struct kobject *kobj,
 				struct attribute *attr,
@@ -127,9 +118,8 @@ static umode_t etr3_is_visible(struct kobject *kobj,
 	const struct pmc_reg_map *map = pmc->map;
 	u32 reg;
 
-	mutex_lock(&pmcdev->lock);
-	reg = pmc_core_reg_read(pmc, map->etr3_offset);
-	mutex_unlock(&pmcdev->lock);
+	scoped_guard(mutex, &pmcdev->lock)
+		reg = pmc_core_reg_read(pmc, map->etr3_offset);
 
 	return reg & ETR3_CF9LOCK ? attr->mode & (SYSFS_PREALLOC | 0444) : attr->mode;
 }
@@ -145,12 +135,10 @@ static ssize_t etr3_show(struct device *dev,
 	if (!map->etr3_offset)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&pmcdev->lock);
-
-	reg = pmc_core_reg_read(pmc, map->etr3_offset);
-	reg &= ETR3_CF9GR | ETR3_CF9LOCK;
-
-	mutex_unlock(&pmcdev->lock);
+	scoped_guard(mutex, &pmcdev->lock) {
+		reg = pmc_core_reg_read(pmc, map->etr3_offset);
+		reg &= ETR3_CF9GR | ETR3_CF9LOCK;
+	}
 
 	return sysfs_emit(buf, "0x%08x", reg);
 }
@@ -401,18 +389,18 @@ static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
 	mphy_core_reg_low  = (SPT_PMC_MPHY_CORE_STS_0 << 16);
 	mphy_core_reg_high = (SPT_PMC_MPHY_CORE_STS_1 << 16);
 
-	mutex_lock(&pmcdev->lock);
+	guard(mutex)(&pmcdev->lock);
 
 	err = pmc_core_send_msg(pmc, &mphy_core_reg_low);
 	if (err)
-		goto out_unlock;
+		return err;
 
 	msleep(10);
 	val_low = pmc_core_reg_read(pmc, SPT_PMC_MFPMC_OFFSET);
 
 	err = pmc_core_send_msg(pmc, &mphy_core_reg_high);
 	if (err)
-		goto out_unlock;
+		return err;
 
 	msleep(10);
 	val_high = pmc_core_reg_read(pmc, SPT_PMC_MFPMC_OFFSET);
@@ -431,9 +419,7 @@ static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
 			   "Power gated");
 	}
 
-out_unlock:
-	mutex_unlock(&pmcdev->lock);
-	return err;
+	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_mphy_pg);
 
@@ -451,11 +437,11 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 	}
 
 	mphy_common_reg  = (SPT_PMC_MPHY_COM_STS_0 << 16);
-	mutex_lock(&pmcdev->lock);
+	guard(mutex)(&pmcdev->lock);
 
 	err = pmc_core_send_msg(pmc, &mphy_common_reg);
 	if (err)
-		goto out_unlock;
+		return err;
 
 	/* Observed PMC HW response latency for MTPMC-MFPMC is ~10 ms */
 	msleep(10);
@@ -467,9 +453,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 			   map[index].bit_mask & val ? "Active" : "Idle");
 	}
 
-out_unlock:
-	mutex_unlock(&pmcdev->lock);
-	return err;
+	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
@@ -508,7 +492,7 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
 
 	pr_debug("ltr_ignore for pmc%d: ltr_index:%d\n", pmc_index, ltr_index);
 
-	mutex_lock(&pmcdev->lock);
+	guard(mutex)(&pmcdev->lock);
 
 	reg = pmc_core_reg_read(pmc, map->ltr_ignore_offset);
 	if (ignore)
@@ -517,8 +501,6 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
 		reg &= ~BIT(ltr_index);
 	pmc_core_reg_write(pmc, map->ltr_ignore_offset, reg);
 
-	mutex_unlock(&pmcdev->lock);
-
 	return 0;
 }
 
@@ -566,10 +548,10 @@ static void pmc_core_slps0_dbg_latch(struct pmc_dev *pmcdev, bool reset)
 	const struct pmc_reg_map *map = pmc->map;
 	u32 fd;
 
-	mutex_lock(&pmcdev->lock);
+	guard(mutex)(&pmcdev->lock);
 
 	if (!reset && !slps0_dbg_latch)
-		goto out_unlock;
+		return;
 
 	fd = pmc_core_reg_read(pmc, map->slps0_dbg_offset);
 	if (reset)
@@ -579,9 +561,6 @@ static void pmc_core_slps0_dbg_latch(struct pmc_dev *pmcdev, bool reset)
 	pmc_core_reg_write(pmc, map->slps0_dbg_offset, fd);
 
 	slps0_dbg_latch = false;
-
-out_unlock:
-	mutex_unlock(&pmcdev->lock);
 }
 
 static int pmc_core_slps0_dbg_show(struct seq_file *s, void *unused)
@@ -984,26 +963,22 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
 	}
 
 	if (clear) {
-		mutex_lock(&pmcdev->lock);
+		guard(mutex)(&pmcdev->lock);
 
 		reg = pmc_core_reg_read(pmc, pmc->map->etr3_offset);
 		reg |= ETR3_CLEAR_LPM_EVENTS;
 		pmc_core_reg_write(pmc, pmc->map->etr3_offset, reg);
 
-		mutex_unlock(&pmcdev->lock);
-
 		return count;
 	}
 
 	if (c10) {
-		mutex_lock(&pmcdev->lock);
+		guard(mutex)(&pmcdev->lock);
 
 		reg = pmc_core_reg_read(pmc, pmc->map->lpm_sts_latch_en_offset);
 		reg &= ~LPM_STS_LATCH_MODE;
 		pmc_core_reg_write(pmc, pmc->map->lpm_sts_latch_en_offset, reg);
 
-		mutex_unlock(&pmcdev->lock);
-
 		return count;
 	}
 
@@ -1012,9 +987,8 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
 	 * and clear everything else.
 	 */
 	reg = LPM_STS_LATCH_MODE | BIT(mode);
-	mutex_lock(&pmcdev->lock);
+	guard(mutex)(&pmcdev->lock);
 	pmc_core_reg_write(pmc, pmc->map->lpm_sts_latch_en_offset, reg);
-	mutex_unlock(&pmcdev->lock);
 
 	return count;
 }
-- 
2.34.1


