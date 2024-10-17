Return-Path: <linux-kernel+bounces-369555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BAC9A1EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9609D1F26212
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567F1DA632;
	Thu, 17 Oct 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DJP7kB6t"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F701D9A40
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158471; cv=none; b=dEvAOH10tkpEySE/N9p4+1JJJaVXTqa5FMS1Q52LaHnF+/Vu1gZIDflmHlu3mtW8QACDyorsFc11spYzPOWL06YGXIY0Jw9md2H238uhBNQcWaJbuAd6OT+xpkyKa0UoyZYTyHY+ZBWnwMc2WKqYwis8vMUQ66cpKNnbZ1MDqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158471; c=relaxed/simple;
	bh=Ey4hkJfeuepSmpGBsIu6nk+9hLwceJu2S1dOO0uow7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JVym11Q6vy6w/PUz6Wq8HPEO1moW0sB4/xlolBQl+tgszRfxpbTD+MPga/FtsyqBcNg7SSnB6tGEfDMyWc5oP7Z2hQku/7RH8V3BDuuTJMpVPV8WIpca5OgF0fAKiICMLm01M7TmjgiEj+LmmaNamfC/suEvs3d+H9Q1BY8QXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DJP7kB6t; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso610167a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729158469; x=1729763269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Her0gSR4BBHnMz6qkjoFdQSLfH6EB46Dm9TwWv8aciM=;
        b=DJP7kB6tfIPs7mCsy5pVyJT1O0bk80aUR74nnc9WAZmg5L9jkBSmiHrFz92XxWHrqg
         7ZvAtYT0t7DKxgmgMlxBCMDjKb5WdGutlUE+pwHKCYRHVfNB/Vs6IdjjaDClZrDZ6jYq
         hm4MbxRJhWvZ7xK9iK5M6Q3W8o7q+jKl2Zq15RApS7YRV/gYLGLiiyiBLyT5dTUdPan7
         o2JaFkTqK64b5E8/07wB2hXMKN76ZZkEh65U4bNMy6MFvBFArvcvYvXrkYwJMO8azcnI
         canmos7XELhlZne/X+sD7tooVFSASE+ziR6IxjEyCcePz/LkoVfviVlz0yoeV6PrRGQh
         jqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158469; x=1729763269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Her0gSR4BBHnMz6qkjoFdQSLfH6EB46Dm9TwWv8aciM=;
        b=SQOHCQAIgxGjg4l0HKnUV4D8eKWg3hrZke5qfrdYM/ICql5EUoVnRl2tDeiR7Yfhsx
         wmdpUEJhU+veDHD5hoPcpn9yfou+gsiZreRY+Y+kvTD/3d0dyx6XZo5WioLv5t3wOuwv
         hycuOJOkthp5fpR/aakqt/4hom6fTqy2U+IL3pXYwrsr8ChpCAXSmj4vickPlKDvHgoZ
         CdEE+/9wRJWNklTfwmB/GD9mZF4M6/FngGwkiFCWd2bU3X1z6bdynCF2ZtRzRPP1kQK/
         m/JaZ+uD55Cu6aGBAJT6FrINsG4z8/IhqJcHG2BR6BiTZq/bdi17QHsUEuLs7xtZsPG5
         L9Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVtbabqmdQt5D0Wf0hVdJU2Q8IhQ/nbWBEY/DjnmVu3KQNCE8f7N2N9JXnC43Al9ucAcDOVm6mY/xAFwgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxod23v4lwrP5SyfX8EDkyZXTFQyLlPpWCK+iV4muB7He+lJ5SY
	5LjU/HlV9OUYJlmSnVt8XmbThUmLSXJZ+TBJUObdEr9AvEX4tRRfFyu3nHQuPMs=
X-Google-Smtp-Source: AGHT+IE1v6XXIN4uy6wpGXlNlRaRH/EFn1RgvKGG6B8slpDy+FU4v/9ncWciKSoJRaJla+Op+ATmuw==
X-Received: by 2002:a05:6a20:cfa5:b0:1d2:f09e:c15b with SMTP id adf61e73a8af0-1d8bcf42381mr31104053637.25.1729158469098;
        Thu, 17 Oct 2024 02:47:49 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4218sm4385365b3a.120.2024.10.17.02.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:47:48 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	jannh@google.com,
	peterx@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 0/7] synchronously scan and reclaim empty user PTE pages
Date: Thu, 17 Oct 2024 17:47:19 +0800
Message-Id: <cover.1729157502.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v1:
 - replace [RFC PATCH 1/7] with a separate serise (already merge into mm-unstable):
   https://lore.kernel.org/lkml/cover.1727332572.git.zhengqi.arch@bytedance.com/
   (suggested by David Hildenbrand)
 - squash [RFC PATCH 2/7] into [RFC PATCH 4/7]
   (suggested by David Hildenbrand)
 - change to scan and reclaim empty user PTE pages in zap_pte_range()
   (suggested by David Hildenbrand)
 - sent a separate RFC patch to track the tlb flushing issue, and remove
   that part form this series ([RFC PATCH 3/7] and [RFC PATCH 6/7]).
   link: https://lore.kernel.org/lkml/20240815120715.14516-1-zhengqi.arch@bytedance.com/
 - add [PATCH v1 1/7] into this series
 - drop RFC tag
 - rebase onto the next-20241011

Changes in RFC v2:
 - fix compilation errors in [RFC PATCH 5/7] and [RFC PATCH 7/7] reproted by
   kernel test robot
 - use pte_offset_map_nolock() + pmd_same() instead of check_pmd_still_valid()
   in retract_page_tables() (in [RFC PATCH 4/7])
 - rebase onto the next-20240805

Hi all,

Previously, we tried to use a completely asynchronous method to reclaim empty
user PTE pages [1]. After discussing with David Hildenbrand, we decided to
implement synchronous reclaimation in the case of madvise(MADV_DONTNEED) as the
first step.

So this series aims to synchronously free the empty PTE pages in
madvise(MADV_DONTNEED) case. We will detect and free empty PTE pages in
zap_pte_range(), and will add zap_details.reclaim_pt to exclude cases other than
madvise(MADV_DONTNEED).

In zap_pte_range(), mmu_gather is used to perform batch tlb flushing and page
freeing operations. Therefore, if we want to free the empty PTE page in this
path, the most natural way is to add it to mmu_gather as well. Now, if
CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected, mmu_gather will free page table
pages by semi RCU:

 - batch table freeing: asynchronous free by RCU
 - single table freeing: IPI + synchronous free

But this is not enough to free the empty PTE page table pages in paths other
that munmap and exit_mmap path, because IPI cannot be synchronized with
rcu_read_lock() in pte_offset_map{_lock}(). So we should let single table also
be freed by RCU like batch table freeing.

As a first step, we supported this feature on x86_64 and selectd the newly
introduced CONFIG_ARCH_SUPPORTS_PT_RECLAIM.

For other cases such as madvise(MADV_FREE), consider scanning and freeing empty
PTE pages asynchronously in the future.

This series is based on next-20241011 (which contains the series [2]).

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/lkml/cover.1718267194.git.zhengqi.arch@bytedance.com/
[2]. https://lore.kernel.org/lkml/cover.1727332572.git.zhengqi.arch@bytedance.com/

Qi Zheng (7):
  mm: khugepaged: retract_page_tables() use pte_offset_map_lock()
  mm: make zap_pte_range() handle full within-PMD range
  mm: zap_install_uffd_wp_if_needed: return whether uffd-wp pte has been
    re-installed
  mm: zap_present_ptes: return whether the PTE page is unreclaimable
  mm: pgtable: try to reclaim empty PTE page in madvise(MADV_DONTNEED)
  x86: mm: free page table pages by RCU instead of semi RCU
  x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64

 arch/x86/Kconfig           |  1 +
 arch/x86/include/asm/tlb.h | 19 ++++++++
 arch/x86/kernel/paravirt.c |  7 +++
 arch/x86/mm/pgtable.c      | 10 +++-
 include/linux/mm.h         |  1 +
 include/linux/mm_inline.h  | 11 +++--
 mm/Kconfig                 | 14 ++++++
 mm/Makefile                |  1 +
 mm/internal.h              | 29 ++++++++++++
 mm/khugepaged.c            |  9 +++-
 mm/madvise.c               |  4 +-
 mm/memory.c                | 95 +++++++++++++++++++++++++++++---------
 mm/mmu_gather.c            |  9 +++-
 mm/pt_reclaim.c            | 68 +++++++++++++++++++++++++++
 14 files changed, 248 insertions(+), 30 deletions(-)
 create mode 100644 mm/pt_reclaim.c

-- 
2.20.1


