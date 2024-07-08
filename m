Return-Path: <linux-kernel+bounces-243888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C681E929C2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817DC282691
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37A14287;
	Mon,  8 Jul 2024 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfPlvnzf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC792125DE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420121; cv=none; b=a3H2myIvwr0elt2pfnaw1CzD3x0gcQr9qZNovhhLjykE6rZm4O8qEMXsrVpCmZEY8575uJ0GNi9r+Ku5EPxdg0mS2C4OlQ6Mj2JMnp/wKZdmYeD+3m2m2MiHR6TdcEO2BkzkXLIXK1pDIxIoLAuLX7k84PpSCcprbYSClePIGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420121; c=relaxed/simple;
	bh=PygjdzSV6SpcBpLpxkEt0f2pdR/RuCc/C0kYkbdkhs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1cQA50FwYbZ5hP3w/gvtzTM7gOoviv1V9181DiZGryQQyVXlxyrFyaaHOBmFqhxWuHAXmhvD4ApLPJNhIQaKWPhvaU1bO+UXTbDjiVg1kskIY8VNozhNxFTwsW+fsEx4XqZk2iQ1xyQSenaYafOz4wU15Nvsv/AGm7o3xNayQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfPlvnzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A95C116B1;
	Mon,  8 Jul 2024 06:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420121;
	bh=PygjdzSV6SpcBpLpxkEt0f2pdR/RuCc/C0kYkbdkhs0=;
	h=From:To:Cc:Subject:Date:From;
	b=cfPlvnzfcKFaWjdjjnAmZ2m7n+TdCgGEfSAB+HvrSbcNZkj71mTAAQTqCpgVnpYlg
	 UcbjJZU5jAJVOd1rBPNbncXnj3hT2/kjjFlXOmivBNbBhE316jitv3xlJkS6v8CbwN
	 xdt+TxYPjg286s/ke13z/uypE48Cy1Qvpx6Ux9T0MoQ0y9TJp9vCrFIMGfFYsCqpoU
	 8Uz7xTj+jaBkX3cw7wDKb0YX8q4mdP7mZP1orDqaDR06QVTRdwfnfmJjNKrtR+iNCf
	 BePIs5y81HMDegsGP//PKKF9cKhFsmDmDq5PryvaapCYIbuE+KMhhd5lV1n5kQUFbH
	 QkLyK0gjan05g==
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
Subject: [PATCH v3 00/20] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
Date: Mon,  8 Jul 2024 14:33:21 +0800
Message-ID: <20240708063344.1096626-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi (Tencent) <alexs@kernel.org>

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

Thanks
Alex

---
v3->v2:
- Fix LKP reported build issue
- Update the Usage of struct zpdesc fields.
- Rebase onto latest mm-unstable commit 2073cda629a4

v1->v2: 
- Take Yosry and Yoo's suggestion to add more members in zpdesc,
- Rebase on latest mm-unstable commit 31334cf98dbd
---

Alex Shi (Tencent) (9):
  mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
  mm/zsmalloc: use zpdesc in trylock_zspage/lock_zspage
  mm/zsmalloc: convert create_page_chain() and its users to use zpdesc
  mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
  mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
  mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
  mm/zsmalloc: introduce __zpdesc_clear_movable
  mm/zsmalloc: introduce __zpdesc_clear_zsmalloc
  mm/zsmalloc: introduce __zpdesc_set_zsmalloc()

Hyeonggon Yoo (11):
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

 mm/zpdesc.h   | 146 ++++++++++++++++
 mm/zsmalloc.c | 460 +++++++++++++++++++++++++++-----------------------
 2 files changed, 398 insertions(+), 208 deletions(-)
 create mode 100644 mm/zpdesc.h

-- 
2.43.0


