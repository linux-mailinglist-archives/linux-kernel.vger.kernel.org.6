Return-Path: <linux-kernel+bounces-539366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65175A4A375
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FC23A142F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D927C14F;
	Fri, 28 Feb 2025 20:01:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230FA27C144
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772912; cv=none; b=N8FzxpYnTP3Ix7ITO70VSGzfN0MJKR265pgD5NEQ/CXEW8ms78Hf9/oPQTPWuGm6Wmajtew2xv49rofZ0alO2t4kPeaOIJi4h7DzWk7tlRYSphOgKNTjMc31Ec05O6qwuYdC2AW82ninVe+LulKVL3G5qZJyFOrGnzsJp43RW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772912; c=relaxed/simple;
	bh=uC4R30oYbR3iG75+cf89id9bE8GVG9O/rfQEdbe7dBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZLqjoC6Toht1btFcj8Ot9cyDfgNwaqz8oTi6AHNVr4RfjlHcnPn5mDLkQaBxc1DwrMH+pUwxbFnNKz543mTAkwMPueUHjqPA5of9svrEcsKmxTCXPFhA6Zy+RF5QJjTGbewWRr4e9syZ684SH0xfXnWWP7T5G4sLuKrrhV06qIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D159E1A25;
	Fri, 28 Feb 2025 12:02:05 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95BC43F5A1;
	Fri, 28 Feb 2025 12:01:47 -0800 (PST)
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
Subject: [PATCH v7 31/49] x86/resctrl: Remove the limit on the number of CLOSID
Date: Fri, 28 Feb 2025 19:58:55 +0000
Message-Id: <20250228195913.24895-32-james.morse@arm.com>
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

From: Amit Singh Tomar <amitsinght@marvell.com>

Resctrl allocates and finds free CLOSID values using the bits of a u32.
This restricts the number of control groups that can be created by
user-space.

MPAM has an architectural limit of 2^16 CLOSID values, Intel x86 could
be extended beyond 32 values. There is at least one MPAM platform which
supports more than 32 CLOSID values.

Replace the fixed size bitmap with calls to the bitmap API to allocate
an array of a sufficient size.

ffs() returns '1' for bit 0, hence the existing code subtracts 1 from
the index to get the CLOSID value. find_first_bit() returns the bit
number which does not need adjusting.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
[ morse: fixed the off-by-one in the allocator and the wrong
 not-found value. Removed the limit. Rephrase the commit message. ]
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v6:
 * Set variable to NULL after kfree()ing it.
 * Call closid_exit() from rdt_kill_sb() to prevent a memory leak.

Changes since v5:
 * This patch got pulled into this series.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 47 +++++++++++++++++---------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c6274d40b217..5f391e8b5746 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -130,8 +130,8 @@ static bool resctrl_is_mbm_event(int e)
 }
 
 /*
- * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
- * we can keep a bitmap of free CLOSIDs in a single integer.
+ * Trivial allocator for CLOSIDs. Use BITMAP APIs to manipulate a bitmap
+ * of free CLOSIDs.
  *
  * Using a global CLOSID across all resources has some advantages and
  * some drawbacks:
@@ -144,7 +144,7 @@ static bool resctrl_is_mbm_event(int e)
  * - Our choices on how to configure each resource become progressively more
  *   limited as the number of resources grows.
  */
-static unsigned long closid_free_map;
+static unsigned long *closid_free_map;
 static int closid_free_map_len;
 
 int closids_supported(void)
@@ -152,20 +152,31 @@ int closids_supported(void)
 	return closid_free_map_len;
 }
 
-static void closid_init(void)
+static int closid_init(void)
 {
 	struct resctrl_schema *s;
-	u32 rdt_min_closid = 32;
+	u32 rdt_min_closid = ~0;
 
 	/* Compute rdt_min_closid across all resources */
 	list_for_each_entry(s, &resctrl_schema_all, list)
 		rdt_min_closid = min(rdt_min_closid, s->num_closid);
 
-	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
+	closid_free_map = bitmap_alloc(rdt_min_closid, GFP_KERNEL);
+	if (!closid_free_map)
+		return -ENOMEM;
+	bitmap_fill(closid_free_map, rdt_min_closid);
 
 	/* RESCTRL_RESERVED_CLOSID is always reserved for the default group */
-	__clear_bit(RESCTRL_RESERVED_CLOSID, &closid_free_map);
+	__clear_bit(RESCTRL_RESERVED_CLOSID, closid_free_map);
 	closid_free_map_len = rdt_min_closid;
+
+	return 0;
+}
+
+static void closid_exit(void)
+{
+	bitmap_free(closid_free_map);
+	closid_free_map = NULL;
 }
 
 static int closid_alloc(void)
@@ -182,12 +193,11 @@ static int closid_alloc(void)
 			return cleanest_closid;
 		closid = cleanest_closid;
 	} else {
-		closid = ffs(closid_free_map);
-		if (closid == 0)
+		closid = find_first_bit(closid_free_map, closid_free_map_len);
+		if (closid == closid_free_map_len)
 			return -ENOSPC;
-		closid--;
 	}
-	__clear_bit(closid, &closid_free_map);
+	__clear_bit(closid, closid_free_map);
 
 	return closid;
 }
@@ -196,7 +206,7 @@ void closid_free(int closid)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	__set_bit(closid, &closid_free_map);
+	__set_bit(closid, closid_free_map);
 }
 
 /**
@@ -210,7 +220,7 @@ bool closid_allocated(unsigned int closid)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	return !test_bit(closid, &closid_free_map);
+	return !test_bit(closid, closid_free_map);
 }
 
 /**
@@ -2754,20 +2764,22 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out_ctx;
 	}
 
-	closid_init();
+	ret = closid_init();
+	if (ret)
+		goto out_schemata_free;
 
 	if (resctrl_arch_mon_capable())
 		flags |= RFTYPE_MON;
 
 	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
 	if (ret)
-		goto out_schemata_free;
+		goto out_closid_exit;
 
 	kernfs_activate(rdtgroup_default.kn);
 
 	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
 	if (ret < 0)
-		goto out_schemata_free;
+		goto out_closid_exit;
 
 	if (resctrl_arch_mon_capable()) {
 		ret = mongroup_create_dir(rdtgroup_default.kn,
@@ -2818,6 +2830,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		kernfs_remove(kn_mongrp);
 out_info:
 	kernfs_remove(kn_info);
+out_closid_exit:
+	closid_exit();
 out_schemata_free:
 	schemata_list_destroy();
 out_ctx:
@@ -3071,6 +3085,7 @@ static void rdt_kill_sb(struct super_block *sb)
 		resctrl_arch_disable_alloc();
 	if (resctrl_arch_mon_capable())
 		resctrl_arch_disable_mon();
+	closid_exit();
 	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
-- 
2.39.5


