Return-Path: <linux-kernel+bounces-388572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E123B9B615E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A333A2840EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED421E47B4;
	Wed, 30 Oct 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="I316a+Xh"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC21E285C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287387; cv=none; b=swSPcB3sQbvV568j6hewGvfwLvE1XadsD3xnRJVKrX3w5P/zCbLQWV537z02xkzmlgNTUfTHSyIWDuieUxelnKLzfMpOVfhUaThIo7N786WIyzyvO4uU4o6uS/cXG17A5/9bTTmMqzwDZPrK9Go2j0gjw4bx1pm8pofsmJ0Y674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287387; c=relaxed/simple;
	bh=vAClixil9ctOwyUjrpNeEnIAT9+x6cz+JtC+S4IQU+Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pV8s77WMyDuyb1BeT9W2AKnlIf6vF0NSDEw5tCt1WI8lu2H1upp+v1fWF2RrQ7ZQCfeTKkTALhmIDq1/RTfg2yF4zkN9nxvbqref67VXXWPU9sqy3CCwkyXFw04nTyQ9UddGh8paPdZZ+4TF1FGXD3KjalVNQdMTLDoQXXUCruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=I316a+Xh; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730287376; bh=vqM/J8b47sq+qs2sxKbDTYiKVZ0AGjfRosIfsrAwCIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I316a+XhVi4mP5ATlseICQZcO6CbgUwDOvnf06MaxIBtjopLIc1KODMgWFDUwR+nW
	 5EQNL5YPNwGaxU5P+WmaAT7FrtuLUoBxkyDFiGo/5O6XnVPixLLi8Rdd9rTOMIOiad
	 0jCF4mu+vgAnuSlRQgGZtTBvKqCNdqRHQ/F4H+f0=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 566A38DF; Wed, 30 Oct 2024 19:21:38 +0800
X-QQ-mid: xmsmtpt1730287298tejdjgkvx
Message-ID: <tencent_889A2EFAAEE6CC9827D206E6D2F286794906@qq.com>
X-QQ-XMAILINFO: NSahpW5IwUZOzKN800ZyPXNXZux2Hl4UHHmBrJKNrYvpmim2NgA80EV2jLAXEm
	 +ahoCMmNQeX3/yoaoauXjnA1VkGRnv4wvKiy/1Cxlirt5IjTF1p8bfrpk1NHY5qUYcdur2yaj6mo
	 8G1Ziv+D7qkfGT+KuxeRg2YMdz+RosskOzpV6LxQMekJd/hYBUrbmhIEDm07SRvqYyxObtN2gcTw
	 v7w1Lv8a58GJp150NxLOGOrzxU7ic0U55atUXPVPvn9X9ZTUd3EWXzEDXxCl7jnPuwzOsobfkNsL
	 JTeLWECdDM9VrjRsFNp4gaaZu8TM7w9zq07yjjNeLBA0cMrh4sjrbUpMPNDGHkihMwnR/TQUC21M
	 AQIFw7/3eO7gIP1M7lx0l4rQ4Jc9YBSdtyVumA7EAUjbGVz8MVqS6Kc9KRn5BRulPBTwHzQkOtCY
	 IyMqzzGYr8iULM7clbn0bgN8Mk+5g1dwARjN99aMrDWkMPuV5MJBeHB84fnX+hWh0BNnqRd9yGgm
	 0MUth8pW6GpACL1iszPFbZW0+xEEAoJy8RmjVN+p1DWHPF8nET7iua9PvJdE8XYYhsejeT12cUXo
	 96+9thbiAR244yF9KgzOF0U92zoCmRSNatSVbVA962q7bNzSQ6182APLH0OLF6Xah/3ufLPV8z/y
	 3ECl12ydG7IIsgkskoF3+Rr4uhJlVjeafVf4FyGZwQ9YE17lFv9aDaZGyOn7tmNpumDNE0dDBw5Z
	 hklSzGxv6c+iotJPbu2khl8L9Fz6K4iiqASaztlHnguu94HMQUWoC1Oyrt5ft7ZHdMD09bVe4u5P
	 PyAZcncUrFI+A2CVj3hrpIAc3p9mFWyjOT+iFIjwXW/gJAVoQjKoHOnHIRPIwGyQQ2pIPvhSNHSa
	 gP+qieNMg4IaiV+IEMRVvDaA3AdQe3FnwzpMlgTfjCa4W/8ngBeuaEezwkOeliK8bEBiCPhjeh
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
Date: Wed, 30 Oct 2024 19:21:39 +0800
X-OQ-MSGID: <20241030112138.3629327-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
References: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check next directory entry space if it is too smaller than file name exit dentry insert and return -EINVAL 

#syz test: upstream master

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..e07ac540ed00 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2834,7 +2834,7 @@ extern int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 			     void *buf, int buf_size,
 			     struct ext4_filename *fname,
 			     struct ext4_dir_entry_2 **dest_de);
-void ext4_insert_dentry(struct inode *dir, struct inode *inode,
+int ext4_insert_dentry(struct inode *dir, struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..e318b13459d1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1022,7 +1022,9 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 					    EXT4_JTR_NONE);
 	if (err)
 		return err;
-	ext4_insert_dentry(dir, inode, de, inline_size, fname);
+	err = ext4_insert_dentry(dir, inode, de, inline_size, fname);
+	if (err)
+		return err;
 
 	ext4_show_inline_dir(dir, iloc->bh, inline_start, inline_size);
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 790db7eac6c2..1c9fedf36fb0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2084,24 +2084,38 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 	return 0;
 }
 
-void ext4_insert_dentry(struct inode *dir,
+static int check_next_dentry(struct inode *dir,
 			struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname)
 {
-
 	int nlen, rlen;
 
 	nlen = ext4_dir_rec_len(de->name_len, dir);
 	rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 	if (de->inode) {
-		struct ext4_dir_entry_2 *de1 =
+		struct ext4_dir_entry_2 *nde =
 			(struct ext4_dir_entry_2 *)((char *)de + nlen);
-		de1->rec_len = ext4_rec_len_to_disk(rlen - nlen, buf_size);
+		nde->rec_len = ext4_rec_len_to_disk(rlen - nlen, buf_size);
 		de->rec_len = ext4_rec_len_to_disk(nlen, buf_size);
-		de = de1;
+		de = nde;
+		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
+		return fname_len(fname) > rlen - EXT4_BASE_DIR_LEN;
 	}
+
+	return 0;
+}
+
+int ext4_insert_dentry(struct inode *dir,
+			struct inode *inode,
+			struct ext4_dir_entry_2 *de,
+			int buf_size,
+			struct ext4_filename *fname)
+{
+	if (check_next_dentry(dir, inode, de, buf_size, fname))
+		return -EINVAL;
+
 	de->file_type = EXT4_FT_UNKNOWN;
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext4_set_de_type(inode->i_sb, de, inode->i_mode);
@@ -2114,6 +2128,8 @@ void ext4_insert_dentry(struct inode *dir,
 		EXT4_DIRENT_HASHES(de)->minor_hash =
 						cpu_to_le32(hinfo->minor_hash);
 	}
+
+	return 0;
 }
 
 /*
@@ -2151,7 +2167,11 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	}
 
 	/* By now the buffer is marked for journaling */
-	ext4_insert_dentry(dir, inode, de, blocksize, fname);
+	err = ext4_insert_dentry(dir, inode, de, blocksize, fname);
+	if (err) {
+		ext4_std_error(dir->i_sb, err);
+		return err;
+	}
 
 	/*
 	 * XXX shouldn't update any times until successful
-- 
2.43.0


