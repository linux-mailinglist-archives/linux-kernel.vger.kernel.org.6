Return-Path: <linux-kernel+bounces-217121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFE990AB12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2DD1C21EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F65192B68;
	Mon, 17 Jun 2024 10:30:14 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B817E903
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620214; cv=none; b=QTGxoGvv1w5uop7N1Cy8QUqQ8Jjy4KYtprtmW9GUU8rIIfdw0EoWbyyD7qKjBOrL2kMZ1KvfzXH/nQjD1147D8+6xh3bKGW/u5MW+aXuTEKLduQ4IoW7fV1QTKsTD4xnICO8bVGmoyCZIUtwM39PkneLA+jQJN2NFhpdqhN899E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620214; c=relaxed/simple;
	bh=yXmbT08+R/weNfyAYav/Bs5/W3uM+bUacFUrSfc4Mpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0oIW6q51+STcHEWmNB1KG0/hSLB3dRNVpTW8b4ov/Rd74YvaX4GWtvrHkacLP3GbQBg2CEn5e7SUiITyPbEyfx4u0VFkNxV4bP/PB6OyNuybzNnomSHMEAnBbBxE6E80XLQh5b1VWIkcUwITt2wEf3ZIaTnnILZ0qC9COdEEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.85])
	by sina.com (172.16.235.24) with ESMTP
	id 6670102300005025; Mon, 17 Jun 2024 18:29:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 46134545089352
X-SMAIL-UIID: F444376CF3744862BE2EC9017EE70E7D-20240617-182957-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Mon, 17 Jun 2024 18:29:46 +0800
Message-Id: <20240617102946.1524-1-hdanton@sina.com>
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  83a7eefedc9b

diff -pur b/fs/namespace.c a/fs/namespace.c
--- b/fs/namespace.c	2024-06-17 18:24:14.364221500 +0800
+++ a/fs/namespace.c	2024-06-17 18:19:58.988799600 +0800
@@ -672,6 +672,14 @@ static bool legitimize_mnt(struct vfsmou
 	return false;
 }
 
+bool mnt_doomed(struct vfsmount *mnt)
+{
+	if (mnt->mnt_flags & MNT_DOOMED)
+		return true;
+
+	return 2 > mnt_get_count(real_mount(mnt));
+}
+
 /**
  * __lookup_mnt - find first child mount
  * @mnt:	parent mount
diff -pur b/fs/open.c a/fs/open.c
--- b/fs/open.c	2024-06-17 18:23:56.967279000 +0800
+++ a/fs/open.c	2024-06-17 18:22:11.065932700 +0800
@@ -952,6 +952,9 @@ static int do_dentry_open(struct file *f
 	if (!open)
 		open = f->f_op->open;
 	if (open) {
+		error = -ENODEV;
+		if (mnt_doomed(f->f_path.mnt))
+			goto cleanup_all;
 		error = open(inode, f);
 		if (error)
 			goto cleanup_all;
diff -pur b/include/linux/mount.h a/include/linux/mount.h
--- b/include/linux/mount.h	2024-06-17 18:25:07.750059900 +0800
+++ a/include/linux/mount.h	2024-06-17 18:17:35.669341200 +0800
@@ -93,6 +93,7 @@ extern bool mnt_may_suid(struct vfsmount
 extern struct vfsmount *clone_private_mount(const struct path *path);
 int mnt_get_write_access(struct vfsmount *mnt);
 void mnt_put_write_access(struct vfsmount *mnt);
+bool mnt_doomed(struct vfsmount *mnt);
 
 extern struct vfsmount *fc_mount(struct fs_context *fc);
 extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
--

