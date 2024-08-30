Return-Path: <linux-kernel+bounces-309475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A1B966B09
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9D328277B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA021BFE17;
	Fri, 30 Aug 2024 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOOQLlFJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA01BD00B
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051597; cv=none; b=uxg0wgHmluJobsRBbVkXYzPN+ggqDfwbVkMs8SwP9F0TrUm0QDn3/Q/DOYBW7h1Sv0qlbdhCij3EAiGqFcRTsD6PlZga2Hp4Ndkj6vVcrysTRrUUa/+WbmW+z3EEjFGxEA0+fg8TL5x8L7sJJBwoNTSTOHtLE+8KBG9X4g3lNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051597; c=relaxed/simple;
	bh=xhS49TLkud49oJkFfPAsnBu15cr7szSNNRVNIBOXkAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxAhX8zyYFlw6opgEHHaELbnVFIELJSw/bteDhsid0PO8WwyS6salJJvZcj64iY0TrS+m6HvvtviPKq40bV/7J2+X1f5k17OUdMqv9Mbzz8X/oR6oyd0IYq3+J9HE/wXtBXwuF1edocG6FRHCP1fiZpeRj5BhQPe0ButIsc4Pf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOOQLlFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD71C4CEC2;
	Fri, 30 Aug 2024 20:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051597;
	bh=xhS49TLkud49oJkFfPAsnBu15cr7szSNNRVNIBOXkAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOOQLlFJY5MCd04208R/x1e6hWWosy49QvIjdtxtchJQTnjbAiYkKBp0VHtZk6XTw
	 GNf6qBqQ74bOhGxR1AFdcwaS0ABYfMnYOrOU89JrDrMF7TmSJb+s9lpu/IO9DmqBLu
	 6U3rmYNvstI2/V+dzJY0rFxQLG340IEJnIKtGb4alrhMwEB7rIOIBYICtDvvTHGxAf
	 SPJdarfa1VehURiJ2BtpZOccYefH575XMZEc/+Pfy+5b591iUET0TY5EAnELpRlGyQ
	 TDLQc8C7/qjtdjhqQNIatvTOSFSnNzKbFNpksGRkWADM49D5mGAcrWH53E7QFlS6Wb
	 S2o2etaGrMEPg==
Date: Fri, 30 Aug 2024 10:59:56 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH v2 11/11] scx_qmap: Implement highpri boosting
Message-ID: <ZtIyzNOJyXtZBnU_@slm.duckdns.org>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-12-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-12-tj@kernel.org>

Implement a silly boosting mechanism for nice -20 tasks. The only purpose is
demonstrating and testing scx_bpf_dispatch_from_dsq(). The boosting only
works within SHARED_DSQ and makes only minor differences with increased
dispatch batch (-b).

This exercises moving tasks to a user DSQ and all local DSQs from
ops.dispatch() and BPF timerfn.

v2: Drop the workaround for the iterated tasks not being trusted by the
    verifier. The issue is fixed from BPF side.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: David Vernet <void@manifault.com>
Cc: Changwoo Min <multics69@gmail.com>
Cc: Andrea Righi <andrea.righi@linux.dev>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c |  126 ++++++++++++++++++++++++++++++++++++-----
 tools/sched_ext/scx_qmap.c     |   11 +++
 2 files changed, 123 insertions(+), 14 deletions(-)

--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -27,6 +27,8 @@
 enum consts {
 	ONE_SEC_IN_NS		= 1000000000,
 	SHARED_DSQ		= 0,
+	HIGHPRI_DSQ		= 1,
+	HIGHPRI_WEIGHT		= 8668,		/* this is what -20 maps to */
 };
 
 char _license[] SEC("license") = "GPL";
@@ -36,10 +38,12 @@ const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_inf_loop_after;
 const volatile u32 dsp_batch;
+const volatile bool highpri_boosting;
 const volatile bool print_shared_dsq;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
 
+u64 nr_highpri_queued;
 u32 test_error_cnt;
 
 UEI_DEFINE(uei);
@@ -95,6 +99,7 @@ static u64 core_sched_tail_seqs[5];
 /* Per-task scheduling context */
 struct task_ctx {
 	bool	force_local;	/* Dispatch directly to local_dsq */
+	bool	highpri;
 	u64	core_sched_seq;
 };
 
@@ -122,6 +127,7 @@ struct {
 /* Statistics */
 u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued, nr_ddsp_from_enq;
 u64 nr_core_sched_execed;
+u64 nr_expedited_local, nr_expedited_remote, nr_expedited_lost, nr_expedited_from_timer;
 u32 cpuperf_min, cpuperf_avg, cpuperf_max;
 u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
 
@@ -140,17 +146,25 @@ static s32 pick_direct_dispatch_cpu(stru
 	return -1;
 }
 
+static struct task_ctx *lookup_task_ctx(struct task_struct *p)
+{
+	struct task_ctx *tctx;
+
+	if (!(tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0))) {
+		scx_bpf_error("task_ctx lookup failed");
+		return NULL;
+	}
+	return tctx;
+}
+
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
 	struct task_ctx *tctx;
 	s32 cpu;
 
-	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
-	if (!tctx) {
-		scx_bpf_error("task_ctx lookup failed");
+	if (!(tctx = lookup_task_ctx(p)))
 		return -ESRCH;
-	}
 
 	cpu = pick_direct_dispatch_cpu(p, prev_cpu);
 
@@ -197,11 +211,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct
 	if (test_error_cnt && !--test_error_cnt)
 		scx_bpf_error("test triggering error");
 
-	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
-	if (!tctx) {
-		scx_bpf_error("task_ctx lookup failed");
+	if (!(tctx = lookup_task_ctx(p)))
 		return;
-	}
 
 	/*
 	 * All enqueued tasks must have their core_sched_seq updated for correct
@@ -256,6 +267,10 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct
 		return;
 	}
 
+	if (highpri_boosting && p->scx.weight >= HIGHPRI_WEIGHT) {
+		tctx->highpri = true;
+		__sync_fetch_and_add(&nr_highpri_queued, 1);
+	}
 	__sync_fetch_and_add(&nr_enqueued, 1);
 }
 
@@ -272,13 +287,73 @@ void BPF_STRUCT_OPS(qmap_dequeue, struct
 
 static void update_core_sched_head_seq(struct task_struct *p)
 {
-	struct task_ctx *tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
 	int idx = weight_to_idx(p->scx.weight);
+	struct task_ctx *tctx;
 
-	if (tctx)
+	if ((tctx = lookup_task_ctx(p)))
 		core_sched_head_seqs[idx] = tctx->core_sched_seq;
-	else
-		scx_bpf_error("task_ctx lookup failed");
+}
+
+/*
+ * To demonstrate the use of scx_bpf_dispatch_from_dsq(), implement silly
+ * selective priority boosting mechanism by scanning SHARED_DSQ looking for
+ * highpri tasks, moving them to HIGHPRI_DSQ and then consuming them first. This
+ * makes minor difference only when dsp_batch is larger than 1.
+ *
+ * scx_bpf_dispatch[_vtime]_from_dsq() are allowed both from ops.dispatch() and
+ * non-rq-lock holding BPF programs. As demonstration, this function is called
+ * from qmap_dispatch() and monitor_timerfn().
+ */
+static bool dispatch_highpri(bool from_timer)
+{
+	struct task_struct *p;
+	s32 this_cpu = bpf_get_smp_processor_id();
+
+	/* scan SHARED_DSQ and move highpri tasks to HIGHPRI_DSQ */
+	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
+		struct task_ctx *tctx;
+
+		if (!(tctx = lookup_task_ctx(p)))
+			return false;
+
+		if (tctx->highpri)
+			scx_bpf_dispatch_from_dsq(BPF_FOR_EACH_ITER, p,
+						  HIGHPRI_DSQ, 0, 0);
+	}
+
+	/*
+	 * Scan HIGHPRI_DSQ and dispatch until a task that can run on this CPU
+	 * is found.
+	 */
+	bpf_for_each(scx_dsq, p, HIGHPRI_DSQ, 0) {
+		bool dispatched = false;
+		s32 cpu;
+
+		if (bpf_cpumask_test_cpu(this_cpu, p->cpus_ptr))
+			cpu = this_cpu;
+		else
+			cpu = scx_bpf_pick_any_cpu(p->cpus_ptr, 0);
+
+		if (scx_bpf_dispatch_from_dsq(BPF_FOR_EACH_ITER, p,
+					      SCX_DSQ_LOCAL_ON | cpu, 0,
+					      SCX_ENQ_PREEMPT)) {
+			if (cpu == this_cpu) {
+				dispatched = true;
+				__sync_fetch_and_add(&nr_expedited_local, 1);
+			} else {
+				__sync_fetch_and_add(&nr_expedited_remote, 1);
+			}
+			if (from_timer)
+				__sync_fetch_and_add(&nr_expedited_from_timer, 1);
+		} else {
+			__sync_fetch_and_add(&nr_expedited_lost, 1);
+		}
+
+		if (dispatched)
+			return true;
+	}
+
+	return false;
 }
 
 void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
@@ -289,7 +364,10 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 c
 	void *fifo;
 	s32 i, pid;
 
-	if (scx_bpf_consume(SHARED_DSQ))
+	if (dispatch_highpri(false))
+		return;
+
+	if (!nr_highpri_queued && scx_bpf_consume(SHARED_DSQ))
 		return;
 
 	if (dsp_inf_loop_after && nr_dispatched > dsp_inf_loop_after) {
@@ -326,6 +404,8 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 c
 
 		/* Dispatch or advance. */
 		bpf_repeat(BPF_MAX_LOOPS) {
+			struct task_ctx *tctx;
+
 			if (bpf_map_pop_elem(fifo, &pid))
 				break;
 
@@ -333,13 +413,25 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 c
 			if (!p)
 				continue;
 
+			if (!(tctx = lookup_task_ctx(p))) {
+				bpf_task_release(p);
+				return;
+			}
+
+			if (tctx->highpri)
+				__sync_fetch_and_sub(&nr_highpri_queued, 1);
+
 			update_core_sched_head_seq(p);
 			__sync_fetch_and_add(&nr_dispatched, 1);
+
 			scx_bpf_dispatch(p, SHARED_DSQ, slice_ns, 0);
 			bpf_task_release(p);
+
 			batch--;
 			cpuc->dsp_cnt--;
 			if (!batch || !scx_bpf_dispatch_nr_slots()) {
+				if (dispatch_highpri(false))
+					return;
 				scx_bpf_consume(SHARED_DSQ);
 				return;
 			}
@@ -649,6 +741,10 @@ static void dump_shared_dsq(void)
 
 static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
+	bpf_rcu_read_lock();
+	dispatch_highpri(true);
+	bpf_rcu_read_unlock();
+
 	monitor_cpuperf();
 
 	if (print_shared_dsq)
@@ -670,6 +766,10 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	if (ret)
 		return ret;
 
+	ret = scx_bpf_create_dsq(HIGHPRI_DSQ, -1);
+	if (ret)
+		return ret;
+
 	timer = bpf_map_lookup_elem(&monitor_timer, &key);
 	if (!timer)
 		return -ESRCH;
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -29,6 +29,7 @@ const char help_fmt[] =
 "  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
 "  -P            Print out DSQ content to trace_pipe every second, use with -b\n"
+"  -H            Boost nice -20 tasks in SHARED_DSQ, use with -b\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -S            Suppress qmap-specific debug dump\n"
@@ -63,7 +64,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:Pd:D:Spvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PHd:D:Spvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -86,6 +87,9 @@ int main(int argc, char **argv)
 		case 'P':
 			skel->rodata->print_shared_dsq = true;
 			break;
+		case 'H':
+			skel->rodata->highpri_boosting = true;
+			break;
 		case 'd':
 			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
 			if (skel->rodata->disallow_tgid < 0)
@@ -121,6 +125,11 @@ int main(int argc, char **argv)
 		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
 		       skel->bss->nr_core_sched_execed,
 		       skel->bss->nr_ddsp_from_enq);
+		printf("         exp_local=%"PRIu64" exp_remote=%"PRIu64" exp_timer=%"PRIu64" exp_lost=%"PRIu64"\n",
+		       skel->bss->nr_expedited_local,
+		       skel->bss->nr_expedited_remote,
+		       skel->bss->nr_expedited_from_timer,
+		       skel->bss->nr_expedited_lost);
 		if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
 			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
 			       skel->bss->cpuperf_min,

