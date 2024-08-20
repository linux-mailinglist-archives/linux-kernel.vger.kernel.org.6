Return-Path: <linux-kernel+bounces-293206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0958957C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C898285B59
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1313A86A;
	Tue, 20 Aug 2024 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EufZ7fid"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A36A039
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125628; cv=none; b=nXSbz7oKs+3ETo87wr2905rl/Slq3hKfN0ZS2yVDBVmkFZ1243qGGaXUApzVnzthKG/GvdmsTm197xGCgz0reDv0Bh/kC17Y/Qytd+mMcwGkNiBCNN+Hrli/uAs+I/8nwzq1xZCxnAT/tB3PVJFoIxQvGGfccTTbJx6na2R8uXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125628; c=relaxed/simple;
	bh=7JJv4KN9xSbK50goC7fnEuayXM2V2u/CfyhdMECGBOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAIHDfy0YDCpEalLmEVzhdEU/RJNiLzNTrpZjV/Hlb79XmPGlZPJfAKmn0Q11d7xTzoWd8pM+TFad+XJ0mNpJAYpihdGDQpSH4X3/tREpmYZg5JQ/0Y6+4uLYmsdenqhka1X4/Wl5c+n+MXvFdauomwgROMQoJLBZtjwmDHlImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EufZ7fid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4FEC4AF0C;
	Tue, 20 Aug 2024 03:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724125628;
	bh=7JJv4KN9xSbK50goC7fnEuayXM2V2u/CfyhdMECGBOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EufZ7fid6iK5WZ0mY5vev5+v9YjCzqJ7/tbDQ2aRbfmnviIuxm5LjcYRhpcYSf+39
	 9ppD9U2cI3wYMNsQd64WOJD2HnPHzXbKaRVaMgKNa2OM3aJmJM1nRsVKuPV9BAZTTX
	 t0zy/kxs9BhCsjbM7qlTAzKKEQgx/FnalQIP8+gdGyqR9yngo9I9VxdLB05HtmOVg0
	 lSqeI4r0UBHSeoIyu8GxAvmrfF+AZ0lHfR9kqjymU0uIbq/ng32cxPZG3zFsG64Vct
	 Tg2GI11CbPYBZsZV+smUi5oiMOVXq3+QZP+U2GWrkruCdI2a+xTE8iE5PdAn6IUUgN
	 hyfAsPTomRFLw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 3/8] f2fs: convert f2fs_set_compressed_page() to use folio
Date: Tue, 20 Aug 2024 11:46:49 +0800
Message-Id: <20240820034654.698236-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820034654.698236-1-chao@kernel.org>
References: <20240820034654.698236-1-chao@kernel.org>
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


