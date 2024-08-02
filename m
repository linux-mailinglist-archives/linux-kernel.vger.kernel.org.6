Return-Path: <linux-kernel+bounces-272548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299A945DC5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773061C22734
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E541DF67F;
	Fri,  2 Aug 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGf2Furk"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03214A0A0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722601258; cv=none; b=p6wkJUl1RZfqNgr3AJ650uop7ExsUqARlCy7arevj9OcCUvGO34TFd3QyHnw6M60HeJxbB1wyJEtcgsjrGHo4qcWvf4x4dEJLUXXPLXh2uJ/DyXbwoEGra9X77oJh1ea9/p2l138kHek/rw6psF7aJNeQMPIsZlR831/wJiLB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722601258; c=relaxed/simple;
	bh=8CSlitnt3W9rzH80PztVfsolv+d8AZy935llza2aYMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvviO4qU7o/e77XngQb/XCy2NcV4TppVGnJGyg8vSHTDBd26vP0l8xsG5vzarqpqKRpYwu2EGOSm/J2Wa2SLUXJOpmhJDlBYIGnyb0Q7PBnXBDmSZgzrh4AF3y72uLPp9oGZHGnXxy8IF1S6b6jrz0ucT6N+8Sd48O1E9gpRVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGf2Furk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc692abba4so61443695ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722601256; x=1723206056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q/Vgd/HJjjNMutQgVmDvwDRdznDYvNQkKPVmlkjWvI=;
        b=JGf2FurkjBT4jZ/cIglVhf4QzQnDC4uFXxUgng5JekQGmg+jpmFMpQgmPWtcGk6ELR
         CETkYsAwxtPf4DNrnFTJHzv68HVyuVhZ6zT1EBgyzS9W5Pg7AhId7Kg87GA3M7DRj+iN
         gQuX83GrE0zKTvEr1sqK+yNKNCkhW5XbAEhLAaRndfAiK6iiQLrJKru3v3LckaLaE1BI
         KJbVo61o9wj5oBMz1OyFKJVv7gIbs+x0SCZY91R1XyHSAU1Nl+q/REjr7Y6o+IiuodJl
         hNP6+SwzgB7/6BDb5zDwk2TSCAavhKRfAIv5l9cFgapX8ZdDvFeaQstTyrgZeSXHQnBW
         XSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722601256; x=1723206056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q/Vgd/HJjjNMutQgVmDvwDRdznDYvNQkKPVmlkjWvI=;
        b=gDO4FvmIfk2kBtYcI+F+3AkSogbt2tvaO6b3tT4yyL1uMV9QXx//LTkGNNkpkURrYB
         bRwG1q+f4HZ3sinjCyKhgOR0BKv+4ld6Q57TAv8yq3150eib5x1CTvN9U/GfNgt90i3D
         Rw8qTI60ysiVIg4trKsdB4bBtoefx1dsARG/dzokzCh5r98lOZ++5dTH0V6IHAVc2XmA
         hX030P+5FFuvtRj+OmbNC7GXqjWexui01iqB9hk5F26ZYVAQU1KQq4a6FUSGXoZgNPAJ
         yfkRAm41Zyle62jOUDqENdyEdVuhlHEWgQMRBjhS9TsGCs7T+MaUMd9IPf7uNX9H6Xjo
         ZLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGHM5QBXV5O5EzZgj15eRo/+i8WxRDhrQNNJxyXnKkpPEsRx7LBE+roZwCud4Kwq4E1LNJg7Xr3IdkbI7tEfhxYUj97MadJUu2O6/U
X-Gm-Message-State: AOJu0YwBW2efxhcpG+DmBMHsgWqIfpawzeOWtbh8wTKVIOFVzJHCh5rV
	YiH3B026G9TQirVsBnkeT9RnIkOoa44jlXHW5yyhbIGIC4FpR53w
X-Google-Smtp-Source: AGHT+IHvCwKcMa1WaAaEyOSrgbVMbhDS/GTyK57FYlX0r3AtXnqExmED+EmlnKkgiLfMX0DbO2tSVQ==
X-Received: by 2002:a17:903:1c2:b0:1fd:63d7:5d21 with SMTP id d9443c01a7336-1ff574218c3mr37981545ad.47.1722601256210;
        Fri, 02 Aug 2024 05:20:56 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff590600e4sm15841875ad.144.2024.08.02.05.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:20:55 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
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
	ying.huang@intel.com,
	yosryahmed@google.com,
	hch@infradead.org
Subject: [PATCH v6 0/2] mm: Ignite large folios swap-in support
Date: Sat,  3 Aug 2024 00:20:29 +1200
Message-Id: <20240802122031.117548-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726094618.401593-1-21cnbao@gmail.com>
References: <20240726094618.401593-1-21cnbao@gmail.com>
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

-v6:
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

Barry Song (1):
  mm: add nr argument in mem_cgroup_swapin_uncharge_swap() helper to
    support large folios

Chuanhua Han (1):
  mm: support large folios swap-in for zRAM-like devices

 include/linux/memcontrol.h |   5 +-
 mm/memcontrol.c            |   7 +-
 mm/memory.c                | 211 +++++++++++++++++++++++++++++++++----
 mm/swap_state.c            |   2 +-
 4 files changed, 196 insertions(+), 29 deletions(-)

-- 
2.34.1


