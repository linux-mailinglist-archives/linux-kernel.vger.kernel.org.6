Return-Path: <linux-kernel+bounces-227915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81CC91580E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1228F1C230B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF01A2C00;
	Mon, 24 Jun 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7bogNeZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D71A0AE9;
	Mon, 24 Jun 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261149; cv=none; b=YRtb7slQM4AAokBNL1xN9Mvo+KYvXQp8oEkx8kTf6lStVHB7DQlnyVqQBX9glvIgv9x9mFwH4fYCKwddr/fmGh/yc0pXrwaYHK80FWfNA4QBX5Wrc5hiQPPw1susu7o7yJGW78G+CxC0xPEQjamImqoBXngGANLvu1qkwy/DIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261149; c=relaxed/simple;
	bh=96Ch0fZf/zJPDrbaEiJHd17RxJsQjY7MRs38wnC1hG8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPfLFCOu2QrdGBZ5N/DwEk9DSzdu3TTW3ra8ybrIisZbz1zySGakntPcfyZUiYgB97PORu2zuUA6BHmRCJMoSE0luyJTD4lXBD7zajJBfWruLvZHPObNWbFF3hvicE0UdOWiOu0BdvaJ8eQ9DngblaPOW/eH0GkbnlU9LbHWhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7bogNeZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261148; x=1750797148;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=96Ch0fZf/zJPDrbaEiJHd17RxJsQjY7MRs38wnC1hG8=;
  b=R7bogNeZLzv6W1fw2hclQHtWJrWyf4onFOHeL2xwRJdTMu8LGLRhtOVV
   wxySpLPML3VrFcuuDRgXYuGbgdr8/v4d0gIdT5k1W1kZnCFqgQUWgRK+w
   8C8/tjn8V2F3ZZO9DgniyWpy9adYYoNNd07z9w94S4HT5JLejJ4GEwLyq
   7UTftcAHB4HkZZJL4G50ORiiog0QMsVXABQum6ve9YV8yI+2BBdxq2XNI
   LKvAg9NUC8kgATtleHH59bj+rcYGlce5fNEDJOpRC5JCGejkX85gipDmN
   Q0vQIzEy6gVFSPMURcgFHfsmLopB4Qo09+9DAbdB36+agnMtezH8lnS0d
   A==;
X-CSE-ConnectionGUID: /cZGedhsSfWT3L8MVaDUdA==
X-CSE-MsgGUID: p33+tBR+T4GseYrMg3wfzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33792347"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33792347"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:25 -0700
X-CSE-ConnectionGUID: xo/DFFy2TV2EvexOvyhaLA==
X-CSE-MsgGUID: E3b2PGQFTs+yMff2Mnamrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47949146"
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
Subject: [PATCH 7/9] platform/x86:intel/pmc: Use DEFINE_SHOW_STORE_ATTRIBUTE macro
Date: Mon, 24 Jun 2024 13:32:16 -0700
Message-Id: <20240624203218.2428475-8-xi.pardee@linux.intel.com>
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

DEFINE_SHOW_STORE_ATTRIBUTE() macro can be used for the ltr_ignore
attribute for better readability.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 99adef28b6d0..e75c56ee54e6 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -529,19 +529,7 @@ static int pmc_core_ltr_ignore_show(struct seq_file *s, void *unused)
 {
 	return 0;
 }
-
-static int pmc_core_ltr_ignore_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pmc_core_ltr_ignore_show, inode->i_private);
-}
-
-static const struct file_operations pmc_core_ltr_ignore_ops = {
-	.open           = pmc_core_ltr_ignore_open,
-	.read           = seq_read,
-	.write          = pmc_core_ltr_ignore_write,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(pmc_core_ltr_ignore);
 
 static void pmc_core_slps0_dbg_latch(struct pmc_dev *pmcdev, bool reset)
 {
@@ -1218,7 +1206,7 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 				    pmcdev, &pmc_core_ppfear_fops);
 
 	debugfs_create_file("ltr_ignore", 0644, dir, pmcdev,
-			    &pmc_core_ltr_ignore_ops);
+			    &pmc_core_ltr_ignore_fops);
 
 	debugfs_create_file("ltr_show", 0444, dir, pmcdev, &pmc_core_ltr_fops);
 
-- 
2.34.1


