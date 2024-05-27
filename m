Return-Path: <linux-kernel+bounces-190859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D681D8D0399
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D672A57D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8717BB3D;
	Mon, 27 May 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC3iBprP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4BC17BB18
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819307; cv=none; b=QslyF0+9RGOmB7x0LjO5ZsWOJ+YVhcPRqtI6AxFHqRTL8+/T8Ubx4yhBEg5Y3qmDDmNv9nkUqAFwlNjMywPPrWhdAaWMqB9WRLtG1nXy3FIvyLgc5+vIQFmaqGaXHcI9rcNpA3CComK2iT0XYwk+MMEarnhv5U8E/SixUJnnk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819307; c=relaxed/simple;
	bh=pMHg2pCAWLHVIM5Px7JnnPO2FNi4+GM85ekhL3dRmm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fj0sNyEt22nVzr6zsRy4ccKgparMN+mkrH31xjGks5/KUSuaml4JUPigPIfiQn9LpFwLQnr3qh3iklVp0LMfZuRl4i2IgJQmy6WMWnYeKDwrXJOArcBCaZim6OmQwG/whHciRmw9x4lXY5TM5yHtF5qzem3N7M3K31MA3zJMTP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jC3iBprP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716819304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KKccOQIZycQoZBPSPGMUHOGUVheMa94LVY3B/d+1+Zo=;
	b=jC3iBprPu092b9YbOMD9gV9Jlya5YRAlIVEy6sdF0Kpyxk4tSJp4iYtvHItcX3bcECWsFr
	hy4zDczlhVuAr9wl446GDkSc6auNbeuw1/KaGWZ0JRruEpIMDjMtNXft5QIJJurVvSPRkM
	xRJEmXvIXeeWsGcxfc8Hr7TysYNIfto=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-spO2U6whOJWTtFQD_qaNog-1; Mon,
 27 May 2024 10:15:01 -0400
X-MC-Unique: spO2U6whOJWTtFQD_qaNog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C284C1C0512D;
	Mon, 27 May 2024 14:15:00 +0000 (UTC)
Received: from t490s.redhat.com (unknown [10.39.192.209])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 595A11C00047;
	Mon, 27 May 2024 14:14:58 +0000 (UTC)
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
Subject: [PATCH v1 0/6] mm: page_type, zsmalloc and page_mapcount_reset()
Date: Mon, 27 May 2024 16:14:48 +0200
Message-ID: <20240527141454.113132-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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

Survived a couple of days with the built bots and my cross-compile
attempts. Briefly tested with zram on x86-64.

[1] https://lore.kernel.org/all/20231130101242.2590384-1-42.hyeyoo@gmail.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>

v1 -> v2:
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
 include/linux/page-flags.h | 23 +++++++++++++++--------
 mm/Kconfig                 | 10 ++++++++--
 mm/filemap.c               |  2 +-
 mm/mm_init.c               |  2 +-
 mm/page_alloc.c            |  6 ++++--
 mm/zsmalloc.c              | 29 +++++++++++++++++++++++++----
 9 files changed, 77 insertions(+), 39 deletions(-)


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.1


