Return-Path: <linux-kernel+bounces-267540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2720F941298
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0161F20EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0172E19F499;
	Tue, 30 Jul 2024 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3QW/RJ6"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656F18E77B;
	Tue, 30 Jul 2024 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344052; cv=none; b=qBTemXl6wlyV8+sRrJXB5HV8iKm6LDN0Us8Ei9aIDQmfIJT2aVr8FzrX+ckqqcGEW/ZPvWcKOHORpFNclf26A0jgyq2TFHViTCvWNUYeSsjQv+tEsLs2YimEXGxEq6goZ5+2tRm2lGy/YIGKmE3TL7UNHXlhaiq00tFmZJOFHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344052; c=relaxed/simple;
	bh=LLiAw6ZxvLcFy7fnlP7whFiN0aTJLUEDsik4Uz39p2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vC0WwmTxMN1Jf2SmoHWzuprmFCUm70oVYMxuEb1YY5kDSSZnI5idUWzVth5/4NDWAjW1aUBbrIQqmy50ARDLEHD7TJmfoy/RgnGGXK1qzE1i+YGn9T1il2lYaPb01IOnFKLCMQPcyNhL4e1TKcmwkYv2iIeZnb5z2j8DGHmNAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3QW/RJ6; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1e31bc1efso259214185a.3;
        Tue, 30 Jul 2024 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722344049; x=1722948849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJYKM99E2+3UyNnfdZyryLSeiuvfGcmER1HaW+0ju40=;
        b=X3QW/RJ6rxPWsyBKCDCEXIM0abhZ2kfpxsGpzAmbdrnmaT76ec8vvzFrBonCuGHN5W
         825DZ3WWoI2vce6HooYBiQruFgbo0FtipOjEAdurOp4BcJw64eNuLq+Mi5kTmLBOwI1F
         xIkmSDM/hK/ZBmuOxaB9lECJey+tthDf8TTQU9H0N6UzTlhIEWJnW7rwg8RwZiawNTij
         OOCG3mDn17o8MXYQfk4hbzBXzmwAtT+TL4MYkrNGNd4fSMt0tHOOXRSoe355hIfp5Iq9
         fwcVJzHKs6n2N+O5+e4OPC0ntF/ffpTmVK8GDGhKBFdRrIEVDXDPornfUnZbKA1s+d4s
         8mPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344049; x=1722948849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJYKM99E2+3UyNnfdZyryLSeiuvfGcmER1HaW+0ju40=;
        b=m8CyFy6IcHK7yZCI04vLbMRujl2P15vVJLSmaiGUA/3VKng2HcmY4+ZXgytJEMU8GI
         sy6YL4ik0oBfVyoBzJCvjahNlOqjywJgjXnOZfaukk7WDfde89DEiMiolmk2tGTtUQwP
         Dg5XboVJQMnsBcGejhr5+3+qr5Fw7a2y3vagvORntduErFBUZ45z/g92/ORBp3LBsCzY
         zlv3h9aALyZIgL0NnjjRAZbPUfwnvkl43G4O5bB1onUYwHJpZm5tuS7W4MnMH45jhdUC
         mESkSN4yXIjhm2VLashEQXtd7R/Fln+kQLH3tZbCOWUL+f1FUSTrcSOqYWc3Q4RkljVi
         dCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVHv4rSMsZ6p708CpKr1qTwv1ilXNH6B9zPVvvJKCghJ/YX+vnjs7NzpwPU85lBJuOcwd9o5wnAhUB+8owfDz1ua5HEjgXs3nSYdfB8TK8OOCRVKtzS6PZmJn1zlpWwQqvupX6F0ZM
X-Gm-Message-State: AOJu0Yy43Tn0+HZEDElsxOl6jFZisSwzmQyLUQUHVXEA66J8ym3djzS2
	jDndQlOXJBQST3k4RB6R0JGk4kannJl4rfIOBej2k6FjK0i0jrGN
X-Google-Smtp-Source: AGHT+IHJH8x1W4h56Q6n4TFNZhS/JteevbctTh7VHs4uLUYEAjKKvOPMlUnAdQWViQNLvChld9W+Fg==
X-Received: by 2002:a05:620a:4551:b0:79e:fef3:ba3 with SMTP id af79cd13be357-7a1e522a232mr1584496085a.3.1722344049079;
        Tue, 30 Jul 2024 05:54:09 -0700 (PDT)
Received: from localhost (fwdproxy-ash-015.fbsv.net. [2a03:2880:20ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8123fb1sm49762661cf.18.2024.07.30.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:54:08 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 0/6] mm: split underutilized THPs
Date: Tue, 30 Jul 2024 13:45:57 +0100
Message-ID: <20240730125346.1580150-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current upstream default policy for THP is always. However, Meta
uses madvise in production as the current THP=always policy vastly
overprovisions THPs in sparsely accessed memory areas, resulting in
excessive memory pressure and premature OOM killing.
Using madvise + relying on khugepaged has certain drawbacks over
THP=always. Using madvise hints mean THPs aren't "transparent" and
require userspace changes. Waiting for khugepaged to scan memory and
collapse pages into THP can be slow and unpredictable in terms of performance
(i.e. you dont know when the collapse will happen), while production
environments require predictable performance. If there is enough memory
available, its better for both performance and predictability to have
a THP from fault time, i.e. THP=always rather than wait for khugepaged
to collapse it, and deal with sparsely populated THPs when the system is
running out of memory.

This patch-series is an attempt to mitigate the issue of running out of
memory when THP is always enabled. During runtime whenever a THP is being
faulted in or collapsed by khugepaged, the THP is added to a list.
Whenever memory reclaim happens, the kernel runs the deferred_split
shrinker which goes through the list and checks if the THP was underutilized,
i.e. how many of the base 4K pages of the entire THP were zero-filled.
If this number goes above a certain threshold, the shrinker will attempt
to split that THP. Then at remap time, the pages that were zero-filled are
not remapped, hence saving memory. This method avoids the downside of
wasting memory in areas where THP is sparsely filled when THP is always
enabled, while still providing the upside THPs like reduced TLB misses without
having to use madvise.

Meta production workloads that were CPU bound (>99% CPU utilzation) were
tested with THP shrinker. The results after 2 hours are as follows:

                            | THP=madvise |  THP=always   | THP=always
                            |             |               | + shrinker series
                            |             |               | + max_ptes_none=409
-----------------------------------------------------------------------------
Performance improvement     |      -      |    +1.8%      |     +1.7%
(over THP=madvise)          |             |               |
-----------------------------------------------------------------------------
Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
-----------------------------------------------------------------------------
max_ptes_none=409 means that any THP that has more than 409 out of 512
(80%) zero filled filled pages will be split.

To test out the patches, the below commands without the shrinker will
invoke OOM killer immediately and kill stress, but will not fail with
the shrinker:

echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
mkdir /sys/fs/cgroup/test
echo $$ > /sys/fs/cgroup/test/cgroup.procs
echo 20M > /sys/fs/cgroup/test/memory.max
echo 0 > /sys/fs/cgroup/test/memory.swap.max
# allocate twice memory.max for each stress worker and touch 40/512 of
# each THP, i.e. vm-stride 50K.
# With the shrinker, max_ptes_none of 470 and below won't invoke OOM
# killer.
# Without the shrinker, OOM killer is invoked immediately irrespective
# of max_ptes_none value and kill stress.
stress --vm 1 --vm-bytes 40M --vm-stride 50K

Patches 1-2 add back helper functions that were previously removed
to operate on page lists (needed by patch 3).
Patch 3 is an optimization to free zapped tail pages rather than
waiting for page reclaim or migration.
Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
subpages when splitting THP.
Patches 6 adds support for THP shrinker.

(This patch-series restarts the work on having a THP shrinker in kernel
originally done in
https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
The THP shrinker in this series is significantly different than the
original one, hence its labelled v1 (although the prerequisite to not
remap clean subpages is the same).)

Alexander Zhu (1):
  mm: add selftests to split_huge_page() to verify unmap/zap of zero
    pages

Usama Arif (3):
  Revert "memcg: remove mem_cgroup_uncharge_list()"
  Revert "mm: remove free_unref_page_list()"
  mm: split underutilized THPs

Yu Zhao (2):
  mm: free zapped tail pages when splitting isolated thp
  mm: don't remap unused subpages when splitting isolated thp

 Documentation/admin-guide/mm/transhuge.rst    |   6 +
 include/linux/huge_mm.h                       |   4 +-
 include/linux/khugepaged.h                    |   1 +
 include/linux/memcontrol.h                    |  12 ++
 include/linux/mm_types.h                      |   2 +
 include/linux/rmap.h                          |   2 +-
 include/linux/vm_event_item.h                 |   1 +
 mm/huge_memory.c                              | 152 +++++++++++++++---
 mm/hugetlb.c                                  |   1 +
 mm/internal.h                                 |   5 +-
 mm/khugepaged.c                               |   3 +-
 mm/memcontrol.c                               |  22 ++-
 mm/migrate.c                                  |  76 +++++++--
 mm/migrate_device.c                           |   4 +-
 mm/page_alloc.c                               |  18 +++
 mm/rmap.c                                     |   2 +-
 mm/vmscan.c                                   |   3 +-
 mm/vmstat.c                                   |   1 +
 .../selftests/mm/split_huge_page_test.c       | 113 +++++++++++++
 tools/testing/selftests/mm/vm_util.c          |  22 +++
 tools/testing/selftests/mm/vm_util.h          |   1 +
 21 files changed, 414 insertions(+), 37 deletions(-)

-- 
2.43.0


