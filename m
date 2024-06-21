Return-Path: <linux-kernel+bounces-223919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6CC911A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB93C1C21FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F9F167DB1;
	Fri, 21 Jun 2024 05:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egYyPlAu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768616727F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948536; cv=none; b=AUV/BQ/ogk8ZCl51qkdNDVb5vdICFleVCAiDfnvDno0DKDR+D3129QZmbBiMhnpl6VMT6vD3srp2Zf1YOs4DmzmvsHvSePYLBp4TXd2bVfmiuKCFQAtJcCwDZRRnNC9TNEUDApKoXDbu7MLPd1/1aTGMiiJRJtWdsaf34VCapE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948536; c=relaxed/simple;
	bh=qXj63AgP40NUpl4XlwRzrIm8KuNAVcRpUKRIp23PaNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfgAMXefj4733Fqwi3VMxxebydmI6HxU3ohv+BmINLHxRDyF5rCWElJUnW0Zcj/dR7yQcrZtYe2dEJl6iCxDM3Rsn+Z8E2OC9RRf6O1/slMDvxtWYwWcfbSveUlZeDLatyEPfebQkX7yVAFt/NlUm7aUUQQHBZ/bTfJjAqcdNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egYyPlAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DE5C4AF0C;
	Fri, 21 Jun 2024 05:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948536;
	bh=qXj63AgP40NUpl4XlwRzrIm8KuNAVcRpUKRIp23PaNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egYyPlAu2juH8SLzVU+rYnNIQS1jHZS8wx2DLqMXQyz3DVD45Y0KyAZE+CzBDrV3J
	 bwGHV0nFL+UoZwbljfBrDLCxvQVfsP8kxb3DOscMi+QicjSb6hN4Sbsh5mjGQjQPlC
	 IGbnFyZdDdnFh7j+9fKhGIL6PRo2weH7KoUYwkE2E2yS4qkG5EInsDTDLngIyrIhNZ
	 agfViVHiyJfvSZhd15I14UKzVJa8mcs7JrIdj36iq1chQ8uZKYJj97w2Kw3k/2GzJ0
	 FDnQOknl6afuuRG4a+UsSji+sd8oWb+N4YgVkRCYbRo53xU4iI4+0RIBUR8SSXfBkQ
	 oOwZQ+7+xJkXw==
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
Subject: [PATCH 04/15] mm/z3fold: use zpdesc in get/put_z3fold_header funcs
Date: Fri, 21 Jun 2024 13:46:44 +0800
Message-ID: <20240621054658.1220796-5-alexs@kernel.org>
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

Convert the get/put_z3fold_header funcs pair to use zpdesc.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 5cb156fc03be..bfbc9f9fdfd4 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -254,9 +254,9 @@ static inline struct z3fold_header *get_z3fold_header(unsigned long handle)
 			locked = z3fold_page_trylock(zhdr);
 			read_unlock(&slots->lock);
 			if (locked) {
-				struct page *page = virt_to_page(zhdr);
+				struct zpdesc *zpdesc = page_zpdesc(virt_to_page(zhdr));
 
-				if (!test_bit(PAGE_MIGRATED, &page->private))
+				if (!test_bit(PAGE_MIGRATED, &zpdesc->zppage_flag))
 					break;
 				z3fold_page_unlock(zhdr);
 			}
@@ -271,9 +271,9 @@ static inline struct z3fold_header *get_z3fold_header(unsigned long handle)
 
 static inline void put_z3fold_header(struct z3fold_header *zhdr)
 {
-	struct page *page = virt_to_page(zhdr);
+	struct zpdesc *zpdesc = page_zpdesc(virt_to_page(zhdr));
 
-	if (!test_bit(PAGE_HEADLESS, &page->private))
+	if (!test_bit(PAGE_HEADLESS, &zpdesc->zppage_flag))
 		z3fold_page_unlock(zhdr);
 }
 
-- 
2.43.0


