Return-Path: <linux-kernel+bounces-280118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF9094C608
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362E7289586
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C3215AAD6;
	Thu,  8 Aug 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="db9daU0K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C216B15A853;
	Thu,  8 Aug 2024 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150562; cv=none; b=B43k7nirmOkQbclf1jM5+FyQMW++xTpj9WkJdARHuKzeyxFs+gvCS+jQE8r3MZ8HuOOE6DWHSVp73Br1cS4nbmk7xPqy+CJ7qtZBa+H5AMPkeHXaaMcMQekzwj/B+wsnWGfEg6+srESlw4xWiBHDHn4aqXbjrKjBlVG9jsiSYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150562; c=relaxed/simple;
	bh=6nRlq33BTnJbB7nmem2brqmpLIwZKd9C3mY2VE3o6Uw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DQUkpnzm8JFVCCeGbuizA8oRaYESljELcqfHyo72vDpyDTwHCzMEcHSI8C/mJGcQAOcngiZcu9ycX7Otvt86ln5x17Qpn8JZJ8JPSa2jIVYEucLf68ZgT9Kt0x1oqgy9T/WKR5Rddmh84K6i/TbHEvsFnOWlMYsrcclksrr0kJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=db9daU0K; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723150561; x=1754686561;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6nRlq33BTnJbB7nmem2brqmpLIwZKd9C3mY2VE3o6Uw=;
  b=db9daU0KuzzgU04Nkhg5uOBZzdkzpcLLCeXQ2mxb9r8TEq9XGvwAtNh1
   mRXHzhbzyGyxI8nZeGLQHxggIXA7f3PSWqTr7hIzrtZCLW3KOe04jlD2l
   ijaCw7nlo9UFOD2MDB4NCU06i1PBNbYoJlmHv0bbP+NQxnfEInq/fJXhY
   PFwB2gUhdHBggrbZKiv5MeFYn1CG3F9XQsa1pQiw/sHZbsnxBaxujHeOH
   YkjFukQU3dcBdYhzLhGkj/CvddLPGDFxhw7XOJsFHs3n+Bbju+xmEztbp
   /kY5NdVpm2ibxFniFJNDV9WKVo/jgVrKzp8T6rnjTBZjpyDREehOhy7kA
   w==;
X-CSE-ConnectionGUID: ILjKdG41TxitIh+WrCgd2g==
X-CSE-MsgGUID: j7EcQZ85SnSMsn3Y/lha6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="20871824"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="20871824"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:56:00 -0700
X-CSE-ConnectionGUID: UV3ub9HrTOGi6PtvpcmvbQ==
X-CSE-MsgGUID: TwkC6x/CQce4Xv314DDxcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57423876"
Received: from dgramcko-desk.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.221.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:55:58 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86:intel/pmc: Ignore all LTRs during suspend
Date: Thu,  8 Aug 2024 13:55:38 -0700
Message-ID: <20240808205551.403770-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xi Pardee <xi.pardee@intel.com>

Add support to ignore all LTRs before suspend and restore the previous
LTR values after suspend. This feature could be turned off with module
parameter ltr_ignore_all_suspend.

Suggested-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
Signed-off-by: Xi Pardee <xi.pardee@intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 53 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  2 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 01ae71c6df59..f364a011721d 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -714,6 +714,49 @@ static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
 
+static void pmc_core_ltr_ignore_all(struct pmc_dev *pmcdev)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
+		struct pmc *pmc;
+		u32 ltr_ign;
+
+		pmc = pmcdev->pmcs[i];
+		if (!pmc)
+			continue;
+
+		guard(mutex)(&pmcdev->lock);
+		pmc->ltr_ign = pmc_core_reg_read(pmc, pmc->map->ltr_ignore_offset);
+
+		/* ltr_ignore_max is the max index value for ltr ignore register */
+		ltr_ign = pmc->ltr_ign | GENMASK(pmc->map->ltr_ignore_max, 0);
+		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, ltr_ign);
+	}
+
+	/*
+	 * Ignoring ME during suspend is blocking platforms with ADL PCH to get to
+	 * deeper S0IX substate.
+	 */
+	pmc_core_send_ltr_ignore(pmcdev, 6, 0);
+}
+
+static void pmc_core_ltr_restore_all(struct pmc_dev *pmcdev)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
+		struct pmc *pmc;
+
+		pmc = pmcdev->pmcs[i];
+		if (!pmc)
+			continue;
+
+		guard(mutex)(&pmcdev->lock);
+		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, pmc->ltr_ign);
+	}
+}
+
 static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
 				       const int lpm_adj_x2)
 {
@@ -1479,6 +1522,10 @@ static bool warn_on_s0ix_failures;
 module_param(warn_on_s0ix_failures, bool, 0644);
 MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
 
+static bool ltr_ignore_all_suspend = true;
+module_param(ltr_ignore_all_suspend, bool, 0644);
+MODULE_PARM_DESC(ltr_ignore_all_suspend, "Ignore all LTRs during suspend");
+
 static __maybe_unused int pmc_core_suspend(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
@@ -1488,6 +1535,9 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	if (pmcdev->suspend)
 		pmcdev->suspend(pmcdev);
 
+	if (ltr_ignore_all_suspend)
+		pmc_core_ltr_ignore_all(pmcdev);
+
 	/* Check if the syspend will actually use S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
@@ -1594,6 +1644,9 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 
+	if (ltr_ignore_all_suspend)
+		pmc_core_ltr_restore_all(pmcdev);
+
 	if (pmcdev->resume)
 		return pmcdev->resume(pmcdev);
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ea04de7eb9e8..e862ea88b816 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -372,6 +372,7 @@ struct pmc_info {
  * @map:		pointer to pmc_reg_map struct that contains platform
  *			specific attributes
  * @lpm_req_regs:	List of substate requirements
+ * @ltr_ign:		Holds LTR ignore data while suspended
  *
  * pmc contains info about one power management controller device.
  */
@@ -380,6 +381,7 @@ struct pmc {
 	void __iomem *regbase;
 	const struct pmc_reg_map *map;
 	u32 *lpm_req_regs;
+	u32 ltr_ign;
 };
 
 /**
-- 
2.43.0


