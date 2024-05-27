Return-Path: <linux-kernel+bounces-191524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CA68D10AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498E01C21965
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A8139D11;
	Mon, 27 May 2024 23:57:42 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341817E912
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854261; cv=none; b=L0J04w5DXepgBfXtDTMIRoh4aYh6Dzexf8n3KAOeHSvLcInjvDzlnIgFUSX4DMvtSgSmew8wyhcTqXAncdr8RorfKLeQApfDkFCJDDDqAVtfJF2Jmo2GNvGzjhT/UHmQ7OaR7Rx8dMHnNZRBXfO5gZf1DHf1EydDdF2OYYx0inE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854261; c=relaxed/simple;
	bh=eBy7/C2nvx6ptlpgjMKipDZUULm3tHFWinQpj/iOXzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFJCx/pic6rOhCrDNvoQwEpvEuKFRaEFa53uB7/f6esunqhWDFTfqf09VXQ0rJy1IvTwNdXFTlqI1luM5H+EBHUo53Ng5nPMsVa2U+qcBVHsGDFjYXPomeFm04fj6u4G0/zeGvfeCQBmrRQGT7i6zytC8T0B2O/MlztgurNxah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.255])
	by sina.com (172.16.235.24) with ESMTP
	id 66551DEA000074B0; Mon, 28 May 2024 07:57:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 12261845089259
X-SMAIL-UIID: 3EDD15FBE5E74D039590144CA24D506A-20240528-075733-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Tue, 28 May 2024 07:57:21 +0800
Message-Id: <20240527235721.2643-1-hdanton@sina.com>
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/open.c
+++ y/fs/open.c
@@ -907,6 +907,7 @@ static int do_dentry_open(struct file *f
 	static const struct file_operations empty_fops = {};
 	struct inode *inode = f->f_path.dentry->d_inode;
 	int error;
+	struct super_block *sb = inode->i_sb;
 
 	path_get(&f->f_path);
 	f->f_inode = inode;
@@ -929,6 +930,7 @@ static int do_dentry_open(struct file *f
 		f->f_mode |= FMODE_WRITER;
 	}
 
+	down_read(&sb->s_umount);
 	/* POSIX.1-2008/SUSv4 Section XSI 2.9.7 */
 	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))
 		f->f_mode |= FMODE_ATOMIC_POS;
@@ -956,6 +958,7 @@ static int do_dentry_open(struct file *f
 		if (error)
 			goto cleanup_all;
 	}
+	up_read(&sb->s_umount);
 	f->f_mode |= FMODE_OPENED;
 	if ((f->f_mode & FMODE_READ) &&
 	     likely(f->f_op->read || f->f_op->read_iter))
--

