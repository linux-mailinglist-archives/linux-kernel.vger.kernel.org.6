Return-Path: <linux-kernel+bounces-414377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068309D275C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0553CB311CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2981CF28C;
	Tue, 19 Nov 2024 13:38:32 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94B1CEE94
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023512; cv=none; b=qzwCBcl2RrMTG6YmV3phlrjUADmKlvL7/G9r7csSw9B2NuiNS7QZ0L9nKnvi/bw43iwl3Ev3yT9rlzxJhxL3y9+GH02k6AJGXI0s+pAeuTKdS3Hnue6EwUjlU2IQUlaqbmcB4ThVR2nE/ZFcjQuREismAZpwesv4NSOHYibxYvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023512; c=relaxed/simple;
	bh=6QoGya8pRAvbvqk8ZhF0qEl8s/LNLlZqsyAdVU3bfc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPs9KxUAa/ZuIQevHpZnSuLr8w2MFIzX1ih//+sPUh7OVHAC3lTPsBSw6kKnPU+lJr3e7k0UeFlPLEZ0QPWTDFE4FauIyRItImk0m/Qkmhi0IPuv/iUUvVMKccLEfv0vfQDNpnB7evnZw5muk16YybueyVmeU2+X9YB2FS7zIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xt59v168kz1T5Cj;
	Tue, 19 Nov 2024 21:36:19 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 91BC41400CB;
	Tue, 19 Nov 2024 21:38:17 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Nov
 2024 21:38:16 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <Dave.Martin@arm.com>
CC: <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
	<xiexiuqi@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v2 6/6] fs/resctrl: Add the helper to check if the task exists in the target group
Date: Tue, 19 Nov 2024 21:51:04 +0800
Message-ID: <20241119135104.595630-7-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241119135104.595630-1-zengheng4@huawei.com>
References: <20241119135104.595630-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100008.china.huawei.com (7.202.181.222)

After introducing the extension for monitoring feature, to check if a
closid exists within the target control group, it is not only check if the
closid of the control group is the same, but also to recursively check if
there is a closid of sub-monitor groups is the same. Therefore, a new
helper task_belongs_to_ctrl_group() is added.

On the x86 side, the closid of the child monitor group is the same as its
parent control group's (only the rmid is different), hence
resctrl_arch_match_rmid() can directly use the closid of the child monitor
group. Meanwhile, task_belongs_to_ctrl_group() can replace
resctrl_arch_match_closid() to be compatible with the x86 arch.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/resctrl/rdtgroup.c | 52 +++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 7ebf4bf75c94..7a188f3cceeb 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -589,19 +589,38 @@ static void update_task_closid_rmid(struct task_struct *t)
 
 static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup *rdtgrp)
 {
-	u32 closid, rmid = rdtgrp->mon.rmid;
+	u32 closid, rmid;
 
-	if (rdtgrp->type == RDTCTRL_GROUP)
-		closid = rdtgrp->closid;
-	else if (rdtgrp->type == RDTMON_GROUP)
-		closid = rdtgrp->mon.parent->closid;
-	else
-		return false;
+	closid = rdtgrp->closid;
+	rmid = rdtgrp->mon.rmid;
 
 	return resctrl_arch_match_closid(tsk, closid) &&
 	       resctrl_arch_match_rmid(tsk, closid, rmid);
 }
 
+/**
+ * task_belongs_to_ctrl_group - the helper to check if the task exists in
+ *				the target control group.
+ * @tsk: task to be checked
+ * @rdtgrp: target control group
+ */
+static bool task_belongs_to_ctrl_group(struct task_struct *tsk, struct rdtgroup *rdtgrp)
+{
+	struct rdtgroup *crdtgrp;
+
+	/* Check whether exists in contrl group self */
+	if (resctrl_arch_match_closid(tsk, rdtgrp->closid))
+		return true;
+
+	/* Check if exists in one of children monitor groups */
+	list_for_each_entry(crdtgrp, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+		if (resctrl_arch_match_closid(tsk, crdtgrp->closid))
+			return true;
+	}
+
+	return false;
+}
+
 static int __rdtgroup_move_task(struct task_struct *tsk,
 				struct rdtgroup *rdtgrp)
 {
@@ -618,17 +637,13 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 * their parent CTRL group.
 	 */
 	if (rdtgrp->type == RDTMON_GROUP &&
-	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
+	   !task_belongs_to_ctrl_group(tsk, rdtgrp->mon.parent)) {
 		rdt_last_cmd_puts("Can't move task to different control group\n");
 		return -EINVAL;
 	}
 
-	if (rdtgrp->type == RDTMON_GROUP)
-		resctrl_arch_set_closid_rmid(tsk, rdtgrp->mon.parent->closid,
-					     rdtgrp->mon.rmid);
-	else
-		resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
-					     rdtgrp->mon.rmid);
+	resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
+				     rdtgrp->mon.rmid);
 
 	/*
 	 * Ensure the task's closid and rmid are written before determining if
@@ -652,14 +667,13 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
 {
 	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
-		resctrl_arch_match_closid(t, r->closid));
+		task_belongs_to_ctrl_group(t, r));
 }
 
 static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
 {
 	return (resctrl_arch_mon_capable() && (r->type == RDTMON_GROUP) &&
-		resctrl_arch_match_rmid(t, r->mon.parent->closid,
-					r->mon.rmid));
+		resctrl_arch_match_rmid(t, r->closid, r->mon.rmid));
 }
 
 /**
@@ -909,7 +923,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 		    rdtg->mode != RDT_MODE_EXCLUSIVE)
 			continue;
 
-		if (!resctrl_arch_match_closid(tsk, rdtg->closid))
+		if (!task_belongs_to_ctrl_group(tsk, rdtg))
 			continue;
 
 		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
@@ -917,7 +931,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 		seq_puts(s, "mon:");
 		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
 				    mon.crdtgrp_list) {
-			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
+			if (!resctrl_arch_match_rmid(tsk, crg->closid,
 						     crg->mon.rmid))
 				continue;
 			seq_printf(s, "%s", crg->kn->name);
-- 
2.25.1


