Return-Path: <linux-kernel+bounces-269702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CBC9435F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A061C22118
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E18287D;
	Wed, 31 Jul 2024 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8XEd5jX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45CC1396;
	Wed, 31 Jul 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722452282; cv=none; b=aCozGVe4OI2XZn6unAENGth+dYTgWSfmxV5Jbo4JtVVUwMZEbkwx/MhF8P10sATF9kvfCYu4UjK8rFeygQSRVKNKMzBy1IjjYYgvz4EwlTFEPRhmCu7XmNa0bqyXi3lulIji+TJ/BC5Y2PZZl7iX5r2/zpho3qTQPswIQou/ZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722452282; c=relaxed/simple;
	bh=MGeuEpaSQDHD8qKl4h2iryP6SiEohHJXEcqm6rTILks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opUrKN7efcL9YTiakpbpdv1Y2wjZ+lGilGztn9XUAePwMUQ00panzjdslYuwF0KObKhoBVsABSUK4GFS09kclg+j7eN4aY/GDUustA/BCMmvtp4FUfcvKjr5NoODedCCwHLYixnkfCTsz27BjO9NmBBBO4FGNP24lhNMExRRohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8XEd5jX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722452281; x=1753988281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MGeuEpaSQDHD8qKl4h2iryP6SiEohHJXEcqm6rTILks=;
  b=J8XEd5jX80j4ZxcYY8SkGbMd9CKu83E37iWInHw8AgRsWDFM82UEFfGJ
   eeXd9GuZRmKoX6B2hZuZQtV8mWwSKHBpAAFnScD4e2tYgAh0PPrklNuNT
   P8Y4lcnl0B3pZOSFWd34tLJ6eoCSxoFbg3IWt5tEgkIDL/PclRVfFyEk+
   vdM+HEi4CJfN7jEe2Cg2JJv0+//vPMkQFajq53Yao9g1H54Q1883maHwf
   xJUFpLDrnyUUfm9eCh8gxmWJNcybos6ShPcwDI4nvSWpV8tqVP+TlhWN7
   WZs/zg302X5wm1SKGcqrdP2/zVUd+7pV9n4/JKz4cMfxvHF9SO4mau4zk
   g==;
X-CSE-ConnectionGUID: OIXXcneFQ3+HiR0IEiRFdw==
X-CSE-MsgGUID: FS7reeQ2S4m4RFq0UCm/mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="12811992"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="12811992"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 11:58:00 -0700
X-CSE-ConnectionGUID: 06+RDcWcQSG8iKj27fsldA==
X-CSE-MsgGUID: GNlyGowSQA2jxXKI//aFBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54437617"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa007.fm.intel.com with ESMTP; 31 Jul 2024 11:57:58 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel-uncore-freq: Do not present separate package-die domain
Date: Wed, 31 Jul 2024 11:57:56 -0700
Message-ID: <20240731185756.1853197-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scope of uncore control is per power domain in a package and die.
A package-die can have multiple power domains on some processors. In this
case package-die domain (root domain) aggregates all information from
power domains in it.

On some processors, CPUID enumerates the die number same as power domain
ID. In this case there is one to one relationship between package-die and
power domain ID. There is no use of aggregating information from all
power domain IDs as the information will be duplicate and confusing. In
this case do not create separate package-die domain.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c     | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 9fa3037c03d1..6c2e607968f2 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -427,6 +427,9 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 
 	auxiliary_set_drvdata(auxdev, tpmi_uncore);
 
+	if (topology_max_dies_per_package() > 1)
+		return 0;
+
 	tpmi_uncore->root_cluster.root_domain = true;
 	tpmi_uncore->root_cluster.uncore_root = tpmi_uncore;
 
@@ -450,7 +453,9 @@ static void uncore_remove(struct auxiliary_device *auxdev)
 {
 	struct tpmi_uncore_struct *tpmi_uncore = auxiliary_get_drvdata(auxdev);
 
-	uncore_freq_remove_die_entry(&tpmi_uncore->root_cluster.uncore_data);
+	if (tpmi_uncore->root_cluster.root_domain)
+		uncore_freq_remove_die_entry(&tpmi_uncore->root_cluster.uncore_data);
+
 	remove_cluster_entries(tpmi_uncore);
 
 	uncore_freq_common_exit();
-- 
2.39.3


