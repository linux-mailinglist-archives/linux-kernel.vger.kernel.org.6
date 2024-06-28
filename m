Return-Path: <linux-kernel+bounces-233287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF9F91B53A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D33BB21752
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765751C683;
	Fri, 28 Jun 2024 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pglwPe18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1A14A82
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544010; cv=none; b=WYSbzu0TUSnIWbENnQBHcfcFZwFThrSzCljegF8SVG6b7h+U3NHMvk6CUoCZGtp4TNgJw6WqiykS7w1fLV6zXg/MMTvQ7bEhY3EQxYJdtY68kPXKpheu1q0bR7n7pyc8/gzjTjh9YaKrrteBTcd/H5Qz0s5OpPm80EmKNctMzv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544010; c=relaxed/simple;
	bh=5+tBHusmR4aUF4zyf7Vxi1FNFEYWZk+/bVwuyAj8IsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CCNt0nGQfME/HEW0do0FtHmKhz7GCamKne7UHb/lFNBxu+sOv8rjDJ4O16l0Ww9D7uNbBa5TDgih0VLtwS1CdPQ7a9t0fMRLvMpmnuzLD3dKQbgGtrClaU3u9S0rA/E388diRh8pbKMQBcSm/CwJbg5RLEPSKLM+yLD9cepB4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pglwPe18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61538C2BBFC;
	Fri, 28 Jun 2024 03:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544009;
	bh=5+tBHusmR4aUF4zyf7Vxi1FNFEYWZk+/bVwuyAj8IsI=;
	h=From:To:Cc:Subject:Date:From;
	b=pglwPe18LUlrctHdShdWVYrBQP5VIPx3LY5Hd5hty+1rUqP9VU/G8RYzKefRNPMsQ
	 NOD3zhg8nhVN4bTlPcNmnq7mRiRDdp+4ywDCwKuwrfsSAZUL+dGZYLDZMp+lUcpt/G
	 VDvSdMp2qBTIQKPoGLj6Bfc/AIhcOZTYwOU7ximIbxlNnYOBTEXfCgs6Hl5l7YjloN
	 haTGshE2CcfBfKQ9ryr2mwIjFJ/UVZN2D3gRcLs6iArOf8encGnj8S/qvmixMdD133
	 UjFGae6kmU3PtFIeoj1/j1tdbV7G48b0rPEjMQKipSZZVwvLhPqg4FTPWtBjreqUCt
	 WoUPHmPTW4jJg==
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
	42.hyeyoo@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 00/20] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
Date: Fri, 28 Jun 2024 11:11:15 +0800
Message-ID: <20240628031138.429622-1-alexs@kernel.org>
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

This patachset could save 123Kbyetes zsmalloc.o size.

Thanks
Alex

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

 mm/zpdesc.h   | 134 +++++++++++++++
 mm/zsmalloc.c | 454 +++++++++++++++++++++++++++-----------------------
 2 files changed, 384 insertions(+), 204 deletions(-)
 create mode 100644 mm/zpdesc.h

-- 
2.43.0


