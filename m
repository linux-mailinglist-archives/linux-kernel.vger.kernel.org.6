Return-Path: <linux-kernel+bounces-238814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59D9250E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB321F21156
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DA9142648;
	Wed,  3 Jul 2024 04:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssU8oOZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77131142625
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979299; cv=none; b=LGcmVfH/u7VaNd3K9Z9nN5vgOX28oH136jxpMv2cFkWKcekC8LjG/JocdKZMD6YlM3YytVfrhTtDu8ceJa1nJkb58BqKNE864zBLP5lWMUSTK/eSsaDDEhzC9mloniwbjX4Vd3MZlCw8+Bme/ikrHydjQtTWJZ9qXJ8wqMY/Rug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979299; c=relaxed/simple;
	bh=hCA+Wp2koQFPErK04B2puEI5lWDR1Rh4V60AMISo3bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b15v7B7ButIqces3ZSeSzbX2DT3D0vrrO9gGtjBufr6+sYjVII4OTEDCg/MkAR0IzSmVty1kS3udmGt+j8zkqsN+UdCtj5eLmAfDZltAS48jNhKwNo7Jz2qIPXWd8sRysgzWoGgMCAPtqPXFEMWX3ThOBWTEULi9dNX6/41LqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssU8oOZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED24BC32781;
	Wed,  3 Jul 2024 04:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719979299;
	bh=hCA+Wp2koQFPErK04B2puEI5lWDR1Rh4V60AMISo3bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssU8oOZS8VnZ5kjtvdEP4lDcKyV/8A6M1yM0c3F1KIS8eUI6cNiQvdY87Bb6YlG1V
	 9b2Qoy4jCAjauQk9G45OXT/p5dW+Jpq9PeP5AI1GVkm+G5B19918JQ/pLqfAPCXsWg
	 c93b4mZRWvKhOEAtTHlXnN8MLEBdsiyswP0TRu5NP202rpZDdQ7/eOVWygU8xreES0
	 uL4HDJpE4IYOajppi6Nr4yiyTp5ZzDwOjGh6ADzC54ITody68TXzrudEUTH1gWDv3i
	 UwlI4ku7/0UD8QVHuSqhSnWNpJFCsL4RazQOmUsYJCjQWblxy1h9oW+ERZ86wiRePZ
	 AzhbrwkhjIkLg==
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
	42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v2 08/20] mm/zsmalloc: convert init_zspage() to use zpdesc
Date: Wed,  3 Jul 2024 12:05:58 +0800
Message-ID: <20240703040613.681396-9-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703040613.681396-1-alexs@kernel.org>
References: <20240703040613.681396-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Replace get_first/next_page func series and kmap_atomic to new helper,
no functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 29b9fa5baa46..d3558f3f8bc3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -948,16 +948,16 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 {
 	unsigned int freeobj = 1;
 	unsigned long off = 0;
-	struct page *page = get_first_page(zspage);
+	struct zpdesc *zpdesc = get_first_zpdesc(zspage);
 
-	while (page) {
-		struct page *next_page;
+	while (zpdesc) {
+		struct zpdesc *next_zpdesc;
 		struct link_free *link;
 		void *vaddr;
 
-		set_first_obj_offset(page, off);
+		set_first_obj_offset(zpdesc_page(zpdesc), off);
 
-		vaddr = kmap_atomic(page);
+		vaddr = zpdesc_kmap_atomic(zpdesc);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
 
 		while ((off += class->size) < PAGE_SIZE) {
@@ -970,8 +970,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		 * page, which must point to the first object on the next
 		 * page (if present)
 		 */
-		next_page = get_next_page(page);
-		if (next_page) {
+		next_zpdesc = get_next_zpdesc(zpdesc);
+		if (next_zpdesc) {
 			link->next = freeobj++ << OBJ_TAG_BITS;
 		} else {
 			/*
@@ -981,7 +981,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 			link->next = -1UL << OBJ_TAG_BITS;
 		}
 		kunmap_atomic(vaddr);
-		page = next_page;
+		zpdesc = next_zpdesc;
 		off %= PAGE_SIZE;
 	}
 
-- 
2.43.0


