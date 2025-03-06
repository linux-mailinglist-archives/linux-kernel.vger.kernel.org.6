Return-Path: <linux-kernel+bounces-550021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543BA55A13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577DE3B2205
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D527CB1D;
	Thu,  6 Mar 2025 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7Jb+1UQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0909627CB0C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301124; cv=none; b=MbBYtaW8DCV3CR/XDXqdJeZ6kA9U3dZ7PJF9RPgcGMe9C/Mk4E6P3GY81pg227iQ28vvPTWgpgsg2uxUKacO7nzddta8WUQk0rWxUWENFGasghT88qlNjYkxq8JHw4wI3t2pXt7TyLunvmyfmt77WHL4tD8kvCziCXs4Yrbl4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301124; c=relaxed/simple;
	bh=3OaQdiUuTcyEIe69qMe8cf9GJuNLKgFZ12pGgelBBDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L97CIQZRIcwSbVllzi67cdtxOiQCFfikt/+t7AOPaXn9iW+tsq1kQ1pbxx4dS9M7pBqEtB+PFOdQA8XkNruKKIniYBwDaCiuGwslT0Q7ygkKPvnndih2Lt6xAyK8CYhPKafCIc+/AhDWiWur4SrQQsXzr1g0ni61aY+ZsRfVA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7Jb+1UQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741301121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igjG5KqbdWExRJ3eRwEZliK2f0M4oSjOk76qmgyzu2Y=;
	b=L7Jb+1UQn0RwutvR3DQ2j9F4eYwdVBBYLjxbsceDIM7DhQOQSv1xjKyz7AiD2QyvVfcGiw
	/dtVpGPGYXOyKfC+On3YMvTrtS6SMzBAl27TZ5Kq+WymW1lBuv0iGkbhIMxtGF8JPWDQby
	aqOqzyg5e7KozT+uqqdUmAMyiSzP3h0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-eFNtnSS5PtelNava3YdU2w-1; Thu,
 06 Mar 2025 17:45:08 -0500
X-MC-Unique: eFNtnSS5PtelNava3YdU2w-1
X-Mimecast-MFC-AGG-ID: eFNtnSS5PtelNava3YdU2w_1741301107
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB792195608A;
	Thu,  6 Mar 2025 22:45:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.191])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E540B18001D3;
	Thu,  6 Mar 2025 22:45:04 +0000 (UTC)
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
Subject: [PATCH v3 2/3] mm: page_table_check: use new iteration API
Date: Thu,  6 Mar 2025 17:44:51 -0500
Message-ID: <ca2d53a020fe1cd65c442627ff6c0c40d591cbd8.1741301089.git.luizcap@redhat.com>
In-Reply-To: <cover.1741301089.git.luizcap@redhat.com>
References: <cover.1741301089.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The page_ext_next() function assumes that page extension objects for a
page order allocation always reside in the same memory section, which
may not be true and could lead to crashes. Use the new page_ext
iteration API instead.

Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
Acked-by: David Hildenbrand <david@redhat.com>
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


