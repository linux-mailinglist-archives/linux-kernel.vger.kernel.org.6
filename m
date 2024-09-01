Return-Path: <linux-kernel+bounces-310305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64169967973
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92EEB227FC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE65D184527;
	Sun,  1 Sep 2024 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnlaIzwm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117F17DFFC
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209061; cv=none; b=AfZ+h5VqK9YG6zIsIKAeNEn/OhQu4QCAkBFP/rJWasNAEF7QWr/3a+ASB/DWoMY8Pf8lWvq/kF/QbA409d6Iraet+NVMTTvoSVJelqtqR4uYPS97ryQK7V4DyC76SVMG+OWEBKPhLaqnCEh7CspZjNwAQHnxBD5zzjkyVbKqfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209061; c=relaxed/simple;
	bh=Vk2TZS2tzxfyfGN1pM2/Us+l1gNK8jIJFJfsnQgjWWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/+9RujPa0cpDpbw2OxnU2FwQY77RbIZy3EoSWNYwJB5SL/szewF1A47C7WzK7XAEoxs/9aNva2HLg6LKsO4mVx3oZNbW9kHNkdvkE0vfkt+/s16D2vy0y6SqqGV0PSJqwRKoT1nht3OtFktFmrl4i11SUIvQzIwbQb5m+y5vUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnlaIzwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDFEC4CEC8;
	Sun,  1 Sep 2024 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209060;
	bh=Vk2TZS2tzxfyfGN1pM2/Us+l1gNK8jIJFJfsnQgjWWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnlaIzwmcS0jDj8c1ciSZ9G9dDJ/gjkvFzCTj45j3CnZ3ey3hFbCs1chu0Fh0Z4pK
	 N4RdQRK2X0WJwUimFBeIT1Z10CMMy+gyo+AoXEbXQqz6foIkYfYWvDZ9aA3TmCIqzX
	 ZC+kVX8u9NhNtjI3QTBKUwxH+zK7rs0eRJaCGzS1/2L3QAcCWefF2ByJyjflcJRmVd
	 sK6Vg4WCAT65yhHO+Ld4vFCMCmSNSrBisuoeseDOnyDukY6SxUZJ4qI1Qbjpb4h6xp
	 d40x2QqSlEmGwBkTEfBgjjjPP2zTP2fJSuDuoaotPHBSeYFpxmaQhEYTzBOxC4uLxe
	 C9HLs2xy/tdHw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/12] sched_ext: Rename scx_kfunc_set_sleepable to unlocked and relocate
Date: Sun,  1 Sep 2024 06:43:38 -1000
Message-ID: <20240901164417.779239-2-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901164417.779239-1-tj@kernel.org>
References: <20240901164417.779239-1-tj@kernel.org>
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
Acked-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 66 +++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 450389c2073d..e7c6e824f875 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5393,35 +5393,6 @@ void __init init_sched_ext_class(void)
 
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
@@ -5764,6 +5735,35 @@ static const struct btf_kfunc_id_set scx_kfunc_set_cpu_release = {
 
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
@@ -6460,10 +6460,6 @@ static int __init scx_init(void)
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
@@ -6471,6 +6467,10 @@ static int __init scx_init(void)
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


