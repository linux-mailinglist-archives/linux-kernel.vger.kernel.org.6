Return-Path: <linux-kernel+bounces-225433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 201D991306B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD2A1F22158
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE916FF4D;
	Fri, 21 Jun 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bt/99xF5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9915532C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009557; cv=none; b=W0ArKviCwJtWokmbXAWoYGDJgubqUIDGPgyoB7AjednSC0SThcAgPEJWDw1HHbSmo66gkhGRWOgiWnEripaceHvwk+clveX9aVVJCDwQZ25+PNPDduR/pCC+phWrHuQLteuDCWXcHJ8q90+IS+UztSaxbT/YGbCc96cMt42KYs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009557; c=relaxed/simple;
	bh=xalcDH7xFOjOU7DCVtWTUs2cEEKmxyG55J7Dr5SEIFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BErSJMwx4tToGptazHrwA4adB2y3UaRq9RjiuW9UBey3spdPV7cFqcoebSC4ZAVyP973Lmq98D3OppmPfMHRcnlQYLdjBeLESfNRxtyjEzXdqw3YjHo7FDg4g52eRamEnsjkYcM6eF8EBttktCr32bSPAO378/1nLHWS87FmQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bt/99xF5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719009555; x=1750545555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xalcDH7xFOjOU7DCVtWTUs2cEEKmxyG55J7Dr5SEIFI=;
  b=bt/99xF5eG0IubC2SVjFSc6MzDLYpuz330c9RPoAAfEN2UWhmbzUb6Bx
   SSclIucMopXZfoMDD7t8J0HSputACyYPs0Dt7v15rWayaAhjzl25wEOxu
   YMI7Re0EiWnkgvw9iFghBx4d6z4fNb5IbQgJn0/oah+37D74RSRwZmp0w
   sjLTgpPaBwZ4dn1d812OS6t8BE/2A6q14xOW4osV771aRvg9kVWHXDzmN
   6+CY3e4xL2wv+UaQQapKGGgA7cme5fB+H1dMrJKoXn2itwwdkDx7FmzJu
   DsiQ16k7WJEmtQIAYIQUgQS/2ndb1tjS/uslh0rNmDw6mu9VqWJT4UAOi
   A==;
X-CSE-ConnectionGUID: k5yAvy/jTx+xIbjbsSgnwA==
X-CSE-MsgGUID: nWTznuHcSsed1mieD79+qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="26691312"
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="26691312"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 15:39:08 -0700
X-CSE-ConnectionGUID: Vd5SlHl2S0avmLchpcO93w==
X-CSE-MsgGUID: bOPiIp2mRjSwvifUxk6ybg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="73935665"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 15:39:08 -0700
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
Subject: [PATCH v21 09/18] x86/resctrl: Add a new field to struct rmid_read for summation of domains
Date: Fri, 21 Jun 2024 15:38:50 -0700
Message-ID: <20240621223859.43471-10-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621223859.43471-1-tony.luck@intel.com>
References: <20240621223859.43471-1-tony.luck@intel.com>
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

Reinette suggested that the rmid_read structure has become complex enough
to warrant documentation of each of its fields and provided the kerneldoc
documentation for struct rmid_read.

Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 135190e0711c..d04018b8b571 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -144,12 +144,31 @@ union mon_data_bits {
 	} u;
 };
 
+/**
+ * struct rmid_read - Data passed across smp_call*() to read event count.
+ * @rgrp:  Resource group for which the counter is being read. If it is a parent
+ *	   resource group then its event count is summed with the count from all
+ *	   its child resource groups.
+ * @r:	   Resource describing the properties of the event being read.
+ * @d:	   Domain that the counter should be read from. If NULL then sum all
+ *	   domains in @r sharing L3 @ci.id
+ * @evtid: Which monitor event to read.
+ * @first: Initialize MBM counter when true.
+ * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing domains.
+ * @err:   Error encountered when reading counter.
+ * @val:   Returned value of event counter. If @rgrp is a parent resource group,
+ *	   @val contains the sum of event counts from its child resource groups.
+ *	   If @d is NULL, @val includes the sum of all domains in @r sharing @ci.id,
+ *	   (summed across child resource groups if @rgrp is a parent resource group).
+ * @arch_mon_ctx: Hardware monitor allocated for this read request (MPAM only).
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
2.45.2


