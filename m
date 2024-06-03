Return-Path: <linux-kernel+bounces-198993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124F88D8036
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9937B28609D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DBA82D9A;
	Mon,  3 Jun 2024 10:42:40 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F019F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411360; cv=none; b=cRIKAy5KOGWbvMx+3fZnmnMFOGfflRa/MGU8OMRy4S4f6w9KIJ3tIxrtGUjGykQnttKDTo2Ato6xU5KnDafvR404m5qSV/kuJbzXwy3sMpwg8Ts5b4Tm0/d8Ig4wrougDS+eanSfYUVR+f0tM1jULhAANV4welE1qCxmEju9gEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411360; c=relaxed/simple;
	bh=WZE/wXk4w/29dBkOrSGAcse3U2x0Hn9pieqgKvJkZvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ol7PBvf4J4Cs7q/BhJd0tNXDNbdOP9DzHMi/T7k0O0wJeHZsF9BECA+f/wCndmS6bK24bYdNh6EG+vZvxEg2y7lwIG3RmhfymzYWTPxv7bVOS+TekkaTOwSbincdljnvX1FPDYKTvwXfRKdHkTKgqKtdzchFzHEpgCep4ecArOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.186])
	by sina.com (172.16.235.24) with ESMTP
	id 665D9E0B00002490; Mon, 3 Jun 2024 18:42:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 56327145089299
X-SMAIL-UIID: FAB669AF052A4A4A995B53A1ACC9F0A6-20240603-184222-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
Date: Mon,  3 Jun 2024 18:42:11 +0800
Message-Id: <20240603104211.1526-1-hdanton@sina.com>
In-Reply-To: <00000000000054d8540619f43b86@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 02 Jun 2024 20:50:18 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103820f2980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/namei.c
+++ y/fs/namei.c
@@ -4198,6 +4198,8 @@ int vfs_rmdir(struct mnt_idmap *idmap, s
 
 	if (!dir->i_op->rmdir)
 		return -EPERM;
+	if (dir == dentry->d_inode)
+		return -EDEADLK;
 
 	dget(dentry);
 	inode_lock(dentry->d_inode);
--

