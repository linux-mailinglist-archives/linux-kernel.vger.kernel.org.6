Return-Path: <linux-kernel+bounces-194043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C08D35D3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C2B285E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B2A1802DE;
	Wed, 29 May 2024 11:54:53 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14511BC57
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716983693; cv=none; b=pFiuCC/W8FbJVkYoOXhyfwixMvjR2sWYKg3Ev9TPDiy7WgRa9oRgYID5KAWaMegk2oz2eqkjQYZnk1sLuZuQpL2/NDM5tUxGclwvg4qVCjMLXXx32HD9EchFK3eaJodFrZ2FEdnjoO3u+9tGsCVy04Mb7xbRJuPgfIA3lUIR4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716983693; c=relaxed/simple;
	bh=6sV6W3xEzbKwzUUXOHrOWUHZ1xLmAfdGarqfQ6waobc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnJtWs/zrke16PwXHC0CAXuR5j60tCBKEVaonHaSkLeGUyRMi+2+wfddadfjyek/+yBHFeNZOemx3vNRHwFtIGXh+I/zPrWrsXE3UGMEQ9gvQoNwEbCyhPe5Qgoy/TK64bRnkR7ciuR8UIAffc1rjqsX/RARbyWzKiOjGySNWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.5])
	by sina.com (10.75.12.45) with ESMTP
	id 6657163C00004C34; Wed, 29 May 2024 19:49:18 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 66334531458002
X-SMAIL-UIID: 32EC0D550B704E8F8CDE9584ED7A08B1-20240529-194918-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Wed, 29 May 2024 19:49:06 +0800
Message-Id: <20240529114906.2905-1-hdanton@sina.com>
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
@@ -906,9 +906,13 @@ static int do_dentry_open(struct file *f
 {
 	static const struct file_operations empty_fops = {};
 	struct inode *inode = f->f_path.dentry->d_inode;
+	struct dentry *d = f->f_path.dentry;
 	int error;
 
+	if (!lockref_get_not_zero(&d->d_lockref))
+		return -ENODEV;
 	path_get(&f->f_path);
+	dput(d);
 	f->f_inode = inode;
 	f->f_mapping = inode->i_mapping;
 	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
--

