Return-Path: <linux-kernel+bounces-175592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4398C2215
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B94E1F2166F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02BF168B16;
	Fri, 10 May 2024 10:27:03 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E716ABC3
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336823; cv=none; b=tJBlAiQS/1mU0W3h+nbtv7YvpasRkdnpsxQ8XcUVX0eJUE+AJTAMM4LavgIAXrM6VE0BALXZ3GaI27EYMrDh1Hw+4P7Lapa/tbXYauHXJpPO+l0ftfjBloN/l5pbThLg9V0rKBpwZ91l1425Fv/BYlRVLjPRLzvtqgdnexfg85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336823; c=relaxed/simple;
	bh=SK1hbF8oGwwr9prxmgVVid73ld0NBEnOT0NNuwRaY54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wq3EpPxcK0MI6mUlwz0dvZulny/GM+6oUlP+Ui8hMUCAECyDB6ey+is3lerZA2jeAYcauNrnzzUD203fNQa+ZAq0cyOdyqJLgcDAXt16S5DwDNe/92TF+jYCuKONB8R8CS734fFcM/0Nh/6VVtEozZOguk1HcxlCeNh7sOG5BGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.62])
	by sina.com (10.75.12.45) with ESMTP
	id 663DF66D00000F1E; Fri, 10 May 2024 18:26:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 67980831457973
X-SMAIL-UIID: 53FE2955DF384184B1D9B79BACEF9E5C-20240510-182655-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
Date: Fri, 10 May 2024 18:26:43 +0800
Message-Id: <20240510102643.2517-1-hdanton@sina.com>
In-Reply-To: <00000000000091228c0617eaae32@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 07 May 2024 22:36:18 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1367a504980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  dccb07f2914c

--- l/fs/overlayfs/dir.c
+++ d/fs/overlayfs/dir.c
@@ -654,10 +654,44 @@ out:
 	return err;
 }
 
+static int __ovl_create_object(struct dentry *dentry, int mode, dev_t rdev, const char *link)
+{
+	int err;
+	struct inode *inode;
+	struct ovl_cattr attr = {
+		.rdev = rdev,
+		.link = link,
+	};
+
+	err = ovl_copy_up(dentry->d_parent);
+	if (err)
+		return err;
+
+	/* Preallocate inode to be used by ovl_get_inode() */
+	err = -ENOMEM;
+	inode = ovl_new_inode(dentry->d_sb, mode, rdev);
+	if (!inode)
+		return err;
+
+	spin_lock(&inode->i_lock);
+	inode->i_state |= I_CREATING;
+	spin_unlock(&inode->i_lock);
+
+	inode_init_owner(&nop_mnt_idmap, inode, dentry->d_parent->d_inode, mode);
+	attr.mode = inode->i_mode;
+
+	err = ovl_create_or_link(dentry, inode, &attr, false);
+	/* Did we end up using the preallocated inode? */
+	if (inode != d_inode(dentry))
+		iput(inode);
+
+	return err;
+}
+
 static int ovl_create(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl)
 {
-	return ovl_create_object(dentry, (mode & 07777) | S_IFREG, 0, NULL);
+	return __ovl_create_object(dentry, (mode & 07777) | S_IFREG, 0, NULL);
 }
 
 static int ovl_mkdir(struct mnt_idmap *idmap, struct inode *dir,
--

