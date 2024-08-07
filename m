Return-Path: <linux-kernel+bounces-277726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E7594A555
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8670A1C20E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6613A1DD39D;
	Wed,  7 Aug 2024 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK6F6K78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDD1C823D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026280; cv=none; b=rTxb367Of7tLm+1+o4o94EMvkx085003sDmROgtlTXEypl3Vvo1D42AAfiMxjrpcxV9g5RICaZ4iIQQXqQzG5VOaTb1ge1HddXFwJGhqG6uax6UcdLQr5ptiVQALvKACTpcFwm/XidS9llLzBnFkBJYUrc8a/RU0bzDtG5bCGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026280; c=relaxed/simple;
	bh=hQ2kmHqbQj5Y7D/m0ApaSU/8XWhA6CYNdlXlnJpjXpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cx9a6urwxMUkqtoKR3xYQse0Ntkh5yqZHhsSBbFoVPRKOH7lurCor6Q1DrMZZXFg5pwDRmcNyRR0ITWwpjKUm6Utu/3rqGnydhY7apiatpKmf6cSayibJI9tywPFKOomgLQT2HjF0CyVZ/+JEOIsKkzRbZrmsDIYLVBasUzeXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK6F6K78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17892C32782;
	Wed,  7 Aug 2024 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026280;
	bh=hQ2kmHqbQj5Y7D/m0ApaSU/8XWhA6CYNdlXlnJpjXpg=;
	h=From:To:Cc:Subject:Date:From;
	b=jK6F6K78K495WJI226I22sczTpiBJJyJof6+y/GkN4h2K2cxQLpBtJr1oKLv5mR21
	 22m7n5H2Dsx4723yK9MzCFj1FhkhtiBq0qoyJI054bHEp1S9kqpxVKvM5JrwA6jG15
	 UIewTpGsbIfqLJWwIll1H7sqQWLXpJyfCRvjiTMq1wvkfcJmKKDtkpaoCjiPLgzlWQ
	 zWarK4pjAmD+emf5Mto3b6KgT7PBsQODbUjxi282CFJZLJAlMtS9VHzx1mVB0mbFZs
	 UjBxbfGAvPLdC/aiJ6VpntV/xQ7Arc+5B/jQruzq85iLNAKwZiRrmfC89gLeOikeMN
	 GEZrp0MK0U6mA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 3/4] f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation
Date: Wed,  7 Aug 2024 18:24:35 +0800
Message-Id: <20240807102435.2198055-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should always truncate pagecache while truncating on-disk data.

Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- don't reset i_size to zero.
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ac61c88f7688..eaa39c50f782 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2199,6 +2199,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
+		f2fs_bug_on(sbi, get_dirty_pages(fi->cow_inode));
+
+		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
+
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-- 
2.40.1


