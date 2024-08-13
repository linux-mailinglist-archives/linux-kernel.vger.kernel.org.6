Return-Path: <linux-kernel+bounces-284711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2945195045A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E18CB24816
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2914199230;
	Tue, 13 Aug 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMuC6p2X"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BE2262B;
	Tue, 13 Aug 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550626; cv=none; b=rwSyboKcvehAa/eqJf3aoNKwGTnFrHPypegYof/1ukUcn1n+fHmLuEux4PdJ8QIGDzGY8B9PMFvAOw8gZnjYbfA0z7XAAKQJhiMyHKOdTT0mUtd2B1inzfeY428ONFPJ5TXLpQs2bJUfe5oHYdodcumPcoSGWf20IduZ+BcSrIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550626; c=relaxed/simple;
	bh=BM8v+PENXndSgNTYVvHrTXN87K08owbElsVe0qrI+TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhNDry+sXBYS2cBfQWU0A9jUHtFJjl0lW8DfqePm72RuMCLCiliuw/PaMU7yfp6/mdKDbJEv5HcHHX4SfGJbhgAOZP6LSsrsv+7oPi4f1SFhbySuQmBZT5IuNVte/Os8Jp1cty7qYr7hwKu/DgdewyV9+RGk2W5zN3ozQAeBKSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMuC6p2X; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1dcc7bc05so359439885a.0;
        Tue, 13 Aug 2024 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550623; x=1724155423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4mgO91X0ECSZtREEM3BoWhZk1QC/8Jzg6tpXLFE4Nc=;
        b=hMuC6p2Xagg+pGppK14Sa3SN92LGbdKW80B82AsI0yjp7QDt3P+DCZQHAMd7rODum3
         TKHlOoBdHR7H0wfMBcmKiNlfhcrUWElzSVKBYQra3wtwLcInuiFy6cRXP/k0l1+JRIiX
         C3szwC7CxhQKQGKndP6nGej4MBFQzlzc5wcKi1E4Bkw8Gd4wHL7K9LSX9SMXcXcZ424t
         bnn2LfE/hvFC+ogJaGMKTCk4FzA1IKEpNWW5eJDZbbATgi+O7qaO1HXYvuXSa8Az24Y0
         UlEgON8d+LZCLMBt5vO/6XNEJAs2vg4q7uJOq76zSodAfwU63gc1ryXWFXirRjQfOgaV
         U9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550623; x=1724155423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4mgO91X0ECSZtREEM3BoWhZk1QC/8Jzg6tpXLFE4Nc=;
        b=WMd6JulWDdi4vv9HtoSPgvuqQT+tTrILoc/vJm7Y8XrrYxxGt3Xi+kDr98uG71vmz9
         3HZh4Ozmogv5h41ysyaYvHU7hoc++1N6rMLMchJ2L9j+rrfgaItIhuWUlA/q8WqH2oQW
         MKfBBKeGPmP0P3oIIq7mGOxtGrnWk5sJUWHVByr9LGf2tx0D1cc6tuoMOJW8M2Ej/RoW
         a4VCaKBwM68s+PmLawRhKjsEyu+qs3kipSEqG+lwscH2iTHt4K9Td55mkLsHBXU7b9z5
         lOjesgaFHyWJbSmMdcOdGTzHHu0C0fFe19LoYMU8dkx6bYDOFdTOXsJmZWwZr2dnmdDP
         2LUw==
X-Forwarded-Encrypted: i=1; AJvYcCUQKtXHOOj1MqoR8kIyHYoDTKbBg5LLMEwhvFud9uX5yBhB+w1lxS7d89+011Lt1zBVPUCZlglX/Zl3S7YJL42xiOJVI1I4kH+gCsGpdA1oiIW2lFn6LMXvpI3+t9vXpXZuQCUodzH6
X-Gm-Message-State: AOJu0YxbYsFOYXoH5xx5Fo4jCpFVvJLWWkjSJKfntluHknK1x16EgLhX
	AeGIwFKqgISHKbx/h0YqyjOeGugUWjZfAfJHeURYA8yj8nMWsGwM
X-Google-Smtp-Source: AGHT+IGT2fzTngjdee05ugmGl4tk7xJ0T9MPishojJ5VclajUPbjUng4/SWveUmLtJvIhfmk6VXO4A==
X-Received: by 2002:a05:620a:28ca:b0:7a3:6dd9:efa6 with SMTP id af79cd13be357-7a4e1537391mr410740885a.33.1723550623047;
        Tue, 13 Aug 2024 05:03:43 -0700 (PDT)
Received: from localhost (fwdproxy-ash-011.fbsv.net. [2a03:2880:20ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d64878sm335487285a.24.2024.08.13.05.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:03:42 -0700 (PDT)
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
Subject: [PATCH v3 0/6] mm: split underutilized THPs
Date: Tue, 13 Aug 2024 13:02:43 +0100
Message-ID: <20240813120328.1275952-1-usamaarif642@gmail.com>
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

v2 -> v3:
- Use my_zero_pfn instead of page_to_pfn(ZERO_PAGE(..)) (Johannes)
- Use flags argument instead of bools in remove_migration_ptes (Johannes)
- Use a new flag in folio->_flags_1 instead of folio->_partially_mapped
  (David Hildenbrand).
- Split out the last patch of v2 into 3, one for introducing the flag,
  one for splitting underutilized THPs on _deferred_list and one for adding
  sysfs entry to disable splitting (David Hildenbrand).

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

Usama Arif (3):
  mm: Introduce a pageflag for partially mapped folios
  mm: split underutilized THPs
  mm: add sysfs entry to disable splitting underutilized THPs

Yu Zhao (2):
  mm: free zapped tail pages when splitting isolated thp
  mm: remap unused subpages to shared zeropage when splitting isolated
    thp

 Documentation/admin-guide/mm/transhuge.rst    |   6 +
 include/linux/huge_mm.h                       |   4 +-
 include/linux/khugepaged.h                    |   1 +
 include/linux/page-flags.h                    |   3 +
 include/linux/rmap.h                          |   7 +-
 include/linux/vm_event_item.h                 |   1 +
 mm/huge_memory.c                              | 156 ++++++++++++++++--
 mm/hugetlb.c                                  |   1 +
 mm/internal.h                                 |   4 +-
 mm/khugepaged.c                               |   3 +-
 mm/memcontrol.c                               |   3 +-
 mm/migrate.c                                  |  74 +++++++--
 mm/migrate_device.c                           |   4 +-
 mm/page_alloc.c                               |   5 +-
 mm/rmap.c                                     |   3 +-
 mm/vmscan.c                                   |   3 +-
 mm/vmstat.c                                   |   1 +
 .../selftests/mm/split_huge_page_test.c       |  71 ++++++++
 tools/testing/selftests/mm/vm_util.c          |  22 +++
 tools/testing/selftests/mm/vm_util.h          |   1 +
 20 files changed, 333 insertions(+), 40 deletions(-)

-- 
2.43.5


