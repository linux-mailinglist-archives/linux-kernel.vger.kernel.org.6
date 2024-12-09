Return-Path: <linux-kernel+bounces-436826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706819E8B66
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30DE28160A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD073172BDC;
	Mon,  9 Dec 2024 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di1kgpx5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751E2147F8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724957; cv=none; b=imWv8XWWHlxa5TqiQe6QG7jg59Wi7deKOgYmUhFh1PjEXMENrhAE3HB1/DLRUSBf0D1RdDfacn/EgqoVzqCaSgbX4IYbKX35sSiwra3gDnezfo+2k2yjxAPkSTxIxUHjbqFOPO0qq3jWN9i+TrRYq7HJmIxLjcq1B3ZN5y/WvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724957; c=relaxed/simple;
	bh=MdDTxfGKx6bu9ZHjfydC1MEn4XRy5nf7GuWie5IjQzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8bnDvqWQe1qH6xI8rvhnC9NIgt+EU+Wcuh5qxaz9SuQmMZ8mFxCRU1nsZjBBdKcFxBQepVQnk9m1fYKRcTb4HxlRH6xVGaRVnDBVxOVSxRYLdGPesNQ8ANVcX5wUaOXRMrttzLs5fWhl7ILaOu8NNVJmxL6YujXwov17UqLSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di1kgpx5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21661be2c2dso944425ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733724953; x=1734329753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7kQonWe5l9Kh79FyLWu6pMklDdWxAHpXcrT/0oQHYM=;
        b=di1kgpx5COvCAir0jmH+q7hzUlbJaavEEbmpsh/unJmkN2XndGEoN1JssHZ0I2jPR2
         HpqH1FENwjzRsHGcp0U4rsRVgWhfcTUEI5gbk9cuV4WKntz0xEGhhzhH7SIjwwV32O+O
         VPFED8Uke1hHGv1AKJ0fcDhlfTckJE4apXHV8t6mROHOcyBk4xPrc33gfPRgIIQQ4y76
         b1SYca2ic3KfsFWxZN4Z4quy+xWcIrJ3QWu8IjkRg+GET5Z/y4ceII8WwPNjUsY1ybRM
         qmJpRuRD3hJJlN8ocRE/xy6IzLJmShldX+XB1yxTtJisKJxiwAGhGiswGGxzQzIHsaYh
         hLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733724953; x=1734329753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7kQonWe5l9Kh79FyLWu6pMklDdWxAHpXcrT/0oQHYM=;
        b=tnQFrVmP9Ws/9bgbupKXrx0zY0nVyJvU7rb96My0UKThgtLIY0+kJHBUH4lZjsgO7z
         A2MfpdcPuT8astK+KGw6fSMroDMaX6mwVNgMVkyCtzubNJyF3hi4V07/dUtHxSPQulrb
         sWJwQ8jVGfaStxvITgBLONcXieTdjPz8JUDDP4YQ29zWqoQOuo5jZ6AEPOFPaWxj0uXX
         ajBZx/05m+PPs/azDnmvBzGfweS79gawig27ACa+nPUIM0OHFs1UMGk38GhlSu4ezBNH
         sciy7zRjYX6tpKXXZ4IbXZCA/Nh+vtu58Sx8Wqtv7VnDsHXRDnD0ME/6V+zLasR1Y6Pa
         JfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVzYtyY9N/qVZDl3AsTaxJZPBpHMoYGkgfw8o+XXyoXAjGNIEjN7ndfWcSPs2tNDXPQS8b5vaHmHUair4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRlK3BhWKv5WUYXL/ou4lMaPxC4/NHv/sWg+fHrIaoawDvUw6
	RmgjNPaWuBIlak6YX1+IN4M3CQfBxPLHUuobvckJhf1Abe52KAUN
X-Gm-Gg: ASbGnct+n5z69uhW8H1b7mMWUTktMcfmoucOXt7mwKaWyQLqSHqIZXKeqqkW7unUUE2
	Sxwe46u+wxot6Rt/32o2ZOog5i4W9WjnhGfqpcL1Fd5E9ULabADErLs2og5gnJF4/rVwcwiP0y3
	nzuy6xTHgY+q7AHFaG/kBMmHMgBwiei0XWu2g9yeCAlDZaeKR2EG/B6LaT5tYteE85k0LwXYQV6
	rtyKfOj8FlHeXPi3RWkYLsxfOzXgSD7kf9M+7gio7wnFLMEcO5FmN5RKp/kfV8ONGwgHEYxdg+d
	Pufz4w==
X-Google-Smtp-Source: AGHT+IEXT8C2guc2VNHTufgL0ACYxl6+A7855+73rckfBd3nDSUWho4w2D8ilsy0bUA5bU6T1nndZg==
X-Received: by 2002:a17:902:ea02:b0:216:2b14:b625 with SMTP id d9443c01a7336-2162b14cdfamr132835015ad.31.1733724953257;
        Sun, 08 Dec 2024 22:15:53 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2165590a8ebsm6925375ad.271.2024.12.08.22.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:15:52 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] sched_ext: Implement scx_rq_clock_update/stale()
Date: Mon,  9 Dec 2024 15:15:27 +0900
Message-ID: <20241209061531.257531-3-changwoo@igalia.com>
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

scx_rq_clock_update() and scx_rq_clock_stale() manage the status of an
rq clock when sched_ext is enabled. scx_rq_clock_update() keeps the rq
clock in memory and its status valid. scx_rq_clock_stale() invalidates
the current rq clock not to use the cached rq clock.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/sched.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 440ecedf871b..7e71d8685fcc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -754,6 +754,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_PENDING	= 1 << 2, /* balance hasn't run yet */
 	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
 	SCX_RQ_BYPASSING	= 1 << 4,
+	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,
@@ -766,9 +767,11 @@ struct scx_rq {
 	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
-	u32			flags;
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
 	bool			cpu_released;
+	u32			flags;
+	u64			clock;			/* current per-rq clock -- see scx_bpf_now_ns() */
+	u64			prev_clock;		/* previous per-rq clock -- see scx_bpf_now_ns() */
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
@@ -1725,9 +1728,28 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
 
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
 #define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
+
+static inline void scx_rq_clock_update(struct rq *rq, u64 clock)
+{
+	if (scx_enabled()) {
+		rq->scx.prev_clock = rq->scx.clock;
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
 #else /* !CONFIG_SCHED_CLASS_EXT */
 #define scx_enabled()		false
 #define scx_switched_all()	false
+
+static inline void scx_rq_clock_update(struct rq *rq, u64 clock) {}
+static inline void scx_rq_clock_stale(struct rq *rq) {}
 #endif /* !CONFIG_SCHED_CLASS_EXT */
 
 /*
-- 
2.47.1


