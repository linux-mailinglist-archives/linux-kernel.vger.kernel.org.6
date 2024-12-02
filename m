Return-Path: <linux-kernel+bounces-426911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347759DF9FE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E082B21E05
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403131F8EE2;
	Mon,  2 Dec 2024 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdkUCGRM"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A71F8AF8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114356; cv=none; b=OjkYE/MRp0LPHb9ote/x2T/ioTtGS5Qqdz2W0yiKa83Ls9RTV0W6OwPpX+LjhT0SW6KAxGtscB3Asv+5zdYO0OeeastL6ezHP+Y4waSN/bRLykwmnopEBl0rXK9GnHke6XpcpZYnyt7FeXRZY8Et5n396PUYswlqmM8Z6RC6Vkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114356; c=relaxed/simple;
	bh=XP1bJ0NOVWvhnqquRkwIz/i6kZEfAZJaGcyYAhOVshM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFg6T4ng0aTyjRnjSfaVqpXY/asvruZKaB2M6evy5aXDzfXAk3emVCyuW1+jFszZFvTRjgkCdIwKdTQU2vLezHPwCMjJeMAonVc6BBGtA13VSU++0vuN/agQsd/D61ftUrDwZVc6FTZaeyp8sy/2s2IOZTCJZ4RlExzGD/wsQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdkUCGRM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21278f3d547so26321895ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733114354; x=1733719154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYP7n+ha6LjN/GOJcD6nH/LRPcnS5LKp91acoSKaYwA=;
        b=hdkUCGRMaSa4fXHnd2QG0ty62d5B5aMI/N7lUXrkC1ukFqmPT/60rOR9QAGfsHzeLo
         DUEclfSdRjl1Lghn3FLTMuv2H71hkh43g2DG08SHIPmepKDDO2u2srjOc0CKaUb8xBiE
         cNaGu8TLuG/OmhqU4J1omHEEeeB3JQytKyiITgmKsgVNUGhwn2OZZ2G4nOfeT8gXv8G2
         9KuW22q/oarAcyCRWx/mP8oS/JW9bS2WDgpScjExMJqD0F5j0htDDznVyiCjs4OZIoxr
         m/syWsjImcoIPCUcBi3cVkNXe1XI9pyH+ibniw7oqXZQTLyB53qGo15EEnpSLFnpmCbi
         Ffxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733114354; x=1733719154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYP7n+ha6LjN/GOJcD6nH/LRPcnS5LKp91acoSKaYwA=;
        b=Zjq3Z6aoW/38IRn67cm5jQ2ptI1gVAux6gfFsiVapu+DHaKBsqzDFctcb8jXNfxt1v
         cAL85Mn68Eqs30sWnRoMrrQkYSQwurf3nhOrHbcFEo6/o28SDCsL6Cp1kJgO7Xl+YBts
         dAtlI+x/cHbyZUY0J1gUbZPndSgXR5eBnfLR09FftKAVvSbmZw4mPkuxrzGIto3cukQz
         FA7erasn+9PE3oOZ7KTF0tMPW45jMTDYiNf2Y2Cpp7z8zq0HIiZCHUs2RApBmOd2cN3Q
         ZlZ31CGrFfS8Qg0lTCgq3/vLK6/7KQUKKyCHh99D99rpExkfdmGaUoXCOtwZfMXVrrSu
         im2A==
X-Forwarded-Encrypted: i=1; AJvYcCXrSTd6CK709v3Ohj+rbigcMIc3fknHPZliyY/1o7fIFZIuq7EvbBo1w8UOBAnN8XDhSIbQklyxVubIrNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKdkSys6wlJt2N3IbAxXA0y3I9RCp2Y5TltYgNV3sBXPFQ26y
	Spl2XOLceSU6y52hxW0szFJhWZ7PKo3LQwUeeaBCJu+7q1kTpiDqceKChw==
X-Gm-Gg: ASbGncul+nki5YV0OQu0R37klyTa9uVZU++lPI2f3m7FI03wSQ1M7GNTKpe59zJtmn4
	vPLYiU4TxQatZCG6QUIEv6LH7/0LpDIgYGZPWCKIHGFkxg5qE1AdvNMI6X7EUFhpuM+kQQZ1KRL
	0WT4O4OW1foM7sPyqEWQRvyQoA5HrNnuFzanfFfXjBfc/YfRrngCpX+Y8kJl28Ikkmnppb8msBa
	G3kuQnHxRKZWiVvMPfE8pk+LWWo1FQKI6KYGdScN+ZDiP4P/xo095gDCvPoDZVDwt4kwFlR0iRb
	rmusyw==
X-Google-Smtp-Source: AGHT+IEFxIWH9QkSFx4XNnPAXcBlCInFklU5TuiP5Qu3WROvroPGS3bMMGVM142hlGMVJZTxZR+0qQ==
X-Received: by 2002:a17:902:c951:b0:215:75ca:6a0 with SMTP id d9443c01a7336-21575ca0788mr91397875ad.29.1733114354199;
        Sun, 01 Dec 2024 20:39:14 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f25easm66759555ad.27.2024.12.01.20.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:39:13 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] sched_ext: Implement scx_bpf_clock_get_ns()
Date: Mon,  2 Dec 2024 13:38:47 +0900
Message-ID: <20241202043849.1465664-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202043849.1465664-1-changwoo@igalia.com>
References: <20241202043849.1465664-1-changwoo@igalia.com>
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
 ops.running() and ops.update_idle() -- in a BPF scheduler.

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
index ac279a657d50..9e2656e21593 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7546,6 +7546,76 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
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
+	if (!(rq->scx.flags & SCX_RQ_CLK_VALID)) {
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
@@ -7577,6 +7647,7 @@ BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
+BTF_ID_FLAGS(func, scx_bpf_clock_get_ns)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
-- 
2.47.1


