Return-Path: <linux-kernel+bounces-268515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FB59425A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A861C21570
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAE049641;
	Wed, 31 Jul 2024 05:14:47 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675349627
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722402887; cv=none; b=Tzc8F/gP3U4+JQ2cTOk2Aek2T+YZ0ZXKsh4OAVvSpjcBNzbA9Ii0/MJFOaVeaH2qsm9oZUcCJt+MShuALV32KqvZ86liMy86NJU0vtiNQuXDaRs535WAB1oMvhdeln3iFBvrSdCJUemRIErE/Sdh/nVxiKdu1RLWzebto/1Nics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722402887; c=relaxed/simple;
	bh=uJtTDGQ8nauawrJhdJj3WEDeVPsWNboIRs2m61CDv+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OU9rDNofjzWUJOLfQ+V5rCZ/PEBPfToJZ0H4Lqv12Omdnnms+w4hT1U0ow6U0zkCITisftrQDzBeYXtvClJtAORRpb7OHlV6koA0TczCWtb+6l7UB10YXINIQ9tNwt+e5WRuEdASux9u/g1zrEzJMDA1Nb8tcEFwjKNWGcS6G1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b5d3113168so31088436d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722402884; x=1723007684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNoK0GrssLWksu4p9mkhXhwaA9KwnCqyoww9sPtZ4Is=;
        b=H4mGQZYQYp/Gt4nbqISL78OIvwzeEc7CrzfhR/MV5TSLgNGxlcua6odSkJrqBt6ptD
         Eh+rDIK8MpRz/Bjr+kQ0dYRC/3JzW+LoF3orrXvwS+aLd6IuQXAhM7GbnT81QGjBwngc
         tKC12bR/5/Q5d2+qDN/GD3iENfRpVlH4cyhGmTORtmXpJEFQD+LAP9+44kcN/6Mip6Al
         /VJtBHR+0ov9PxR9Ltz+S4wQyN7QdipbacmCWXiDYQ03m6qf2vl7O6LW09pjeqi0TcE4
         zaBTZCgbkzZgUc2lBXED0BjxykYzki5YyVw3dzTchNx8P0BviS7vjt1+1uQZddgzwNIE
         gNew==
X-Gm-Message-State: AOJu0YwE2H+wzYYVc9VRpQ7JNNXzUNMB1foQu3qUH1uaJeIh0XWLeYfz
	hj2Z8p7ul2LX2cENFDLjKnAYLh/P09Z+Gfpf2PuOnogSTw5YhfWZ
X-Google-Smtp-Source: AGHT+IF3cJpLGMPAbaELp5rscIvC2y860pZgTn0AvOa9i0UNh7SNxYLQ8VineDfL+anmz/SNT1bKlA==
X-Received: by 2002:a05:6214:e45:b0:6bb:7bce:a203 with SMTP id 6a1803df08f44-6bb7bcea61bmr33351456d6.11.1722402883807;
        Tue, 30 Jul 2024 22:14:43 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8f83c9sm69731786d6.38.2024.07.30.22.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 22:14:43 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/2] scx: Allow calling sleepable kfuncs from BPF_PROG_TYPE_SYSCALL
Date: Wed, 31 Jul 2024 00:14:36 -0500
Message-ID: <20240731051437.69689-1-void@manifault.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently only allow calling sleepable scx kfuncs (i.e.
scx_bpf_create_dsq()) from BPF_PROG_TYPE_STRUCT_OPS progs. The idea here
was that we'd never have to call scx_bpf_create_dsq() outside of a
sched_ext struct_ops callback, but that might not actually be true. For
example, a scheduler could do something like the following:

1. Open and load (not yet attach) a scheduler skel

2. Synchronously call into a BPF_PROG_TYPE_SYSCALL prog from user space.
   For example, to initialize an LLC domain, or some other global,
   read-only state.

3. Attach the skel, which actually enables the scheduler

The advantage of doing this is that it can preclude having to do pretty
ugly boilerplate like initializing a read-only, statically sized array of
u64[]'s which the kernel consumes literally once at init time to then
create struct bpf_cpumask objects which are actually queried at runtime.

Doing the above is already possible given that we can invoke core BPF
kfuncs, such as bpf_cpumask_create(), from BPF_PROG_TYPE_SYSCALL progs. We
already allow many scx kfuncs to be called from BPF_PROG_TYPE_SYSCALL progs
(e.g. scx_bpf_kick_cpu()). Let's allow the sleepable kfuncs as well.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/sched/ext.h | 14 ++++++--------
 kernel/sched/ext.c        | 27 +++++++++++----------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 593d2f4909dd..26e1c33bc844 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -106,16 +106,14 @@ enum scx_ent_dsq_flags {
  * mechanism. See scx_kf_allow().
  */
 enum scx_kf_mask {
-	SCX_KF_UNLOCKED		= 0,	  /* not sleepable, not rq locked */
-	/* all non-sleepables may be nested inside SLEEPABLE */
-	SCX_KF_SLEEPABLE	= 1 << 0, /* sleepable init operations */
+	SCX_KF_UNLOCKED		= 0,	  /* sleepable and not rq locked */
 	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
-	SCX_KF_CPU_RELEASE	= 1 << 1, /* ops.cpu_release() */
+	SCX_KF_CPU_RELEASE	= 1 << 0, /* ops.cpu_release() */
 	/* ops.dequeue (in REST) may be nested inside DISPATCH */
-	SCX_KF_DISPATCH		= 1 << 2, /* ops.dispatch() */
-	SCX_KF_ENQUEUE		= 1 << 3, /* ops.enqueue() and ops.select_cpu() */
-	SCX_KF_SELECT_CPU	= 1 << 4, /* ops.select_cpu() */
-	SCX_KF_REST		= 1 << 5, /* other rq-locked operations */
+	SCX_KF_DISPATCH		= 1 << 1, /* ops.dispatch() */
+	SCX_KF_ENQUEUE		= 1 << 2, /* ops.enqueue() and ops.select_cpu() */
+	SCX_KF_SELECT_CPU	= 1 << 3, /* ops.select_cpu() */
+	SCX_KF_REST		= 1 << 4, /* other rq-locked operations */
 
 	__SCX_KF_RQ_LOCKED	= SCX_KF_CPU_RELEASE | SCX_KF_DISPATCH |
 				  SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index da9cac6b6cc2..4a07deb30c44 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1029,16 +1029,12 @@ static __always_inline bool scx_kf_allowed(u32 mask)
 		return false;
 	}
 
-	if (unlikely((mask & SCX_KF_SLEEPABLE) && in_interrupt())) {
-		scx_ops_error("sleepable kfunc called from non-sleepable context");
-		return false;
-	}
-
 	/*
 	 * Enforce nesting boundaries. e.g. A kfunc which can be called from
 	 * DISPATCH must not be called if we're running DEQUEUE which is nested
-	 * inside ops.dispatch(). We don't need to check the SCX_KF_SLEEPABLE
-	 * boundary thanks to the above in_interrupt() check.
+	 * inside ops.dispatch(). We don't need to check boundaries for any
+	 * blocking kfuncs as the verifier ensures they're only called from
+	 * sleepable progs.
 	 */
 	if (unlikely(highest_bit(mask) == SCX_KF_CPU_RELEASE &&
 		     (current->scx.kf_mask & higher_bits(SCX_KF_CPU_RELEASE)))) {
@@ -3224,9 +3220,9 @@ static void handle_hotplug(struct rq *rq, bool online)
 	atomic_long_inc(&scx_hotplug_seq);
 
 	if (online && SCX_HAS_OP(cpu_online))
-		SCX_CALL_OP(SCX_KF_SLEEPABLE, cpu_online, cpu);
+		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
 	else if (!online && SCX_HAS_OP(cpu_offline))
-		SCX_CALL_OP(SCX_KF_SLEEPABLE, cpu_offline, cpu);
+		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_offline, cpu);
 	else
 		scx_ops_exit(SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
 			     "cpu %d going %s, exiting scheduler", cpu,
@@ -3390,7 +3386,7 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 			.fork = fork,
 		};
 
-		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, init_task, p, &args);
+		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init_task, p, &args);
 		if (unlikely(ret)) {
 			ret = ops_sanitize_err("init_task", ret);
 			return ret;
@@ -4648,7 +4644,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	cpus_read_lock();
 
 	if (scx_ops.init) {
-		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, init);
+		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
 		if (ret) {
 			ret = ops_sanitize_err("init", ret);
 			goto err_disable_unlock_cpus;
@@ -5424,14 +5420,11 @@ __bpf_kfunc_start_defs();
  * @dsq_id: DSQ to create
  * @node: NUMA node to allocate from
  *
- * Create a custom DSQ identified by @dsq_id. Can be called from ops.init() and
- * ops.init_task().
+ * Create a custom DSQ identified by @dsq_id. Can be called from any sleepable
+ * scx callback, and any BPF_PROG_TYPE_SYSCALL prog.
  */
 __bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
 {
-	if (!scx_kf_allowed(SCX_KF_SLEEPABLE))
-		return -EINVAL;
-
 	if (unlikely(node >= (int)nr_node_ids ||
 		     (node < 0 && node != NUMA_NO_NODE)))
 		return -EINVAL;
@@ -6490,6 +6483,8 @@ static int __init scx_init(void)
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_sleepable)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					     &scx_kfunc_set_sleepable)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_select_cpu)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-- 
2.45.2


