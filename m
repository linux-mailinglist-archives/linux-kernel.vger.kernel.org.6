Return-Path: <linux-kernel+bounces-228240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27750915D33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A061C21400
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7652461694;
	Tue, 25 Jun 2024 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMOyQR//"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7C55774
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285245; cv=none; b=LURrNmr99APgf8e+lP2hSap1LW5CAIKUTpZ2T8GuPo9flyJqyPWd1hpqo+bHTwv00aUoJBbYONe42jrdqEBrdCL/44+O6K6k5OBbh6l3E1f5aoNn5qiyRfyfvFU+pHmMnd6mNS8QPJZm0wyXEK1nBcf1eftFZ71ScUioBgVZKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285245; c=relaxed/simple;
	bh=7i9ANIkcb5e+IjTGnXP1+fnS3hh1UJ930GMPGvqfu9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTNNWq6yylx+9jdN6DT/yiZR9Twr3xO3bQ6EGm/OyZdBtQyOhKr3KoqNjFWjYl4Qg6lhoEAmzZnlA3CfjdbR+f57KAXtdVhzu2lWUx91FVN7B37uBTZDXYjZsXxhb0LgAe/u757vXp3b7Ack5V01SR/BuAh0x1/3eF//bgQD+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMOyQR//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912ECC4AF07;
	Tue, 25 Jun 2024 03:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719285245;
	bh=7i9ANIkcb5e+IjTGnXP1+fnS3hh1UJ930GMPGvqfu9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMOyQR//ysFjBcydfxv3gFlf1Xl1zVfYea9wWSmsmP7PuAKdH2XRqxpQeBvN5fA6q
	 YzzQsRaPy8yrJSo+a0BFSoZGbpseVHwr5mlpjK3l9xj8fbRlmzVxaKpQuT9Sslchtt
	 hubqkx+BApzr9szwqKRcMXJAav2kTc4TCbD94LiG3lJP1DpEOgF8/fYdDPLEelq6qU
	 l33HIsHL2lIdUZTr79zgDPr0cqe/s1YY+YXQIkwkSiFbG+Lwpb//PWreEFEAxlV7Ba
	 +WM6BMUOWrzs+tu2YA+IzWwLaN7KZmimrX/Z3MnOcbxCRJASdsij4aDkXp/XOiKIiB
	 SOpaIjO7/PJmA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/4] f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation
Date: Tue, 25 Jun 2024 11:13:50 +0800
Message-Id: <20240625031351.3586955-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625031351.3586955-1-chao@kernel.org>
References: <20240625031351.3586955-1-chao@kernel.org>
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
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2203904383a6..0355cb054521 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2185,6 +2185,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 	} else {
 		/* Reuse the already created COW inode */
+		truncate_setsize(inode, 0);
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-- 
2.40.1


