Return-Path: <linux-kernel+bounces-386124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEA29B3F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 309E2B21A83
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475D17543;
	Tue, 29 Oct 2024 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEJh+6j1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9814A85
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163431; cv=none; b=Rj+0mWoxpKsNK5NImKsdZXGO5vvKBPiAFC9MoAI31qGxf/uGLK2ldel0MHMSah7qww/S1evKclqE7Htt/C1EPIboQdTUdw0LjRCn8pS/rYRzauDJV0d5Rvondv1YbS8h7/+jey5Rd9wtG/U8TjPUqwByISU4RYLl4mg0lxVWe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163431; c=relaxed/simple;
	bh=6amym9LlHgYwByTv/LTLrRmuOSWhxeY3BdEsJPngSbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hu0HCwI1H4keMmRxLmxx1U4bq+hsmB9itAKFHsrfAIsl7JrGfx5kV5YnjJjErwZAWnAh6Ur+aTkWCeW/PI3ISnMUPyghwe4qZIGVXBh7Y1aCjbW8L1q0pIJWNx51PK/TgG6tAVXHa1iHfnu7h40u/6TVhKDZXWQAenALQfczaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEJh+6j1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8950BC4CEC3;
	Tue, 29 Oct 2024 00:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730163430;
	bh=6amym9LlHgYwByTv/LTLrRmuOSWhxeY3BdEsJPngSbc=;
	h=From:To:Cc:Subject:Date:From;
	b=PEJh+6j1uzmIWwsg1KEBFZbhqFCmGz+qAxX0fbbKWXZgJsIoGJgQmJqdM1c2C2YGD
	 2LuMhgn/UcLyLrmPAFBkDYHrpm0/mmPh8uegUGuiCad/Dk+INKP6yDvkBRrknWomg6
	 KZAnDCKS78/5rJK3Fr8atpSIpHUIalTHQtzTihdBMCvv7vaNTPmKWo5/HODVD5TH+G
	 ZO6vCDHk6vMRXowImBZmsojxZsS1C48VWYqGvUnP17JU1/MEUaTGo8L2IGtYIMu9/a
	 1qftTiEO6YaU5rySc44IT/hP/KzNRYe4mVxKdeKFo3AOYdE+UFrfmDZIPx4za5sV8P
	 tQDPQ5tAJApMg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: clean up opened code w/ {get,set}_nid()
Date: Tue, 29 Oct 2024 08:57:03 +0800
Message-Id: <20241029005703.2740230-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just cleanup, no logic change.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index af36c6d6542b..7d904f2bd5b6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1066,7 +1066,7 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 	int i;
 	int idx = depth - 2;
 
-	nid[0] = le32_to_cpu(ri->i_nid[offset[0] - NODE_DIR1_BLOCK]);
+	nid[0] = get_nid(dn->inode_page, offset[0], true);
 	if (!nid[0])
 		return 0;
 
@@ -1177,7 +1177,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 
 skip_partial:
 	while (cont) {
-		dn.nid = le32_to_cpu(ri->i_nid[offset[0] - NODE_DIR1_BLOCK]);
+		dn.nid = get_nid(page, offset[0], true);
 		switch (offset[0]) {
 		case NODE_DIR1_BLOCK:
 		case NODE_DIR2_BLOCK:
@@ -1209,13 +1209,10 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		}
 		if (err < 0)
 			goto fail;
-		if (offset[1] == 0 &&
-				ri->i_nid[offset[0] - NODE_DIR1_BLOCK]) {
+		if (offset[1] == 0 && get_nid(page, offset[0], true)) {
 			lock_page(page);
 			BUG_ON(page->mapping != NODE_MAPPING(sbi));
-			f2fs_wait_on_page_writeback(page, NODE, true, true);
-			ri->i_nid[offset[0] - NODE_DIR1_BLOCK] = 0;
-			set_page_dirty(page);
+			set_nid(page, offset[0], 0, true);
 			unlock_page(page);
 		}
 		offset[1] = 0;
-- 
2.40.1


