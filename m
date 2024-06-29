Return-Path: <linux-kernel+bounces-234904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CDD91CC41
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9FA1C21288
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3144C93;
	Sat, 29 Jun 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF9pcmmI"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4E39FD9
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719659435; cv=none; b=XvS+ES3IDFx74wiGK67swOPcDnI1F5nLRCakAqkZaSAVX0Ixu4KWDXzb6QuueFv39tWyYGH4k1RzPN7rLSSIhLBtToQSbLAVZihsUXZiGVY+xhfYrhfEn1qiWsp6p+80tc6PsfL1CimlVD41KtJuvVE9vDJc3DgSaQBlFz0/lEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719659435; c=relaxed/simple;
	bh=qowpaKq/OhdJi8ITdojZT8NtJ5JQXS8Eub32ge7BcM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZygcE6IyzxG/ZuNzErpPhWtxzc878bMHiKvwC8mApiNLAS1U5jmW055u7vXOUeojJuIF6lvzMKD5ZL/hKHpdf0Rh/EOYWK7usdfOJRccB49Z6Mvg0VUZKyFZAYPxfoaHiXWq/OQTje81rV7mrGGvT18l1lyAqXyhp8eAm2aaVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF9pcmmI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f70c457823so7403075ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719659433; x=1720264233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBAcVgcZQQmUaocHAdNszX5FkxHdKW1jcpkzZ5MX9kQ=;
        b=IF9pcmmIoyJVjBG7ANVCW0Z8W/JpMoJCHrIC+xLSzM1/akI442FBKnBgtAfJ/ewjJi
         ZNPCkR29gUHRzfsvLq9Ai4HHgC+F01pnXy5s7Xf+Nh2EadjA2XSTsnuNaDAHGwIxUIiM
         H4HCLXezdGmPd7CMvfCjyRmcfF/5wR5Mv3vgV4HE7aMM/G5ofhpRg6qVR0AZSPMyVnZN
         tFbl6TmRITkvV21ctah2PuqSoskvcVheFvmDUdhywnTvkq7Wx1Aysw2riVrnKQeMB0vz
         u9ykl7YNFQsXZmq6piYPNh0b1bzsq/YzmInM8m4xhFK333PqF05dLCC5ykyrmBnZH/00
         Ap2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719659433; x=1720264233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBAcVgcZQQmUaocHAdNszX5FkxHdKW1jcpkzZ5MX9kQ=;
        b=GKQzoDEVq5cjkMzAStXlHzDjMNHzqQLfeclBj+KEN9I1mea4M0aOevLc0ciUp2Y87a
         UOSpQBXzpfXJRasy5CNsuYmJ5BPMCDwrbnBPRI7BfP7YEMVqNIYmOjFoC336Mx/W0iC6
         EIWmpco+FMEw41uX84RClCLRBYPcCSZGTc5NB8uzathktj9EuSoiR9BeOzf2697CasnW
         f67N7VHXa6Xn84sox7KFY3UYXa0vxV3DsNL8wcnrhit0OZARoazjaabiTinO7h5DHwlc
         fruYtapXqKMhYLkNx310XrOtMOmuUZ4+OXAPJWa5ALyVb5Tsb1dAtB2QkQC2bdkT1FtB
         /DHA==
X-Forwarded-Encrypted: i=1; AJvYcCUlwWOykVSyaTCvHEwozV6ByKGr9coDWxYpIn/VwOgiBlVNbnnuvzamzWJACWGTFsjQ2bywmhgD3ACyhfOJfbC0uX+geEYe8twppESC
X-Gm-Message-State: AOJu0Yzk4BPx/7k4EzllksP1D6aajnF/TPOOrNvAqhucwFixPpfoXq8P
	6OPzC5Vdc7HJirDgpySkQh7i4I2oDHwWUiXdr4L7uHnpk6rwtyeP
X-Google-Smtp-Source: AGHT+IFcma5rRXL35Rr9ot3u/wZrnRCfziW0eE4+61wGxHzyqaFYi4s2Hx7oY/SVvwtFUFY0PE5FDQ==
X-Received: by 2002:a17:902:e546:b0:1f6:fcd9:5b86 with SMTP id d9443c01a7336-1fadbc73dcemr3582105ad.12.1719659432559;
        Sat, 29 Jun 2024 04:10:32 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596920sm30068975ad.268.2024.06.29.04.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 04:10:32 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	surenb@google.com,
	kaleshsingh@google.com,
	hughd@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	baolin.wang@linux.alibaba.com,
	shakeel.butt@linux.dev,
	senozhatsky@chromium.org,
	minchan@kernel.org
Subject: [PATCH RFC v4 0/2] mm: support mTHP swap-in for zRAM-like swapfile
Date: Sat, 29 Jun 2024 23:10:08 +1200
Message-Id: <20240629111010.230484-1-21cnbao@gmail.com>
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

-v4:
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

Barry Song (1):
  mm: swap: introduce swapcache_prepare_nr and swapcache_clear_nr for
    large folios swap-in

Chuanhua Han (1):
  mm: support large folios swapin as a whole for zRAM-like swapfile

 include/linux/swap.h  |   4 +-
 include/linux/zswap.h |   2 +-
 mm/memory.c           | 210 +++++++++++++++++++++++++++++++++++-------
 mm/swap.h             |   4 +-
 mm/swap_state.c       |   2 +-
 mm/swapfile.c         | 114 +++++++++++++----------
 6 files changed, 251 insertions(+), 85 deletions(-)

-- 
2.34.1


