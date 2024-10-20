Return-Path: <linux-kernel+bounces-373504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E689A5781
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 01:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1497281D0B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 23:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD001465BB;
	Sun, 20 Oct 2024 23:42:40 +0000 (UTC)
Received: from sxb1plsmtpa01-05.prod.sxb1.secureserver.net (sxb1plsmtpa01-05.prod.sxb1.secureserver.net [188.121.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6AF20E31D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729467760; cv=none; b=Aa5W8Au6Sb+8fO9DWpW/6FzVtunQqlCI9RJHxnwCMGpRIZiPgo+4+Go8cSpcAsBiogFRXDqsfVuT8dINg692hFpiTWum8IbrNe327+BdzAtepRWSV222SudKkbCbNYpn9cwn84TTqkORy82WukZ7HN2chZlXQNechVYjT4hCe8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729467760; c=relaxed/simple;
	bh=QJaCZm8L71fNVsHth8YmRmDIVISDn+gE4ATzTQbpLs4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ekk5ZG+OzyLiTFmCDXtUX16r6gmIPogpWqtDcjwEqQZmsVo3lWXA8yq3emRrq+a31sqMhyp8KKbUkIZj+oGJGllaP4ju1WSCmcdf/LAUXevfoWQ3rXas/ij93RwWO9pDw8y4e5Q+wnoxhNTCb/AiS2P09R1Q3/kHLIQ4hm/OwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id 2fGRteujmhxWc2fGit1UlM; Sun, 20 Oct 2024 16:23:29 -0700
X-CMAE-Analysis: v=2.4 cv=BaET0at2 c=1 sm=1 tr=0 ts=671590f1
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=GeTWYS56exIqEZPe-6AA:9
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	"Lai, Yi" <yi1.lai@linux.intel.com>
Subject: [PATCH] Squashfs: Fix variable overflow in squashfs_readpage_block
Date: Mon, 21 Oct 2024 00:22:00 +0100
Message-Id: <20241020232200.837231-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOiFdZ96ERph1ovwAJYzsy6got+owpfo+raPw0lQI/d1cTSqKntn27SeNJEw64a5pw9yO6jcJLD/kEW3KCoF9PHlh63c5hVzOJh+BnP+lCfR8Wp3JTTQ
 A2Bk6wJY4kTQY2GMzftYhl7lYjpAnl9FCzh0+clNhGJnEfO8p8Vxj3rcM5FV7kWHtLo7qSvcaZfiww7U3AeHSFHWL6cwR5NpNPJ6M+DNsn3tBOK19ThBSXsu
 RGHacMNTmAYAJh71Frv8CN++uv2AdO8cg85gL6kbtSRYr0Gus0EtZDJzgqv+SSzjs2m/bxptEEGqZYrie33H7w==

Syzbot reports a slab out of bounds access in squashfs_readpage_block().

This is caused by an attempt to read page index 0x2000000000.  This value
(start_index) is stored in an integer loop variable which overflows
producing a value of 0.  This causes a loop which iterates over pages
start_index -> end_index to iterate over 0 -> end_index, which ultimately
causes an out of bounds page array access.

Fix by changing variable to a loff_t, and rename to index to
make it clearer it is a page index, and not a loop count.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/all/ZwzcnCAosIPqQ9Ie@ly-workstation/
---
 fs/squashfs/file_direct.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index 22251743fadf..d19d4db74af8 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -30,7 +30,8 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
 	loff_t start_index = folio->index & ~mask;
 	loff_t end_index = start_index | mask;
-	int i, n, pages, bytes, res = -ENOMEM;
+	loff_t index;
+	int i, pages, bytes, res = -ENOMEM;
 	struct page **page, *last_page;
 	struct squashfs_page_actor *actor;
 	void *pageaddr;
@@ -45,9 +46,9 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 		return res;
 
 	/* Try to grab all the pages covered by the Squashfs block */
-	for (i = 0, n = start_index; n <= end_index; n++) {
-		page[i] = (n == folio->index) ? target_page :
-			grab_cache_page_nowait(target_page->mapping, n);
+	for (i = 0, index = start_index; index <= end_index; index++) {
+		page[i] = (index == folio->index) ? target_page :
+			grab_cache_page_nowait(target_page->mapping, index);
 
 		if (page[i] == NULL)
 			continue;
-- 
2.39.2


