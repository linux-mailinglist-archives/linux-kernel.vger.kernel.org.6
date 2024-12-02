Return-Path: <linux-kernel+bounces-426913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3E9DFA00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93060281C39
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B041F8EE4;
	Mon,  2 Dec 2024 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbskrb7m"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990C1F8EE5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114363; cv=none; b=M80R5AH4nSdQKCrGgTx6rjLzgdjC3eWTGu3bOokld7DzhmkaiVRBJ0hxw0+iVw7P8JJka4GFB1o3bdd+CHaCoFw8hEfdTTZf8KlZVx8xr3VWNB+6MHPncwjTU/xTHOWc0/71d8BIDDWNlqCd1XTtLLRgqkED0DYfUC1NmTgBBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114363; c=relaxed/simple;
	bh=Kzd/PUC5ctt74z6B6vUj4jyvkEy3XwQUHulW25s5gBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVJXgsFy2dATPw836QGZv+QhbMolgTSTiijquR1snLC75aBJrducumyduRiCjZofWqZpZc7Ps0Zq0cdaFolXNFTFfjBQZ3d9nByzLKFVgSQZMBqq03eutgDWj6JvcetHFmm8QIjVFjrB/QcxPyjlEvBRECtq79zX8aAHOWjD4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbskrb7m; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724f383c5bfso2749074b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733114362; x=1733719162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hrorv/GUnF7EJucVAVWvFSb+WFE0AwzJOhO/e5bho0Y=;
        b=hbskrb7mNhKH/JVgxz9DEG07IOkcRVGgmWiIx7WDrUNhMwG4vDIs884mEWNuMVcZC4
         eoLmWKbt2DQJYpBGRsE8LJIgPayiZxMmA10bCFr96iUFKGr3yeAfN5Uil4OMKACsFxOC
         RlRfQuv5tOAxdJK1fgrGSm6ZMZMjJoKyGg60ll/XFpToMuJ7YW7kdOWX/Us41tu1R/WB
         xk4TFCVfauEuNNV5133oj0l1Na0aat+k8le7yjaXmRv7KQjrxns9W6evkeMTonPPUs3z
         DFmYoe+y7wVkxL9f6Y2CjzDxBPeqzORiVzR2CXFTm2FGgmznMC8MRpt9XLhIRDMzDDL0
         P00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733114362; x=1733719162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hrorv/GUnF7EJucVAVWvFSb+WFE0AwzJOhO/e5bho0Y=;
        b=ogP4NqjYtAnzY3f8WN6Yk1xPnCL7l74fXDNlGNTjSMiq620d0zqz2yS2dQxZtypSNF
         4yfcHCJcaBdYwjt71oUWYq4lsMLXqhsXRsDMvv/lnQeZaRNdMtgfmrlijuwRP/yoo4y2
         +QV+zVLfrojiuG/QqvhKoAP0ddCXoMsyYe9108+HtoQHEGCVAhsNf6+oSlkB8nsoJdft
         M2ThOdErXTu7kU2jxoczuXMmQBOi57iL4l9VMq19qJpGRS3zg9tLEEdBJyWON6eoYeLr
         qsjPkmwzWa8/qEx8rEQPiM96p9slr6X6LK5cm66Rq1LgwnjNyMY/ocPwBIYK8x+2XbEW
         b5cw==
X-Forwarded-Encrypted: i=1; AJvYcCVfENzKGwIdi+0FawvpAdg8PGZiUhGIJIIOXTLXsLk82nMjI4gy4CJ+3fH++1z1jRgVLB6BzAHmMyoZTWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpgYYyPsgmBgw676W66VZLdKPJy6YZilhNbvIPqaMMv3BXtah
	9q8bgFOATEl8n/4eEgYN3OMGwRucR/tucol27O2JjFBfTuLBJqgX
X-Gm-Gg: ASbGncsepcSsPH9Ji1AJ9TqXs2+YR1V/0al3ch8LGasK6B2phpMeuWNTgKGxdDhZgKt
	2pqTJq/q4UdNwbnWXmV9RdMRwocdMw4lBbD4DX2thLL0IwZyClQr0NyU84B4X1xAm2WRDX+MLhY
	q30s5qSrSTAYSRiQGtre50iXsmdQu0qazw0HIc2Mqa7qrnzj4aCI4QzexsTm+KYA83A/JKgoF7X
	iGAaXxTnHe0otVVuuWRX79wOa1lNhREc9TW27MsgrIvr4Pc1MfmkXMhVKix88bX4uLhQHjdwP5u
	I9ASFg==
X-Google-Smtp-Source: AGHT+IGNfxYs7dGFB/p293PItC99MrejYOrgMw0YTiPhRduHnTMChg1lC2uh6n+pQfLghwcAsvZOaw==
X-Received: by 2002:a05:6a00:2351:b0:724:67dd:2615 with SMTP id d2e1a72fcca58-7253015446amr29616926b3a.22.1733114361847;
        Sun, 01 Dec 2024 20:39:21 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176150dsm7687509b3a.23.2024.12.01.20.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:39:21 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] sched_ext: Replace bpf_ktime_get_ns() to scx_bpf_clock_get_ns()
Date: Mon,  2 Dec 2024 13:38:49 +0900
Message-ID: <20241202043849.1465664-6-changwoo@igalia.com>
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
index 4e3afcd260bf..15351bf2f053 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -734,7 +734,7 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 	struct fcg_cpu_ctx *cpuc;
 	struct fcg_cgrp_ctx *cgc;
 	struct cgroup *cgrp;
-	u64 now = bpf_ktime_get_ns();
+	u64 now = scx_bpf_clock_get_ns();
 	bool picked_next = false;
 
 	cpuc = find_cpu_ctx();
-- 
2.47.1


