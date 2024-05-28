Return-Path: <linux-kernel+bounces-193165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762088D27E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A803F1C24513
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8230A1419AD;
	Tue, 28 May 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ur4YWxYa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C434513F450
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934825; cv=none; b=f1GqxWfiefankl23sMmx3eZIgVB9aNU3huE0Me4CRLbFHO8C9q0MWd5jF6OYL81W57lxMuCOD3w4PMPRAj1MieK4UAEFb1bJqLvmLSwqMkisenr0Cj0j6cknCZzxdyPVi6rb/EZcb+FxSlUxj36kIb8avqq0wtbcDsW3lad7Wm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934825; c=relaxed/simple;
	bh=Bn4WCobrLCRai9CuiX0+6K+r0PIf/znTHjUcGtZTPcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reBnmQyMAbnq7eNVBc5ctgLFjyKBqOfn3WoCc8pB3K3B7USadyHcWisJcBjLcgNNqS1CJmfLj9RGZEz4ozHkSIM2gYV621W4pV8ksprJ2K3Xqtger4Um0Fds3kGVsgYe0rlZ5aJNVdeItiauTjNe8+fYP+hnpHIK/t4r6ObmhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ur4YWxYa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716934824; x=1748470824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bn4WCobrLCRai9CuiX0+6K+r0PIf/znTHjUcGtZTPcI=;
  b=Ur4YWxYaI559f5FkIWw242hJW2PyExrjPhb9rK4Qhj2n/Ru0hNFirLpU
   eHCpLGKtR9sdSSpev6eThSApP3ePadYRFwkGSSvRcu7sikSWzP/U5k8U7
   WWOGb2TB0b4vRJ3H5Iov1lA+yhvU+lslZiRyYQTvwGzpABiniORN3vJ1H
   CuQSvDuFTHjqgMlWLzo7yf844szehgjyo5oi/gHfTCWFRV5lFiwlB11VO
   6DHdGWKiPV2AK35SCTNFLhBMv/KpxPn8LlTavRcrYVH2zuhHwct1E8dtK
   YirEWbdXtSe6liA1UliQfuPV06VP0+A+JAb4U7MEpM+uavf3FJWcUbQl1
   w==;
X-CSE-ConnectionGUID: 73KGliE6RsKQi3aPelvgrA==
X-CSE-MsgGUID: gTGXjWcHS1eMEOEGdNLlmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30812212"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30812212"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:18 -0700
X-CSE-ConnectionGUID: n4Kg3+09S0Cb8L6ferM9Tw==
X-CSE-MsgGUID: GYiwBNMHTQqRlS1jUTPkWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40090743"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:17 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v19 11/20] x86/resctrl: Allocate a new bit in union mon_data_bits
Date: Tue, 28 May 2024 15:19:56 -0700
Message-ID: <20240528222006.58283-12-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528222006.58283-1-tony.luck@intel.com>
References: <20240528222006.58283-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Sub-NUMA Cluster (SNC) mode is enabled the legacy monitor reporting
files must report the sum of the data from all of the SNC nodes that
share the L3 cache that is referenced by the monitor file.

Resctrl squeezes all the attributes of these files into 32-bits so they
can be stored in the "priv" field of struct kernfs_node.

Arbitrarily choose the "evtid" field to sacrifice one bit to make
space for a new bit. This structure is purely internal to resctrl,
no ABI issues with modifying it. Subsequent changes may rearrange the
allocation of bits between each of the fields as needed.

The stolen bit is given to a new "sum" field that indicates that reading
this file must sum across SNC nodes. This bit also indicates that the
domid field is the l3_cache_id (instead of a domain id) to find which
domains must be summed.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d8156d22cbdc..7957fc38b71c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -133,14 +133,20 @@ struct mon_evt {
  *                     as kernfs private data
  * @rid:               Resource id associated with the event file
  * @evtid:             Event id associated with the event file
- * @domid:             The domain to which the event file belongs
+ * @sum:               Set when event must be summed across multiple
+ *                     domains.
+ * @domid:             When @sum is zero this is the domain to which
+ *                     the event file belongs. When @sum is one this
+ *                     is the id of the L3 cache that all domains to be
+ *                     summed share.
  * @u:                 Name of the bit fields struct
  */
 union mon_data_bits {
 	void *priv;
 	struct {
 		unsigned int rid		: 10;
-		enum resctrl_event_id evtid	: 8;
+		enum resctrl_event_id evtid	: 7;
+		unsigned int sum		: 1;
 		unsigned int domid		: 14;
 	} u;
 };
-- 
2.45.0


