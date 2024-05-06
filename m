Return-Path: <linux-kernel+bounces-169672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E28BCC0C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8883828350D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925323FB01;
	Mon,  6 May 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO3HNL/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8023D2
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991599; cv=none; b=c4aQL+uhpoY929DmPflqbmEYK0jLHRQPQuG8ads0LCyk8tDExubwMvNRLUVvsbV21ScL3hs9/XlsBKSUbbJxwPNeDcP1xhX10wFlbKIVqzYbLGlTvktViW8sthXyYuEk3bPJfDTbFqLanZ8mfvlAoNWVfUQhV2qm14GYnTHGNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991599; c=relaxed/simple;
	bh=ArQZcPL9NskSWJ33AcpZ7fqpChWS94RCsV5KimDJTWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iEay2yK6psPOqYk4Rb8/1pfWj7TsjQlLt5Y6ANw31PuOYyiYfsnfVIwUYJlV8/iGtfi9500uhhroCISSr8vieDWFpia+Vc2kGIzImcOw6YhEvvgvYI/SzjVNkPVlUfpS57/WLFMsJzPmCbjSNdaV/rmDq4mkFkX8xwH8LuV5ODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO3HNL/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA1BC116B1;
	Mon,  6 May 2024 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714991599;
	bh=ArQZcPL9NskSWJ33AcpZ7fqpChWS94RCsV5KimDJTWY=;
	h=From:To:Cc:Subject:Date:From;
	b=PO3HNL/NaetYrGgi4hGaAP0vK2LQfQyHtc5/VlCpgZx3gPrczk+9ZmblggC9/m3z3
	 85Z76E4GjDW7N/t/6kY7dkRuAJ3BujwzquOE3LVHB3ZTgCNhqtIDxPjVfIlabMw2s9
	 P1TC86GbAmremkhH1O2Vr3ed1AgbwQ+d7Y4Lm0OTFfgosuABRvprrwIN1MIU4SpKjl
	 Htn29yMbng/+bMit+Ic0OEZ/gV43EjgcfojFEiiaBkHUBSaT7qt2qsjd/zZcw/hWiP
	 GK8HfY+W8UNX9nazhsaKQ6INN3BtApxRKariBmzFuNCOpcvznZ4qLkEvQqW+a+W7GP
	 mIEhU2Oxr68dA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: fix to release node block count in error path of f2fs_new_node_page()
Date: Mon,  6 May 2024 18:33:11 +0800
Message-Id: <20240506103313.773503-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It missed to call dec_valid_node_count() to release node block count
in error path, fix it.

Fixes: 141170b759e0 ("f2fs: fix to avoid use f2fs_bug_on() in f2fs_new_node_page()")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b3de6d6cdb02..ae39971825bc 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1313,15 +1313,14 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 
 #ifdef CONFIG_F2FS_CHECK_FS
 	err = f2fs_get_node_info(sbi, dn->nid, &new_ni, false);
-	if (err) {
-		dec_valid_node_count(sbi, dn->inode, !ofs);
-		goto fail;
-	}
+	if (err)
+		goto out_dec;
+
 	if (unlikely(new_ni.blk_addr != NULL_ADDR)) {
 		err = -EFSCORRUPTED;
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
-		goto fail;
+		goto out_dec;
 	}
 #endif
 	new_ni.nid = dn->nid;
@@ -1345,7 +1344,8 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
 	return page;
-
+out_dec:
+	dec_valid_node_count(sbi, dn->inode, !ofs);
 fail:
 	clear_node_page_dirty(page);
 	f2fs_put_page(page, 1);
-- 
2.40.1


