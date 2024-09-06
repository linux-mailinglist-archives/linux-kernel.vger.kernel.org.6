Return-Path: <linux-kernel+bounces-317978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38596E6A3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D142869AA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9CAA41;
	Fri,  6 Sep 2024 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0d3nT+y"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617D634
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581467; cv=none; b=U4VFfMBcNT5PpYh8+L/783ZyrV6ElzHNIRdcX83RO0q0HEm1PSx6ZGqb+2jwS7/89ohq47SUK0CiYXcDa5O0SC20Afyr7XbVmK7Xp+2NolXnG1MF2LqVZJAUGjAg8lcvwbWSOuTE1Q0iVSGvHCIce0q7JZPCW/b4g3b1S91sW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581467; c=relaxed/simple;
	bh=Y6JwEvWOkMZQjqJdzDqEqHcnDLlutJW9tXS+jbVJEFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=a0ihttKcTrDPQYNb/5wtx+NyQUGnJ3b26P3XhkBoMYngx82N+gAf0vsOfTsvGDbN3VbqQHDizqCtNOkUgbb4dG9plO8AmtUFMTlPbyA1m6TS6+I2912uPZR6MGenlHqu7piK9D0OS+Wj77lNOEG9EQ+Xmkk4kQJq0A361UTY3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0d3nT+y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc47abc040so14052655ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725581465; x=1726186265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbjdBeyp4fMNwEu+N0jYliJHl44TXgvrnk+y6OuqndM=;
        b=W0d3nT+yFgxIujLlCTtU5nH3zaLKuXFfQ01o4SC8XZZYa8lgPATpMU+bKOUaOAjyiz
         /fjq25D9qrK0k+aoCT/I9/u6DmbaJwTAwHhP8QxDfFQCo+Qgv+lZSjFfoNmm9QFOZWT1
         IDwroLxLc5zdfsiXu8+51nRgFNuetkmMIRd3rbowSzvFXGSqO7bzRtiIMidwkn7lcs59
         KuMEJZlCuJ2e3FV2T9R43sS7xJenDRyYGl83Z+4XAnK2uwi4u9dtMt9QYpdUDfJJcnL6
         yY/8Hy68VXXDpN9W3W2zVLt/JktfncdPE4IRMl5XMtexFnrFpmyNj7beMMKaoePxwtvR
         3Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725581465; x=1726186265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbjdBeyp4fMNwEu+N0jYliJHl44TXgvrnk+y6OuqndM=;
        b=aLkvW8I3q5eTglAgOeoJBgremPbBj8LHUYAK6peL6wAO99Rd5xYD0g4XVAZ9M0/Qx9
         0WSxjslTXnS7Rq8MdwGoU/ZOlNGumjwjvRZQl95RSW3MR+FZJwSz89vGPtIF+AWUPOwI
         OBorQQXaE2mFD+q1MnMklsl7JGFrYWk4R64redIo0lj0YBMXu+G1HODWeQOS7ihuZXrM
         O/9LIZq6rBo0ueFu5ahFKH8tRj8f1wq9ZlSPSG3CsUbAR+QxPbfzfIcdW1ufRoRy3zh7
         VYuCMUX0vk+UguB6TqNNZKP+XYHlpVWbVbYmYvBLfFE6U/mi6nygCH01W8e1qv1k7sGR
         gmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFMqD6GZs1nAzEArjrKDv3gaC4hXmLALsiWyTKVBxcQund0yaAOUvAgkpZILKjWKxfmOQybz+8aYVT4uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4E08j0Xcbehr1PzpRlcV/e/eosNHkb16Kt5SL+rIgoPNBSvkf
	0OhoH08XfXtt+/zQP6ZCR/NuZbqLYsHWCHaPqKlAgTEyHP3voGfXc2rgzGJn
X-Google-Smtp-Source: AGHT+IHqZ4JSw2isH8M/tECNN2i8qZcs9nh8a+v4LPdLPv4IsJZbsUfyVRIDk7PCCO36XKdnhBsRqw==
X-Received: by 2002:a17:902:d485:b0:205:6d75:8fdd with SMTP id d9443c01a7336-2056d75914bmr169145205ad.28.1725581465170;
        Thu, 05 Sep 2024 17:11:05 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:cd42:f8ae:5222:5ab7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3548dsm33447445ad.140.2024.09.05.17.10.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Sep 2024 17:11:04 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hanchuanhua@oppo.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hch@infradead.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com
Subject: [PATCH v8 0/3] mm: enable large folios swap-in support
Date: Fri,  6 Sep 2024 12:10:44 +1200
Message-Id: <20240906001047.1245-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Currently, we support mTHP swapout but not swapin. This means that once mTHP
is swapped out, it will come back as small folios when swapped in. This is
particularly detrimental for devices like Android, where more than half of
the memory is in swap.

The lack of mTHP swapin functionality makes mTHP a showstopper in scenarios
that heavily rely on swap. This patchset introduces mTHP swap-in support.
It starts with synchronous devices similar to zRAM, aiming to benefit as
many users as possible with minimal changes.

-v8:
 * fix the conflicts with zeromap(this is also a hotfix to zeromap with a
   Fixes tag), reported by Kairui, thanks!
   Usama, Yosry, thanks for all your comments during the discussion!
 * refine the changelog to add the case Kanchana reported, using Intel
   IAA, with mTHP swap-in zRAM read latency can improve 7X. thanks!
 * some other code cleanup

-v7:
 https://lore.kernel.org/linux-mm/20240821074541.516249-1-hanchuanhua@oppo.com/
 * collect Chris's ack tags, thanks!
 * adjust the comment and subject，pointed by Christoph. 
 * make alloc_swap_folio() always charge the folio to fix the problem of charge
   failure in memcg when the memory limit is reached(reported and pointed by
   Kairui), pointed by Kefeng, Matthew.

-v6:
 https://lore.kernel.org/linux-mm/20240802122031.117548-1-21cnbao@gmail.com/
 * remove the swapin control added in v5, per Willy, Christoph;
   The original reason for adding the swpin_enabled control was primarily
   to address concerns for slower devices. Currently, since we only support
   fast sync devices, swap-in size is less of a concern.
   We’ll gain a clearer understanding of the next steps while more devices
   begin to support mTHP swap-in.
 * add nr argument in mem_cgroup_swapin_uncharge_swap() instead of adding
   new API, Willy;
 * swapcache_prepare() and swapcache_clear() large folios support is also
   removed as it has been separated per Baolin's request, right now has
   been in mm-unstable.
 * provide more data in changelog.

-v5:
 https://lore.kernel.org/linux-mm/20240726094618.401593-1-21cnbao@gmail.com/

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

Barry Song (2):
  mm: Fix swap_read_folio_zeromap() for large folios with partial
    zeromap
  mm: add nr argument in mem_cgroup_swapin_uncharge_swap() helper to
    support large folios

Chuanhua Han (1):
  mm: support large folios swap-in for sync io devices

 include/linux/memcontrol.h |   5 +-
 mm/memcontrol.c            |   7 +-
 mm/memory.c                | 261 +++++++++++++++++++++++++++++++++----
 mm/page_io.c               |  32 +----
 mm/swap.h                  |  33 +++++
 mm/swap_state.c            |   2 +-
 6 files changed, 282 insertions(+), 58 deletions(-)

-- 
2.34.1


