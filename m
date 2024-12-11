Return-Path: <linux-kernel+bounces-441894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD019ED559
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB42166A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BC1247995;
	Wed, 11 Dec 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pax3/29v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A6248374;
	Wed, 11 Dec 2024 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943144; cv=none; b=fciPrPJsR/ASEKKYnvoQ5VVhfcUaBcwHrUvJpoBg8cPbeO4AEA/o35E7kbbagQnP5QKLCHzN/VX3Yq5Tw7A+HzLzUO1mhhEK6FtTB03zIsq0SC+inazn/M+erxwwMoP71K203v/OvI5gccnMuu1JzgNN5uhXZTGEketCax5Oq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943144; c=relaxed/simple;
	bh=i58miCwsFy8lwImWGPRjcXEHc888+TYAUzq/MSE+I60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIwPEpxei1wrwjItGGPD6vllNqRIS7u6ON++T/E0pGHqi3LQ1M92xSdNhF+1wcB3AozHgfTQgISRoben59tw7XelRCLq3ISbtoNn3q1S0sgW2Mx3JAYvURDWQ4tmDgVDQb2S2ztq53eQMuNKQSWii03KfCh97DqgDuU7cqhmVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pax3/29v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C8AC4CEDE;
	Wed, 11 Dec 2024 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943143;
	bh=i58miCwsFy8lwImWGPRjcXEHc888+TYAUzq/MSE+I60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pax3/29v+fNkXpyfZfIOWbBasQOaLIZ4kPDk1vDi4LIpZqDSCOKL7ZyRdVnIS7yuZ
	 3SALYwocBmVVtGZMhTTtxfIOH9j+hNhRarHIm65mjaj9D2W29be0mlrxjTTYeksCeZ
	 3Tx+hMiFNwDHVRDRJKs5wNlgxutdBTpwd0CV6rKyZcpLejk4SQkWq4jdvzzjQjyaKc
	 IIDAP3VNSX77J6ToPxU1PlJdVtMXQjNnZbNb72SwNMQQz04S8JkfYL8I5+/z2W1UGq
	 UPS3jAqCOSuUd8EShsk6x2DjW/VZergKNvznhfZ3LGMVr7J6vg2sMy3AtvmR0OuEjf
	 ZkTkpoClebrAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.6 05/23] udf: Skip parent dir link count update if corrupted
Date: Wed, 11 Dec 2024 13:51:42 -0500
Message-ID: <20241211185214.3841978-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit c5566903af56dd1abb092f18dcb0c770d6cd8dcb ]

If the parent directory link count is too low (likely directory inode
corruption), just skip updating its link count as if it goes to 0 too
early it can cause unexpected issues.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/namei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 605f182da42cb..b3f57ad2b869f 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -521,7 +521,11 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 			 inode->i_nlink);
 	clear_nlink(inode);
 	inode->i_size = 0;
-	inode_dec_link_count(dir);
+	if (dir->i_nlink >= 3)
+		inode_dec_link_count(dir);
+	else
+		udf_warn(inode->i_sb, "parent dir link count too low (%u)\n",
+			 dir->i_nlink);
 	udf_add_fid_counter(dir->i_sb, true, -1);
 	dir->i_mtime = inode_set_ctime_to_ts(dir,
 					     inode_set_ctime_current(inode));
-- 
2.43.0


