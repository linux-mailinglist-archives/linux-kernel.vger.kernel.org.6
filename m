Return-Path: <linux-kernel+bounces-291319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307D39560D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B392817EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DE022F19;
	Mon, 19 Aug 2024 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDSTLN8B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571101F954
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724030458; cv=none; b=dOm2IZNXmBse4hp0x/GVZz0FqhzIAcH2azfyzzVDamE8d65Q//zrT561ZIcpioP6zZmQeQCk9YJSJtPqgobwFT8kv6jsQ1g5tKSnNiVZC9lNlFSzXrAOQxmuButm1Ri9bNfASG134S0CJ251kP4X++EZCgYzOX0Ww+oZzKUaups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724030458; c=relaxed/simple;
	bh=7JJv4KN9xSbK50goC7fnEuayXM2V2u/CfyhdMECGBOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HfrYsG4KaJtyUFGU6vyt2DagWGzb+BLd5pbN3EtM95xufEfDXP2R/WWY6qnFiyAySclruDj/CI1GX5roWo+1GKL6QCQVScDbSkorVsxRVNQCDNnkzPRF2qZZG77RsUrGcapIf1Zgyy9gNVhAzr7WCAZRhiYuOkignpLvaRMsjIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDSTLN8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38CCC4AF11;
	Mon, 19 Aug 2024 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724030458;
	bh=7JJv4KN9xSbK50goC7fnEuayXM2V2u/CfyhdMECGBOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDSTLN8Bf6nJClcVrX60OF1bPPfs1Ggx/9YQdIxonAzMUd0zyl6KTJLTRtOT/G/Ch
	 7UoZA9KlTuDrY5Ovp17c69RPbQmRwctWYXKKYAiNnl/RgIGQR5RcBYNZXpR/ZQDRc6
	 7qQwV5jzRW67slq1g+dE7xtYcs/h0A61IEjOfoDU2CJtH2ywsjxb0gcih8NH1Q6WxP
	 40CPCS7AxT/pPod4/rnqXfN9ta5CWRmxR9ner5FhtSp7tKsZWgIIP3D2GzNf51erVa
	 I+F6P4dW27rJ/e0kciVmV+MHiHt6IrfsDggFv1/c5s7pbTcu/hhC/YOKbfOB0hzHxy
	 dbUOxc5yLQiZw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/8] f2fs: convert f2fs_set_compressed_page() to use folio
Date: Mon, 19 Aug 2024 09:20:18 +0800
Message-Id: <20240819012023.3871272-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240819012023.3871272-1-chao@kernel.org>
References: <20240819012023.3871272-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 82c31641e696..67bb1e2e07a4 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -90,11 +90,13 @@ bool f2fs_is_compressed_page(struct page *page)
 static void f2fs_set_compressed_page(struct page *page,
 		struct inode *inode, pgoff_t index, void *data)
 {
-	attach_page_private(page, (void *)data);
+	struct folio *folio = page_folio(page);
+
+	folio_attach_private(folio, (void *)data);
 
 	/* i_crypto_info and iv index */
-	page->index = index;
-	page->mapping = inode->i_mapping;
+	folio->index = index;
+	folio->mapping = inode->i_mapping;
 }
 
 static void f2fs_drop_rpages(struct compress_ctx *cc, int len, bool unlock)
-- 
2.40.1


