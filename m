Return-Path: <linux-kernel+bounces-294174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D40958A49
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B3F1F2314B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866C5192B99;
	Tue, 20 Aug 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2ry5UY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3E192B77
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165722; cv=none; b=FZ45k5F1ogMNNmBPUc9YdVZN+uoBT665EO2OsrNvwnrzhcni60dK9EBN4Q1uDMXa7u/PzUauILJnsIsIh4QvWfC7fBmwlBQcqrT8vSVaRV5mJELeZzG72vCEnXzr0ufEGiLiV8q+eEmn0GFmbRzac/zr288vlEkJlKCnNRCRGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165722; c=relaxed/simple;
	bh=7JJv4KN9xSbK50goC7fnEuayXM2V2u/CfyhdMECGBOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNUUJukSmxTIzetSw1gxURs31QAuZH9zRbL4zLt1l1knUePtZM9ynGEWqzrzxf5+CcwxzIeP4u3nrRrj/LyXQQtI7b/SBHVOG1OAnEQtjR/Ya+qRq0j9Y6gVcv1NDt/jD88GGhgWou7AlE0cXao4L6+mCo8LSb8uq95o0usAgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2ry5UY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF5FC4AF10;
	Tue, 20 Aug 2024 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165722;
	bh=7JJv4KN9xSbK50goC7fnEuayXM2V2u/CfyhdMECGBOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2ry5UY561F4StWJhGVD2VhhyoyqS63hJ9KOFASUCRg3J45saor81xAyXqdmymw65
	 R6jd6s9b0mYDKHfQz7MR7oUX6j/mju1mSDaMqIWIG6gmyWqehKKn8c1t0O8i00AldR
	 3YSdEky64e03TyGcm+AUqAWDdLV/x+AXTDESNCgf2vLhMYeNVPziyixgpPCpm1LIyz
	 ou9AHqgjp1Jni34cVnEyUays8ULOaWHE1qa/yxE+B/mWyXRKagAEZUbmpKW3fZGuJO
	 rM48FzzRK9OxtUXMzzzG5hjK1BKHpzy5YQXHhN860JrNNiyLdkz9V5TQM66fanQnLr
	 NJ1yeGQ59hCKw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 4/9] f2fs: convert f2fs_set_compressed_page() to use folio
Date: Tue, 20 Aug 2024 22:55:02 +0800
Message-Id: <20240820145507.1372905-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820145507.1372905-1-chao@kernel.org>
References: <20240820145507.1372905-1-chao@kernel.org>
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


