Return-Path: <linux-kernel+bounces-339964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF899986CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E966B1C20E86
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A06918C336;
	Thu, 26 Sep 2024 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PC0ekmBv"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAFA224D6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333211; cv=none; b=jUDMXlCWq8OQvSdbvrgCcFqRGdG6bGA3bp130tDqfwadNuTs0bX3cG2TKLdsc4LrYUoj4abEYQ2BOjd3jzs62AjooEYMYz4vkceu4PvDgRTgbkY6PHACWlGLhY2mIBZC77utm3+KolkpbbaYPVIYEzebf8zlPYOhOgUaQSdkyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333211; c=relaxed/simple;
	bh=ENFimFaGoSIE9lgJXww6hsFaWSvuC/eszbO8ZI3LgKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aag+tu7+PPz9y4/33I2tBaVnvCUpJ5viRs2FzzDznveb9o7e6xmGcy5TwJmuRA/vH9rPTW3G275oyZBVqIZgA4lPoBb7ezQRfv6hXyNfamjYz+8KE3p29eAltUnSTTTjFJ+s6RKCm0DMzJzanrwricx3Zo1KCXY4m2QvEl+sRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PC0ekmBv; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-456757d8871so3875121cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333208; x=1727938008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=psD5QBE2/gRnBoEm6qk1NsXq2zG3EMB2GGe+WDIIiWM=;
        b=PC0ekmBvRCwJUR2a6jmhDh0qHiAjsdpYWgFXl681E9ZG25KIT3CFgfoOROjjTkygGV
         gzq6Py5kGpuDaOLdEZTQT43gcPNOSnlbBZwBcJsZsiwbYaLoa6P+iuTtBk8ul8wAmsGL
         gEqvYW2BTP5QC1wa7Xv+eBVHNtOntFweCQrePgYOijyU85lnmgrhpbbjYz4bH/eo/1rs
         K4ziP+5zv53/cA4QAet0JQsljk4cDVKBYYnHNhO6q/HNPrmaOdV1ckOPeJ5btPn4iVEr
         JNPsQthCeQ2Tj4FObedlvean4l5ztZuXbEyqP0/WYlODpbPaXj9ozriGfkX/Ka6hKd6a
         DhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333208; x=1727938008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psD5QBE2/gRnBoEm6qk1NsXq2zG3EMB2GGe+WDIIiWM=;
        b=h1e3vPyyt1cKne77gDdBp5o1W0QVloBZRY1g0f/VEuN+p18FKwTyYw2f3V/i4Y27ST
         bmSWqS172piwdoO/63rpJ7PaE6Qo7LeDaElM0YRjd27+d4NLR59E05Z8CSHIljqCvi75
         IV5jvx4ifF9xfsCltn76rQ+zZ5jDkEPnmnYxDIzbO8liOGUzy/f3yZgj7YK52S5U+AV1
         Q/BHOS7h7fXJvaQJCkLcYwZ3I6KGYDkwQGGtDpVLb5xWYBXe1sTExkfKlZVzM/VoUTTM
         leYPw2DOsZp0fVBUaUDnZ51F8h6FH7YKH09dIdvktmWU4SXo0CnZDbTBmszrKSTeB/oW
         PS2A==
X-Gm-Message-State: AOJu0Yw30R7ZIMXQitb42L1jC2zC/4U0kGxgQwInL5jC+IifkKWlu13Q
	8EQBhSSzjuZZMnlKE7m86yk4RjPWl6ifqjaEpqnDhHFppcdTPpetVDe/OjuNUtY=
X-Google-Smtp-Source: AGHT+IESrskC0O60xJo9CKcSFqAz070fd6XCEqJPS1rPBwM9ByQ3Zw6qYsXl3/Ca/QhHASyX7ikg5w==
X-Received: by 2002:a05:622a:1311:b0:458:34ee:3a4b with SMTP id d75a77b69052e-45b5dec78afmr74252701cf.6.1727333208088;
        Wed, 25 Sep 2024 23:46:48 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:46:47 -0700 (PDT)
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
Subject: [PATCH v5 00/13] introduce pte_offset_map_{ro|rw}_nolock()
Date: Thu, 26 Sep 2024 14:46:13 +0800
Message-Id: <cover.1727332572.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
 - directly pass pmdvalp to __pte_offset_map() in pte_offset_map_rw_nolock()
   (Muchun Song)
 - fix the problem of the reference of folio and the mm counter in
   [PATCH v4 07/13] (Muchun Song)
 - directly pass pmdvalp to pte_offset_map_rw_nolock() in map_pte()
   (Muchun Song)
 - collect the Acked-bys and Reviewed-bys
 - rebase onto the next-20240926

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

This series is based on the next-20240926.

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
 mm/khugepaged.c                            | 24 +++++++---
 mm/memory.c                                | 25 ++++++++--
 mm/mremap.c                                | 11 ++++-
 mm/page_vma_mapped.c                       | 24 +++++++---
 mm/pgtable-generic.c                       | 41 ++++++++++++++---
 mm/userfaultfd.c                           | 15 ++++--
 mm/vmscan.c                                |  9 +++-
 12 files changed, 157 insertions(+), 64 deletions(-)

-- 
2.20.1


