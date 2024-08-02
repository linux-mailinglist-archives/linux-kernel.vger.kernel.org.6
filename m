Return-Path: <linux-kernel+bounces-272913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3397E94627B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D811C226D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB211E484B;
	Fri,  2 Aug 2024 17:30:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825F4166F37
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619846; cv=none; b=E1ecY99LJgGscDW0DVS2y8rW/ohsWX+T9SYFscPmt/7sQDdB4lz3KCQlH5/GE0Qqw1R57MTr9a8Xtb1W5u44nu/4sw278Lh3OvCZH90pp2S+ReFXWzMlEBvh59KaVLJtAk+1iwCcnVVixpaOG+WKHK7sVRC53k6uaE0I3hzhJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619846; c=relaxed/simple;
	bh=tR2ALyN69ZIRyWUcjAeFbfgihCCJdALqmcjq4F+oDEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HB9MXnirMMlDY9cDIZK8fmYnXkcEnM4PuPWbgIEW4z3/+Xw4Xll8ejw5ffK3N5vMwO6pdk30UpZccyh2syH8MyGUDfOW8cvsoQ4R45IFkhsP/lHi4kGDM/7dy7lw3g0Neq1imocvNGMoZyb3EtCGH7APag39M0WchvO96cEDZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C05E91042;
	Fri,  2 Aug 2024 10:31:10 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 524C83F64C;
	Fri,  2 Aug 2024 10:30:40 -0700 (PDT)
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
	Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v4 14/39] x86/resctrl: Add a resctrl helper to reset all the resources
Date: Fri,  2 Aug 2024 17:28:28 +0000
Message-Id: <20240802172853.22529-15-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240802172853.22529-1-james.morse@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
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

Add an architecture helper to reset all resources.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64

---
Changes since v1:
 * Rename the for_each_capable_rdt_resource() introduced in the new
   function resctrl_arch_reset_resources(), back to
   for_each_alloc_capable_rdt_resource() as it was in the original code.

   The change looked unintentional; and presumably a resource that does
   not support resource allocation doesn't have any properties to
   reset...
---
 arch/x86/include/asm/resctrl.h         |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 3b225040f617..e7af45aaeabb 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -16,6 +16,8 @@
  */
 #define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
 
+void resctrl_arch_reset_resources(void);
+
 /**
  * struct resctrl_pqr_state - State cache for the PQR MSR
  * @cur_rmid:		The cached Resource Monitoring ID
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index adc86568f72b..1597add37b97 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2891,6 +2891,14 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	return 0;
 }
 
+void resctrl_arch_reset_resources(void)
+{
+	struct rdt_resource *r;
+
+	for_each_alloc_capable_rdt_resource(r)
+		reset_all_ctrls(r);
+}
+
 /*
  * Move tasks from one to the other group. If @from is NULL, then all tasks
  * in the systems are moved unconditionally (used for teardown).
@@ -3000,16 +3008,14 @@ static void rmdir_all_sub(void)
 
 static void rdt_kill_sb(struct super_block *sb)
 {
-	struct rdt_resource *r;
-
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
 	rdt_disable_ctx();
 
-	/*Put everything back to default values. */
-	for_each_alloc_capable_rdt_resource(r)
-		reset_all_ctrls(r);
+	/* Put everything back to default values. */
+	resctrl_arch_reset_resources();
+
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
-- 
2.39.2


