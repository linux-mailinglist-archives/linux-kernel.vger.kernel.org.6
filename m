Return-Path: <linux-kernel+bounces-411800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4FE9CFFC0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B6B2859FB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D302E193091;
	Sat, 16 Nov 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy9WBBFd"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B9198848
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772935; cv=none; b=mX07bbbLXLlP8QKTZcA6/ks5X2WFdOBTFdeOfnld/PWr1Ihp8fmmt8M+S81bDTXFzEWr/Tavq4FTexjo+/iY8mizzOoxMcQ9fHpcFc27Ac/YfqJNYhjxtl9ROyYWMPhIeaIfyQFuMKTZEDHeREe5Gqlaqf/bEGyhW0C52S0XCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772935; c=relaxed/simple;
	bh=29OhbxoZ0xm6G7JzBb4GdoFklR8a8xfzpQfSQfoBXk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acUVA01wLBHkotAXqMjuu+4wQJrMtkYK+kgoH2XFNfyb5bkg3RO1BdGBSKEkZbookqhZ24MHDm6VUydaNDmqj8JttRFbFXWsZXjU5lcDt47bZWMZ8EIwfvMmbNaVu41SWS+KqXN9UCNB8audtL57gK0f6zat2KBCLPEDRzCnzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy9WBBFd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20caccadbeeso18597065ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731772933; x=1732377733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEUGftoYqMghGeJCrzA2wJAFP+c9rSA4g2ZKWQjS6GI=;
        b=jy9WBBFdZWlX+aqc3w5GBlY18Piz8jo3rsA9Kh6jaEUW8wUlI8j4qBpZoTIPByVul/
         Bqwudv+lHRoIoFHjoJxgQ2+r1Rv5Mmj5GUcXBNEjHEIs8HYd0j/WNo31lpKQRGXEyU7v
         PtWZPWKBUZsHv2cc2gLqzcRSAIgkNO383OPYt/01hrZClZdG9QxZctm0u7D1wQpDsqiG
         SVpOchQgrEUoSmo5u8LCEhO6phLaLTK5l64HpixhYhAxMC2udIoVJFKYsbbuB96Teei+
         FgFFhtLMmR+qQJDsoQlxgKJi3UnUVYP19cjYvG4VV4PyJGJOBhpknGMOhapCbA3kVaW7
         8Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731772933; x=1732377733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEUGftoYqMghGeJCrzA2wJAFP+c9rSA4g2ZKWQjS6GI=;
        b=g3eUIQf6QttWMekU7dPCwlnlneZhyDn1KSm7CHe61Vd4sS1tFss82j7XxoSDC0R4Il
         eZdHW42fqFv0hrM2yRSO4gWXsDxwWnSwCueVX6WaYIrXW7UTEDH2NcOpWMxZkUTohDaj
         CzZHkl4qDq+2EmQN6e1N/vbBuxPDXLl5LDNsZebKLiFgZRetXgcG3fIX6Sw3B4PMH1Ay
         K439nqV3pOg799klcr/q/7rnRcuXtS34JTR4guP+m36wJaG5rFlcOpka/uYok06pYaKX
         +OJBItgCRWwzf2DNrnB50mTvXCq9yIoENJlCJIcc6H+Md8dzZGZrlncClRK1sS2bYq+9
         Fiww==
X-Forwarded-Encrypted: i=1; AJvYcCW8oJtmG+5T7OQ6DOtOx91FAYOIq1oeg9G5xNCyAAyLfvFWK5L7iGmvlo9Jak66Uq6jxGy2d44B22qro/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+3bhF0yxE5E8SaSpOW7+dkRiXbIyGxEyYkfvnsfuhhDE1OjS
	YyEmBxK/ay8M9gBbFmmQYhVvXUBCYT+HyCOliN9WfhRC70Yg3Y7c
X-Google-Smtp-Source: AGHT+IFQzE03yOcJF6hT2Bip9XWJXr23JrMiXmrisg0f9+jeNvS/flZn9tQ/f2G0LVaDu+haL6Zunw==
X-Received: by 2002:a17:902:d48e:b0:20c:e5b5:608a with SMTP id d9443c01a7336-211d0d5ea23mr94522405ad.5.1731772933238;
        Sat, 16 Nov 2024 08:02:13 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f4535csm29137285ad.178.2024.11.16.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 08:02:12 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] sched_ext: Replace bpf_ktime_get_ns() to scx_bpf_clock_get_ns()
Date: Sun, 17 Nov 2024 01:01:26 +0900
Message-ID: <20241116160126.29454-6-changwoo@igalia.com>
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

In the BPF schedulers that use bpf_ktime_get_ns() -- scx_central and
scx_flatcg, replace bpf_ktime_get_ns() calls to scx_bpf_clock_get_ns().

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/scx_central.bpf.c | 4 ++--
 tools/sched_ext/scx_flatcg.bpf.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index e6fad6211f6c..cb7428b6a198 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -245,7 +245,7 @@ void BPF_STRUCT_OPS(central_running, struct task_struct *p)
 	s32 cpu = scx_bpf_task_cpu(p);
 	u64 *started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
 	if (started_at)
-		*started_at = bpf_ktime_get_ns() ?: 1;	/* 0 indicates idle */
+		*started_at = scx_bpf_clock_get_ns() ?: 1;	/* 0 indicates idle */
 }
 
 void BPF_STRUCT_OPS(central_stopping, struct task_struct *p, bool runnable)
@@ -258,7 +258,7 @@ void BPF_STRUCT_OPS(central_stopping, struct task_struct *p, bool runnable)
 
 static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
-	u64 now = bpf_ktime_get_ns();
+	u64 now = scx_bpf_clock_get_ns();
 	u64 nr_to_kick = nr_queued;
 	s32 i, curr_cpu;
 
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 4e3afcd260bf..3be99f3c32fd 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -734,7 +734,7 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 	struct fcg_cpu_ctx *cpuc;
 	struct fcg_cgrp_ctx *cgc;
 	struct cgroup *cgrp;
-	u64 now = bpf_ktime_get_ns();
+	u64 now = scx_bpf_op_clock_get_ns();
 	bool picked_next = false;
 
 	cpuc = find_cpu_ctx();
-- 
2.47.0


