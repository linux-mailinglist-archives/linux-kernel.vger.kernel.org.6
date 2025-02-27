Return-Path: <linux-kernel+bounces-537607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC7DA48E12
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A627A5F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9467D4502A;
	Fri, 28 Feb 2025 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXMnK34l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC876450EE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706989; cv=none; b=h7xmsPD8rO2lwxzWgMRVFMiKI4TX4N/ulSoSvZjGiuDxq11fyUjf0GluAgH4dVHz5sj8PVzDFDID9VKmhu9hNn+Zz9KPBvKpeaa+mVY0t1cenYWQjVsg5AtefAwBXY5sg8YAwM4b/pb4zuu4QRkXfLbtMHEYidgCuxxlx/YQz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706989; c=relaxed/simple;
	bh=4bxHTBKUgXhyLP5114/1Rtwa8qJMLVErQlbUUaq298Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qYw0/NKXNikQh3bd0iycPnofLEawienQ3kNOuxU0UbWUjmS5XIoqgEt8a//WTUlI4NMG726KvAz6KTORSQN8Ghxg3Tv1eum1NTTRTlMK7nttTaK8/8FQkaazEJxmunoRfjesupb4broF1ayB2nWyXQDZjIcCvfek3bzNJRuSTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXMnK34l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D18C4CEDD;
	Fri, 28 Feb 2025 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740706988;
	bh=4bxHTBKUgXhyLP5114/1Rtwa8qJMLVErQlbUUaq298Y=;
	h=From:To:Cc:Subject:Date:From;
	b=aXMnK34lixU/3T7P4eBmggcjLP8+w4YFbd8Y6WF19U+wtDSjjrr4JW4P/EJRBWCK7
	 Oyn3KaGELp480PUPQbApkSTWHm2r1SklCZZOTiIN4Cdvu4SSz1Nk4zl1M1mpKarm02
	 ESdWNJIodv49ItHHp9lhuY87bgV2Re9Htg/xPtz4j3adGv66Mb5JQHB0Hm/YmGkJrQ
	 RkZjXVfLmm7XbJVLv/dcF2mdoRHhE7wmrt6wJi9EjxFiBh5zt6CuW9hqXIOoCcddIP
	 5LmMRlhJyDxp+UgByKwp6Gpoi/aZe7zYH9gNMcaYYzIIiGqMZfw8WExDG78uJT6xMQ
	 7RojYi2ibN45g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Leo Stone <leocstone@gmail.com>,
	syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v5] f2fs: add check for deleted inode
Date: Thu, 27 Feb 2025 23:54:20 +0800
Message-Id: <20250227155420.48885-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leo Stone <leocstone@gmail.com>

The syzbot reproducer mounts a f2fs image, then tries to unlink an
existing file. However, the unlinked file already has a link count of 0
when it is read for the first time in do_read_inode().

Add a check to sanity_check_inode() for i_nlink == 0.

[Chao Yu: rebase the code and fix orphan inode recovery issue]
Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
Signed-off-by: Leo Stone <leocstone@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v5:
- only check i_nlink in lookup()
 fs/f2fs/namei.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 949621bc0d07..e39533482b45 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -502,6 +502,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 
+	if (inode->i_nlink == 0) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
+			  __func__, inode->i_ino);
+		err = -EFSCORRUPTED;
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+		goto out_iput;
+	}
+
 	if (IS_ENCRYPTED(dir) &&
 	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 	    !fscrypt_has_permitted_context(dir, inode)) {
-- 
2.40.1


