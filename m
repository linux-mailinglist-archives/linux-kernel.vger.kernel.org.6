Return-Path: <linux-kernel+bounces-419823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C481E9D76BE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95982BC23D2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89D1D5AD9;
	Sun, 24 Nov 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjBkzZxY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF42036EE;
	Sun, 24 Nov 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455852; cv=none; b=VXq6ZV3ddcR0uDDjx/ilvpkLg8l3lz7yCa/F4pHe9/Bl/e+ittri3JJgFFGqaKk2FJi/2F9ZkL6VmL55sYiMZdNYts9lTT58WFiQT6uGygKeyouVAruzc700pZJUIPAhp2WFPGX8Kt9uhb9YISnfVJOYJ22qgt86aZLuTQQnKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455852; c=relaxed/simple;
	bh=GPWL1EoADPh4U369AvLTJZQRfBf1SjUW476Qa27QLl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCGCDbDM4qpshWpmr4ZoVjjJDhBR0Ab9f4NHo7q3NA4UilhgRwUT3bZPw3JSsGcMRw1QDFSMpT+Bu5h2kAVGUkGMa9nk20wg/6O8Tx8Vl4nFPCk4gLYuLbtCQvlj7r45CezPXDuebTS54JOWSOPh82Ab4cqjbpR54eQicBiLwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjBkzZxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF02C4CECC;
	Sun, 24 Nov 2024 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455852;
	bh=GPWL1EoADPh4U369AvLTJZQRfBf1SjUW476Qa27QLl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjBkzZxYI6sTRHkl8r7/VA8bssA72a1ZjntRTo4LGQWJTdEWnDYBfsNgp7P3mmhoB
	 u9t/05opYAiVEdwrvZx6o98FoPLTPKFVvNY4R46/Id5g+WZRShBpawCYL9pVKsG0Hu
	 /1AMMug/ld4hcvXAavtIYO1LxWXW7hQUPH6ZLFtHT5al2mSsQ1Dl1GJGszUEs4l9Bo
	 Y1EKUCCbXyk8FZmjfSPTM9NvFGar4/yGxvkXBuyYNuEBu4O/i1PUL3caJkW+1PULaA
	 SMQheuJubFmIDmO8vXGbcswX9ej+INnvvlELC5ss7ERRYxsCM73vV5G1V5G5Nig9vT
	 laHxIZq+pWu2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.11 57/87] jfs: fix array-index-out-of-bounds in jfs_readdir
Date: Sun, 24 Nov 2024 08:38:35 -0500
Message-ID: <20241124134102.3344326-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit 839f102efb168f02dfdd46717b7c6dddb26b015e ]

The stbl might contain some invalid values. Added a check to
return error code in that case.

Reported-by: syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0315f8fe99120601ba88
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dtree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 69fd936fbdb37..8f85177f284b5 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2891,6 +2891,14 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 		stbl = DT_GETSTBL(p);
 
 		for (i = index; i < p->header.nextindex; i++) {
+			if (stbl[i] < 0 || stbl[i] > 127) {
+				jfs_err("JFS: Invalid stbl[%d] = %d for inode %ld, block = %lld",
+					i, stbl[i], (long)ip->i_ino, (long long)bn);
+				free_page(dirent_buf);
+				DT_PUTPAGE(mp);
+				return -EIO;
+			}
+
 			d = (struct ldtentry *) & p->slot[stbl[i]];
 
 			if (((long) jfs_dirent + d->namlen + 1) >
-- 
2.43.0


