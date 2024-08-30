Return-Path: <linux-kernel+bounces-308655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5B1965FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911F91F2141E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF04219ABB3;
	Fri, 30 Aug 2024 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue2zh6tJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A931199FCD
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015865; cv=none; b=aBt7BlvTML5g0LQ+UPhuox/KdD+zs2ElZZvsMmQnHZ9Ue7OzgF/UBHw9JFRrbjPvnEVvLHhKBE8wBtk54WsPYqd9BHC0XZc/UqI44ZNeAzR3CZWa5+/mVC3WuxyU6+UZUMM/1TVL5vY0Gv7CZyR3YM9hGGzWHIi1h6llDcepH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015865; c=relaxed/simple;
	bh=jYbzTDcPNcHefVl8FR2+Z/8hO9n4kyBlUXQG6lPG1rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm0Tu1aocLAeNahm1oEjGDQly6K8ochFmqRXwtFsjpX9c5HItgBE8Exyk4JdznzPFClDi+v4gEOpmzfYJ4dAoJsrCfmrYmEU1f2A4V0TAMBN04uuILtpOthyQ9PecWNjBd6K4KmGxllhzViHocJ3bTP4TMwcbzzy1CiJsNW/6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue2zh6tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86B8C4CEC4;
	Fri, 30 Aug 2024 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015863;
	bh=jYbzTDcPNcHefVl8FR2+Z/8hO9n4kyBlUXQG6lPG1rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ue2zh6tJUxKjhyvnxinV0JptfFLE2oDBsPKc7wksWwQ8brEpEvFSZ2+7bHbZ80Qfj
	 kYtUUZCpneNVYMIcSYlFPkyu2CM2RFBVZyxsKlk5yTkH4gPNpvOqVNNNr4tHwCyPnJ
	 +8M/fsnOcEnCtlfEto7ExsQWYRydeK7NEiHlrMw/hNCMIGbP+EJ+ld8TV0JiIsSM+p
	 IJFBAYTd18yoNTwAuWkiseesgPvBWqdytzzVEaZjWb0sWrLsgRj+6cVqEonJDDCVpB
	 HvtgAiC8RaoiRIAIjOAH0RXhUB6gSRqMOCfMkkauEHqdlNADcPgckJfZptMwdcYJlT
	 aYMNS132aaZQA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/11] sched_ext: Rename scx_kfunc_set_sleepable to unlocked and relocate
Date: Fri, 30 Aug 2024 01:03:45 -1000
Message-ID: <20240830110415.116090-2-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830110415.116090-1-tj@kernel.org>
References: <20240830110415.116090-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sleepables don't need to be in its own kfunc set as each is tagged with
KF_SLEEPABLE. Rename to scx_kfunc_set_unlocked indicating that rq lock is
not held and relocate right above the any set. This will be used to add
kfuncs that are allowed to be called from SYSCALL but not TRACING.

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 66 +++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 140a4612d379..5423554a11af 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5395,35 +5395,6 @@ void __init init_sched_ext_class(void)
 
 __bpf_kfunc_start_defs();
 
-/**
- * scx_bpf_create_dsq - Create a custom DSQ
- * @dsq_id: DSQ to create
- * @node: NUMA node to allocate from
- *
- * Create a custom DSQ identified by @dsq_id. Can be called from any sleepable
- * scx callback, and any BPF_PROG_TYPE_SYSCALL prog.
- */
-__bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
-{
-	if (unlikely(node >= (int)nr_node_ids ||
-		     (node < 0 && node != NUMA_NO_NODE)))
-		return -EINVAL;
-	return PTR_ERR_OR_ZERO(create_dsq(dsq_id, node));
-}
-
-__bpf_kfunc_end_defs();
-
-BTF_KFUNCS_START(scx_kfunc_ids_sleepable)
-BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
-BTF_KFUNCS_END(scx_kfunc_ids_sleepable)
-
-static const struct btf_kfunc_id_set scx_kfunc_set_sleepable = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_sleepable,
-};
-
-__bpf_kfunc_start_defs();
-
 /**
  * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
  * @p: task_struct to select a CPU for
@@ -5766,6 +5737,35 @@ static const struct btf_kfunc_id_set scx_kfunc_set_cpu_release = {
 
 __bpf_kfunc_start_defs();
 
+/**
+ * scx_bpf_create_dsq - Create a custom DSQ
+ * @dsq_id: DSQ to create
+ * @node: NUMA node to allocate from
+ *
+ * Create a custom DSQ identified by @dsq_id. Can be called from any sleepable
+ * scx callback, and any BPF_PROG_TYPE_SYSCALL prog.
+ */
+__bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
+{
+	if (unlikely(node >= (int)nr_node_ids ||
+		     (node < 0 && node != NUMA_NO_NODE)))
+		return -EINVAL;
+	return PTR_ERR_OR_ZERO(create_dsq(dsq_id, node));
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
+BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
+BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_unlocked,
+};
+
+__bpf_kfunc_start_defs();
+
 /**
  * scx_bpf_kick_cpu - Trigger reschedule on a CPU
  * @cpu: cpu to kick
@@ -6462,10 +6462,6 @@ static int __init scx_init(void)
 	 * check using scx_kf_allowed().
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_sleepable)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
-					     &scx_kfunc_set_sleepable)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_select_cpu)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_enqueue_dispatch)) ||
@@ -6473,6 +6469,10 @@ static int __init scx_init(void)
 					     &scx_kfunc_set_dispatch)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_cpu_release)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_unlocked)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					     &scx_kfunc_set_unlocked)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_any)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
-- 
2.46.0


