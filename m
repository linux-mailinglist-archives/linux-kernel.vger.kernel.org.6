Return-Path: <linux-kernel+bounces-208125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E93D902123
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4052F1C23067
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707178C9C;
	Mon, 10 Jun 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt559jjE"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0BDBA53
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020943; cv=none; b=Fw8LYprMotUxyBH/w33tJgyvX3S5eClspzENQrzVHQpw8lqOmDF7YddkUpQJPmBQbRM4BxcqkPrWeUDkRCii9TxNG2+ayLkVj8R/ioW0KoUeXDBlcDTvfHCGgcnxxe+wh/vb9Y3PfKvKkTW0MHsQaKBi0sq1WxJUqQpsA5P33jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020943; c=relaxed/simple;
	bh=aQFP7gNPrNXTh2IHcUhusTtvEa4HHQK5PtH55IE5+CE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMdEWBEEVjxKYrqQI+Ndn7vo/YNJwWJp3LYXuKukBIim8YSp+q4345h5bDiUBRegm40t0gzHvbmF142XtpWdZVuGz/ydAUDhjNjKk9xrPJHXnOyVHwI2KVs/wD1XbtKpgCKwO9KFi9yGG3WRtJDmoc0L+/wzFCsVNU8WZBYSOpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt559jjE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c199e37f4eso3636699a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718020941; x=1718625741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26tuUrqnEQfFAp3h3pgs/MAqgYUu2Sg0W6tKE5DaxLQ=;
        b=Gt559jjEYDTV3H1vTGqtTJWt9aAOwk0l6F/kU2g4jYtTgHqhoc40wLOeUC0w3ha9e7
         qAGOpCFQuOm5YZCZxhTqKJ48HLUH7NdwKVA61Rp9zPnNX4phO7U/v3rfLI6SrFvNIv7a
         zhAqZTwFPuo4EPsLTAXE8eEhz0GJ54hzxR00R1L3JQCbXbv2FyNvS3ZL5xDrGkWG5h01
         euKvz/DHt4vXX8V8CZTrhgoGS82YylXATf7caJjRCalD2YX6hpl3LkBo6GZapzqUrjFT
         Et8aWYy+aCGXG3ApwNm80+FajfbqLWbpCoI4KQnduc4LIQAcO0DXe2FA5jNa4/vNPHzx
         QYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718020941; x=1718625741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26tuUrqnEQfFAp3h3pgs/MAqgYUu2Sg0W6tKE5DaxLQ=;
        b=qrEVM7MRX4gz7eTb0Wq6EZPwVb3Hj+r1MWQDpJERej1HF8mM1+4mlNt7wPJKQT3Scf
         qR/n05RHPoEGGLBN8ySMJxn9Y5LIPaqmPjSwx3pQyrlqYowYeA7JhKqRUr3IUmIWX4/k
         B1UfyTTqHT0lIfviYvLZOg+VR5P3WCAxYd+Av3fs87dYxCqvSOBRjhtSfCinxyQr9V5Q
         Bfha/GDTsQpd+wXdw5JAK9vhEjvg0SIPb+fLN8JDx8VQHy5Xtt+3bbVxUJpKVIxHDsk4
         0IGbclL6e1OeRI4d2skZbJ8Qrb6KVFui9eGSr5ipzX2yIjFcIMle24NzRoEaW0BBKnCV
         oqIg==
X-Forwarded-Encrypted: i=1; AJvYcCVZEUvjYX57vk57m0qPE4jiP/expqS9RsBOgY51GDDNXpfcERxLWGQGUq9hmrdc08P6zXme/8RoUKqdbs/3NtKZTvpoA6IaVf1rvYBm
X-Gm-Message-State: AOJu0Yxc0Q7J8g5bL0XmI96gGnVKf2qnb9K7n9j3x2XfUbu4i6OBtyqd
	Z8HOtDUwldpKShKNc/JlyYbJyTlOm6fPJ/wFVLQhQ24T3PL8gI8t
X-Google-Smtp-Source: AGHT+IFBudSl4WgItCCnP5LfGTAa8cr1lbmtKS+NCmJH2FoXqV6FA1FwxGmVoAyBzdfwCVxMYS/NSg==
X-Received: by 2002:a17:90b:817:b0:2c2:f2d6:60d4 with SMTP id 98e67ed59e1d1-2c2f2d664aamr3884336a91.8.1718020940887;
        Mon, 10 Jun 2024 05:02:20 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c302f0ebdcsm2478478a91.23.2024.06.10.05.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:02:20 -0700 (PDT)
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
Subject: [PATCH v7 0/4] Reclaim lazyfree THP without splitting
Date: Mon, 10 Jun 2024 20:02:05 +0800
Message-Id: <20240610120209.66311-1-ioworker0@gmail.com>
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

Changes since v6 [6]
====================
 - mm/rmap: remove duplicated exit code in pagewalk loop
    - Pick RB from David - thanks!
 - mm/rmap: add helper to restart pgtable walk on changes
    - Add the page_vma_mapped_walk_restart() helper to handle scenarios
      where the page table walk needs to be restarted due to changes in
      the page table (suggested by David)
 - mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
    - Pass 'pvmw.address' to split_huge_pmd_locked() (per David)
    - Drop the check for PMD-mapped THP that is missing the mlock (per David)
 - mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
    - Rename the function __discard_trans_pmd_locked() to
      __discard_anon_folio_pmd_locked() (per David)

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
[6] https://lore.kernel.org/linux-mm/20240521040244.48760-1-ioworker0@gmail.com

Lance Yang (4):
  mm/rmap: remove duplicated exit code in pagewalk loop
  mm/rmap: add helper to restart pgtable walk on changes
  mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
  mm/vmscan: avoid split lazyfree THP during shrink_folio_list()

 include/linux/huge_mm.h |  15 +++++
 include/linux/rmap.h    |  22 ++++++++
 mm/huge_memory.c        | 122 +++++++++++++++++++++++++++++++++-------
 mm/rmap.c               |  77 ++++++++++++++-----------
 4 files changed, 184 insertions(+), 52 deletions(-)


base-commit: 6b77d01728f219a091f55ca3142bbc4e4057ca50
-- 
2.33.1


