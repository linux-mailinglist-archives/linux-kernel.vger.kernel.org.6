Return-Path: <linux-kernel+bounces-194010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C714D8D3559
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790411F26053
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A091181B8B;
	Wed, 29 May 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h23b6e1B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BE181300
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981564; cv=none; b=sr0ipeDqTT1HTnYsHCx2+B6R9r5abDyYqQV4d/hzWbYcfxBSNgf9dMjodywTwJdUI6A6Uc/JWgQQgE8zPwj3BcLy1+6/KQRpnblr98Hlci4RK1mE154TCjppsF1y5S1+Z4WvEDaTnxRDGLxrRYDgqD7NvyT87Bs3Xx/gIWyjxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981564; c=relaxed/simple;
	bh=OrtHN7gm6sG7/e44ksUr1jsieGg46k546PJ3cCa5NdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/6Opr29y49R+tRWZ7ns9N4LUFYQmIg9Mb3xGj7qH/e0HnoFw+da4qfdXmHF2cNJ+E/cxRsFPYGgn5S/hryFpdcjc21BHuju/qK8zgVLJZMoFYkuuFcJPOe+IGSwAqfCaq3e6Z+E4DGis8Bew/tYLn1dUDrB/q0Un3RcnliilBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h23b6e1B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716981562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=503jl45eQ6DH26oe7TpQo3EopwWo8mZfnH3eTedH2jo=;
	b=h23b6e1BiZmOdspkExb2c/aKQ7NIbdcL7jFLuCGGfMVcRbejSQ/ThcwFmT5n4N5musRcDq
	tGPXqXkObuN+obOm6vt9HUYG8yA+Y/svwQdStWt5lET6gQzdi8o5zJ8m29cRtGvOM/wkvH
	pYfpzykC1v163lmhbtV8o0VzW/Pmp8U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-jaInmsy4NLOfXj_IkOsLPQ-1; Wed, 29 May 2024 07:19:19 -0400
X-MC-Unique: jaInmsy4NLOfXj_IkOsLPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E2B185A58C;
	Wed, 29 May 2024 11:19:19 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.127])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9DAFDC15BB9;
	Wed, 29 May 2024 11:19:17 +0000 (UTC)
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
Subject: [PATCH v2 6/6] mm/mm_init: initialize page->_mapcount directly in __init_single_page()
Date: Wed, 29 May 2024 13:19:04 +0200
Message-ID: <20240529111904.2069608-7-david@redhat.com>
In-Reply-To: <20240529111904.2069608-1-david@redhat.com>
References: <20240529111904.2069608-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Let's simply reinitialize the page->_mapcount directly. We can now
get rid of page_mapcount_reset().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 5 -----
 mm/mm_init.c       | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index eebfce8f58bca..c41c82bcbec2f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1206,11 +1206,6 @@ static inline int folio_entire_mapcount(const struct folio *folio)
 	return atomic_read(&folio->_entire_mapcount) + 1;
 }
 
-static inline void page_mapcount_reset(struct page *page)
-{
-	atomic_set(&(page)->_mapcount, -1);
-}
-
 /**
  * page_mapcount() - Number of times this precise page is mapped.
  * @page: The page.
diff --git a/mm/mm_init.c b/mm/mm_init.c
index e0023aa685556..426314eeecec3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -568,7 +568,7 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
-	page_mapcount_reset(page);
+	atomic_set(&page->_mapcount, -1);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
 
-- 
2.45.1


