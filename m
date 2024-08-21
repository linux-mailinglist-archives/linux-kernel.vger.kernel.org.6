Return-Path: <linux-kernel+bounces-295104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CC29596DD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0B51C20A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97061196C86;
	Wed, 21 Aug 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IkYYvFbu"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879C1898E1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228368; cv=none; b=s8tbTrdIOpQyW6SLoCZUTsJ4R7n6Wiw2wSKzamNwmvrTEesnbxS3+HrlEsjXm7D80o+SiKqvjt5Ek4B6Iv22WHVIoYFE9MGNjlZr5wLwQJt0FHPFXzHCHUGjJRZq0b8ciDA9mAvCy23UDSk3J9LWhJAaqNMxKTbCvaxxk5kgwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228368; c=relaxed/simple;
	bh=Kz7kPMZkCCKCxWyNX9zUjxoO33p9EPsl0yy4Y2+hV8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sS0dz5TGzUCEqiQCDESjaKpvtaMVZS+gA3MroNbny9aH2kWKW58k9op8I+w++6N5eT0fqfxQVhctMCNKCIpG8k5+ynzs7GgYL3nzmLrJhrDK/qmsvX2D0rV0/+MywUgCoIgx/0E3v/lG9qu8l65tWhq1PUvcSBBXQqTetYM2oEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IkYYvFbu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201f7fb09f6so46445475ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228366; x=1724833166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PN5+in6xnBXgxe2LIsQDc93ppSQBPQmBv4bxyw8DmlQ=;
        b=IkYYvFbu9Bp+wd75/4AXZL39o/9IkYEYDhkOZnbtyIIOD9+tgpxvaFUBIXBTlRasJS
         76U24VUqKDwR90NakeCYR5YARla+K9277itmmiXfMh8y+q/4rcRHXKpyeQ8/ayV3SEA9
         qL/qm7MUa0llqtGpZ4NzeWHqpNxJpUX7snHQBDejmHlljqj667qG319vbNHHPfERnVFi
         Rsm5RNvWSdHmJRBhcHFZcL3qvDD5TOrZrqcpmBZKD+HDCnD/Lp07va5PC4ISAzApmCu7
         +YHBd5urAz8Pb4cat5SBWwdB4sDZyOdPISCZsE84o/tWe8zGNg0XA9T8R+jgA3TV1N6J
         RqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228366; x=1724833166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PN5+in6xnBXgxe2LIsQDc93ppSQBPQmBv4bxyw8DmlQ=;
        b=rbAAe3AjDlE3JZalFZzhaKg4i1O3eaZ8u2oEKankpPfx+MaTeCmUflJhkMRoiZMSmk
         dDj3sTiamuu5rWvoHoFuNSvQgdqNA0wln/LBGyEfsS1ySNboAgvLOptKgseJEUTm5YZb
         2mFB1o2D+yJik0eOL1JHGqeb5+1Tui7koXkLEgqcNGDFGA+/lCquJRm9biDV83FvRMcE
         /CYsnk68sJ77809d66kDZxd7WNXTWnFba2dYizsrq6I6vBOeN3ItYRLUTk7zf2Xys86u
         RVO5z+VbkwGMw6q64zprZe3gSXMEzdHPfgffqtTxfb7uDypNLrS8wb+6y2pftNWSjFbo
         bA+g==
X-Gm-Message-State: AOJu0YwvMScMQNVaT8tuL6U99EBMgOA1WptPaxUrgIQzAhJ9uCIqYW0M
	hDtywKRUxqOjhOvMhoarmEg67OrXJbfkH3JRjW2fsPR3ZDU2PtURcoDmGBogO2w=
X-Google-Smtp-Source: AGHT+IHHUoYOI/2K4+IHeJgFEXGAQNHZYM2BB7ldoGeWEQ/b7YbP3WstRyHOcikTGkk/QMWJJeDGRQ==
X-Received: by 2002:a17:90a:c381:b0:2c9:69cc:3a6f with SMTP id 98e67ed59e1d1-2d5e9dcab76mr1637566a91.31.1724228366127;
        Wed, 21 Aug 2024 01:19:26 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:19:25 -0700 (PDT)
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
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 00/14] introduce pte_offset_map_{readonly|maywrite}_nolock()
Date: Wed, 21 Aug 2024 16:18:43 +0800
Message-Id: <cover.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

As proposed by David Hildenbrand [1], this series introduces the following two
new helper functions to replace pte_offset_map_nolock().

1. pte_offset_map_readonly_nolock()
2. pte_offset_map_maywrite_nolock()

As the name suggests, pte_offset_map_readonly_nolock() is used for read-only
case. In this case, only read-only operations will be performed on PTE page
after the PTL is held. The RCU lock in pte_offset_map_nolock() will ensure that
the PTE page will not be freed, and there is no need to worry about whether the
pmd entry is modified. Therefore pte_offset_map_readonly_nolock() is just a
renamed version of pte_offset_map_nolock().

pte_offset_map_maywrite_nolock() is used for may-write case. In this case, the
pte or pmd entry may be modified after the PTL is held, so we need to ensure
that the pmd entry has not been modified concurrently. So in addition to the
name change, it also outputs the pmdval when successful. This can help the
caller recheck *pmd once the PTL is taken. In some cases we can pass NULL to
pmdvalp: either the mmap_lock for write, or pte_same() check on contents, is
also enough to ensure that the pmd entry is stable.

This series will convert all pte_offset_map_nolock() into the above two helper
functions one by one, and finally completely delete it.

This also a preparation for reclaiming the empty user PTE page table pages.

This series is based on the next-20240820.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/lkml/f79bbfc9-bb4c-4da4-9902-2e73817dd135@redhat.com/

Qi Zheng (14):
  mm: pgtable: introduce pte_offset_map_{readonly|maywrite}_nolock()
  arm: adjust_pte() use pte_offset_map_maywrite_nolock()
  powerpc: assert_pte_locked() use pte_offset_map_readonly_nolock()
  mm: filemap: filemap_fault_recheck_pte_none() use
    pte_offset_map_readonly_nolock()
  mm: khugepaged: __collapse_huge_page_swapin() use
    pte_offset_map_readonly_nolock()
  mm: handle_pte_fault() use pte_offset_map_maywrite_nolock()
  mm: khugepaged: collapse_pte_mapped_thp() use
    pte_offset_map_maywrite_nolock()
  mm: copy_pte_range() use pte_offset_map_maywrite_nolock()
  mm: mremap: move_ptes() use pte_offset_map_maywrite_nolock()
  mm: page_vma_mapped_walk: map_pte() use
    pte_offset_map_maywrite_nolock()
  mm: userfaultfd: move_pages_pte() use pte_offset_map_maywrite_nolock()
  mm: multi-gen LRU: walk_pte_range() use
    pte_offset_map_maywrite_nolock()
  mm: pgtable: remove pte_offset_map_nolock()
  mm: khugepaged: retract_page_tables() use
    pte_offset_map_maywrite_nolock()

 Documentation/mm/split_page_table_lock.rst |  6 +++-
 arch/arm/mm/fault-armv.c                   |  9 ++++-
 arch/powerpc/mm/pgtable.c                  |  2 +-
 include/linux/mm.h                         |  7 ++--
 mm/filemap.c                               |  4 +--
 mm/khugepaged.c                            | 39 ++++++++++++++++++--
 mm/memory.c                                | 13 +++++--
 mm/mremap.c                                |  7 +++-
 mm/page_vma_mapped.c                       | 24 ++++++++++---
 mm/pgtable-generic.c                       | 42 ++++++++++++++++------
 mm/userfaultfd.c                           | 12 +++++--
 mm/vmscan.c                                |  9 ++++-
 12 files changed, 143 insertions(+), 31 deletions(-)

-- 
2.20.1


