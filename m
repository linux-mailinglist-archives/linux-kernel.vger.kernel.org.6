Return-Path: <linux-kernel+bounces-521400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE5AA3BCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4617A6008
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7701DEFE5;
	Wed, 19 Feb 2025 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOV6k1GX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC91B4F0C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964336; cv=none; b=FeXJZlWhNn2euX6eM5TKvVJxJVI56prjxbJDMATvv93kZBpgCqqoZQmzdwmOP4x2dVuuhnD5JyCicBVyoB2+fpaC+WSfdftDObvGU79N99+9DfTv+aEQTnIwG3DuffPcKzGR2glcow1vvPAELwLyzcY7dlVhJrg3fEK6fFZgP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964336; c=relaxed/simple;
	bh=NOye59Erp/+KOU3xqQ3tG8KF99TMasOhT5RvzxMHDxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gOePKzph68EqhIIf3rFAZ4J6+Q4p9j2P1iZhGJOzOi8+QSazXW6cRbBPtLRzRqmI3b8N1UZDmVeNhBpgL/lYW+EdHvPCylitiaYAP+G6nKoMestEhMZybKWpZYlzZUVfPDkQpzMbjyHNvOW+aUzCQisdzX+GsKuaIzgV86O6IK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOV6k1GX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f2339dcfdso11957665ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739964333; x=1740569133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb3qjAdIKb0cGpN4NTEEcHe/MgWIebClO9nvYHKBt2c=;
        b=gOV6k1GXUrqopOgr936SBPXejLeQ8JdPyGhipKFP1B2r5qVFbVMcRGWwMw3MG5gZJf
         eRDDwfUUR9z4yjoYwhBNeG3k4eTNADqHCmlpqG+sPyqmgxyD8kaXqyVhxluHF2fut+22
         1Tv22SxBy97HjS90tFV0AOjJ0sYsN0/0MW29QepMgOReJbJQyWoHW75GuyQrus9saRJv
         lDqfhWMz1znabb6G9dNtudV4ESdaLHDB5OFNJR8eqXEwIofZ7nYr5qmIoOjNqwsikE9B
         JMGTQnFhN5RNW/qk0kSrtiKn6OdUH6pIe5oa8t5RFqgh2mJOux3Bx+056MC3a0IbW9yD
         Au2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739964333; x=1740569133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eb3qjAdIKb0cGpN4NTEEcHe/MgWIebClO9nvYHKBt2c=;
        b=xTaxIa15X9n0pk6rujKiW702IEC/3K9ZCuVyV5uiUaAoQSZjdQmPxVMQf2ZUgG15Qs
         iYXOBsPVj0iwDifl8fX73PxwX75AylHO+1mS3BnvrXzwThyrlQRHJwsyQ58Jj0TiHp4r
         uIiSq3Txf453pYckH7Gdjptek/YiJoMAlYTixrtqblo00eV6LosuHAsUP8x9aSyTRyZA
         YK/tWV8l4EYTlVnE1zDBW4ecfsg1EDFLmBjU2Ukg0oXgRIk7J6DI9P2Ye49d8hx/K1JJ
         Yb9MW3Y4impyhBsen128BBWT/PYJ1CCTdcFv5H8Zoz0oyM7BFXEEmkZ0/yWSnAEy2lpe
         hlRg==
X-Gm-Message-State: AOJu0Yx5WZEYJsFC2vryZx/vI4uHxdY4qWjwGQUhmflMSkQFmlt/hpuG
	YqqeJomJiLn9QXU1HN1UZ98xsausti5keEE3xpALIvTwkhDiEjiP
X-Gm-Gg: ASbGncufc6PYn2OTMgrImABNC/OjhNgv0ek32+YzdODPC1Y4KuIpLMARYdsAgILjsYt
	DbJcvj7fsl61EbaVrw9O1/JiyjHv72Fn1Ie/qkky5wBTowkIyrYWju2oIMihcuIgvLEpfqiq69q
	s3F5TWMSUcQv/y9EjH0RL+3gbaXCmdesnH+KbW30Z5SVMbc8uqUmzAkE6kytDt3dz1V6wY9zIKP
	E1yLNARtP0T0IrBvffrGjzcYsG96o5RcYOytnNLBmmZEnF4DziyzhRrBmAS4nZN+1U/73SVtRS7
	jDtDBoji28GKzGU8FPTk1r0xaSySNKg+
X-Google-Smtp-Source: AGHT+IF8kNT2MetyoLuxF9ILx52K0ftVCLidA67ewR5lWC8LU67l4Cc0GQJorlauNh1IkgSBpGIeuw==
X-Received: by 2002:a17:902:f612:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-2216ee83a79mr58769555ad.1.1739964333330;
        Wed, 19 Feb 2025 03:25:33 -0800 (PST)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491ecsm102728565ad.9.2025.02.19.03.25.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Feb 2025 03:25:32 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	zhengtangquan@oppo.com,
	Barry Song <v-songbaohua@oppo.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nicolas Geoffray <ngeoffray@google.com>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
Date: Thu, 20 Feb 2025 00:25:19 +1300
Message-Id: <20250219112519.92853-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

userfaultfd_move() checks whether the PTE entry is present or a
swap entry.

- If the PTE entry is present, move_present_pte() handles folio
  migration by setting:

  src_folio->index = linear_page_index(dst_vma, dst_addr);

- If the PTE entry is a swap entry, move_swap_pte() simply copies
  the PTE to the new dst_addr.

This approach is incorrect because even if the PTE is a swap
entry, it can still reference a folio that remains in the swap
cache.

If do_swap_page() is triggered, it may locate the folio in the
swap cache. However, during add_rmap operations, a kernel panic
can occur due to:
 page_pgoff(folio, page) != linear_page_index(vma, address)

$./a.out > /dev/null
[   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
[   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
[   13.337716] memcg:ffff00000405f000
[   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
[   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
[   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
[   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
[   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
[   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
[   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
[   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
[   13.340190] ------------[ cut here ]------------
[   13.340316] kernel BUG at mm/rmap.c:1380!
[   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[   13.340969] Modules linked in:
[   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
[   13.341470] Hardware name: linux,dummy-virt (DT)
[   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
[   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
[   13.342018] sp : ffff80008752bb20
[   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
[   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
[   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
[   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
[   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
[   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
[   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
[   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
[   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
[   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
[   13.343876] Call trace:
[   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
[   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
[   13.344333]  do_swap_page+0x1060/0x1400
[   13.344417]  __handle_mm_fault+0x61c/0xbc8
[   13.344504]  handle_mm_fault+0xd8/0x2e8
[   13.344586]  do_page_fault+0x20c/0x770
[   13.344673]  do_translation_fault+0xb4/0xf0
[   13.344759]  do_mem_abort+0x48/0xa0
[   13.344842]  el0_da+0x58/0x130
[   13.344914]  el0t_64_sync_handler+0xc4/0x138
[   13.345002]  el0t_64_sync+0x1ac/0x1b0
[   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
[   13.345504] ---[ end trace 0000000000000000 ]---
[   13.345715] note: a.out[107] exited with irqs disabled
[   13.345954] note: a.out[107] exited with preempt_count 2

Fully fixing it would be quite complex, requiring similar handling
of folios as done in move_present_pte. For now, a quick solution
is to return -EBUSY.
I'd like to see others' opinions on whether a full fix is worth
pursuing.

For anyone interested in reproducing it, the a.out test program is
as below,

 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 #include <sys/syscall.h>
 #include <linux/userfaultfd.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <unistd.h>
 #include <poll.h>
 #include <errno.h>

 #define PAGE_SIZE 4096
 #define REGION_SIZE (512 * 1024)

 #ifndef UFFDIO_MOVE
 struct uffdio_move {
     __u64 dst;
     __u64 src;
     __u64 len;
     #define UFFDIO_MOVE_MODE_DONTWAKE        ((__u64)1<<0)
     #define UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES ((__u64)1<<1)
     __u64 mode;
     __s64 move;
 };
 #define _UFFDIO_MOVE  (0x05)
 #define UFFDIO_MOVE   _IOWR(UFFDIO, _UFFDIO_MOVE, struct uffdio_move)
 #endif

 void *src, *dst;
 int uffd;

 void *madvise_thread(void *arg) {
     if (madvise(src, REGION_SIZE, MADV_PAGEOUT) == -1) {
         perror("madvise MADV_PAGEOUT");
     }
     return NULL;
 }

 void *fault_handler_thread(void *arg) {
     struct uffd_msg msg;
     struct uffdio_move move;
     struct pollfd pollfd = { .fd = uffd, .events = POLLIN };

     pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
     pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);

     while (1) {
         if (poll(&pollfd, 1, -1) == -1) {
             perror("poll");
             exit(EXIT_FAILURE);
         }

         if (read(uffd, &msg, sizeof(msg)) <= 0) {
             perror("read");
             exit(EXIT_FAILURE);
         }

         if (msg.event != UFFD_EVENT_PAGEFAULT) {
             fprintf(stderr, "Unexpected event\n");
             exit(EXIT_FAILURE);
         }

         move.src = (unsigned long)src + (msg.arg.pagefault.address - (unsigned long)dst);
         move.dst = msg.arg.pagefault.address & ~(PAGE_SIZE - 1);
         move.len = PAGE_SIZE;
         move.mode = 0;

         if (ioctl(uffd, UFFDIO_MOVE, &move) == -1) {
             perror("UFFDIO_MOVE");
             exit(EXIT_FAILURE);
         }
     }
     return NULL;
 }

 int main() {
 again:
     pthread_t thr, madv_thr;
     struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
     struct uffdio_register uffdio_register;

     src = mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
     if (src == MAP_FAILED) {
         perror("mmap src");
         exit(EXIT_FAILURE);
     }
     memset(src, 1, REGION_SIZE);

     dst = mmap(NULL, REGION_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
     if (dst == MAP_FAILED) {
         perror("mmap dst");
         exit(EXIT_FAILURE);
     }

     uffd = syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK);
     if (uffd == -1) {
         perror("userfaultfd");
         exit(EXIT_FAILURE);
     }

     if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
         perror("UFFDIO_API");
         exit(EXIT_FAILURE);
     }

     uffdio_register.range.start = (unsigned long)dst;
     uffdio_register.range.len = REGION_SIZE;
     uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;

     if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
         perror("UFFDIO_REGISTER");
         exit(EXIT_FAILURE);
     }

     if (pthread_create(&madv_thr, NULL, madvise_thread, NULL) != 0) {
         perror("pthread_create madvise_thread");
         exit(EXIT_FAILURE);
     }

     if (pthread_create(&thr, NULL, fault_handler_thread, NULL) != 0) {
         perror("pthread_create fault_handler_thread");
         exit(EXIT_FAILURE);
     }

     for (size_t i = 0; i < REGION_SIZE; i += PAGE_SIZE) {
         char val = ((char *)dst)[i];
         printf("Accessing dst at offset %zu, value: %d\n", i, val);
     }

     pthread_join(madv_thr, NULL);
     pthread_cancel(thr);
     pthread_join(thr, NULL);

     munmap(src, REGION_SIZE);
     munmap(dst, REGION_SIZE);
     close(uffd);
     goto again;
     return 0;
 }

As long as you enable mTHP (which likely increases the residency
time of swapcache), you can reproduce the issue within a few
seconds. But I guess the same race condition also exists with
small folios.

Fixes: adef440691bab ("userfaultfd: UFFDIO_MOVE uABI")
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Nicolas Geoffray <ngeoffray@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: ZhangPeng <zhangpeng362@huawei.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/userfaultfd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 867898c4e30b..34cf1c8c725d 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -18,6 +18,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include "internal.h"
+#include "swap.h"
 
 static __always_inline
 bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
@@ -1079,9 +1080,19 @@ static int move_swap_pte(struct mm_struct *mm,
 			 pmd_t *dst_pmd, pmd_t dst_pmdval,
 			 spinlock_t *dst_ptl, spinlock_t *src_ptl)
 {
+	struct folio *folio;
+	swp_entry_t entry;
+
 	if (!pte_swp_exclusive(orig_src_pte))
 		return -EBUSY;
 
+	entry = pte_to_swp_entry(orig_src_pte);
+	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
+	if (!IS_ERR(folio)) {
+		folio_put(folio);
+		return -EBUSY;
+	}
+
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
-- 
2.39.3 (Apple Git-146)


