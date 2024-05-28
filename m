Return-Path: <linux-kernel+bounces-193171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FAC8D27ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1D5B22553
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820E914533F;
	Tue, 28 May 2024 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H18qe2s+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28A143754
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934829; cv=none; b=kZgHZCjScjXQACNJn93LWBgTi/3RgSiQY9LR8Mxqv99h4K3fezOQIIHoU7WgaREwxVd33ztR5EN0axyLD3rQM/l5EboWjlOGM5tPDs503KcUxnk5DXa0pJ7viShpRDpQ/QMWOqn3ibsUkzWJ0JKc6eCNpAuUmXgG3ZDVEuxH4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934829; c=relaxed/simple;
	bh=ae2net2an2bG2zA//O2uZIIe0Gsj90vooANwSwQeDp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDi0n18UOOQKwpMqXKBE5vISY+hPLL21x0sXAgRawiMRfwyHeEfAaPnBScfjOCXrbUotHR43UHryQmyA6S1AmNAkE1qGjtHi52aTua8MsEwJwGjKvMMogz1sVG2/s5sz089jpoXhtgCjGRkkzNE8y8hBZ35PRNpyeNzWXMPQCgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H18qe2s+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716934828; x=1748470828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ae2net2an2bG2zA//O2uZIIe0Gsj90vooANwSwQeDp0=;
  b=H18qe2s+HPeMwv+pu72wa/kVE0f8qaoTG/uiH2p3ub26RW2r6ptvbZXz
   9SfJYIfipC8Uc82sE8pCw9GtmYWml15MmAzxi159utnBV4aS0QjFxEkLg
   PK/NFbE3Z6y4fAMKPzHdM5PM6GkR4ovhG8gU/p7jxymwPofm4aHG5sO87
   Ww/RjSHimQ987l7S56Q8rBt0hTd27X5ShaekQoYXHRGxNMRV5QSdLF0Oh
   mtnKCKm4qXg2y9vPrm5rI6O4xd8osYcuO23w/IfeCBIJ7RcYqZ8pAZ1ak
   /H+Tbx3b5sq4ilp3ox+DwL+HwQv+lR1WYhgVaDIpXJuTpPsL2qjbnjiIj
   w==;
X-CSE-ConnectionGUID: 5tn2roWBTmWGmtMGa7RMUw==
X-CSE-MsgGUID: 6IaNmqx3Tp+svNdFesGIJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30812254"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30812254"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:20 -0700
X-CSE-ConnectionGUID: QD3PTiOTSc2KlcgwAcUijA==
X-CSE-MsgGUID: 7T08vKT8SCKRDTa9rx+H2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40090773"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:19 -0700
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
Subject: [PATCH v19 17/20] x86/resctrl: Update CPU sanity checks when reading RMID counters
Date: Tue, 28 May 2024 15:20:02 -0700
Message-ID: <20240528222006.58283-18-tony.luck@intel.com>
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

When reading from a single domain the existing check that current CPU is
in the domain is accurate.

But when summing across multiple domains that share an L3 cache instance
it is sufficient to run on any CPU in the shared_map for that cache.

Split the check into the two separate cases.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c9dd6ec68fcd..e7a8e96821e5 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -308,9 +308,6 @@ static int resctrl_arch_rmid_read_one(struct rdt_resource *r, struct rdt_mon_dom
 
 	resctrl_arch_rmid_read_context_check();
 
-	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
-		return -EINVAL;
-
 	ret = __rmid_read(cpu, rmid, eventid, &msr_val);
 	if (ret)
 		return ret;
@@ -338,8 +335,15 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 	int ret;
 
 	*val = 0;
-	if (!sum)
+	if (!sum) {
+		if (!cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
+			return -EINVAL;
+
 		return resctrl_arch_rmid_read_one(r, d, cpu, rmid, eventid, val);
+	}
+
+	if (!cpumask_test_cpu(cpu, &ci->shared_cpu_map))
+		return -EINVAL;
 
 	list_for_each_entry(d, &r->mon_domains, hdr.list) {
 		if (d->ci->id != ci->id)
-- 
2.45.0


