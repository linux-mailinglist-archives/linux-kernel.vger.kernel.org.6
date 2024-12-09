Return-Path: <linux-kernel+bounces-436828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0571A9E8B68
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB21428108E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F092147EC;
	Mon,  9 Dec 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2SP04cd"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61CB2147F8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724962; cv=none; b=ioPn3hoV9EDd+i+QDl60DAc5Y8+HHK8uXTGQ/6UXPDOPqDmDPxmV4ZI/W7VB37StDfc9+tVIm1cs3oiaiM9NuzUWZgUOUkzO76WlCrYUE6kto/BP/M3iNPh5h7y9SbdFig8e44RqmEJHW2GCi4u/31uCsNdKuH2mqXjAlwFIC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724962; c=relaxed/simple;
	bh=PN6Iw3Dxk3S0kVn76rQkvmuHIz9L20xles6S0U2u3jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvOFbUKx3Ynq1p5PGjc/EHL+5DUnFxYgIPRyur0ulKtIxmac+cOv/1k7s4/edKDG+Pa3bnYjDLTKixbJQ0O13wgAfzIbbSXCozF2xZ5O2MTJwttUhl45gKfCVdTWV1ls5Hnujrm1KQFYhminyddejJXNB0Q3f7n+JLvsudblmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2SP04cd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2165448243fso4665745ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733724960; x=1734329760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEf8zUxGouueZslZOLUKni+ZjYVAncqMk9D3zvb5k7I=;
        b=O2SP04cdZNS/9R18CQaN5qVNYfa8nKWnb9fDQsIS0VK3eRdDTxEz+LBhrqw6mwO66k
         hecL/GDfEnTnJTuaxVb4Te+l1K3ZcZKE3wGJC0KU6xkLm2e/XijJLOKt9PklypY5K3v9
         /SCm3vXY2AfhbyNgS1al9PQUv+ephNhqu+BF+GKTEq7a06Gh4QJzN8gyFp2cGNhte1lp
         +UdOsGjemOLVTRcampWi5DHmHTAH/15XBTVp8Vgnarnl64lc54toD/LB4lha8iwhsYdK
         9MncT/PXqoptenJUAhCFI3m7wsHcLc+qvRiI2OXFcpUQJRoA2Pk/K+N/+kT1H/EsLx7I
         VHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733724960; x=1734329760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEf8zUxGouueZslZOLUKni+ZjYVAncqMk9D3zvb5k7I=;
        b=lA2wk0UVIEqfzVa7sAiUduXzlirAEmWuKqgRNBzVUS9dPPx8SCW32+I1BUPlMtJiGk
         1Jg+XP4fQJK+gDkdYnpzEIi1XygPqwYBVFevJ+6lqWyvhO5xDJUty11QVcuFxCAPWBil
         NZiT9duYWX5IuNGI7ArjfS9LuY5LRCLAeYAQMGtO5YF02WyKkXUl9xloeXqU9oqT+fVZ
         44TpGwQbuoubq9/94YuOaZzgwE5YhiAxY6gUuxO2jKpVOka3vx0MUjKztoQOjjsLcH+S
         6cDyilQ1daCD+wVUlzoBas07kRc399W+XjBgqqR/eWkfF0GB4v/ViXX5SMkPorT7Z3jE
         pKYw==
X-Forwarded-Encrypted: i=1; AJvYcCXM8kNva8Vnx9peZQNNkINdsk7oIy3U2dyQ6vmHMHhlUtTT6crtO+OCCTbtdLV+6440qLK5R5JlCU4xmDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fyMuBiv9tI3oebb17w+BCUpuGe6AKIJB1qzoxZP/kIq52x51
	oXh0sds7Dc0ghzowuGJIebrKOYXPEfuSgegF95ujDpsTGryVblfkgsoFZQ==
X-Gm-Gg: ASbGncvxzbY10NURCJ2pjUOlZGIZ5R2o3ZFM1SXPjtZMqYaatm8ignALVvR+mlcQW3D
	NGjdwGoMvtIvejhIvZaBJQchmSRM+RwZXiAR3wmR4xY9o2i/RvEcPsiUxa6FJq5nTMNLKTHfGcM
	CsZcV7aMMghZo1kHmQNgHXJPGjjWNUrCXeA+w8hU98Be7qpOflxCyGSAV69xxJNA0sMBZFOeMrn
	1053cHsHUp+N+5CexmkAHNKraTDVEIaeBeUNiv4awF9mWfFaqPdpPEiH3DEAJjzqA4yc2Kyt4Ay
	yGsAvQ==
X-Google-Smtp-Source: AGHT+IG64B1UnDqQhghjhSxh2tq6nF1Qq6Q36HyIm9VCwWqhe+o/79OCTs4qHrK3v0UWINjE8lBzBg==
X-Received: by 2002:a17:902:d2c1:b0:216:4676:dfaf with SMTP id d9443c01a7336-2164676e34amr55038175ad.34.1733724959859;
        Sun, 08 Dec 2024 22:15:59 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162e22d4besm31147575ad.230.2024.12.08.22.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:15:59 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] sched_ext: Implement scx_bpf_now_ns()
Date: Mon,  9 Dec 2024 15:15:29 +0900
Message-ID: <20241209061531.257531-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209061531.257531-1-changwoo@igalia.com>
References: <20241209061531.257531-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returns a high-performance monotonically non-decreasing clock for the current
CPU. The clock returned is in nanoseconds.

It provides the following properties:

1) High performance: Many BPF schedulers call bpf_ktime_get_ns() frequently
 to account for execution time and track tasks' runtime properties.
 Unfortunately, in some hardware platforms, bpf_ktime_get_ns() -- which
 eventually reads a hardware timestamp counter -- is neither performant nor
 scalable. scx_bpf_now_ns() aims to provide a high-performance clock by
 using the rq clock in the scheduler core whenever possible.

2) High enough resolution for the BPF scheduler use cases: In most BPF
 scheduler use cases, the required clock resolution is lower than the most
 accurate hardware clock (e.g., rdtsc in x86). scx_bpf_now_ns() basically
 uses the rq clock in the scheduler core whenever it is valid. It considers
 that the rq clock is valid from the time the rq clock is updated
 (update_rq_clock) until the rq is unlocked (rq_unpin_lock).

3) Monotonically non-decreasing clock for the same CPU: scx_bpf_now_ns()
 guarantees the clock never goes backward when comparing them in the same
 CPU. On the other hand, when comparing clocks in different CPUs, there
 is no such guarantee -- the clock can go backward. It provides a
 monotonically *non-decreasing* clock so that it would provide the same
 clock values in two different scx_bpf_now_ns() calls in the same CPU
 during the same period of when the rq clock is valid.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 71342f3719c1..f0476d5dd6f5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7601,6 +7601,78 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
 }
 #endif
 
+/**
+ * scx_bpf_now_ns - Returns a high-performance monotonically non-decreasing
+ * clock for the current CPU. The clock returned is in nanoseconds.
+ *
+ * It provides the following properties:
+ *
+ * 1) High performance: Many BPF schedulers call bpf_ktime_get_ns() frequently
+ *  to account for execution time and track tasks' runtime properties.
+ *  Unfortunately, in some hardware platforms, bpf_ktime_get_ns() -- which
+ *  eventually reads a hardware timestamp counter -- is neither performant nor
+ *  scalable. scx_bpf_now_ns() aims to provide a high-performance clock by
+ *  using the rq clock in the scheduler core whenever possible.
+ *
+ * 2) High enough resolution for the BPF scheduler use cases: In most BPF
+ *  scheduler use cases, the required clock resolution is lower than the most
+ *  accurate hardware clock (e.g., rdtsc in x86). scx_bpf_now_ns() basically
+ *  uses the rq clock in the scheduler core whenever it is valid. It considers
+ *  that the rq clock is valid from the time the rq clock is updated
+ *  (update_rq_clock) until the rq is unlocked (rq_unpin_lock).
+ *
+ * 3) Monotonically non-decreasing clock for the same CPU: scx_bpf_now_ns()
+ *  guarantees the clock never goes backward when comparing them in the same
+ *  CPU. On the other hand, when comparing clocks in different CPUs, there
+ *  is no such guarantee -- the clock can go backward. It provides a
+ *  monotonically *non-decreasing* clock so that it would provide the same
+ *  clock values in two different scx_bpf_now_ns() calls in the same CPU
+ *  during the same period of when the rq clock is valid.
+ */
+__bpf_kfunc u64 scx_bpf_now_ns(void)
+{
+	struct rq *rq;
+	u64 clock;
+
+	preempt_disable();
+
+	/*
+	 * If the rq clock is valid, use the cached rq clock
+	 * whenever the clock does not go backward.
+	 */
+	rq = this_rq();
+	clock = rq->scx.clock;
+
+	if (!(rq->scx.flags & SCX_RQ_CLK_VALID) ||
+	    (rq->scx.prev_clock >= clock)) {
+		/*
+		 * If the rq clock is invalid or goes backward,
+		 * start a new rq clock period with a fresh sched_clock_cpu().
+		 *
+		 * The cached rq clock can go backward because there is a
+		 * race with a timer interrupt. Suppose that a timer interrupt
+		 * occurred while running scx_bpf_now_ns() *after* reading the
+		 * rq clock and *before* comparing the if condition. The timer
+		 * interrupt will eventually call a BPF scheduler's ops.tick(),
+		 * and the BPF scheduler can call scx_bpf_now_ns(). Since the
+		 * scheduler core updates the rq clock before calling
+		 * ops.tick(), the scx_bpf_now_ns() call will get the fresh
+		 * clock. After handling the timer interrupt, the interrupted
+		 * scx_bpf_now_ns() will be resumed, so the if condition will
+		 * be compared. In this case, the clock, which was read before
+		 * the timer interrupt, will be the same as rq->scx.prev_clock.
+		 * When such a case is detected, start a new rq clock period
+		 * with a fresh sched_clock_cpu().
+		 */
+		clock = sched_clock_cpu(cpu_of(rq));
+		scx_rq_clock_update(rq, clock);
+	}
+
+	preempt_enable();
+
+	return clock;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
@@ -7632,6 +7704,7 @@ BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
+BTF_ID_FLAGS(func, scx_bpf_now_ns)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
-- 
2.47.1


