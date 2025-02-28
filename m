Return-Path: <linux-kernel+bounces-539349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69521A4A35C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386743B212C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09672202978;
	Fri, 28 Feb 2025 20:00:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4BA202966
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772851; cv=none; b=Y4FndcijHwM24NNrD+qEakQ8bw6302MgnZgD/nBmMQCoIujHd7ujwgrxoT1x6pIeh0BO6iYRaQ2d1DcdotwYwWzJzlVm2d2fYAMxxOtq+TITojyukBFsSHZoYbQe3w5Ue9KT8CExICTu1RAtLe6hq9I4C5szLI9ybbIyfSYcnHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772851; c=relaxed/simple;
	bh=AJ97oBDT7dXeO2PZynWYfPTrR0LZA71TF74uVDQZ1Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kpbm8UuBU4OL+A8Ky4GhSpn1EeGfWvnbPvpEaf9YMD1ZInj5M+jicDe4B2D0QQ7Abck1kk3HNU7vRWU9wdv9j+q57BtHe0IvjAiSF5T2Yi0qbjwpkSk+uR6VvSELTFvOmkAZcM1kHsLKWUmAlioCrZc8KULrAzeSUcXL9QfzcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0F44176C;
	Fri, 28 Feb 2025 12:01:04 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BC933F5A1;
	Fri, 28 Feb 2025 12:00:46 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
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
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 14/49] x86/resctrl: Add an arch helper to reset one resource
Date: Fri, 28 Feb 2025 19:58:38 +0000
Message-Id: <20250228195913.24895-15-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
References: <20250228195913.24895-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On umount(), resctrl resets each resource back to its default
configuration. It only ever does this for all resources in one go.

reset_all_ctrls() is architecture specific as it works with struct
rdt_hw_resource.

Make reset_all_ctrls() an arch helper that resets one resource.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v5:
 * Move the arch/fs split into the for-each loop at Reinette's suggestion.
 * Dropped a bunch of tags and rewrote the commit message.

Changes since v1:
 * Rename the for_each_capable_rdt_resource() introduced in the new
   function resctrl_arch_reset_resources(), back to
   for_each_alloc_capable_rdt_resource() as it was in the original code.

   The change looked unintentional; and presumably a resource that does
   not support resource allocation doesn't have any properties to
   reset...
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 9 +++++----
 include/linux/resctrl.h                | 9 +++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b2dad689e780..9eb57ebb36c6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2867,7 +2867,7 @@ static int rdt_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static int reset_all_ctrls(struct rdt_resource *r)
+void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_ctrl_domain *hw_dom;
@@ -2896,7 +2896,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		smp_call_function_any(&d->hdr.cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	}
 
-	return 0;
+	return;
 }
 
 /*
@@ -3015,9 +3015,10 @@ static void rdt_kill_sb(struct super_block *sb)
 
 	rdt_disable_ctx();
 
-	/*Put everything back to default values. */
+	/* Put everything back to default values. */
 	for_each_alloc_capable_rdt_resource(r)
-		reset_all_ctrls(r);
+		resctrl_arch_reset_all_ctrls(r);
+
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 326f7ba220e7..487b9657a7b5 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -394,6 +394,15 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
  */
 void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
+/**
+ * resctrl_arch_reset_all_ctrls() - Reset the control for each CLOSID to its
+ *				    default.
+ * @r:		The resctrl resource to reset.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_reset_all_ctrls(struct rdt_resource *r);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.39.5


