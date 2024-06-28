Return-Path: <linux-kernel+bounces-234625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC87491C8B4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00391C21216
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336711514E3;
	Fri, 28 Jun 2024 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdiRyi94"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8259136671
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611798; cv=none; b=ixEZFq/8+DgRfxbhjB63GWGIP+e+qfWhm0n8BC+Gu9auemyL/eqGuqWOoUDeLf4SRyJSgk4loUvm5NmT3MwChY2vip5oE7FM1iPh4VH7MMUW7pF2N5JvO9m/qA2h01KXEOdtq/bHb0heIlaP63ggDExnXm/SeYe1k1L6iub/E2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611798; c=relaxed/simple;
	bh=XHqnON1ZlIgjEQVtBP33bJ1OgEYv4ca7K5/9djHRK90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGaIHql5L3VteS7Do1IJ5u3efuiueSb1GOKbKFisinf5m0PfeRH9+rx0hbLt4PDwnah02LEJcaV+mbxrtYSiTAIBBgM1/VZOY2nImKUCC5uj5Za0pdP3dSLNHb/xl0k90ENiyGwvrG+Gp2X51qGX3RP0UoatWeXQUCFfKaLBA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdiRyi94; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611797; x=1751147797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHqnON1ZlIgjEQVtBP33bJ1OgEYv4ca7K5/9djHRK90=;
  b=NdiRyi94pb2j5Wo/azb5QPEIB6dLU7hQUqWutIvqtWN/PKHsWasEr0EB
   1JRpwWCaCgkewhT7gDLtsgD5ycBDD525fyBE1ppJ3GGP6U0fCSLQbxno5
   lGlQdr7DZc3sFrlWOIbdPMw2AnyydKWNxDkhXibffWfUNqgGFscrE7bKQ
   QYB3gBhPQMUEYPSdL7s1r3LGess/aETzfF/aHw3mWcQfCDeUriHMed9Pb
   kazjlLUF4esPjrwiQjYui8gjUievhQEMZXUOT4KJ5IbZC5+9ZqL/CE3PU
   EoJVC7jgSHjY18xH+h6F/e60YLl1YCdpwEhpBrqO2QrgP/efTpnuv7g1n
   Q==;
X-CSE-ConnectionGUID: K1A67yENQ6e2X1BD0u4CfA==
X-CSE-MsgGUID: kEnvpXUITKO45zJnYYhwzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762628"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762628"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:28 -0700
X-CSE-ConnectionGUID: 5gj9MZB9QeC6jfoUWpTfSQ==
X-CSE-MsgGUID: jn2ymCsXScujguKHnJ4VYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065678"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:27 -0700
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
Subject: [PATCH v23 15/19] x86/resctrl: Fill out rmid_read structure for smp_call*() to read a counter
Date: Fri, 28 Jun 2024 14:56:15 -0700
Message-ID: <20240628215619.76401-16-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628215619.76401-1-tony.luck@intel.com>
References: <20240628215619.76401-1-tony.luck@intel.com>
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

With Sub-NUMA Cluster (SNC) mode there are now two cases to handle:

1) Reading a file that returns a value for a single domain.
   + Choose the CPU to execute from the domain cpu_mask

2) Reading a file that must sum across domains sharing an L3 cache
   instance.
   + Indicate to called code that a sum is needed by passing a NULL
     rdt_mon_domain pointer.
   + Choose the CPU from the L3 shared_cpu_map.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 ++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 13d862221f9c..16982d1baf99 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -632,7 +632,7 @@ void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
-		    int evtid, int first);
+		    cpumask_t *cpumask, int evtid, int first);
 void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 4d76ff31a9e0..50fa1fe9a073 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -515,7 +515,7 @@ static int smp_mon_event_count(void *arg)
 
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
-		    int evtid, int first)
+		    cpumask_t *cpumask, int evtid, int first)
 {
 	int cpu;
 
@@ -536,7 +536,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		return;
 	}
 
-	cpu = cpumask_any_housekeeping(&d->hdr.cpu_mask, RESCTRL_PICK_ANY_CPU);
+	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
 
 	/*
 	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
@@ -545,7 +545,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	 * counters on some platforms if its called in IRQ context.
 	 */
 	if (tick_nohz_full_cpu(cpu))
-		smp_call_function_any(&d->hdr.cpu_mask, mon_event_count, rr, 1);
+		smp_call_function_any(cpumask, mon_event_count, rr, 1);
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
 
@@ -574,16 +574,40 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	resid = md.u.rid;
 	domid = md.u.domid;
 	evtid = md.u.evtid;
-
 	r = &rdt_resources_all[resid].r_resctrl;
-	hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
-	if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
+
+	if (md.u.sum) {
+		/*
+		 * This file requires summing across all domains that share
+		 * the L3 cache id that was provided in the "domid" field of the
+		 * mon_data_bits union. Search all domains in the resource for
+		 * one that matches this cache id.
+		 */
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			if (d->ci->id == domid) {
+				rr.ci = d->ci;
+				mon_event_read(&rr, r, NULL, rdtgrp,
+					       &d->ci->shared_cpu_map, evtid, false);
+				goto checkresult;
+			}
+		}
 		ret = -ENOENT;
 		goto out;
+	} else {
+		/*
+		 * This file provides data from a single domain. Search
+		 * the resource to find the domain with "domid".
+		 */
+		hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
+		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
+			ret = -ENOENT;
+			goto out;
+		}
+		d = container_of(hdr, struct rdt_mon_domain, hdr);
+		mon_event_read(&rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
 	}
-	d = container_of(hdr, struct rdt_mon_domain, hdr);
 
-	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
+checkresult:
 
 	if (rr.err == -EIO)
 		seq_puts(m, "Error\n");
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 67a8188c6d8f..cd0229f7c30e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3073,7 +3073,7 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 			return ret;
 
 		if (!do_sum && is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
+			mon_event_read(&rr, r, d, prgrp, &d->hdr.cpu_mask, mevt->evtid, true);
 	}
 
 	return 0;
-- 
2.45.2


