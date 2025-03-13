Return-Path: <linux-kernel+bounces-560366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D983A60334
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C093BFE45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBDB1F4727;
	Thu, 13 Mar 2025 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="sTwR3LqO"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129545948
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900020; cv=none; b=twqPaoq/DVsrYY/baB+E2EuEhkfRAR33YVowqRvNT9npX0vnj7xuDGBge9MMsWR2dwm5PjlHCcRoaXEMn0WBcn2w15J2MovQEXogLJAwB8wG15eaa5UbMzLdgGs5cm+JjzRMKf8vhZ61RQpb1uzQlfcvLnlHsCLqjdoaxc7wSTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900020; c=relaxed/simple;
	bh=7zeuJ/gANn4pOQ7bDcZjWIQQLSbI9al+2RepJvI1+kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrU/AicdbIpMgp7ALnxe4U94qR9g7z8evv2PeyZQeD/1P1W6no6WlBicGWjsrk4ax6EFOTVuLfgOw10KHpTnTydmfbBMpDTldGn6OdTp+HqkSRh22LP42ffmACJWHj7oDpsNE+F9WbZydMgXb+RY6+LolMfYZErMzm+ivKyHhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=sTwR3LqO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f916e75fso29379396d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741900015; x=1742504815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=acnkGczaHoZ7Fx3rgT5jbvpZ1dgElb8rpj0kySNqzQc=;
        b=sTwR3LqO/bF/KeLDyg9IPgirAf0/oONsbbfj2GF1vg9jm0/bjt14OyBgl/qdkS2zQT
         ZroBM0EO4hxgbeskdU5Aqn0m4lWcYp80vM6xtEiUTyuIn8/fXGYnN52CfMyDy1m302jC
         MLOgEs/F1tVkFBVe05MemPpXIuxyWJ2cB4aJtAhc8qSCZSA1OBQxhHms2zSHS+/CpQQW
         +KWLk5UDxzMWdVlzK3xzEBcudtUW2mXoucYw9bzCAzN2VIQJOVlRyFtZnHYf9R2KVQYE
         UNLbo+zQpfm36rnynX8FQtscf8zocRuhwVW7YTCL7SEzF4zHlPNnhQCkNXMA8SIW8TbE
         +x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900015; x=1742504815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acnkGczaHoZ7Fx3rgT5jbvpZ1dgElb8rpj0kySNqzQc=;
        b=vyeThfeYncpUANn5PUMNvJaOcTXlXWGpFjOicNw2LjwskZLBlZwEOzSxyucJqkaY1t
         mMlCuARaVj/+REPaKwkUPd/iZUpv9xcNKy8m+UT1k/cq3h90ojk9YU8aATYJWWM4U/tT
         xBxdyO2+mNtHXFM63KzGSJemFWM+B+2BytWB6pQlFWbiuKCNGhzX7gXwIKU0BTFcrD7z
         mbo5b7B4UlkRgMX6IFXyp8RFQiSKfXeCc0T0gU7MMBBIgUwrjOlUChQ/y9sRHGEFYC9s
         926kmY+dBni7rhYZZJBlVKn6FjkScke+O5JPwVHYKUGDu/HWdqcWTC7FhlQ1pdjXIKoQ
         JGjg==
X-Forwarded-Encrypted: i=1; AJvYcCVlsSAD8mtL5fl//5AI0MkpLq2cn4zoBRjnBeO80TFdRrPk0Wf5zt+HSNiNiQDJ/S9QhqsHdbWuUcCzqCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6k8RZ0B9WE06DIu1VTxuq80L84wx21e7fgtg+dzbDYs+F6UND
	o04/wfdisAYf1jMoa++iWnBZ2QS1MMA03wxbQW6vm4uyGaRz7Sxnj3KWDO8ZGkn2KGUf5h0HQI8
	L
X-Gm-Gg: ASbGncs+T3DYeBcveqqUzU3uVh22j4S/ybbJhkqOU0ixlT3E9OsTAe01rZ+u4Tw9O+5
	9fS2W2LRh9JjxFoERxy6kpCQ9TeFx1sTaN5UwE6kQ0bEYbCeUSU3CID5doGyuQqFwSOQqVft0B6
	NDGXhIWKwlVF58i+xFfMlHhf6KM6JGYiMD6a+5toOvU4edGI7P8Oc0YdrUe1yZGfZQfsGCvv87Q
	9nF4tE2ZXY6o3wwEe5/bb0xvUYuYHU9b6DTO4POEVWQw8OSh4yU+O5myqB29yiWwKP/nhgQsN/8
	JsJXhnYphDyxg2Cy9Y9h7CR5h/1c7+0SL5hGX/kxFTA=
X-Google-Smtp-Source: AGHT+IHhJKfY1xzK0yGlgacwgxvBIof6ldTsBteC55oukFeS9CLgsFgifOVwTo6sprjF60jwNuwHrg==
X-Received: by 2002:a05:6214:3007:b0:6e2:485d:fddd with SMTP id 6a1803df08f44-6eaddee6d07mr71984676d6.1.1741900015290;
        Thu, 13 Mar 2025 14:06:55 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade2097f3sm13863406d6.17.2025.03.13.14.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:06:54 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] mm: reliable huge page allocator
Date: Thu, 13 Mar 2025 17:05:31 -0400
Message-ID: <20250313210647.1314586-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series makes changes to the allocator and reclaim/compaction code
to try harder to avoid fragmentation. As a result, this makes huge
page allocations cheaper, more reliable and more sustainable.

It's a subset of the huge page allocator RFC initially proposed here:

  https://lore.kernel.org/lkml/20230418191313.268131-1-hannes@cmpxchg.org/

The following results are from a kernel build test, with additional
concurrent bursts of THP allocations on a memory-constrained system.
Comparing before and after the changes over 15 runs:

                                                     before                   after
    Hugealloc Time mean               52739.45 (    +0.00%)   28904.00 (   -45.19%)
    Hugealloc Time stddev             56541.26 (    +0.00%)   33464.37 (   -40.81%)
    Kbuild Real time                    197.47 (    +0.00%)     196.59 (    -0.44%)
    Kbuild User time                   1240.49 (    +0.00%)    1231.67 (    -0.71%)
    Kbuild System time                   70.08 (    +0.00%)      59.10 (   -15.45%)
    THP fault alloc                   46727.07 (    +0.00%)   63223.67 (   +35.30%)
    THP fault fallback                21910.60 (    +0.00%)    5412.47 (   -75.29%)
    Direct compact fail                 195.80 (    +0.00%)      59.07 (   -69.48%)
    Direct compact success                7.93 (    +0.00%)       2.80 (   -57.46%)
    Direct compact success rate %         3.51 (    +0.00%)       3.99 (   +10.49%)
    Compact daemon scanned migrate  3369601.27 (    +0.00%) 2267500.33 (   -32.71%)
    Compact daemon scanned free     5075474.47 (    +0.00%) 2339773.00 (   -53.90%)
    Compact direct scanned migrate   161787.27 (    +0.00%)   47659.93 (   -70.54%)
    Compact direct scanned free      163467.53 (    +0.00%)   40729.67 (   -75.08%)
    Compact total migrate scanned   3531388.53 (    +0.00%) 2315160.27 (   -34.44%)
    Compact total free scanned      5238942.00 (    +0.00%) 2380502.67 (   -54.56%)
    Alloc stall                        2371.07 (    +0.00%)     638.87 (   -73.02%)
    Pages kswapd scanned            2160926.73 (    +0.00%) 4002186.33 (   +85.21%)
    Pages kswapd reclaimed           533191.07 (    +0.00%)  718577.80 (   +34.77%)
    Pages direct scanned             400450.33 (    +0.00%)  355172.73 (   -11.31%)
    Pages direct reclaimed            94441.73 (    +0.00%)   31162.80 (   -67.00%)
    Pages total scanned             2561377.07 (    +0.00%) 4357359.07 (   +70.12%)
    Pages total reclaimed            627632.80 (    +0.00%)  749740.60 (   +19.46%)
    Swap out                          47959.53 (    +0.00%)  110084.33 (  +129.53%)
    Swap in                            7276.00 (    +0.00%)   24457.00 (  +236.10%)
    File refaults                    138043.00 (    +0.00%)  188226.93 (   +36.35%)

THP latencies are cut in half, and failure rates are cut by 75%. These
metrics also hold up over time, while the vanilla kernel sees a steady
downward trend in success rates with each subsequent run, owed to the
cumulative effects of fragmentation.

A more detailed discussion of results is in the patch changelogs.

The patches first introduce a vm.defrag_mode sysctl, which enforces
the existing ALLOC_NOFRAGMENT alloc flag until after reclaim and
compaction have run. They then change kswapd and kcompactd to target
pageblocks, which boosts success in the ALLOC_NOFRAGMENT hotpaths.

Main differences to the RFC:

- The freelist hygiene patches have since been upstreamed separately.

- The RFC version would prohibit fallbacks entirely, and make
  pageblock reclaim and compaction mandatory for all allocation
  contexts. This opens up a large dependency graph for compaction,
  possibly remaining sources of pollution, and the handling of
  low-memory situations, OOMs and deadlocks.

  This version uses only kswapd & kcompactd to pre-produce pageblocks,
  while still allowing last-ditch fallbacks to avoid memory deadlocks.

  The long-term goal remains converging on the version proposed in the
  RFC and its ~100% THP success rate. But this is reserved for future
  iterations that can build on the changes proposed here.

- The RFC version proposed a new MIGRATE_FREE type as well as
  per-migratetype counters. This allowed making compaction more
  efficient, and the pre-compaction gap checks more precise, but again
  at the cost of complex changes in an already invasive series.

  This series simply uses a new vmstat counter to track the number of
  free pages in whole blocks to base reclaim/compaction goals on.

- The behavior is opt-in and can be toggled at runtime. The risk for
  regressions with any allocator change is sizable, and while many
  users care about huge pages, obviously not all do. A runtime knob is
  warranted to make the behavior optional and provide an escape hatch.

Based on today's akpm/mm-unstable.

Patches #1 and #2 are somewhat unrelated cleanups, but touch the same
code and so included here to avoid conflicts from re-ordering.

 Documentation/admin-guide/sysctl/vm.rst |  9 ++++
 include/linux/compaction.h              |  5 +-
 include/linux/mmzone.h                  |  1 +
 mm/compaction.c                         | 87 ++++++++++++++++++++-----------
 mm/internal.h                           |  1 +
 mm/page_alloc.c                         | 72 +++++++++++++++++++++----
 mm/vmscan.c                             | 41 ++++++++++-----
 mm/vmstat.c                             |  1 +
 8 files changed, 161 insertions(+), 56 deletions(-)


