Return-Path: <linux-kernel+bounces-293205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F2F957C00
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A812857DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF654963C;
	Tue, 20 Aug 2024 03:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCFZbc5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B141C71
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125626; cv=none; b=CVWlE99r4ER3tZnL+uGEvb4mZTSraXOiAyWzpXhhja7i80LjafWccswOmxQLBgMcWaKA7M2IdpGDPtK9YD7Ptner2AXKI3AElJmmLjcS2IhgVOrKproGDuhhFtzCQQzRtZTdhV+DHysS5O5L22RvsKrUy3apNOCDJV3N3o8i+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125626; c=relaxed/simple;
	bh=/xnmcfediMlfnoUVnmuzbvo1S4c7hWPIg/RHrVMxn+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mNf3LA3t2i3oI1dvsyg1TE+CZd1+s0qXK5dmoor/Fy6+UvO9xROOSof6IZ3+SGM1wtIJB0qr3DnMAHr5avEJiIeQaarpeVuKp73DtryX8s6xzEnwd5CwwJjjRamaUO7yXaIoIApIkkcrfDq6jhgqsU4rSghQTgjROOVEOMFuPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCFZbc5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04647C4AF10;
	Tue, 20 Aug 2024 03:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724125626;
	bh=/xnmcfediMlfnoUVnmuzbvo1S4c7hWPIg/RHrVMxn+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCFZbc5AbaUpaNwC+ljQqt6ePtYw8+HcBnq7MqOSx4BbLTQ2uxDSZMvMCVkTgeku9
	 Pb07QZqIWBfrYkZT+mNd8bRQ+jO3Lcz+1FG9L7RVur1bPCQ5Ysl1FmfQhRwyrlaAqc
	 ec0hCn7AC6/fL27ZlRTvhZWrJErJVAnMemjuv8WXUwkS/wMi1wvQSPEELsBAaVhL9N
	 s2C6roVhXGZQG2MfI/SFG00zlRQCRqEJqgK8FyXBKBdCkDIeE0tq0ocTT1QRfLmmUU
	 7I6uaESCzHfdJwxJ0pN/dP5inywV0aCt26rzDbYaXz33jA/mNeVa61RUyIoa4cSHkm
	 T4YCTeup2NQ+w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 2/8] f2fs: convert f2fs_write_end() to use folio
Date: Tue, 20 Aug 2024 11:46:48 +0800
Message-Id: <20240820034654.698236-2-chao@kernel.org>
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
v2:
- fix compile error.
 fs/f2fs/data.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 85ac05c3655a..e114d738b6b4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3698,7 +3698,8 @@ static int f2fs_write_end(struct file *file,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 
 	trace_f2fs_write_end(inode, pos, len, copied);
 
@@ -3707,17 +3708,17 @@ static int f2fs_write_end(struct file *file,
 	 * should be PAGE_SIZE. Otherwise, we treat it with zero copied and
 	 * let generic_perform_write() try to copy data again through copied=0.
 	 */
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		if (unlikely(copied != len))
 			copied = 0;
 		else
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	/* overwrite compressed file */
 	if (f2fs_compressed_file(inode) && fsdata) {
-		f2fs_compress_write_end(inode, fsdata, page->index, copied);
+		f2fs_compress_write_end(inode, fsdata, folio->index, copied);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 		if (pos + copied > i_size_read(inode) &&
@@ -3730,10 +3731,10 @@ static int f2fs_write_end(struct file *file,
 	if (!copied)
 		goto unlock_out;
 
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 
 	if (f2fs_is_atomic_file(inode))
-		set_page_private_atomic(page);
+		set_page_private_atomic(folio_page(folio, 0));
 
 	if (pos + copied > i_size_read(inode) &&
 	    !f2fs_verity_in_progress(inode)) {
-- 
2.40.1


