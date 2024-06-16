Return-Path: <linux-kernel+bounces-216248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD740909D20
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 13:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98317281376
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454A186E2F;
	Sun, 16 Jun 2024 11:16:06 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0FC152
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718536565; cv=none; b=kP1N871yVULvyq8W2OTLUERJ4rRp224bbSp2zeTLCFUqQvvWXhJQcuYXbRv5yi8E0X8QprP1a8lE81JWVkaNe127tzT07L4e0Lxpltj2RaXWg0EHdr4wlWfegCLzXnd15SyPywwOnjcLE+hL3N8IdCQwjnnVA7rdzueI+c06/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718536565; c=relaxed/simple;
	bh=yRkvWUcyYD85QzvXjqsicOKjXeT9KTNyhEAcAFqT3Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+3dBwez0eKS5xCG3kQ/aZ0NfkavXge5x52qzeP6TKH3H4VDeXzh19vOfl+EtppEM4spFcczipAA1hZG57unO88QI/S34Ip/h6VmmkIQSuXhpXbmqXab3FmId8VT7ZlB4yYbqNxsptJlgKnzPJasfkMFCEIjjw5OElSaiyoAcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.2])
	by sina.com (172.16.235.25) with ESMTP
	id 666EC94100001C09; Sun, 16 Jun 2024 19:15:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 31080534210374
X-SMAIL-UIID: 9F37067A3CB646B48E3E5A2BABADC89A-20240616-191515-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Sun, 16 Jun 2024 19:15:02 +0800
Message-Id: <20240616111502.1435-1-hdanton@sina.com>
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

--- x/fs/open.c
+++ y/fs/open.c
@@ -35,6 +35,8 @@
 #include <linux/filelock.h>
 
 #include "internal.h"
+#include "mount.h"
+#include "pnode.h"
 
 int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
 		loff_t length, unsigned int time_attrs, struct file *filp)
@@ -952,6 +954,12 @@ static int do_dentry_open(struct file *f
 	if (!open)
 		open = f->f_op->open;
 	if (open) {
+		struct mount *mnt = real_mount(f->f_path.mnt);
+		error = -ENODEV;
+		if (mnt->mnt.mnt_flags & MNT_DOOMED)
+			goto cleanup_all;
+		if (mnt_get_count(mnt) < 2)
+			goto cleanup_all;
 		error = open(inode, f);
 		if (error)
 			goto cleanup_all;
--

