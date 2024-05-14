Return-Path: <linux-kernel+bounces-178359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 660978C4C84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F1C282428
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A853BF9F5;
	Tue, 14 May 2024 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jr1O09Av"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27597AD31
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715670012; cv=none; b=mQjBGCM1XMPxCmTW5zLZ18Z9sOJVP3DF5ipfZLFjmMfEyT71NosXcy++K0FEw0loqi0NLvoLlpDKougVvoLoRWJIsNlkMFWysQ8WmvWbnwD9h1W4021xRnos+gud+hTtu0uZLZIN8mqyLgDLroyEZMc71P++Rzqyjsm1Rks3k5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715670012; c=relaxed/simple;
	bh=Fr1k8FCX8AQDOA16hofIxkjmqYHc90QA46DYS6nQbjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r6XZwwobR86DygQlT8llAzHewiLKEyNXhhH2mg0N58VQBxh54tH/8HZvNeqzL78vu91ehjrR5ZRwcXvoZwfKKqZyE1vq+vmWGZSBVlcNX0tDDarUBDfrKTqT+gLSfrP/sCDWGvrgpQUqOE4r0IlqMeL8KYwXVYra3taNCM2EwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jr1O09Av; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715670004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GuMB+wcCP156JnQ5VQJFiYAVGQR5x6RhBdouNcVSTSA=;
	b=Jr1O09AvAPD6UyTKl8bsftFt7gGDU4ozIL0ch7vr4uDZaxxseqfppwgKLqdgWEekI+10Aj
	GDPQmfgQykdWsimeN0XdSGhpkoNzOa7KLYlsOj9YKY1p289hhryhT6IBTuKt2NAKk6ckRr
	mQAtzerY6ehi6Y6+0OEcbwpK7loX8L4=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	vbabka@suse.cz
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm: page_alloc: fix the incorrect parameter
Date: Tue, 14 May 2024 14:59:33 +0800
Message-Id: <20240514065933.1523170-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The first parameter passed to set_pageblock_migratetype should be the
buddy, not the page. Let's change it back correctly.

Fixes: fd919a85cd55 ("mm: page_isolation: prepare for hygienic freelists")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cd584aace6bf..5422f6f8975d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1728,7 +1728,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
-		set_pageblock_migratetype(page, migratetype);
+		set_pageblock_migratetype(buddy, migratetype);
 		split_large_buddy(zone, buddy, pfn, order);
 		return true;
 	}
-- 
2.25.1


