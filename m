Return-Path: <linux-kernel+bounces-530150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E72A42FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90FFE7AB12D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32FD205AA0;
	Mon, 24 Feb 2025 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlIThKYl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334481FBEBF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434377; cv=none; b=YapS/yUzRfcUIY0sKz4Vy6NsgupC8xueVk6sTLXFAh0XzuTQRcZAmMN4uAK23VhGB70ELdLhPyNJud4mBeWgmJ0KVa3FMJdDfiMn03HWT0DO/xJxPCFxvNlHmnGBFwX3XlR3CnotVU7Rw4hNdlBzGn/j8nojaVqvjMjQM/PVPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434377; c=relaxed/simple;
	bh=tYAQ3aSW354yzsYqD4JxVDZTKN8sBGftkdhW2t84PpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjSEihzjcZ+k8pg5TsrZZPc5ztrXjLvi7vwpou3jtxklb2tYsZ1F9FfPo5Zyop6iYceGLNMlAu9L52XQgnA2BqSpaiS3Ecu2gQU8+k5lVVqFXsI0lCcEdjQOg6MOJ+WM004ukUpWZAClpyvmnADZ8FELDRjLWiWKfmitGjD4iEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlIThKYl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740434374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6w7eedefm4DE2XJ3Yn/BDysgoHUEY0apu1z5eddMX8Y=;
	b=MlIThKYlqRQXAUODBzZWDgWm+tnsJ3U9iqxIgqpqaO3l0mEQ2/HoNy/uWv0r22bqK25FcS
	ilWQyLKSzCCI916rr0XeWM4iWsW+HfuayG//3i1pmO2yByc8ij2q6bYhTtLTm/p2uK8B2s
	0S5SlvpIE0IAgiy2qNeqr4I5VZZT4o0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-JQXE_8nIOY-3y1mHgNHfUw-1; Mon,
 24 Feb 2025 16:59:29 -0500
X-MC-Unique: JQXE_8nIOY-3y1mHgNHfUw-1
X-Mimecast-MFC-AGG-ID: JQXE_8nIOY-3y1mHgNHfUw_1740434368
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC91419560B9;
	Mon, 24 Feb 2025 21:59:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C092D180035F;
	Mon, 24 Feb 2025 21:59:25 +0000 (UTC)
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
Subject: [PATCH v2 4/4] mm: page_owner: use new iteration API
Date: Mon, 24 Feb 2025 16:59:08 -0500
Message-ID: <badc717329c288c58b7abf7513603aa3042c008c.1740434344.git.luizcap@redhat.com>
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
 mm/page_owner.c | 61 +++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2d6360eaccbb6..c9d2c688eb981 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -229,17 +229,19 @@ static void dec_stack_record_count(depot_stack_handle_t handle,
 			handle);
 }
 
-static inline void __update_page_owner_handle(struct page_ext *page_ext,
+static inline void __update_page_owner_handle(struct page *page,
 					      depot_stack_handle_t handle,
 					      unsigned short order,
 					      gfp_t gfp_mask,
 					      short last_migrate_reason, u64 ts_nsec,
 					      pid_t pid, pid_t tgid, char *comm)
 {
-	int i;
+	struct page_ext_iter iter;
+	struct page_ext *page_ext;
 	struct page_owner *page_owner;
 
-	for (i = 0; i < (1 << order); i++) {
+	rcu_read_lock();
+	for_each_page_ext(page, 1 << order, page_ext, iter) {
 		page_owner = get_page_owner(page_ext);
 		page_owner->handle = handle;
 		page_owner->order = order;
@@ -252,20 +254,22 @@ static inline void __update_page_owner_handle(struct page_ext *page_ext,
 			sizeof(page_owner->comm));
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
-		page_ext = page_ext_next(page_ext);
 	}
+	rcu_read_unlock();
 }
 
-static inline void __update_page_owner_free_handle(struct page_ext *page_ext,
+static inline void __update_page_owner_free_handle(struct page *page,
 						   depot_stack_handle_t handle,
 						   unsigned short order,
 						   pid_t pid, pid_t tgid,
 						   u64 free_ts_nsec)
 {
-	int i;
+	struct page_ext_iter iter;
+	struct page_ext *page_ext;
 	struct page_owner *page_owner;
 
-	for (i = 0; i < (1 << order); i++) {
+	rcu_read_lock();
+	for_each_page_ext(page, 1 << order, page_ext, iter) {
 		page_owner = get_page_owner(page_ext);
 		/* Only __reset_page_owner() wants to clear the bit */
 		if (handle) {
@@ -275,8 +279,8 @@ static inline void __update_page_owner_free_handle(struct page_ext *page_ext,
 		page_owner->free_ts_nsec = free_ts_nsec;
 		page_owner->free_pid = current->pid;
 		page_owner->free_tgid = current->tgid;
-		page_ext = page_ext_next(page_ext);
 	}
+	rcu_read_unlock();
 }
 
 void __reset_page_owner(struct page *page, unsigned short order)
@@ -293,11 +297,11 @@ void __reset_page_owner(struct page *page, unsigned short order)
 
 	page_owner = get_page_owner(page_ext);
 	alloc_handle = page_owner->handle;
+	page_ext_put(page_ext);
 
 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
-	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
+	__update_page_owner_free_handle(page, handle, order, current->pid,
 					current->tgid, free_ts_nsec);
-	page_ext_put(page_ext);
 
 	if (alloc_handle != early_handle)
 		/*
@@ -313,19 +317,13 @@ void __reset_page_owner(struct page *page, unsigned short order)
 noinline void __set_page_owner(struct page *page, unsigned short order,
 					gfp_t gfp_mask)
 {
-	struct page_ext *page_ext;
 	u64 ts_nsec = local_clock();
 	depot_stack_handle_t handle;
 
 	handle = save_stack(gfp_mask);
-
-	page_ext = page_ext_get(page);
-	if (unlikely(!page_ext))
-		return;
-	__update_page_owner_handle(page_ext, handle, order, gfp_mask, -1,
+	__update_page_owner_handle(page, handle, order, gfp_mask, -1,
 				   ts_nsec, current->pid, current->tgid,
 				   current->comm);
-	page_ext_put(page_ext);
 	inc_stack_record_count(handle, gfp_mask, 1 << order);
 }
 
@@ -344,26 +342,24 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
 
 void __split_page_owner(struct page *page, int old_order, int new_order)
 {
-	int i;
-	struct page_ext *page_ext = page_ext_get(page);
+	struct page_ext_iter iter;
+	struct page_ext *page_ext;
 	struct page_owner *page_owner;
 
-	if (unlikely(!page_ext))
-		return;
-
-	for (i = 0; i < (1 << old_order); i++) {
+	rcu_read_lock();
+	for_each_page_ext(page, 1 << old_order, page_ext, iter) {
 		page_owner = get_page_owner(page_ext);
 		page_owner->order = new_order;
-		page_ext = page_ext_next(page_ext);
 	}
-	page_ext_put(page_ext);
+	rcu_read_unlock();
 }
 
 void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 {
-	int i;
 	struct page_ext *old_ext;
 	struct page_ext *new_ext;
+	struct page_ext *page_ext;
+	struct page_ext_iter iter;
 	struct page_owner *old_page_owner;
 	struct page_owner *new_page_owner;
 	depot_stack_handle_t migrate_handle;
@@ -381,7 +377,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	old_page_owner = get_page_owner(old_ext);
 	new_page_owner = get_page_owner(new_ext);
 	migrate_handle = new_page_owner->handle;
-	__update_page_owner_handle(new_ext, old_page_owner->handle,
+	__update_page_owner_handle(&newfolio->page, old_page_owner->handle,
 				   old_page_owner->order, old_page_owner->gfp_mask,
 				   old_page_owner->last_migrate_reason,
 				   old_page_owner->ts_nsec, old_page_owner->pid,
@@ -391,7 +387,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	 * will be freed after migration. Keep them until then as they may be
 	 * useful.
 	 */
-	__update_page_owner_free_handle(new_ext, 0, old_page_owner->order,
+	__update_page_owner_free_handle(&newfolio->page, 0, old_page_owner->order,
 					old_page_owner->free_pid,
 					old_page_owner->free_tgid,
 					old_page_owner->free_ts_nsec);
@@ -400,11 +396,12 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	 * for the new one and the old folio otherwise there will be an imbalance
 	 * when subtracting those pages from the stack.
 	 */
-	for (i = 0; i < (1 << new_page_owner->order); i++) {
+	rcu_read_lock();
+	for_each_page_ext(&old->page, 1 << new_page_owner->order, page_ext, iter) {
+		old_page_owner = get_page_owner(page_ext);
 		old_page_owner->handle = migrate_handle;
-		old_ext = page_ext_next(old_ext);
-		old_page_owner = get_page_owner(old_ext);
 	}
+	rcu_read_unlock();
 
 	page_ext_put(new_ext);
 	page_ext_put(old_ext);
@@ -813,7 +810,7 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 				goto ext_put_continue;
 
 			/* Found early allocated page */
-			__update_page_owner_handle(page_ext, early_handle, 0, 0,
+			__update_page_owner_handle(page, early_handle, 0, 0,
 						   -1, local_clock(), current->pid,
 						   current->tgid, current->comm);
 			count++;
-- 
2.48.1


