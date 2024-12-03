Return-Path: <linux-kernel+bounces-429651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00839E1F1F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1022812B3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD9D1F6692;
	Tue,  3 Dec 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX8TeSaK"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96017BB16
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236109; cv=none; b=VRF8wM8eLldf/0YRaxyAvKqw10C5CWNjPCYBOhOQRRXmrgcB8bJ0chnbxVPdXBP8YhzAEP+rfQ0gKbAQNbEJvftLK7HKjqMJ5jzp9eXDxMqxTrHL33xvhdL3sv3Icteba9vyZfjoSk0zQZrv7JvtjtRhd1XWxy7KUpgv0ZICe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236109; c=relaxed/simple;
	bh=XP1bJ0NOVWvhnqquRkwIz/i6kZEfAZJaGcyYAhOVshM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPMRDwUloACJtzW7fNBxtQwmIzbEwZKw1ka1xkofsMpgxc2D1MtwWJpur5zod7TRxdR5ogeNlqOQlY6EToaiCkLXLFAGHaX+7ThWHt2LBRwcYp54jUGsGuR/gKSt9CO3VdBR2fQmztSH9HvjHDrL8PmOxZn+8L2sA0dIVXyCRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX8TeSaK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so5565560b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236107; x=1733840907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYP7n+ha6LjN/GOJcD6nH/LRPcnS5LKp91acoSKaYwA=;
        b=KX8TeSaKKOdi3b2+TSS43qbTOeHllSFBLiK05hpGvqEXFWbAPdPvbfCwalvrCZ5/Gy
         /mrbcZxAgM9las/nRtk02lNibEsCvbOE06sGReCCw8NuS6LH+cMhzQm/ecTjUCR9rv4h
         ovG3kb7YYlzO6ayuKu+bE4VM8HDdwShJSAf7eJJGSIPKn/YMwd+hyRToIUL3BZUKnCQw
         SVCEWtuEJgRN7lDdkMBLvsBUYzWzR2l/J8dvBxMup/Pp7Z9s5Cq5fsdUkrJhhBBSvQbm
         Dm2+kqB3iwbRJwNZnOPG0NuHQOc/3C5MN4XRdibtgL+dQjbP7UQPqq9s1x1+eflWQ3QA
         XNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236107; x=1733840907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYP7n+ha6LjN/GOJcD6nH/LRPcnS5LKp91acoSKaYwA=;
        b=YGsxAwleau1gabW06y3TZkpYvdrk5iGXz72H5JiaI1Xe3/6r2IektjrgoZiFcIBLUu
         wTVreMF+ARz2xf7Ni86BKJkNJlZ3o4jFCEbkBlBAywM7n85l7gXJWcsZtEqMrO0cLuzI
         IrnfXJlHShCj0aW203iKSMgRm1iDRRatvKuNuCidSx+37YLTarq6shru2OGIEpuf+hDK
         J5N1gi1iHAyvVHupCTWXHrSUPs+tP5alCqdhX20C1Ev6Nm4a++CopEWwLR8zUwqM0OPj
         /xTSjQROcu0D/1OIofp0Cc8MfZEKQEV7lfuRJCXjm3W23BCvy9oF3xYUzIaajfTViVmi
         P5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCURvtSmXxyfAnrWpSDlSd0EXjuALe+sfoJawcJ13aVWyppJyGSrNIEFhzhFqQMcnieULlXj1bLpQJA7N3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLDLTdmH/WPSebNat5I0eRKO411rkVFtr9wbmp58kIw1sqRPhf
	e5zTWh/ESs1+vV7USVR5YL/2f0lVO77MOY5cDstUo+g04H3pH6ox
X-Gm-Gg: ASbGnct8smVEI7jz0Xy5mAZ80V8pEIqA8ZjG/MeGRbntqUVV+Dw0hJlNGV4xW0Pb4qa
	oexX6PdB+HlT0M21ZC/kV7Cl5J8k7XLnWNBpdZT4+SxFByfiX02h/XqHONV0U+CDthkCaTwmd+p
	oTutvIYRM9X9CvcI9I+H8RY2poZxeMA7M2YBPpxwt2YTvViuL/qAMfjsDTcfp8ujcV5hsgCUIHu
	Br0CsVeEP5XNjJn0c2BgcX8mnJ7wWAEhB5mDDdByjrNvaTX9lRwaQjY5m5x4ZlnjN/p1h5+aAG5
	N74EeA==
X-Google-Smtp-Source: AGHT+IGzEvUFUhuv6DWW7JtgRJA5rpEQD9VBCT18VtfYwwYuviw9CPrCi9Odv+s0ttu7vLN4Mk4pGQ==
X-Received: by 2002:a17:90b:3e83:b0:2ee:b8ac:73c1 with SMTP id 98e67ed59e1d1-2ef011db5f7mr3511314a91.2.1733236106902;
        Tue, 03 Dec 2024 06:28:26 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eeaef494fcsm4686117a91.43.2024.12.03.06.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:28:26 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] sched_ext: Implement scx_bpf_clock_get_ns()
Date: Tue,  3 Dec 2024 23:28:00 +0900
Message-ID: <20241203142802.36305-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203142802.36305-1-changwoo@igalia.com>
References: <20241203142802.36305-1-changwoo@igalia.com>
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


