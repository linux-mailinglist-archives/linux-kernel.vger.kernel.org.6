Return-Path: <linux-kernel+bounces-413888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316849D2031
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C341F21ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05985156641;
	Tue, 19 Nov 2024 06:24:40 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108C714A0B5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731997479; cv=none; b=pJfMuTbnPoMvWK4M8j8SYTlmRcvl0vKUVu70v784fQpMFB2BqxMLxqH7gPfCjyNYfa3aipKbRc3XBoS0k1YQZvUvTj5KgkULqxx9Z43cDpO7sqbaugaiyQMZzhrvKP+PV1EbCqojxE9ES30VGuAw8cfwStGhlPnty8DfV4yH9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731997479; c=relaxed/simple;
	bh=60ei7b63gLqgrTfNqjeP4XIG3k34pMSyv53lXwb1OzY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VJNcUwopaldS0wkLLzCWH7Beyb5PDDFnoGyLR2LA9wH+f6iH0Y1sM5q9Grw6lt7BWyyPXSeuEXCKI2pL3ULzXzrdeIVtMJ9YXczZ3wkE3KH8EV6IWCFaRA2Pi/trilZ1/DbOCbofudaX9hZQAA0rpakXSdor20k6yl0DdT+nq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a76acda477so19988555ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731997477; x=1732602277;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TL+wqQcCC8BsZeURTWvcfxDsZnXSUEvk6aa56u2QLY=;
        b=DQ8Li2uZLjKU4odZeXhzOQSO0H+ynp+f4V6JCmJGwR8PB+XA/rq56PL+3tc0qvxOep
         sMWfjg460AHTyTjRoBweIhfuvrnGVlk1ipyNPcFAulrujZLtHbEYTPzKvMeeYSYi48o4
         NvV1YcdATD4Nu4GiSazN/EX4Xxcv2yqzevZMog0QvmUVZ793/O463qwltNjk+OSqvZ9h
         dTbXqybNjgQt64k3SbRsbLxl7TeINcTd7/KhdB6TG7vXJaOK0U65evqXXy6LkKAB4dtL
         JRWWE2FaAIDNN1kgW05r3pj/qQ8QEHSvjBzka+F8zew6K/k95c8WBq56pYUbRt62/Uw0
         MQNg==
X-Gm-Message-State: AOJu0Yy9oAI8SM4v9jiftNqWW6/Olvxoe2kdlOAp6c7tXym3kFUQqkdg
	Z9foF66y0WxW0/o6Cc/VUVRbggiR5ZrVcDi05s460LgpxeBn6YKglPZWPRs+btEJUDszSns5xWw
	PmV1bYikP0R5qwyQKABulWzSKtoony7u+EeUrPeo8e7hWVXyslDD71+0=
X-Google-Smtp-Source: AGHT+IFDdEXr56BzLHS7TGyqqzCYFZdgsDHlHcGak/ABOCT2c5+IK06AfPZwR9bgEkXT8FJLJSDORCvFk8ZYiS96R+u4MoT4261o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3a76e5936dfmr42358185ab.17.1731997477244; Mon, 18 Nov 2024
 22:24:37 -0800 (PST)
Date: Mon, 18 Nov 2024 22:24:37 -0800
In-Reply-To: <67381991.050a0220.57553.0045.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673c2f25.050a0220.87769.0068.GAE@google.com>
Subject: Re: [syzbot] Re: general protection fault in jfs_error()
From: syzbot <syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: general protection fault in jfs_error()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 158f238aa69d91ad74e535c73f552bd4b025109c

diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 98f9a432c336..c0a51defc5b7 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -303,12 +303,6 @@ static int chkSuper(struct super_block *sb)
 	/*
 	 * validate superblock
 	 */
-	/* validate fs signature */
-	if (strncmp(j_sb->s_magic, JFS_MAGIC, 4) ||
-	    le32_to_cpu(j_sb->s_version) > JFS_VERSION) {
-		rc = -EINVAL;
-		goto out;
-	}
 
 	bsize = le32_to_cpu(j_sb->s_bsize);
 	if (bsize != PSIZE) {
@@ -449,6 +443,18 @@ int updateSuper(struct super_block *sb, uint state)
 	return 0;
 }
 
+static int validateSuper(struct buffer_head *bh)
+{
+	struct jfs_superblock *j_sb;
+
+	if (!bh)
+		return -EIO;
+
+	j_sb = (struct jfs_superblock *)bh->b_data;
+
+	return (strncmp(j_sb->s_magic, JFS_MAGIC, 4) == 0 &&
+		le32_to_cpu(j_sb->s_version) <= JFS_VERSION) ? 0 : -EINVAL;
+}
 
 /*
  *	readSuper()
@@ -457,17 +463,17 @@ int updateSuper(struct super_block *sb, uint state)
  */
 int readSuper(struct super_block *sb, struct buffer_head **bpp)
 {
-	/* read in primary superblock */
+	/* read in and validate primary superblock */
 	*bpp = sb_bread(sb, SUPER1_OFF >> sb->s_blocksize_bits);
-	if (*bpp)
+	if (!validateSuper(*bpp))
 		return 0;
 
-	/* read in secondary/replicated superblock */
+	/* read in and validate secondary/replicated superblock */
 	*bpp = sb_bread(sb, SUPER2_OFF >> sb->s_blocksize_bits);
-	if (*bpp)
+	if (!validateSuper(*bpp))
 		return 0;
 
-	return -EIO;
+	return -EINVAL;
 }
 
 
diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
index 8ec43f53f686..5f01f767bc0a 100644
--- a/fs/jfs/jfs_umount.c
+++ b/fs/jfs/jfs_umount.c
@@ -104,14 +104,15 @@ int jfs_umount(struct super_block *sb)
 	 * list (to signify skip logredo()).
 	 */
 	if (log) {		/* log = NULL if read-only mount */
-		updateSuper(sb, FM_CLEAN);
-
-		/*
-		 * close log:
-		 *
-		 * remove file system from log active file system list.
-		 */
-		rc = lmLogClose(sb);
+		rc = updateSuper(sb, FM_CLEAN);
+		if (!rc) {
+			/*
+			 * close log:
+			 *
+			 * remove file system from log active file system list.
+			 */
+			rc = lmLogClose(sb);
+		}
 	}
 	jfs_info("UnMount JFS Complete: rc = %d", rc);
 	return rc;
@@ -122,6 +123,7 @@ int jfs_umount_rw(struct super_block *sb)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	struct jfs_log *log = sbi->log;
+	int rc;
 
 	if (!log)
 		return 0;
@@ -147,7 +149,7 @@ int jfs_umount_rw(struct super_block *sb)
 	 */
 	filemap_write_and_wait(sbi->direct_inode->i_mapping);
 
-	updateSuper(sb, FM_CLEAN);
+	rc = updateSuper(sb, FM_CLEAN);
 
-	return lmLogClose(sb);
+	return rc ? rc : lmLogClose(sb);
 }

