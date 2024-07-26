Return-Path: <linux-kernel+bounces-262763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7988093CC6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3A7B21A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6435017FF;
	Fri, 26 Jul 2024 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwlujWMg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D97ED8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956934; cv=none; b=HTEci+xufZ5HlHUhZAxnYjJ+3h6Zio4mkA7WMsOOraryUVxEt/aYeSXwyZsraBXaFoHqc7j104aidJ6WaxZsz30DycvfjxNLRkgKTUew6H8FGcejU4SrgZ2tD23d1i8Zx2JkYSjm1aQdd6328Y2rTE4KXQ5KEl5Nkz48/GJkLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956934; c=relaxed/simple;
	bh=T4nX2JvG0FoiXpP8NRekGHbQn5NBbSpbRupQpyxiKDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DPuvygnAi4Z2K/rMGk5D1aLucUrN90ah9leXo9/6+LD8dDZKUcLM46Man+AuV0ObsYZ4Tkbk+eMorNH1B+jc4i5MWWhcMk7ZnUZ1kykNa2/PB3W3VUYbzvd2j0ZLIOcXuRpXpimpBcn7hS1v37kVOxB3Q9hwo+eUBSl4iL//d+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwlujWMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CE5C116B1;
	Fri, 26 Jul 2024 01:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721956934;
	bh=T4nX2JvG0FoiXpP8NRekGHbQn5NBbSpbRupQpyxiKDs=;
	h=From:To:Cc:Subject:Date:From;
	b=EwlujWMguyiHVCmfst4ahoKh4JFUOOA3OPNhQH5bY2y1Z0uaWwxdekIO95tBsmbzA
	 N3XQy9ptg7SrmoulTej1Oie/aYItA7FaeChfuZrcDhF4q3O0nFFtdWg+QYOpIdndqd
	 fIV/6o0oFFcLaXO/ZbMoleBsjX0BZxoad3v5ZOYOOeg1MLAmhLhHYkZ8tK0MjFRfHe
	 CKcPCdtwIWrEl0cJ2XShYJQv0sadvxr5jj1QoOqsniUQIJ5szNirxZ2IOJT/kBo9bo
	 pGokn3HAnnFOXtO7cVH7bZxc3B5R8+Qkx6iSz5RSJysnYeyVZerbBbSBaWzmtLpO+5
	 T+RZov3e5utTQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 3/4] f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation
Date: Fri, 26 Jul 2024 09:22:04 +0800
Message-Id: <20240726012204.1306174-1-chao@kernel.org>
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
v2:
- fix to use cow_inode instead of inode
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6c62f76474d1..54886ddcb8ab 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2202,6 +2202,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
+		truncate_setsize(fi->cow_inode, 0);
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-- 
2.40.1


