Return-Path: <linux-kernel+bounces-193163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9611A8D27E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515EB288621
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C12B140370;
	Tue, 28 May 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdPZXTOw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6875413F01A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934824; cv=none; b=UnO0kxhVSLuSCG6k1yjoPBG0RWHuvBbt4DJQaq+3Q39DEd/okfQsJeHDnSoPUXpLMTOj3INh0PMr5wnn2x2Cvl2S1IWq2jEDiCEebzOFl7TKz1KsaDwq7HYAZktdZocTgQdpE0KHE+UnNnLXg1kWKoGmbu4gLJSiCPMeovymUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934824; c=relaxed/simple;
	bh=pOQZF8HFVACiDlR+DiYZ0BzMt0qWyIWt5Aigq+NSKkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lshlJP1aang4862FbvvSF1gUznO5q9b9Rgm99cXplunjYAYONdOtCBdRKXbtj9gxgBeMSsAOGoSeREZUh2wR9eUMD6ZNjdtPwRuvAQDl7nMI18EO4HnhcWAiRw55BifLsfW6hPd04iCh2uSv/5VgOT7YE26UnYEeAWvrVRuDBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdPZXTOw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716934823; x=1748470823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pOQZF8HFVACiDlR+DiYZ0BzMt0qWyIWt5Aigq+NSKkw=;
  b=KdPZXTOw4dCR+HkfHarEGQOvuHlr5BaxECeA3GE1vpOYet6nKlOYwtZJ
   /pg6K4OmEmMwMOQ3aTF5qvYxXe1HQgWDDZxpOm7qvsNaKEdzl+22BeeAR
   UMgmwGif84fdx3zYllRSYqskaH45y9k5qJQo8e5h74+mG6qy0j7HuZ8TT
   kEhMxqgQerjAynOQi6sNA9s55mOHScNT2lF0tEmjuWBnnzWGUrfSCmvpX
   HBLzGYqSEpRWaLQ1kiL7rsP76+p+3//yxB+u6r7pGVdxSfuV2OqDD97+o
   SPdcWGGObwHSu+XknJSp1Seady8eKBspS7a3B8kN5kfSrK5A1khGQHNnW
   Q==;
X-CSE-ConnectionGUID: jG+mGo68REima1YFYKppBA==
X-CSE-MsgGUID: LYeN2TKcSl+m8bsEHi43qA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30812197"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30812197"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:17 -0700
X-CSE-ConnectionGUID: FZvuxAP9StWnXt+DJU6LHg==
X-CSE-MsgGUID: Fg6efc1BTnyPVBiKm1F4Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40090737"
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
Subject: [PATCH v19 09/20] x86/resctrl: Add new fields to struct rmid_read for summation of domains
Date: Tue, 28 May 2024 15:19:54 -0700
Message-ID: <20240528222006.58283-10-tony.luck@intel.com>
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

rdtgroup_mondata_show() calls mon_event_read() which calls
mon_event_count() which packages up all the required details into an
rmid_read structure passed across the smp_call*() infrastructure.

Legacy files reporting for a single domain pass that domain in the
rmid_read structure. Files that need to sum multiple domains have
meta data that provides the L3 cache ID for domains that must be
summed.

Add the sumdomains and cacheinfo fields to the rmid_read structure.

Add kerneldoc comments for the rmid_read structure.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index eb70d3136ced..d8156d22cbdc 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -145,12 +145,28 @@ union mon_data_bits {
 	} u;
 };
 
+/**
+ * struct rmid_read - Data passed across smp_call*() to read event count
+ * @rgrp:	Resctrl group (provides RMID value)
+ * @r:		Resource
+ * @d:		Domain
+ * @evtid:	Which monitor event to read
+ * @first:	When true this just requests initialization of an MBM counter
+ * @sumdomains:	When false just return monitor count from domain @d. When true,
+ *		sum all domains in @r sharing L3 @ci.id
+ * @ci:		See @sumdomains
+ * @err:	Used to return error indication
+ * @val:	Used to return value of event counter
+ * @arch_mon_ctx: hardware monitor allocated for this read request (MPAM only)
+ */
 struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	bool			sumdomains;
+	struct cacheinfo	*ci;
 	int			err;
 	u64			val;
 	void			*arch_mon_ctx;
-- 
2.45.0


