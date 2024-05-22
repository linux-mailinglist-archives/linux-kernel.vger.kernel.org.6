Return-Path: <linux-kernel+bounces-186706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA958CC7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C04F1C20EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972C013D61A;
	Wed, 22 May 2024 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmvHLmxF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAE20DF4
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411831; cv=none; b=adRVUT4xMFbFoK7qYyP/K4mU4LPmduwaea3+v+/MK1tGJ2NKtjv4iWyODscxP6IEVSsHVMdABd5HDI3pVp+wVXlkUO+51FK+M4F8AA2grdYba6DDqGnRQrDmBKTMdDQH9i4s7g3/GBHIkBW3kZHkCcWhE/nCmG2Qyfl5vYUjRNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411831; c=relaxed/simple;
	bh=c0knFbe4KUs1c2AEzMCJh04Hrtk/o1gEtpRmb2o7zXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1gPJkmr0Lew2hE1Fif+awrTpmYt9g6NZorNxwchj4BwRk1NTsPYjxvv5Rv5LFhWUurPOtWbbsXRS4rhXhd+jEUS7OL9iL8RvuR/WY8M0+oTmWNX8BlC3QMabVgaMq/EpVOYhxCVzlwgn+M1yLZiCm9DSm6nGvsJfBLDbZse3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmvHLmxF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716411828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8bJaVETnceXnZKEpoYXTppVEYfiyqOTFMzgclBfDxIg=;
	b=WmvHLmxFVg7jFo0KkSlYO+9GBCbnHw2ztI7r2pvvMbFzkQMkajOP4MuqphmwYOX4Y+zVc1
	Xuo11p3iIvGfXEm2qinmuZ7Rv83ekdGGO6UMK49Aj49F1VnMUG53xOYZDKes3YI5izugQU
	xB5gJNpk4ux8Xjae3jm3VKbJtpxMdXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-8G2Dz7GxOOaDT4FP9uenVQ-1; Wed, 22 May 2024 17:03:45 -0400
X-MC-Unique: 8G2Dz7GxOOaDT4FP9uenVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0546681227E;
	Wed, 22 May 2024 21:03:45 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 82A9F7412;
	Wed, 22 May 2024 21:03:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH RFC 0/6] mm: page_type, zsmalloc and page_mapcount_reset()
Date: Wed, 22 May 2024 23:03:35 +0200
Message-ID: <20240522210341.1030552-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Wanting to remove the remaining abuser of _mapcount/page_type along with
page_mapcount_reset(), I stumbled over zsmalloc, which is yet to be
converted away from "struct page" [1].

Unfortunately, we cannot stop using the page_type field in zsmalloc code
completely for its own purposes. All other fields in "struct page" are
used one way or the other.

.. but we can limit the abuse to 16 bit, glue it to a apge type that
must be set, and document it. page_has_type() will always successfully
indicate such zsmalloc pages, and such zsmalloc pages only.

We lose zsmalloc support for PAGE_SIZE > 64KB, which should be tolerable.
We could use more bits from the page type, but 16 bit sounds like a good
idea.

So clarify the _mapcount/page_type documentation, use a proper page_type
for zsmalloc, and remove page_mapcount_reset().

Only lightly tested with zram. Will have to do more testing and
cross-compile checking.

[1] https://lore.kernel.org/all/20231130101242.2590384-1-42.hyeyoo@gmail.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>

David Hildenbrand (6):
  mm: update _mapcount and page_type documentation
  mm: allow reuse of the lower 16bit of the page type with an actual
    type
  mm/zsmalloc: use a proper page type
  mm/page_alloc: clear PageBuddy using __ClearPageBuddy() for bad pages
  mm/filemap: reinitialize folio->_mapcount directly
  mm/mm_init: initialize page->_mapcount directly in__init_single_page()

 include/linux/mm.h         | 10 ----------
 include/linux/mm_types.h   | 29 ++++++++++++++++++++---------
 include/linux/page-flags.h | 25 +++++++++++++++++--------
 mm/Kconfig                 |  1 +
 mm/filemap.c               |  2 +-
 mm/mm_init.c               |  2 +-
 mm/page_alloc.c            |  6 ++++--
 mm/zsmalloc.c              | 23 +++++++++++++++++++----
 8 files changed, 63 insertions(+), 35 deletions(-)


base-commit: 29c73fc794c83505066ee6db893b2a83ac5fac63
-- 
2.45.0


