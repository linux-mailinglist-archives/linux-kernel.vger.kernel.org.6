Return-Path: <linux-kernel+bounces-310700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E7396804A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDAFB225EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC116BE20;
	Mon,  2 Sep 2024 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmzGMWRd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363862B9BB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261393; cv=none; b=uoq+Ge5aA//12XoixOLDHfDjl5mHbrNJplcLz/j/O9z8GYQ4Irp9YeRzXrjaszz0MZ+QyddYr4Z2Cx8/7/YuiWZ5gSQqpd1CWEIdu7ydZ/qPTv8Teq1561khv17fg3paLW8A91mDnXdkQCqH0hq82lnAs3lX7Tt19hwhCf5yJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261393; c=relaxed/simple;
	bh=C+PQyPVCIVbmT/BZwf3yjRAH5H4AzFwbepsfC3VtwYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a93YY467YptqeRn307oc7S5XHcsY1JwZWzshJxI/Aygv1dO6yTdiWVJSTqo7D2Vghr8RHrlv0+GS9QZPvOtg4h5O/mSDdQ19cqvv4UQq0tPeSV3aMT6LfGsIn9QJKsAVlMPvl4DCPI+XG0tQhnRxyzsuKn+wTbyMQRdHunvYqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmzGMWRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FC7C4CEC2;
	Mon,  2 Sep 2024 07:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261392;
	bh=C+PQyPVCIVbmT/BZwf3yjRAH5H4AzFwbepsfC3VtwYo=;
	h=From:To:Cc:Subject:Date:From;
	b=RmzGMWRdeLlM97okxY0Sw/YVpluQR5yVs86w+rYSGxhsrJ0twKF8C6XMJhCcOJrhN
	 zeVnZMGaBxB0b+iOU9YkLfSjwrHuYFJuB7Anp8tPnaJBYLQkX6bveW+uogzC3eFbSM
	 drf2NyTvM+LOatVbNyY4gk4VvlYICfui+UJPNUnD7pyQPkzzXsQ7dG6b3UxRXXhdMq
	 YnnO5RpdJ2HHpz20DV51q+gnlCRr9saSCrsso2KtMLEaokS9O4+VuSysrY6hNyjmEN
	 vx653RNcY+1986hKlndc2S1jorh1E1kyF7GspGOsYRLQKcGwKcs3FbG64vas3yd6Nn
	 fLOvh0LxtqWfg==
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
Subject: [PATCH v7 00/21] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool 
Date: Mon,  2 Sep 2024 15:21:11 +0800
Message-ID: <20240902072136.578720-1-alexs@kernel.org>
X-Mailer: git-send-email 2.46.0
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

This patchset abstracts the memory descriptor used in zsmalloc by zswap/zram.
The descriptor still overlays the struct page; nothing has changed
in that regard. What this patchset accomplishes is the use of folios in
to save some code size, and the introduction of a new concept, zpdesc. 
This patchset is just an initial step; it does not bias the potential 
changes to kmem_alloc or larger zspage modifications.

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
v6->v7:
- rebase on akpm/mm-unstable on Aug 30

v5->v6:
- rebase on akpm/mm-unstable on Aug 4
- recover 2 helpers and update code comments according to Vishal's
  comments on patch 1 and 6.

v4->v5:
- rebase on akpm/mm-unstable on Aug 8 + Stephen Rothwell's build fix.
- add a helper and update code comments according to Sergey's comments
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

 mm/zpdesc.h   | 147 +++++++++++++++
 mm/zsmalloc.c | 490 +++++++++++++++++++++++++++-----------------------
 2 files changed, 414 insertions(+), 223 deletions(-)
 create mode 100644 mm/zpdesc.h

-- 
2.46.0


