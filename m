Return-Path: <linux-kernel+bounces-411798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BD49CFFBE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040982859FB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43901946A2;
	Sat, 16 Nov 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6MHBgVE"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F1191F9E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772929; cv=none; b=bgow8B1wvX/KiHnGUdXGm2bX3x2OJqz0ZMuRVgrM7sFcePNI3Baqok6fhKDozZj2xq7S/28hY6MQ9GXq1iZeqHaRHlXN6VrpeGoLRQ/uW1gc5sXeNA4+wiCnhlVjNMDIFveqmVfzePezR6EKC6ew9BfxkpxRcaqnw3rHeUPeopo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772929; c=relaxed/simple;
	bh=URoaSsWNsSTDBVnXKWM7IW6JYC7xxG/Zo/nPyLKGfmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Utj7Xy3ZzXGv5F9cdkieVVY5RlnkKrXxeoITW+cnnU1A9r1xLX0kvFtPh/HT7/yIyRXyjl7CBYmQz+8oYaf0qt2nUZzNU/l7vw0yhZh5WCOXkx98KYA4Ldq6PFGJq/8HiI7BGuIKxkiaYfiLQd6B/kwFB3+jHJamsRYn4Uw5BRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6MHBgVE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-72410cc7be9so2341245b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731772927; x=1732377727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMycY57gYsPds40IIgx8o+5491JCQvawYObZO7Q8XFI=;
        b=i6MHBgVE8LzYeh+rDZ8bcWGrbqktqn02pQs95G6o50+ribFMDQVFhGam5MHQPrSOIR
         YkkgcErM2WTL99jTNfnio42Ngv3j5HRjKl4K498aro6J3pxIWOUTXMPZvLRw2teRI/hn
         SvVxUwhGpdtz/iBZ7GCE6aQDUGIcYYPcyjNhs1kAeKHBw4RQxrRX2dAOf8DJjQsvOGeg
         b5RAFCkqh010gXOkzvfNpxwl0QhugdudB/hztnhjvc1iWhV6zxKbNydVpMa/a6INi8xh
         CQ6m4QTGS9eTfVqAR7SOOXW8jdoWa9c7AdptRBjFAnvu+N7Xc97g6uIkz6t3rbRMENRe
         TG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731772927; x=1732377727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMycY57gYsPds40IIgx8o+5491JCQvawYObZO7Q8XFI=;
        b=J9GLP4oqayXUo439FJy0M5c3h0AFEZplMcKy+1GQQvDyA4eWMNvVZVLZX9q5BoVBr5
         7avBM8qIoih7hpsEjfFj2Q8bzuYXge8xg5hbMePSoJVx6O4zpMF1UnJZh1phwIISehAm
         QopH3N9xWNppn2pinrVLpI7JINgSHGPzIXZd6HRgJwUQR29lhwdM4cDjklhjZHizRrym
         hvjKx4qjdtow2yLKOZ7Tp1TOX75+19jhPE4th3gqpKw/ALyJq0L0DZoEvgF3UoZ03Fc2
         /nCMhSEkvT9I7lNpLNbpiyGhXhndZd3WxehtcKoxrn7ZSFYim1AT4z8EWOgm1KiFqjv0
         5Pfg==
X-Forwarded-Encrypted: i=1; AJvYcCVrD1Rj74OjzT4jHSp97cl7yjyKVoeY+NAR8w+LCJZoWO1C0EUyIilodb1++M5Vn8QNcewhr+FpUQRUiTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVGt8C76fDI72dWg/SgQZSG0oHgsjZsUD/c7fioRTOpJ+KdpI
	EMQ/R2S2DlEiST7ViusVbtq5FM/9JpIZlPwEPFnAi+zCunQKHPif
X-Google-Smtp-Source: AGHT+IE+DCkEW3YrSTAVNT5/vS7NbVd6a7tuTAH7r7kjprhrp2a0mchf2rouZw05bxQPg+RJhdFpxA==
X-Received: by 2002:a17:90b:3504:b0:2ea:4150:3f71 with SMTP id 98e67ed59e1d1-2ea415042cfmr2204374a91.14.1731772926543;
        Sat, 16 Nov 2024 08:02:06 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca518sm29315795ad.88.2024.11.16.08.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 08:02:06 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sched_ext: Implement scx_bpf_clock_get_ns()
Date: Sun, 17 Nov 2024 01:01:24 +0900
Message-ID: <20241116160126.29454-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116160126.29454-1-changwoo@igalia.com>
References: <20241116160126.29454-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returns a high-performance monotonically non-decreasing clock for the
current CPU. The clock returned is in nanoseconds.

It provides the following properties:

1) High performance: Many BPF schedulers call bpf_ktime_get_ns()
 frequently to account for execution time and track tasks' runtime
 properties. Unfortunately, in some hardware platforms, bpf_ktime_get_ns()
 -- which eventually reads a hardware timestamp counter -- is neither
 performant nor scalable. scx_bpf_clock_get_ns() aims to provide a
 high-performance clock by using the rq clock in the scheduler core
 whenever possible.

2) High enough resolution for the BPF scheduler use cases: In most BPF
 scheduler use cases, the required clock resolution is lower than the
 most accurate hardware clock (e.g., rdtsc in x86). scx_bpf_clock_get_ns()
 basically uses the rq clock in the scheduler core whenever it is valid.
 It considers that the rq clock is valid from the time the rq clock is
 updated (update_rq_clock) until the rq is unlocked (rq_unpin_lock).
 In addition, it invalidates the rq clock after long operations --
 ops.running() and ops.update_idle() -- in the BPF scheduler.

3) Monotonically non-decreasing clock for the same CPU:
 scx_bpf_clock_get_ns() guarantees the clock never goes backward when
 comparing them in the same CPU. On the other hand, when comparing clocks
 in different CPUs, there is no such guarantee -- the clock can go backward.
 It provides a monotonically *non-decreasing* clock so that it would provide
 the same clock values in two different scx_bpf_clock_get_ns() calls in the
 same CPU during the same period of when the rq clock is valid.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b8ad776ef516..b0374274ead2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7541,6 +7541,76 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
 }
 #endif
 
+/**
+ * scx_bpf_clock_get_ns - Returns a high-performance monotonically
+ * non-decreasing clock for the current CPU. The clock returned is in
+ * nanoseconds.
+ *
+ * It provides the following properties:
+ *
+ * 1) High performance: Many BPF schedulers call bpf_ktime_get_ns() frequently
+ *  to account for execution time and track tasks' runtime properties.
+ *  Unfortunately, in some hardware platforms, bpf_ktime_get_ns() -- which
+ *  eventually reads a hardware timestamp counter -- is neither performant nor
+ *  scalable. scx_bpf_clock_get_ns() aims to provide a high-performance clock
+ *  by using the rq clock in the scheduler core whenever possible.
+ *
+ * 2) High enough resolution for the BPF scheduler use cases: In most BPF
+ *  scheduler use cases, the required clock resolution is lower than the most
+ *  accurate hardware clock (e.g., rdtsc in x86). scx_bpf_clock_get_ns()
+ *  basically uses the rq clock in the scheduler core whenever it is valid.
+ *  It considers that the rq clock is valid from the time the rq clock is
+ *  updated (update_rq_clock) until the rq is unlocked (rq_unpin_lock).
+ *  In addition, it invalidates the rq clock after long operations --
+ *  ops.running() and ops.update_idle().
+ *
+ * 3) Monotonically non-decreasing clock for the same CPU:
+ *  scx_bpf_clock_get_ns() guarantees the clock never goes backward when
+ *  comparing them in the same CPU. On the other hand, when comparing clocks
+ *  in different CPUs, there is no such guarantee -- the clock can go backward.
+ *  It provides a monotonically *non-decreasing* clock so that it would provide
+ *  the same clock values in two different scx_bpf_clock_get_ns() calls in the
+ *  same CPU during the same period of when the rq clock is valid.
+ */
+__bpf_kfunc u64 scx_bpf_clock_get_ns(void)
+{
+	static DEFINE_PER_CPU(u64, prev_clk);
+	struct rq *rq = this_rq();
+	u64 pr_clk, cr_clk;
+
+	preempt_disable();
+	pr_clk = __this_cpu_read(prev_clk);
+
+	/*
+	 * If the rq clock is invalid, start a new rq clock period
+	 * with a fresh sched_clock().
+	 */
+	if (!(rq->scx.flags & SCX_RQ_CLK_UPDATED)) {
+		cr_clk = sched_clock();
+		scx_rq_clock_update(rq, cr_clk);
+	}
+	/*
+	 * If the rq clock is valid, use the cached rq clock
+	 * whenever the clock does not go backward.
+	 */
+	else {
+		cr_clk = rq->scx.clock;
+		/*
+		 * If the clock goes backward, start a new rq clock period
+		 * with a fresh sched_clock().
+		 */
+		if (pr_clk > cr_clk) {
+			cr_clk = sched_clock();
+			scx_rq_clock_update(rq, cr_clk);
+		}
+	}
+
+	__this_cpu_write(prev_clk, cr_clk);
+	preempt_enable();
+
+	return cr_clk;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
@@ -7572,6 +7642,7 @@ BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
+BTF_ID_FLAGS(func, scx_bpf_clock_get_ns)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
-- 
2.47.0


