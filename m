Return-Path: <linux-kernel+bounces-197411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2BB8D6A34
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3781C25C11
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7200117E458;
	Fri, 31 May 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJKlGeh2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80617CA09
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717185456; cv=none; b=CGEGqiJVyGcc7YFyIoX08SfaT3ltTZrt29RgD5QGkfSSqWSDHNdZ77rP9X2fJgCrnRELNsEW7VMR5U9GtGAD5dYTYSoAv2/Yf+m35Sy2F0uJ/Lqva31sK3ubsnaIpEpmhbA8r0svPG40MApa/aXtdJsW6iV5H4SA17T7wlWag6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717185456; c=relaxed/simple;
	bh=RsqO07LtaR/1pQ294RLwenEBg2L8jtETbGsARD5fAjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fl4tkIPqfLxwwesXQL4BErp29qriyskuCGPkirgTrZ8zaqQQ0Fb8NUyfzviBO85Wk7ryUcLH6wCazNZEycTdKdXOSBiol7KPken9pdXOHR3P1qSMJyFo0Vtx8n2aMYLa6+8PDPrXA4FhAGO0nESfA+JSD4+rlTr6lsNLP41+2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJKlGeh2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717185455; x=1748721455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RsqO07LtaR/1pQ294RLwenEBg2L8jtETbGsARD5fAjo=;
  b=ZJKlGeh21J6/yGuI58Pxh+Tkd7vnoEwCxXprd4CMeslZinmxkyo0uvH+
   pnaLPG8B9RWDq2y675QqDdieg96pW5qycCMLtrpSa8pgLaLm3CKc8eabY
   pu9NGTMGrjGkyWaRsHT5NIQB/N1q2k5lGfz1BBYg2UAklgkyJfzqK+Po5
   qGDn/Mjs1y8xaFAWku8f4AdckrUmXBdwZot4dV8TnLTO9cQmHc47+QLt1
   ba7yttIp1NKELUomcsMwhkV2fc0+PlinAfgoYrrbLq+Gb5FnJ02v7BzCU
   /rVYHdwub1qwyqfpJnZCuGIECqiRc6sQHlIkOyID8LX5IIRBuSDAs4isu
   Q==;
X-CSE-ConnectionGUID: XbLATo1ITHCowp7eofFzGQ==
X-CSE-MsgGUID: p+iOPmpsTCu1pIdV+TC4vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13501146"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13501146"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:57:33 -0700
X-CSE-ConnectionGUID: KoVO3zmHRBm5PSLOFDbLfA==
X-CSE-MsgGUID: /Lt1zt62TxGKKJVhQXyUeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="59438873"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:57:32 -0700
From: Tony Luck <tony.luck@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 2/3] x86/resctrl: Replace open code cacheinfo search in pseudo_lock_region_init()
Date: Fri, 31 May 2024 12:57:19 -0700
Message-ID: <20240531195720.232561-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240531195720.232561-1-tony.luck@intel.com>
References: <20240531195720.232561-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use get_cpu_cacheinfo_level() instead of open coded search.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index aacf236dfe3b..1bbfd3c1e300 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -292,9 +292,8 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
-	struct cpu_cacheinfo *ci;
+	struct cacheinfo *ci;
 	int ret;
-	int i;
 
 	/* Pick the first cpu we find that is associated with the cache. */
 	plr->cpu = cpumask_first(&plr->d->cpu_mask);
@@ -306,15 +305,11 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 		goto out_region;
 	}
 
-	ci = get_cpu_cacheinfo(plr->cpu);
-
-	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
-
-	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == plr->s->res->cache_level) {
-			plr->line_size = ci->info_list[i].coherency_line_size;
-			return 0;
-		}
+	ci = get_cpu_cacheinfo_level(plr->cpu, plr->s->res->cache_level);
+	if (ci) {
+		plr->line_size = ci->coherency_line_size;
+		plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
+		return 0;
 	}
 
 	ret = -1;
-- 
2.45.0


