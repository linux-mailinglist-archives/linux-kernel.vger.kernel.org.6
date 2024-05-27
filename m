Return-Path: <linux-kernel+bounces-190867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3483F8D03AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608911C218D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426D161B43;
	Mon, 27 May 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH0Indix"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795816ABF3
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819318; cv=none; b=rxQFAWaQm/JGrIFLJERVrwuLJRPVR+g/R4NIWU7dNWy7V4pG08eZYB2H3SPdTqGl1rs+IX4X00bEEgjF93+jDDWLdVp1WDbjj59SH8zMyFEpCd10oC6AMHSCi+cEMnamXtT+JVmZY+GbjCP2XBcKwxMRq2sdG0TSlyNsj2e+4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819318; c=relaxed/simple;
	bh=eR54nyN8X331jvh+2F+9aDH/YXJgBoJDMxx+DXSKR14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qriZPXxKLXr8s++VzFzN1WtvGj+ozRVj1sMfeWA2nS3h2LZ8JuG57DbsH31GnZqL9ll12UHOR+urqzMsB5AfXg1AwkU6itGvKIFUd3VgQIwS9kfJlSdtawOfnERTzUzym2IMb4LrOFfGtM6A2zONggkzgRBgcKCgRNHLsmGQV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH0Indix; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716819316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hshwfl98bML8acqrBVRK8K6pB1i4C/7ItyePT11o37I=;
	b=FH0Indix9f/mdiHiwZexNkJ4+ru6n6TNYOF6Q6CbGXwx5mdWfOgeh5jx/efXB7DHkC1VDL
	arORcoFolLjzYoMI0JVIwUbfZB+jktbga8pzKuDOydmeZbgZOPupAKuMqdyLpNw9ej28iJ
	uAIvWi+xIn4IRFaM7aKDut78yZ0UDMc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-AAUNmNJgPs6LTG_45hYmFg-1; Mon, 27 May 2024 10:15:09 -0400
X-MC-Unique: AAUNmNJgPs6LTG_45hYmFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51D76185A78E;
	Mon, 27 May 2024 14:15:09 +0000 (UTC)
Received: from t490s.redhat.com (unknown [10.39.192.209])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 902091C00A8F;
	Mon, 27 May 2024 14:15:07 +0000 (UTC)
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
Subject: [PATCH v1 4/6] mm/page_alloc: clear PageBuddy using __ClearPageBuddy() for bad pages
Date: Mon, 27 May 2024 16:14:52 +0200
Message-ID: <20240527141454.113132-5-david@redhat.com>
In-Reply-To: <20240527141454.113132-1-david@redhat.com>
References: <20240527141454.113132-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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
2.45.1


