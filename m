Return-Path: <linux-kernel+bounces-383534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A99B1CF6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888B3281EB4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 09:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EAE7DA93;
	Sun, 27 Oct 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VV4Ms0x/"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5781799B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022708; cv=none; b=gjOconNbvDqP151Xol1k30K7rJCS1YXldm6iSHh9YUeOdr0Iv/1K7b3OzxyzdaF0DIol8DyFljo03cqoMfv0/NKAjBO+pW9+iD6FXTn/yKa5RSECCkxL/kP8w48MnkIXCEi7NAE/Xi3Ye8GafZbBXnNPS53BVic3AxGnMCVoH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022708; c=relaxed/simple;
	bh=cpJoWljXzsf4XWSIx8zyfDTaOGByOEbSrJBGmyxjhbo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uYkwLRLZx8MuH9aM3kOvKXPOYVnZnUZ31ZZNLwj4Ri1/p2WlHue5EpCHtLKQxTawbALi+R2H7d5IIZaYgrvfeRrTa9ueJeIKvVDHqrX1bMzAN1PArAOyQtEaj74RdGW9Xb9CIJ/OycEfaS2uIzgFRvsI8Iq3HDxbzDJVwJHsP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VV4Ms0x/; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730022697; bh=82+FUztEUDgPNv5t8u9GqSLBsi4U3kiZfopeNUH5QD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VV4Ms0x/RAFX70L2sP6TZam/SjVYshJ6i3zul/PCMQypcM1sImeNDU4OgGqxmMQ/X
	 ftgD1iec29WyBELqvGj4H3gO9fcbGayDobl2uQlUHzjFM5azcCk0r92bF3kyzvG04P
	 gYl3RXRrs77wpzYK+pFth3obKI6P8vQ6IVfucV0E=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id CE40385D; Sun, 27 Oct 2024 17:51:36 +0800
X-QQ-mid: xmsmtpt1730022696tdbnnecm7
Message-ID: <tencent_A56F5096F0E83AEC6ACE9478866F602D150A@qq.com>
X-QQ-XMAILINFO: NEoGzTA04D+5xZWFDfDIN3jjuS6F34xsbv9FWa8uIi9Z0hHdKLmhZbVSoyRstI
	 aEZM1nIrtz+/eSlsuLRbae5c/BeiX1/dInZPbl5asipnwETsmCDo/COHd6DjHrsIJhFrcmyq44/A
	 JViBRQIxTZdJYF22A/uHcLMU9LTmOxnxXba6Dw/EDSoRbQ7jpLchtN1kefz3amWGJa6zA0Ba9Yy5
	 ruDj6dxB+GyUrJc4MKBWoiq0JfRjPsEzAhFT3h2CitFpg+JKrNv2EvTZYDoobXx3vJfrCrTimUEH
	 iX57pNjVIWdXkA7YE4hxL1uJZvqr7axASXA44oe0mKVWxagBuM1WTqW/oULJhM1PX9X63PbcsuER
	 2mRTvDz12bDzsEbsTICvfCG22USVoD8+4amv0ZFYNXYvn3EENHJSApaTbZGidUUma4f9JS4hOlO/
	 SExfw/WiSfg2ySyVSZ9EdL1CHaUC1g0qpHuBBnM0dyX91KYbL/B+0n6X+WrviaI8c5OR32xsKdpr
	 JnbQPrieS+xL2CV3Tkp1kvJXugqQF8qjr+s7NlzEy88VN3NLnKKGJbIv1GN+x5UGoN1B7vtilNLu
	 mGghWDBrF4CzP669RCX19cjlgh8uIO1Lt4oTlvYXSmM5EPbLoKjvouzflSS6HBhg9Kg2wGBPTLnV
	 0KTcgD9T4/jueCoO41/nzwle3cgNiyzF2NQ/XnrXXx9WpQHkv8jMqyEVUyfnc0vib1YsNMTZQtTp
	 USoAfNToWLVkrgPKA85tO/hpPcIBkuhVSG/D6N5vsw8UIz5TW3emjOMpWpgtOTiCyuIp17at/hcE
	 PiHHUJ08ioCPo1KslKRK0IC8s6rM/FUkZ+6cwWoL1OcUZr0WmQKP+QGE8FylIVXgmlF610/qvMgk
	 sEXWB45zoAW7ptNwMrmyt5QDTBogTtB3ItdYJk60+pI9Bxu6w/pGUUwuINRA6nzVtfWOcdwyCC
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
Date: Sun, 27 Oct 2024 17:51:36 +0800
X-OQ-MSGID: <20241027095135.1806480-2-eadavis@qq.com>
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

#syz test

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..dbd062f80c22 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2834,7 +2834,7 @@ extern int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 			     void *buf, int buf_size,
 			     struct ext4_filename *fname,
 			     struct ext4_dir_entry_2 **dest_de);
-void ext4_insert_dentry(struct inode *dir, struct inode *inode,
+static int ext4_insert_dentry(struct inode *dir, struct inode *inode,
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
index 790db7eac6c2..4ce1b207a4c0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2084,24 +2084,38 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 	return 0;
 }
 
-void ext4_insert_dentry(struct inode *dir,
+static int ext4_check_next_dentry(struct inode *dir,
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
+static int ext4_insert_dentry(struct inode *dir,
+			struct inode *inode,
+			struct ext4_dir_entry_2 *de,
+			int buf_size,
+			struct ext4_filename *fname)
+{
+	if (ext4_check_next_dentry(dir, inode, de, buf_size, fname))
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


