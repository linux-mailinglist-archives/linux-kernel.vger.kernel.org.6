Return-Path: <linux-kernel+bounces-180434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0388C6E98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD72282249
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4571C15EFA4;
	Wed, 15 May 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cdf14LXn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6315D5D6
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811823; cv=none; b=cVbLJ9g8+e6A8CAcpifltwdsJYSU/r6c1CbPJJXpBv98AnWHqM4NSGRiKtb62cZza897sLb8FVeHLJ3ssfOtLPNOSYmt93Qr76H0SUTNInhngrM++KwxdFxjzgiyc847FsDP0e2UqHiTDoClFp/K8C2otlvQGFxIYVutnnPExa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811823; c=relaxed/simple;
	bh=fZQWGJA37S+/5/Zhu3Tw50fNZ5E9v7U/ReujXZVCtGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRhvqZ2goQwu0efPaNOUQ+rRAKRp++zWuIITMXbg3yfJgu23hiKSmqqvLR3bei6lGFlkg2UfxGqRDiZW2tnnaIgmZldiTS6+E6gZUYWzgwHMcovnIBXm6Wnc2J/ooLCM2lKXafFYSZTeA5XsAStl3YX5+52ubeOtz2MUSRXEqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cdf14LXn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715811822; x=1747347822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZQWGJA37S+/5/Zhu3Tw50fNZ5E9v7U/ReujXZVCtGg=;
  b=Cdf14LXnGy4fujhrcMM0uJPHI+F9ZQwpyczwudyJPPwNF9C+R9u1ULT5
   TWjz35WV3J1n20sZvfKMDlX6Vz6toX2foYtCEI9s3NJ9pEEDPUFC5Y23t
   lDjv4Z7FFfpm8/qq1/GELrILia5jNabQnxhwpSCU8IG3rfp0PdMF/LDiU
   pDPFIAgNAhjRc4D6pjIAJkG0d9ea2yTLM99es5fWWhmqm3XbPKMQhbZqB
   oxqU6U7VquC8ALg+To+G/7bznKrMFzcho/l0krReIBg14PiGnzmlFbB3c
   tKEJInL0eTF7oXxpJli0dfgqa6+tslP5qwT4KYijcTHuoW0MzoDj6u8iV
   g==;
X-CSE-ConnectionGUID: H/9fcesfREKAig2VCO+uDg==
X-CSE-MsgGUID: k/Al6E6QSFmD+eqnJgu0lQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15671682"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="15671682"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:36 -0700
X-CSE-ConnectionGUID: 5NODjmzmQ3iWLN/XL6Cxvw==
X-CSE-MsgGUID: 99XlUGDUSbKsHXGEQ5hagg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35989180"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:35 -0700
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
Subject: [PATCH v18 11/17] x86/resctrl: Allocate a new bit in union mon_data_bits
Date: Wed, 15 May 2024 15:23:19 -0700
Message-ID: <20240515222326.74166-12-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515222326.74166-1-tony.luck@intel.com>
References: <20240515222326.74166-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Sub-NUMA (SNC) mode is enabled the legacy monitor reporting files
must report the sum of the data from all of the SNC nodes that share the
L3 cache that is referenced by the monitor file.

Resctrl squeezes all the attributes of these files into 32-bits so they
can be stored in the "priv" field of struct kernfs_node.

Steal one bit from the "evtid" field (currently 8 bits, but only three
events supported by Intel) to create a new "sum" field that indicates
this file must sum across SNC nodes. This bit also indicates that the
domid field is the display_id to match to find which domains must be
summed.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 498c5d240c68..c54ad12ff2b8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -132,14 +132,19 @@ struct mon_evt {
  *                     as kernfs private data
  * @rid:               Resource id associated with the event file
  * @evtid:             Event id associated with the event file
- * @domid:             The domain to which the event file belongs
+ * @sum:               Set when event must be summed across multiple
+ *                     domains.
+ * @domid:             When @sum is zero this is the domain to which
+ *                     the event file belongs. When sum is one this
+ *                     is the display_id of all domains to be summed
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
2.44.0


