Return-Path: <linux-kernel+bounces-208849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 464289029DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC96B2504B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1038814D2A4;
	Mon, 10 Jun 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWuWZPdl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359B4D8C5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050675; cv=none; b=DxS8DRYRQJldVPfEkfYyii+CcPXnS+152j0hmriaPfngq6faMpJfbcwCefUk5KEd3TjvPLDDMggikkV40W7QKSnZ+0OhQl+lFCorSFCOp8owZlwNuFe2oDILaS159tKYpCbjmL6Qq/Gw4hpy0Q0tsK2D7+H9CokqcKRLOLVSPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050675; c=relaxed/simple;
	bh=Q+TO7WPwh47NG19W5uRxnauRQqMejPS2GM07LB24eWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAFlnp8i19/4CExn+SaKJnmds1CUFwfqbJSf3uMFoaou9pFFgQAcl0BpCToFcrHFfIb4lh6FA5QBbAP0x1ezwvltwuRRecNysikfQ2CwarIE7GZ2OQ/NgOZYJxwHhKZ/fI94PmLPRELvYhEVY52Q1KODRoY2hpUNpvIBYIZ0/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWuWZPdl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718050674; x=1749586674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q+TO7WPwh47NG19W5uRxnauRQqMejPS2GM07LB24eWg=;
  b=ZWuWZPdlUWQ3C0vDmjRBTETYmnFRWi9MjIq0Z3n2oADK1aHMu+PiOmTu
   HNNRcRdD51HV2rGC+mdL6xWZl2Rej/t+Bh3lgEW5Bt5Dzjpuy04aecI77
   WUucgmXgCdNUTDWA0NfWvMAlBYqtLlfKvBa/VHoDEt6hDeYxihmgp+R/9
   G7RqN1RrVOMqlqqKJuL/skwZiBVHBeL8Apf3xtFLVV8jIxkrrCGT8rUTR
   RGzwxGqFC51yxEsROLTYJ4HArDm93VwKGBB/8FeJWwf8zEJgviXNJIp3/
   ZVoyVNHtSEn/1wK49Gz/CDCESHBk4qug7J5u5DprvAYZ1rT7nm6PLTF6P
   A==;
X-CSE-ConnectionGUID: jOxexuxAR/OdQJIo1VcuZg==
X-CSE-MsgGUID: iOAMEQsHSNm0R4OmDmhV1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18561516"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18561516"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:17:51 -0700
X-CSE-ConnectionGUID: Fl05qcTsROyz5zVYtzp62g==
X-CSE-MsgGUID: xl5dWpXGQjKncjNs44ReAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39169084"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jun 2024 13:17:50 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	eranian@google.com,
	ak@linux.intel.com,
	yunying.sun@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/8] perf/x86/uncore: Retrieve the unit ID from the unit control RB tree
Date: Mon, 10 Jun 2024 13:16:14 -0700
Message-Id: <20240610201619.884021-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240610201619.884021-1-kan.liang@linux.intel.com>
References: <20240610201619.884021-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The box_ids only save the unit ID for the first die. If a unit, e.g., a
CXL unit, doesn't exist in the first die. The unit ID cannot be
retrieved.

The unit control RB tree also stores the unit ID information.
Retrieve the unit ID from the unit control RB tree

Tested-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 075c92e0e4bc..27a0cda5cc91 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -863,6 +863,9 @@ static const struct attribute_group uncore_pmu_attr_group = {
 static inline int uncore_get_box_id(struct intel_uncore_type *type,
 				    struct intel_uncore_pmu *pmu)
 {
+	if (type->boxes)
+		return intel_uncore_find_discovery_unit_id(type->boxes, -1, pmu->pmu_idx);
+
 	return type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx;
 }
 
-- 
2.35.1


