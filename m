Return-Path: <linux-kernel+bounces-177278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61FF8C3C52
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B265280E44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839E146D47;
	Mon, 13 May 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgUlpojv"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EE146A64
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586469; cv=none; b=cB7kjb4xFiIl/Z85QBU4qUYQEm7ynwDLge9hNps4IAOnNoxWxAolyiKQ47FWwivYEfBnBH72buo48SdGkwY7+K/cQaBQspbaawIxzQcnc3GzcP5T2lisOdQTuggysYZScmAjVH7FaE+QdMGLjXZp1BaF4qHlh6QRt4s84qzl4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586469; c=relaxed/simple;
	bh=HfX7F7ojfaf41PdCJZ+kwmTV2ZLK/OS8ZYak0OOG1h0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l1kGpiiHQlDl0bfZCu0ulti1xJSudODihxnzT7UQu6o4+pMhKOZ+Qixgm2NGtgl7+6vuRsZWHnsA3GVmZfpnSfH2oCUE/mdxCyKBbmOkb6AouBA4TpYtDID4SieLdngBBuNzDuOtGR/VOCEP5vnPGNwcCQ0bdEiy4Hs39KzHJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgUlpojv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4f2b1c997so1133317b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715586468; x=1716191268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMsOuSvzf4aVI6LsRrkYGtxxdKvIAWtBa8DssIl0GDM=;
        b=HgUlpojvvXmFDcFMnh8VVXW69Gu9GjpNQWpB48PKrmOzZt6OJbQCOl2VjkVJ9SFzV6
         YgiHbSiudJsJtrMSpcK1k+Klpgvl2sMLIx06GuAEwSaTlJ9UgLau44FGkApDxZ+aPgRO
         yjtLizXJGpWEKlbSPvZRtfsjQvMdFISqy9x5alhf+xnYDRxdM0wSmSE+GaJrpnXoatte
         XcZhzYMOmGi4Pc8SO5kzVLRSZJWzIstnD1DUPJsnyBztTnYNXb+cfi/aKho/VJ9Gh1b+
         x2qN3l7V4bYpq34ntH5tRTdAwrzuZLh/S54O8dBef4YOyejjygHi2ojwP/lgNVCPiFL0
         1xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586468; x=1716191268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMsOuSvzf4aVI6LsRrkYGtxxdKvIAWtBa8DssIl0GDM=;
        b=ofUSoTc7SXB4ggoXQe3ATWNg+wu9Iz7clEEVJCpgJSssDec+ydM2SgkgA9hj1v9BqO
         DEoaTUoPFQugCFEg7tQC52BGeZ+5xIH47O3hXlOHaqmwABj3m5nIp0V+Ws+H+P2Q1JCL
         0s2J9NM4wEqXS4030oGqbrWkTXx63tcfYyZMatCI9VycAVz7tfyJCERZ1iQFUtbSQH3v
         gLMAdlP3RmjePX57axD75FpZbCjtKhIk9XFS0cFOgh7fsjEYuJp264PinjKc4l1mNJ6l
         kg19xjTVPID5Qm228kjLhkWCXXPByep4iOHdQVgCmx4LjhBrUOpHQYzj4PCeSKh/4wP+
         Ybcg==
X-Forwarded-Encrypted: i=1; AJvYcCU2F6PP2Nr6Lgq2j5/bQb/q0aHo33mV4Zzb3hJb590hjHbjzFzQc6MFfU/cIzo7LX2zXfAOQxnzo2Kcs2nrIE/ibm43WGbli+nGi3OW
X-Gm-Message-State: AOJu0YwNpM4rQxGXqe1Vg4AOHLkZl4O410tWN5Gb6aP7SLG7WmVXGwIm
	rRDoWnU3uEVZzRR6lEojsA/pGvn9bacDSd+VKwSVB1jjw02NaHwq
X-Google-Smtp-Source: AGHT+IELxEpVMigw41d+USsvJh6XNnuiakSF+kkZsKY2vnA7653ykgBEkQSFtd6+p793bowb5qsR4w==
X-Received: by 2002:a05:6a21:99aa:b0:1af:cc48:3e25 with SMTP id adf61e73a8af0-1afde0af471mr9450020637.10.1715586467513;
        Mon, 13 May 2024 00:47:47 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66621sm7008967b3a.13.2024.05.13.00.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:47:47 -0700 (PDT)
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
Subject: [PATCH RESEND v5 0/4] Reclaim lazyfree THP without splitting
Date: Mon, 13 May 2024 15:47:08 +0800
Message-Id: <20240513074712.7608-1-ioworker0@gmail.com>
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


