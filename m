Return-Path: <linux-kernel+bounces-194004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C42688D3553
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51784B24B29
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733516D9AD;
	Wed, 29 May 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3myBUqI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9E137903
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981553; cv=none; b=AfatNo+pU1QE0lRKoPeHjZMje6qvtALr6O3ENbi7e/tiw/j4GQg29lBsOAQQW6ztJtcti6tsTUVAM6EgjzLGsO14I516Sy9m5K66Cgtqm+xb48HtdzWtaiflw5Z/nx8G4XyiEapz8PDdQbEBPoXhtP18HQr2S02NWQxXW2+objg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981553; c=relaxed/simple;
	bh=IdYZdK+0Kpa8lbkG4W6iZOfgFAUE+8WOlAiZncQqZmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CamgbS+aL34Wgt7U2VNx0Za4fAC4jxeAuMuarAuYzDkVY5ENQUaA3EW3Zaw8/PGjbQ8E3qL5irDv9BCY+LeXmrC1xoOcMEYhx9KXud6YgsQ4FQLCs7gtzyqhRYqeLVUt+Yo7TWSQVor5X8eYF8ab/Adf/Cb8rRVAm3w8gOHc6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3myBUqI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716981550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jPxv1H9FEvCkjhG3HJ1KbEh1kIcR6+OYpFhiyO9bfXs=;
	b=L3myBUqICjG+YFiU/NJfKXtn06fgwmjJdzRQddjFhSRl7Ts/3/SDvRO02Q4dJMZviZfTBp
	ZPsneu9Bl39qzHf3uTAhDmSxkbL7QcsGoKMiDauK400/V2T0GdqozcLnTSXmJKJqSoIk/I
	24KnYQ1RaxFMtgCDuC74nKJdVFqDiSU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-hdrW9_VDPtqk-vfyiUgC2g-1; Wed, 29 May 2024 07:19:07 -0400
X-MC-Unique: hdrW9_VDPtqk-vfyiUgC2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12C47800169;
	Wed, 29 May 2024 11:19:07 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.127])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0116C15BB1;
	Wed, 29 May 2024 11:19:04 +0000 (UTC)
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
Subject: [PATCH v2 0/6] mm: page_type, zsmalloc and page_mapcount_reset()
Date: Wed, 29 May 2024 13:18:58 +0200
Message-ID: <20240529111904.2069608-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Wanting to remove the remaining abuser of _mapcount/page_type along with
page_mapcount_reset(), I stumbled over zsmalloc, which is yet to be
converted away from "struct page" [1].

Unfortunately, we cannot stop using the page_type field in zsmalloc code
completely for its own purposes. All other fields in "struct page" are
used one way or the other. Could we simply store a 2-byte offset value
at the beginning of each page? Likely, but that will require a bit more
work; and once we have memdesc we might want to move the offset in there
(struct zsalloc?) again.

.. but we can limit the abuse to 16 bit, glue it to a page type that
must be set, and document it. page_has_type() will always successfully
indicate such zsmalloc pages, and such zsmalloc pages only.

We lose zsmalloc support for PAGE_SIZE > 64KB, which should be tolerable.
We could use more bits from the page type, but 16 bit sounds like a good
idea for now.

So clarify the _mapcount/page_type documentation, use a proper page_type
for zsmalloc, and remove page_mapcount_reset().

Briefly tested with zram on x86-64.

[1] https://lore.kernel.org/all/20231130101242.2590384-1-42.hyeyoo@gmail.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>

v1 -> v2:
 * Rebased to mm/mm-unstable
 * "mm: update _mapcount and page_type documentation"
  -> Minor comment change
 * "mm: allow reuse of the lower 16 bit of the page type with an actual
    type"
  -> Fixup 18 vs 16 in description
  -> Reduce PAGE_TYPE_BASE to a single bit and hand-out bits from highest
     to lowest
  -> Adjust description

RFC -> v1:
 * Rebased to v6.10-rc1
 * "mm: update _mapcount and page_type documentation"
  -> Exchange members and fixup doc as suggested by Mike
 * "mm: allow reuse of the lower 16bit of the page type with an actual
    type"
  -> Remove "highest bit" comment, fixup PG_buddy, extend description
 * "mm/zsmalloc: use a proper page type"
  -> Add and use HAVE_ZSMALLOC to fixup compilcation
  -> Fixup BUILD_BUG_ON
  -> Add some VM_WARN_ON_ONCE(!PageZsmalloc(page));
 * "mm/mm_init: initialize page->_mapcount directly
    in __init_single_page()"
  -> Fixup patch subject

David Hildenbrand (6):
  mm: update _mapcount and page_type documentation
  mm: allow reuse of the lower 16 bit of the page type with an actual
    type
  mm/zsmalloc: use a proper page type
  mm/page_alloc: clear PageBuddy using __ClearPageBuddy() for bad pages
  mm/filemap: reinitialize folio->_mapcount directly
  mm/mm_init: initialize page->_mapcount directly in
    __init_single_page()

 drivers/block/zram/Kconfig |  1 +
 include/linux/mm.h         | 10 ----------
 include/linux/mm_types.h   | 33 ++++++++++++++++++++++-----------
 include/linux/page-flags.h | 25 ++++++++++++++++---------
 mm/Kconfig                 | 10 ++++++++--
 mm/filemap.c               |  2 +-
 mm/mm_init.c               |  2 +-
 mm/page_alloc.c            |  6 ++++--
 mm/zsmalloc.c              | 29 +++++++++++++++++++++++++----
 9 files changed, 78 insertions(+), 40 deletions(-)

-- 
2.45.1


