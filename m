Return-Path: <linux-kernel+bounces-257276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C49377BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E319B1F22747
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9B1339B1;
	Fri, 19 Jul 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NupWd8eo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7F5F876;
	Fri, 19 Jul 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721392073; cv=none; b=A9qNhE5iOaku568a5JygnydSB/jVWOT7Ww8xkdZerBG5lmqTyloSsq/R9xI3IDz/CIy+uyp7rex4GlKyNH0Jszq/yx/hWLGFGi6qQ2/LNZY9FgbVYHe24t0NPN5oF6wwd5WrlswLSAuoiNfoZs78LkaFkWmFdXLm4/B2pN+8g7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721392073; c=relaxed/simple;
	bh=mwqPKZVN/GAHYJhSrkcOfprKnitWhdw76fnKlbvm3ow=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=E4snTaU9+YFsHWCbLg+Y5lOgbmlz0bB6IDhqTrWfE9mJOA28ygkwcR1lcR2w79c6ddVbIn1jYbfE0wgAlipTAYbn3cQK97gX77W6je1wNosrmpUcpf4K+dJ/uBKiJDAwFL5XdBgnraFXtTQvb0+dzAaALrreI7FHutxU12gHfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NupWd8eo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721392072; x=1752928072;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mwqPKZVN/GAHYJhSrkcOfprKnitWhdw76fnKlbvm3ow=;
  b=NupWd8eo50EcJ/RG1EIn/lptQ0vAabktUVrQzH5nI6f6zSqJKMeso5cN
   gMNOsTx/ptG7/PQRO/Oo+dOiDATlqfZeI7/eWbkPuj1xa/DPmNkTZAxbC
   4T1j3ZuZLoXeMPq/jih2MNgGCKAS4wj/EJFbRbvt0p6KXf+dNpc6inb+B
   81TrO6CWhCetNTqfoNW+1JibY3QNd4uJTWmiScP2zst5/UR3+kO/L8Mt3
   5N7qZA1dnT5mSCOpNzc7Q7a8YcMmFquaUT+8ZlvF4yBy2MJT0xb/N/0tD
   2q+OtrNMrc0VGCtoC3nr3OKCpWoJbJHNKUahoERAKDrvpSzjgRmvC8hAR
   Q==;
X-CSE-ConnectionGUID: MxCQgFAwSOSXRAUHYh6//A==
X-CSE-MsgGUID: YmBE9xEwT86QB39sP36KAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="41524364"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="41524364"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 05:27:51 -0700
X-CSE-ConnectionGUID: GEn9wxRGRm2VrVs86mk26w==
X-CSE-MsgGUID: 9HRGTw8eRHKg69qjeGjCKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="50789648"
Received: from kkgame1-x299-aorus-gaming-3-pro.itwn.intel.com ([10.225.75.93])
  by fmviesa006.fm.intel.com with ESMTP; 19 Jul 2024 05:27:49 -0700
From: Kane Chen <kane.chen@intel.com>
To: kane.chen@intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH 1/1] platform/x86/intel/pmc: Show live substate requirements
Date: Fri, 19 Jul 2024 20:28:07 +0800
Message-Id: <20240719122807.3853292-1-kane.chen@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While debugging runtime s0ix, we do need to check which required IPs
are not power gated. This patch adds code to show live substate status
vs requirements in sys/kernel/debug/pmc_core/substate_requirements to
help runtime s0ix debug.

Signed-off-by: Kane Chen <kane.chen@intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 2ad2f8753e5d4..b93ecc5169745 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -791,13 +791,15 @@ static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
 	pmc_for_each_mode(i, mode, pmcdev)
 		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
 
-	seq_printf(s, " %9s |\n", "Status");
+	seq_printf(s, " %9s |", "Status");
+	seq_printf(s, " %11s |\n", "Live Status");
 }
 
 static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
 	u32 sts_offset;
+	u32 sts_offset_live;
 	u32 *lpm_req_regs;
 	int num_maps, mp, pmc_index;
 
@@ -811,6 +813,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 		maps = pmc->map->lpm_sts;
 		num_maps = pmc->map->lpm_num_maps;
 		sts_offset = pmc->map->lpm_status_offset;
+		sts_offset_live = pmc->map->lpm_live_status_offset;
 		lpm_req_regs = pmc->lpm_req_regs;
 
 		/*
@@ -828,6 +831,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 		for (mp = 0; mp < num_maps; mp++) {
 			u32 req_mask = 0;
 			u32 lpm_status;
+			u32 lpm_status_live;
 			const struct pmc_bit_map *map;
 			int mode, idx, i, len = 32;
 
@@ -842,6 +846,9 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 			/* Get the last latched status for this map */
 			lpm_status = pmc_core_reg_read(pmc, sts_offset + (mp * 4));
 
+			/* Get the runtime status for this map */
+			lpm_status_live = pmc_core_reg_read(pmc, sts_offset_live + (mp * 4));
+
 			/*  Loop over elements in this map */
 			map = maps[mp];
 			for (i = 0; map[i].name && i < len; i++) {
@@ -868,6 +875,9 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 				/* In Status column, show the last captured state of this agent */
 				seq_printf(s, " %9s |", lpm_status & bit_mask ? "Yes" : " ");
 
+				/* In Live status column, show the live state of this agent */
+				seq_printf(s, " %11s |", lpm_status_live & bit_mask ? "Yes" : " ");
+
 				seq_puts(s, "\n");
 			}
 		}
-- 
2.34.1


