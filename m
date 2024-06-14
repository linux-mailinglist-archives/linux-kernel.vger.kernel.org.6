Return-Path: <linux-kernel+bounces-214199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A71908120
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A287C1F232E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C540E1822F3;
	Fri, 14 Jun 2024 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzbVVz64"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622183211
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329933; cv=none; b=IPHhIHOiTDYJEdqK2zJLuuIjXz69XfLRa9HcbHkEebAcuG+NTTPMWs6DureQR6ZQCxBtqX8UFSlqLA1APCWK2XlizGxWkG0mIsWnbJh76ogdntaSuwr8uaHMWtebXEbx/15wxxF5QqqrMgQ2y9UZalgzo8SS1QLvFZOi5B29OLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329933; c=relaxed/simple;
	bh=8Ki4l3T6vH22W0aVvzk3kvtFnLQJGMOGdu99Et0LUyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nfSmkZP6xx9uvUon5JXkdrfmKAUhFvR+WhCuY+DVVnj5ZL5V5+D4NmB9XXU2p4kLUMSukdqCuSzaW0k2xzh4b1NgMX31wwTnOcZ6cR8jCakuaSYEy+ogATv2oZweZXe8RJnUC4SMQiUDePIV3szvLZC9VfoBpd1pq2bqn3b7q+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzbVVz64; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f97a4c4588so959280a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718329931; x=1718934731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1wXsOFCer7vHGFr9Qte+BXKKrfUhXYrUOWzgt+gKOxk=;
        b=TzbVVz64g3v476lP9sJfGuRNNEwfI9lqksEtN51nXT8ru9sMK95vC9N01d0MEpDGCy
         6nHXldaJ21hao20ywccayIzANtS8qhxwANRCVBshTBu+CJ2/730D1tiTWVp0M09CxdgP
         N+12K5XdOsTUJYKcVgjjeLlRSjzCqQHaLxGVGxAM1ZgylMxN31bWBag80t3xNAuijBe6
         3imM7S6Wgg1WbSXJc5GHbpvdxjAgRMX2gbbszMmJkv2Cw3ITsYlm94ln7GqzDJPY5R1F
         G1tErztxblmKB8qdv/wVhzciDK0MrnhBb/G87G8/8dIaxBmk4sBMlcnyf3eFRP2bsghk
         fEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718329931; x=1718934731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wXsOFCer7vHGFr9Qte+BXKKrfUhXYrUOWzgt+gKOxk=;
        b=A6oELk7HRftCVzGczsiZSpn1k0/5vY5FEPvIhhJW3fmz3AD3MsGoiq6LGotZmbklE8
         CJ52PBph8ut+eETuG8VbjJLhYkA50zFl+I4kT2sYkXL1pLRN3IzOjQHFsFNT8ZZ59NZZ
         aqI3nMBDbtNueaD1g+bnvImiZzbrCLlU6F7o77podNYCk2C1RCEwmYlaVLnV7dA/G6ei
         djmPOYE+8rQuE+86CHRY2Gqd/D6LAMIWtNRoWT7u3+EJsCbrB+NsL+suPp2IZ3IrGj1A
         jetljijmNUBVyKfr+7FUpwV9FKuf6womwHUYJ2BDj/HPtXwC0qwe9trDVMX5JNiiUtf0
         9Teg==
X-Forwarded-Encrypted: i=1; AJvYcCXSI+G9f7Kz9z6AMhQEmay9AwgtpYe/+lip5tgWSLYy8WLu4dqi3aT0IxSU8nhBsJzE8obQhKFHm+OVomeHyNX8oQ8U1FG/kmRW5u6a
X-Gm-Message-State: AOJu0YxAlfEpR6ezRBUPCkoTCNBDhHnMN9bFEQUjjzjqWiKkA7xg1vY/
	7pqtfA97Na4uayUL68lBNu7DqHsklwIpW75YA5u3JMSP1qjFxyqB
X-Google-Smtp-Source: AGHT+IH8DzzZU7rX/4lt7YzMOCeNUh+JeaFDz5nfyyGRhoig8GO71+REZov7Bt05RgQd3c6h9EEi8A==
X-Received: by 2002:a05:6870:a690:b0:254:b0b0:9335 with SMTP id 586e51a60fabf-25842981936mr1466954fac.33.1718329931164;
        Thu, 13 Jun 2024 18:52:11 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96d4c3sm2000912b3a.59.2024.06.13.18.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 18:52:10 -0700 (PDT)
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
Subject: [PATCH v8 0/3] Reclaim lazyfree THP without splitting
Date: Fri, 14 Jun 2024 09:51:35 +0800
Message-Id: <20240614015138.31461-1-ioworker0@gmail.com>
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

Changes since v7 [7]
====================
 - mm/rmap: remove duplicated exit code in pagewalk loop
    - Pick RB from Barry - thanks!
    - Rename walk_done_err to walk_abort (per Barry and David)
 - mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
    - Make page_vma_mapped_walk_restart() more general (per David)
    - Squash page_vma_mapped_walk_restart() into this patch (per David)
 - mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
    - Don't unmark a PMD-mapped folio as lazyfree in unmap_huge_pmd_locked()
    - Drop the unused "pmd_mapped" variable (per Baolin)

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
[7] https://lore.kernel.org/linux-mm/20240610120209.66311-1-ioworker0@gmail.com

Lance Yang (3):
  mm/rmap: remove duplicated exit code in pagewalk loop
  mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
  mm/vmscan: avoid split lazyfree THP during shrink_folio_list()

 include/linux/huge_mm.h |  15 +++++
 include/linux/rmap.h    |  24 ++++++++
 mm/huge_memory.c        | 118 +++++++++++++++++++++++++++++++++-------
 mm/rmap.c               |  68 ++++++++++++-----------
 4 files changed, 174 insertions(+), 51 deletions(-)


base-commit: fb8d20fa1a94f807336ed209d33da8ec15ae6c3a
-- 
2.33.1


