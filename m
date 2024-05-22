Return-Path: <linux-kernel+bounces-186710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B23C8CC7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38204B21A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742D1474AD;
	Wed, 22 May 2024 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNnxP48H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AED146586
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411842; cv=none; b=k2LVx1661CNyEGYszx8K0c7LHJa4kIFPKVAf2Db0QWlCYZ6tE2vLyMmkgd6ngqymKgbKhyjb4rUnLku/FT7uZaRvZhg0+10WWNFeqsh2OjdfIurOPWCEJPpSlDOMeLmosYyhRdAIXAjTDQvJHqqZfNxuZiyDdROoGlXCioy2amc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411842; c=relaxed/simple;
	bh=0BfzNJgPHUIWX0iWLtLdfNYTXy+ODEs3tvBTu1w1dc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsiJWZq6YrLXO/OloADBDD55A0DdB+rq6BzPLDaWdITBNS8aoZpOm0xakmziy/wRs34Gvz6Zqz592ya6VrCO+JjpR/guv+LLONNfhrYK9FlgIk7pDvQ/hAabSk36wzQMbHi6ueTxQln4BZacShocnjo+ywGs8tV8Ri3R9N2pK5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNnxP48H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716411840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6qRfeG4CVJz5l48G3FsZPf4ap0/Ubwcpkx8trvSrMU=;
	b=iNnxP48H3m51no+v3npPEgp0jTguKrQqeasL9WXMVjZk88DASmU96yeAhIQvuVQp3E+pg3
	Qz9wocw1SJxQvhcXPt17ndLlUvExzSSQr+3yM5iSH1I6i1qNc2UfwUo5BPtWa3Li3V22DV
	s/BjAovD9MZAKFoINnQQv91HPwlGzFc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-gaoAYFYkNC-gX_dN8vliYw-1; Wed, 22 May 2024 17:03:55 -0400
X-MC-Unique: gaoAYFYkNC-gX_dN8vliYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49F378008A4;
	Wed, 22 May 2024 21:03:55 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5F27B7412;
	Wed, 22 May 2024 21:03:53 +0000 (UTC)
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
Subject: [PATCH RFC 4/6] mm/page_alloc: clear PageBuddy using __ClearPageBuddy() for bad pages
Date: Wed, 22 May 2024 23:03:39 +0200
Message-ID: <20240522210341.1030552-5-david@redhat.com>
In-Reply-To: <20240522210341.1030552-1-david@redhat.com>
References: <20240522210341.1030552-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Let's stop using page_mapcount_reset() and clear PageBuddy using
__ClearPageBuddy() instead.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e22ce5675ca..b595342e73c2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -498,7 +498,8 @@ static void bad_page(struct page *page, const char *reason)
 	dump_stack();
 out:
 	/* Leave bad fields for debug, except PageBuddy could make trouble */
-	page_mapcount_reset(page); /* remove PageBuddy */
+	if (PageBuddy(page))
+		__ClearPageBuddy(page);
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
@@ -1346,7 +1347,8 @@ static void check_new_page_bad(struct page *page)
 {
 	if (unlikely(page->flags & __PG_HWPOISON)) {
 		/* Don't complain about hwpoisoned pages */
-		page_mapcount_reset(page); /* remove PageBuddy */
+		if (PageBuddy(page))
+			__ClearPageBuddy(page);
 		return;
 	}
 
-- 
2.45.0


