Return-Path: <linux-kernel+bounces-215084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20979908E20
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1EFB29F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E071A2547;
	Fri, 14 Jun 2024 15:02:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DAD1A0AFF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377327; cv=none; b=cVwyNwq5cQge3Fttq3Na3H4dFGcVYjh6qisLMfcLz6W5BkNTMoMc0bUCVpkjrWvq91xjaWEy48UG0xmk1NR0bb42j9FS0APvjWM0f7JX76Ujhg29y2+dVWgai5VAzckHEYO94j6aJqyQMbBLasvkDt9ZsuF80YAw1e59yFHdLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377327; c=relaxed/simple;
	bh=BiKZ3Yg2ou3GMUcLcOoDbajbNdClONDCeK7On16AeL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgTFGIcL8Mt67ELV5YGSWWuM09sx9fVh9CBlrmSjIrRMQtad4wzgiK6uttCca/mPA2EjYsjJv/gMUVoKfgCuWZZUbqdLvytZEw4LV3HTAC6FFrvsVPvV9y8taA9c1z69+tMuUpckrvDyyOMFvePd7l/WQBUfCnjfGqu0lQv8qIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4810419F0;
	Fri, 14 Jun 2024 08:02:30 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 783DE3F5A1;
	Fri, 14 Jun 2024 08:02:02 -0700 (PDT)
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
	Dave Martin <Dave.Martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v3 17/38] x86/resctrl: Stop using the for_each_*_rdt_resource() walkers
Date: Fri, 14 Jun 2024 15:00:12 +0000
Message-Id: <20240614150033.10454-18-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240614150033.10454-1-james.morse@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The for_each_*_rdt_resource() helpers walk the architecture's array
of structures, using the resctrl visible part as an iterator. These
became over-complex when the structures were split into a
filesystem and architecture-specific struct. This approach avoided
the need to touch every call site.

Once the filesystem parts of resctrl are moved to /fs/, both the
architecture's resource array, and the definition of those structures
is no longer accessible. To support resctrl, each architecture would
have to provide equally complex macros.

Change the resctrl code that uses these to walk through the resource_level
enum and check the mon/alloc capable flags instead. Instances in core.c,
and resctrl_arch_reset_resources() remain part of x86's architecture
specific code.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v1:
 * [Whitespace only] Fix bogus whitespace introduced in
   rdtgroup_create_info_dir().

 * [Commit message only] Typo fix:
   s/architectures/architecture's/g
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  7 +++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 28 +++++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index aacf236dfe3b..ad20822bb64e 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -840,6 +840,7 @@ bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm
 bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 {
 	cpumask_var_t cpu_with_psl;
+	enum resctrl_res_level i;
 	struct rdt_resource *r;
 	struct rdt_domain *d_i;
 	bool ret = false;
@@ -854,7 +855,11 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	 * First determine which cpus have pseudo-locked regions
 	 * associated with them.
 	 */
-	for_each_alloc_capable_rdt_resource(r) {
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		r = resctrl_arch_get_resource(i);
+		if (!r->alloc_capable)
+			continue;
+
 		list_for_each_entry(d_i, &r->domains, list) {
 			if (d_i->plr)
 				cpumask_or(cpu_with_psl, cpu_with_psl,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9c03e973a5f6..d9513d7b5157 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -98,12 +98,17 @@ void rdt_last_cmd_printf(const char *fmt, ...)
 
 void rdt_staged_configs_clear(void)
 {
+	enum resctrl_res_level i;
 	struct rdt_resource *r;
 	struct rdt_domain *dom;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	for_each_alloc_capable_rdt_resource(r) {
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		r = resctrl_arch_get_resource(i);
+		if (!r->alloc_capable)
+			continue;
+
 		list_for_each_entry(dom, &r->domains, list)
 			memset(dom->staged_config, 0, sizeof(dom->staged_config));
 	}
@@ -2192,6 +2197,7 @@ static u32 fflags_from_resource(struct rdt_resource *r)
 
 static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 {
+	enum resctrl_res_level i;
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	unsigned long fflags;
@@ -2216,7 +2222,11 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 			goto out_destroy;
 	}
 
-	for_each_mon_capable_rdt_resource(r) {
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		r = resctrl_arch_get_resource(i);
+		if (!r->mon_capable)
+			continue;
+
 		fflags =  fflags_from_resource(r) | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
@@ -2637,10 +2647,15 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 
 static int schemata_list_create(void)
 {
+	enum resctrl_res_level i;
 	struct rdt_resource *r;
 	int ret = 0;
 
-	for_each_alloc_capable_rdt_resource(r) {
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		r = resctrl_arch_get_resource(i);
+		if (!r->alloc_capable)
+			continue;
+
 		if (resctrl_arch_get_cdp_enabled(r->rid)) {
 			ret = schemata_list_add(r, CDP_CODE);
 			if (ret)
@@ -3181,6 +3196,7 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **dest_kn)
 {
+	enum resctrl_res_level i;
 	struct rdt_resource *r;
 	struct kernfs_node *kn;
 	int ret;
@@ -3199,7 +3215,11 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 	 * Create the subdirectories for each domain. Note that all events
 	 * in a domain like L3 are grouped into a resource whose domain is L3
 	 */
-	for_each_mon_capable_rdt_resource(r) {
+	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
+		r = resctrl_arch_get_resource(i);
+		if (!r->mon_capable)
+			continue;
+
 		ret = mkdir_mondata_subdir_alldom(kn, r, prgrp);
 		if (ret)
 			goto out_destroy;
-- 
2.39.2


