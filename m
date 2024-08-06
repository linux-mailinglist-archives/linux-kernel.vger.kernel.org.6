Return-Path: <linux-kernel+bounces-275577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949AC948766
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F202A285975
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9EF9DF;
	Tue,  6 Aug 2024 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2uYnoZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE45C2E9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910675; cv=none; b=u39eY3LiB8rBz7GRS+gQLnET9SnGJXwflaWDrbrLJ3lwwKu9shcPJBb5KzovukyzC+piSix9pSl/8Tcs0e/tAbfbCRvp/6uECudITG9QMq73Enqm55viQewPfdzqoAN2NcL0ONjLaG95ydYfqsYlDju0kLNHgB7YfHu/Y2jXK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910675; c=relaxed/simple;
	bh=yXVABbkmu8OTawq0fw52gNq7FEB6YnC9rfwX9dBxipE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQSEjDvrlcjRRVnV0UAYn5M3Sy7P8Xg1QZ86oL/ctkcGe88l6MeJj6NvzeQ3oMbO/vlzCGV3u09i0chcmSOyekOhfNTDyJgYZtR4GzzHIq3TJYpwdl/MXnup1NFtS+hP8xWHaI3oryCr4QZ27ihhprSit11MCHpVttmUFq0tbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2uYnoZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5959AC32782;
	Tue,  6 Aug 2024 02:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910674;
	bh=yXVABbkmu8OTawq0fw52gNq7FEB6YnC9rfwX9dBxipE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2uYnoZxR8xMBazV/hBgxgY81G3IXq7Xti+2mJZaEDWlhaCvFzCpg8/8LndrC02+d
	 0zXoDHYOX4iKnA9+Nlqx5RdEbkv+eFVbpvAiIh1SrP47yve+P3MaHrvhySrz9+Iioq
	 dnEdB9mDMxO6jlTPGe5NslxhBy6VyDMui3GJg1RtYVbeOcyDNDrQ92AmDKKSGlYrD3
	 3XS0v5Df+AdCXcaWMhzH0BUCvBpyYCHLEYr87jL4LIWxzb2TcCqPVj3sYz59Cd2Aaa
	 FJ38L9N604JzZGqUxC/heCvKbkZ+3oXCoIVhQSaOHEJyQJryAjLFb4dD890SWQXqQE
	 NJholuQNSG2Lg==
From: alexs@kernel.org
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	willy@infradead.org,
	senozhatsky@chromium.org,
	david@redhat.com,
	42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
Date: Tue,  6 Aug 2024 10:22:47 +0800
Message-ID: <20240806022311.3924442-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806022143.3924396-1-alexs@kernel.org>
References: <20240806022143.3924396-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

According to Metthew's plan, the page descriptor will be replace by a 8
bytes mem_desc on destination purpose.
https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/

Here is a implement on zsmalloc to replace page descriptor by 'zpdesc',
which is still overlay on struct page now. but it's a step move forward
above destination.

To name the struct zpdesc instead of zsdesc, since there are still 3
zpools under zswap: zbud, z3fold, zsmalloc for now(z3fold maybe removed
soon), and we could easyly extend it to other zswap.zpool in needs.

For all zswap.zpools, they are all using single page since often used
under memory pressure. So the conversion via folio series helper is
better than page's for compound_head check saving.

For now, all zpools are using some page struct members, like page.flags
for PG_private/PG_locked. and list_head lru, page.mapping for page migration.

This patachset does not increase the descriptor size nor introduce any
functional changes, and could save about 122Kbytes zsmalloc.o size.

Thanks a lot for comments and suggestion from Yosry, Yoo, Sergey, Willy
and Vishal!

Thanks
Alex

---
v4->v5:
- rebase on akpm/mm-unstable on Aug 4.
- add a helper and update code comments accroding to Sergey's comments
- fold patch 20/21, remove 3 helpers functions according to Vishal's
  comments 

v3->v4:
- rebase on akpm/mm-unstable Jul 21
- fixed a build warning reported by LKP
- Add a comment update for struct page to zpdesc change

v2->v3:
- Fix LKP reported build issue
- Update the Usage of struct zpdesc fields.
- Rebase onto latest mm-unstable commit 2073cda629a4

v1->v2: 
- Take Yosry and Yoo's suggestion to add more members in zpdesc,
- Rebase on latest mm-unstable commit 31334cf98dbd
---

Alex Shi (10):
  mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
  mm/zsmalloc: use zpdesc in trylock_zspage()/lock_zspage()
  mm/zsmalloc: convert create_page_chain() and its users to use zpdesc
  mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
  mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
  mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
  mm/zsmalloc: introduce __zpdesc_clear_movable
  mm/zsmalloc: introduce __zpdesc_clear/set_zsmalloc()
  mm/zsmalloc: introduce zpdesc_clear_first() helper
  mm/zsmalloc: update comments for page->zpdesc changes

Hyeonggon Yoo (11):
  mm/zsmalloc: convert __zs_map_object/__zs_unmap_object to use zpdesc
  mm/zsmalloc: add and use pfn/zpdesc seeking funcs
  mm/zsmalloc: convert obj_malloc() to use zpdesc
  mm/zsmalloc: convert obj_allocated() and related helpers to use zpdesc
  mm/zsmalloc: convert init_zspage() to use zpdesc
  mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
  mm/zsmalloc: add zpdesc_is_isolated()/zpdesc_zone() helper for
    zs_page_migrate()
  mm/zsmalloc: convert __free_zspage() to use zdsesc
  mm/zsmalloc: convert location_to_obj() to take zpdesc
  mm/zsmalloc: convert migrate_zspage() to use zpdesc
  mm/zsmalloc: convert get_zspage() to take zpdesc

 mm/zpdesc.h   | 146 +++++++++++++++
 mm/zsmalloc.c | 482 +++++++++++++++++++++++++++-----------------------
 2 files changed, 403 insertions(+), 225 deletions(-)
 create mode 100644 mm/zpdesc.h

-- 
2.43.0


