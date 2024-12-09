Return-Path: <linux-kernel+bounces-436830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8B9E8B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1731885BBF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017A2101A9;
	Mon,  9 Dec 2024 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtDPLb85"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F221480E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724970; cv=none; b=fse8/OpNN8FDaNYCykwT1Ow5fcCWWcyXip5qPLZqJkERbDvpme47jlbXzTnXHRx9oBIdQ46pQuPwlmj7bMkSgxvTj2QyDGUvzycx/zfa4Q4O02j79Q5lgxy27Q37OgUDUtz+KZTNL+HFhM5K8PQRvepmoa63S+es9aOf6+6KFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724970; c=relaxed/simple;
	bh=8xKUl/PksIoq2Rbneib2leLcMgymowSckqA99qxx/g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1ZXV83Zo1AFG3CP1zEZh9z/azwXTiExnI/9CEa2+gTKJk/6aTM1qcCqjBABugHFi/KYkTdXsSq0GLWjFnzCAfadx3fwYXi/oGUggqlV6nU9D9iENlr550BUpN7unLYOF3HrUPyGcw7uPrCDuXL2ThqQUB10WoCCTOWugR3H6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtDPLb85; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso901378a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733724968; x=1734329768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47y2cVyd1kuIZD8NQ+KQkmd+50HMhaVqGUhTFqkPRtg=;
        b=OtDPLb85FZ6FH8HT5ZfK0KBpXMYOBrR8i2/p3PIFc+XkRQ841RQIT9ePyzDJaK4plB
         AtILbI8JdwgcoyYpLog1WWjuM8ZdG1skOG53xhMDOBI1a3rSIgW4P/j5vFfyAvOLX3FN
         /hNvNGBu4Jq1FNMJNc5ZvE1CyCfGcmP8ypiaA8LMdMZ8jwqfRPcyuXhITpakepPYG3LS
         JZ7XC8zBvdkOB9Sxoo+XalB1lqwN2oxjruEk3FvwYM+rv2il+QvwgBZq/98uVfu2+obH
         wGaetgeOy+XkDv9wRhDT5TN4g8Fqzywt4pOPcRl0AUdTqVUykdSBJX1P0khbZfAb3NbR
         2plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733724968; x=1734329768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47y2cVyd1kuIZD8NQ+KQkmd+50HMhaVqGUhTFqkPRtg=;
        b=bYkp6Uy0q2ZrkvkS65NFAbqQ9z/gDav6hbH7nF+zYIdBM0R0QVaoOBMOD2mW7XS3ng
         tYeec2AYnpj8fZpqCdUL3hYjGEZlW/bGWEP6wTTe0+q5WAWGAypFhip6HYVEdYnMYlZz
         DKehC3NBNXtMRkcgjiCXTiavdPlHuF6xr6MFNFmSPYcScNaiM+x2whxb1EEZPGl+4hn6
         uI11hZRlwAS1lyNUNFlnuWvrLqAm17hXYmwyI8cO/ZB7LkWBUg0E3KXNx/7555x4xsSn
         qqiGKXinLRIfLxS3aCXBKRJAMyFUqd6pZhayz+TpKH1YyzgP1+6MCXeayr5waDH1z7sZ
         IBcg==
X-Forwarded-Encrypted: i=1; AJvYcCVTbcV7qMIXEoEhIBY2C9rBwSratFhVRNN8EbNtlCGSs78q/Xt6TqgLeX2IE84D0Pfj7wmJD8jL0zkzDzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+nqUqfF+PhPy6sQ5nmDs6no2PCGyk+Hb5Yu4yQQvaYfypJh7
	vAHL9Gz9sOa80ft1U0f0RvLOuJDhpcUeRAyTcDx3rP4ULHGHTJjR
X-Gm-Gg: ASbGncu+QERz2Jf96wdKKCir836nOJKFmCxzdpVgslWfZpZH8lci4IfTdLRBOW9MaDI
	QoVvER7nDBP5J2LxFpCevNgBzlSGi9sffW5ztQiVItMLO1AW0SDCQPl/aVSTaoFXa3OoE3c/j+M
	W5Zx6RCyApe78Sd7oyHa8eLHw3EhKdpGAb+XmCP747Ywt98ILqB6k1Cdn+tOD7IQEjQ7sIQ+pL8
	PiuUqJ89lHzee9Eqpe5o1uA5CrRm1xQT9AVSyGOk0CcWFUCc+asnZ5DQz0lDPzOr5mkcbm5QucW
	9EyGmg==
X-Google-Smtp-Source: AGHT+IGR6SDOInTOzs1ZgZz2jFp+v8LqNuzUwHxPV0vg7nvptPwzbdk6ljguSlV/VuELR3U+zEvc0w==
X-Received: by 2002:a17:903:2344:b0:20c:6399:d637 with SMTP id d9443c01a7336-21614da3f2amr202143245ad.40.1733724968203;
        Sun, 08 Dec 2024 22:16:08 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162381c6basm39572265ad.121.2024.12.08.22.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:16:07 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] sched_ext: Replace bpf_ktime_get_ns() to scx_bpf_now_ns()
Date: Mon,  9 Dec 2024 15:15:31 +0900
Message-ID: <20241209061531.257531-7-changwoo@igalia.com>
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

In the BPF schedulers that use bpf_ktime_get_ns() -- scx_central and
scx_flatcg, replace bpf_ktime_get_ns() calls to scx_bpf_now_ns().

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/scx_central.bpf.c | 4 ++--
 tools/sched_ext/scx_flatcg.bpf.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index e6fad6211f6c..e64b7a429126 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -245,7 +245,7 @@ void BPF_STRUCT_OPS(central_running, struct task_struct *p)
 	s32 cpu = scx_bpf_task_cpu(p);
 	u64 *started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
 	if (started_at)
-		*started_at = bpf_ktime_get_ns() ?: 1;	/* 0 indicates idle */
+		*started_at = scx_bpf_now_ns() ?: 1;	/* 0 indicates idle */
 }
 
 void BPF_STRUCT_OPS(central_stopping, struct task_struct *p, bool runnable)
@@ -258,7 +258,7 @@ void BPF_STRUCT_OPS(central_stopping, struct task_struct *p, bool runnable)
 
 static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
-	u64 now = bpf_ktime_get_ns();
+	u64 now = scx_bpf_now_ns();
 	u64 nr_to_kick = nr_queued;
 	s32 i, curr_cpu;
 
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 4e3afcd260bf..568581b15c44 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -734,7 +734,7 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 	struct fcg_cpu_ctx *cpuc;
 	struct fcg_cgrp_ctx *cgc;
 	struct cgroup *cgrp;
-	u64 now = bpf_ktime_get_ns();
+	u64 now = scx_bpf_now_ns();
 	bool picked_next = false;
 
 	cpuc = find_cpu_ctx();
-- 
2.47.1


