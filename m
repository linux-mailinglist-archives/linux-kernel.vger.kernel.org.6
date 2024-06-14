Return-Path: <linux-kernel+bounces-215078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF34A908E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714D628E04D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3416A19B5BA;
	Fri, 14 Jun 2024 15:01:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB4019B595
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377310; cv=none; b=jlmsebEmTQPZHTftc64sT7ZTr7BGwNUok4o+7TVERstywxl9joTXZae6eP9Rw6bM6ltafN3SdK36KOJWV8W8hLwlx4aZbiEuYgZfz7W2saOcUkzu1uS3VBNWYuLXSuZEzk3bbaVIiIAUfDOoDNAzNyoudKRu0zhWx7lR6UwBdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377310; c=relaxed/simple;
	bh=gPbnexUT3SLPn2ac/yqk9+H8gEfWvM3toDmCLUAtHH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNIchZKb7Nks+7SZPBFaNXalJIzgqRrPC8CTWgI9T3dstrr8uxxWFEEQDHvgNutwFqXsQLTt6i5kZDkyxh+VXbRQj9jHjJ2bjg72aW5omZ3TVS68+nKzOO0+6MjwfH5/98J+ZmTKdPmHjEHQqCxywwBK+SksUXfwiz4h1Co3Xcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30DA0175D;
	Fri, 14 Jun 2024 08:02:13 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EBCB3F5A1;
	Fri, 14 Jun 2024 08:01:45 -0700 (PDT)
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
Subject: [PATCH v3 12/38] x86/resctrl: Wrap resctrl_arch_find_domain() around rdt_find_domain()
Date: Fri, 14 Jun 2024 15:00:07 +0000
Message-Id: <20240614150033.10454-13-james.morse@arm.com>
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

rdt_find_domain() finds a domain given a resource and a cache-id.
It's not quite right for the resctrl arch API as it also returns the
position to insert a new domain, which is needed when bringing a
domain online in the arch code.

Wrap rdt_find_domain() in another function resctrl_arch_find_domain()
in order to avoid the unnecessary argument outside the arch code.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v1:
 * [Commit message only] Minor rewording to avoid "impersonating code".

 * [Commit message only] Typo fix:
   s/in a another/in another/ in commit message.
---
 arch/x86/kernel/cpu/resctrl/core.c        | 9 +++++++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 2 --
 include/linux/resctrl.h                   | 2 ++
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index fe7b99e7f07e..9ad660b2b097 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -381,8 +381,8 @@ void rdt_ctrl_update(void *arg)
  * caller, return the first domain whose id is bigger than the input id.
  * The domain list is sorted by id in ascending order.
  */
-struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
-				   struct list_head **pos)
+static struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
+					  struct list_head **pos)
 {
 	struct rdt_domain *d;
 	struct list_head *l;
@@ -406,6 +406,11 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	return NULL;
 }
 
+struct rdt_domain *resctrl_arch_find_domain(struct rdt_resource *r, int id)
+{
+	return rdt_find_domain(r, id, NULL);
+}
+
 static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 2ef91e748325..2100560dda6a 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -600,7 +600,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	evtid = md.u.evtid;
 
 	r = resctrl_arch_get_resource(resid);
-	d = rdt_find_domain(r, domid, NULL);
+	d = resctrl_arch_find_domain(r, domid);
 	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
 		goto out;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 73b44b684c52..54aba0b6b7d2 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -535,8 +535,6 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
 int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
 int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 			     umode_t mask);
-struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
-				   struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 476d92ab0884..5f1d578371ab 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -277,6 +277,8 @@ static inline u32 resctrl_get_default_ctrl(struct rdt_resource *r)
 
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+
+struct rdt_domain *resctrl_arch_find_domain(struct rdt_resource *r, int id);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 /*
-- 
2.39.2


