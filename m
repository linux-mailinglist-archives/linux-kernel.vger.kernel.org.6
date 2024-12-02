Return-Path: <linux-kernel+bounces-426909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C169DF9FC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BAE162DFA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4274A1D6DBE;
	Mon,  2 Dec 2024 04:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu5VadXH"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7428399
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114347; cv=none; b=NS9W66NT3VIvHhh3MaLwwjo+Dg1TgBK9EA9f2uTbwsYHVdE5nvtEGyinHvoyKFqmma2rrvU4AFLKJEv9fTwn2sRTtcD3oabzV5CDAwCr6kHLhCEJOpGKR3R/a2sE9qHYbCNh0do9lkik+5juB65NKaCwbbQ7SgXbxW5I5Jr1k5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114347; c=relaxed/simple;
	bh=pPlr8cBAY8ZlWbRFSuS5YgZiPfbogN78FxsS+StV5ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPDw7N9PMcNZXdy8/n1DJLmTQhG/LkYJH9PTMEtksjWtB6AC24VWMhpeos8l6MrAFGgv8H1v0OZ8EUGXrqnqc/RZRASV5pJz3JF/3kY+m2euIGrKdbDRwL2Ytmw5Ucjt6R0cELcd+NuG5ejczQNFRikuxbIw4q/UhlsLC8wgRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu5VadXH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724d8422dbaso3117555b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733114345; x=1733719145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7q6MX6sgwytwqgWeV3TDLk22z43nA7MC5ajmWt+B9A=;
        b=iu5VadXHnwtYHvx1429Ocuv17vMbUy1HF2Okqg0knLm33o2+gaMe5duhcUBTycKBba
         CMetESRLVNO9A2zHJPzNiKnrz7CBoZjuiB5d9K+nTRus+yU07IQy6gAXfDGne1A8NV6P
         uck7O5jpMribIyOotL6gHs8MjD2JUsANGBMlSiyEHCUeTxjUX49QRKpIZNojHDeTbBXA
         UVg4D+BIe2++jOrxxuecfsm14xBpOTX2khuC1je3wpADYOPPxSYrFhZXg9t2Ymw3fRyj
         edhItqvQhVRNXV74w4ZbC2txxjliBj5bAtHBU+Th1rGzFQp39E9O+uAyVsS8X3gBSWth
         bw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733114345; x=1733719145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7q6MX6sgwytwqgWeV3TDLk22z43nA7MC5ajmWt+B9A=;
        b=bnQDGg8rMUTKoVFRlK5C05DSlG5lqusovj+bz0dexwShP5IJYgtI6jeDd4GAFhEksP
         nBCcj91qr3MFdT5JXEzB2u7BfQJjRHHWLqheSp5sqqxR2MgeYOmdSTbe3/z4R1qfshEP
         1JE/xMgO2mdmVjTQebEk/8HP8D2EPtCJNTI+nlJSZuPPDzNNbjPRtk+EY0IXb/LRmrSd
         vRQqWIi/xlZtbjJfp7VW9UHkJ/rJa1ALFJnr059swISHuixVQ9K8yDgl9pzlypsv5rZj
         p7BYRxHwyZ66G9VxDNjldXEVxvh1vbdKcyQ6npBUy4omV87C1ASq5Jgyv+G7nZrEAusW
         8oQA==
X-Forwarded-Encrypted: i=1; AJvYcCUFUQ9zk5z8ahNMbRVzTyQUUrPSQ1dzVXJ9FZeEDf0f33lXuVecqbhqIIDsHiAfG8ziyCv/B6sZ2CX7lsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznDb7NPzkM+8bsj6YdJAmu8JCkVvKqOhoVOYQ3D3kmz6EH/38d
	k/6kGYq6k5lTVMkb39nrJgNYhMrhDAlDETC78nBLsfTtQqbxcR90
X-Gm-Gg: ASbGncu+HdIocxj4bRXfyyNQ1kScDETVEuoUnTaNYTVQ5ncomtNPPp9gznxxTrJ0hhd
	/o1K0yHoG+d3WMmNz3wma1Zjj0HgRJ+ibNzJmdqfRpiOsH7kEu3/phE8zmbUIso3ub3/lxNqXXZ
	fl1ggiH7xGY0ClSkzE/JrtpoIqDnhz9HiMH6Cvy6A3RfJjt2J4/PkLzPcfMcuL/HnTkDuuOsYLz
	7gwJ4OYg5P8rCx3axoDtDcFpHvPKI4chj3NUUFZPcW+UX0tROw5a2COT5pKDIs6c83PEI919dri
	Gc11ZA==
X-Google-Smtp-Source: AGHT+IFik/6cOdExAlO+rVaQ7ZjP8+HNg9j4UQF82xdYImQky2PyMu3+arlwqk96ftOcEAhgjsaydQ==
X-Received: by 2002:a05:6a00:3c8e:b0:71e:cc7:c507 with SMTP id d2e1a72fcca58-725301832afmr32012816b3a.23.1733114344454;
        Sun, 01 Dec 2024 20:39:04 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f1b9sm7436080b3a.42.2024.12.01.20.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:39:03 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] sched_ext: Implement scx_rq_clock_update/stale()
Date: Mon,  2 Dec 2024 13:38:45 +0900
Message-ID: <20241202043849.1465664-2-changwoo@igalia.com>
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

scx_rq_clock_update() and scx_rq_clock_stale() manage the status of an
rq clock. scx_rq_clock_update() keeps the rq clock in memory and its
status valid. scx_rq_clock_stale() invalidates the current rq clock
not to use the cached rq clock.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/sched.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76f5f53a645f..09d5a64f78ce 100644
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
@@ -1353,6 +1355,24 @@ static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
 	/* Do nothing */
 }
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static inline void scx_rq_clock_update(struct rq *rq, u64 clock)
+{
+	rq->scx.clock = clock;
+	rq->scx.flags |= SCX_RQ_CLK_VALID;
+}
+
+static inline void scx_rq_clock_stale(struct rq *rq)
+{
+	rq->scx.flags &= ~SCX_RQ_CLK_VALID;
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
2.47.1


