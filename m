Return-Path: <linux-kernel+bounces-204069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BFB8FE399
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233301F21790
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C69417E90D;
	Thu,  6 Jun 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGQ4XbpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE6517E91B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667760; cv=none; b=TtULY5YetxbFId56t/GtOCd4okabRMxRI4yrg+lcyMuBBVUm9KwxJVA/Ed8qSEf2TM1cvljLHttgherct2NldX5uHqPfEcv3JKKevoCJIL5y5WYbe/0KfUfPv9mL1aX8csCkc8wYiWK/k5qCe+TuQJhWvTZ6NyrNQi/eXgFTJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667760; c=relaxed/simple;
	bh=taqzzIoM4pefR9En+zKIyMj3up5tKOsXWoFe6XXJE1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTV0LfOaacmZP8HOv1F8eMxIOVk5Q0C6VFGxgDpOzEYgjfXjs3w8BdJ/sY5OMlufMzrNWht8iXJ6DXCEMnLp9NLMSM/+dqZAlYNH5/zPkmbhSh6w2+kdWF1z9rUulpHKOkl1ooOwtFXeSgyq5AH1VpZl+34wsRq2VLP2YiSZT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGQ4XbpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01782C32786;
	Thu,  6 Jun 2024 09:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717667760;
	bh=taqzzIoM4pefR9En+zKIyMj3up5tKOsXWoFe6XXJE1U=;
	h=From:To:Cc:Subject:Date:From;
	b=nGQ4XbpMf66u0zSZZspvZOCfAm70HsfKzEN59kFtS2za97f7TzHpX8UW1QeYY1N4G
	 HPdg0tJp2j2w0rAGx6rpqj4OIi7eHlBAZde7jDsa6JLnwiP+gzyHGCY9m8YIHrZpfP
	 DNUr8V5rrfbDG00TNgKMLxk2ZZJ67bXdjyJOIWtLaRW9ixD/3mxs1fjvFbsl2aUstC
	 eI7BvLZa7FVLUYxJwIqJ1AyXn2NEJE0dr4Zl6Qwm78coTMFOVBn/juo5jUmYkYmL0R
	 Lea3GYdnAbChnteWrOQI+WgzwxieHxcZtwlk/27rYgi/ndHeGIa6VJQWmz2VbCxmtG
	 8GkDGKPklncAw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: remove redundant sanity check in sanity_check_inode()
Date: Thu,  6 Jun 2024 17:55:51 +0800
Message-Id: <20240606095551.4089055-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f240d3aaf5a1 ("f2fs: do more sanity check on inode") missed
to remove redundant sanity check on flexible_inline_xattr flag, fix
it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 87982e06bbe7..a3456b29b5ff 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -312,10 +312,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 			if (!sanity_check_compress_inode(inode, ri))
 				return false;
 		}
-	} else if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
-		f2fs_warn(sbi, "%s: corrupted inode ino=%lx, run fsck to fix.",
-			  __func__, inode->i_ino);
-		return false;
 	}
 
 	if (!f2fs_sb_has_extra_attr(sbi)) {
-- 
2.40.1


