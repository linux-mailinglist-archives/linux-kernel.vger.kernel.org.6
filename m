Return-Path: <linux-kernel+bounces-284340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7840950012
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AF12856F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF413C691;
	Tue, 13 Aug 2024 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWylMq9j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4113B294
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538466; cv=none; b=clCevnGGYcu3gUKeglGQXHEVOZRNsAHcaIjqZ9W9j0VYMJVX/91+nbKtNuIt+lDLKEFg1mmWZFLU0GbyyA+YxshW9CW0SHkxdDPFjFWT36E5V9sGV4ClwYK+U89R9w+/lah9mh4w3Qr6LUNEFzHc+bR+Dmon58goJacycapR3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538466; c=relaxed/simple;
	bh=Z/FMnC5lYBSOOCLhgveNnkuyOlHnMIIIL5Dx/+PVQLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1+DhFDX87/FeawhoBDl5MrTE9jDyWYtr/Z7WwfxLUw6xqhqd7jXBi8u745UyUVW2raEiBqv3oQXKBlKOnPRIEB6eWYdZK0LxoPawehL07QjuMqLTNUDrXf6Q/qE5UJ7MmTrk6IY2/9BgdqEhdY+fWftGioAuevu+3R836d/z/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWylMq9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E78C4AF0B;
	Tue, 13 Aug 2024 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538466;
	bh=Z/FMnC5lYBSOOCLhgveNnkuyOlHnMIIIL5Dx/+PVQLg=;
	h=From:To:Cc:Subject:Date:From;
	b=bWylMq9js9m3gA6VjYMC3dbDTYydIcdM74Gyq/SVS6zVmZHFqoKGA5fzN02HMhWLd
	 1iHWuBb7KuA3ydtm+97Myx/MEzJGyWE6Sjdlgzvy3qTYHHH5ewdcrYK39G7DgaN+te
	 KB+hDssdx2Q1116Tsosg2VdNA/LWKl/puxWw3sswDPT5yUsoExpNnxVVfy4k3pAErZ
	 /brk6jpXumPs/K7QJOpHliK7qXsH90PFH3zgZGnslcIgrwfUMLf/lCU4kELVjcvjjH
	 iV56FIxwnYoEuhEkpTmwR4Ve+FMnd5RmqNwNMUM5ZBi6VPBvUmyY/EdVirUoz8Nt9W
	 1bzrd47Agv1TQ==
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
Subject: [PATCH v6 00/21] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
Date: Tue, 13 Aug 2024 16:45:46 +0800
Message-ID: <20240813084611.4122571-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
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

After this patchset, a possible way to memdesc is suggested here:
https://marc.info/?l=linux-mm&m=172308822809560&w=2

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
 mm/zsmalloc.c | 496 +++++++++++++++++++++++++++-----------------------
 2 files changed, 418 insertions(+), 225 deletions(-)
 create mode 100644 mm/zpdesc.h

-- 
2.43.0


