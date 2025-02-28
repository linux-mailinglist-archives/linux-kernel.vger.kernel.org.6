Return-Path: <linux-kernel+bounces-539372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B259DA4A37D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6243BA516
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F2027D79F;
	Fri, 28 Feb 2025 20:02:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14B27D76F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772934; cv=none; b=atJMZJwi0JXdZCfoGuLQROkeVIOsuZYCSm7G3ih8CbrZFoPLP2MYdua2O/kNtZLOuMrUTON7jDkzD/N64AfKvYmpuOxUSaBKZy+h2E9gxGFIqqB9yb7opV8bFgSlZ7rAuu2qncVXYJNsWxBKhZo3r9+NQ4DFH0+LxNDqfMeGjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772934; c=relaxed/simple;
	bh=Bx6TP3tTUtjUVJQC83UApAnC+z26yoYEc/vUnMTjBo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZuwXPJuyq+QMjAqmiBsOIfMZ5Dv/AmysfiibCwioLwnaXhl8aoWuKbItXoRwyMYZP+gZehMrY2x6SVDPa0jaHkYfTX7P+ijBWvgovj210jruXnukKZrXucXS5iO48U/tjUMhGTR1vf2rCTb8IPRQM2YxqsYgaNKeKYS7M2HPu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 874B719F0;
	Fri, 28 Feb 2025 12:02:27 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D6D23F5A1;
	Fri, 28 Feb 2025 12:02:09 -0800 (PST)
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
	fenghuay@nvidia.com
Subject: [PATCH v7 37/49] x86/resctrl: Expand the width of dom_id by replacing mon_data_bits
Date: Fri, 28 Feb 2025 19:59:01 +0000
Message-Id: <20250228195913.24895-38-james.morse@arm.com>
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

MPAM platforms retrieve the cache-id property from the ACPI PPTT table.
The cache-id field is 32 bits wide. Under resctrl, the cache-id becomes
the domain-id, and is packed into the mon_data_bits union bitfield.
The width of cache-id in this field is 14 bits.

Expanding the union would break 32bit x86 platforms as this union is
stored as the kernfs kn->priv pointer. This saved allocating memory
for the priv data storage.

The firmware on MPAM platforms have used the PPTT cache-id field to
expose the interconnect's id for the cache, which is sparse and uses
more than 14 bits. Use of this id is to enable PCIe direct cache
injection hints. Using this feature with VFIO means the value provided
by the ACPI table should be exposed to user-space.

To support cache-id values greater than 14 bits, convert the
mon_data_bits union to a structure. This is allocated for the default
control group when the kernfs event files are created, and free'd when
the monitor directory is rmdir'd when the domain goes offline.
All other control and monitor groups lookup the struct mon_data allocated
for the default control group, and use this.
This simplifies the lifecycle of this structure as the default control
group cannot be rmdir()d by user-space, so only needs to consider
domain-offline, which removes all the event files corresponding to a
domain while holding rdtgroup_mutex - which prevents concurrent
readers. mkdir_mondata_subdir_allrdtgrp() must special case the default
control group to ensure it is created first.

Signed-off-by: James Morse <james.morse@arm.com>
---
Previously the MPAM tree repainted the cache-id to compact them,
argue-ing there was no other user. With VFIO use of this PCIe feature,
this is no longer an option.

Changes since v6:
 * Added the get/put helpers.
 * Special case the creation of the mondata files for the default control
   group.
 * Removed wording about files living longer than expected, the corresponding
   error handling is wrapped in WARN_ON_ONCE() as this indicates a bug.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  19 +--
 arch/x86/kernel/cpu/resctrl/internal.h    |  37 +++---
 arch/x86/kernel/cpu/resctrl/monitor.c     |   3 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 142 ++++++++++++++++++++--
 4 files changed, 162 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 0a0ac5f6112e..159972c3fe73 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -667,7 +667,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
-	union mon_data_bits md;
+	struct mon_data *md;
 	int ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
@@ -676,17 +676,22 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		goto out;
 	}
 
-	md.priv = of->kn->priv;
-	resid = md.u.rid;
-	domid = md.u.domid;
-	evtid = md.u.evtid;
+	md = of->kn->priv;
+	if (WARN_ON_ONCE(!md)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	resid = md->rid;
+	domid = md->domid;
+	evtid = md->evtid;
 	r = resctrl_arch_get_resource(resid);
 
-	if (md.u.sum) {
+	if (md->sum) {
 		/*
 		 * This file requires summing across all domains that share
 		 * the L3 cache id that was provided in the "domid" field of the
-		 * mon_data_bits union. Search all domains in the resource for
+		 * struct mon_data. Search all domains in the resource for
 		 * one that matches this cache id.
 		 */
 		list_for_each_entry(d, &r->mon_domains, hdr.list) {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 32ed9aeffb90..16c1a391d012 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -103,27 +103,24 @@ struct mon_evt {
 };
 
 /**
- * union mon_data_bits - Monitoring details for each event file.
- * @priv:              Used to store monitoring event data in @u
- *                     as kernfs private data.
- * @u.rid:             Resource id associated with the event file.
- * @u.evtid:           Event id associated with the event file.
- * @u.sum:             Set when event must be summed across multiple
- *                     domains.
- * @u.domid:           When @u.sum is zero this is the domain to which
- *                     the event file belongs. When @sum is one this
- *                     is the id of the L3 cache that all domains to be
- *                     summed share.
- * @u:                 Name of the bit fields struct.
+ * struct mon_data - Monitoring details for each event file.
+ * @rid:             Resource id associated with the event file.
+ * @evtid:           Event id associated with the event file.
+ * @sum:             Set when event must be summed across multiple
+ *                   domains.
+ * @domid:           When @sum is zero this is the domain to which
+ *                   the event file belongs. When @sum is one this
+ *                   is the id of the L3 cache that all domains to be
+ *                   summed share.
+ *
+ * Stored in the kernfs kn->priv field, readers and writers must hold
+ * rdtgroup_mutex.
  */
-union mon_data_bits {
-	void *priv;
-	struct {
-		unsigned int rid		: 10;
-		enum resctrl_event_id evtid	: 7;
-		unsigned int sum		: 1;
-		unsigned int domid		: 14;
-	} u;
+struct mon_data {
+	unsigned int rid;
+	enum resctrl_event_id evtid;
+	unsigned int sum;
+	unsigned int domid;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 73e3fe4f4c87..5bf67b429dd3 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1096,6 +1096,9 @@ static struct mon_evt mbm_local_event = {
  * Note that MBM events are also part of RDT_RESOURCE_L3 resource
  * because as per the SDM the total and local memory bandwidth
  * are enumerated as part of L3 monitoring.
+ *
+ * mon_put_default_kn_priv_all() also assumes monitor events are only supported
+ * on the L3 resource.
  */
 static void l3_mon_evt_init(struct rdt_resource *r)
 {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index aecd3fa734cd..443635d195f0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3114,6 +3114,110 @@ static struct file_system_type rdt_fs_type = {
 	.kill_sb		= rdt_kill_sb,
 };
 
+/**
+ * mon_get_default_kn_priv() - Get the mon_data priv data for this event from
+ *                             the default control group.
+ * Called when monitor event files are created for a domain.
+ * When called with the default control group, the structure will be allocated.
+ * This happens at mount time, before other control or monitor groups are
+ * created.
+ * This simplifies the lifetime management for rmdir() versus domain-offline
+ * as the default control group lives forever, and only one group needs to be
+ * special cased.
+ *
+ * @r:      The resource for the event type being created.
+ * @d:	    The domain for the event type being created.
+ * @mevt:   The event type being created.
+ * @rdtgrp: The rdtgroup for which the monitor file is being created,
+ *          used to determine if this is the default control group.
+ * @do_sum: Whether the SNC sub-numa node monitors are being created.
+ */
+static struct mon_data *mon_get_default_kn_priv(struct rdt_resource *r,
+						struct rdt_mon_domain *d,
+						struct mon_evt *mevt,
+						struct rdtgroup *rdtgrp,
+						bool do_sum)
+{
+	struct kernfs_node *kn_dom, *kn_evt;
+	struct mon_data *priv;
+	bool snc_mode;
+	char name[32];
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
+	if (!do_sum)
+		sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
+	else
+		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
+
+	kn_dom = kernfs_find_and_get(kn_mondata, name);
+	if (!kn_dom)
+		return NULL;
+
+	kn_evt = kernfs_find_and_get(kn_dom, mevt->name);
+
+	/* Is this the creation of the default groups monitor files? */
+	if (!kn_evt && rdtgrp == &rdtgroup_default) {
+		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+		if (!priv)
+			return NULL;
+		priv->rid = r->rid;
+		priv->domid = do_sum ? d->ci->id : d->hdr.id;
+		priv->sum = do_sum;
+		priv->evtid = mevt->evtid;
+		return priv;
+	}
+
+	if (!kn_evt)
+		return NULL;
+
+	return kn_evt->priv;
+}
+
+/**
+ * mon_put_default_kn_priv_all() - Potentially free the mon_data priv data for
+ *                                 all events from the default control group.
+ * Put the mon_data priv data for all events for a particular domain.
+ * When called with the default control group, the priv structure previously
+ * allocated will be kfree()d. This should only be done as part of taking a
+ * domain offline.
+ * Only a domain offline will 'rmdir' monitor files in the default control
+ * group. After domain offline releases rdtgrp_mutex, all references will
+ * have been removed.
+ *
+ * @rdtgrp:  The rdtgroup for which the monitor files are being removed,
+ *           used to determine if this is the default control group.
+ * @name:    The name of the domain or SNC sub-numa domain which is being
+ *           taken offline.
+ */
+static void mon_put_default_kn_priv_all(struct rdtgroup *rdtgrp, char *name)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	struct kernfs_node *kn_dom, *kn_evt;
+	struct mon_evt *mevt;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (rdtgrp != &rdtgroup_default)
+		return;
+
+	kn_dom = kernfs_find_and_get(kn_mondata, name);
+	if (!kn_dom)
+		return;
+
+	list_for_each_entry(mevt, &r->evt_list, list) {
+		kn_evt = kernfs_find_and_get(kn_dom, mevt->name);
+		if (!kn_evt)
+			continue;
+		if (!kn_evt->priv)
+			continue;
+
+		kfree(kn_evt->priv);
+		kn_evt->priv = NULL;
+	}
+}
+
 static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
 		       void *priv)
 {
@@ -3135,19 +3239,25 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
 	return ret;
 }
 
-static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, char *subname)
+static void mon_rmdir_one_subdir(struct rdtgroup *rdtgrp, char *name, char *subname)
 {
+	struct kernfs_node *pkn = rdtgrp->mon.mon_data_kn;
 	struct kernfs_node *kn;
 
 	kn = kernfs_find_and_get(pkn, name);
 	if (!kn)
 		return;
+
+	mon_put_default_kn_priv_all(rdtgrp, name);
+
 	kernfs_put(kn);
 
-	if (kn->dir.subdirs <= 1)
+	if (kn->dir.subdirs <= 1) {
 		kernfs_remove(kn);
-	else
+	} else {
+		mon_put_default_kn_priv_all(rdtgrp, subname);
 		kernfs_remove_by_name(kn, subname);
+	}
 }
 
 /*
@@ -3170,10 +3280,10 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
+		mon_rmdir_one_subdir(prgrp, name, subname);
 
 		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
-			mon_rmdir_one_subdir(crgrp->mon.mon_data_kn, name, subname);
+			mon_rmdir_one_subdir(crgrp, name, subname);
 	}
 }
 
@@ -3182,19 +3292,19 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 			     bool do_sum)
 {
 	struct rmid_read rr = {0};
-	union mon_data_bits priv;
+	struct mon_data *priv;
 	struct mon_evt *mevt;
 	int ret;
 
 	if (WARN_ON(list_empty(&r->evt_list)))
 		return -EPERM;
 
-	priv.u.rid = r->rid;
-	priv.u.domid = do_sum ? d->ci->id : d->hdr.id;
-	priv.u.sum = do_sum;
 	list_for_each_entry(mevt, &r->evt_list, list) {
-		priv.u.evtid = mevt->evtid;
-		ret = mon_addfile(kn, mevt->name, priv.priv);
+		priv = mon_get_default_kn_priv(r, d, mevt, prgrp, do_sum);
+		if (WARN_ON_ONCE(!priv))
+			return -EINVAL;
+
+		ret = mon_addfile(kn, mevt->name, priv);
 		if (ret)
 			return ret;
 
@@ -3274,9 +3384,17 @@ static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	struct rdtgroup *prgrp, *crgrp;
 	struct list_head *head;
 
+	/*
+	 * During domain-online create the default control group first
+	 * so that mon_get_default_kn_priv() can find the allocated structure
+	 * on subsequent calls.
+	 */
+	mkdir_mondata_subdir(kn_mondata, d, r, &rdtgroup_default);
+
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		parent_kn = prgrp->mon.mon_data_kn;
-		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
+		if (prgrp != &rdtgroup_default)
+			mkdir_mondata_subdir(parent_kn, d, r, prgrp);
 
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
-- 
2.39.5


