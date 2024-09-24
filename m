Return-Path: <linux-kernel+bounces-336579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374B8983CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6852826C8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715694EB38;
	Tue, 24 Sep 2024 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DCJLCb7i"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73442A8F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158230; cv=none; b=OUaMb3OZs4fwPZJXnllPm5Ry5J/LadPZc80iWrCDWw3LpsO6Vbb/+EWvS2vga51CGtuEiMXU3i3maBNbZ0gQ37rqB/l9ITAHBX7fdvL7MqKahXN83me0n/JuW8VTNTikHVRkoPSVrsw1YsfdVkDSmg7l2FGrTv0rU48nC56hbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158230; c=relaxed/simple;
	bh=5EJ1wM44oSW6caNwnYJYPQHyJBSYal/0hk2KJQmEe0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQTwPTHYY7FYszg4uP/8YF/cDVkIqsYSU3eVALcj8DHuGoKRCrl+JDC1INXH69Nh8zOQffMJJlFg06LuTffNy9e2RSWW9VmqGRbacct+kL6po9vMdlk5tfg5ydqakYS/bf7vixxTE7D6ShF4NDLNdE5gC24gdHbtnwswYaBLXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DCJLCb7i; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206aee40676so41319185ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158228; x=1727763028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ+6J9fpvc8LtEIEryLlJSsbAdd45v7edjcT5rDHpkU=;
        b=DCJLCb7ircptpUM3YsFiOL1CgkMqzPQdLPapedFhddmdlq64bSC/REli0/hMSwP6Sx
         eR9ZabrJla1AVpfzyoIIgUcpfoGG+KJgzFd1NM727fF/ZGiPM6m2hAIC6e8vxZhFkr33
         hzdVF6Qp1fJnRTyrnKZ3RFH9wEmvMocd3Hoy8ASgDkg9wb6SHMcJRh9EOd//RXpaSy9l
         6y6sH5Tkb4oVox7EdVkWfxKM9b7AFKnTLNVaDpuD6tnQRR5s+bTlPDWjPkC3/jfoPg3/
         feSSg7fVIQ7cL4uzqtxvBUuzzTYx8njGVj48RvthKLegd50g7+mwZs6aqORSakYKPVNg
         VPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158228; x=1727763028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZ+6J9fpvc8LtEIEryLlJSsbAdd45v7edjcT5rDHpkU=;
        b=TYsoVt6qjf1sXandQKUPMF62UHdHFppLq/CgUXsOQY1ebtwMcJ6NAkPjgIs60NhIFR
         aQIm6uv9cqFX9peZ0HVn5D+QGX8CK/q8yCRjyPGzb4agz+gggtAKnIc9sNq8R0HbUn+D
         QQBdVrtMfdLVOYpT3FMVQWGMZ3LuBGTw/LSFFCa4uwQ9UJ5miARFTFTiwuOU6LNFDIUl
         AI6TUdbdIXdePjhtWY6xmu9y3qwStEEDVV1ctJjC+NdIH9pBg4ILPJOAbRDIU4G1jUgV
         qQ5kN+U7ujjRl0liNTCmrPTYhJfscFHkCge3yJNbLFdqpIemzQ36FMrOZbK/KAiWicqv
         4ALQ==
X-Gm-Message-State: AOJu0Yxol6zQGzW2kzcNW7VaBPXJuS6atZV8FD906qw//SGdIqgzfdZf
	7TMlxPGTRRaS8mniU5nWctL14baiPfqb4pGCDFIe3OpLNZ7CVtUUJpHspYIyFjU=
X-Google-Smtp-Source: AGHT+IE3JgWdRJx6WCYXen89wPhryGlCmdGWyOg8hF+XH/7tbK6pMmGNNEBSXyybrad6ihXB6X7r6g==
X-Received: by 2002:a17:903:22c7:b0:206:a1ea:f4fe with SMTP id d9443c01a7336-208d832a9c8mr174328585ad.10.1727158228146;
        Mon, 23 Sep 2024 23:10:28 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:10:27 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 00/13] introduce pte_offset_map_{ro|rw}_nolock()
Date: Tue, 24 Sep 2024 14:09:52 +0800
Message-Id: <cover.1727148662.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
 - arm: adjust_pte() use pte_offset_map_rw_nolock()
   (use ptl != vmf->ptl to check if we are using split PTE locks)
   mm: khugepaged: collapse_pte_mapped_thp() use pte_offset_map_rw_nolock()
   (move the pte_unmap() backward)
   mm: copy_pte_range() use pte_offset_map_rw_nolock()
   (remove pmd_same() check)
   mm: mremap: move_ptes() use pte_offset_map_rw_nolock()
   (remove pmd_same() check)
   mm: page_vma_mapped_walk: map_pte() use pte_offset_map_rw_nolock()
   (move the assignment to pvmw->ptl backward)
 - remove [PATCH v3 14/14] (will be sent as a separate patch)
 - reorder patches
 - collect the Reviewed-bys
 - rebase onto the next-20240923

Changes in v3:
 - change to use VM_WARN_ON_ONCE() instead of BUG_ON() in pte_offset_map_rw_nolock()
   (David Hildenbrand)
 - modify the comment above the pte_offset_map_lock() in [PATCH v2 01/14]
   (David Hildenbrand and Muchun Song)
 - modify the comment above the pte_offset_map_rw_nolock() in [PATCH v2 06/14]
   (David Hildenbrand and Muchun Song)
 - also perform a pmd_same() check in [PATCH v2 08/14] and [PATCH v2 09/14]
   (since we may free the PTE page in retract_page_tables() without holding the
    read lock of mmap_lock)
 - collect the Acked-bys and Reviewed-bys
 - rebase onto the next-20240904

Changes in v2:
 - rename pte_offset_map_{readonly|maywrite}_nolock() to
   pte_offset_map_{ro|rw}_nolock() (LEROY Christophe)
 - make pte_offset_map_rw_nolock() not accept NULL parameters
   (David Hildenbrand)
 - rebase onto the next-20240822

Hi all,

As proposed by David Hildenbrand [1], this series introduces the following two
new helper functions to replace pte_offset_map_nolock().

1. pte_offset_map_ro_nolock()
2. pte_offset_map_rw_nolock()

As the name suggests, pte_offset_map_ro_nolock() is used for read-only
case. In this case, only read-only operations will be performed on PTE page
after the PTL is held. The RCU lock in pte_offset_map_nolock() will ensure that
the PTE page will not be freed, and there is no need to worry about whether the
pmd entry is modified. Therefore pte_offset_map_ro_nolock() is just a renamed
version of pte_offset_map_nolock().

pte_offset_map_rw_nolock() is used for may-write case. In this case, the pte or
pmd entry may be modified after the PTL is held, so we need to ensure that the
pmd entry has not been modified concurrently. So in addition to the name change,
it also outputs the pmdval when successful. The users should make sure the page
table is stable like checking pte_same() or checking pmd_same() by using the
output pmdval before performing the write operations.

This series will convert all pte_offset_map_nolock() into the above two helper
functions one by one, and finally completely delete it.

This also a preparation for reclaiming the empty user PTE page table pages.

This series is based on the next-20240923.

Comments and suggestions are welcome!

Thanks,
Qi

Qi Zheng (13):
  mm: pgtable: introduce pte_offset_map_{ro|rw}_nolock()
  powerpc: assert_pte_locked() use pte_offset_map_ro_nolock()
  mm: filemap: filemap_fault_recheck_pte_none() use
    pte_offset_map_ro_nolock()
  mm: khugepaged: __collapse_huge_page_swapin() use
    pte_offset_map_ro_nolock()
  arm: adjust_pte() use pte_offset_map_rw_nolock()
  mm: handle_pte_fault() use pte_offset_map_rw_nolock()
  mm: khugepaged: collapse_pte_mapped_thp() use
    pte_offset_map_rw_nolock()
  mm: copy_pte_range() use pte_offset_map_rw_nolock()
  mm: mremap: move_ptes() use pte_offset_map_rw_nolock()
  mm: page_vma_mapped_walk: map_pte() use pte_offset_map_rw_nolock()
  mm: userfaultfd: move_pages_pte() use pte_offset_map_rw_nolock()
  mm: multi-gen LRU: walk_pte_range() use pte_offset_map_rw_nolock()
  mm: pgtable: remove pte_offset_map_nolock()

 Documentation/mm/split_page_table_lock.rst |  6 ++-
 arch/arm/mm/fault-armv.c                   | 53 +++++++++-------------
 arch/powerpc/mm/pgtable.c                  |  2 +-
 include/linux/mm.h                         |  7 ++-
 mm/filemap.c                               |  4 +-
 mm/khugepaged.c                            | 20 ++++++--
 mm/memory.c                                | 25 ++++++++--
 mm/mremap.c                                | 11 ++++-
 mm/page_vma_mapped.c                       | 25 ++++++++--
 mm/pgtable-generic.c                       | 43 +++++++++++++++---
 mm/userfaultfd.c                           | 15 ++++--
 mm/vmscan.c                                |  9 +++-
 12 files changed, 159 insertions(+), 61 deletions(-)

-- 
2.20.1


