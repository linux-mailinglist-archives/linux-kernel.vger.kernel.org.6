Return-Path: <linux-kernel+bounces-272931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677994628E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B138E28A2D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D91A34CD;
	Fri,  2 Aug 2024 17:31:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F8C1A83A2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619908; cv=none; b=aUdeJxFFEDF7UJonpI2artogMzgplX1+WlpPMPG15Hnozt9X3etgzf5aKqpXiOsBSfPfaLlTRAXomW6d+UcLnViZg6mP+rYyEpIzRmH6crex/x465k5kgDka3ToyWvhuywPyrltonjOPYuKiNTknKaQk3DP2dinn79pVr4NoLnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619908; c=relaxed/simple;
	bh=Qgda4E/lBFocazHoxUYicPK9yE7WjHs9NotHdUgAWxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XWAYiRR5NQZ61K7ZTRAdO5cVdni72vG8fYUHrJoVREexFaEldAYWaHRNQqlrXkzQKv5W9XKph+ymYqYFXdAp3SydvgcIXIeiR9mLA5G0HJwQuOYdp+3/p2IWKqpIkwbU+izpBoULtsJKwjG09BU3PK7hD9GVl3H4Di1upl0YPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E56811684;
	Fri,  2 Aug 2024 10:32:11 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 468E43F64C;
	Fri,  2 Aug 2024 10:31:43 -0700 (PDT)
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
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v4 32/39] x86/resctrl: Drop __init/__exit on assorted symbols
Date: Fri,  2 Aug 2024 17:28:46 +0000
Message-Id: <20240802172853.22529-33-james.morse@arm.com>
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

Because ARM's MPAM controls are probed using MMIO, resctrl can't be
initialised until enough CPUs are online to have determined the
system-wide supported num_closid. Arm64 also supports 'late onlined
secondaries', where only a subset of CPUs are online during boot.

These two combine to mean the MPAM driver may not be able to initialise
resctrl until user-space has brought 'enough' CPUs online.

To allow MPAM to initialise resctrl after __init text has been free'd,
remove all the __init markings from resctrl.

The existing __exit markings cause these functions to be removed by the
linker as it has never been possible to build resctrl as a module. MPAM
has an error interrupt which causes the driver to reset and disable
itself. Remove the __exit markings to allow the MPAM driver to tear down
resctrl when an error occurs.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++----
 include/linux/resctrl.h                | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f5801048404d..c8086095954b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -480,7 +480,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first);
-int __init resctrl_mon_resource_init(void);
+int resctrl_mon_resource_init(void);
 void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 39c450624ed0..1fd47f8a0e18 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1191,7 +1191,7 @@ static __init int snc_get_config(void)
  *
  * Returns 0 for success, or -ENOMEM.
  */
-int __init resctrl_mon_resource_init(void)
+int resctrl_mon_resource_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	int ret;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 19f852bbc8b0..db5c18caa40e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2048,7 +2048,7 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
-static void __init thread_throttle_mode_init(void)
+static void thread_throttle_mode_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 	struct rftype *rft;
@@ -4052,7 +4052,7 @@ static void rdtgroup_destroy_root(void)
 	rdtgroup_default.kn = NULL;
 }
 
-static void __init rdtgroup_setup_default(void)
+static void rdtgroup_setup_default(void)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -4268,7 +4268,7 @@ void resctrl_offline_cpu(unsigned int cpu)
  *
  * Return: 0 on success or -errno
  */
-int __init resctrl_init(void)
+int resctrl_init(void)
 {
 	int ret = 0;
 
@@ -4325,7 +4325,7 @@ int __init resctrl_init(void)
 	return ret;
 }
 
-void __exit resctrl_exit(void)
+void resctrl_exit(void)
 {
 	rdtgroup_destroy_root();
 	debugfs_remove_recursive(debugfs_resctrl);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 1ebf705ec3c5..c97ae81a57af 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -541,7 +541,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-int __init resctrl_init(void);
-void __exit resctrl_exit(void);
+int resctrl_init(void);
+void resctrl_exit(void);
 
 #endif /* _RESCTRL_H */
-- 
2.39.2


