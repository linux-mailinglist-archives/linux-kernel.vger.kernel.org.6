Return-Path: <linux-kernel+bounces-314564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABCF96B544
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C1E28AE75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD81CCB4E;
	Wed,  4 Sep 2024 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QRYKstlA"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9141C871A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439246; cv=none; b=tCZY+wFEMrah40/HDrM1oNd/hgPa2PBKRvmPRHHQdKeMQoacDrw7OKX3IO9JcArLO7DCcBRgPzZpchfJ8GaELOiP8sLFgWYB+qvI6/2AExVimJT/zJNJ3AYjP5HlM/f2lA6XGh4YMRy7gxqHLHfJo5IiWzjvQulWWo49vnLyM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439246; c=relaxed/simple;
	bh=q+CiWZ7z/PMkMFiP+B/KgiY9eCTD98HaB+Usg+amjYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Db3tYbN3K1mFH7/+Ftp+W8U63iVNQ8tqHy07IyyucDvzZaXCveqlM/NlKWBzcpCD4pqMdG1bFHJyOMTwoJMPKn4R2qvbceLyD0opAHmmoIMo6qxXZjqA6+2X/r4rEeK/4miF1KnuUgxL8Ike2C7RkaLGLGNNsyvsBCECB3y/Dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QRYKstlA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so533945a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439243; x=1726044043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnxZ3keyEwgQ9RkNvwyvGwt3DYekuRW0HVUJKFS+J3s=;
        b=QRYKstlAnwhIetS9KsnkkDPMneJ7pucduC3BLmIG0qjtZ6ZirZQDucPMYcCgaPhx1v
         jVzE0TIFCEQnO7IOX/yS6aSg1D5dcUupHVVOKXb9f+w3UM15XGVLFsUaQZz57A+0bKwR
         Om4GY4GyEjfrdqX2p3MqWBNz4AEQ3PlPN9hfrNpHEOBC6+cD6nFm0jNW4/DVXK6JMf90
         KaSUC/k0Dy5IQJRpVKxct6MVVKREBKWNH+20IAHtTYaRp4p2uZp7nGxz2srRH1PnMWSs
         bwwWVgi6YqhbQu+Ta9VdRFJX7u0MK+Ye28VBLPSk1T3LlIRROCbZte5MVPJ4ZYCiOqzF
         GbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439243; x=1726044043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnxZ3keyEwgQ9RkNvwyvGwt3DYekuRW0HVUJKFS+J3s=;
        b=Uq6aoOeniJKUTrzUGSGdfHSe+xmIzawDIywIONRC/PVQY1wZ96woauga4TZw2noBbU
         yr+DyOaemSQ9IoAyjsThUteN/AxKHMM1VaK92Y+kMproU7LhAvyIBB9WfxSkm/V27K9W
         H+HrPiMeGcFg4xivx8faSDvS7ux+1JQM/9e5Wksz5dcuOyZmgU5lQgpPF2+DnUUrH8v1
         CqLlGq8BapiyrQBPOY6yGayIq3lXv2bsuYWSwYikzWHDosIniPiT/g+4PYGI+x9qllYq
         1enDGmC2HRIi307yymtHPqat3QioVOSOWWJBj5POA+Xf4DCo99pYOTj/oksvNZq69pzD
         wUpA==
X-Gm-Message-State: AOJu0Yw2Ls28MQXB4JTCDTL55GMo8DJonSO+W3OKrhVnAlX808CdOjWd
	Ia8pXKvh+huaD54pT0X4bEiLqMu6vksWpalWWunj6goULsvQ2K74M7mxaASW6Dc=
X-Google-Smtp-Source: AGHT+IG+iEKF7FtSjHKinQSwDvpK7gnjP4wMOie8wNTxXeNBeSlHHCqUvqbL69VXmYEDlh1n7ZOmCw==
X-Received: by 2002:a05:6a20:d503:b0:1c0:f2d9:a452 with SMTP id adf61e73a8af0-1cece4fdcacmr13163272637.13.1725439243372;
        Wed, 04 Sep 2024 01:40:43 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:40:42 -0700 (PDT)
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
Subject: [PATCH v3 00/14] introduce pte_offset_map_{ro|rw}_nolock()
Date: Wed,  4 Sep 2024 16:40:08 +0800
Message-Id: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

This series is based on the next-20240904.

Comments and suggestions are welcome!

Thanks,
Qi

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

 Documentation/mm/split_page_table_lock.rst |  6 ++-
 arch/arm/mm/fault-armv.c                   |  9 ++++-
 arch/powerpc/mm/pgtable.c                  |  2 +-
 include/linux/mm.h                         |  7 +++-
 mm/filemap.c                               |  4 +-
 mm/khugepaged.c                            | 39 ++++++++++++++++++--
 mm/memory.c                                | 32 ++++++++++++++--
 mm/mremap.c                                | 20 +++++++++-
 mm/page_vma_mapped.c                       | 24 ++++++++++--
 mm/pgtable-generic.c                       | 43 ++++++++++++++++++----
 mm/userfaultfd.c                           | 15 ++++++--
 mm/vmscan.c                                |  9 ++++-
 12 files changed, 180 insertions(+), 30 deletions(-)

-- 
2.20.1


