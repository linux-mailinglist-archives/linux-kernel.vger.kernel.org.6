Return-Path: <linux-kernel+bounces-272911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37236946279
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BE01F23AFC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EEF166F23;
	Fri,  2 Aug 2024 17:30:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53820166F0E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619836; cv=none; b=ludcpW703CHwrY7pUncu5eHky652jak0MqA7tdYkgSdOL0ZJVdR+BH5xiySvg6qW3PdoXlLiA/92msfys/44vyWyX/d5ahmUCGk51az2C6anNlWkH3ClVrtWOEV2gQtGIJmaF0kXIx4TbJIryuV1X1PSIv2bJuS7mLa9+eQw4WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619836; c=relaxed/simple;
	bh=Ii+TaSRnFyZpZHnFgvJUjFRPJZvz1OlwJIGeTLNmh/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmT0ixmtt9aZWffI+6725JocLh+nDrAl7agMAdyqzwfkvf/ZImhp66pjpOLB5OWUqy7gfFnucxdjMsnddyZAmNLEt2lJyF/q+rLcqIH+hIW5VwdHPwX+VdgON4p6HYPzwTTcFESKJYOhN3QLoRtor4y4eUwiMKg/CbRYcnmuD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 651E71042;
	Fri,  2 Aug 2024 10:31:00 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECF5C3F64C;
	Fri,  2 Aug 2024 10:30:29 -0700 (PDT)
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
Subject: [PATCH v4 12/39] x86/resctrl: Wrap resctrl_arch_find_domain() around rdt_find_domain()
Date: Fri,  2 Aug 2024 17:28:26 +0000
Message-Id: <20240802172853.22529-13-james.morse@arm.com>
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

rdt_find_domain() finds a domain given a resource and a cache-id.
It's not quite right for the resctrl arch API as it also returns the
position to insert a new domain, which is needed when bringing a
domain online in the arch code.

Wrap rdt_find_domain() in another function resctrl_arch_find_domain()
in order to avoid the unnecessary argument outside the arch code.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64

---
Changes since v3:
 * Used domain_list as a meaningful name instead of 'h'.

Changes since v1:
 * [Commit message only] Minor rewording to avoid "impersonating code".

 * [Commit message only] Typo fix:
   s/in a another/in another/ in commit message.
---
 arch/x86/kernel/cpu/resctrl/core.c        | 10 ++++++++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 --
 include/linux/resctrl.h                   |  3 +++
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 19852ba2c826..4a0dbdc2da4d 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -398,8 +398,8 @@ void rdt_ctrl_update(void *arg)
  * found (and NULL returned) then the first domain with id bigger than
  * the input id can be returned to the caller via @pos.
  */
-struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
-				       struct list_head **pos)
+static struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
+					      struct list_head **pos)
 {
 	struct rdt_domain_hdr *d;
 	struct list_head *l;
@@ -420,6 +420,12 @@ struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
 	return NULL;
 }
 
+struct rdt_domain_hdr *resctrl_arch_find_domain(struct list_head *domain_list,
+						int id)
+{
+	return rdt_find_domain(domain_list, id, NULL);
+}
+
 static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 4de1fea6190d..4fba6e79bb06 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -622,7 +622,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		 * This file provides data from a single domain. Search
 		 * the resource to find the domain with "domid".
 		 */
-		hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
+		hdr = resctrl_arch_find_domain(&r->mon_domains, domid);
 		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
 			ret = -ENOENT;
 			goto out;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index bb88be45b8c4..0b2113364caa 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -578,8 +578,6 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
 int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
 int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 			     umode_t mask);
-struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
-				       struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2271fa7eb6c4..1eb6dc5b7b79 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -313,6 +313,9 @@ static inline u32 resctrl_get_default_ctrl(struct rdt_resource *r)
 
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+
+struct rdt_domain_hdr *resctrl_arch_find_domain(struct list_head *domain_list,
+						int id);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 /*
-- 
2.39.2


