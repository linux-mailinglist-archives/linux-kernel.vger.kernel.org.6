Return-Path: <linux-kernel+bounces-263067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B409D93D094
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7386D281F25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37AE176AAC;
	Fri, 26 Jul 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG6Tei4o"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E331EF01
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987223; cv=none; b=NUKCh+UOpmybfU0+NoGJeTfVFNxK3gvjECL3+tYiJsofocoT0TJzTP3bepDIOf9PBN8Px9pPw+zwA11znAnAfIzQVuUsVcGrHQv1nBD/Smp5eumEm00kiLYnzi8W1PdJBUFJPq/F9V+86AH2R2uhsivr/PO4lu29Qw43XStJ6jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987223; c=relaxed/simple;
	bh=daL/QuJxMAOO/2xvxQhhXIWHp5c1xqQ8TfsgF3BqRso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUP6caIvA5D0JINIEU7J7iLdb+ppPRye9iZW8CD3NJWoaxrIFy68BIlvPQjAnDwaRElnG8SMgdozGG0MhzVwDMlK1/A0XtmL3AOurXxidwfYkGFmYuH1LLucne8eXhQTre0e3QgCPW9tqVJZQicmt8cBkxbPwKhuJEqvEzvdjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG6Tei4o; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fed72d23a7so3981835ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721987222; x=1722592022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hYeok8a21a815KmMqTiVxvmLWth6eyV+eijWhQCcpY=;
        b=UG6Tei4oY307BN8Faq+YnljmtN0hgEG9af5IQr6R1j9F3/g9BlXVb1icz1OQa10v6k
         24hUX1n+mdpLIzhZwy7us8MTTLoN5+axnKYmssSy7Iwfz2KqgOo/ugwOUzeE5pgufDTR
         1EQ9tdsCtENmxmgm+czq8Lj92uhmK+UYjU7d5dWXipfzC43otmsvEUHxBuymCyNMNuQU
         JWmIrDGEXMyovQ2rkWPAWj/RVquM2y6P13CLQyQFRn5odg12PeXHB1hgQYtNjgLxRMEy
         bqxkB1y1Tzi1zn9i2Xa6du+cM5EiwKOiAIQI368Ah06pRX6Z4sRYUugEHzx826143mE3
         huBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721987222; x=1722592022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hYeok8a21a815KmMqTiVxvmLWth6eyV+eijWhQCcpY=;
        b=lk19n2iQqBDzXsXS9H+x77o3HsgBV3csKBby30eWcn1vLYlX0BxEUEyMdwi5WYx4Vg
         TXXTo+kE7xXiXTFJD3MnXqJWwmyclsifptCkgCHoGM3jbDfT/yKC0JAmtv3/jonUpNcJ
         8NsE63+5JU0uUce6C5VGJbYzo5Z0dbmXV0KO1DrQWU4ntE/pg6aX7NKKI8LnRR76Qd88
         bt5tEbJtUD5CJSF6YPXqm4sHQ6ZAyJ8UWDpcOaFs7gbZ98lpQUYIgTYmU/V3V6CiagPg
         hGiPQGuFp3867ZrkYIeTon89oVWu4ehFncWfep9qSra90/gQTEFd1bD+mrXtoMHEdAHH
         8Y1w==
X-Forwarded-Encrypted: i=1; AJvYcCVeUzjMjOdgAWO6AuFPyPxtGudnbgUENz3lIfahMik1HcQWZBCCY7wLRD4AKybDkID2H5xT03tt4O2jRd06Gy71hQKaBJyWFnE66gE1
X-Gm-Message-State: AOJu0YxEKX76ToJY9Nqa5VnpgH3kmsbSSpZDHXotCFDaELfjm/BYt20B
	UmpQkIDKtW7y7E9L0fJy6QndIbDX5aSNDWXD2patEwlu4WJCGKOw
X-Google-Smtp-Source: AGHT+IF2rYGD79oIra6KDSbEdo1SbLFnul/wydficDNOgKTqChEyBYfaZEkLcFnkvEiK8cpU4uVCwA==
X-Received: by 2002:a17:903:1c9:b0:1fb:3d7:1d01 with SMTP id d9443c01a7336-1fed934e6a6mr51565535ad.59.1721987221583;
        Fri, 26 Jul 2024 02:47:01 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d15e98sm28127455ad.99.2024.07.26.02.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 02:47:01 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: ying.huang@intel.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	yosryahmed@google.com
Subject: [PATCH v5 0/4] mm: support mTHP swap-in for zRAM-like swapfile
Date: Fri, 26 Jul 2024 21:46:14 +1200
Message-Id: <20240726094618.401593-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

In an embedded system like Android, more than half of anonymous memory is
actually stored in swap devices such as zRAM. For instance, when an app
is switched to the background, most of its memory might be swapped out.

Currently, we have mTHP features, but unfortunately, without support
for large folio swap-ins, once those large folios are swapped out,
we lose them immediately because mTHP is a one-way ticket.

This is unacceptable and reduces mTHP to merely a toy on systems
with significant swap utilization.

This patch introduces mTHP swap-in support. For now, we limit mTHP
swap-ins to contiguous swaps that were likely swapped out from mTHP as
a whole.

Additionally, the current implementation only covers the SWAP_SYNCHRONOUS
case. This is the simplest and most common use case, benefiting millions
of Android phones and similar devices with minimal implementation
cost. In this straightforward scenario, large folios are always exclusive,
eliminating the need to handle complex rmap and swapcache issues.

It offers several benefits:
1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP after
   swap-out and swap-in.
2. Eliminates fragmentation in swap slots and supports successful THP_SWPOUT
   without fragmentation. Based on the observed data [1] on Chris's and Ryan's
   THP swap allocation optimization, aligned swap-in plays a crucial role
   in the success of THP_SWPOUT.
3. Enables zRAM/zsmalloc to compress and decompress mTHP, reducing CPU usage
   and enhancing compression ratios significantly. We have another patchset
   to enable mTHP compression and decompression in zsmalloc/zRAM[2].

Using the readahead mechanism to decide whether to swap in mTHP doesn't seem
to be an optimal approach. There's a critical distinction between pagecache
and anonymous pages: pagecache can be evicted and later retrieved from disk,
potentially becoming a mTHP upon retrieval, whereas anonymous pages must
always reside in memory or swapfile. If we swap in small folios and identify
adjacent memory suitable for swapping in as mTHP, those pages that have been
converted to small folios may never transition to mTHP. The process of
converting mTHP into small folios remains irreversible. This introduces
the risk of losing all mTHP through several swap-out and swap-in cycles,
let alone losing the benefits of defragmentation, improved compression
ratios, and reduced CPU usage based on mTHP compression/decompression.

Conversely, in deploying mTHP on millions of real-world products with this
feature in OPPO's out-of-tree code[3], we haven't observed any significant
increase in memory footprint for 64KiB mTHP based on CONT-PTE on ARM64.

[1] https://lore.kernel.org/linux-mm/20240622071231.576056-1-21cnbao@gmail.com/
[2] https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmail.com/
[3] OnePlusOSS / android_kernel_oneplus_sm8550
https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplus/sm8550_u_14.0.0_oneplus11

-v5:
 * Add swap-in control policy according to Ying's proposal. Right now only
   "always" and "never" are supported, later we can extend to "auto";
 * Fix the comment regarding zswap_never_enabled() according to Yosry;
 * Filter out unaligned swp entries earlier;
 * add mem_cgroup_swapin_uncharge_swap_nr() helper

-v4:
 https://lore.kernel.org/linux-mm/20240629111010.230484-1-21cnbao@gmail.com/

 Many parts of v3 have been merged into the mm tree with the help on reviewing
 from Ryan, David, Ying and Chris etc. Thank you very much!
 This is the final part to allocate large folios and map them.

 * Use Yosry's zswap_never_enabled(), notice there is a bug. I put the bug fix
   in this v4 RFC though it should be fixed in Yosry's patch
 * lots of code improvement (drop large stack, hold ptl etc) according
   to Yosry's and Ryan's feedback
 * rebased on top of the latest mm-unstable and utilized some new helpers
   introduced recently.

-v3:
 https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.com/
 * avoid over-writing err in __swap_duplicate_nr, pointed out by Yosry,
   thanks!
 * fix the issue folio is charged twice for do_swap_page, separating
   alloc_anon_folio and alloc_swap_folio as they have many differences
   now on
   * memcg charing
   * clearing allocated folio or not

-v2:
 https://lore.kernel.org/linux-mm/20240229003753.134193-1-21cnbao@gmail.com/
 * lots of code cleanup according to Chris's comments, thanks!
 * collect Chris's ack tags, thanks!
 * address David's comment on moving to use folio_add_new_anon_rmap
   for !folio_test_anon in do_swap_page, thanks!
 * remove the MADV_PAGEOUT patch from this series as Ryan will
   intergrate it into swap-out series
 * Apply Kairui's work of "mm/swap: fix race when skipping swapcache"
   on large folios swap-in as well
 * fixed corrupted data(zero-filled data) in two races: zswap and
   a part of entries are in swapcache while some others are not
   in by checking SWAP_HAS_CACHE while swapping in a large folio

-v1:
 https://lore.kernel.org/all/20240118111036.72641-1-21cnbao@gmail.com/#t

Barry Song (3):
  mm: swap: introduce swapcache_prepare_nr and swapcache_clear_nr for
    large folios swap-in
  mm: Introduce mem_cgroup_swapin_uncharge_swap_nr() helper for large
    folios swap-in
  mm: Introduce per-thpsize swapin control policy

Chuanhua Han (1):
  mm: support large folios swapin as a whole for zRAM-like swapfile

 Documentation/admin-guide/mm/transhuge.rst |   6 +
 include/linux/huge_mm.h                    |   1 +
 include/linux/memcontrol.h                 |  12 ++
 include/linux/swap.h                       |   9 +-
 mm/huge_memory.c                           |  44 +++++
 mm/memory.c                                | 212 ++++++++++++++++++---
 mm/swap.h                                  |  10 +-
 mm/swapfile.c                              | 102 ++++++----
 8 files changed, 329 insertions(+), 67 deletions(-)

-- 
2.34.1


