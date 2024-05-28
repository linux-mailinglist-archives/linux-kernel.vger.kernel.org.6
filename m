Return-Path: <linux-kernel+bounces-193168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025D8D27EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402812872A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C07143881;
	Tue, 28 May 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZT9wmLTN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7B140E2B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934827; cv=none; b=kHMF4w6grfuf6FKjdfdcW8LaUOG1bNWgW7iH8NMFPx6B1BxYO8otkueqrHtlGIc89Q5XLkBlyt4lNuAM2Wco1AuaHGBqzyBqiySZKPdpADW+WdgZPhblElz6tfXlguOHdCEjjO1toO9GP9uQwMDTCgQ6zh7DGbkZm2WHZxw5ruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934827; c=relaxed/simple;
	bh=IorIMWxs/gs9G2e+fIJjKu+T6wnYFb7FW0tiY1sOfW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wl7WE64XuUum5+QVk+O/9Rth5op0kz29WObQlRsk52OXfmWcIVDbjEzoqOvD5WkMZWQ3SJ2DvK7rFCwM+MzZeItXiVQOBQm0R7iQuuR2nhGDLs1SdYkI0GuxsAfzR4JksK6TLZMd6Dbm527w7fPLIefA02MUlNksa3DZ1emPBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZT9wmLTN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716934826; x=1748470826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IorIMWxs/gs9G2e+fIJjKu+T6wnYFb7FW0tiY1sOfW8=;
  b=ZT9wmLTNN0q1jNrKuxzU1rGLI1Pl0ssjV7tVFfUjowlrvbHy/VyfM4tY
   FtBe7PexNZhgysPTim+CNcEN/GR0Djilbi5b4nnUTFUX///1Azfx7DNZn
   wYSQ75RlkShh9QIwgxYafVc1dTZJdiw5bdiFCrlx7abhfm4p7Aw2jL6sK
   1JsrHz+sUF5wsOkdzTN7kC7Hhen5hmJa6OP9z6NtpUB0IWNNls7LNsZad
   ccyucWEDunHyk2t4DMWgpiaFwWzqHfRRXujVUK2bXXj44Gw+DOVfUpbZ/
   EPlk2+3dR6/IWd1ejXYuc7tyNO/xUEE5/ICrQniF2EQkm3lrx5WlDD3zT
   w==;
X-CSE-ConnectionGUID: Ud0znyTTRQySBRCbsWn3OA==
X-CSE-MsgGUID: vhpvYNSySH+mg7DFR4ZFGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30812233"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30812233"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:19 -0700
X-CSE-ConnectionGUID: bAd8cXkbSu2OItmG3YHEDw==
X-CSE-MsgGUID: L5hHJfCnQne9S7kgBGZymg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40090756"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:18 -0700
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
Subject: [PATCH v19 14/20] x86/resctrl: Fill out rmid_read structure for smp_call*() to read a counter
Date: Tue, 28 May 2024 15:19:59 -0700
Message-ID: <20240528222006.58283-15-tony.luck@intel.com>
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

mon_event_read() fills out most fields of the struct rmid_read that is
passed via an smp_call*() function to a CPU that is part of the correct
domain to read the monitor counters.

The one exception is the sumdomains field that is set by the caller
(either rdtgroup_mondata_show() or mon_add_all_files()).

When rmid_read.sumdomains is false:
	The domain field "d" specifies the only domain to read
	CPU to execute is chosen from d->hdr.cpu_mask

When rmid_read.sumdomains is true:
	The domain field is NULL.
	The cache_info field indicates that all domains
	that are part of that cache instance should be
	summed.
	CPU to execute is chosen from ci->shared_cpu_mask

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 28 ++++++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 3b9383612c35..4e394400e575 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -517,6 +517,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first)
 {
+	cpumask_t *cpumask;
 	int cpu;
 
 	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
@@ -537,7 +538,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		return;
 	}
 
-	cpu = cpumask_any_housekeeping(&d->hdr.cpu_mask, RESCTRL_PICK_ANY_CPU);
+	cpumask = rr->sumdomains ? &rr->ci->shared_cpu_map : &d->hdr.cpu_mask;
+	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
 
 	/*
 	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
@@ -546,7 +548,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	 * counters on some platforms if its called in IRQ context.
 	 */
 	if (tick_nohz_full_cpu(cpu))
-		smp_call_function_any(&d->hdr.cpu_mask, mon_event_count, rr, 1);
+		smp_call_function_any(cpumask, mon_event_count, rr, 1);
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
 
@@ -575,15 +577,29 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	resid = md.u.rid;
 	domid = md.u.domid;
 	evtid = md.u.evtid;
-
+	rr.sumdomains = md.u.sum;
 	r = &rdt_resources_all[resid].r_resctrl;
-	hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
-	if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
+
+	if (rr.sumdomains) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			if (d->ci->id == domid) {
+				rr.ci = d->ci;
+				d = NULL;
+				goto got_cacheinfo;
+			}
+		}
 		ret = -ENOENT;
 		goto out;
+	} else {
+		hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
+		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
+			ret = -ENOENT;
+			goto out;
+		}
+		d = container_of(hdr, struct rdt_mon_domain, hdr);
 	}
-	d = container_of(hdr, struct rdt_mon_domain, hdr);
 
+got_cacheinfo:
 	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
 	if (rr.err == -EIO)
-- 
2.45.0


