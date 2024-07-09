Return-Path: <linux-kernel+bounces-246697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9032492C540
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C553B21FF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957C718C168;
	Tue,  9 Jul 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co3QkM8e"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639F189F50
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560113; cv=none; b=iR7vN04oxHpOH5fVnFz7PNgwBeZZ4H6NhFFzEllqMnkoUdUFXifvd4QaBul1s19YNdhNlf7o7QNxmTRqTdRmH4MDrSrzQn043guSJYXLru8rF2nqpvfzupbrOliLNB/17JqJrgd5ORIYQXrTR3tzcnge/4eWcP5WOI0jQZrAXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560113; c=relaxed/simple;
	bh=yJOifvxwPkq8z7X3t2LM6/Yxrphv/2HyuOAMb5ucR5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jz0B9i76D1kGx2VLO5HzQypn2a2KUXBRK6bapYr/ZRzsGoE0aUvqHYgOa+AFS2x0r4zuclJQEMD8dnPSjRbitwH6iqgJcZhDweUdNplXok6X2mEG21DUSozg7oUejc6oIsYw7gAwiu8PIqAfipAJVmQ1tGCfV2xTDpJXYtYhx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co3QkM8e; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3738690172eso24893255ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560111; x=1721164911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BYGlNVr8KZsVIpJwjqIOI8vD2FsLDFvrIyFo8N6d1c=;
        b=co3QkM8eHHUGyZu/XwnAL6f+NrtHKhKGmeWxSrsFLH2OAV7V/hYh1CDk1SoagHcWmC
         taPAlCliZmS8clRr0U88ulOiiCYtoP/nmLSgs+0B44sSre/HEMhIEqGBjz4mlkGt7Ede
         Lk+0hM4mPupWLPe3m0TLggO+gpD433AwtgPSZB0pYt7nzXyHXnijSfeYQMSiFVr32iws
         spGVwiDIThpz0I05ALTfi/Ir7B+zBcVK9Q8ab3OXHrKGYUayNNmkwiMTRjNWL7+4J5aV
         7QRtO41IfK37Qga5ReffH5oC3dZgNM69hDYbZH+9/ZyNHErQew6a6Kvd2djJAU/4fOhx
         9Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560111; x=1721164911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1BYGlNVr8KZsVIpJwjqIOI8vD2FsLDFvrIyFo8N6d1c=;
        b=k8CYXEg2hxa1fg8XUGr+W6UDLVaa9sCCG44CgwBrFNXjrDZQQc5mmYCr4oOAYQ7l0j
         5PEsaJ9EAWd6SCExtZ5K9UNkmFtaTahKpaTFugDrZ8CYOJDyqHdQ/mVAOcVcSYtESKSn
         ad+HfyenHADTTmR5RrE41Zrf16Jp09A5F7FfiX/fKF3d8GQftO913jGLJRgXu/gduKtQ
         2dXsQcJlpGyQOdWULikEhfok54pYcE72T7FdokiLNCCdGofAs1lFXgRgMo7DMpsTEqkZ
         tC/HV1QpIGe7ce3gp10O/0AlIre6N9nEU2Gjy3N8KJXCLQfUikw9+JEIZrjDpIUgCdUo
         AyOQ==
X-Gm-Message-State: AOJu0YyccJYWrpg5zPzItG48UaVoD3iuX6u8YjZQltYD6Pnxl0aLDmeg
	pMidp4eKXVAIJw4evUfqWdvjIDMM6ONThd/r9jW3ZY8U+7VFjs8e
X-Google-Smtp-Source: AGHT+IHTOOocoRKwPf7XMtlftdHw9wsFK1JmhL3d7tObqpfNUyQIKJC2FbVGi6JkcCoJR6Eaax3pTA==
X-Received: by 2002:a05:6e02:1a2e:b0:374:ad1d:941a with SMTP id e9e14a558f8ab-38a57ad744cmr45384015ab.10.1720560111366;
        Tue, 09 Jul 2024 14:21:51 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d66db041csm1804896a12.68.2024.07.09.14.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:21:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	righi.andrea@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] sched_ext/scx_qmap: Pick idle CPU for direct dispatch on !wakeup enqueues
Date: Tue,  9 Jul 2024 11:21:12 -1000
Message-ID: <20240709212137.1199269-7-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709212137.1199269-1-tj@kernel.org>
References: <20240709212137.1199269-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because there was no way to directly dispatch to the local DSQ of a remote
CPU from ops.enqueue(), scx_qmap skipped looking for an idle CPU on !wakeup
enqueues. This restriction was removed and schbed_ext now allows
SCX_DSQ_LOCAL_ON verdicts for direct dispatches.

Factor out pick_direct_dispatch_cpu() from ops.select_cpu() and use it to
direct dispatch from ops.enqueue() on !wakeup enqueues.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Changwoo Min <changwoo@igalia.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 39 ++++++++++++++++++++++++++--------
 tools/sched_ext/scx_qmap.c     |  5 +++--
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 27e35066a602..892278f12dce 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -120,11 +120,26 @@ struct {
 } cpu_ctx_stor SEC(".maps");
 
 /* Statistics */
-u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
+u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued, nr_ddsp_from_enq;
 u64 nr_core_sched_execed;
 u32 cpuperf_min, cpuperf_avg, cpuperf_max;
 u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
 
+static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
+{
+	s32 cpu;
+
+	if (p->nr_cpus_allowed == 1 ||
+	    scx_bpf_test_and_clear_cpu_idle(prev_cpu))
+		return prev_cpu;
+
+	cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+	if (cpu >= 0)
+		return cpu;
+
+	return -1;
+}
+
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -137,17 +152,14 @@ s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		return -ESRCH;
 	}
 
-	if (p->nr_cpus_allowed == 1 ||
-	    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+	cpu = pick_direct_dispatch_cpu(p, prev_cpu);
+
+	if (cpu >= 0) {
 		tctx->force_local = true;
+		return cpu;
+	} else {
 		return prev_cpu;
 	}
-
-	cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
-	if (cpu >= 0)
-		return cpu;
-
-	return prev_cpu;
 }
 
 static int weight_to_idx(u32 weight)
@@ -172,6 +184,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	u32 pid = p->pid;
 	int idx = weight_to_idx(p->scx.weight);
 	void *ring;
+	s32 cpu;
 
 	if (p->flags & PF_KTHREAD) {
 		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
@@ -207,6 +220,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
+	/* if !WAKEUP, select_cpu() wasn't called, try direct dispatch */
+	if (!(enq_flags & SCX_ENQ_WAKEUP) &&
+	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >= 0) {
+		__sync_fetch_and_add(&nr_ddsp_from_enq, 1);
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, enq_flags);
+		return;
+	}
+
 	/*
 	 * If the task was re-enqueued due to the CPU being preempted by a
 	 * higher priority scheduling class, just re-enqueue the task directly
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 304f0488a386..c9ca30d62b2b 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -116,10 +116,11 @@ int main(int argc, char **argv)
 		long nr_enqueued = skel->bss->nr_enqueued;
 		long nr_dispatched = skel->bss->nr_dispatched;
 
-		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq=%"PRIu64" deq=%"PRIu64" core=%"PRIu64"\n",
+		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq=%"PRIu64" deq=%"PRIu64" core=%"PRIu64" enq_ddsp=%"PRIu64"\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
 		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
-		       skel->bss->nr_core_sched_execed);
+		       skel->bss->nr_core_sched_execed,
+		       skel->bss->nr_ddsp_from_enq);
 		if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
 			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
 			       skel->bss->cpuperf_min,
-- 
2.45.2


