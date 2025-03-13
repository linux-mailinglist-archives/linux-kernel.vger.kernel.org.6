Return-Path: <linux-kernel+bounces-559558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C725A5F597
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DE2189042E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AAB267AFD;
	Thu, 13 Mar 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eE98MHiS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3F26772F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871327; cv=none; b=OFM49TOcf7ik7Kevxrhg44+g1zXnFVxSArhaWkTdi18it0fDJ7VI9fkOMnfihpL+Ahgd64RIL3J1zgEomXdTRs3LT3YnAARRnY0Zguh2DOVO6eGlws9eSX/4BjzG+JJ0pI6oo1AhDMjvtc6163DJywYqZBU0q4jSzfoDJyel6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871327; c=relaxed/simple;
	bh=Md9tocAhH1stH7wG31sbdM1EhyJkqlAw+/cWKPZwGPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQqL3PCpA3LUETrNUm04ODVcfcotiPur6ESbPLVBvLisQEsPH3dn2spCf05AustNM0NcspsCtNgyDQ9Bn6NroDoEaGWK88GGalXxqsgaN72k3p0EMpgESw9jC7FwsiEGEISeasUhOCxiuKsyekQ4qQJHcMV9xizmenasKnesHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eE98MHiS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741871326; x=1773407326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Md9tocAhH1stH7wG31sbdM1EhyJkqlAw+/cWKPZwGPg=;
  b=eE98MHiSSahQxnYNN/ayiadEsTyzeAO5qSdJJ79bqD+o6nZ84zllOBf5
   8zR/9fgUoFtq2va3XfwNlr7gsQUSCgQDRd88ph/kNzaPN9adAlbE3vYt5
   8SeDIKW6UlY6mkyBVayrt9lq2sgHpJ8sNNMurBr6HNBcmaIB5CgiYtLzJ
   J1ly+IRIsPVXYq9LOue+YiIMJgpgMujudR9GbzRk+qM/HECiX1lCYuKFv
   AzUvCz2+SskiXYekhxVY6EBt1w0Vjw9bgsnidPmKSH07uOH9jsTugl0fd
   ssrAECCjMK4D4kXvn8tzawrsYvVtweRnpSllj4VOCp8YyBayryY1VDZXJ
   Q==;
X-CSE-ConnectionGUID: EIpXuX+vTmajv2mGRO4DFQ==
X-CSE-MsgGUID: ug9l7Ui5Q/yqL7vDi+SlFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53191644"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53191644"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:08:41 -0700
X-CSE-ConnectionGUID: bEGg6bx4Q1GnEEGAmNZ4ig==
X-CSE-MsgGUID: IEI1k3LnSpa887jflcwnPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126011503"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 06:08:41 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/4] perf/x86/intel/uncore: Add iMC freerunning for Panther Lake
Date: Thu, 13 Mar 2025 06:08:47 -0700
Message-Id: <20250313130847.4081079-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250313130847.4081079-1-kan.liang@linux.intel.com>
References: <20250313130847.4081079-1-kan.liang@linux.intel.com>
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

No changes since V1

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


