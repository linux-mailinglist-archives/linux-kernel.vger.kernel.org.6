Return-Path: <linux-kernel+bounces-407386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965CF9C6CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267681F216A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCEF1FBCB0;
	Wed, 13 Nov 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSkiH5wb"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C31FBCA4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493386; cv=none; b=g18l2fiGox7qK7MPGS1R7fxm4xEr48Jevfa6AOfHj5bGx346z72mmPJJpg1bs9gtOqYXhi0ZxOrc+IGxnSaQwya7xYv0UBHOObrc1Cxq1OcgEIwUV68rzqYIgXglBbGLi0H35CQlRuVc5vppkR4G8dnbT1xrqKJi9vwUN9CC+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493386; c=relaxed/simple;
	bh=k4OeViykiz9p/LE6LhUqz3tbdLe2T4/m44PWbOvnu7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EJZ5+pq7IqdUStytK4WhybgozEhdypJyktQLyxN4ZezbaRdtqg/N0/6pNEHj2luvwW7z8CbmLvz81MsNSxGb++XzRhv2PWsogaI8lZNdNKd04h0hipHQzfObyNMIjUejmsSCSlDY4CHgI2FJ3fkXrLwmMscTMF6Vch5xql60L6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSkiH5wb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e9b4a5862fso3978526a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731493384; x=1732098184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DvMStMainN1maGNhy6LoZn5y50SMr4G1rH9B4VQHsVU=;
        b=eSkiH5wb+04YUqbQbxXRn2uDHgL4NQOR/d6eEbmN33coTSs85FH7EmLeNuwpDAZ8AJ
         4pEljzcXuZjhY/mKHqsMriB66wun9RNkdo9XT237WcvrcPKFij0Mem0fkqhLWHg13ork
         P3y+T3W8dAY2RK4cBvUNs+2NoOoPd1Hx6oNSbktb+vWP++hBRxH/cOg/iLOEeLBb2WdE
         ImnQ4ZZ3PKZQY6shElwyGkaWJyD/P5w6YEEHMECZw1xTQV0EmiYae6EI8nnASvQQPh/N
         sbaogiztTatGk/enMd55OohsnVca0Sb7iGu4sfy5sfKs1kvAQw5Q4c1K3nkbJJ8VBWnK
         H3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731493384; x=1732098184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvMStMainN1maGNhy6LoZn5y50SMr4G1rH9B4VQHsVU=;
        b=JFPrERRVut1Lku5n8XPRAiTntgfhGbmXBIMHSvncPxRdnU/KXqgcBYb4oy1pq+lat7
         AvgPoYQXLeK+yJVsnc9Ews52aC0fidSt+aXrtSWsxJsppxDPNMpfPpUwkAaGVj5/0rXz
         OCn54m9SS1Q3ZBsm/eV1opAEnR8qlQab5nI1FpMApK6/9jx3Hy6ncyGUYUUT7Dq7SHFW
         cbAZn6wMvqGq41ZxMubJbulGKhbOj04b6WU8AmXYTuKRNtrcDAG5mjQDQw5sYN4v3zvN
         bgoWuV0Q69YcTWn34jdUcLUCSek/v0/2Crag/Fk63qwCvSAus9+U/iNg8PZ7pJomD1Oa
         PMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8jjVbnXw7PERGcIrCVcm6/GlU9gRtPC11x8CWoz9rzAMnl1I1W5ShDSmmJ77QgZxfgZ2EUcbvDLsi9cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyWlWJvb1IecZjP0ovpcy8IBOtlz0u6/liDPF19JzsFGV207Q
	DBuGJANC+z/+/Lek5zTxiKDdF5EunNSNJ+6jPDxoab9x0kdcVkhW
X-Google-Smtp-Source: AGHT+IHGcKLap7p5/uvUeNdIs7hhby7XxjUWNnJi2nlWvxTeRtO5IndHlrKNl6ejk3xDwEOnJ6QTvA==
X-Received: by 2002:a17:90b:3b85:b0:2dd:5e86:8c2f with SMTP id 98e67ed59e1d1-2e9e4bef591mr7385297a91.21.1731493383185;
        Wed, 13 Nov 2024 02:23:03 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-199-79.dynamic-ip.hinet.net. [220.143.199.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3eb38a6sm1114809a91.15.2024.11.13.02.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:23:02 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Raghavendra K T <raghavendra.kt@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>,
	Jiwei Sun <sunjw10@lenovo.com>
Subject: [PATCH v2 1/1] sched/numa: Fix memory leak due to the overwritten vma->numab_state
Date: Wed, 13 Nov 2024 18:21:46 +0800
Message-Id: <20241113102146.2384-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

[Problem Description]
When running the hackbench program of LTP, the following memory leak is
reported by kmemleak.

  # /opt/ltp/testcases/bin/hackbench 20 thread 1000
  Running with 20*40 (== 800) tasks.

  # dmesg | grep kmemleak
  ...
  kmemleak: 480 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
  kmemleak: 665 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

  # cat /sys/kernel/debug/kmemleak
  unreferenced object 0xffff888cd8ca2c40 (size 64):
    comm "hackbench", pid 17142, jiffies 4299780315
    hex dump (first 32 bytes):
      ac 74 49 00 01 00 00 00 4c 84 49 00 01 00 00 00  .tI.....L.I.....
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace (crc bff18fd4):
      [<ffffffff81419a89>] __kmalloc_cache_noprof+0x2f9/0x3f0
      [<ffffffff8113f715>] task_numa_work+0x725/0xa00
      [<ffffffff8110f878>] task_work_run+0x58/0x90
      [<ffffffff81ddd9f8>] syscall_exit_to_user_mode+0x1c8/0x1e0
      [<ffffffff81dd78d5>] do_syscall_64+0x85/0x150
      [<ffffffff81e0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ...

This issue can be consistently reproduced on three different servers:
  * a 448-core server
  * a 256-core server
  * a 192-core server

[Root Cause]
Since multiple threads are created by the hackbench program (along with
the command argument 'thread'), a shared vma might be accessed by two or
more cores simultaneously. When two or more cores observe that
vma->numab_state is NULL at the same time, vma->numab_state will be
overwritten.

Although current code ensures that only one thread scans the VMAs in a
single 'numa_scan_period', there might be a chance for another thread
to enter in the next 'numa_scan_period' while we have not gotten till
numab_state allocation [1].

Note that the command `/opt/ltp/testcases/bin/hackbench 50 process 1000`
cannot the reproduce the issue. It is verified with 200+ test runs.

[Solution]
Use the cmpxchg atomic operation to ensure that only one thread executes
the vma->numab_state assignment.

[1] https://lore.kernel.org/lkml/1794be3c-358c-4cdc-a43d-a1f841d91ef7@amd.com/

Fixes: ef6a22b70f6d ("sched/numa: apply the scan delay to every new vma")
Reported-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3356315d7e64..7f99df294583 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3399,10 +3399,16 @@ static void task_numa_work(struct callback_head *work)
 
 		/* Initialise new per-VMA NUMAB state. */
 		if (!vma->numab_state) {
-			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
-				GFP_KERNEL);
-			if (!vma->numab_state)
+			struct vma_numab_state *ptr;
+
+			ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
+			if (!ptr)
+				continue;
+
+			if (cmpxchg(&vma->numab_state, NULL, ptr)) {
+				kfree(ptr);
 				continue;
+			}
 
 			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
 
-- 
2.34.1


