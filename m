Return-Path: <linux-kernel+bounces-542761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C9A4CD58
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00873ACBD2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CECF23A998;
	Mon,  3 Mar 2025 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEuQf1hs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D726238D21
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036381; cv=none; b=loZ1jKO6/9Y1CpL38ecS4Gf3ka5XFlISJNKwJ6IOXSnalfjZXzK8mTfmPigcoIrnAGEt3S4MlX6ZwRyrmWIadfstcpG4Vrcmjk18qpewnJeBhYEsg4DitUvS4YnnsdGAp7G2ULsAReTn93diJnqFQZ75aY06b9CxJK1wlxJcAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036381; c=relaxed/simple;
	bh=31NojJ3/EaHRgpM9xSyDxLxa8eoZBsL9/Qa8p809PAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YM5mPZJ/6XUaRXjWCxvaoX5WTZjIb02j31LdG5Ug77e/iiABRmS/+WhBpJzeF/RCzzeelIJsdLDO1ODL96i7W04gRFxuFvWEbsxCuuswTq7ieM9r0YyXsha4GUCN5J1BS3aK6h8MLOiZhObPB114N9lXHtmScWBo4SPtjxE1OIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEuQf1hs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741036380; x=1772572380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31NojJ3/EaHRgpM9xSyDxLxa8eoZBsL9/Qa8p809PAA=;
  b=kEuQf1hs7TTZJ5BLE8Ievy/QfkFBPBJm6+2+RQ7IPHlh8BvkhhyTjE2o
   4tN0KfVAI3EGcn6RJEOs+FEQaRV3x2f0Sly/i/i/5H/4tOdeHNBmBbfKs
   U179DKqdenyC+qja4NnQcmUukrposUuqn2AAZX9LEV5mdAO8r2YmKwR9n
   OL/Kr1IRLmMDbxVx+D2ESEwWTPhPqoxSMsRfbridhsfDmkFLSg5g0tPm3
   5szs3Zm0oHzdhHdYHyN9hJcG94xZZ9hzK3vVqeRqF8SQjBh6egr/tddxe
   I0KUaGBz7CdhjOGZ+LFHWgeMSlMXpbABfwSBv6KgVisSsYfhkfCKtkQNB
   Q==;
X-CSE-ConnectionGUID: bv3NZfWjTY2XhSR5V0bIig==
X-CSE-MsgGUID: P4KXtF6BTcihOixiRFpOWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="67302374"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="67302374"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:12:55 -0800
X-CSE-ConnectionGUID: fNY5LAjOTbm88xox5V6pQw==
X-CSE-MsgGUID: owNNFx0ZTJ2cTKaDFJKiBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="123106906"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 03 Mar 2025 13:12:55 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 4/4] perf/x86/intel/uncore: Add iMC freerunning for Panther Lake
Date: Mon,  3 Mar 2025 13:13:06 -0800
Message-Id: <20250303211306.3261160-4-kan.liang@linux.intel.com>
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

PTL uncore imc freerunning counters are the same as the previous HW.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index b9c0e02b7da4..bea4e7f33785 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1905,9 +1905,17 @@ static struct intel_uncore_type *ptl_uncores[UNCORE_PTL_MAX_NUM_UNCORE_TYPES] =
 	[UNCORE_PTL_TYPE_HBO] = &ptl_uncore_hbo,
 };
 
+#define UNCORE_PTL_MMIO_EXTRA_UNCORES		1
+
+static struct intel_uncore_type *ptl_mmio_extra_uncores[UNCORE_PTL_MMIO_EXTRA_UNCORES] = {
+	&adl_uncore_imc_free_running,
+};
+
 void ptl_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
+						 UNCORE_PTL_MMIO_EXTRA_UNCORES,
+						 ptl_mmio_extra_uncores,
 						 UNCORE_PTL_MAX_NUM_UNCORE_TYPES,
 						 ptl_uncores);
 }
-- 
2.38.1


