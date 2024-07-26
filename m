Return-Path: <linux-kernel+bounces-263525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD793D73C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17F81C20CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8817CA0C;
	Fri, 26 Jul 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIsN7TOG"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920617C7DE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722012846; cv=none; b=hLpCr2vfTUj3zcMzf1b7ZMgNAIIxBS2P8mEDQ4Dhf01nPdi1DUJOw4MQztjlzAuk89O4TAyvTZ2A201PaaVvQcdMPVcLyPUH44vZuCAz6De+ZEw6e37dlIEyUqgswpLTld+dpxLKxoaIl+FnhMWQ6UVC326cRcMnZiJ5/GTJF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722012846; c=relaxed/simple;
	bh=vr6UV/vfHQnscv+r2Vi3krbeS7d+G5ul9haD0pCKolE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AVGVy/fu0emd4gsWzNXzd/V7DzJYYgD/1/IPeM6FzVAKn4HCKZwndoxSdK1mCmP1l4+q2UG0lHFD10vVAvWlMrtD9TQzZdOLIZ2tGIh0srTb+lQvYFodBac0wkRLJWeSgPTER8CzmVvSDolUmdOsYkH9T/LZfN7g/8D/Yr8aKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIsN7TOG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fee6435a34so7562315ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722012844; x=1722617644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4t2bj9tP9eNdb8RTP1Rkd3tr4D6cDtGqwUT49U/h94=;
        b=gIsN7TOGDRmgNeHw56hbQP1q1t4FYEWfGJyNy6jj0pVI5ksV8S296oh6tEpZyQbTYJ
         OZsYubGjapt3kfa6eVSd0VGK41/ZkpAFM6Hx300Ye9QPqyoEDXbNps+8k34rb98EW1vT
         3bSiAtOpFDOzL7cTBIptPtCPh0c5637dTB4fWNn9nCxT1PXgdhQGLNOd7MaaAUQzTlAh
         LNWhs9v6bwpa7L/XVcm97vIsaOwWpenY9QLrAigsqmkN+RUa9SRocOKfs/QQhEVfHw7Z
         bVYnvF3AJkyo49ku7yVTENV/QeUCEm3gA0o+C26j4eSnknlyjlFwTth9kKPlRWqdsrpI
         q2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722012844; x=1722617644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4t2bj9tP9eNdb8RTP1Rkd3tr4D6cDtGqwUT49U/h94=;
        b=s3ETeM2Fd7R72U2sJ9DPdtHRg9dtTSeXEZVZY23nvZmlsIkrq1f2cyul16iUUckYqp
         IpVpPoWG5K6+Y5yX/GDo4kyd6HzxFhspj597ixRQndU2FxYfnfRS/wGT+nDsABDg7Dp8
         yl8XjjYe0oPBDXTa7+/jrTbHllsZ8br4oJvSI5n0g2qYX2rs8dNNqfGR9mzgac34bk/S
         EM8JumQ/PdaNsyr8XP1lubKJ+iWcCkKRp/9hAqGNhRTkZv3s/WH1K9+vxll73rcZ5tUX
         qUk076xn4yqqc9AyCu/BKe0NSjUE/9XDzioiyOgi4iKcgrDa5bSmQm2KyNJIZ1lzPfR9
         7l5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoK5PuJo37h4k76d2PJ+0joyZBSVCD9sxkTy67RK4gxV9vxEl0EBlLkbmErN8eW+zy82BTqCWpiVObdKsPRi7J0ZImrQUFLfrUCPpM
X-Gm-Message-State: AOJu0Yz/wwIU7t6qjWCN3l7Q+xmI+9/0qy/nNPC0THB5Jz98P0twelIw
	3kF6l1PpxMsYpXoys4yL6rjrjZg7A+GLF2gf6EDLhFTijeXGuEtL
X-Google-Smtp-Source: AGHT+IFwO5/nYoc8mAYgHMXJs+2rtU6mJlKccGDL7cAHvInL7APqQb08P4db4KgKW/00R4sAxn2Wmg==
X-Received: by 2002:a17:903:2284:b0:1fd:9b96:32d4 with SMTP id d9443c01a7336-1ff048e6ff9mr2338855ad.51.1722012844009;
        Fri, 26 Jul 2024 09:54:04 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-223-167.dynamic-ip.hinet.net. [220.143.223.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed8000ecasm34897805ad.309.2024.07.26.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 09:54:03 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Baoquan He <bhe@redhat.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>,
	Jiwei Sun <sunjw10@lenovo.com>
Subject: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of KASAN shadow virtual address into one operation
Date: Sat, 27 Jul 2024 00:52:46 +0800
Message-Id: <20240726165246.31326-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

When compiling kernel source 'make -j $(nproc)' with the up-and-running
KASAN-enabled kernel on a 256-core machine, the following soft lockup
is shown:

watchdog: BUG: soft lockup - CPU#28 stuck for 22s! [kworker/28:1:1760]
CPU: 28 PID: 1760 Comm: kworker/28:1 Kdump: loaded Not tainted 6.10.0-rc5 #95
Workqueue: events drain_vmap_area_work
RIP: 0010:smp_call_function_many_cond+0x1d8/0xbb0
Code: 38 c8 7c 08 84 c9 0f 85 49 08 00 00 8b 45 08 a8 01 74 2e 48 89 f1 49 89 f7 48 c1 e9 03 41 83 e7 07 4c 01 e9 41 83 c7 03 f3 90 <0f> b6 01 41 38 c7 7c 08 84 c0 0f 85 d4 06 00 00 8b 45 08 a8 01 75
RSP: 0018:ffffc9000cb3fb60 EFLAGS: 00000202
RAX: 0000000000000011 RBX: ffff8883bc4469c0 RCX: ffffed10776e9949
RDX: 0000000000000002 RSI: ffff8883bb74ca48 RDI: ffffffff8434dc50
RBP: ffff8883bb74ca40 R08: ffff888103585dc0 R09: ffff8884533a1800
R10: 0000000000000004 R11: ffffffffffffffff R12: ffffed1077888d39
R13: dffffc0000000000 R14: ffffed1077888d38 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8883bc400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005577b5c8d158 CR3: 0000000004850000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 ? watchdog_timer_fn+0x2cd/0x390
 ? __pfx_watchdog_timer_fn+0x10/0x10
 ? __hrtimer_run_queues+0x300/0x6d0
 ? sched_clock_cpu+0x69/0x4e0
 ? __pfx___hrtimer_run_queues+0x10/0x10
 ? srso_return_thunk+0x5/0x5f
 ? ktime_get_update_offsets_now+0x7f/0x2a0
 ? srso_return_thunk+0x5/0x5f
 ? srso_return_thunk+0x5/0x5f
 ? hrtimer_interrupt+0x2ca/0x760
 ? __sysvec_apic_timer_interrupt+0x8c/0x2b0
 ? sysvec_apic_timer_interrupt+0x6a/0x90
 </IRQ>
 <TASK>
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? smp_call_function_many_cond+0x1d8/0xbb0
 ? __pfx_do_kernel_range_flush+0x10/0x10
 on_each_cpu_cond_mask+0x20/0x40
 flush_tlb_kernel_range+0x19b/0x250
 ? srso_return_thunk+0x5/0x5f
 ? kasan_release_vmalloc+0xa7/0xc0
 purge_vmap_node+0x357/0x820
 ? __pfx_purge_vmap_node+0x10/0x10
 __purge_vmap_area_lazy+0x5b8/0xa10
 drain_vmap_area_work+0x21/0x30
 process_one_work+0x661/0x10b0
 worker_thread+0x844/0x10e0
 ? srso_return_thunk+0x5/0x5f
 ? __kthread_parkme+0x82/0x140
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x2a5/0x370
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x30/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Debugging Analysis:

  1. The following ftrace log shows that the lockup CPU spends too much
     time iterating vmap_nodes and flushing TLB when purging vm_area
     structures. (Some info is trimmed).

     kworker: funcgraph_entry:              |  drain_vmap_area_work() {
     kworker: funcgraph_entry:              |   mutex_lock() {
     kworker: funcgraph_entry:  1.092 us    |     __cond_resched();
     kworker: funcgraph_exit:   3.306 us    |   }
     ...                                        ...
     kworker: funcgraph_entry:              |    flush_tlb_kernel_range() {
     ...                                          ...
     kworker: funcgraph_exit: # 7533.649 us |    }
     ...                                         ...
     kworker: funcgraph_entry:  2.344 us    |   mutex_unlock();
     kworker: funcgraph_exit: $ 23871554 us | }

     The drain_vmap_area_work() spends over 23 seconds.

     There are 2805 flush_tlb_kernel_range() calls in the ftrace log.
       * One is called in __purge_vmap_area_lazy().
       * Others are called by purge_vmap_node->kasan_release_vmalloc.
         purge_vmap_node() iteratively releases kasan vmalloc
         allocations and flushes TLB for each vmap_area.
           - [Rough calculation] Each flush_tlb_kernel_range() runs
             about 7.5ms.
               -- 2804 * 7.5ms = 21.03 seconds.
               -- That's why a soft lock is triggered.

  2. Extending the soft lockup time can work around the issue (For example,
     # echo 60 > /proc/sys/kernel/watchdog_thresh). This confirms the
     above-mentioned speculation: drain_vmap_area_work() spends too much
     time.

If we combine all TLB flush operations of the KASAN shadow virtual
address into one operation in the call path
'purge_vmap_node()->kasan_release_vmalloc()', the running time of
drain_vmap_area_work() can be saved greatly. The idea is from the
flush_tlb_kernel_range() call in __purge_vmap_area_lazy(). And, the
soft lockup won't not be triggered.

Here is the test result based on 6.10:

[6.10 wo/ the patch]
  1. ftrace latency profiling (record a trace if the latency > 20s).
     echo 20000000 > /sys/kernel/debug/tracing/tracing_thresh
     echo drain_vmap_area_work > /sys/kernel/debug/tracing/set_graph_function
     echo function_graph > /sys/kernel/debug/tracing/current_tracer
     echo 1 > /sys/kernel/debug/tracing/tracing_on

  2. Run `make -j $(nproc)` to compile the kernel source

  3. Once the soft lockup is reproduced, check the ftrace log:
     cat /sys/kernel/debug/tracing/trace
        # tracer: function_graph
        #
        # CPU  DURATION                  FUNCTION CALLS
        # |     |   |                     |   |   |   |
          76) $ 50412985 us |    } /* __purge_vmap_area_lazy */
          76) $ 50412997 us |  } /* drain_vmap_area_work */
          76) $ 29165911 us |    } /* __purge_vmap_area_lazy */
          76) $ 29165926 us |  } /* drain_vmap_area_work */
          91) $ 53629423 us |    } /* __purge_vmap_area_lazy */
          91) $ 53629434 us |  } /* drain_vmap_area_work */
          91) $ 28121014 us |    } /* __purge_vmap_area_lazy */
          91) $ 28121026 us |  } /* drain_vmap_area_work */

[6.10 w/ the patch]
  1. Repeat step 1-2 in "[6.10 wo/ the patch]"

  2. The soft lockup is not triggered and ftrace log is empty.
     cat /sys/kernel/debug/tracing/trace
     # tracer: function_graph
     #
     # CPU  DURATION                  FUNCTION CALLS
     # |     |   |                     |   |   |   |

  3. Setting 'tracing_thresh' to 10/5 seconds does not get any ftrace
     log.

  4. Setting 'tracing_thresh' to 1 second gets ftrace log.
     cat /sys/kernel/debug/tracing/trace
     # tracer: function_graph
     #
     # CPU  DURATION                  FUNCTION CALLS
     # |     |   |                     |   |   |   |
       23) $ 1074942 us  |    } /* __purge_vmap_area_lazy */
       23) $ 1074950 us  |  } /* drain_vmap_area_work */

  The worst execution time of drain_vmap_area_work() is about 1 second.

Link: https://lore.kernel.org/lkml/ZqFlawuVnOMY2k3E@pc638.lan/
Fixes: 282631cb2447 ("mm: vmalloc: remove global purge_vmap_area_root rb-tree")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Tested-by: Jiwei Sun <sunjw10@lenovo.com>
---
 include/linux/kasan.h | 12 +++++++++---
 mm/kasan/shadow.c     | 14 ++++++++++----
 mm/vmalloc.c          | 34 ++++++++++++++++++++++++++--------
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 70d6a8f6e25d..2adea4fef153 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -29,6 +29,9 @@ typedef unsigned int __bitwise kasan_vmalloc_flags_t;
 #define KASAN_VMALLOC_VM_ALLOC		((__force kasan_vmalloc_flags_t)0x02u)
 #define KASAN_VMALLOC_PROT_NORMAL	((__force kasan_vmalloc_flags_t)0x04u)
 
+#define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply exsiting page range */
+#define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
+
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 #include <linux/pgtable.h>
@@ -511,7 +514,8 @@ void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
 int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
-			   unsigned long free_region_end);
+			   unsigned long free_region_end,
+			   unsigned long flags);
 
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
@@ -526,7 +530,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
 static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long end,
 					 unsigned long free_region_start,
-					 unsigned long free_region_end) { }
+					 unsigned long free_region_end,
+					 unsigned long flags) { }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
@@ -561,7 +566,8 @@ static inline int kasan_populate_vmalloc(unsigned long start,
 static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long end,
 					 unsigned long free_region_start,
-					 unsigned long free_region_end) { }
+					 unsigned long free_region_end,
+					 unsigned long flags) { }
 
 static inline void *kasan_unpoison_vmalloc(const void *start,
 					   unsigned long size,
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d6210ca48dda..88d1c9dcb507 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -489,7 +489,8 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
  */
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
-			   unsigned long free_region_end)
+			   unsigned long free_region_end,
+			   unsigned long flags)
 {
 	void *shadow_start, *shadow_end;
 	unsigned long region_start, region_end;
@@ -522,12 +523,17 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
 			return;
 		}
-		apply_to_existing_page_range(&init_mm,
+
+
+		if (flags & KASAN_VMALLOC_PAGE_RANGE)
+			apply_to_existing_page_range(&init_mm,
 					     (unsigned long)shadow_start,
 					     size, kasan_depopulate_vmalloc_pte,
 					     NULL);
-		flush_tlb_kernel_range((unsigned long)shadow_start,
-				       (unsigned long)shadow_end);
+
+		if (flags & KASAN_VMALLOC_TLB_FLUSH)
+			flush_tlb_kernel_range((unsigned long)shadow_start,
+					       (unsigned long)shadow_end);
 	}
 }
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e34ea860153f..bc21d821d506 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2186,6 +2186,25 @@ decay_va_pool_node(struct vmap_node *vn, bool full_decay)
 	reclaim_list_global(&decay_list);
 }
 
+static void
+kasan_release_vmalloc_node(struct vmap_node *vn)
+{
+	struct vmap_area *va;
+	unsigned long start, end;
+
+	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
+	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
+
+	list_for_each_entry(va, &vn->purge_list, list) {
+		if (is_vmalloc_or_module_addr((void *) va->va_start))
+			kasan_release_vmalloc(va->va_start, va->va_end,
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE);
+	}
+
+	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
+}
+
 static void purge_vmap_node(struct work_struct *work)
 {
 	struct vmap_node *vn = container_of(work,
@@ -2193,20 +2212,17 @@ static void purge_vmap_node(struct work_struct *work)
 	struct vmap_area *va, *n_va;
 	LIST_HEAD(local_list);
 
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
+		kasan_release_vmalloc_node(vn);
+
 	vn->nr_purged = 0;
 
 	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
-		unsigned long orig_start = va->va_start;
-		unsigned long orig_end = va->va_end;
 		unsigned int vn_id = decode_vn_id(va->flags);
 
 		list_del_init(&va->list);
 
-		if (is_vmalloc_or_module_addr((void *)orig_start))
-			kasan_release_vmalloc(orig_start, orig_end,
-					      va->va_start, va->va_end);
-
 		atomic_long_sub(nr, &vmap_lazy_nr);
 		vn->nr_purged++;
 
@@ -4726,7 +4742,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
-				va->va_start, va->va_end);
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
 		vas[area] = NULL;
 	}
 
@@ -4776,7 +4793,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 				&free_vmap_area_list);
 		if (va)
 			kasan_release_vmalloc(orig_start, orig_end,
-				va->va_start, va->va_end);
+				va->va_start, va->va_end,
+				KASAN_VMALLOC_PAGE_RANGE | KASAN_VMALLOC_TLB_FLUSH);
 		vas[area] = NULL;
 		kfree(vms[area]);
 	}
-- 
2.25.1


