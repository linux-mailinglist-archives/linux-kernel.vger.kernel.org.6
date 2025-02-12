Return-Path: <linux-kernel+bounces-510374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF44A31BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6AC16840F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C022189F43;
	Wed, 12 Feb 2025 02:21:44 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F433D3B8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326903; cv=none; b=aM/wvxVrujF/8fR13ZUZotQMnbvRUti3k/z/o+kmTIyJ2h82GzLXsEnxMUC/mA0zuXOsIV2PDn8wTiEAHfwfzmTbfWcHZGzpFDKHqrYw0S1M76o4pQ2xN77nUD2T7D/+Ld/vZCxRRmnS23BoOo1JQyxx9fCe+bEfoww6pM3voc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326903; c=relaxed/simple;
	bh=UgwC4QNIm2wYd98Mrn0myQ1ps/3mn0ecSPsnhG0Dywk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nsp9lZg1/X1HmUpWjFNFmdJex8Uvi4cNh2qrbnpM1pR9+ISf3frR5p6K+6JYcf2v70QgbsVfSXwGIA8qJmiuBFOi/tjJ2Hz8NbgnoLgb2dIbgY4GDmF+45HoyXOWnHrq5hdct2QwrjNVn8fZhV2wGGa4huH1v8MvoziKhtw0KHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from walle01-sz.amlogic.com (10.28.11.73) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.39; Wed, 12 Feb 2025
 10:06:32 +0800
From: Shengken Lin <shengken.lin@amlogic.com>
To: <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Shengken Lin
	<shengken.lin@amlogic.com>
Subject: [PATCH] mm: Remove redundant PageMemcgKmem(page) call
Date: Wed, 12 Feb 2025 10:06:27 +0800
Message-ID: <20250212020627.3461237-1-shengken.lin@amlogic.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The function of PageMemcgKmem(page) is the same as that of
folio_memcg_kmem(folio).

Since __memcg_kmem_uncharge_page already uses folio_memcg_kmem to check
if a folio has been uncharged, calling PageMemcgKmem(page) before
__memcg_kmem_uncharge_page is redundant.

Signed-off-by: Shengken Lin <shengken.lin@amlogic.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 579789600a3c..5a76760de495 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1055,7 +1055,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);

-	if (memcg_kmem_online() && PageMemcgKmem(page))
+	if (memcg_kmem_online())
 		__memcg_kmem_uncharge_page(page, order);

 	/*
--
2.34.1


