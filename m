Return-Path: <linux-kernel+bounces-552710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85DFA57D40
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFE7188D4C6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31608215050;
	Sat,  8 Mar 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQLl/3hp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11F1FF7CD
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459022; cv=none; b=D+VGpQq5CpqPuUcuAc+1wQFqyeIsst+un32+HK886nMQA86dKxbTNNxMPQA7rijSG7rQSmn0Q+jTacrBPR+8RST3ggp9mOf2xe/eQVia5SpzBBu7pFyG8A/i25CN5Lp91wGw9Th9G2WSHhw2zqdU5RBuZ86y3rDMW/2spxb256g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459022; c=relaxed/simple;
	bh=t2B2o+S0wXOAA4+LJE2F4eNiPS9UXwAkOPzF1uone2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OR9tOWq113amcT49n0XFat1LQdXENJC1Hhw1nwqIIFiZeuvyZaHCFOnnMWuSdMnH3oE8hlh/tsgVqqX3VJ7fI/phsnhAMvJNhw/Prt/fddo9Eee9RVhNyfCMyCdzJyHDqy+EaKqIpEAImGIs6/LfIjjaZbCwflHnU4VV0UJYQsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQLl/3hp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741459021; x=1772995021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t2B2o+S0wXOAA4+LJE2F4eNiPS9UXwAkOPzF1uone2o=;
  b=IQLl/3hpaV4rs9x2Bp7KM2t6YLIOIXrr2LoDMnY6+caTF0fDmX0tfmej
   TMYXVpDP6/4JPUWyaBTk6ygjix7xf1Wxvb0p5UIVrFjQ7GWKjRpEjU621
   Fn0uVTC4uY2Mb15EC3sxlAC1TxapZYlGStnfZ4dProVtlS8LZyc0v2Pf1
   sIfH8OL/6SBEId2s1ARWFlZmE/b8DEL/H5H6zae8Hl2uYVKpoNsDTCeOJ
   HPa32dbmX16mO120U5x8X0tUXSbfY3k2tF89GjdqZLCt7EBhgxPtFM2LM
   I+PN5dFQwPSMB8rasWKCLe0H8xL7f25iC1RNbO/zCx2/elZGPmiYPKxoQ
   w==;
X-CSE-ConnectionGUID: is9Zh7I9R2aAwLgcrL/d1A==
X-CSE-MsgGUID: d9BYY6DlSSiGknaucAzmtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42532472"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="42532472"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 10:36:59 -0800
X-CSE-ConnectionGUID: oSEtz1fQQOOzxLiZcVdhpA==
X-CSE-MsgGUID: HlNNySLHSLWcBgzF2fheQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150548549"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2025 10:36:58 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] thermal: intel: int340x: Enable platform temperature control
Date: Sat,  8 Mar 2025 10:36:54 -0800
Message-ID: <20250308183655.118285-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308183655.118285-1-srinivas.pandruvada@linux.intel.com>
References: <20250308183655.118285-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable platform temperature control feature for Lunar Lake and
Panther Lake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index a55aaa8cef42..f7f03159606a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -486,7 +486,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_MSI_SUPPORT |
 	  PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_DLVR |
-	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
+	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR |
+	  PROC_THERMAL_FEATURE_PTC) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
 	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
@@ -496,7 +497,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, PTL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_MSI_SUPPORT |
-	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
+	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR |
+	  PROC_THERMAL_FEATURE_PTC) },
 	{ },
 };
 
-- 
2.48.1


