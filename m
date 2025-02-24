Return-Path: <linux-kernel+bounces-530149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75356A42FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA92117AC34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB02040AB;
	Mon, 24 Feb 2025 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjEEr0LO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8F1FDE0B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434374; cv=none; b=oJXhamHTsQhtzcNPy2w9rqVo4XU3od7EEKpfidy0/01ytLobWoWb7NZUGxHmWt67gQRz8kgcALrqPb0Bg7X+vsM3ENB0827kFb8Fd9ZcgsgwyM+BDdjeh48mPDFoKWspS7KYn5qgz+2TI3/QC62RY2z39+Lod9AdG9tdN+jb66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434374; c=relaxed/simple;
	bh=gfapPMQxsUeWZIyMMjCbJZLY9wGtMaY+RaHj6lbqACQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4qOiirfI1AfMc/5ZI9NYRR5h6bl++bdksu9nUYwxLnrb1vVOEH+gTpu8G1iiqklqcGm6KpmG0JGMZV2g1CK095y0c74s3BGaKoEdJI9wmSRQdnLmnXvWqPzK4l5jAWcpuuOvHGIQGmJEAv8UYyJbMVXIUmHjVDwJdMyZ4FiLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjEEr0LO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740434370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZnmS/k+dHYbcrS2T4gnKYBLuSvALIoKj3mKYh0gqWc=;
	b=WjEEr0LOLIoqFQ/gakrj4kJKmgUHn/HMXKmNZCmiOWNm8uezWir/EKgKZN81bJmhAOrdMZ
	oYMTYJFw26gPApMqffnozXPv+0/NM/RJxgBgokcSHZdcq8QcPlNzTpDYXZyEzL8hDg29IT
	coO57BVSd4FLqHBjFUZab+vx3uHrTxM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-d9MzX_ROPZSFbvEmazSggQ-1; Mon,
 24 Feb 2025 16:59:26 -0500
X-MC-Unique: d9MzX_ROPZSFbvEmazSggQ-1
X-Mimecast-MFC-AGG-ID: d9MzX_ROPZSFbvEmazSggQ_1740434365
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76ACE18EB2C3;
	Mon, 24 Feb 2025 21:59:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E206180035F;
	Mon, 24 Feb 2025 21:59:23 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@redhat.com,
	yuzhao@google.com,
	pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	muchun.song@linux.dev,
	luizcap@redhat.com
Subject: [PATCH v2 3/4] mm: page_table_check: use new iteration API
Date: Mon, 24 Feb 2025 16:59:07 -0500
Message-ID: <30d246e83e73073451dc3d5fe189b733afbefd07.1740434344.git.luizcap@redhat.com>
In-Reply-To: <cover.1740434344.git.luizcap@redhat.com>
References: <cover.1740434344.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The page_ext_next() function assumes that page extension objects for a
page order allocation always reside in the same memory section, which
may not be true and could lead to crashes. Use the new page_ext
iteration API instead.

Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 mm/page_table_check.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 509c6ef8de400..e11bebf23e36f 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -62,24 +62,20 @@ static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
  */
 static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
 {
+	struct page_ext_iter iter;
 	struct page_ext *page_ext;
 	struct page *page;
-	unsigned long i;
 	bool anon;
 
 	if (!pfn_valid(pfn))
 		return;
 
 	page = pfn_to_page(pfn);
-	page_ext = page_ext_get(page);
-
-	if (!page_ext)
-		return;
-
 	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
-	for (i = 0; i < pgcnt; i++) {
+	rcu_read_lock();
+	for_each_page_ext(page, pgcnt, page_ext, iter) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
 
 		if (anon) {
@@ -89,9 +85,8 @@ static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
 			BUG_ON(atomic_read(&ptc->anon_map_count));
 			BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
 		}
-		page_ext = page_ext_next(page_ext);
 	}
-	page_ext_put(page_ext);
+	rcu_read_unlock();
 }
 
 /*
@@ -102,24 +97,20 @@ static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
 static void page_table_check_set(unsigned long pfn, unsigned long pgcnt,
 				 bool rw)
 {
+	struct page_ext_iter iter;
 	struct page_ext *page_ext;
 	struct page *page;
-	unsigned long i;
 	bool anon;
 
 	if (!pfn_valid(pfn))
 		return;
 
 	page = pfn_to_page(pfn);
-	page_ext = page_ext_get(page);
-
-	if (!page_ext)
-		return;
-
 	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
-	for (i = 0; i < pgcnt; i++) {
+	rcu_read_lock();
+	for_each_page_ext(page, pgcnt, page_ext, iter) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
 
 		if (anon) {
@@ -129,9 +120,8 @@ static void page_table_check_set(unsigned long pfn, unsigned long pgcnt,
 			BUG_ON(atomic_read(&ptc->anon_map_count));
 			BUG_ON(atomic_inc_return(&ptc->file_map_count) < 0);
 		}
-		page_ext = page_ext_next(page_ext);
 	}
-	page_ext_put(page_ext);
+	rcu_read_unlock();
 }
 
 /*
@@ -140,24 +130,19 @@ static void page_table_check_set(unsigned long pfn, unsigned long pgcnt,
  */
 void __page_table_check_zero(struct page *page, unsigned int order)
 {
+	struct page_ext_iter iter;
 	struct page_ext *page_ext;
-	unsigned long i;
 
 	BUG_ON(PageSlab(page));
 
-	page_ext = page_ext_get(page);
-
-	if (!page_ext)
-		return;
-
-	for (i = 0; i < (1ul << order); i++) {
+	rcu_read_lock();
+	for_each_page_ext(page, 1 << order, page_ext, iter) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
 
 		BUG_ON(atomic_read(&ptc->anon_map_count));
 		BUG_ON(atomic_read(&ptc->file_map_count));
-		page_ext = page_ext_next(page_ext);
 	}
-	page_ext_put(page_ext);
+	rcu_read_unlock();
 }
 
 void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte)
-- 
2.48.1


