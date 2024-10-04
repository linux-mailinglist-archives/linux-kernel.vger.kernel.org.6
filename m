Return-Path: <linux-kernel+bounces-350495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EAD990602
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587691C22033
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330C217337;
	Fri,  4 Oct 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw5RkPRr"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A820FAB3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051986; cv=none; b=F4YeOq3X+FzUaevhL/J3QQcejmJeMH7b3yT+IZsMcC2ZB2wGejlyshx1ZnkcmUzXBKPG7NrMma2QmV1RtAHQAGFPXzz0N2kwTsUmeCDC6Z/1yyxD+IU9zsPctxT4zEge6CnspEt3lBUIARF26mykg1PbGNN750OVgih74QdZWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051986; c=relaxed/simple;
	bh=SvVMiP5bYQccLlRibeNq7UvAIhgKNz5HarDP8qK3GxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gJfHvSbf33409/h5gkd66ipybuDiT1ES01BYE6zdes3GkvxH4dr50jwnoUabww9DISwfds60hX2ao8GWLlKCMBIAzfObCIDfQsH8xXuy4/8OWWvnzbAk5OLZnaneiBXKDc7cbpZ74Ed4/Gco1104NhmSBKJYpPYtytP62hZKzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw5RkPRr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b9b35c7c3so22444895ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728051984; x=1728656784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BqAmAYZW4h1IpzXArIG4D9TOPIIXqqCyLd+mnm6+QOk=;
        b=cw5RkPRroighPJbTxx1CzGh27cix1spgCRJxJ336VvyC/Vc6vNBHcJTR8xSjd0mkHE
         hwIalruiYaaU2fauvqMoONfF+iuMlwg+jG+FphsQWKc6n8DwlAsLDbXGSWEHl1Mxss8Y
         2CRoiKb07ia/C1GooQq0iRAVMzOZ+exHEVCu5Kd5ofst9rViSnx4qdkmPUHWFENi9vIz
         5WUvEuJNc5YXgn+VV6h0PRfaWSYU3+KR89zQcr1T8z2phe4gqDGFFrvEWos/bJtKWaqX
         jVYv7M7nRB0AD058SDTjhX/gZP+oyxq/6jtQmX64fl1oXKAHYS2mDjzG9AOekp0EET0e
         sFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728051984; x=1728656784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqAmAYZW4h1IpzXArIG4D9TOPIIXqqCyLd+mnm6+QOk=;
        b=a0uz2QJf/hJwM5RuQY/iTthUdhabIjlQAzxIAvzeHMbQ++Y4SNIz4TjDvmUZUPN29D
         t91O8+lhNP9UKdM8lN0QN28loWfOfsLHCmUnBjZG0A47ojg5LKdZFEzTRjmzOyLFJZiX
         8qqmVHibINwGiZWDLBLeLAYBSHA8/CBn3dJ0+ToysbYSR6apmZ1KnRBCQA6CQNrMRjEi
         JDmjNlDXxhjJfCSFMQ9KG09JDs5Ill7WW6uN+DiektISmfhvTlzQuGNAyaSIPJiVC8Y+
         C0K4xXafndjCx1U1Y70Qb5wbx1yNsnFKAggO2zUYHP/GgUWuvppMPPxVRehW3+XGZjiN
         ZcyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGDooHI1aLRoSksoaBy68YBz+O02LNCM77jOrQ5u+uIE9ISXLNSpxWNxWrZnZrQcvP4CzMiKHSZcgODSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTH41dHgvrpV1rojr0pnqobzxyeH7NkdrW/hQhE1oYOJdFx/N1
	BBJBRpMLwqO/HpC57PVBz1Xy3f/8dS8AxYd05qBpfuD8jxHGBGQV
X-Google-Smtp-Source: AGHT+IGslST/zpYraHv9EyvdMJno1O23Q/9gT9H3qesnxYgFQvTKjX2xZEbm8Ei5ysk/xwg6BRbg5w==
X-Received: by 2002:a17:903:11d0:b0:20b:6bf4:4acf with SMTP id d9443c01a7336-20bff074b06mr54117605ad.48.1728051984404;
        Fri, 04 Oct 2024 07:26:24 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefad02asm24448445ad.201.2024.10.04.07.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:26:23 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] mm: swap: prevent possible data-race in __try_to_reclaim_swap
Date: Fri,  4 Oct 2024 23:25:04 +0900
Message-Id: <20241004142504.4379-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A report [1] was uploaded from syzbot.

In the previous commit 862590ac3708 ("mm: swap: allow cache reclaim to skip 
slot cache"), the __try_to_reclaim_swap() function reads offset and nr_pages 
from folio without folio_lock protection. 

In the currently reported KCSAN log, it is assumed that the actual data-race 
will not occur because the calltrace that does WRITE already obtains the 
folio_lock and then writes. 

However, the existing __try_to_reclaim_swap() function was already implemented 
to perform reads under folio_lock protection [1], and there is a risk of a 
data-race occurring through a function other than the one shown in the KCSAN 
log. 

Therefore, I think it is appropriate to change all read operations for 
folio to be performed under folio_lock.

[1]

==================================================================
BUG: KCSAN: data-race in __delete_from_swap_cache / __try_to_reclaim_swap

write to 0xffffea0004c90328 of 8 bytes by task 5186 on cpu 0:
 __delete_from_swap_cache+0x1f0/0x290 mm/swap_state.c:163
 delete_from_swap_cache+0x72/0xe0 mm/swap_state.c:243
 folio_free_swap+0x1d8/0x1f0 mm/swapfile.c:1850
 free_swap_cache mm/swap_state.c:293 [inline]
 free_pages_and_swap_cache+0x1fc/0x410 mm/swap_state.c:325
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x2cf/0x440 mm/mmu_gather.c:373
 zap_pte_range mm/memory.c:1700 [inline]
 zap_pmd_range mm/memory.c:1739 [inline]
 zap_pud_range mm/memory.c:1768 [inline]
 zap_p4d_range mm/memory.c:1789 [inline]
 unmap_page_range+0x1f3c/0x22d0 mm/memory.c:1810
 unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
 unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
 exit_mmap+0x18a/0x690 mm/mmap.c:1864
 __mmput+0x28/0x1b0 kernel/fork.c:1347
 mmput+0x4c/0x60 kernel/fork.c:1369
 exit_mm+0xe4/0x190 kernel/exit.c:571
 do_exit+0x55e/0x17f0 kernel/exit.c:926
 do_group_exit+0x102/0x150 kernel/exit.c:1088
 get_signal+0xf2a/0x1070 kernel/signal.c:2917
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffffea0004c90328 of 8 bytes by task 5189 on cpu 1:
 __try_to_reclaim_swap+0x9d/0x510 mm/swapfile.c:198
 free_swap_and_cache_nr+0x45d/0x8a0 mm/swapfile.c:1915
 zap_pte_range mm/memory.c:1656 [inline]
 zap_pmd_range mm/memory.c:1739 [inline]
 zap_pud_range mm/memory.c:1768 [inline]
 zap_p4d_range mm/memory.c:1789 [inline]
 unmap_page_range+0xcf8/0x22d0 mm/memory.c:1810
 unmap_single_vma+0x142/0x1d0 mm/memory.c:1856
 unmap_vmas+0x18d/0x2b0 mm/memory.c:1900
 exit_mmap+0x18a/0x690 mm/mmap.c:1864
 __mmput+0x28/0x1b0 kernel/fork.c:1347
 mmput+0x4c/0x60 kernel/fork.c:1369
 exit_mm+0xe4/0x190 kernel/exit.c:571
 do_exit+0x55e/0x17f0 kernel/exit.c:926
 __do_sys_exit kernel/exit.c:1055 [inline]
 __se_sys_exit kernel/exit.c:1053 [inline]
 __x64_sys_exit+0x1f/0x20 kernel/exit.c:1053
 x64_sys_call+0x2d46/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:61
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000242 -> 0x0000000000000000

Reported-by: syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com
Fixes: 862590ac3708 ("mm: swap: allow cache reclaim to skip slot cache")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 mm/swapfile.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0cded32414a1..904c21256fc2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -193,13 +193,6 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	folio = filemap_get_folio(address_space, swap_cache_index(entry));
 	if (IS_ERR(folio))
 		return 0;
-
-	/* offset could point to the middle of a large folio */
-	entry = folio->swap;
-	offset = swp_offset(entry);
-	nr_pages = folio_nr_pages(folio);
-	ret = -nr_pages;
-
 	/*
 	 * When this function is called from scan_swap_map_slots() and it's
 	 * called by vmscan.c at reclaiming folios. So we hold a folio lock
@@ -210,6 +203,12 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (!folio_trylock(folio))
 		goto out;
 
+	/* offset could point to the middle of a large folio */
+	entry = folio->swap;
+	offset = swp_offset(entry);
+	nr_pages = folio_nr_pages(folio);
+	ret = -nr_pages;
+
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
 			((flags & TTRS_FULL) && mem_cgroup_swap_full(folio)));
--

