Return-Path: <linux-kernel+bounces-277974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C294A8DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F932831C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B943200111;
	Wed,  7 Aug 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmkfjNfH"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10941E7A4A;
	Wed,  7 Aug 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038467; cv=none; b=CqGofm3DQkrsJpFIeveKA86tCOI7kIpEph/5eV8GB1agazo1DnJubR8IUR8pf7+KdTetA8Y13a1FLE6OJObT+QZ35cJTOm/PQJ8VpiE5dGPTW0Kax+8VdODL2bRf47WobjVbnvMmrIxxyZfsqzuqdhDM4X51fOcellL+FABIARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038467; c=relaxed/simple;
	bh=y6lRLj6Q8geyHITcpuqPjhHhU5i39uSDY5DwD7L4kPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opWhtsKXkJpxC5kMvw17Gyj2K4uF4hswduWVnpuqhrMjOfU1CmwKLIz833zTk023lF6RoRKv3T6JFWtN98ut5fTlvr/U8ZpkNtN718lAPJtwAx0RQse0CIMjdOkwTeK6jyWCu6Jpw3hv73w+wSFZ6bNLYAyOMT5cU6cyWBmocJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmkfjNfH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a337501630so88291985a.3;
        Wed, 07 Aug 2024 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723038464; x=1723643264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fj3CiDMnMYVyJ2yBXzbIGfrBkR2JWLiopjH/TBFvqok=;
        b=nmkfjNfH6UpbAcRO3hLxxLYcG72OVGz/qdscalIhjN2SiO7b5V8/XGbdfGYI3eDNJ3
         s8T+cfDOHKa6k8xcNcoAYwJei4q8/+w7gsgIXgz5z0cx3Gu9q2cVlKAb3YWi7cctb33I
         torrYVIhkdi6hOXrvumKqJu1wT1W9TjVR24qGYxfthlUTaG1MW44rl7sbVrww9fZCV25
         ruwjlrJH3lypkF3X1JRHF6Y+Q9dlajQdXuCoXPrlDur1nv69PHyteFQDnTnTWwT6i42m
         izxrbcrbGgmO/JT0NucjKHyHAdfAPJrZgmyXJMDgMJklTpBi9H9XikuLuWsqrf6enjMe
         460g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038464; x=1723643264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fj3CiDMnMYVyJ2yBXzbIGfrBkR2JWLiopjH/TBFvqok=;
        b=ifC5h4+R9C8dHaxlaHhVhGNJpTVF8xz3HyG5oYrbhZYwAwfgOb3Vp8gm6EZsMS+5YD
         /yd5kMvJQq24s53RP8KaEZqlGozmNC8nJehxBVnI9xr9ffDcH1IaH+1FQgEfC2SwtzY2
         bbIdRt07F3p+GJqA+UmjHpb2/O0qzO+LZNBrqM12BEHXpSkrpvCs6ASqKGDZH5ADpLwN
         eA995OWd7HCFE4S6uJ65NFv9dSH4/mKwN2cf9scm+dQSHVwdR5Uw59qey4bmAtWhPAEF
         lUatR3iCCD3wwTUIZKgPxxK5vNbArdpMj71HlniK5Al9TqwGtbcq0GHPlKNyGEHN9RMg
         8uSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAUv7mkmsP5pQwQH3VpNQ5f4Kjvg8tttTOse7iAZL5+pHHS3feqFRwv/YLo6CgpXsxfx59oXHTjZMNJAc2F8eZM1fZ5hFzPIa52PRJx+E/66qLzp/JX9L5GPg09WR0GoyvePNSviLd
X-Gm-Message-State: AOJu0Yxnlo6EqUBl0s5vSnpd9zTwLjoeMsEiquREvQqlV1ZaT+GuAlLl
	9/dR/LYFOpc5oYDWPLDDwjse0E7OiX1lHVcqrCZZKRGL/dIFasmM
X-Google-Smtp-Source: AGHT+IFqIKOM1N4AKrzj/E8x/D2GM2O8SagVmo6dAXhIh1vuGBmeqjfkKgTC39ekJOuIrAu0ZkNy1Q==
X-Received: by 2002:a05:620a:24d2:b0:7a1:d5f3:c7d1 with SMTP id af79cd13be357-7a34ef0aa2bmr2094580385a.22.1723038464478;
        Wed, 07 Aug 2024 06:47:44 -0700 (PDT)
Received: from localhost (fwdproxy-ash-112.fbsv.net. [2a03:2880:20ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786c1ed5sm62130685a.118.2024.08.07.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:47:43 -0700 (PDT)
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
Subject: [PATCH v2 0/4] mm: split underutilized THPs
Date: Wed,  7 Aug 2024 14:46:45 +0100
Message-ID: <20240807134732.3292797-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
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
mapped to the shared zeropage, hence saving memory. This method avoids the
downside of wasting memory in areas where THP is sparsely filled when THP
is always enabled, while still providing the upside THPs like reduced TLB
misses without having to use madvise.

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
# of max_ptes_none value and kills stress.
stress --vm 1 --vm-bytes 40M --vm-stride 50K

v1 -> v2:
- Turn page checks and operations to folio versions in __split_huge_page.
  This means patches 1 and 2 from v1 are no longer needed.
  (David Hildenbrand)
- Map to shared zeropage in all cases if the base page is zero-filled.
  The uffd selftest was removed.
  (David Hildenbrand).
- rename 'dirty' to 'contains_data' in try_to_map_unused_to_zeropage
  (Rik van Riel).
- Use unsigned long instead of uint64_t (kernel test robot).

Alexander Zhu (1):
  mm: selftest to verify zero-filled pages are mapped to zeropage

Usama Arif (1):
  mm: split underutilized THPs

Yu Zhao (2):
  mm: free zapped tail pages when splitting isolated thp
  mm: remap unused subpages to shared zeropage when splitting isolated
    thp

 Documentation/admin-guide/mm/transhuge.rst    |   6 +
 include/linux/huge_mm.h                       |   4 +-
 include/linux/khugepaged.h                    |   1 +
 include/linux/mm_types.h                      |   2 +
 include/linux/rmap.h                          |   3 +-
 include/linux/vm_event_item.h                 |   1 +
 mm/huge_memory.c                              | 153 +++++++++++++++---
 mm/hugetlb.c                                  |   1 +
 mm/internal.h                                 |   4 +-
 mm/khugepaged.c                               |   3 +-
 mm/memcontrol.c                               |   3 +-
 mm/migrate.c                                  |  73 +++++++--
 mm/migrate_device.c                           |   4 +-
 mm/rmap.c                                     |   2 +-
 mm/vmscan.c                                   |   3 +-
 mm/vmstat.c                                   |   1 +
 .../selftests/mm/split_huge_page_test.c       |  71 ++++++++
 tools/testing/selftests/mm/vm_util.c          |  22 +++
 tools/testing/selftests/mm/vm_util.h          |   1 +
 19 files changed, 321 insertions(+), 37 deletions(-)

-- 
2.43.5


