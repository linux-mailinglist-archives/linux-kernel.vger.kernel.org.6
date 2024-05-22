Return-Path: <linux-kernel+bounces-186247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798658CC1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3056C1F23FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903513E038;
	Wed, 22 May 2024 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBubBgGh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC7823B5
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382644; cv=none; b=iMhmNLUf6v2PdliJUhNz6Jo+5sqxQ74p2QTnMoSE3bjofI9f6n3vfjoDtOUojGCHAUEFcN7bfluqUpruhPfIQnzi8QvywqybI5b0XglrkPB5W17qc2aFbt2YAGL0hL8nHGjfvJCAod04PFeqADz5e+jReqr2BytAykreXhDDOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382644; c=relaxed/simple;
	bh=bA0s7EecaF7la6hYVu8pE+N0G/qaj4dmjE+cTiBRqD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVeJ8bLcyrv7587PEs3yicjZ/ug7LVhsxwD/0t+DmsWDzcOJCDvRT7Q3kSX0vBJdooSKXO7jetJADp7ng2t5GbqGUiB9LCoT7uoEE0kmR9sjsJsvOEKT91VvqGYsYjlklSe5MOAtmApt3RwVzkxl1KaFeGsGUuqwuupnSz5/h0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBubBgGh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716382641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dtAZKM4MiVSYLDB4Q4XKxWFHe1658DI6+IaEJTZmd0=;
	b=DBubBgGhln9CUy8Eimv2Iuda+Oe39DoVvoBl+iTBGXqd2fe6Zj6e2DuXpMXNcg5zrBnsgR
	ZjzzlPZzkgMXhjwqUQJGUUaHsyDs5olRCdVhY1sMLnOX4IMl0u4Z5stgyHN0RMU6pGHYW3
	UIAYwH7dxTlK8UuXEMuXtJ43pn5vsFI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-xc9_3YTpP6ObsEwyO8otuw-1; Wed, 22 May 2024 08:57:17 -0400
X-MC-Unique: xc9_3YTpP6ObsEwyO8otuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B83DF8058D5;
	Wed, 22 May 2024 12:57:16 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 93E1040C6CB6;
	Wed, 22 May 2024 12:57:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 1/3] mm/memory: move page_count() check into validate_page_before_insert()
Date: Wed, 22 May 2024 14:57:11 +0200
Message-ID: <20240522125713.775114-2-david@redhat.com>
In-Reply-To: <20240522125713.775114-1-david@redhat.com>
References: <20240522125713.775114-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

We'll now also cover the case where insert_page() is called from
__vm_insert_mixed(), which sounds like the right thing to do.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b5453b86ec4b..a3aad7e58914 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1987,6 +1987,8 @@ static int validate_page_before_insert(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
+	if (!folio_ref_count(folio))
+		return -EINVAL;
 	if (folio_test_anon(folio) || folio_test_slab(folio) ||
 	    page_has_type(page))
 		return -EINVAL;
@@ -2041,8 +2043,6 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 {
 	int err;
 
-	if (!page_count(page))
-		return -EINVAL;
 	err = validate_page_before_insert(page);
 	if (err)
 		return err;
@@ -2176,8 +2176,6 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 {
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return -EFAULT;
-	if (!page_count(page))
-		return -EINVAL;
 	if (!(vma->vm_flags & VM_MIXEDMAP)) {
 		BUG_ON(mmap_read_trylock(vma->vm_mm));
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
-- 
2.45.0


