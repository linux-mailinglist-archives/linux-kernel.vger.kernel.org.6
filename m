Return-Path: <linux-kernel+bounces-411795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835809CFFBA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E6D285C36
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33E42A92;
	Sat, 16 Nov 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2AmXO43"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A414F70
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772921; cv=none; b=bdhfixUs4sPQV5rCZnphHuRIqaJZywLHuJZtJZEfrc8gZb7heOnFYzrMHRuBvnZ8TQ/TKMF0Vv0MnytRipBQLKHFIsVoJa9y35lG5rquunLenuEanmMC1hiqbOpVXzeTPIhP0iuhiGoKBNz7YWgvx1onIvyG7DE3QZISaSQRek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772921; c=relaxed/simple;
	bh=0vd+HZzJ5k+fFsPT6iNDQixWz/Op/NOEpANZ9hcb6EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=py/BsDD0Pk+oh8rkJYNGCJeigcjCaUkJzPGKEZOGbyqsi7iVKnWc42GndaKP7oTK7h5fv0pcRblGQy9FLXWSor3Yeusgn06koLHd0yDvi16uBut/kuqZHLW93N1ZU+NIPtO2QKW8hFJ0gy92fOhJqhlm+b+jsvCJJM9/xh1lWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2AmXO43; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cb47387ceso30314095ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731772919; x=1732377719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuuWQGzQ1DfUt2ak4ZbC84lMZxrJ6yXnCz0y/5+ZzOA=;
        b=T2AmXO43hnCiwPMtv379vL5k7OjkIaDiasb8V5NE/o5vTlc4BaozgEoWWkPuT1NZsB
         0gegVtyjeT6GcDj56DOMGc4N0kjkFN07MeBNbBjx+7YAUoO964J8JoaOSEOAcdylDzg0
         +wua93HwuK4qSg+v00A2ODMdu0d6panpF7o87TKJxkuxbJsSWMzQiH/3lQ74hcMnZMhP
         J3fiCeAmHtBS2ClY5nRwuuxtoeItCcb9puS2eQa2IQHn6Me/YKX8CUpfjqv8RwExCB30
         dwy9Xvq4fcTRLi5THEPMoEmUwFUKwDBr4LupoVoTDZXtnXyh44Jm2KoMG8dVV3ieIYxJ
         kS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731772919; x=1732377719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuuWQGzQ1DfUt2ak4ZbC84lMZxrJ6yXnCz0y/5+ZzOA=;
        b=RlPprmro0Fnc35ck3Nc+upoRCTUtQttk09WEA0jco2AY1r0ApdiHTa+ajwbQEZya9M
         jGWQbhS2Wdk5U8TXmcaQypYg/TntQ8xfZF2hU4mPA2SFBWEhD5CTBNsHzxrAF1jjlZMA
         ZemS5nUoREk+iAkJcqsjFtqPFuzEowJppbVHt/QvTvpPjwaT45da5o9j/TIIbG3TlYxm
         I0lPVYlrwoPfs1Rn+qTOozxWXiSfvqEcq9TTkgRCOZ4+zkElufz7LLiTQkQPi6zbXuxN
         beWDTCPqHpyFsrVCPOuhyn/JTn0e4djoQ9V11VYw/xF0s1BSsmJZ2RVMeppf0nYJZ4Ps
         Rudg==
X-Forwarded-Encrypted: i=1; AJvYcCXwL8XnCYx11LlqotxqAxUnTxC6DH6hME0EdDbVowzLiaXv4KsPlQCcoVPCeCB4lLlJx798StyD1GeAm3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Ct0uWBBKKVHZUQZgIkOaiQa8orA6shXubQx8PXf3PQA+Na+m
	tKVue9SijJPJOZ44dbyU7ALw7ETvE9yR63G7WGlgorIWFLsUTw9Z
X-Google-Smtp-Source: AGHT+IF4zrtBHANffc8d0oZ84RIc2au55hvsJo3/mPDF1rpu4iZzgSVCVnsFyVvIm7hJ6KI2EtO/RA==
X-Received: by 2002:a17:903:2452:b0:20b:8776:4902 with SMTP id d9443c01a7336-211d0ebf325mr97950975ad.38.1731772919100;
        Sat, 16 Nov 2024 08:01:59 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34809sm28267705ad.124.2024.11.16.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 08:01:58 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] sched_ext: Implement scx_rq_clock_update/stale()
Date: Sun, 17 Nov 2024 01:01:22 +0900
Message-ID: <20241116160126.29454-2-changwoo@igalia.com>
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

scx_rq_clock_update() and scx_rq_clock_stale() manage the status of an
rq clock. scx_rq_clock_update() keeps the rq clock in memory and its
status valid. scx_rq_clock_stale() invalidates the current rq clock
not to use the cached rq clock.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/sched.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4d79804631e4..61efff790e24 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -754,6 +754,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_PENDING	= 1 << 2, /* balance hasn't run yet */
 	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
 	SCX_RQ_BYPASSING	= 1 << 4,
+	SCX_RQ_CLK_UPDATED	= 1 << 5, /* RQ clock is updated by the core */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,
@@ -765,6 +766,7 @@ struct scx_rq {
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
 	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
+	u64			clock;			/* cached per-rq clock -- see scx_bpf_clock_get_ns() */
 	u32			nr_running;
 	u32			flags;
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
@@ -1345,6 +1347,24 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static inline void scx_rq_clock_update(struct rq *rq, u64 clock)
+{
+	rq->scx.clock = clock;
+	rq->scx.flags |= SCX_RQ_CLK_UPDATED;
+}
+
+static inline void scx_rq_clock_stale(struct rq *rq)
+{
+	rq->scx.flags &= ~SCX_RQ_CLK_UPDATED;
+}
+
+#else
+static inline void scx_rq_clock_update(struct rq *rq, u64 clock) {}
+static inline void scx_rq_clock_stale(struct rq *rq) {}
+
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
-- 
2.47.0


