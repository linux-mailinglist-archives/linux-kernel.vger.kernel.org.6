Return-Path: <linux-kernel+bounces-215087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7107908E23
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4824E28D822
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A76C1AB502;
	Fri, 14 Jun 2024 15:02:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD5F1A3BAB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377338; cv=none; b=GO4d5q4/2ExPsejqpJ6xP+/xn0PIRCwzQX8OFz3hWkhiES8yhTNz76bl9u4lqM2nncQ/b9y9MVGAqX2Oa4FCZOcgoA/3+MKCDmRC9ezx8mNLUm/0TluanTRH9ZtphdUuMZ1oSrM8BQcy80Wr38MVx5DZC7nfok+zXpohkjr0NYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377338; c=relaxed/simple;
	bh=pxiLph68joHlE1YGl7yo6slrPXf2diFZkyMs3EXW6FU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prnlDcwoH3d6fk6k8XZiSVaM4goZTsIFomne6HCkYN9Eh2IHtBrHR98YKmbAyryKU4tojPdOIZ+v7q5rIDgRzXIwlmhTKRm1vxY2Xv4xQhj3uNQTSqUV+r8Wg9ScWDLwk4XjmsQTqEAxuEGGXjs9JcBWOVgzNzPG1r0R/hsuIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D7E61A25;
	Fri, 14 Jun 2024 08:02:40 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8D83F5A1;
	Fri, 14 Jun 2024 08:02:12 -0700 (PDT)
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
Subject: [PATCH v3 20/38] x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
Date: Fri, 14 Jun 2024 15:00:15 +0000
Message-Id: <20240614150033.10454-21-james.morse@arm.com>
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

mon_event_config_{read,write}() are called via IPI and access model
specific registers to do their work.

To support another architecture, this needs abstracting.

Rename mon_event_config_{read,write}() to have a "resctrl_arch_"
prefix, and move their struct mon_config_info parameter into
<linux/resctrl.h>.  This allows another architecture to supply an
implementation of these.

As struct mon_config_info is now exposed globally, give it a 'resctrl_'
prefix. MPAM systems need access to the domain to do this work, add
the resource and domain to struct resctrl_mon_config_info.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v1:
 * [Whitespace only] Re-tabbed struct resctrl_mon_config_info in
   <linux/resctrl.h> to fit the prevailing style.

   Non-functional change.

 * [Commit message only] Reword to align with the actual naming of the
   definitions and destination header file.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 34 +++++++++++++-------------
 include/linux/resctrl.h                |  9 +++++++
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index da71f1d80be4..45c9b8b76cca 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1578,11 +1578,6 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	return ret;
 }
 
-struct mon_config_info {
-	u32 evtid;
-	u32 mon_config;
-};
-
 #define INVALID_CONFIG_INDEX   UINT_MAX
 
 /**
@@ -1607,9 +1602,9 @@ static inline unsigned int mon_event_config_index_get(u32 evtid)
 	}
 }
 
-static void mon_event_config_read(void *info)
+void resctrl_arch_mon_event_config_read(void *info)
 {
-	struct mon_config_info *mon_info = info;
+	struct resctrl_mon_config_info *mon_info = info;
 	unsigned int index;
 	u64 msrval;
 
@@ -1624,14 +1619,15 @@ static void mon_event_config_read(void *info)
 	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
 }
 
-static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
+static void mondata_config_read(struct resctrl_mon_config_info *mon_info)
 {
-	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
+	smp_call_function_any(&mon_info->d->cpu_mask,
+			      resctrl_arch_mon_event_config_read, mon_info, 1);
 }
 
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
-	struct mon_config_info mon_info = {0};
+	struct resctrl_mon_config_info mon_info = {0};
 	struct rdt_domain *dom;
 	bool sep = false;
 
@@ -1642,9 +1638,11 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 		if (sep)
 			seq_puts(s, ";");
 
-		memset(&mon_info, 0, sizeof(struct mon_config_info));
+		memset(&mon_info, 0, sizeof(struct resctrl_mon_config_info));
+		mon_info.r = r;
+		mon_info.d = dom;
 		mon_info.evtid = evtid;
-		mondata_config_read(dom, &mon_info);
+		mondata_config_read(&mon_info);
 
 		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
 		sep = true;
@@ -1677,9 +1675,9 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-static void mon_event_config_write(void *info)
+void resctrl_arch_mon_event_config_write(void *info)
 {
-	struct mon_config_info *mon_info = info;
+	struct resctrl_mon_config_info *mon_info = info;
 	unsigned int index;
 
 	index = mon_event_config_index_get(mon_info->evtid);
@@ -1693,14 +1691,16 @@ static void mon_event_config_write(void *info)
 static void mbm_config_write_domain(struct rdt_resource *r,
 				    struct rdt_domain *d, u32 evtid, u32 val)
 {
-	struct mon_config_info mon_info = {0};
+	struct resctrl_mon_config_info mon_info = {0};
 
 	/*
 	 * Read the current config value first. If both are the same then
 	 * no need to write it again.
 	 */
+	mon_info.r = r;
+	mon_info.d = d;
 	mon_info.evtid = evtid;
-	mondata_config_read(d, &mon_info);
+	mondata_config_read(&mon_info);
 	if (mon_info.mon_config == val)
 		return;
 
@@ -1712,7 +1712,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * are scoped at the domain level. Writing any of these MSRs
 	 * on one CPU is observed by all the CPUs in the domain.
 	 */
-	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
+	smp_call_function_any(&d->cpu_mask, resctrl_arch_mon_event_config_write,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index fbae9a907544..65f0a2d17e4b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -220,6 +220,13 @@ struct resctrl_cpu_defaults {
 	u32 rmid;
 };
 
+struct resctrl_mon_config_info {
+	struct rdt_resource	*r;
+	struct rdt_domain	*d;
+	u32			evtid;
+	u32			mon_config;
+};
+
 /**
  * resctrl_arch_sync_cpu_closid_rmid() - Refresh this CPU's CLOSID and RMID.
  *					 Call via IPI.
@@ -263,6 +270,8 @@ struct rdt_domain *resctrl_arch_find_domain(struct rdt_resource *r, int id);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
+void resctrl_arch_mon_event_config_write(void *info);
+void resctrl_arch_mon_event_config_read(void *info);
 
 /*
  * Update the ctrl_val and apply this config right now.
-- 
2.39.2


