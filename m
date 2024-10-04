Return-Path: <linux-kernel+bounces-350887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD010990AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F0FB240C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618CE21C19D;
	Fri,  4 Oct 2024 18:06:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C2421C18F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065193; cv=none; b=OeJAOKpTN2CbBgX2WxOoIvTig0+sFgxCIhW0g9VLrOEZbo30DoB497eQrY3Q86a4AOf8r1RRWBVZIblDhs1O695IVzhvmXqSSxzf0OgziC+LntEMmQNPxB9pr9SAi8+tC9iwOFIi7/wd4LqdVR0WG5yRR0KYzFv2NEQrL3uQgZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065193; c=relaxed/simple;
	bh=A2aXloBeu64up5hajxlivDli572v8uJNHc/wFfqyyWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sEd6IdN1UVWCJPzUkAz484QlKOOiPGaEZWiujJqk15b7z9UyTgnGeVnF0WVEOfX3NneA1iw3US7NfAYCelk7P2aAEAOPig0nlucwyYGQYFPe3AER6qnsIRk36rYXue+ToCn0nA/yxm3DisVLOdkBBLtcs3J2eR6y8sdg8uNwiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE93C150C;
	Fri,  4 Oct 2024 11:07:00 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18D9A3F58B;
	Fri,  4 Oct 2024 11:06:27 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v5 27/40] x86/resctrl: Move thread_throttle_mode_init() to be managed by resctrl
Date: Fri,  4 Oct 2024 18:03:34 +0000
Message-Id: <20241004180347.19985-28-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>
References: <20241004180347.19985-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

thread_throttle_mode_init() is called from the architecture specific code
to make the 'thread_throttle_mode' file visible. The architecture specific
code has already set the membw.throttle_mode in the rdt_resource.

This doesn't need to be specific to the architecture, the throttle_mode
can be used by resctrl to determine if the 'thread_throttle_mode' file
should be visible.

Call thread_throttle_mode_init() from resctrl_setup(), check the
membw.throttle_mode on the MBA resource. This avoids publishing an
extra function between the architecture and filesystem code.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 1 -
 arch/x86/kernel/cpu/resctrl/internal.h | 1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 9 ++++++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b5ad1ed2a4de..0da7314195af 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -228,7 +228,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
-	thread_throttle_mode_init();
 
 	r->alloc_capable = true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 9c08efb0e198..30de95e59129 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -495,7 +495,6 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_mon_domain *d);
 void __check_limbo(struct rdt_mon_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
-void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3f10e6897daa..596f5f087834 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2048,10 +2048,15 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
-void __init thread_throttle_mode_init(void)
+static void __init thread_throttle_mode_init(void)
 {
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 	struct rftype *rft;
 
+	if (!r->alloc_capable ||
+	    r->membw.throttle_mode == THREAD_THROTTLE_UNDEFINED)
+		return;
+
 	rft = rdtgroup_get_rftype_by_name("thread_throttle_mode");
 	if (!rft)
 		return;
@@ -4264,6 +4269,8 @@ int __init resctrl_init(void)
 
 	rdtgroup_setup_default();
 
+	thread_throttle_mode_init();
+
 	ret = resctrl_mon_resource_init();
 	if (ret)
 		return ret;
-- 
2.39.2


