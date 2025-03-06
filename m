Return-Path: <linux-kernel+bounces-548094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE09A53FBE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DECD1893EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B391304BA;
	Thu,  6 Mar 2025 01:18:13 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44EB33FD;
	Thu,  6 Mar 2025 01:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223893; cv=none; b=BNtaab8+lJsUBi2abJ3/Wc+QT/v8swnJEdTtxjHx1aGyVtbJM0/D4txOq9K0/dc20fmSwWhPr7UrkYF7QUSGOZpN7LOrEUOYR6p3exUpYllje28bgce1SlESEMNfVgj/KIoscDPQ+ntpJuUzCIfkRHs5I5DrVnKMvsKCqtKfcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223893; c=relaxed/simple;
	bh=dA3VOSRaI0yq7m0/75aUTiC6gOA1Zy5sAhwgijdVq4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGTdJz4bN2FssI6jQqAsmYEYGZc8RL8hmZiDn3u728HlDLDtghmtuRPoDr8o0/h65X5+T5fcQOS8KWkKGA5TjAjDvJeRmfPQBSNKr+FkEnf9SjSxu7a89m3w0396kEMkNjpsDxznYawxdn9Ee1T26d78+4C9kzR+uFq8OcmGKVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525KXCXI001371;
	Wed, 5 Mar 2025 17:17:49 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 456csa1fws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 05 Mar 2025 17:17:48 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 5 Mar 2025 17:17:48 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 5 Mar 2025 17:17:46 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+2d373c9936c00d7e120c@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <perex@perex.cz>, <syzkaller-bugs@googlegroups.com>, <tiwai@suse.com>
Subject: [PATCH] ALSA: seq: Use atomic to prevent data races in total_elements
Date: Thu, 6 Mar 2025 09:17:45 +0800
Message-ID: <20250306011745.100014-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67c88903.050a0220.15b4b9.0028.GAE@google.com>
References: <67c88903.050a0220.15b4b9.0028.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: b4y4zDI5h0GFdZp1B6ibjkSpm5nfwk3t
X-Proofpoint-GUID: b4y4zDI5h0GFdZp1B6ibjkSpm5nfwk3t
X-Authority-Analysis: v=2.4 cv=d4wPyQjE c=1 sm=1 tr=0 ts=67c8f7bc cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=Vs1iUdzkB0EA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=12NZYVJXO6P3OMb9Et4A:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_01,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=923 clxscore=1011
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503060005

syzbot reported a data-race in snd_seq_poll / snd_seq_pool_init. [1]

Just use atomic_set/atomic_read for handling this case.

[1]
BUG: KCSAN: data-race in snd_seq_poll / snd_seq_pool_init

write to 0xffff888114535610 of 4 bytes by task 7006 on cpu 1:
 snd_seq_pool_init+0x1c1/0x200 sound/core/seq/seq_memory.c:469
 snd_seq_write+0x17f/0x500 sound/core/seq/seq_clientmgr.c:1022
 vfs_write+0x27d/0x920 fs/read_write.c:677
 ksys_write+0xe8/0x1b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:739
 x64_sys_call+0x287e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888114535610 of 4 bytes by task 7005 on cpu 0:
 snd_seq_total_cells sound/core/seq/seq_memory.h:83 [inline]
 snd_seq_write_pool_allocated sound/core/seq/seq_clientmgr.c:95 [inline]
 snd_seq_poll+0x103/0x170 sound/core/seq/seq_clientmgr.c:1139
 vfs_poll include/linux/poll.h:82 [inline]
 __io_arm_poll_handler+0x1e5/0xd50 io_uring/poll.c:582
 io_arm_poll_handler+0x464/0x5b0 io_uring/poll.c:707
 io_queue_async+0x89/0x320 io_uring/io_uring.c:1925
 io_queue_sqe io_uring/io_uring.c:1954 [inline]
 io_req_task_submit+0xb9/0xc0 io_uring/io_uring.c:1373
 io_handle_tw_list+0x1b9/0x200 io_uring/io_uring.c:1059
 tctx_task_work_run+0x6e/0x1c0 io_uring/io_uring.c:1123
 tctx_task_work+0x40/0x80 io_uring/io_uring.c:1141
 task_work_run+0x13a/0x1a0 kernel/task_work.c:227
 get_signal+0xe78/0x1000 kernel/signal.c:2809
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x62/0x120 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x000001f4

Reported-by: syzbot+2d373c9936c00d7e120c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2d373c9936c00d7e120c
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 sound/core/seq/seq_memory.c | 12 ++++++------
 sound/core/seq/seq_memory.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 20155e3e87c6..4a5c771ce8f9 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -21,7 +21,7 @@
 
 static inline int snd_seq_pool_available(struct snd_seq_pool *pool)
 {
-	return pool->total_elements - atomic_read(&pool->counter);
+	return atomic_read(&pool->total_elements) - atomic_read(&pool->counter);
 }
 
 static inline int snd_seq_output_ok(struct snd_seq_pool *pool)
@@ -353,7 +353,7 @@ int snd_seq_event_dup(struct snd_seq_pool *pool, struct snd_seq_event *event,
 		extlen = event->data.ext.len & ~SNDRV_SEQ_EXT_MASK;
 		ncells = DIV_ROUND_UP(extlen, sizeof(struct snd_seq_event));
 	}
-	if (ncells >= pool->total_elements)
+	if (ncells >= atomic_read(&pool->total_elements))
 		return -ENOMEM;
 
 	err = snd_seq_cell_alloc(pool, &cell, nonblock, file, mutexp);
@@ -466,7 +466,7 @@ int snd_seq_pool_init(struct snd_seq_pool *pool)
 
 	/* init statistics */
 	pool->max_used = 0;
-	pool->total_elements = pool->size;
+	atomic_set(&pool->total_elements, pool->size);
 	return 0;
 }
 
@@ -499,7 +499,7 @@ int snd_seq_pool_done(struct snd_seq_pool *pool)
 		ptr = pool->ptr;
 		pool->ptr = NULL;
 		pool->free = NULL;
-		pool->total_elements = 0;
+		atomic_set(&pool->total_elements, 0);
 	}
 
 	kvfree(ptr);
@@ -523,7 +523,7 @@ struct snd_seq_pool *snd_seq_pool_new(int poolsize)
 	spin_lock_init(&pool->lock);
 	pool->ptr = NULL;
 	pool->free = NULL;
-	pool->total_elements = 0;
+	atomic_set(&pool->total_elements, 0);
 	atomic_set(&pool->counter, 0);
 	pool->closing = 0;
 	init_waitqueue_head(&pool->output_sleep);
@@ -555,7 +555,7 @@ void snd_seq_info_pool(struct snd_info_buffer *buffer,
 {
 	if (pool == NULL)
 		return;
-	snd_iprintf(buffer, "%sPool size          : %d\n", space, pool->total_elements);
+	snd_iprintf(buffer, "%sPool size          : %d\n", space, atomic_read(&pool->total_elements));
 	snd_iprintf(buffer, "%sCells in use       : %d\n", space, atomic_read(&pool->counter));
 	snd_iprintf(buffer, "%sPeak cells in use  : %d\n", space, pool->max_used);
 	snd_iprintf(buffer, "%sAlloc success      : %d\n", space, pool->event_alloc_success);
diff --git a/sound/core/seq/seq_memory.h b/sound/core/seq/seq_memory.h
index 7f7a2c0b187d..812edbe8cee0 100644
--- a/sound/core/seq/seq_memory.h
+++ b/sound/core/seq/seq_memory.h
@@ -44,7 +44,7 @@ struct snd_seq_pool {
 	struct snd_seq_event_cell *ptr;	/* pointer to first event chunk */
 	struct snd_seq_event_cell *free;	/* pointer to the head of the free list */
 
-	int total_elements;	/* pool size actually allocated */
+	atomic_t total_elements;	/* pool size actually allocated */
 	atomic_t counter;	/* cells free */
 
 	int size;		/* pool size to be allocated */
@@ -74,13 +74,13 @@ int snd_seq_event_dup(struct snd_seq_pool *pool, struct snd_seq_event *event,
 /* return number of unused (free) cells */
 static inline int snd_seq_unused_cells(struct snd_seq_pool *pool)
 {
-	return pool ? pool->total_elements - atomic_read(&pool->counter) : 0;
+	return pool ? atomic_read(&pool->total_elements) - atomic_read(&pool->counter) : 0;
 }
 
 /* return total number of allocated cells */
 static inline int snd_seq_total_cells(struct snd_seq_pool *pool)
 {
-	return pool ? pool->total_elements : 0;
+	return pool ? atomic_read(&pool->total_elements) : 0;
 }
 
 /* init pool - allocate events */
-- 
2.43.0


