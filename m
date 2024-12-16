Return-Path: <linux-kernel+bounces-446744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F17B9F28A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B2018815F6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A471C3C0D;
	Mon, 16 Dec 2024 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGYmxhAr"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ADF1C07C0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318750; cv=none; b=ExOtYLeqJhLNCahiJ+BAEWrrMt+nrEm074G3YPajtAPM1evYsAKui6jEepr1lQfyQyPFtJv80VqZPtmfXTRLxPblZ5EauQD76pAFjHJFeyaq1Y0D132E481rsNVOyWosDyDeH2QG20hOOAUGZIbcQoapsncYSiIga6ZB6J0MsZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318750; c=relaxed/simple;
	bh=4stYz4/gGsi209Zl3d3WdyhWsyzSZCdqMC7HTz5fhyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4vfSHfPqYsRl6nFAgcpAYC4aSdUmBLkIJoeVPzamYVnIR0zxhypP1W1gJ9JWCCeIihbZGBs6WlxD526/2KNeAyRs4F3JvyqHtiFaZbkEXsKXUWf9Ep+yU8Rbn0V+e+M2gzfji7gnenYymacl6672ESgF0WU3ykmp7JGGliGfn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGYmxhAr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21145812538so34162705ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734318748; x=1734923548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMZAxlMblUHwQnDYumYsih8SVwxSsCKPzL7XYsgcWJQ=;
        b=kGYmxhAr69WBCh2qo8O1nXvAiZtRX7C/aUfWcMlwA/SVRclOgBAOGlqG8+mbYxo70L
         hrKtm5PmV9JJ960ckBg5XOY6NdX+LBClHEvQOUElmgxkEzi0wjKRE+oym9rFhehUnTs1
         6MvMvL7PKoQBv/JT4WkySn+HlXjJvM6pTSUqfPmshhTl49kMuwr/wRy8/UtIbBfelqF0
         uuzxdEvgw995oskIJFSo3/P5VZDH5V1B9J48YMp3xhwQVXc5IMR047M4IYBzXPGtLTFJ
         RzubMcopE4rFE2EAT3BKEq9k8O9hDoNO/cjaez92jEMxoDKptK279c6dpKsulXW/rjNj
         187A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734318748; x=1734923548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMZAxlMblUHwQnDYumYsih8SVwxSsCKPzL7XYsgcWJQ=;
        b=Ioue4lnc/RHqJ9JhYudCVfm9zL3aKsBrunnjKCBuXM2u6oAgJxGflzqa/DpMCMwIis
         iHpY3Lk8ziJNAiI8dzXmbqm+jsJFTMuISGZV98iO9+EYYOg8qKjaO5uAkkUOxgQYi4+J
         SkmsPE8UXeAn0k3ocP0E9yxh8kUYiw9K2cWt4Wf9sWoYy1nZETwYUNsKUm1CTQO2m7QY
         lLX4mZw3YYOjXdZ0bNEink7y+VAieWn5HymBpJaHXr7TgDztzDdve2LQZOdM5qk2AjlR
         qco5I4WyXd3l6lE4m4kM3vxUCJOIh571BBMg4DCoU97G4ZnUKslgmgQHukIqA9Z52g9k
         Mwtg==
X-Forwarded-Encrypted: i=1; AJvYcCWaYHLJxPqqZ4hOslSDafpN5rkzeQWT+kTvXoXSsu9rGI4BoFW7BSMrylXZ/tqaZXxlx6z5Z+VQNmvqPno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqkmtfH9LS/ZrW/vx3A8zHad0ZZlVc0JUJM0rOw+P77ms79tc
	OiCX6E2HCQF62ir+lsDroxPG0ogyAnvH6dNUhaZMAT/yEgwu0fAk
X-Gm-Gg: ASbGncv08cWUx5D78hlfJCUZ4VEkuzV0Nr65imPasIj263exprBuSPKLbE5sOqABCFy
	lgVQSbgjqt+3Rk80Pb/d9wavmWunX7hHwO2wsvwS9oM06wU4Y0UztmA9yFNPnwyItHXJmuOn3Je
	JaeVU/wUiTXOQdL7Tj7CxyfpvLiHHEJeh45X9rp+isNaV1Mb7YLDjrO/qGH43qaXrcaxnHs3ZOH
	jUbQbG88zMnFQB6hZRSK1zteHNx/SvhSOObb6ZNvMxLaZUtONxnHI+sL+aodTnGJXWs7xuwmbkS
	xg5GIEIjcvyr
X-Google-Smtp-Source: AGHT+IE9a/SgVKPHbF5W4uThKayf+TK8X192v/Wi1m6PkR30a4OPCVpl8dIpQQNknshhKk6NDFl2fQ==
X-Received: by 2002:a17:903:1d2:b0:216:7cd8:e964 with SMTP id d9443c01a7336-218929e814cmr163850155ad.22.1734318748538;
        Sun, 15 Dec 2024 19:12:28 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d0e4sm32874705ad.261.2024.12.15.19.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:12:28 -0800 (PST)
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
Subject: [PATCH v5 5/6] sched_ext: Replace bpf_ktime_get_ns() to scx_bpf_now_ns()
Date: Mon, 16 Dec 2024 12:11:43 +0900
Message-ID: <20241216031144.98097-6-changwoo@igalia.com>
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

In the BPF schedulers that use bpf_ktime_get_ns() -- scx_central and
scx_flatcg, replace bpf_ktime_get_ns() calls to scx_bpf_now_ns().

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/scx_central.bpf.c | 4 ++--
 tools/sched_ext/scx_flatcg.bpf.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 2907df78241e..ea1d853b9dd4 100644
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
index 3dbfa82883be..85e33e45f818 100644
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


