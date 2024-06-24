Return-Path: <linux-kernel+bounces-227909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4FD915801
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C631F218B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12BF1A08B1;
	Mon, 24 Jun 2024 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcvnxaC1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B0383B1;
	Mon, 24 Jun 2024 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261146; cv=none; b=nMlNwJ5zdAhX4Ed+aMAxQMoE0uDXg3bASdk01nYMJTnd6drNu6mhY+U5m51++F3cN7Czh3vliih4KYKnzdlLkpX5Yv1dXPAd8I0E0SlPY/kjdOAPrXMuI5yNjLQqvJtoD563o5iLngTXlz/xizAxcTQWnJn53vRYBLZyf7iAWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261146; c=relaxed/simple;
	bh=jrfI2LfaIuJh8tOoABJFsU9ljTfvO5uI0RG24qQQFaI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvMYR7DQx0eYeOplEJfepZqX5IngBupR1gieE6QDATLPWhfAP/9uWL0euqinGgChIZfVMfnopE4o//KAjSJ9ItkQDhI7xMqF/J2mb/QudyzYeZSOkzCVxQkuxy718LdxYmct1VWcCtpVtzQXdxebzqkqV+Unj2PDrWLkX6j+e4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcvnxaC1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261144; x=1750797144;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=jrfI2LfaIuJh8tOoABJFsU9ljTfvO5uI0RG24qQQFaI=;
  b=AcvnxaC1j9ix+cIXvIXHIFVEzHtcad8IHWZ7nt3tulR2NN3MUlV40aLB
   Z0XcGE2TN9GLv23Lj2NBkTwEkNqhjA5oFRleRmvUvqQfoxGed4CmRlqYG
   7y2GJ3BoFs8fdR81mLDVEVMHpGrgheeOOmbsfgIMuPR0oRULWXTgsnFD0
   ehKEvluLo0HecFVB2WPqZEdqKv+ZRPHySAofSaabPK8vN2A+LIf0DKZ+g
   GubJZA+VHhJInmPVhQT/e7Yz+f+KuFAp9EpMDZ8KpikluJBhzS2s6PuIH
   xCdYAN7B4YrAswtJpClg8mIR7GzD7rx2gl1Nbryh33C30lMC5eDDCmxFI
   Q==;
X-CSE-ConnectionGUID: ZumFF6zPRS6/ZIg/sSgOuQ==
X-CSE-MsgGUID: yiAdpAFSQ1+f4IhJp1ue8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33792325"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33792325"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:22 -0700
X-CSE-ConnectionGUID: 4OHF3lHFSPCiTIlrkC0Nbg==
X-CSE-MsgGUID: PNor9kl6St23Vqt+Yl1Fvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47949131"
Received: from ticela-or-265.amr.corp.intel.com (HELO xpardee-test1.amr.corp.intel.com) ([10.209.54.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:22 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] platform/x86:intel/pmc: Use the return value of pmc_core_send_msg
Date: Mon, 24 Jun 2024 13:32:10 -0700
Message-Id: <20240624203218.2428475-2-xi.pardee@linux.intel.com>
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

Use the return value of pmc_core_send_msg() directly instead of
assigning another code when an error occurs.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 65eb09c7af6a..e656d51e7ad5 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -403,18 +403,16 @@ static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
 
 	mutex_lock(&pmcdev->lock);
 
-	if (pmc_core_send_msg(pmc, &mphy_core_reg_low) != 0) {
-		err = -EBUSY;
+	err = pmc_core_send_msg(pmc, &mphy_core_reg_low);
+	if (err)
 		goto out_unlock;
-	}
 
 	msleep(10);
 	val_low = pmc_core_reg_read(pmc, SPT_PMC_MFPMC_OFFSET);
 
-	if (pmc_core_send_msg(pmc, &mphy_core_reg_high) != 0) {
-		err = -EBUSY;
+	err = pmc_core_send_msg(pmc, &mphy_core_reg_high);
+	if (err)
 		goto out_unlock;
-	}
 
 	msleep(10);
 	val_high = pmc_core_reg_read(pmc, SPT_PMC_MFPMC_OFFSET);
@@ -455,10 +453,9 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 	mphy_common_reg  = (SPT_PMC_MPHY_COM_STS_0 << 16);
 	mutex_lock(&pmcdev->lock);
 
-	if (pmc_core_send_msg(pmc, &mphy_common_reg) != 0) {
-		err = -EBUSY;
+	err = pmc_core_send_msg(pmc, &mphy_common_reg);
+	if (err)
 		goto out_unlock;
-	}
 
 	/* Observed PMC HW response latency for MTPMC-MFPMC is ~10 ms */
 	msleep(10);
-- 
2.34.1


