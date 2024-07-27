Return-Path: <linux-kernel+bounces-264294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2AF93E15E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 00:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D701F216B9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642F642058;
	Sat, 27 Jul 2024 22:41:10 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA1D33CC4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722120070; cv=none; b=P5x5/nyD4MnO9BVW8dsn+Fu8YfU+wMsvnfhliy9xbJMJbTKlQQr9OOQmVv5S3CkGHXfPc7f2VeiFx77hfn5SSoe1RqOZgFeWqxj7syVYljGCk7n7hMSsBfIGiXZLzaGS8aK7+H3n9wa9hSquUmgO9AfjQGEPzGZSMujrSO1vKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722120070; c=relaxed/simple;
	bh=LdXdCGiMj5U/WkM8EQiTLpnZ4bnFsbvEC0o1YKJld2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gme6O9jvgQpnDGdnoQaP27XlXmLcAnV1EICtM+W3q8//WDKEUWokIz3gdGgULlFen59xyiA/YNBIn3xkWogGVUMlhfBNKfTyyT3BZx1HJ2MIGxRR3ObMvEfDaqQvBlbq72wQXB4mOp/ejI7mW736DCBA/gRc2r4ZMa5cNMzjej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.198])
	by sina.com (10.185.250.21) with ESMTP
	id 66A5777200003257; Sat, 28 Jul 2024 06:40:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8692113408428
X-SMAIL-UIID: 02FD4D3953BF4DBB8483C1B8073C870C-20240728-064052-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c1751b6739d83d70bb75@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_file_mmap
Date: Sun, 28 Jul 2024 06:40:40 +0800
Message-Id: <20240727224040.2248-1-hdanton@sina.com>
In-Reply-To: <00000000000038f243061e3ad3fe@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jul 2024 06:44:20 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2f8c4f506285 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e875a1980000

#syz test upstream  2f8c4f506285

--- x/fs/ntfs3/file.c
+++ y/fs/ntfs3/file.c
@@ -365,7 +365,10 @@ static int ntfs_file_mmap(struct file *f
 		}
 
 		if (ni->i_valid < to) {
-			inode_lock(inode);
+			if (!inode_trylock(inode)) {
+				err = -EDEADLK;
+				goto out;
+			}
 			err = ntfs_extend_initialized_size(file, ni,
 							   ni->i_valid, to);
 			inode_unlock(inode);
--

