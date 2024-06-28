Return-Path: <linux-kernel+bounces-233301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3503391B548
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1662811EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA023771C;
	Fri, 28 Jun 2024 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aECRD5kR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9534545
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544061; cv=none; b=DqNoL4EmpoZazNUSRNogEliAG7ca+Gnp0JKJWuKfPNXhcfX3Z5RNwk1L6rtJ7a0B8YpiiWBaGFMcCKmjxZJxXl7fkK1pW0MZIopQdIID9vWVTzh7CsfC3rsSSrP+w/BIP0flAmMsoqvBB0M7e1tKSezZqxSDbe0TGwT7FdhtPzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544061; c=relaxed/simple;
	bh=6AxrbjsULXI2U/XKKk6mycuO4iJeWrzhsSGBcy6kdOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCuqqxPEXe01gOeVGJC/W4JdoSH7KRSz1bzh5hzeA5XiDv1F7wRH2+cXpWr0ErF17aQrRMsMtwJPtivquZfDgeCEDvlVo+bG6hoTL+YvipmuV2DqUjjnmZFeBJKE/dkqnkhBaLnniitVHFQh3wzM1z1NcV89U7TdPxKsNunmafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aECRD5kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B02C32789;
	Fri, 28 Jun 2024 03:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544060;
	bh=6AxrbjsULXI2U/XKKk6mycuO4iJeWrzhsSGBcy6kdOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aECRD5kR9xoAvSpndBIFlgKo2JqqxBip4pTFrYHYczi9pt2fEs0YDBL3FL9ihGLPN
	 dglkNp8v2wVgW4fRUFamWff3pQLICuo6u4rcQytZJhWVKePCQKo2Z1pc4Keqr24Min
	 kCxKz85MfgScoKYa8Jmkhm5LUaoIo6ll2NeyVgC8MU1CIjZATofW4L/z07K/VsOoNp
	 Hg0xPuVEK8REdGAmwy7pa3YxAZ/RfCoVSfYm+87q30iT1p6LByqLPnnSQGNB3DHnmn
	 L5Ph4XaeiMvUxy/hGgtGom2xh/BcTHyMdCpa9KAncBtu+ct1oNvBGLFPyrramw0rrJ
	 Gi41UA6Yh6veA==
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
Subject: [PATCH 14/20] mm/zsmalloc: convert migrate_zspage() to use zpdesc
Date: Fri, 28 Jun 2024 11:11:29 +0800
Message-ID: <20240628031138.429622-15-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628031138.429622-1-alexs@kernel.org>
References: <20240628031138.429622-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Use get_first_zpdesc/get_next_zpdesc to replace get_first/next_page. No
functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e8af01768ae0..a10af49d8d08 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1640,14 +1640,14 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 	unsigned long used_obj, free_obj;
 	unsigned long handle;
 	int obj_idx = 0;
-	struct page *s_page = get_first_page(src_zspage);
+	struct zpdesc *s_zpdesc = get_first_zpdesc(src_zspage);
 	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
-		handle = find_alloced_obj(class, page_zpdesc(s_page), &obj_idx);
+		handle = find_alloced_obj(class, s_zpdesc, &obj_idx);
 		if (!handle) {
-			s_page = get_next_page(s_page);
-			if (!s_page)
+			s_zpdesc = get_next_zpdesc(s_zpdesc);
+			if (!s_zpdesc)
 				break;
 			obj_idx = 0;
 			continue;
-- 
2.43.0


