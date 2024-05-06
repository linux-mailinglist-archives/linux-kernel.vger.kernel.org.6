Return-Path: <linux-kernel+bounces-169673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6458BCC0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1421C2130C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF451369AD;
	Mon,  6 May 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsUNro59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA7757F8
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991601; cv=none; b=mtQA8hlV40Go0TIizMO5zBHn4OuazMxp0AYZaxvXbUXJJOmLqvfwwYA/9f0AuwtwSh1LRLvUcqEJF0XUOHZjAyS5wja5lOaSXASz/oeAUpZcigOjzT3TqacEOhiGg1y9G8qkW/M2R+ALghCqijF+BoTVOwjBMXyJ816+za2zhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991601; c=relaxed/simple;
	bh=8d1H5ohN2OC867yx9Kz7v2nSEmt59J3n2trihH6jcFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncRR4JaqeEFfvJy0UPKO1k725j7OYInE2sicUkrb92g1xGFqYJuFit95BVLhn+XFOxSi8PMx2jyh/KECWcJ5fbo5zdkKmZQV1h6Ts6V9XnTgZXxT0CkDOThedayI3bh0AVwm5Sv9F0MASPc6I8i7gUmLXo8H/nfZcYuaDrJl7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsUNro59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1719C4AF18;
	Mon,  6 May 2024 10:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714991601;
	bh=8d1H5ohN2OC867yx9Kz7v2nSEmt59J3n2trihH6jcFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsUNro59jXc0yxJ2XMnh1j9/+xx9X43rLu3WZgQ+WYy1DLyp0VXzPVAyd5JINd7OS
	 mvA2tpZ98mnK26t8zizcnuhFu1QgMA9zoCbmiF6wNmNxlICzZhknuj6R7Pa+uI/EC5
	 j5UShNpxwcq7gFizl1h1OSlAw1gYAF4FhnGQ2a3YG0ps0INegJv9hwiBKjhnUnY9QG
	 yZlHbyIMcPno4wbhtwShSaksSCOrWPHW/F/CURfu9m5IdvH7MVDceI0baf+6oZTJKy
	 pfqHJagIy1wclYghDINnZLBp/A7E+hRG095sFYt9xnJXO79st8DLBHnk2aBwl7yK2B
	 Jjre/ozJIZDgA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: fix to add missing iput() in gc_data_segment()
Date: Mon,  6 May 2024 18:33:12 +0800
Message-Id: <20240506103313.773503-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506103313.773503-1-chao@kernel.org>
References: <20240506103313.773503-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During gc_data_segment(), if inode state is abnormal, it missed to call
iput(), fix it.

Fixes: 132e3209789c ("f2fs: remove false alarm on iget failure during GC")
Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8852814dab7f..e86c7f01539a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1554,10 +1554,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			int err;
 
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode) ||
-					special_file(inode->i_mode))
+			if (IS_ERR(inode))
 				continue;
 
+			if (is_bad_inode(inode) ||
+					special_file(inode->i_mode)) {
+				iput(inode);
+				continue;
+			}
+
 			err = f2fs_gc_pinned_control(inode, gc_type, segno);
 			if (err == -EAGAIN) {
 				iput(inode);
-- 
2.40.1


