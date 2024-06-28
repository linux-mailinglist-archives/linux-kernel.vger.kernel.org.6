Return-Path: <linux-kernel+bounces-234620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C191C8AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B54F282CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02E13774A;
	Fri, 28 Jun 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAtIGtos"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F7839EB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611796; cv=none; b=IcGgIr4Y4VljLfHVu/DS/JMXus6H8raIY8El1X4EbLpsgs/RigahRbj5g3RNW6mVZdIJcISvo09X1VlCgFrnX5qqDGYOOXC4JMN8OxWW3EfhRnxB3gIo6xxFtPtE8zY+9u17CaT1xlZrUB66+q0igdCuDOISXJtmoQtC6mgGE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611796; c=relaxed/simple;
	bh=7UpWt0Wp9+zR/Uq/c6LkPQAMz/OkGruwVpBwVVZoADg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mH+GGH6Yz2/X9ndljsYQrCxNjQg9eC5kWW1Co9vFBCq0wb1FhnCMuKTTbaeZhpjoiMa60QxKtKet4k03tON3/++4kaM8tyewhRR/Fdl01SwCMpmmsVCgbwfjm4Ff34lNh30Ij9dLcjW8Z7D3BSX+AgBRJadomllzfGavK/9FPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAtIGtos; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611794; x=1751147794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7UpWt0Wp9+zR/Uq/c6LkPQAMz/OkGruwVpBwVVZoADg=;
  b=DAtIGtosxsTeaQunro5FD+CPt//iJqXhU4m9M2t9zP6/kCbcO8pX5EPn
   3v1LcCucHb7Oy5hPfjU1aTptcMa7ZOaRhBlO1o3uqsHyONI/k66D3O/oP
   vqQgg2azZwGUxTUYhAXGPD/MqupHEqzvKubOoT86Exwkc5r5ufxXFjVRG
   KLbmFLUEFadpNgEmESd0qCxCsK5gc0NZDAF17k8onxPygRMVg/s8VvhBi
   JUVmwPUvn6VDoGJ8GDz4SyYQWZ6IRvgoC951XDX0qcEaGAmcBMOF0lDFZ
   MVpHFpycf3B4iRCwHy0Mm8x9iEgmo96qmMmpNoczeTDBoFaPQnP5qM08j
   w==;
X-CSE-ConnectionGUID: 5qXAUNzLSf2ly8OiD6TKTw==
X-CSE-MsgGUID: PAWa/jz0RZSFAeud6HZ7YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762591"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762591"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:28 -0700
X-CSE-ConnectionGUID: TsChAdLqQqu3dCT6nCbR1A==
X-CSE-MsgGUID: phvLMc5gRxOQ/3Caw9K07A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065663"
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
Subject: [PATCH v23 10/19] x86/resctrl: Initialize on-stack struct rmid_read instances
Date: Fri, 28 Jun 2024 14:56:10 -0700
Message-ID: <20240628215619.76401-11-tony.luck@intel.com>
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

New semantics rely on some struct rmid_read members having NULL values
to distinguish between the SNC and non-SNC scenarios.  resctrl can thus
no longer rely on this struct not being initialized properly.

Initialize all on-stack declarations of struct rmid_read:
	rdtgroup_mondata_show()
	mbm_update()
	mkdir_mondata_subdir()
to ensure that garbage values from the stack are not passed down
to other functions.

Remove redundant rr->val = 0; from mon_event_read() and rr.first = false;
from mbm_update() since the rmid_read structure is cleared by compiler.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 3 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     | 3 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 3b9383612c35..4d76ff31a9e0 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -529,7 +529,6 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->evtid = evtid;
 	rr->r = r;
 	rr->d = d;
-	rr->val = 0;
 	rr->first = first;
 	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
 	if (IS_ERR(rr->arch_mon_ctx)) {
@@ -557,12 +556,12 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
 	struct rdt_domain_hdr *hdr;
+	struct rmid_read rr = {0};
 	struct rdt_mon_domain *d;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	union mon_data_bits md;
-	struct rmid_read rr;
 	int ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ff4e74594a19..ca309c93a56b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -780,9 +780,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
 		       u32 closid, u32 rmid)
 {
-	struct rmid_read rr;
+	struct rmid_read rr = {0};
 
-	rr.first = false;
 	rr.r = r;
 	rr.d = d;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 70d41a8fd788..d0443589cd86 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3029,10 +3029,10 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 				struct rdt_mon_domain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
+	struct rmid_read rr = {0};
 	union mon_data_bits priv;
 	struct kernfs_node *kn;
 	struct mon_evt *mevt;
-	struct rmid_read rr;
 	char name[32];
 	int ret;
 
-- 
2.45.2


