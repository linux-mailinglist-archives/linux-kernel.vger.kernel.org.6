Return-Path: <linux-kernel+bounces-320447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF55970A93
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B599C1F21699
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38B1531E6;
	Sun,  8 Sep 2024 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGpMt2dg"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8D136663
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725837695; cv=none; b=EZzCaskh/EvoEWqWfy5jL4nVhCslrz1hq6lZlUE/7wNATE46CNxtdjjq4M6sNoWBjpZSJZfeh8BkvY93xOdIm1VTVMAOodYSPJMKgSWWGyiXDcAymdRYMT9OscCb3Mky1/0OZDGNZbZyIHEf0n4HBY16rbyUoyM+1wBB0DFSNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725837695; c=relaxed/simple;
	bh=Bn4zGkzyhelvgOynGb7w7VBCWSp/Z3k1qg7oi08db8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CvaGEUeP//ZNFxGjwzRuq9udN+CL4vivxl6l1PHiPHAfdo7oyW3gbpof1FTPymybsopddqKECGuRdfgGgGzO5v3E0m/pwmkgQg0CWA37UCrvg/qAZBJAZ2EsOtUXlc/UWJ0hxl9x6WaVQW1YHO2bq5Qx5sZRyxAhL++b9CV/hX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGpMt2dg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-717911ef035so2869405b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 16:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725837693; x=1726442493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D4XfG6mbU1pHrhOieTfAg/3V0YCeOX3JLypNHo4Aiik=;
        b=BGpMt2dgfUsvAmqpUTlhqHzxJh7s2rTQ4y9joT1vkHDIxdf75U9G78xWvatpkE2OKO
         WBZZgSbRzRnGB59hmR1VwWpsdewhZcHp15beFeRjWTX/eXWsPhEPMgXkb3MvOpuTp8ig
         rnBBoNPpjnRc0OnQdTVsohQqEIo9BvB77nANv3evfhfGBtt9tDwiNliGv7rIkDiRW+q6
         qWNOXVklYH0iBGwcZuyQtURW3apAaKUPHLXWn7URGYZEy6KvRfOgHGrRA8r9FJK1262m
         x3Ss5xC0eG6PP3GFBw+dp7SJHLkvf+4ghiE5/UP9+wWzYe1xvdbnEn6soZNu0zlz+CDt
         dGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725837693; x=1726442493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4XfG6mbU1pHrhOieTfAg/3V0YCeOX3JLypNHo4Aiik=;
        b=W5UGW0bcRHf6qg5/V/p9/B2+IEl84XT77Z8pZQ+QRam2oOzn/C4ER4NHRt6KZHYzUC
         wIILw3Gqk722valYFKSmGJi9gFXl8Js4ZtjwedufPHZPv2SdqVUs6SfMpjg2phnwHKut
         hmiX+mYDivGoNfqHbIUteXAvsushaxQAGaYYPL5YUS8aWRY97f9G0MmfuG3yoOF5ajVi
         j6K2U/t2tyt8JJrpzrstaZjzjlu1nYtH6imcTr98cmbmNVCyy/A6BiVzRSo+0e1L1rFJ
         yPVODIIxjxduOEEXh/UZEkWt4Dkpu+fU+ixVvnaJqYQrT6zghgMNjObxfNKUVGHmN85B
         V06w==
X-Forwarded-Encrypted: i=1; AJvYcCUW/frgwRW7NTFHlGI35yJqGPFhU6cg4oo3fxs1s7vq8Y5eo3cxT1MYzT9jtxDYw1QnbbWhy7k09NBuAn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlEBZks5p7NW9vBXGx7x3RaONlUZzaRnN07U5ZePlnX2A6f86
	46lW4Nob/tvw/q3JLTKIfnwWIr/sM4MswkcHzW9cH5ZcfURpuQkQ
X-Google-Smtp-Source: AGHT+IF/PMhDHe/5mSj4TkI1XBbuxWuCkRI0tlZ/vvDLAbmDq+Ontuf0QtBlpGcaKpyUcqQGdsZbjw==
X-Received: by 2002:a05:6a00:94a2:b0:714:1e36:3bcb with SMTP id d2e1a72fcca58-718d5e0f288mr7969912b3a.9.1725837693317;
        Sun, 08 Sep 2024 16:21:33 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:ecbd:b95f:f7b2:8158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c703asm2447643b3a.82.2024.09.08.16.21.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Sep 2024 16:21:32 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
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
Subject: [PATCH v9 0/3] mm: enable large folios swap-in support
Date: Mon,  9 Sep 2024 11:21:16 +1200
Message-Id: <20240908232119.2157-1-21cnbao@gmail.com>
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

-v9:
 * cleanup (rename, drop local variable) for patch 1 according to Yosry,
   thanks!
 * collect Yosry's reviewed-by tags, thanks!

-v8:
 https://lore.kernel.org/linux-mm/20240906001047.1245-1-21cnbao@gmail.com/
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


