Return-Path: <linux-kernel+bounces-177148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1CF8C3AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BB5B20C37
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9DD146005;
	Mon, 13 May 2024 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGY9H0Gd"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774B1E493
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715576774; cv=none; b=KWVvM5KLjxY3IIllMOc7RDylY9T+j4T2ShSQWiQ/++5yEeQwCtumatKJDpiQ0+ZvDC/3hg99c6wymywrKOwX72bMwnlhpPZZFEgmaF7sgVpAKVIQ2XJhe/J+JQBCzMYMVFfUTJAnCP1Z29+japyYQ48GvHX4BnTTtsL1tmwHv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715576774; c=relaxed/simple;
	bh=HfX7F7ojfaf41PdCJZ+kwmTV2ZLK/OS8ZYak0OOG1h0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hgpSXTR4O7pJLteQ54sFjrFm1eY/WhnmHRC3H0OeEX7nFy4y9LWt3RdWB+kGHPIn8En/bLOCc3mIw4uPU+HD2ijzwuAMORP68b+DGtpjKc0ENzi3pn+7JWH1SLjlGZlEF9CMFkv7B1gFqQWBTgQe5/dpyeD9+ZWZOBg1sx9vBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGY9H0Gd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f45020ac2cso3042020b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715576773; x=1716181573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMsOuSvzf4aVI6LsRrkYGtxxdKvIAWtBa8DssIl0GDM=;
        b=CGY9H0GdIG/dzPFk/XvgK6eUrkM8P4VELdS/6u0XMeiRAEPRVKPCUeVvTMh6rYrGOi
         5YBlIBwfihHIfBInf1sXHm667+9mIrIKMdr+GdCmBQur4fY7pwx3WLPjNwy8vNVcm3uP
         5dQ3UFn4DYVo0EMb0ipwQEebJQ3NqFFVUQH5Yo/pptcdi9vG5/3Qp8pSJlfjdJq18HwE
         IvIo4BGoPlSbMx7WHp57+O/H/yA5OU7uOetCc4nhgPCSflAiu/eoOo5s0wxEW1268Vhe
         k28noixWeZd2kCiWzqZBmXDLacSRp187seNUDOwe0OTmhA4+ZtPLPDoWuRvZM3YwE7IP
         Krjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715576773; x=1716181573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMsOuSvzf4aVI6LsRrkYGtxxdKvIAWtBa8DssIl0GDM=;
        b=Q1SekGhmlR/OLB7cZpvQmsKFxNspC1tX17I1OjG/2+Yrcq40bX1r9WM7AuGFijEmpe
         Xv++3CVy/HqKnGXdYmdsdJ+jD2AAl8EJdAodqzU4d0BxgsgDVNtyT6M5C0/hIyJ96gK6
         C9nKJb+ilf9CaBZvgf7To0Um0UeJFRbBMAbfHQfOA2PfNiQHAowxytI9dwjuU4TLJLNe
         FmohjYJtH1u/ltXd9AMD9EQERLG33q91jQ90raoOs8vwyBOqI1DcVItNS1eNyDbs6Wbn
         lD+ovLqQma05ODxKa18/st/ZAJMQZ5d1Yoy1O+eWJD/qQ97axmlm+bFdgir6QB9+j8fr
         gEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEZFcGTUpesz+vNxdyZyz/oDX9wu2i6OR/wwY05lwo2j1ItRHihPWZHzxA+TKsoYLwsyQ1y8WmbH1GsZlgJ7JAhe8FE2wLM1f8HEjF
X-Gm-Message-State: AOJu0YyNkKS/99Ln2QgXyxe7YMMPwSS9rMwHRuQgIfTg2SaIBwXAo4r0
	HkfJAxmvXflj4660ry0hEX1TqCOA5w8vxLyzW2mZ06DgjJAnroY4
X-Google-Smtp-Source: AGHT+IGYrPCxcmnR8cJ4d+auQeAC8wKD1GQ9YTUIxUbDF7H2GDkf39apOY5KNAJeaYeRqV+ZkUDjPw==
X-Received: by 2002:a05:6a00:2daa:b0:6f3:ebc4:4407 with SMTP id d2e1a72fcca58-6f4e0299e1amr9756864b3a.4.1715576772592;
        Sun, 12 May 2024 22:06:12 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b26ceasm6507313b3a.187.2024.05.12.22.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 22:06:12 -0700 (PDT)
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
Subject: [PATCH v5 0/4] Reclaim lazyfree THP without splitting
Date: Mon, 13 May 2024 13:05:21 +0800
Message-Id: <20240513050525.84252-1-ioworker0@gmail.com>
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

Lance Yang (4):
  mm/rmap: remove duplicated exit code in pagewalk loop
  mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
  mm/mlock: check for THP missing the mlock in try_to_unmap_one()
  mm/vmscan: avoid split lazyfree THP during shrink_folio_list()

 include/linux/huge_mm.h |  15 ++++++
 mm/huge_memory.c        | 117 +++++++++++++++++++++++++++++++++-------
 mm/rmap.c               |  73 ++++++++++++++-----------
 3 files changed, 153 insertions(+), 52 deletions(-)

-- 
2.33.1


