Return-Path: <linux-kernel+bounces-223924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16668911A83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5254281629
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE8416B72E;
	Fri, 21 Jun 2024 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghaTGi+U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E216C444
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948552; cv=none; b=XgpvVacXVnIx6shTgoFjrWWRNa2rjWLFtMg7HxXRX3PDm6pxb7Ypie8bbItYVk8SfkEdg68bHlDbPTE78zDQyIxlm2703h1MperQaSODJTmun/+5d00D072WBOtzZ8dvy0xqcNuXvFgUDOG9rTsLcLi7gBSjLqSD/jD12isnpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948552; c=relaxed/simple;
	bh=y6KoeLhtvm8xPFObZNaibmIhv/1vXuAoQWjifV7MAf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfWQs9GrkA6z+p9p+QtEn5MXMek4AYZ7WxeQQHxBqYytcBKVZ/EE5ddHpeH1dK3zifRewSxr8+uWZHcuPzGcz4vgnAkP1pf4yTc1U2MeZT2RimOiYbqQDkVVZryMMMDrLW4WCnZQX80s2toxREqnVgW+t9OziKlrcnEdq6IRtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghaTGi+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA2EC4AF0A;
	Fri, 21 Jun 2024 05:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948551;
	bh=y6KoeLhtvm8xPFObZNaibmIhv/1vXuAoQWjifV7MAf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghaTGi+UM7rTyHmBOXsg4g/Q87Fxag1B+8BTmn51DnnCTFVZEYWtdlc1Bq6m3a9OI
	 rQmyMjlhsXeMSLdsf0OBDkZ1iiUBcbohmeGSHet9Zbf7odS2O+5sYO1rxn7TGCFPwB
	 7nWzR442GxYjaomeWTuFa/aYTj8j5EeBGaln1+26V2j470pWPmGx2LJEwONvA9SvRT
	 e0BhQPgYEahIKbmo0CW1nY82aDZg1EpHbZQQ1YQgHfehQwIA20edDZL8ekXeXcPzUa
	 /paqNPM9jXw3gMc1gIQbA8PPVvb3zcgJ6xvaBNXvzos35sn6ju19wMc/BEc7n5v5x5
	 nRmPjpjlYopSQ==
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
Subject: [PATCH 09/15] mm/z3fold: use zpdesc in z3fold_compact_page and do_compact_page
Date: Fri, 21 Jun 2024 13:46:49 +0800
Message-ID: <20240621054658.1220796-10-alexs@kernel.org>
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

The main purpose is converting page->private to zpdesc->zppage_flag too.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 97580e2224c2..3d36448885c9 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -691,12 +691,12 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 /* Has to be called with lock held */
 static int z3fold_compact_page(struct z3fold_header *zhdr)
 {
-	struct page *page = virt_to_page(zhdr);
+	struct zpdesc *zpdesc = page_zpdesc(virt_to_page(zhdr));
 
-	if (test_bit(MIDDLE_CHUNK_MAPPED, &page->private))
+	if (test_bit(MIDDLE_CHUNK_MAPPED, &zpdesc->zppage_flag))
 		return 0; /* can't move middle chunk, it's used */
 
-	if (unlikely(PageIsolated(page)))
+	if (unlikely(PageIsolated(zpdesc_page(zpdesc))))
 		return 0;
 
 	if (zhdr->middle_chunks == 0)
@@ -739,14 +739,13 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
 static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 {
 	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
-	struct page *page;
+	struct zpdesc *zpdesc = page_zpdesc(virt_to_page(zhdr));
 
-	page = virt_to_page(zhdr);
 	if (locked)
 		WARN_ON(z3fold_page_trylock(zhdr));
 	else
 		z3fold_page_lock(zhdr);
-	if (WARN_ON(!test_and_clear_bit(NEEDS_COMPACTING, &page->private))) {
+	if (WARN_ON(!test_and_clear_bit(NEEDS_COMPACTING, &zpdesc->zppage_flag))) {
 		z3fold_page_unlock(zhdr);
 		return;
 	}
@@ -757,8 +756,8 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 	if (put_z3fold_locked(zhdr))
 		return;
 
-	if (test_bit(PAGE_STALE, &page->private) ||
-	    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
+	if (test_bit(PAGE_STALE, &zpdesc->zppage_flag) ||
+	    test_and_set_bit(PAGE_CLAIMED, &zpdesc->zppage_flag)) {
 		z3fold_page_unlock(zhdr);
 		return;
 	}
@@ -766,7 +765,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 	if (!zhdr->foreign_handles && buddy_single(zhdr) &&
 	    zhdr->mapped_count == 0 && compact_single_buddy(zhdr)) {
 		if (!put_z3fold_locked(zhdr)) {
-			clear_bit(PAGE_CLAIMED, &page->private);
+			clear_bit(PAGE_CLAIMED, &zpdesc->zppage_flag);
 			z3fold_page_unlock(zhdr);
 		}
 		return;
@@ -774,7 +773,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 
 	z3fold_compact_page(zhdr);
 	add_to_unbuddied(pool, zhdr);
-	clear_bit(PAGE_CLAIMED, &page->private);
+	clear_bit(PAGE_CLAIMED, &zpdesc->zppage_flag);
 	z3fold_page_unlock(zhdr);
 }
 
-- 
2.43.0


