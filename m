Return-Path: <linux-kernel+bounces-170616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B978BD9BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC89E2848E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AA74F896;
	Tue,  7 May 2024 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMlsUM0o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D34EB55
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052668; cv=none; b=jmsmClAQcgmlqgnhiQwmuZEK1tTvJkZS3/f7GXlmqE5PGrz75CtVmRSU0FfkUzhdM7zyqSr4sDk/PXZncRJZGLie3Es5w6O9vJfB1oeIUfg+E3TQtVoT7OOOOBoT0+aSAw5TagAxHVycOuoXdpxQMJ1yswOxCdvCxi/8Kb/98d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052668; c=relaxed/simple;
	bh=WEn57ZpMPjcw1lMUxGYEU0m2DwBeLhYddgmX6aoQ1nM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pc5wXniy+fCEwzo/CAgGA1ktgLKjMQn0ZTxlnnTgLFMzQjpTG7tjH5lEackRQLWewDiYiK0hxxOBgF1CeLRKYq3QzdygKR9cGMWVUlFNqWe22xKqIwDvK4798ckbhhtKyMGWA21+JZOlPhjLPHDLzNGryAGaWJCvY+4A+6/c5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMlsUM0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9719C2BBFC;
	Tue,  7 May 2024 03:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715052668;
	bh=WEn57ZpMPjcw1lMUxGYEU0m2DwBeLhYddgmX6aoQ1nM=;
	h=From:To:Cc:Subject:Date:From;
	b=uMlsUM0oWh47ThJBil5c2EetKK0vGVlcuipp91NLbvzVr/malBRi/8qcDmZ+lXl5r
	 cit/OxCDcuY0hlmc09NoP4A72ppqnHkdnKWdMy6IrAUHzACSTj66tGwLbHRCHvWLK+
	 duX16sVoiecHSxu8WoLkcmt2jvtF7EJnNRblec/PAkhS/u1y9bYuOA1IBvYv2tn9aa
	 Ejm5BFUFsTGTGRawYDH5osVPkyaeTr13c10R2C8W+JvGXF65rupgro1IeFUbKQdwS2
	 5M8Ontb+7rN83I77Z1XwFcqXNHR0TpzeiGPq5kr6OlxmDx7kF07W2jKqaN1t9MCmCy
	 6mE0s6DqFZVmA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 1/3] f2fs: fix to release node block count in error path of f2fs_new_node_page()
Date: Tue,  7 May 2024 11:31:00 +0800
Message-Id: <20240507033100.1044884-1-chao@kernel.org>
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
v2:
- avoid comppile warning if CONFIG_F2FS_CHECK_FS is off.
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b3de6d6cdb02..7df5ad84cb5e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1319,6 +1319,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	}
 	if (unlikely(new_ni.blk_addr != NULL_ADDR)) {
 		err = -EFSCORRUPTED;
+		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 		goto fail;
@@ -1345,7 +1346,6 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
 	return page;
-
 fail:
 	clear_node_page_dirty(page);
 	f2fs_put_page(page, 1);
-- 
2.40.1


