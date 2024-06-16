Return-Path: <linux-kernel+bounces-216146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E55F909BEC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 08:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F85B22E61
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EE316D9B5;
	Sun, 16 Jun 2024 06:33:18 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BD16F0DD
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718519597; cv=none; b=XJJhIV5vdSzcnkVNleeHRNvOrVmsWlMoGgIfQJ3dCgMkbr8IiJDJ0jjrU/vDSUFdxUY6kTvIZ+deEkJmRfSXJSf1KfQ94u4RH9hidK4Nb8LhCXrp2JFdOzoQYrxcRwLsfi5YHrUa/E3optwwMvCn9qraj0fEybqN2WsDhZ8G8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718519597; c=relaxed/simple;
	bh=RkDUC72NplqItLpzX1fqE4SV2IKmpl2/vpxNEajZ7dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTNkHV8H62v8he0wJyWVfAVPp/Ca27slr54H7lAjSkv1LIfykv9ZrZ3lxQcBC0+/wGrEX6FhuEpZtx9egsfg0P3HLB6IMxDaPUcejs9n/TINMLpNUBCBgx9/kCjlLlmbYg3qwX53Q4M+U0SoBOv0vi8ypXcqNk9PFsrUgBc2FBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.2])
	by sina.com (172.16.235.25) with ESMTP
	id 666E872200002C1C; Sun, 16 Jun 2024 14:33:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 55163934210318
X-SMAIL-UIID: 36CC5AC86D914D71A4F4F763510731BD-20240616-143308-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Sun, 16 Jun 2024 14:32:56 +0800
Message-Id: <20240616063256.1356-1-hdanton@sina.com>
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
@@ -952,6 +952,12 @@ static int do_dentry_open(struct file *f
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

