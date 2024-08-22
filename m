Return-Path: <linux-kernel+bounces-296752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BD95AE99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE491F24503
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41A175D3D;
	Thu, 22 Aug 2024 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TEgUvu2S"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0114D42C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310832; cv=none; b=U9iSoq4TmwL8WhfPqjhhkDqsjCAjJPwQbhYHjPOqtb6ubIOZoamFwFALX6KffdfvZSV0y3+B5h/hAGalA7qxzelFYXkeq7+JqSXPEGPLFPvuqkykrXjVR8XQopR+WGZwT6MQxIu6s5fhVA6tfm36zZrE1Akrgv4cy0H/u8vHFbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310832; c=relaxed/simple;
	bh=kWsXm+TNMemG6NWyPN6g5pavxhI7t+IxsfCaHKkZEGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=trqb86DEU8c1Qv7B8pFVHVmY0sJZKy7RDAC1ew2XfVtqB0YLhfLUbZUm9D2XHsyl2KMFellgKqu2l87KQHo4K5SDESOAQOlg4CWl1jiTqItvpQdBY1UHTM2cBbm87UsA7CIcqI2JyzeQrzEzB6r23yb/NKVk7mnToDfQcarLGgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TEgUvu2S; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70942ebcc29so347500a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310829; x=1724915629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFMLU37SF14i0z7/xzd4z7SOLQqMigYLuSMvL0jdhU0=;
        b=TEgUvu2SeK48mfNVWRCrkE4BM+eMv4QkccuRMVGLdyifaa9nLBDgARE0eT66/JP2cz
         S+9rPK8L72J/BN2y7KJ4KTwD+m7eRy+bVEZ4jxtQi5mB3EggGEjUAtceYFn27Hki5Tr9
         IHwhJ6uUUYVYk4FTuegF1VMFarYq6Sm/qJ2bnYIKw12gcp7CVbfqju4lnptG6r/Ul6Ry
         PaDB1qzHIiB6phfu5ACk6gUh6dTetQimhDvVtyz02elWnrBfaOODLK4D/GtKlsUnwb1U
         Aq6YK7+ZAfmNUBYuHchLWQqVtT4Xx8trolrMELFze5Mvo4oXOVdYpFYUYN8lnyNxUNEg
         5B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310829; x=1724915629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFMLU37SF14i0z7/xzd4z7SOLQqMigYLuSMvL0jdhU0=;
        b=nsOxtFPTFwIgHF+h4Oe0JJ9QwIHiRY3qsDNZ2gS3MnFgqTrfcutZZqEaZpgY7gGqBf
         P4V3gwjXLH/h5aVznuBTAwb2uV9kEoXJ+kWEL1UJiEu0fiJ+YL04IOhrHwbng0lo8e+G
         1wNVI74/wN8fAMifTwhzgnRz9WTUQbma78LdF54W2Oo85WN19Ad4FHiB9JC/rBgK18VA
         oSREgG062MNnIeiAyAOAJA/ohzV9BzN6qspFRATV58KoQty5hOhg1uIL2oC/NAgB+nve
         0RVqcdRRp5zRvWKrVJ8ktX83n9G3Bz0VrQ6q9dZHahPwMshZd5QA/geJGwTg2iMz113j
         HIZQ==
X-Gm-Message-State: AOJu0Yw3jUNhvtombp7D5/AjQNpsmK4u0jt7e7qcafYj+SI3YKMFx5nC
	nwc8OWX75jMCVXzA1ZMb1jz4ozMBjxINoaD4zEluPWc/EWPqEhR8qZkQo19d8NQ=
X-Google-Smtp-Source: AGHT+IHFVt0p20Eao8jGQp/M4A8gGxgTtYUk7Hnj/FFBLeb56GgWurcM0rgpuj3RCCjsswwc/siqyg==
X-Received: by 2002:a05:6830:4386:b0:702:5a0:2f82 with SMTP id 46e09a7af769-70e043561e4mr1361943a34.0.1724310828958;
        Thu, 22 Aug 2024 00:13:48 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:13:48 -0700 (PDT)
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
Subject: [PATCH v2 00/14] introduce pte_offset_map_{ro|rw}_nolock()
Date: Thu, 22 Aug 2024 15:13:15 +0800
Message-Id: <cover.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
it also outputs the pmdval when successful. This can help the caller recheck
*pmd once the PTL is taken. In some cases, that is, either the mmap_lock for
write, or pte_same() check on contents, is also enough to ensure that the pmd
entry is stable. But in order to prevent the interface from being abused, we
choose to pass in a dummy local variable instead of NULL.

This series will convert all pte_offset_map_nolock() into the above two helper
functions one by one, and finally completely delete it.

This also a preparation for reclaiming the empty user PTE page table pages.

This series is based on the next-20240822.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/lkml/f79bbfc9-bb4c-4da4-9902-2e73817dd135@redhat.com/

Qi Zheng (14):
  mm: pgtable: introduce pte_offset_map_{ro|rw}_nolock()
  arm: adjust_pte() use pte_offset_map_rw_nolock()
  powerpc: assert_pte_locked() use pte_offset_map_ro_nolock()
  mm: filemap: filemap_fault_recheck_pte_none() use
    pte_offset_map_ro_nolock()
  mm: khugepaged: __collapse_huge_page_swapin() use
    pte_offset_map_ro_nolock()
  mm: handle_pte_fault() use pte_offset_map_rw_nolock()
  mm: khugepaged: collapse_pte_mapped_thp() use
    pte_offset_map_rw_nolock()
  mm: copy_pte_range() use pte_offset_map_rw_nolock()
  mm: mremap: move_ptes() use pte_offset_map_rw_nolock()
  mm: page_vma_mapped_walk: map_pte() use pte_offset_map_rw_nolock()
  mm: userfaultfd: move_pages_pte() use pte_offset_map_rw_nolock()
  mm: multi-gen LRU: walk_pte_range() use pte_offset_map_rw_nolock()
  mm: pgtable: remove pte_offset_map_nolock()
  mm: khugepaged: retract_page_tables() use pte_offset_map_rw_nolock()

 Documentation/mm/split_page_table_lock.rst |  6 +++-
 arch/arm/mm/fault-armv.c                   |  9 ++++-
 arch/powerpc/mm/pgtable.c                  |  2 +-
 include/linux/mm.h                         |  7 ++--
 mm/filemap.c                               |  4 +--
 mm/khugepaged.c                            | 39 ++++++++++++++++++--
 mm/memory.c                                | 23 ++++++++++--
 mm/mremap.c                                |  9 ++++-
 mm/page_vma_mapped.c                       | 24 ++++++++++---
 mm/pgtable-generic.c                       | 42 ++++++++++++++++------
 mm/userfaultfd.c                           | 15 ++++++--
 mm/vmscan.c                                |  9 ++++-
 12 files changed, 157 insertions(+), 32 deletions(-)

-- 
2.20.1


