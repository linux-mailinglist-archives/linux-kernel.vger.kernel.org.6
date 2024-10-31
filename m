Return-Path: <linux-kernel+bounces-391378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A709B85D8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAD72828AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCA01CCB39;
	Thu, 31 Oct 2024 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uyehrfii"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383591BF311
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412147; cv=none; b=GN/5uRZOyQLWWP+BZqZDfAVa7wNr5IBwMIXbu7UFktbVyLgWIb1b6wlpGB1IMKKuMNvLrt+oMCp3eO9wRuCQxGK4MYXZkplOW2ECuqngdyNKuaOl3lC4O2U/d1xeW+fUiVSMp/XcnyJOfgglsbZ7qjtB3YHUuqzXk9p1OBwSbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412147; c=relaxed/simple;
	bh=wKHGL9ol3sggkcvmr76jmTSZINBJcqkSaYiCI+6qWmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Moaait4Yo8F6qSsVgL+ZZsy2k0Ki38v2pNSifVHUHNNqDXduvKcYqs+UZxL3X0SxC9YZ7KmY9kCNULSBleEZRSu54pwyHvwEdbUoKsNjg4Up2T8yytjDd5+6jUcHN6djkcfUp3YG/MBT+ihLXP0fM+d09kriynHDRxvfnM+QUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uyehrfii; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730412141; x=1761948141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wKHGL9ol3sggkcvmr76jmTSZINBJcqkSaYiCI+6qWmc=;
  b=UyehrfiiKEr5HJYE4Syd62zpk5NHUGEdcQeOQmIItUDXttnW/hq8M7yN
   z3zqdNevdaqNYd7IbMZvgzJmK2EcLmzkJHMzrOU2z2Nn+hzVNC02QWOBh
   y61A9FIdjz7hf4gvrtmDaAEBf3LHuYIOu6Mdy2KVyWiG2utbvuQTvUMIr
   N0/BX3OXnPG+xNIT0sH82BnBSOj/MhXcgvWqp8iHGa+Dj4nnbY0zGxaE3
   9Ey2fDZu19VqshLFaey+oHN6YumJ8NsDQ9mrGDBTK/axeREpnfLHoPXnk
   kNuYoKBU3m2t0XEHNTfEYuT32r/5A6IYEJ3z44h4XgSBcqn5xIPRUCZj8
   g==;
X-CSE-ConnectionGUID: ot2dHXHmTR280K5+PGC4sA==
X-CSE-MsgGUID: abAQF0wjSsGVamZgHR1Mcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="29596061"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="29596061"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 15:02:20 -0700
X-CSE-ConnectionGUID: 9Dcpi6uWTpWCVr0M3Lk0Qg==
X-CSE-MsgGUID: nkrx03vuRMyEaHMk7clw2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113554433"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 15:02:20 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/resctrl: Support Sub-NUMA cluster mode SNC6
Date: Thu, 31 Oct 2024 15:02:13 -0700
Message-ID: <20241031220213.17991-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support Sub-NUMA cluster mode with 6 nodes per L3 cache (SNC6) on some
Intel platforms.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 851b561850e0..5fcb3d635d91 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1158,11 +1158,12 @@ static __init int snc_get_config(void)
 
 	ret = cpus_per_l3 / cpus_per_node;
 
-	/* sanity check: Only valid results are 1, 2, 3, 4 */
+	/* sanity check: Only valid results are 1, 2, 3, 4, 6 */
 	switch (ret) {
 	case 1:
 		break;
 	case 2 ... 4:
+	case 6:
 		pr_info("Sub-NUMA Cluster mode detected with %d nodes per L3 cache\n", ret);
 		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_L3_NODE;
 		break;
-- 
2.47.0


