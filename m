Return-Path: <linux-kernel+bounces-223917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69067911A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DCD1C2198C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EDF14D2AC;
	Fri, 21 Jun 2024 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFwfQUXj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25713CFB8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948531; cv=none; b=XR466pUzHkM/83DWg81157AQZLJS5CN5sG+m71lnLvjQj0c1IeK0HAodYrrTX0c63NV8DkKtN/Yh70a1q5pYigziUgIAyFtXJPeCqnRJz0CPUebG/ManxsO42lF3zhXoBiXBd8QoEZFj4ZEGBYNWhTK3GY4hvWUCmnHs+mRnjXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948531; c=relaxed/simple;
	bh=lFp9hPza5pPU6dl5Bp6oDNXPAe1FxKDcyrPF29XpEYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKq+mzpv3GQpwkbO2nGIe+B0t7qAmusI6Q6nHG/RjcipJ4nzWNB+qblu1OB/sRCutC5tJAJH89lOQfkIoBMtDMVT6R7djyQqYx9Yy6XqkNZsp+Ai9nzeJq95HWqqIj4CRGP8P8kQHYkDDVCBs62zq2FmMU+RneW1CHzCBwRkgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFwfQUXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15D1C4AF07;
	Fri, 21 Jun 2024 05:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948530;
	bh=lFp9hPza5pPU6dl5Bp6oDNXPAe1FxKDcyrPF29XpEYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFwfQUXjaoVLS24SUVu4YvOrADDzlqMCpnmBV2Rt9lcarvqJAYcoeVvBBvZyEFcSG
	 KGp68SU8RbPtBYJ0klurNhr77ppUHrZZJoq6fEbsZSRQ46nP4EpcSXTNWC0Zj4P8jv
	 7VnR4u6r0N7uF+UzuFsJGa4F019JtVvNXMbiibkCiDuyt+A3TtkgePnKr8f8sbXfea
	 79oztsDbLI2MuKg2Bmquh568/GbNejiYViESoUfL7kBDMZTEpPDLSwh6n7xrYyYJPr
	 qovChvVpaBRXEMqycHMZRrIDiyieHrI5RQLwOEPxF45O2eupXrulXqajYm/UeTflAW
	 2vOA+yRTrYNNA==
From: alexs@kernel.org
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	willy@infradead.org,
	senozhatsky@chromium.org,
	david@redhat.com,
	42.hyeyoo@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 02/15] mm/z3fold: use zpdesc in z3fold_page_migrate
Date: Fri, 21 Jun 2024 13:46:42 +0800
Message-ID: <20240621054658.1220796-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621054658.1220796-1-alexs@kernel.org>
References: <20240621054658.1220796-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Convert page to zpdesc in z3fold_page_migrate. And introduce
zpdesc_get/put base on folio_get/put helpers, since z3fold only
deal with single pages.

This patch could save about 12Kbytes.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 30 ++++++++++++++++--------------
 mm/zpdesc.h | 10 ++++++++++
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index b1229c0520f1..b7f86c1b57a3 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1290,18 +1290,20 @@ static int z3fold_page_migrate(struct page *newpage, struct page *page,
 {
 	struct z3fold_header *zhdr, *new_zhdr;
 	struct z3fold_pool *pool;
+	struct zpdesc *zpdesc = page_zpdesc(page);
+	struct zpdesc *newzpdesc = page_zpdesc(newpage);
 
-	VM_BUG_ON_PAGE(!PageIsolated(page), page);
-	VM_BUG_ON_PAGE(!test_bit(PAGE_CLAIMED, &page->private), page);
-	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
+	VM_BUG_ON_PAGE(!PageIsolated(zpdesc_page(zpdesc)), zpdesc_page(zpdesc));
+	VM_BUG_ON_PAGE(!test_bit(PAGE_CLAIMED, &zpdesc->zppage_flag), zpdesc_page(zpdesc));
+	VM_BUG_ON_PAGE(!PageLocked(zpdesc_page(newzpdesc)), zpdesc_page(newzpdesc));
 
-	zhdr = page_address(page);
+	zhdr = zpdesc_address(zpdesc);
 	pool = zhdr_to_pool(zhdr);
 
 	if (!z3fold_page_trylock(zhdr))
 		return -EAGAIN;
 	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0) {
-		clear_bit(PAGE_CLAIMED, &page->private);
+		clear_bit(PAGE_CLAIMED, &zpdesc->zppage_flag);
 		z3fold_page_unlock(zhdr);
 		return -EBUSY;
 	}
@@ -1309,10 +1311,10 @@ static int z3fold_page_migrate(struct page *newpage, struct page *page,
 		z3fold_page_unlock(zhdr);
 		return -EAGAIN;
 	}
-	new_zhdr = page_address(newpage);
+	new_zhdr = zpdesc_address(newzpdesc);
 	memcpy(new_zhdr, zhdr, PAGE_SIZE);
-	newpage->private = page->private;
-	set_bit(PAGE_MIGRATED, &page->private);
+	newzpdesc->zppage_flag = zpdesc->zppage_flag;
+	set_bit(PAGE_MIGRATED, &zpdesc->zppage_flag);
 	z3fold_page_unlock(zhdr);
 	spin_lock_init(&new_zhdr->page_lock);
 	INIT_WORK(&new_zhdr->work, compact_page_work);
@@ -1321,9 +1323,9 @@ static int z3fold_page_migrate(struct page *newpage, struct page *page,
 	 * so we only have to reinitialize it.
 	 */
 	INIT_LIST_HEAD(&new_zhdr->buddy);
-	__ClearPageMovable(page);
+	__ClearPageMovable(zpdesc_page(zpdesc));
 
-	get_page(newpage);
+	zpdesc_get(newzpdesc);
 	z3fold_page_lock(new_zhdr);
 	if (new_zhdr->first_chunks)
 		encode_handle(new_zhdr, FIRST);
@@ -1331,16 +1333,16 @@ static int z3fold_page_migrate(struct page *newpage, struct page *page,
 		encode_handle(new_zhdr, LAST);
 	if (new_zhdr->middle_chunks)
 		encode_handle(new_zhdr, MIDDLE);
-	set_bit(NEEDS_COMPACTING, &newpage->private);
+	set_bit(NEEDS_COMPACTING, &newzpdesc->zppage_flag);
 	new_zhdr->cpu = smp_processor_id();
-	__SetPageMovable(newpage, &z3fold_mops);
+	__SetPageMovable(zpdesc_page(newzpdesc), &z3fold_mops);
 	z3fold_page_unlock(new_zhdr);
 
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
 
 	/* PAGE_CLAIMED and PAGE_MIGRATED are cleared now. */
-	page->private = 0;
-	put_page(page);
+	zpdesc->zppage_flag = 0;
+	zpdesc_put(zpdesc);
 	return 0;
 }
 
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index d51785863596..7fde29645331 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -48,4 +48,14 @@ static inline void *zpdesc_address(const struct zpdesc *zpdesc)
 	return folio_address(zpdesc_folio(zpdesc));
 }
 
+static inline void zpdesc_get(struct zpdesc *zpdesc)
+{
+	folio_get(zpdesc_folio(zpdesc));
+}
+
+static inline void zpdesc_put(struct zpdesc *zpdesc)
+{
+	folio_put(zpdesc_folio(zpdesc));
+}
+
 #endif
-- 
2.43.0


