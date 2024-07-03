Return-Path: <linux-kernel+bounces-238804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F709250BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790681C2298B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD581369A3;
	Wed,  3 Jul 2024 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE0z8PvQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C61745E2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979268; cv=none; b=BSNvI9gPLT8gG6A5/gaFPutWIa8SKLJD9a6jIG+KqQlDInDplYkc19of4W2XN1eHx5UGIdV2FOv9WcO1kKytWFie5YywEG7CG3cxr5UlJ7u4a7mXTKXUrNXWNsE38BERwOHH68h6qvrotOf2bxLFCpQIrUgZrjmw68IZlIN4siQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979268; c=relaxed/simple;
	bh=R8PbHDxHItRnttRsVyzAQLI+0I52W3YmlMnrM72F+NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGjzbrynnPKcEJNREYH7qSjIni9nY6i/k5Xxlc4scMre4mMk+XuETbbBuon5duN+rJtQtG/u2Lz2UNYHCYEHn+Hm+6u9GjTu9t2MWxelIALSqEfgYf8Hxj1yo1A+nWObICJVfhPVjBkHlwSvVpkzPXNxYajb2AaPXj+r5d9vHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE0z8PvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F287C32781;
	Wed,  3 Jul 2024 04:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979267;
	bh=R8PbHDxHItRnttRsVyzAQLI+0I52W3YmlMnrM72F+NA=;
	h=From:To:Cc:Subject:Date:From;
	b=UE0z8PvQpR6RnbkYegJYZzdXzv+2CWrilJnJyjlsjCdwp4aOkDW6MDpYs2vBNMFkg
	 UYNN4qHib4hSrIbrhN6wg0kAew4dGju/9Xy1oIVTMnefdZAUu4OgpFIcRcFnvUKjl+
	 ZtFuzTWDE6mvwt1vkb3fyBhKAJdXgnXO53Mu7wmJFB+D3iYk/2wLuKDtuB3j0A/zzv
	 O+d7VBrCjrvnMX4ijxbfXDvqavPMRFRJ8xS5PeTBDn8wFa7Q+7biX0v47Gem5BZggm
	 sDLmwUwxvgLlwgyqvemK8cc5jk4f4FXYUil4cJuJKtYQBw3041LXGy8nRhCzBM75h+
	 nkYgJ7Ob7EqgQ==
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
Subject: [PATCH v2 00/20] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
Date: Wed,  3 Jul 2024 12:05:50 +0800
Message-ID: <20240703040613.681396-1-alexs@kernel.org>
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

To name the struct zpdesc instead of zsdesc, since there are still 3
zpools under zswap: zbud, z3fold, zsmalloc for now(z3fold maybe removed
soon), and we could easyly extend it to other zswap.zpool in needs.

For all zswap.zpools, they are all using single page since often used
under memory pressure. So the conversion via folio series helper is
better than page's for compound_head check saving.

For now, all zpools are using some page struct members, like page.flags
for PG_private/PG_locked. and list_head lru, page.mapping for page migration.

This patachset does not increase the descriptor size nor introduce any
functional changes, and it could save about 123Kbytes zsmalloc.o size.

Thanks
Alex

---
v1->v2: 
- Take Yosry and Yoo's suggestion to add more members in zpdesc,
- Rebase on latest mm-unstable commit 31334cf98dbd
---

Alex Shi (8):
  mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
  mm/zsmalloc: use zpdesc in trylock_zspage/lock_zspage
  mm/zsmalloc: convert create_page_chain() and its users to use zpdesc
  mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
  mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
  mm/zsmalloc: introduce __zpdesc_clear_movable
  mm/zsmalloc: introduce __zpdesc_clear_zsmalloc
  mm/zsmalloc: introduce __zpdesc_set_zsmalloc()

Hyeonggon Yoo (12):
  mm/zsmalloc: convert __zs_map_object/__zs_unmap_object to use zpdesc
  mm/zsmalloc: add and use pfn/zpdesc seeking funcs
  mm/zsmalloc: convert obj_malloc() to use zpdesc
  mm/zsmalloc: convert obj_allocated() and related helpers to use zpdesc
  mm/zsmalloc: convert init_zspage() to use zpdesc
  mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
  mm/zsmalloc: add zpdesc_is_isolated/zpdesc_zone helper for
    zs_page_migrate
  mm/zsmalloc: convert __free_zspage() to use zdsesc
  mm/zsmalloc: convert location_to_obj() to take zpdesc
  mm/zsmalloc: convert migrate_zspage() to use zpdesc
  mm/zsmalloc: convert get_zspage() to take zpdesc
  mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc

 mm/zpdesc.h   | 143 ++++++++++++++++
 mm/zsmalloc.c | 456 +++++++++++++++++++++++++++-----------------------
 2 files changed, 393 insertions(+), 206 deletions(-)
 create mode 100644 mm/zpdesc.h

-- 
2.43.0


