Return-Path: <linux-kernel+bounces-180431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C658C6E95
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70211C22100
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A16315E1F1;
	Wed, 15 May 2024 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WU14Ho/0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1E15CD62
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811821; cv=none; b=pOchT692l85XuRcu+laIvufDQhHVUwyBnvx2LBhi9cE0dtXRPaKJUoMjiDPC4bDVtkub/RNBDcJtLhyRzLTSSue+zylbZvxi3EUJEXPo5NN/HLSwnhoVLg5Qpo2CDx0apxlCe2zdHNH98KAasqcSHB+Ekz21FhWuiHWvJVindU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811821; c=relaxed/simple;
	bh=TU6adTaK6z06ftA3d3b1Rp6eaFEXtWKr5JvtLW3jvXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbjcBmyyPVsnxOZaqzSNUCi4nZOY3klIwsEoMA/PuTFDi7QjEJxSzVACB+Mo36uO9GG57A4SsoopTGX7CeR4nkGYyO1Vcz4rghocEr7pwVITIknTIMbTxJdFTF0uEhzf0sK6iTvaycPXStoAvTED1MzNwuiyZDSMsrSboDhUwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WU14Ho/0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715811820; x=1747347820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TU6adTaK6z06ftA3d3b1Rp6eaFEXtWKr5JvtLW3jvXc=;
  b=WU14Ho/0jLrJ249Eo/o7sQUMcip9VkYLrA/6ElSFse50NBnUYejTdJAp
   Hcu5so8jJEJsYbkaNMyZ06ClTSMDQsvquaaNTXFs16+QQ0KBTX3pnzR29
   6xzhVzK+KkerZl7pAC13JlYN7mp3kuxO0apk2zkIIK7wQafvfDekYnqTP
   vpeHvr2y5ct47xTKSqIjqPOrsNMr44zoKtUnRhDBOfiC3xvSV/7Jd+u3p
   LjhrMv+cSd0HGJNan+mWyjoDGH7RaMFD8RZy9tPSHyxkNZImFq55F4wJJ
   Z8MwI9PYWZEHEUZZv2p3RPtoCsCZ4b3DbXvOdixiNLfrQqE3dH6nEiloO
   Q==;
X-CSE-ConnectionGUID: siksPkjsT2mbBGyW/rQ+1A==
X-CSE-MsgGUID: Nt+JwPN7SrSqInGNZ9SypQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15671637"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="15671637"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:34 -0700
X-CSE-ConnectionGUID: 6NHmxtiiSHqhr2K1+vLQWQ==
X-CSE-MsgGUID: zzisozSiTPOwldjH+CxJsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35989162"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:34 -0700
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
Subject: [PATCH v18 07/17] x86/resctrl: Prepare for new Sub-NUMA (SNC) cluster monitor files
Date: Wed, 15 May 2024 15:23:15 -0700
Message-ID: <20240515222326.74166-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515222326.74166-1-tony.luck@intel.com>
References: <20240515222326.74166-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When SNC is enabled monitoring data is collected at the SNC node
granularity, but must be reported at L3-cache granularity for
backwards compatibility in addition to reporting at the node
level.

Add a mon_display_scope field to the rdt_resource structure to track
reporting scope. Default is for non-SNC systems where both scopes
are the same.

This is the first step to an eventual goal of monitor reporting files
like this (for a system with two SNC nodes per L3):

$ cd /sys/fs/resctrl/mon_data
$ tree mon_L3_00
mon_L3_00			<- 00 here is L3 cache id
├── llc_occupancy		\  These files provide legacy support
├── mbm_local_bytes		 > for non-SNC aware monitor apps
├── mbm_total_bytes		/  that expect data at L3 cache level
├── mon_sub_L3_00		<- 00 here is SNC node id
│   ├── llc_occupancy		\  These files are finer grained
│   ├── mbm_local_bytes		 > data from each SNC node
│   └── mbm_total_bytes		/
└── mon_sub_L3_01
    ├── llc_occupancy		\
    ├── mbm_local_bytes		 > As above, but for node 1.
    └── mbm_total_bytes		/

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h            | 2 ++
 arch/x86/kernel/cpu/resctrl/core.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5c7775343c3e..98c0ff8ba005 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -187,6 +187,7 @@ enum resctrl_scope {
  * @num_rmid:		Number of RMIDs available
  * @ctrl_scope:		Scope of this resource for control functions
  * @mon_scope:		Scope of this resource for monitor functions
+ * @mon_display_scope:	Scope for user reporting monitor functions
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
  * @ctrl_domains:	RCU list of all control domains for this resource
@@ -207,6 +208,7 @@ struct rdt_resource {
 	int			num_rmid;
 	enum resctrl_scope	ctrl_scope;
 	enum resctrl_scope	mon_scope;
+	enum resctrl_scope	mon_display_scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
 	struct list_head	ctrl_domains;
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index bfa9d3a429fd..15856254fea7 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -71,6 +71,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "L3",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.mon_scope		= RESCTRL_L3_CACHE,
+			.mon_display_scope	= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
-- 
2.44.0


