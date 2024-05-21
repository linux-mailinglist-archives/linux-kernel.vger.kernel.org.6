Return-Path: <linux-kernel+bounces-184476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6108CA734
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDC7281E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35988208B8;
	Tue, 21 May 2024 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKkTU18U"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFF14F62
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264198; cv=none; b=Y3VvTjVNDNBbHMHq/j7v+EnDRD750lue8hYdQ/BxMuEAlLh5fgjpGoneg//7i1ent28eHW1FkPKhfFhcjhpiu4IgiNQoDuRSM4yC/0dWoX0jBfK9hvTY6evUMlzcuFyfRV3R1TbsyEdjn+gysq3LlwYxjhd2fM5FjYeMo7aDK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264198; c=relaxed/simple;
	bh=79S2NHusfDf8kqQQYNA2iw/6igJvluSpMjKNPaqLyjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Joc8FAvMVKNJmgUfHP0dsaGrezEwByASnjIJ+uICEBOf6gBTBe9u+QO0lqasDRNDoIpCGfn6MYVLwDQxCGFL80yunIc1kR7kyVM0Hh4qg2OtDep56P8DYA382rr9/ersRv0eG+3nMknullK+WJhB1MuWvDZr10TBB+LXiQQbCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKkTU18U; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecddf96313so82525125ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716264196; x=1716868996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=spLqBETeC+qWfSJg+4pVx1XrstM8E2ZSksh7ykN8FD8=;
        b=TKkTU18UcydF1K0TPa/7EhDx2+eh1suhx2NJClR9m29Fn7Xs5GfL/EzpttfOIA9j/Z
         b24XfXammup2uB9MUyeRhyHHF/kQI/SsZNT3QKL1HQvZSSI3vhYMODZtGVoWWUkU01o+
         gnOhcfik7jkJSLARcow+T1TMqBPJPu6lqAJO4pZ3TKVbPG6tSPU/gvPORr9o47DP9mFd
         PBli7yTaWXH3JZ70eacGXwwtiadzzQRMBaHh21eP1B7XjuLPxjMzMpqcPie1BdzrIS59
         ASUUevzLSJWk/UWg2/DJ+yYde0aboeuZrArDJEwcbynjSDjidsq6ejXP/LmqlYUrpmSk
         /jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716264196; x=1716868996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spLqBETeC+qWfSJg+4pVx1XrstM8E2ZSksh7ykN8FD8=;
        b=gacmUW6QzNitn3hnNTFHmjxo4yPI5j3hOaLLRRbiCHb7jE4GtbRAA87bbmdHcWgy0k
         lC83swTF1TUoalMRoLNsk2ac45wt10bRUNuVECRy+ASFoXipJoUKLcCGtr78LBeNSWMy
         SbXstD5ymcU+chV6xUvAHBT1Etr7oVlP4jNOAtLRXRdt8l03fWlgEePL7rATTCQbQIjc
         cmfk0TPhAomJWE/XsWRxrhXCkDny+zMV+FiEm9nZh1Pn/hba2HuMNCAyzds9zCrI2Jwm
         yxJmUwU7i0svrummccusHq1uvYTNzdUmkjxiMje/Ds+Nym30VTv7sTGxbZD6RmrlrXQT
         mQjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRz4LQOGAhxit3ayT+jqrP0CsNnxMIuXFC/GwawX9B5vrTpevoIZ8lVyjsePtQ0UgHjswSRA7ejgVz425zHf5YuxwUyGDtN7YtbXj9
X-Gm-Message-State: AOJu0Ywo0mNd7oAvO6xg3batodIMPmhnnnBsSuBLo2NrcKZkQLvrHoho
	Q32+HPBfLAHHSxx1eD9yCrZj2YVCibEjSXDnnX23NnU7xYBaxv3O
X-Google-Smtp-Source: AGHT+IGliB0CTAHaxPyiVxnLz68yFNjKn75clHMn+AefFU3zI1HVriRKt3gDwUekPuWH6LbqIsZZug==
X-Received: by 2002:a17:902:d4c6:b0:1f2:f043:774e with SMTP id d9443c01a7336-1f2f0437a36mr127361215ad.25.1716264196190;
        Mon, 20 May 2024 21:03:16 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::302d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad62bfsm211683945ad.74.2024.05.20.21.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 21:03:15 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v6 0/3] Reclaim lazyfree THP without splitting
Date: Tue, 21 May 2024 12:02:41 +0800
Message-Id: <20240521040244.48760-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series adds support for reclaiming PMD-mapped THP marked as lazyfree
without needing to first split the large folio via split_huge_pmd_address().

When the user no longer requires the pages, they would use madvise(MADV_FREE)
to mark the pages as lazy free. Subsequently, they typically would not re-write
to that memory again.

During memory reclaim, if we detect that the large folio and its PMD are both
still marked as clean and there are no unexpected references(such as GUP), so we
can just discard the memory lazily, improving the efficiency of memory
reclamation in this case.

Performance Testing
===================

On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
mem_cgroup_force_empty() results in the following runtimes in seconds
(shorter is better):

--------------------------------------------
|     Old       |      New       |  Change  |
--------------------------------------------
|   0.683426    |    0.049197    |  -92.80% |
--------------------------------------------

---

Changes since v5 [5]
====================
 - mm/rmap: remove duplicated exit code in pagewalk loop
    - Pick RB from Baolin Wang - thanks!
 - mm/mlock: check for THP missing the mlock in try_to_unmap_one()
    - Merge this patch into patch 2 (per Baolin Wang)
 - mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
    - Mark a folio as being backed by swap space if the folio or its PMD
      was redirtied (per Baolin Wang)
    - Use pmdp_huge_clear_flush() to get and flush a PMD entry
      (per Baolin Wang)

Changes since v4 [4]
====================
 - mm/rmap: remove duplicated exit code in pagewalk loop
    - Pick RB from Zi Yan - thanks!
 - mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
    - Remove the redundant alignment (per Baolin Wang)
    - Set pvmw.ptl to NULL after unlocking the PTL (per Baolin Wang)
 - mm/mlock: check for THP missing the mlock in try_to_unmap_one()
    - Check whether the mlock of PMD-mapped THP was missed
      (suggested by Baolin Wang)
 - mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
    - No need to check the TTU_SPLIT_HUGE_PMD flag for unmap_huge_pmd_locked()
      (per Zi Yan)
    - Drain the local mlock batch after folio_remove_rmap_pmd()
      (per Baolin Wang)

Changes since v3 [3]
====================
 - mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
    - Resolve compilation errors by handling the case where
      CONFIG_PGTABLE_HAS_HUGE_LEAVES is undefined (thanks to SeongJae Park)
 - mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
    - Remove the unnecessary conditional compilation directives
      (thanks to Barry Song)
    - Resolve compilation errors due to undefined references to
      unmap_huge_pmd_locked and split_huge_pmd_locked (thanks to Barry)

Changes since v2 [2]
====================
 - Update the changelog (thanks to David Hildenbrand)
 - Support try_to_unmap_one() to unmap PMD-mapped folios
   (thanks a lot to David Hildenbrand and Zi Yan)

Changes since v1 [1]
====================
 - Update the changelog
 - Follow the exact same logic as in try_to_unmap_one() (per David Hildenbrand)
 - Remove the extra code from rmap.c (per Matthew Wilcox)

[1] https://lore.kernel.org/linux-mm/20240417141111.77855-1-ioworker0@gmail.com
[2] https://lore.kernel.org/linux-mm/20240422055213.60231-1-ioworker0@gmail.com
[3] https://lore.kernel.org/linux-mm/20240429132308.38794-1-ioworker0@gmail.com
[4] https://lore.kernel.org/linux-mm/20240501042700.83974-1-ioworker0@gmail.com
[5] https://lore.kernel.org/linux-mm/20240513074712.7608-1-ioworker0@gmail.com

Lance Yang (3):
  mm/rmap: remove duplicated exit code in pagewalk loop
  mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
  mm/vmscan: avoid split lazyfree THP during shrink_folio_list()

 include/linux/huge_mm.h |  15 +++++
 mm/huge_memory.c        | 122 +++++++++++++++++++++++++++++++++-------
 mm/rmap.c               |  83 ++++++++++++++++-----------
 3 files changed, 167 insertions(+), 53 deletions(-)

-- 
2.33.1


