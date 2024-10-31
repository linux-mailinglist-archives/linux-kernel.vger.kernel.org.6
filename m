Return-Path: <linux-kernel+bounces-390144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B19B761E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15038B21736
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46700153BE8;
	Thu, 31 Oct 2024 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EIhByHrd"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC5715382E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362450; cv=none; b=kXs5GjO+KI+Lt7zsKlbYVolcpvMknAaXhP/9e6Lh3Yt1ncLSgKFdV8N3KydZ4KYuAnvwIcElRHBQU1vBLGoX3t7w5mctwVh2p9OIjL5nhP2H++G+1XvXRyr+kPIdwM8kbM5+FikuY1Du/DWoEBYTkv5IYeIX9zW01Jh1ukVw0gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362450; c=relaxed/simple;
	bh=HkGC4stRYQuw6P00wjUYGlOpm6uTpmeyYQ2YuvHSnhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gqNO2KNgzd27xPiEcoxfknGoaVURxcbU/LwIYvL1TFTl7JcMeeS4EbtB49iltfn/YM1GNHpXyMeYcMttAem3gXim3N3s7nl2LlVrs1DCMtfnBxQ2S1L/MvATMmVX6UzP94gMOkJSZER32CZEP3xosJ+hUzKlE4O6Ek2d6nuUsTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EIhByHrd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c8c50fdd9so12577705ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730362447; x=1730967247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tkQ9WZUCsC8z89qOXEr8b5vtEe7JN52Ek+ujHmE9f44=;
        b=EIhByHrd2MAaUlBg6gILCF9GENtNtjajQsz/0CRwagXlIHxabj1aUuHZ/pbFyhBmkZ
         9QY0q49ngRrS7iDXJMFIO2kXkDKKnxvMMCndjha6dHLxyIEKxQmGOVYu49e2Bg3gVob9
         9YYJ7rqANcdXTyCphUqy4Rchgy5mdJvMg2JzbA8GjzeaROrZHH7PBMSFdin4TopEmltU
         gdQWOzm2qRe9W3Xn2OHQtH0wC//LKKorEUqYtJacRSZC53miMA7YuUoK4P1kuA4Yiwc0
         VELrBzsu0/VsRjB+ie9hYNU1YEAwNYZUcyDaxr1edU3Yz+SG0OoeteO9lAtQ50G/9EHX
         8qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362447; x=1730967247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkQ9WZUCsC8z89qOXEr8b5vtEe7JN52Ek+ujHmE9f44=;
        b=DN1VqOF5+p0Isl5/v0wzdYLc5WQ9TfZ+kzDTenY09hRea3l8r/SzevSxlH0gPjRJY7
         DsE52wKhLOOOWfac7Grj8fo5/cyM0FnfmnhaDU3+eHdtvUW9+AgaLe2sfPIU2wJTZQQc
         PMYY0wEqCtvUE3U3xunov0hbZnv4MuiOu5GI0Mcs2jbgPqm/VTtWWuxN1L1rgcWGOFPW
         m8nZKQ5o8fH54XaGeZ6fEYOSMvFWN21BII60xzTKvlPNfAOg1VlQ50/ZxUJNBILYeOka
         OaemBL1QoAqbCa3iK4krX57EptesSfWbXZbBF9agk4G3xCOJG/xQKvvMnIyuNxKTXpyC
         VCWA==
X-Forwarded-Encrypted: i=1; AJvYcCV0HMtBmnS0ZAwiU6YKDC81alVWvkJi8VoFQL7tad0H5drndcNywkwchNx61LsH+hfKjz1f30fegcJm6Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1v7x9oNdvygKWBRNAYOw/heRJCZTd5M8EusR1HU3cejOCFt2
	LyU/PUD6W1gZfh3mbYHz3pjpWQqodaO4en5+VG8QEOmYhsuSvjj9Ri3lXwgHOOs=
X-Google-Smtp-Source: AGHT+IHNqTGZLYppxBamLvQthBLNg7bIYE2zQEjxS+ujin+/siUJIbRU2Fk3XijmqC60zqrcFDmIrA==
X-Received: by 2002:a17:90b:1d0a:b0:2d8:b510:170f with SMTP id 98e67ed59e1d1-2e93e0e5ee5mr1974810a91.20.1730362447078;
        Thu, 31 Oct 2024 01:14:07 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9201b2586sm5163996a91.0.2024.10.31.01.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:14:06 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	peterx@redhat.com,
	catalin.marinas@arm.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 0/7] synchronously scan and reclaim empty user PTE pages
Date: Thu, 31 Oct 2024 16:13:16 +0800
Message-Id: <cover.1730360798.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - fix [PATCH v1 1/7] (Jann Horn)
 - reset force_flush and force_break to false in [PATCH v1 2/7] (Jann Horn)
 - introduce zap_nonpresent_ptes() and do_zap_pte_range()
 - check pte_none() instead of can_reclaim_pt after the processing of PTEs
   (remove [PATCH v1 3/7] and [PATCH v1 4/7])
 - reorder patches
 - rebase onto the next-20241031

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

This series is based on next-20241031 (which contains the series [2]).

Note: issues related to TLB flushing are not new to this series and are tracked
      in the separate RFC patch [3]. And more context please refer to this
      thread [4].

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/lkml/cover.1718267194.git.zhengqi.arch@bytedance.com/
[2]. https://lore.kernel.org/lkml/cover.1727332572.git.zhengqi.arch@bytedance.com/
[3]. https://lore.kernel.org/lkml/20240815120715.14516-1-zhengqi.arch@bytedance.com/
[4]. https://lore.kernel.org/lkml/6f38cb19-9847-4f70-bbe7-06881bb016be@bytedance.com/

Qi Zheng (7):
  mm: khugepaged: retract_page_tables() use pte_offset_map_rw_nolock()
  mm: introduce zap_nonpresent_ptes()
  mm: introduce do_zap_pte_range()
  mm: make zap_pte_range() handle full within-PMD range
  mm: pgtable: try to reclaim empty PTE page in madvise(MADV_DONTNEED)
  x86: mm: free page table pages by RCU instead of semi RCU
  x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64

 arch/x86/Kconfig           |   1 +
 arch/x86/include/asm/tlb.h |  19 ++++
 arch/x86/kernel/paravirt.c |   7 ++
 arch/x86/mm/pgtable.c      |  10 +-
 include/linux/mm.h         |   1 +
 mm/Kconfig                 |  15 +++
 mm/Makefile                |   1 +
 mm/internal.h              |  23 ++++
 mm/khugepaged.c            |  17 ++-
 mm/madvise.c               |   4 +-
 mm/memory.c                | 228 ++++++++++++++++++++++++-------------
 mm/mmu_gather.c            |   9 +-
 mm/pt_reclaim.c            |  68 +++++++++++
 13 files changed, 319 insertions(+), 84 deletions(-)
 create mode 100644 mm/pt_reclaim.c

-- 
2.20.1


