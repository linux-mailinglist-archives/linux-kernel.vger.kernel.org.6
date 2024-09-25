Return-Path: <linux-kernel+bounces-339674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBFD9868CF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA51C282265
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988DA156C72;
	Wed, 25 Sep 2024 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUXYh80d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B864C91
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301478; cv=none; b=ntQwZWr/9EUexUxue+BH6zVbMYfbZE5HdHSLsD+6SvzjNmfyaSNATaE66q5HlXDkzrlw/72HJl4RT7oRf7GlL+vLDsAMi1VRMOotne7P98mtmANuBTT791GeuzmdCR5kxV1Mi2caA/b/VoK+tP5wIhvOUoXxDbomInDVZ+wFKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301478; c=relaxed/simple;
	bh=yx8lih9oLY12YVOI+EkDxwGMzkYwdi7Tv9kls7gCen8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WAydCzsry0rFpG9m8HXLHY0au6jvUB01eceMwecKmbmma/U9uBhiJVM2NvfCB6+7ovFkgqZBmCG93vtXS5C7Dev0CjGSoMjcvijEHg9Dl1hcagoSq9d0vKkLOgxnyatgR0NeIG4pRAKo89SFHkEZGJTX2Sc53/rSm+lqWqit+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUXYh80d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6784EC4CEC3;
	Wed, 25 Sep 2024 21:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727301477;
	bh=yx8lih9oLY12YVOI+EkDxwGMzkYwdi7Tv9kls7gCen8=;
	h=Date:From:To:Cc:Subject:From;
	b=DUXYh80dExPQHIaEeR5Jj9Um/wdLod2oPE8J53sj/VnwdiG/uM6vcUDi3tG+6GSCM
	 GOSUFSCsuTsrILAgJiroIGRHj3wqbOsi3QFCxkTbMzqFqBv5DF5oAg3GNc2K3SkTnc
	 Md8MIiWS1ilZXLFt2cCrlxPsECnz/mGH7En1jUAyBmKARnbVGF6FAmBdd8g3CNajy7
	 yEsqYiousWCby/okHN1gtPeoGL+kk10ww5eJ11u9e1z8OBI/DQYdSpawu8dxZxBQ7F
	 SFc4POyw2YdYpydm0SGE5hZIUTrTuWuDlpa9+gPhk9FXI1cvTp4AwZ7PIbXgqnNjhj
	 b+qOp+LUcSBUA==
Date: Wed, 25 Sep 2024 11:57:56 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com
Subject: [sched_ext/for-6.12-fixes] sched_ext: Add __COMPAT helpers for
 features added during v6.12 devel cycle
Message-ID: <ZvSHZL3mBlYm2H_A@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

cgroup support and scx_bpf_dispatch[_vtime]_from_dsq() are newly added since
8bb30798fd6e ("sched_ext: Fixes incorrect type in bpf_scx_init()") which is
the current earliest commit targeted by BPF schedulers. Add compat helpers
for them and apply them in the example schedulers.

These will be dropped after a few kernel releases. The exact backward
compatibility window hasn't been decided yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applying to sched_ext/for-6.12-fixes.

Thanks.

 tools/sched_ext/include/scx/compat.bpf.h |   19 +++++++++++++++++++
 tools/sched_ext/scx_flatcg.bpf.c         |   10 +++++-----
 tools/sched_ext/scx_qmap.bpf.c           |   12 ++++++------
 3 files changed, 30 insertions(+), 11 deletions(-)

--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -15,6 +15,25 @@
 	__ret;									\
 })
 
+/* v6.12: 819513666966 ("sched_ext: Add cgroup support") */
+#define __COMPAT_scx_bpf_task_cgroup(p)						\
+	(bpf_ksym_exists(scx_bpf_task_cgroup) ?					\
+	 scx_bpf_task_cgroup((p)) : NULL)
+
+/* v6.12: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()") */
+#define __COMPAT_scx_bpf_dispatch_from_dsq_set_slice(it, slice)			\
+	(bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_slice) ?			\
+	 scx_bpf_dispatch_from_dsq_set_slice((it), (slice)) : (void)0)
+#define __COMPAT_scx_bpf_dispatch_from_dsq_set_vtime(it, vtime)			\
+	(bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_vtime) ?			\
+	 scx_bpf_dispatch_from_dsq_set_vtime((it), (vtime)) : (void)0)
+#define __COMPAT_scx_bpf_dispatch_from_dsq(it, p, dsq_id, enq_flags)		\
+	(bpf_ksym_exists(scx_bpf_dispatch_from_dsq) ?				\
+	 scx_bpf_dispatch_from_dsq((it), (p), (dsq_id), (enq_flags)) : false)
+#define __COMPAT_scx_bpf_dispatch_vtime_from_dsq(it, p, dsq_id, enq_flags)	\
+	(bpf_ksym_exists(scx_bpf_dispatch_vtime_from_dsq) ?			\
+	 scx_bpf_dispatch_vtime_from_dsq((it), (p), (dsq_id), (enq_flags)) : false)
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -383,7 +383,7 @@ void BPF_STRUCT_OPS(fcg_enqueue, struct
 		return;
 	}
 
-	cgrp = scx_bpf_task_cgroup(p);
+	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
 	cgc = find_cgrp_ctx(cgrp);
 	if (!cgc)
 		goto out_release;
@@ -509,7 +509,7 @@ void BPF_STRUCT_OPS(fcg_runnable, struct
 {
 	struct cgroup *cgrp;
 
-	cgrp = scx_bpf_task_cgroup(p);
+	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
 	update_active_weight_sums(cgrp, true);
 	bpf_cgroup_release(cgrp);
 }
@@ -522,7 +522,7 @@ void BPF_STRUCT_OPS(fcg_running, struct
 	if (fifo_sched)
 		return;
 
-	cgrp = scx_bpf_task_cgroup(p);
+	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
 	cgc = find_cgrp_ctx(cgrp);
 	if (cgc) {
 		/*
@@ -565,7 +565,7 @@ void BPF_STRUCT_OPS(fcg_stopping, struct
 	if (!taskc->bypassed_at)
 		return;
 
-	cgrp = scx_bpf_task_cgroup(p);
+	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
 	cgc = find_cgrp_ctx(cgrp);
 	if (cgc) {
 		__sync_fetch_and_add(&cgc->cvtime_delta,
@@ -579,7 +579,7 @@ void BPF_STRUCT_OPS(fcg_quiescent, struc
 {
 	struct cgroup *cgrp;
 
-	cgrp = scx_bpf_task_cgroup(p);
+	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
 	update_active_weight_sums(cgrp, false);
 	bpf_cgroup_release(cgrp);
 }
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -318,11 +318,11 @@ static bool dispatch_highpri(bool from_t
 
 		if (tctx->highpri) {
 			/* exercise the set_*() and vtime interface too */
-			scx_bpf_dispatch_from_dsq_set_slice(
+			__COMPAT_scx_bpf_dispatch_from_dsq_set_slice(
 				BPF_FOR_EACH_ITER, slice_ns * 2);
-			scx_bpf_dispatch_from_dsq_set_vtime(
+			__COMPAT_scx_bpf_dispatch_from_dsq_set_vtime(
 				BPF_FOR_EACH_ITER, highpri_seq++);
-			scx_bpf_dispatch_vtime_from_dsq(
+			__COMPAT_scx_bpf_dispatch_vtime_from_dsq(
 				BPF_FOR_EACH_ITER, p, HIGHPRI_DSQ, 0);
 		}
 	}
@@ -340,9 +340,9 @@ static bool dispatch_highpri(bool from_t
 		else
 			cpu = scx_bpf_pick_any_cpu(p->cpus_ptr, 0);
 
-		if (scx_bpf_dispatch_from_dsq(BPF_FOR_EACH_ITER, p,
-					      SCX_DSQ_LOCAL_ON | cpu,
-					      SCX_ENQ_PREEMPT)) {
+		if (__COMPAT_scx_bpf_dispatch_from_dsq(BPF_FOR_EACH_ITER, p,
+						       SCX_DSQ_LOCAL_ON | cpu,
+						       SCX_ENQ_PREEMPT)) {
 			if (cpu == this_cpu) {
 				dispatched = true;
 				__sync_fetch_and_add(&nr_expedited_local, 1);


