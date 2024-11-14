Return-Path: <linux-kernel+bounces-408786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D89C838F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA864B24B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7561EABA9;
	Thu, 14 Nov 2024 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NK+MC7JP"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB9152532
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567628; cv=none; b=a7cdlNxKyS9m17KyNYRC41YJw6EMB14C0TYsLiq/5H100Vf7b4iU7J5yLDpMI+vyKttUI4e6IDZ83OQeJHNtw2PgUsFYBZpPY9Z9nsUZRBjEr+pRUUVBsZ8/0OdwMa1/TfCinFj6KD/jUuoj4484VEAXeR2eFxgw8UFkP2k9Y/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567628; c=relaxed/simple;
	bh=E7yG8RiKF/rz65mNKQEsgh/Hx89qRd0r/5bJMVIKA2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mCBpJsIJUe7c7beqd44tP12mnC7gw/xQt4+eRZYSJmkneQgByxdgSBj7+Mdds3yZmCsEQWLV4tasKH8DOEsc6Ae7IG3n3FSN59RYfcPoAEAZIRtNbs0xrBLefCrnYrZmMFQuQGMuPMGkaAHm/FS2k1vc65eI/uFyUNg8N3PO7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NK+MC7JP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c805a0753so2358945ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731567626; x=1732172426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppWhpTd52TjJCCDS+EQr23PMbbYE2t0bTxCQVPbMPwg=;
        b=NK+MC7JPD5K60wzn5ltZx8vJhBPMw+9sH/sxaIRQQMZuNhYKtKlAcgkzzXt+khuV9V
         Al0q6f9NVv2qR5JwLcUYFNqKgbPW6sA/MLGv7aXWhWBRQV7GWTreE6jAbhzlYkBFPNUq
         owTdKaNzea5uwMhxXiZixnOQ3MIy4522C6To7qqx8aBcDQX1vN+CebikUOJoUCK8UBtj
         8VjJj8wFPwqaD4z0UMqTtFLupfx1s8Cjk9fJcUTgJkYv9WYOZE8h/qMYi1voz2OIgSlp
         fXOphAEv98a6tyddkQ2hyezn3De2eRAmDdoBy6TK1Z+w91kDKArZdSk/+MpzRvxBJnhl
         XkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567626; x=1732172426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppWhpTd52TjJCCDS+EQr23PMbbYE2t0bTxCQVPbMPwg=;
        b=DYbdMhuchHpWw4gKveEQ5v7br7PChN8G1lw7k2W8Hfq+m4KEbX5F+s5da13+yOS5nv
         7+rG1lcx7VznBottgeVVIqxjxSST/aZp29SgGBuRbqHF3P0oF13jYC6VygcMveW9+tLE
         wLHOuEKvqHx5+L6ME4cCLgzHPFdOuIcfzf1OE5AF9t1P48CSlgJjkuNYSYwlALpEhwtY
         uRe2DU73V1aCXy7QJfHrL+ivkaCmhkAPLac/cTSbFezKydjrdzsTYL9saIa/bFbkT7tp
         ST8TPH3/5dvkOYaUfHECpcfqN4deyZEE3fnXXZGp04hvZ58XXk1M8n+vUvSFSOMJhK12
         60Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVUfgKPx260QYsYmIZKHJmlsUkniO3ZNZnHyQYrIPh8uk9n6+ksEpVIknw81KhK4Cfl388TJi8vpWUUv7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7mohKEtny/tBiJRIURmQOwGhq4zjJUUbaBBn8JNpRuY6DL4r
	zPw5VNiAPx3tHmluKgKbYMTYnL3jwsXtSzp4s2ujaR/r5DGmRwRlLOr2WbEa7b4=
X-Google-Smtp-Source: AGHT+IEfZggo5NO+eFLQrRxC+GYnbRgduJHWaZDad+eOwdF2nsEeKaCuWMxC+Yr43OjjTZNi7plhXA==
X-Received: by 2002:a17:902:f541:b0:20d:1866:ed6f with SMTP id d9443c01a7336-21183ccf11bmr310127245ad.4.1731567626121;
        Wed, 13 Nov 2024 23:00:26 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d389c2sm4119065ad.268.2024.11.13.23.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:00:24 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	peterx@redhat.com
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zokeefe@google.com,
	rientjes@google.com,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 0/9] synchronously scan and reclaim empty user PTE pages
Date: Thu, 14 Nov 2024 14:59:51 +0800
Message-Id: <cover.1731566457.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
 - recheck pmd state instead of pmd_same() in retract_page_tables()
   (suggested by Jann Horn)
 - recheck dst_pmd entry in move_pages_pte() (pointed by Jann Horn)
 - introduce new skip_none_ptes() (suggested by David Hildenbrand)
 - minor changes in [PATCH v2 5/7]
 - remove tlb_remove_table_sync_one() if CONFIG_PT_RECLAIM is enabled.
 - use put_page() instead of free_page_and_swap_cache() in
   __tlb_remove_table_one_rcu() (pointed by Jann Horn)
 - collect the Reviewed-bys and Acked-bys
 - rebase onto the next-20241112

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

This series is based on next-20241112 (which contains the series [2]).

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

Qi Zheng (9):
  mm: khugepaged: recheck pmd state in retract_page_tables()
  mm: userfaultfd: recheck dst_pmd entry in move_pages_pte()
  mm: introduce zap_nonpresent_ptes()
  mm: introduce skip_none_ptes()
  mm: introduce do_zap_pte_range()
  mm: make zap_pte_range() handle full within-PMD range
  mm: pgtable: try to reclaim empty PTE page in madvise(MADV_DONTNEED)
  x86: mm: free page table pages by RCU instead of semi RCU
  x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64

 arch/x86/Kconfig           |   1 +
 arch/x86/include/asm/tlb.h |  19 +++
 arch/x86/kernel/paravirt.c |   7 ++
 arch/x86/mm/pgtable.c      |  10 +-
 include/linux/mm.h         |   1 +
 include/linux/mm_types.h   |   4 +-
 mm/Kconfig                 |  15 +++
 mm/Makefile                |   1 +
 mm/internal.h              |  19 +++
 mm/khugepaged.c            |  45 ++++---
 mm/madvise.c               |   7 +-
 mm/memory.c                | 250 +++++++++++++++++++++++++------------
 mm/mmu_gather.c            |   9 +-
 mm/pt_reclaim.c            |  71 +++++++++++
 mm/userfaultfd.c           |  51 +++++---
 15 files changed, 397 insertions(+), 113 deletions(-)
 create mode 100644 mm/pt_reclaim.c

-- 
2.20.1


