Return-Path: <linux-kernel+bounces-272926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2643946288
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8B0289BBA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300F18BB5E;
	Fri,  2 Aug 2024 17:31:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B5318BB50
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619892; cv=none; b=uLK5M8FGxchZe/ePOCKfTpInwqx4Ee0vL6bYzgMJLeHtSciFiFgc7E6Di/hbmaXayfjC6B57761xwDbClzWjdZN7kb7dO/jTRE+DqiPF4c2u1v3hpB3i3WEtouoYds35JZSM8jUSg3LQqc2SKNaFN76y+m3QldzDfm5YfBj0OcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619892; c=relaxed/simple;
	bh=6UwLrAUJCtkg5OvHdwDY7mbQrz+/MwPQEezDe+zqA+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZMi9jGJ7i+RGTmEhIF59RhMXkz+xnDnwYORRb2HeH+B00pZnC3WdaG4eOOS2qTZj0sXvnOkFJKdq/IQkS2/EcnmgVVXg8KLAxOBYWDn5s8eU5jQh4xEn0Z9PNaHyeJj9cUH5gPdx3/lRbQKK4zCSi6enksRDyrcOFpfnVhlGWQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC2291007;
	Fri,  2 Aug 2024 10:31:55 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12B073F64C;
	Fri,  2 Aug 2024 10:31:26 -0700 (PDT)
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
Subject: [PATCH v4 27/39] x86/resctrl: Move get_config_index() to a header
Date: Fri,  2 Aug 2024 17:28:41 +0000
Message-Id: <20240802172853.22529-28-james.morse@arm.com>
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

get_config_index() is used by the architecture specific code to map a
CLOSID+type pair to an index in the configuration arrays.

MPAM needs to do this too to preserve the ABI to user-space, there is
no reason to do it differently.

Move the helper to a header file.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
---
Changes since v1:
 * Reindent resctrl_get_config_index() as per coding-style.rst rules.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 +++----------------
 include/linux/resctrl.h                   | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 4fba6e79bb06..3c9ac1c853eb 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -283,25 +283,12 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	return -EINVAL;
 }
 
-static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
-{
-	switch (type) {
-	default:
-	case CDP_NONE:
-		return closid;
-	case CDP_CODE:
-		return closid * 2 + 1;
-	case CDP_DATA:
-		return closid * 2;
-	}
-}
-
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
 	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	u32 idx = get_config_index(closid, t);
+	u32 idx = resctrl_get_config_index(closid, t);
 	struct msr_param msr_param;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
@@ -338,7 +325,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			idx = get_config_index(closid, t);
+			idx = resctrl_get_config_index(closid, t);
 			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
 				continue;
 			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
@@ -458,7 +445,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type type)
 {
 	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
-	u32 idx = get_config_index(closid, type);
+	u32 idx = resctrl_get_config_index(closid, type);
 
 	return hw_dom->ctrl_val[idx];
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f09c07e598f7..f99bd2996cba 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -386,6 +386,21 @@ void resctrl_arch_mon_event_config_write(void *info);
  */
 void resctrl_arch_mon_event_config_read(void *info);
 
+/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
+static inline u32 resctrl_get_config_index(u32 closid,
+					   enum resctrl_conf_type type)
+{
+	switch (type) {
+	default:
+	case CDP_NONE:
+		return closid;
+	case CDP_CODE:
+		return closid * 2 + 1;
+	case CDP_DATA:
+		return closid * 2;
+	}
+}
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
-- 
2.39.2


