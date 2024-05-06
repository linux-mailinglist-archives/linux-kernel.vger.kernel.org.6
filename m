Return-Path: <linux-kernel+bounces-169684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9118BCC2D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563811F23B91
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1065142E9D;
	Mon,  6 May 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpaEIk0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BB142E83
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992133; cv=none; b=UtpXP6nfrrwzGY3FJsusIKFb2JCI7azHpasLL+GKVGPWE5CcEsqj92Z+nQ3SobGk/g4An42q2YFU/Pm1DccEDYRUpu0HKRKSNe7hFAIYP1yG9PP/v3Q3GbJ9E2VibIeB8eBMTY578H/7+sT7OYIizVFBJqgWt0aR6WTY+BqK9Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992133; c=relaxed/simple;
	bh=KvHgv8pWJ70VR77g2JX68gkuf540MRIUf0YWe6xekTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IB90XMdVSg7+QQD2yDQJnqlR2Uyr22Jq8g/S63p3rwo452s1jzrgrCoxQyW//iNdqfJerix1tfImLGJbrs+e0YciNtqpv9cM5qpNXTZ27DuFaDCeqoaP8eDqVa1BzMLms+O13+xge+WCzucDz9ASSVEPZs7XYDXnsJHCDq0fHCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpaEIk0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481F5C4DDE0;
	Mon,  6 May 2024 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992132;
	bh=KvHgv8pWJ70VR77g2JX68gkuf540MRIUf0YWe6xekTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DpaEIk0f4Ct2HOBbOktLw9cLgScg74r6sF1aeBGSzldjHZsNtOCpAb7aB09DC+L4b
	 nH/B/fkiKSgkh5C6qy4uO2Kdfy9F8UY2dvpVSFFyoFWZSMM4T/T5O3j2TnREhwhU7j
	 ItwrN3876knBt86fB5TEPiIVlC5FEpyo+oL1tFlXoxyBZlLKw2k+gQm3e+JpalOszz
	 a/qMDofsnHqvSBlCu9fngq2K0PxZUs9hUmhu4O3Rq4p0f1J3urtAB4sdoaMv+AhvLI
	 MbbiGVOOgBWfkPsddFIQG/VI++F2GOSEwo3sHQC0kKQ0it7nAW3FjgUnSrLgu7wttl
	 PmlDVZsZj/rMA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/5] f2fs: compress: fix typo in f2fs_reserve_compress_blocks()
Date: Mon,  6 May 2024 18:41:38 +0800
Message-Id: <20240506104140.776986-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506104140.776986-1-chao@kernel.org>
References: <20240506104140.776986-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/released/reserved.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6c84485687d3..e77e958a9f92 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3785,7 +3785,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	} else if (reserved_blocks &&
 			atomic_read(&F2FS_I(inode)->i_compr_blocks)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%lx "
+		f2fs_warn(sbi, "%s: partial blocks were reserved i_ino=%lx "
 			"iblocks=%llu, reserved=%u, compr_blocks=%u, "
 			"run fsck to fix.",
 			__func__, inode->i_ino, inode->i_blocks,
-- 
2.40.1


