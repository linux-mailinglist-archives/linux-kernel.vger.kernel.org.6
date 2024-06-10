Return-Path: <linux-kernel+bounces-208747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4229A9028C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F60B23817
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D4A1514C9;
	Mon, 10 Jun 2024 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gp0yIfuy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB6B14EC73
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044545; cv=none; b=JcBqwUByAQDOwZEgBtMPb6pst7ypZ6RDBhvVo0QlFmGYQ1aJtojTXo6p/PT57p2x1/N2Ioie2lrYDjtH28KEq4sBZcSs/+U+g5+bShK37FvwOvqxg6dkJJbwlSlLl5ZvvYMs+F4J/J/4CgX6s8AZs4s1sXOW/Cq9NDwbnbBSHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044545; c=relaxed/simple;
	bh=n/UgyX1U4zOUKAVlm2WMJOCOaWfvqKc/RRK5WzMIgI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBU8VW+k3DtjyZ16CfFqJrxDj827o0pr1QvnsoQZDVRypDXf5m6LfhBhXu1qkDtsxIT+W2aXzvnGZHLGYvPlEQy7MdY/ZNeWd9vHZ/tesgI0KeGlXQSp25uBq3n7huI3NZOHvswsef+MGP7keaUC0VgYLv1Ob28xbzaOLWTOSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gp0yIfuy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718044544; x=1749580544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/UgyX1U4zOUKAVlm2WMJOCOaWfvqKc/RRK5WzMIgI0=;
  b=gp0yIfuy+F3+UXeqIemJfMJ5AwPTkr8cBCbEnxOXS/cQ7Opwmh8g5wTU
   t6LObajZmJzQMh1fehsQjZ9tjlrY3WLI2LiLVeQZnl9dJepBFYG5/PzOT
   c/aMi2+139uU/K+nQbuNmgDfr12qM32XbotcRhC916L4cs7Er9Bfq5+1d
   JzPMsXJzQ+KgxIpLkTK0fVbT/pslvBErO0l01o/qQ7VJaCyiTeVQE0rzh
   x8ws1ZKw6gsMp2TPgsIpwguwv/KArBoFmhzECRIAbaxUQ9694KLnJNh6G
   cBBZLdorhBVG6wf+TWqR9dhh/olkO2TiO4zyP17AyOS+234Ah+ebUvIcD
   w==;
X-CSE-ConnectionGUID: JLDMLsFrQECEAU0cobKICQ==
X-CSE-MsgGUID: AZ/q95EoSR2ERE/JYinCkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12004834"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="12004834"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
X-CSE-ConnectionGUID: zStku52nQu6uU60eIgGNUQ==
X-CSE-MsgGUID: ZrrWjfSVTKmHoaoioOdLrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43576575"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
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
Subject: [PATCH v20 09/18] x86/resctrl: Add a new field to struct rmid_read for summation of domains
Date: Mon, 10 Jun 2024 11:35:19 -0700
Message-ID: <20240610183528.349198-10-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610183528.349198-1-tony.luck@intel.com>
References: <20240610183528.349198-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a user reads a monitor file rdtgroup_mondata_show() calls
mon_event_read() to package up all the required details into an rmid_read
structure which is passed across the smp_call*() infrastructure to code
that will read data from hardware and return the value (or error status)
in the rmid_read structure.

Sub-NUMA Cluster (SNC) mode adds files with new semantics. These require
the smp_call-ed code to sum event data from all domains that share an
L3 cache.

Add a pointer to the L3 "cacheinfo" structure to struct rmid_read
for the data collection routines to use to pick the domains to be
summed.

Reinette suggested that the rmid_read structure has become complex
enough to warrant documentation of each of its fields. Add the kerneldoc
documentation for struct rmid_read.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 99f601d05f3b..d29c7b58c151 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -145,12 +145,25 @@ union mon_data_bits {
 	} u;
 };
 
+/**
+ * struct rmid_read - Data passed across smp_call*() to read event count
+ * @rgrp:	Resctrl group
+ * @r:		Resource
+ * @d:		Domain. If NULL then sum all domains in @r sharing L3 @ci.id
+ * @evtid:	Which monitor event to read
+ * @first:	Initializes MBM counter when true
+ * @ci:		Cacheinfo for L3. Used when summing domains
+ * @err:	Return error indication
+ * @val:	Return value of event counter
+ * @arch_mon_ctx: Hardware monitor allocated for this read request (MPAM only)
+ */
 struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	struct cacheinfo	*ci;
 	int			err;
 	u64			val;
 	void			*arch_mon_ctx;
-- 
2.45.0


