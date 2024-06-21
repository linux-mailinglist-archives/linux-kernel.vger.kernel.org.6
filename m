Return-Path: <linux-kernel+bounces-223915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC1C911A79
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47BF281CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F03413699E;
	Fri, 21 Jun 2024 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4uMpUuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC212C481
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948524; cv=none; b=QxS9DB6XCZE9uH/i/YbmSW7Sb3vhDTK9eBwkWSu+LPO65fPRUhD0K1R9YYwYy9yDueLCxGx/vLy2CvpHgwa0LoMslqZzq57u8Ucp0NLA+gNMpbue2HAqqy1Sxs7Kzs0vJ9g97EUbhjTWSBkbY6X1vDsxc64MusTTWxsvBgnIhwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948524; c=relaxed/simple;
	bh=sI3HdF7oTrLQQ9ZG9TlqrCSIuiaexC6T0mWrx6bDeLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAsM8PSYbFCjuSiPF7TG88pG0jzNXSpVt/ciWAerKBBqlQWapUqSCfvC1qZGUhtpJoiUQ3C/GHOFD5c7xqPvsuCPmggRaTR6cSaNdfdwt4LZU+vGkLh2CXOrTbbQP7juV34aT2tZi4nCb8LAwogUPaXozd6C5+cJix+f8Smr4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4uMpUuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E3BC4AF07;
	Fri, 21 Jun 2024 05:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948524;
	bh=sI3HdF7oTrLQQ9ZG9TlqrCSIuiaexC6T0mWrx6bDeLE=;
	h=From:To:Cc:Subject:Date:From;
	b=c4uMpUuKiB3ymxKZ4d3CCkA+d78gA+pzEW4h2VFSgPwieQkyE0fb+oWqhZh+N/751
	 5k14M8haVEnEZqY0Dt19zZoaeAmta3D+LtEnrkwE7ffSBDIL5mcaGPwuek9AcCIObY
	 uOJqVBSlNTsjsIDf9QwjVB5hAXXUairt/6DNojxuA0DSDUSxeqAhgpwVy/MBk/DraB
	 EshaeK0s59xoX5sHBL7dW5PVokeIroViWdmN8BXKgclikxkzAXjAcFNn0opNNlC5jh
	 k5P9kgiJAIK5HQeiUTNOCSMlE8GEPLsEZONxEAb6q2WlHHgWUrcNGqt865D/wOmGQD
	 oFsRnTb8azwlw==
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
Subject: [PATCH 00/15] add zpdesc memory descriptor for zswap.zpool 
Date: Fri, 21 Jun 2024 13:46:40 +0800
Message-ID: <20240621054658.1220796-1-alexs@kernel.org>
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

Here is a implement on z3fold to replace page descriptor by zpdesc,
which is still overlay on struct page now. but it's a step move forward
above destination.

To name the struct zpdesc instead of z3fold_desc, since there are 3 zpool
usages under zswap, zbud, z3fold, zsmalloc. It looks like we may extend the
zpdesc to zbud and zsmalloc, combined their usage into one.

For zpdesc(page), z3fold just uses the 5th member zppage_flag, which
match with page.private. Potentially uses the first member flags for
headless PG_locked, list_head lru and page.mapping|PAGE_MAPPING_MOVABLE
for page migration.

This patachset could save 26Kbyetes z3fold.o size, basely saving come
from the page to folio conversion.

Thanks a lot!
Alex

Alex Shi (15):
  mm/z3fold: add zpdesc struct and helper and use them in
    z3fold_page_isolate
  mm/z3fold: use zpdesc in z3fold_page_migrate
  mm/z3fold: use zpdesc in z3fold_page_putback
  mm/z3fold: use zpdesc in get/put_z3fold_header funcs
  mm/z3fold: use zpdesc in init_z3fold_page
  mm/z3fold: use zpdesc in free_z3fold_page
  mm/z3fold: convert page to zpdesc in __release_z3fold_page
  mm/z3fold: use zpdesc free_pages_work
  mm/z3fold: use zpdesc in z3fold_compact_page and do_compact_page
  mm/z3fold: use zpdesc in __z3fold_alloc
  mm/z3fold: use zpdesc in z3fold_alloc
  mm/z3fold: use zpdesc in free_z3fold_page and z3fold_free
  mm/z3fold: use zpdesc in z3fold_map/z3fold_unmap
  mm/z3fold: introduce __zpdesc_set_movable
  mm/z3fold: introduce __zpdesc_clear_movable

 mm/z3fold.c | 190 +++++++++++++++++++++++++++-------------------------
 mm/zpdesc.h |  87 ++++++++++++++++++++++++
 2 files changed, 184 insertions(+), 93 deletions(-)
 create mode 100644 mm/zpdesc.h

-- 
2.43.0


