Return-Path: <linux-kernel+bounces-293208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F349A957C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCBD2863F6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECC01494A5;
	Tue, 20 Aug 2024 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl7oIWic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3D148FE6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125632; cv=none; b=AeKF0GxyD+njiu+IweKQ5U+CXfB1szLw50FrbenR8D6kn/Q4vhVvynNN2knbYHhEwqkpqcykPgGF4ZrYYUDeI/Omq7E6qp+uw0So44OwhgG+PC5cciuMfMRw8bT5XtILCv8bf1ANNGJDGBuVFXBv2jwhLVzL++9NQ4ZlVe6RtOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125632; c=relaxed/simple;
	bh=Gv9T9VqQEXP+t9GsufY3LhPD+LhHvt38T1omk9U0JGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ftuFVxq5YVF+w/B74hYPVTU0K+2QHS2A6Q4OWuypIu1VVzgV+2ia0NIRM6Ku7mdkCdb2mpCD/IkxIUBV3to/BMPbHxISt3udoK3BQWkYzYI5KtbYx7Vvk6r1/WLJKcnKqnT7aw2RfrVLqIRB/Y9+PYkUv1bzQCVi8cMZycRku3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl7oIWic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEDAC4AF09;
	Tue, 20 Aug 2024 03:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724125632;
	bh=Gv9T9VqQEXP+t9GsufY3LhPD+LhHvt38T1omk9U0JGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bl7oIWicgFEGKNiIE52WCqV2xquS6lZe4NR7/ZrT+7l0Ti9k3hfX5WhXNw/57m+ws
	 PWhUlShTwj0PkbSaaWLoW9vWz82vY4KZmcsUnOluFC83S+DXwD0K07uhALkdpwieBb
	 LOLJR3+f+rt92gEyyzVhRm1bGipkXbjuuyLccvDvtsUyj88tiGInEjk4NBYoijK6eN
	 m5W5UpSPSCNNA1C82IM//XDJfl8uV6bMTFmXzVsObWdE0y3gQPOOkNOzSEjMtycTDp
	 Ue7DlMUhZNx6L2rAjPK/tHNAyVHRs0mS+Ecev4cgdoAuSif0AkmDeMxP2DTlebC/Mi
	 SwEcuFKp13K1A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 5/8] f2fs: convert f2fs_write_data_page() to use folio
Date: Tue, 20 Aug 2024 11:46:51 +0800
Message-Id: <20240820034654.698236-5-chao@kernel.org>
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
 fs/f2fs/data.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c57ddee2c7c5..e69097267b99 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2945,22 +2945,23 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 static int f2fs_write_data_page(struct page *page,
 					struct writeback_control *wbc)
 {
+	struct folio *folio = page_folio(page);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		goto out;
 
 	if (f2fs_compressed_file(inode)) {
-		if (f2fs_is_compressed_cluster(inode, page->index)) {
-			redirty_page_for_writepage(wbc, page);
+		if (f2fs_is_compressed_cluster(inode, folio->index)) {
+			folio_redirty_for_writepage(wbc, folio);
 			return AOP_WRITEPAGE_ACTIVATE;
 		}
 	}
 out:
 #endif
 
-	return f2fs_write_single_data_page(page_folio(page), NULL, NULL, NULL,
+	return f2fs_write_single_data_page(folio, NULL, NULL, NULL,
 						wbc, FS_DATA_IO, 0, true);
 }
 
-- 
2.40.1


