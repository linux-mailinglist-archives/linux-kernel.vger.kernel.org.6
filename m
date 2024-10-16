Return-Path: <linux-kernel+bounces-368281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906769A0DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C31284C76
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55220E000;
	Wed, 16 Oct 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jymln88U"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF754F95
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091286; cv=none; b=LyGik8P2tBriT5BIrrKS+GI9q324Tw/iR+lN3NflE2lde+WFmn9LFtDJceEcSPfHrOY+SVhkiK5r2hzw0p25aOmvNftKcAWhyx0V9bQ06ohDDNROMgIo1N7KyOl5UI0YxSnI33mrJ02WZ9klz59fQmcL7ou8HpEeLPKsUWWj6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091286; c=relaxed/simple;
	bh=Z+aAA1YVFXtBl05pU5c/121QeHDESV8r/TbdfNXoPb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ivATq5h0fuoSVk/gOu3zLju3IaXA7hqoYPukpcnRHlW516/4QVUklGYD9d8jkiQY/zXuxNZZ4GqacX08xVnacSzmu6ykXnaXe3qb1ZaWu10T6mg5Vy0SN+5PCavQovJJO06PSYsx/XcLxI//EbE/mqo2JdL5sA2Kk3XcuHerqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jymln88U; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e681ba70so16220e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729091283; x=1729696083; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PslRAyiixMy05hfv+pu0elRVVKFMTwH/kHV4AZcAZs=;
        b=Jymln88USYwl28zGRe/qK4hSYcbSyLt7vef0DFQJOrwbBxSAQNcgXfoG6pQm4zulCj
         EYrdKu4qFl4E5EWcwSHQXvHDK14ap62y6skSM3fW8sKuccSbTG9rySSBMDPnwO7nInwL
         rb+lB78hppi9QPqCqxOC0zab5kZlxVt961NL71qeDGGj4pPoVUqzgy/9q9j/TD3ucphG
         +tWmqbPt5neh9LlUpZJPQQvqiRhWW6LsnOYbRLFEmur9IUzmvt9dO8lp58Ug5F1db2YX
         qPtjkw8R0X1CIWC4Pk3g6mprmtq4dkrGOLra4NEYW4fIxQwDfGtNNbZoO6St2E5ZjwzW
         RyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729091283; x=1729696083;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PslRAyiixMy05hfv+pu0elRVVKFMTwH/kHV4AZcAZs=;
        b=Iyok86bcAZxO5EPdbhhaWfM1pLZW3FDTvEXiE3jAEFt+lFt/tDKyHoy4lU1+Ks2gKJ
         JPTWUTccbMttLpBqsj1C3BoBNs0/oxSptCDtEWM6X6A0nTzrl5Abxb7P3ERIEEExn2xi
         znRXaK73ZZ4AaCVGZur/AJp/bgiOjz7oITbBV7ZP2CT9V2sGGj4s/38fGyfytlcwZ+Px
         DTPoU01rDzMhvq1s0jHKFRZz3ipVSSgyZG2fHL5rieZ0gIsYe7ERnOb/WID+XfRL+z4z
         5sNzq7BwagTlyK1LQvTqJCpZRTcdh7Loxy4Y3r1ahiAYu1k9NKOIbrY6iRu5UCEAis1t
         ASRA==
X-Forwarded-Encrypted: i=1; AJvYcCWx8y1UTHXHj7GFfFNG8Cpwit0ne/rw4j1gx6XQbWL4BBlfOChifU9XkSVfCS3YpT2rZMZVGJQhKVkv4+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoF6+T2//W5vHXBp/bMEOrGQM/q1rKykjgBQeLcQdcSjNsRBFl
	HGa+YkW9OjGxB2pFuzMhq2Qn4YuOPcjD6GV8VnV3WkJeqEt0zQioyUm5Wx+SYwgElhwBZ9laQ0m
	RKubv
X-Google-Smtp-Source: AGHT+IE8qTbydoevA3YP8CtQdUFEfTyV1QlrGPTvMKHOFRvsY7d+9Jz+6u+5/v+W/grEx7Z43cy5Wg==
X-Received: by 2002:a05:6512:1092:b0:539:d0c4:5b53 with SMTP id 2adb3069b0e04-53a04d026a5mr642432e87.4.1729091282178;
        Wed, 16 Oct 2024 08:08:02 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:a496:e3cd:3667:2787])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c767csm52155285e9.48.2024.10.16.08.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:08:00 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 16 Oct 2024 17:07:53 +0200
Subject: [PATCH fix 6.12] mm: mark mas allocation in vms_abort_munmap_vmas
 as __GFP_NOFAIL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fix-munmap-abort-v1-1-601c94b2240d@google.com>
X-B4-Tracking: v=1; b=H4sIAMjWD2cC/x2MQQ6DMAwEvxL5XKPYqXLgK6gH05riAwElLaqE+
 HstbjPS7B7QtJo26MMBVXdrthYXugV4zlLeivZyB458p0gZJ/vh8i2LbCjjWj/IKcUxU0osAj7
 bqnpzXQ7gFHJHDI/z/AO5lIbdbAAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729091278; l=6984;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Z+aAA1YVFXtBl05pU5c/121QeHDESV8r/TbdfNXoPb8=;
 b=qOgRxn5GRAhrrVyL6Of2U5YlGDeq3PvmgjTLpJnUdsaVm1Mv/uWaa0L7e7IRhHGHA2+O2jMEA
 CnDYlXRiESIAh0wpolV7ehPyIeM3AfZcdn8XGhZ+LlBi4c8JS88iXzl
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

vms_abort_munmap_vmas() is a recovery path where, on entry, some VMAs
have already been torn down halfway (in a way we can't undo) but are
still present in the maple tree.

At this point, we *must* remove the VMAs from the VMA tree, otherwise
we get UAF.

Because removing VMA tree nodes can require memory allocation, the
existing code has an error path which tries to handle this by
reattaching the VMAs; but that can't be done safely.

A nicer way to fix it would probably be to preallocate enough maple
tree nodes for the removal before the point of no return, or something
like that; but for now, fix it the easy and kinda ugly way, by marking
this allocation __GFP_NOFAIL.

Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring the gap on failure")
Signed-off-by: Jann Horn <jannh@google.com>
---
This can be tested with the following reproducer (on a kernel built with
CONFIG_KASAN=y, CONFIG_FAILSLAB=y, CONFIG_FAULT_INJECTION_DEBUG_FS=y,
with the reproducer running as root):

```

  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

static void write_file(char *name, char *buf) {
  int fd = open(name, O_WRONLY);
  if (fd == -1)
    err(1, "unable to open for writing: %s", name);
  if (SYSCHK(write(fd, buf, strlen(buf))) != strlen(buf))
    errx(1, "write %s", name);
  SYSCHK(close(fd));
}

int main(void) {
  // make a large area with a bunch of VMAs
  char *area = SYSCHK(mmap(NULL, AREA_SIZE, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0));
  for (int off=0; off<AREA_SIZE; off += 0x2000)
    SYSCHK(mmap(area+off, 0x1000, PROT_READ, MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, -1, 0));

  // open a file whose mappings use usbdev_vm_ops, and map it in part of this area
  int map_fd = SYSCHK(open("/dev/bus/usb/001/001", O_RDONLY));
  void *map = SYSCHK(mmap(area, 0x1000, PROT_READ, MAP_SHARED|MAP_FIXED, map_fd, 0));
  close(map_fd);

  // make RWX mapping request fail late
  SYSCHK(prctl(65/*PR_SET_MDWE*/, 1/*PR_MDWE_REFUSE_EXEC_GAIN*/, 0, 0, 0));

  // some random other file
  int fd = SYSCHK(open("/etc/passwd", O_RDONLY));

  /* disarm for now */
  write_file("/sys/kernel/debug/failslab/probability", "0");

  /* fail allocations of maple_node... */
  write_file("/sys/kernel/debug/failslab/cache-filter", "Y");
  write_file("/sys/kernel/slab/maple_node/failslab", "1");
  /* ... even though it's a sleepable allocation... */
  write_file("/sys/kernel/debug/failslab/ignore-gfp-wait", "N");
  /* ... in this task... */
  write_file("/sys/kernel/debug/failslab/task-filter", "Y");
  write_file("/proc/self/make-it-fail", "1");
  /* ... every time... */
  write_file("/sys/kernel/debug/failslab/times", "-1");
  /* ... after 8 successful allocations (value chosen experimentally)... */
  write_file("/sys/kernel/debug/failslab/space", "2048"); // one object is 256
  /* ... and print where the allocations actually failed... */
  write_file("/sys/kernel/debug/failslab/verbose", "2");
  /* ... and that's it, arm it */
  write_file("/sys/kernel/debug/failslab/probability", "100");

  // This mmap request will fail late due to MDWE.
  // The error recovery path will attempt to clear out the VMA pointers with a
  // spanning_store (which will be blocked by error injection).
  mmap(area, AREA_SIZE, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, fd, 0);

  /* disarm */
  write_file("/sys/kernel/debug/failslab/probability", "0");

  SYSCHK(munmap(map, 0x1000)); // UAF expected here
  system("cat /proc/$PPID/maps");
}
```

Result:
```
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 100, space 256, times -1
CPU: 3 UID: 0 PID: 607 Comm: unmap-fail Not tainted 6.12.0-rc3-00013-geca631b8fe80 #518
[...]
Call Trace:
 <TASK>
 dump_stack_lvl+0x80/0xa0
 should_fail_ex+0x4d3/0x5c0
[...]
 should_failslab+0xc7/0x130
 kmem_cache_alloc_noprof+0x73/0x3a0
[...]
 mas_alloc_nodes+0x3a3/0x690
 mas_nomem+0xaa/0x1d0
 mas_store_gfp+0x515/0xa80
[...]
 mmap_region+0xa96/0x2590
[...]
 do_mmap+0x71e/0xfe0
[...]
 vm_mmap_pgoff+0x17a/0x2f0
[...]
 ksys_mmap_pgoff+0x2ee/0x460
 do_syscall_64+0x68/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
[...]
 </TASK>
mmap: unmap-fail: (607) Unable to abort munmap() operation
==================================================================
BUG: KASAN: slab-use-after-free in dec_usb_memory_use_count+0x365/0x430
Read of size 8 at addr ffff88810e9ba8b8 by task unmap-fail/607

CPU: 3 UID: 0 PID: 607 Comm: unmap-fail Not tainted 6.12.0-rc3-00013-geca631b8fe80 #518
[...]
Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x670
[...]
 kasan_report+0xf7/0x130
[...]
 dec_usb_memory_use_count+0x365/0x430
 remove_vma+0x76/0x120
 vms_complete_munmap_vmas+0x447/0x750
 do_vmi_align_munmap+0x4b9/0x700
[...]
 do_vmi_munmap+0x164/0x2e0
 __vm_munmap+0x128/0x2a0
[...]
 __x64_sys_munmap+0x59/0x80
 do_syscall_64+0x68/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
[...]
 </TASK>

Allocated by task 607:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 usbdev_mmap+0x1a0/0xaf0
 mmap_region+0xf6e/0x2590
 do_mmap+0x71e/0xfe0
 vm_mmap_pgoff+0x17a/0x2f0
 ksys_mmap_pgoff+0x2ee/0x460
 do_syscall_64+0x68/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 607:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x4f/0x70
 kfree+0x148/0x450
 vms_clean_up_area+0x188/0x220
 mmap_region+0xf1b/0x2590
 do_mmap+0x71e/0xfe0
 vm_mmap_pgoff+0x17a/0x2f0
 ksys_mmap_pgoff+0x2ee/0x460
 do_syscall_64+0x68/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
[...]
==================================================================
```
---
 mm/vma.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/vma.h b/mm/vma.h
index 819f994cf727..ebd78f1577f3 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -241,15 +241,9 @@ static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
 	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
 	 */
 	mas_set_range(mas, vms->start, vms->end - 1);
-	if (unlikely(mas_store_gfp(mas, NULL, GFP_KERNEL))) {
-		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
-			     current->comm, current->pid);
-		/* Leaving vmas detached and in-tree may hamper recovery */
-		reattach_vmas(mas_detach);
-	} else {
-		/* Clean up the insertion of the unfortunate gap */
-		vms_complete_munmap_vmas(vms, mas_detach);
-	}
+	mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
+	/* Clean up the insertion of the unfortunate gap */
+	vms_complete_munmap_vmas(vms, mas_detach);
 }
 
 int

---
base-commit: eca631b8fe808748d7585059c4307005ca5c5820
change-id: 20241016-fix-munmap-abort-2330b61332aa
-- 
Jann Horn <jannh@google.com>


