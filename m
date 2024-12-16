Return-Path: <linux-kernel+bounces-446745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8ED9F28AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B133F7A1307
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320A1C4A13;
	Mon, 16 Dec 2024 03:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhRcgSca"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B91C3C1D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318753; cv=none; b=qWgJP7VeDX5VVH7ZMKyzkooAdWbGpZaAVy9FyI+jKT9XaWsY1ICJrMCek43R+XfCatb9E2L4bqg70EBK1U5u+nqdubaS7wjf78rBVtlo/sWCny5A6OV+G/CSPafYY+fKfub4pthSqnrkid040QNBGURcEk4NI3EDQpLw7ZVArvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318753; c=relaxed/simple;
	bh=QV1F6m7RtxUBxKyIhCZOeu8HRvxTozYvf6p2RqU2fss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErgKBZQw5VST1sJK8EXPc12r2I7/ytyramAKVIc/7wk1INwkO5WJNy2nd6Ww8aTkoTOKfjmSa15soNgfoR6Y4NcbnyT9IpYfwR/PIkls39mmmyHcSQV+37UUPSmTlw0j1kq0bAPM/4LMo2LV97BeervwOXxo2bhfsdVWIpnAXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhRcgSca; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216426b0865so30389575ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734318752; x=1734923552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOt0ueFwgFWxNaJC91o0b6u/gfq61/y7Hzh7uJU5b4g=;
        b=EhRcgScauoUHWxXpBaIbIBXn+b6N9piIvDrKwQBui6cMYFXvNGjQWUSHiC5anBMhQ6
         FK3UGW6HHFkVaaazrHsPnGV7wHyXI9/+VUc9CJ6zCV29gYCKYE1Lh5xtHvgs2fN/ZUSf
         D8UTEBh6QkF3p0Y+Igk7Ko6X40suIEmOSrPPpA5XuwZnI40loU4MS1ZnS/AHkSLwHJwe
         rxRt632QE+TokJJwFdgSXSZlcx5GN/0shcjzf6b4nQOq4P80RsK9h31KNDO8hX69fbci
         SFf1R0jnnL5TjEFpXpAup+zsRONQfjG/yDqgipZaUICLwYBZ+V+n7Cxe6loH/tR5/2aJ
         CFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734318752; x=1734923552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOt0ueFwgFWxNaJC91o0b6u/gfq61/y7Hzh7uJU5b4g=;
        b=FoowkGbIwkYULrKplT6IOR/shu0FxNb1C1zP1f6ThH04j/s0ooPr1MLyTXmd4XEKuq
         qPZu2Knvo2ShLPiV/lXsPezn/RRiypD+qzUDPQBcuIcXSSf90fOaxBECLRABPmhx4IZi
         Oisy9FymQRnqTq4I4zSd9F/h3ZR6dybgAWARICTJqxOE6BjeJHJUFP/ooAMUlPZTDXR+
         wPUFg4IBSYerETq3WwXOX5Kf+3S9cV3QwxNCeD5M6uR2Vwnd89qhud8yUNhVwHQbA3nN
         4mGf5FAloAfYs4k/uREahNRija/7fJRBZY5bUKCYL28su2vCAUAKp8ieDxbw4uuxPonv
         pztg==
X-Forwarded-Encrypted: i=1; AJvYcCVqWMXMZW59yB1+4t4RI/MEl8aLG0X2rhDgtx7xNHa7Wrw2M/T38bEcOVVygkKLhIYGwK7myyshsOLb0Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTp9aBQ75/qN7EPVIY0ypak2pXx2/c23YoXVprgPHaG/f3Vbme
	Ihgk8jWF0R4K+WDEyqxRcJEb9SlBvbKso4ojpR+q3EPcJGrzPzSF
X-Gm-Gg: ASbGncuu3/e0vORGduy4avJmw6m0j0rrFr3GJMUXR7Ktl7FUIHmWMTcQrCukY5EQlcB
	f0UU2HUhPXA00Ow8pvlQG3lEbYzANqHaA8lc5tr5/K2Lb5Xz1MKUnvZzj6cLummnyaF8MM2VFHO
	Gxw7wIdX5qx/iWTv570Tcrv9nMMqIlCkYDdZLcP232ZGEZ1GtjgQIn+EayWQDHQKq45jDK+9mOR
	qoC03AqdTxXgmCavTNn/che18QIXKVIJY+ywmtnxz/kq02Kh9zLNmoUhQZz8lsjoi/ZZyWe/oA5
	CDQBKsUnYNbN
X-Google-Smtp-Source: AGHT+IH2J1GusDzNvQ+wayqWVdLaBt7wz58A7Yg61gP9ygIEJFz+eBl0003MSwpIbPOi+U0T/4oxcw==
X-Received: by 2002:a17:902:f14b:b0:215:b087:5d62 with SMTP id d9443c01a7336-21892a4179bmr118497035ad.36.1734318751757;
        Sun, 15 Dec 2024 19:12:31 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d90dsm32918565ad.266.2024.12.15.19.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:12:31 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v5 6/6] sched_ext: Use time helpers in BPF schedulers
Date: Mon, 16 Dec 2024 12:11:44 +0900
Message-ID: <20241216031144.98097-7-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216031144.98097-1-changwoo@igalia.com>
References: <20241216031144.98097-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the BPF schedulers to use time helpers defined in common.bpf.h

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/scx_central.bpf.c |  5 -----
 tools/sched_ext/scx_flatcg.bpf.c  | 11 +++--------
 tools/sched_ext/scx_simple.bpf.c  |  5 -----
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index ea1d853b9dd4..c3b6998ea83e 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -87,11 +87,6 @@ struct {
 	__type(value, struct central_timer);
 } central_timer SEC(".maps");
 
-static bool vtime_before(u64 a, u64 b)
-{
-	return (s64)(a - b) < 0;
-}
-
 s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 85e33e45f818..2735ec25e511 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -137,11 +137,6 @@ static u64 div_round_up(u64 dividend, u64 divisor)
 	return (dividend + divisor - 1) / divisor;
 }
 
-static bool vtime_before(u64 a, u64 b)
-{
-	return (s64)(a - b) < 0;
-}
-
 static bool cgv_node_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
 	struct cgv_node *cgc_a, *cgc_b;
@@ -920,14 +915,14 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 		    struct cgroup *from, struct cgroup *to)
 {
 	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
-	s64 vtime_delta;
+	s64 delta;
 
 	/* find_cgrp_ctx() triggers scx_ops_error() on lookup failures */
 	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
 		return;
 
-	vtime_delta = p->scx.dsq_vtime - from_cgc->tvtime_now;
-	p->scx.dsq_vtime = to_cgc->tvtime_now + vtime_delta;
+	delta = vtime_delta(p->scx.dsq_vtime, from_cgc->tvtime_now);
+	p->scx.dsq_vtime = to_cgc->tvtime_now + delta;
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index 31f915b286c6..6561d400ae6d 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -52,11 +52,6 @@ static void stat_inc(u32 idx)
 		(*cnt_p)++;
 }
 
-static inline bool vtime_before(u64 a, u64 b)
-{
-	return (s64)(a - b) < 0;
-}
-
 s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
 	bool is_idle = false;
-- 
2.47.1


