Return-Path: <linux-kernel+bounces-352865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B6599255C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0122328274B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F5161326;
	Mon,  7 Oct 2024 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1mMKA6K"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157F6FC5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284791; cv=none; b=Hj0mjP+we2iBqSKRViQplEN3xnz41sMqVz7KdZHEqr4/vhj3+Tma5h+S45N3dvvOvAEw6tB6qoDuaIx2wVvWklH8A0/QeaduTeF0z5dX4J2nZlN/uasV2h/7QHZzG3LA/eMwYDuBW4h9ZYEbRqxB/VzYelHxf6RNHAPOmrpSu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284791; c=relaxed/simple;
	bh=fSFvLxoaHYBGEdI9wiT8ioVnGQYK80+KmdHNwN9bBCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H+gVZpYca5kKJUc5slmxlQ95e/OuFrTUSGTPmUNsCRyt/gcS/ICjgOzYAt0fy2cDzR75vxtvCfHDKc3j/NccdaQYYSxMSLsxP2EXRqF2wY0q4BooWbIUXaurAfg4Y0ZS86LQYL+VTq2VcclrFpIHGyuHy734pOzuOpdgnMxpKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1mMKA6K; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b64584fd4so37948575ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728284789; x=1728889589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXdcYSBgFk717u+cFxiYU6BpkH6yI82U7KUgndIaZDk=;
        b=Y1mMKA6KxbMd8FKLTHYP+9Rz8+357t6B422Nf3v/WylkfdGogr6uVszGwe2j0dzWnI
         NxYdrv9IqB3jbzskmht6KZTGfZjpH7LNHYveWCUVFlogROcMUIBzaFOd+BjCsS0PGxh1
         tmI8oyQ1n30NbBSG16Qi8FpBOBRWcTosc4WLs7xMNv9HE8nGODSE8QvPRfBzXNEc0tyy
         rfD/h4cGaNmdcQCTWPwlefOdCKg+aaJc3IBcFwD5/azQoHsYsoHBGGGXgaEAEmIYlFmB
         juANnx8e8pFGzD7sDaV+qjtTNqyXCi69HlQfUsjYuyo40h7wIxz3IWX+4WDh8fw+Zsf3
         1mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728284789; x=1728889589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXdcYSBgFk717u+cFxiYU6BpkH6yI82U7KUgndIaZDk=;
        b=vvT2k5a+uroRtSrjkRbmR4hegmhdoi5+zf5moV/UKlE28LiIgeGBP3QAlE/BU3ZDkR
         ODaluvuxnd+lYNkQYFlQUXo12LOSEUZX9cMasU2ovO4IK9VIafX1VdkkiPZNfFdPuSKG
         hSntzV8BE6NllwGM1ulHPsL551NXsLV20xMy2sPy6KojGkxm6ro2PCJwoxcOEgnvlXh9
         zcX7sQEyr8N8o8uBhATgKXYtu6POb4Td9EefrFle/3e5ClLWbpy+ulMpvFLfQYzkNENH
         APS8W/6RVzvveycQy3VKdpd+6eH7XtqC+g2UscUSQIZWMh1oX4XdmYPFNvR5Yxa0f74h
         /v9g==
X-Forwarded-Encrypted: i=1; AJvYcCWYz8DbW0YgQOu0APTQ86jDzSp+pyXS/QySQzS8VsXFtzjv8ePucjCvzndmpX6avkZsT2BILhe+6mF0Ihg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqIlPinjAZBIVNG49X36iMwvWAiC9Qaqbf47e2CGky032eDqi
	8g1wySm3sLFRCiH52j1Nv9hM1m73xvb9NhoKBEM0yRdAlRM0BOE4
X-Google-Smtp-Source: AGHT+IEPv8d7zsOCOMruREtYLEajSg4cLxNN7LodM5DIZwlRj9z75EHh2vpKy9joAT9mBtOdHEuHjw==
X-Received: by 2002:a17:90a:3002:b0:2e0:a28a:ef88 with SMTP id 98e67ed59e1d1-2e1e63bc02bmr10403056a91.41.1728284789452;
        Mon, 07 Oct 2024 00:06:29 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f7690sm4568033a91.42.2024.10.07.00.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:06:29 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	ryncsn@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] mm: swap: prevent possible data-race in __try_to_reclaim_swap
Date: Mon,  7 Oct 2024 16:06:23 +0900
Message-Id: <20241007070623.23340-1-aha310510@gmail.com>
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
slot cache"), the __try_to_reclaim_swap() function reads offset and folio->entry 
from folio without folio_lock protection. 

In the currently reported KCSAN log, it is assumed that the actual data-race 
will not occur because the calltrace that does WRITE already obtains the 
folio_lock and then writes. 

However, the existing __try_to_reclaim_swap() function was already implemented 
to perform reads under folio_lock protection [1], and there is a risk of a 
data-race occurring through a function other than the one shown in the KCSAN 
log. 

Therefore, I think it is appropriate to change read operations for 
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
 mm/swapfile.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0cded32414a1..eb782fcd5627 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -194,9 +194,6 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (IS_ERR(folio))
 		return 0;
 
-	/* offset could point to the middle of a large folio */
-	entry = folio->swap;
-	offset = swp_offset(entry);
 	nr_pages = folio_nr_pages(folio);
 	ret = -nr_pages;
 
@@ -210,6 +207,10 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (!folio_trylock(folio))
 		goto out;
 
+	/* offset could point to the middle of a large folio */
+	entry = folio->swap;
+	offset = swp_offset(entry);
+
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
 			((flags & TTRS_FULL) && mem_cgroup_swap_full(folio)));
--

