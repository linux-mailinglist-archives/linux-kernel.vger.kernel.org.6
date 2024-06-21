Return-Path: <linux-kernel+bounces-223918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA3911A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FF91C21E32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDB715664C;
	Fri, 21 Jun 2024 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8XjtS0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71D155A52
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948534; cv=none; b=dDILCgnO2c5nJIjPJ19259XgFErGoar0hvPIyj4ZaGb3VeK3rrQq8prGyMRq5pq/8Bol5ixJ0IQ6m/72MC3Zoq/FE5K5yBNk3rsXnylhgjXh4xtYXhU4LRcl7b41qh5LGo8Ahx4KXgjgYxvpQiGf5r1R6tnw6BtN7kqZ7WGmhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948534; c=relaxed/simple;
	bh=dd2siZgce72Js9rHx7j82fOPcgkDkcIWKh0L5w1zff0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIgZx9vUUwApT3uxB3UbGgufnXWfaMo11JJWsNSxLbPJdr7059A0FouUttOFUokMP3AAqSjS9GamqE4VflDTHz0Q+0AqfvgLJ+UMocU4Z1O1VMdf4+2NTm4wOURuYYfkJA71mTEoJ3bWzaN/yOEERQWSJz4KexPazuwoL09e8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8XjtS0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A606C4AF0A;
	Fri, 21 Jun 2024 05:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948533;
	bh=dd2siZgce72Js9rHx7j82fOPcgkDkcIWKh0L5w1zff0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8XjtS0m/7b+Fl85MJhkqBpvIGisLhL2bxGmCQxv2/ny81+Fq+AeD8U9d5RFc0ya4
	 S2TcuJm+gq+e9lJNLM8l9DgeOhGkYTTLL+S174+ntE4pAv6fK6kU3ELimUhyYCzSzo
	 ZCIG+yI3q4l/Mu7uLRo8kAeYWwWUCZBqfvyC+i791Um2NAbykq+FsKHkvzxo/JY3bU
	 62T0zsgRdnWgftCddh08lv2ApsH/JcLvdqoZBzbWQHvrZDRSdjjWFJypgPs+95Altm
	 ASoDaRp5K5LT9x51YgLFcUZ3D4Hks6T5n0LWikFXdOKm74gG9w+rt71Qb2vmxRA3PL
	 hTWBId8cGCb0w==
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
Subject: [PATCH 03/15] mm/z3fold: use zpdesc in z3fold_page_putback
Date: Fri, 21 Jun 2024 13:46:43 +0800
Message-ID: <20240621054658.1220796-4-alexs@kernel.org>
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

Convert page to zpdesc in z3fold_page_putback function, and keep the
'page' parameter since the function hooks to page_putback, which is used
by other users.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index b7f86c1b57a3..5cb156fc03be 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1350,8 +1350,9 @@ static void z3fold_page_putback(struct page *page)
 {
 	struct z3fold_header *zhdr;
 	struct z3fold_pool *pool;
+	struct zpdesc *zpdesc = page_zpdesc(page);
 
-	zhdr = page_address(page);
+	zhdr = zpdesc_address(zpdesc);
 	pool = zhdr_to_pool(zhdr);
 
 	z3fold_page_lock(zhdr);
@@ -1362,7 +1363,7 @@ static void z3fold_page_putback(struct page *page)
 		return;
 	if (list_empty(&zhdr->buddy))
 		add_to_unbuddied(pool, zhdr);
-	clear_bit(PAGE_CLAIMED, &page->private);
+	clear_bit(PAGE_CLAIMED, &zpdesc->zppage_flag);
 	z3fold_page_unlock(zhdr);
 }
 
-- 
2.43.0


