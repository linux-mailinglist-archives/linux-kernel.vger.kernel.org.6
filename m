Return-Path: <linux-kernel+bounces-227917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A81915811
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B830289403
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1C19DF70;
	Mon, 24 Jun 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMkGm2iH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD651A254A;
	Mon, 24 Jun 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261151; cv=none; b=QrYlUdukG43jbMYg8tESBJwYaGMw6/Put9cwZUk10lRRH8q2OcrEtIf7ltuOmMUapnwVFG6KT17RqE8sS/oihpJiEn0Lqf9zEoZFiplfWl50CW5V/faUXN3vl6g+De3bQwCLE6H9cZXbUwmVivVizDcFkHAQ0t3fESh1je0zR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261151; c=relaxed/simple;
	bh=32lJSqfS/jJayhpYdDx+rQslJTty49izFRL0Zvx4x5g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ny1YonrxOb5ysnZrRrx4AFHlGPvHBA13F+tBOigd5m4zuwL/W0Wf7g3GPYBKOA0NolPGdtjCwvxG4uV909pggGplOJfTD8UzLQJhm7mTvlstzqa6H6X54MJCaASZI+7R5jc/liks8kiGTLXVYtENIHEq9Tfv/ayJlt+JPFZ9TIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMkGm2iH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261149; x=1750797149;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=32lJSqfS/jJayhpYdDx+rQslJTty49izFRL0Zvx4x5g=;
  b=SMkGm2iHpJH8YdG9hBq5xr+XjTrD4aTCbAlvNSl8zUqtak0JMbBjjuaW
   sKJ+U3DnHct4KHevlABxHjKZHbkKCO/vuYgjxqSDgsMOd87AKOO2i1YOq
   9vzef3Sy3YYNlsS3rbVLl5iVSIPLnZhpUZKozB0QnvOvRwVeKvjCddLen
   8S/NOvGlf3Eh24sTcndoZVfVATeOH6LQX8L9IQv9M8ZMvQ5QPYQlClLI8
   A70w5CXkdXsdWI9SM1C/QHJFq0m50XsjzKCGekcTWcyQJTR2lX4FIsrpG
   ZBkJQuDUI7T3SC7FeZpyxbMJ6iX49o0+xU5smAW7vIRdcDvmws+9HC9rz
   g==;
X-CSE-ConnectionGUID: CziPfuoaSh6OYFShNhQUqQ==
X-CSE-MsgGUID: mCC5xJ7+SSS4BGlHNy+K8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33792354"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33792354"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:26 -0700
X-CSE-ConnectionGUID: NTEnfBV/S8upzsa4KhDxiQ==
X-CSE-MsgGUID: ZpDRi15qTJ6X0VA0A+52TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47949149"
Received: from ticela-or-265.amr.corp.intel.com (HELO xpardee-test1.amr.corp.intel.com) ([10.209.54.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:25 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] platform/x86:intel/pmc: Add support to undo ltr_ignore
Date: Mon, 24 Jun 2024 13:32:18 -0700
Message-Id: <20240624203218.2428475-10-xi.pardee@linux.intel.com>
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

Add ltr_restore support to undo the ltr_ignore action. It sets the
ltr_ignore bit of the corresponding IP to 0. Ltr_restore reuses some
functionality of pmc_core_ltr_ignore_write() so moved the common
functionality into a helper function.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 38 ++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index cfdacb04ff8d..9dbd3a43ddad 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -507,12 +507,10 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
 	return 0;
 }
 
-static ssize_t pmc_core_ltr_ignore_write(struct file *file,
-					 const char __user *userbuf,
-					 size_t count, loff_t *ppos)
+static ssize_t pmc_core_ltr_write(struct pmc_dev *pmcdev,
+				  const char __user *userbuf,
+				  size_t count, int ignore)
 {
-	struct seq_file *s = file->private_data;
-	struct pmc_dev *pmcdev = s->private;
 	u32 value;
 	int err;
 
@@ -520,17 +518,43 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 	if (err)
 		return err;
 
-	err = pmc_core_send_ltr_ignore(pmcdev, value, 1);
+	err = pmc_core_send_ltr_ignore(pmcdev, value, ignore);
 
 	return err ?: count;
 }
 
+static ssize_t pmc_core_ltr_ignore_write(struct file *file,
+					 const char __user *userbuf,
+					 size_t count, loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct pmc_dev *pmcdev = s->private;
+
+	return pmc_core_ltr_write(pmcdev, userbuf, count, 1);
+}
+
 static int pmc_core_ltr_ignore_show(struct seq_file *s, void *unused)
 {
 	return 0;
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(pmc_core_ltr_ignore);
 
+static ssize_t pmc_core_ltr_restore_write(struct file *file,
+					  const char __user *userbuf,
+					  size_t count, loff_t *ppos)
+{
+	struct seq_file *s = file->private_data;
+	struct pmc_dev *pmcdev = s->private;
+
+	return pmc_core_ltr_write(pmcdev, userbuf, count, 0);
+}
+
+static int pmc_core_ltr_restore_show(struct seq_file *s, void *unused)
+{
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(pmc_core_ltr_restore);
+
 static void pmc_core_slps0_dbg_latch(struct pmc_dev *pmcdev, bool reset)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
@@ -1208,6 +1232,8 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	debugfs_create_file("ltr_ignore", 0644, dir, pmcdev,
 			    &pmc_core_ltr_ignore_fops);
 
+	debugfs_create_file("ltr_restore", 0200, dir, pmcdev, &pmc_core_ltr_restore_fops);
+
 	debugfs_create_file("ltr_show", 0444, dir, pmcdev, &pmc_core_ltr_fops);
 
 	if (primary_pmc->map->s0ix_blocker_maps)
-- 
2.34.1


