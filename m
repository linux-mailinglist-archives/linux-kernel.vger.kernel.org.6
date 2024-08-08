Return-Path: <linux-kernel+bounces-279377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9841394BC89
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A9283D41
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED0A18C331;
	Thu,  8 Aug 2024 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="O7TKAKzX"
Received: from msa.smtpout.orange.fr (msa-213.smtpout.orange.fr [193.252.23.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4B145FE0;
	Thu,  8 Aug 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117953; cv=none; b=CSowWPGA5hTjpD3r9PVvOS32kigKtEk4hGRL5fLTgQiNeonJRkDtbaOvZvq6auRMFxQD94MGIk4uJx7oK9mj7XdhSQD/xqvHa1gWKrrKAodBxcsKXURX8UAbftEu+hxFzOdRO958vx+FQ8ir2j0WqEib8VjkPl4+GT8bl6BeK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117953; c=relaxed/simple;
	bh=eF2ePApikNs5+k4/8u8YxnC7Eb2zSQ8xjQ/xyeX9PVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ns8GrEZ0Ur6D/Aq3c3TzTnsUQwCwCy7qx18fDghJgYdor/txJChY3NVRV7e4jO8py5JgCla1vvTlR31bJDWGL9vlYlojEf25BBfDFmgCHVlojpB6VnT8qIFNzD/SW6aQybnfw2H/J9Gnegd3MFTU6DJaB7zWr0hftztT2XWCPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=O7TKAKzX; arc=none smtp.client-ip=193.252.23.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id c1flsSTvRnx6kc1fmsWZkp; Thu, 08 Aug 2024 13:51:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723117874;
	bh=cYtU3cwJ0fwnXFeK+ZEulL64nxWji9jLh3ldKu9/Uc4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=O7TKAKzXIBDtMMkFLkwEZLLyCekuVCRfY12OOmcEk0PpY37EmUBZyrytZCnxvK6sn
	 jRT/FP2C5d8ihpEF42E0DvldObBocaaS08MjSQtOkEDqQ61N6MUE/AW0QI+F9hkrtR
	 iahjEFsjC5PH5aBuXBZ+Rgh5psxy660RYLRC+w2F6mlPbPohS+UgOwMEhmDmYzutNx
	 jsBx5D3XEx+s7Z3TRlL4Qe1OXvWoaXuzbeAHvwYcFbsO9O7UxGfZ0Bt6PzIbt3wZc1
	 1lF8NqaH4KySj2oMnVNGnUje1kuHYqXAYpaj9B+LkQ1KgXerfL2spG7/xikerI/zMa
	 2CZ4JfJ6OxFPw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Aug 2024 13:51:14 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH] f2fs: Use sysfs_emit_at() to simplify code
Date: Thu,  8 Aug 2024 13:50:46 +0200
Message-ID: <0afb817e75a84859e1a86e1a7ba2041a9b852b6e.1723117820.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file already uses sysfs_emit(). So be consistent and also use
sysfs_emit_at().

This slightly simplifies the code and makes it more readable.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 fs/f2fs/sysfs.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index ed4bf434207a..654a541dcc45 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -188,50 +188,50 @@ static ssize_t features_show(struct f2fs_attr *a,
 	int len = 0;
 
 	if (f2fs_sb_has_encrypt(sbi))
-		len += scnprintf(buf, PAGE_SIZE - len, "%s",
+		len += sysfs_emit_at(buf, len, "%s",
 						"encryption");
 	if (f2fs_sb_has_blkzoned(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "blkzoned");
 	if (f2fs_sb_has_extra_attr(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "extra_attr");
 	if (f2fs_sb_has_project_quota(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "projquota");
 	if (f2fs_sb_has_inode_chksum(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "inode_checksum");
 	if (f2fs_sb_has_flexible_inline_xattr(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "flexible_inline_xattr");
 	if (f2fs_sb_has_quota_ino(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "quota_ino");
 	if (f2fs_sb_has_inode_crtime(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "inode_crtime");
 	if (f2fs_sb_has_lost_found(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "lost_found");
 	if (f2fs_sb_has_verity(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "verity");
 	if (f2fs_sb_has_sb_chksum(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "sb_checksum");
 	if (f2fs_sb_has_casefold(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "casefold");
 	if (f2fs_sb_has_readonly(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "readonly");
 	if (f2fs_sb_has_compression(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "compression");
-	len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+	len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "pin_file");
-	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 	return len;
 }
 
@@ -329,17 +329,14 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		int hot_count = sbi->raw_super->hot_ext_count;
 		int len = 0, i;
 
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-						"cold file extension:\n");
+		len += sysfs_emit_at(buf, len, "cold file extension:\n");
 		for (i = 0; i < cold_count; i++)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
-								extlist[i]);
+			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
 
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-						"hot file extension:\n");
+		len += sysfs_emit_at(buf, len, "hot file extension:\n");
 		for (i = cold_count; i < cold_count + hot_count; i++)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
-								extlist[i]);
+			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
+
 		return len;
 	}
 
-- 
2.46.0


