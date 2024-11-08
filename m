Return-Path: <linux-kernel+bounces-401695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FCE9C1E1F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB59F1C20FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187511E9069;
	Fri,  8 Nov 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbdNLYVH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FBD192B95
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072743; cv=none; b=LCdXwdfB84qjwaLpMVSv1MDjS5ybRd54trdZO7fbICAJebJO4zfrgBzKfqtSGPIhAadE68MNLZPwgp/xOYNPSZK1+nfYHMKEhUX3kTaazYoX+ydROJrP+5V/AzOYu+H+eYq/tdSFm+MOZV9/3nhWIxsbFUHBDK5JroJcI9UXjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072743; c=relaxed/simple;
	bh=5+aObWcNzSS6tJ2DwquMz1FwzKX7xDSTuh49U06QbUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fumkSuehB/w7jtBjjev4O/BgNEhd9KE5cscPusibNPz2ovMMjtu5YO7ufNrYl8bKILysxDtbofWP5+11+Rg9yFEzuUjqD9S3cH5+n+qIIlXsZ1tFE+/jZ/vgnfdHfi+aqKC5myZzRbla3KJMVWBrQmYH3aoEUnrE6TE2lGupL/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbdNLYVH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cf6eea3c0so22903235ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731072741; x=1731677541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mizrfvSVkUCNED9Y2NSIWyK0vQ9oYQmDnBbjRhGsL4=;
        b=QbdNLYVHtIPkhW6LJX4aInFsSVbyzGUR0hcJ4ZFw/Ka6ibPMB3MGCRPUVWYY8d4XcH
         i3181MpxR6WX8ElJh/iCUJW7DoquQOiK1+HJoMi6OKmwkpdnKPXSm2tEtk5ATSthvxwI
         dXKaXmfOSpfQD2JOVM6TQLfobD3VSFWrMiqg4rcTOfuhVWwKD70HPvgHlcAxG+eKNXYJ
         9X/FYnpeLTCPibtjotYdNI2xs2NiHvWu0Ikq9j9WlZz8Sey/aYUEGd+GdsfJmuyF3isH
         Inube4jghHaJNldC4I1uy33wCncCkPckrWjAdv7VvHdIrPiWMk5oSRA1teP4pIynDBhR
         8l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072741; x=1731677541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mizrfvSVkUCNED9Y2NSIWyK0vQ9oYQmDnBbjRhGsL4=;
        b=bEMDPZmLmoDcugok+A1/+CsMtwaSMYxLzzgLDOMzYybEV7o8ChUXmXWmz3QuJQ/VRG
         C8VCzN28r2a6FvIJ95rLu9wt7iwFcy5sD6nEyUPSV142D14amOz7rDXQkQlvhSWxDgFb
         EBpm1dXTHanpv5/6OrloBdtT//eN+gBkzIZBDjCoasH2DzO2rSw0Nl19UpbUQfiuAQB8
         qohA1bFrwp5Wkna4dGoBKdYNeRS+5HTj/l060tYjkqxjux3fk/i7Jv5tyRgzCi2SJeDS
         LAEqr75xhNaoJaMW9U8nxZQYawre0whGK14AHaI9Izzxt98RQyPfZI9VY41gpAPckfoJ
         ++Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWAyY6b2lSEdhjiK5dbvwmfsU2C+PqIp9hMJi2JcpQapxld0glrGdUBangbWa7r+D0Q/ujHMHrO7iSnPqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeURmQeDepfTbTaaT/TYkWSkgke+yeUIxjUGQVreDsIAe76fIT
	3ugyfihn3Y7BZb2sVxLiqZjjL8Ox5F8EdWQiylhy9UZWbQhN6uTL1iDSgrm15XE=
X-Google-Smtp-Source: AGHT+IEhGsvp6Hssde9pRaFnvxwwTJ/5AVBuoiR0yoMCI7WlfZC9INb/F+oL2qxkFMC8blbsiii9fw==
X-Received: by 2002:a17:902:ce91:b0:20c:e1f5:48c7 with SMTP id d9443c01a7336-211835ea892mr27707775ad.55.1731072740942;
        Fri, 08 Nov 2024 05:32:20 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-198-84.dynamic-ip.hinet.net. [220.143.198.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e59486sm29288975ad.204.2024.11.08.05.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:32:20 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Raghavendra K T <raghavendra.kt@amd.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>,
	Jiwei Sun <sunjw10@lenovo.com>
Subject: [PATCH 1/1] sched/numa: Fix memory leak due to the overwritten vma->numab_state
Date: Fri,  8 Nov 2024 21:31:39 +0800
Message-Id: <20241108133139.25326-1-ahuang12@lenovo.com>
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

Note that the command `/opt/ltp/testcases/bin/hackbench 50 process 1000`
cannot the reproduce the issue because of the fork() and COW. It is
verified with 200+ test runs.

[Solution]
Introduce a lock to make sure the atomic operation of the vma->numab_state
access.

Fixes: ef6a22b70f6d ("sched/numa: apply the scan delay to every new vma")
Reported-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h |  1 +
 kernel/sched/fair.c      | 17 ++++++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 61fff5d34ed5..a08e31ac53de 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -673,6 +673,7 @@ struct vm_operations_struct {
 static inline void vma_numab_state_init(struct vm_area_struct *vma)
 {
 	vma->numab_state = NULL;
+	mutex_init(&vma->numab_state_lock);
 }
 static inline void vma_numab_state_free(struct vm_area_struct *vma)
 {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bc..77eee89a89f5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -768,6 +768,7 @@ struct vm_area_struct {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
+	struct mutex numab_state_lock;		/* NUMA Balancing state lock */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c157d4860a3b..53e6383cd94e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3397,12 +3397,24 @@ static void task_numa_work(struct callback_head *work)
 			continue;
 		}
 
+		/*
+		 * In case of the shared vma, the vma->numab_state will be
+		 * overwritten if two or more cores observe vma->numab_state
+		 * is NULL at the same time. Make sure that only one core
+		 * allocates memory for vma->numab_state. This can prevent
+		 * the memory leak.
+		 */
+		if (!mutex_trylock(&vma->numab_state_lock))
+			continue;
+
 		/* Initialise new per-VMA NUMAB state. */
 		if (!vma->numab_state) {
 			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
 				GFP_KERNEL);
-			if (!vma->numab_state)
+			if (!vma->numab_state) {
+				mutex_unlock(&vma->numab_state_lock);
 				continue;
+			}
 
 			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
 
@@ -3428,6 +3440,7 @@ static void task_numa_work(struct callback_head *work)
 		if (mm->numa_scan_seq && time_before(jiffies,
 						vma->numab_state->next_scan)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SCAN_DELAY);
+			mutex_unlock(&vma->numab_state_lock);
 			continue;
 		}
 
@@ -3440,6 +3453,8 @@ static void task_numa_work(struct callback_head *work)
 			vma->numab_state->pids_active[1] = 0;
 		}
 
+		mutex_unlock(&vma->numab_state_lock);
+
 		/* Do not rescan VMAs twice within the same sequence. */
 		if (vma->numab_state->prev_scan_seq == mm->numa_scan_seq) {
 			mm->numa_scan_offset = vma->vm_end;
-- 
2.34.1


