Return-Path: <linux-kernel+bounces-429649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E39E1F1D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A38A2816B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0564A1F6671;
	Tue,  3 Dec 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fip9F796"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAD1F6666
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236096; cv=none; b=LRmYYpZosjU3saObNGSsd9qyAq1uQbm3h5ydaLVydVGd3ZGTGvSGxbEzOMPp6yBByqlctOU6wmgZ4UPLpyS6P/Wjjm+nqaWbHDv/h1swJ2jhIWT7ZicEP64SCTCIM8MfOcZErrYYZFBoClBTIgBFb1nlQAWLr2dPelJ619gqP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236096; c=relaxed/simple;
	bh=h2dIVnJ81F6uZYP1oUnf4CrFDhfMx5vUHlJpCOdGz8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RP834N++MM25Z2Q0P9yZI/n5HGqYkKO99ZwxbFIXw240oIhvb5t/6/lr35aachxI147/WW6L9yut2MP5B5zOjEalAwJW7dlhnjAaOlGOBCnMYUSDz4qTyxC21sYwi1zqYyuvxi1+byI8DPtUxstyUK3bOmuQdyL++h4CzUSSy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fip9F796; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so5291108a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236094; x=1733840894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXY9UT8RCb6a4PX7hbXExEdtMGrEre1BV6m7kXEjMlk=;
        b=fip9F796pGZWoWkn3/At2TZcl0I3wQyNiBGT5tJpk2Npm1JaYg1mNyIgJO9MZ0naEG
         aD/+xWkuIP4i8ahT/AVMzD519UZgaawJztXT+p+F+6fZ/LbnwR92aKBDTgiMs5X9r4D5
         VX2exRzg0dGX8uOa/lly5vV8qQgjV9LlbfnQeN2G20xVqIrEJ4985Iabc1yaBhZ9qeoQ
         gflFGTNsYDEEMkSOMs7ZTuwxmXesSmt+DzmZKgA7DNqC9VfWeYkLsBFZP3Le3/zt+stW
         dKgHuncUm2LE5QC/2QCAW0w2Dqs7gNJdZGsyVJSgEEtIq590G4htKoQ+ay9ai/4nkObx
         Fvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236094; x=1733840894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXY9UT8RCb6a4PX7hbXExEdtMGrEre1BV6m7kXEjMlk=;
        b=fvqaZiMjSvlc/9DhhObmxhYp0X1iDoEGPtz8ldQEZnokeRKRsfRBpxq2biyBV7W1Ay
         7XlvbV/PX8AFpj9rsW5dveH6oXITmWbJT+wyLv5flgUi1EgMD7CWDl1ueGKp1Po/BiO+
         4aPd8HNMREcpFNRzGbIz13tkGqfD11/d9wozGdE87ioIdPpnC1CDyO+p0lE0u61iMPF6
         LQOIHr9kTdeAqkOJHrOznsixV5ksXaY92Rl5IuHbnb5zGA54ROlTWiARD4vgCulcmtmt
         Aer4HpHwpiPTiqbcLyCzM44S0/3ZBYRmVVwZtFT3otrsMXP70L+B9m1gANkHKNxEKdqA
         5Kpw==
X-Forwarded-Encrypted: i=1; AJvYcCVZMNnIId/8q+0Qc1AgUKbE1loneneJjiCSTtFlwJ10aCoqpMDiMCpz/vbdUi/bwxwjzvYjeJ4VmjNjzvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/oteuHLJBgOPQbRHRpQnW0Gd4X6+OeE+IUwTvu9jgleSzurp
	pHPh2JsjBS0W6actMRlmNUlHmJ5N2rlFN3oQ+U83o1Ds7mxwt+mvYDpspQ==
X-Gm-Gg: ASbGncv5zZBa7O2VH7k0+OaQxlIf4QkGyVof4BHAfa6uU+gfSo5tOVTYuTAUootJyVd
	92Ia3/Xn5UMGoARThEn8rvNSGVWjGNKpebQFyxJJL+qhMoYamdC7tcXzIL3Um8+Mg9KN+mhiD2a
	Kv1p2X3CrE786jN9lMNXKU+bCPW75Tnq8NTYNyhCu2lD6MZJ1UhXj8voNk8Eju83GdhUzDWxPv3
	UoapwNR3panDpRSDEuo3JUW8fBxAmxv1UEjtW0ZBp05oknsytQerPMcdzdbzjJ5NaV3FLaG2lzo
	QSJUZQ==
X-Google-Smtp-Source: AGHT+IE/KLhiic7WhAdlfQP7doDfiMSi12yMUnE+eYYoKvVI13GcDPjDKhryrlonfGZ4i4a7vfkvlw==
X-Received: by 2002:a05:6a20:6a28:b0:1db:f01a:cf12 with SMTP id adf61e73a8af0-1e1653f28e6mr3848305637.34.1733236093907;
        Tue, 03 Dec 2024 06:28:13 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849be0sm10481757b3a.198.2024.12.03.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:28:13 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] sched_ext: Implement scx_rq_clock_update/stale()
Date: Tue,  3 Dec 2024 23:27:58 +0900
Message-ID: <20241203142802.36305-2-changwoo@igalia.com>
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

scx_rq_clock_update() and scx_rq_clock_stale() manage the status of an
rq clock when sched_ext is enabled. scx_rq_clock_update() keeps the rq
clock in memory and its status valid. scx_rq_clock_stale() invalidates
the current rq clock not to use the cached rq clock.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/sched.h | 48 +++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76f5f53a645f..da55b39c9e58 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -754,6 +754,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_PENDING	= 1 << 2, /* balance hasn't run yet */
 	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
 	SCX_RQ_BYPASSING	= 1 << 4,
+	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,
@@ -766,8 +767,9 @@ struct scx_rq {
 	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
-	u32			flags;
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
+	u64			clock;			/* cached per-rq clock -- see scx_bpf_clock_get_ns() */
+	u32			flags;
 	bool			cpu_released;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
@@ -1717,6 +1719,37 @@ struct rq_flags {
 
 extern struct balance_callback balance_push_callback;
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+extern const struct sched_class ext_sched_class;
+
+DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);	/* SCX BPF scheduler loaded */
+DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
+
+#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
+#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
+
+static inline void scx_rq_clock_update(struct rq *rq, u64 clock)
+{
+	if (scx_enabled()) {
+		rq->scx.clock = clock;
+		rq->scx.flags |= SCX_RQ_CLK_VALID;
+	}
+}
+
+static inline void scx_rq_clock_stale(struct rq *rq)
+{
+	if (scx_enabled())
+		rq->scx.flags &= ~SCX_RQ_CLK_VALID;
+}
+
+#else /* !CONFIG_SCHED_CLASS_EXT */
+#define scx_enabled()		false
+#define scx_switched_all()	false
+
+static inline void scx_rq_clock_update(struct rq *rq, u64 clock) {}
+static inline void scx_rq_clock_stale(struct rq *rq) {}
+#endif /* !CONFIG_SCHED_CLASS_EXT */
+
 /*
  * Lockdep annotation that avoids accidental unlocks; it's like a
  * sticky/continuous lockdep_assert_held().
@@ -2505,19 +2538,6 @@ extern const struct sched_class rt_sched_class;
 extern const struct sched_class fair_sched_class;
 extern const struct sched_class idle_sched_class;
 
-#ifdef CONFIG_SCHED_CLASS_EXT
-extern const struct sched_class ext_sched_class;
-
-DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);	/* SCX BPF scheduler loaded */
-DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
-
-#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
-#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
-#else /* !CONFIG_SCHED_CLASS_EXT */
-#define scx_enabled()		false
-#define scx_switched_all()	false
-#endif /* !CONFIG_SCHED_CLASS_EXT */
-
 /*
  * Iterate only active classes. SCX can take over all fair tasks or be
  * completely disabled. If the former, skip fair. If the latter, skip SCX.
-- 
2.47.1


