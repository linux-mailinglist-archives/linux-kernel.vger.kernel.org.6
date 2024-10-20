Return-Path: <linux-kernel+bounces-373085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A75AE9A520A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B89B24BCE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 03:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB57462;
	Sun, 20 Oct 2024 03:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="t0bUb2Gm"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD6522F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729394094; cv=none; b=DNSh3aGzdiOoDfT+/h67bysUgPZOCXLk+fsKG42AK5hj1SHxaXC6eT8cP85BXGLi7Eybk5wxGo3OhJlWOKxdB4xi5mrmNZ4d2ldAaL4QRkjvnMMatFkzYHcYIY8dBnuLR83vJm9G/0+yiXOdyHYdHUfdhH+dU9cK3sZ/kVw+HDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729394094; c=relaxed/simple;
	bh=t7rAV19HF+s4oSEoJdeu5haeiT0Iv8hcm6RqZcuQYak=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tpLYDP502VmiQawxVciCtEBgRf4JMNMpgfl9yPpfJgG2tXdv1DOyXSW3CCvEkHVTrK09YoNLd/6pyIO0prnCD/joJuHC1Pl52DCguUQJpwH4stUCDb1VeKvpUYp4bWcR6xAg0BVzO+v1RYNkhrrSB/XexXJD9OjGVKhKwP7JrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=t0bUb2Gm; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729393781; bh=pTkYmTkOzMMx3C160krS8c6v1gMy6GS1btbDEZKllg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t0bUb2Gmg0RY3rA4KY9DqNpKHx+OIdxKGQhkBWM3a7jV58+3INxOXjfUS4IlL3qob
	 nDEW0/aII064lwaD8JIB2M70nagej7MNW0v913suKA1CNCkVotrJMF2YmmB5i2O6eu
	 bC3eeuFDQKDAYd3mmoJzuPYkBkbv/DmTmychrXMg=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 26702EBA; Sun, 20 Oct 2024 11:09:39 +0800
X-QQ-mid: xmsmtpt1729393779th0c6wf69
Message-ID: <tencent_CE9C9E131B1F4B491B1E25F3BA14BB123308@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wa3B8JXO/EbcnLDIo1RiwR7oVE2BX7mF3sqd3tJHr7yapZEgPro
	 2/Sbbx6YXFvfP+OPY6TFIb0tGFV3lSaUInpLXbFNoW+WzqJLJ6q/5ACg17IB2snetAYYZxwfy/yU
	 dpzGkcKnQP9c48+i/0VfOzvUukubBKboKQkJ6xdqGFwy435iDGVOyf65Xt4Hmh5f8ma+uU5ujlX2
	 2IiL12b4qf/B6nCYK6K+R5Ze51NQynZJ37I4ugHsyxgAdoj/LnTNjAzaBdf3BDDrJGppWImB3CuC
	 tzCkKrCsGv/Jov/jhiOadXJ/WkvqQRDyXJcUIrAPCOU+J/T6PkX9y6QLFEZOhwTidkoJvN9+hckN
	 8VsW2Jr/JItX61OgGzZ19pASBdfaCMT/Bo+sBK3gY4D1O3DX7UrLXOWhYh2EdagX7cDlLBiRhK+c
	 tCI0QmvrWJIYZjRgemMi4Ya4jQWkmMWkxIJLLuPJi2xqG/RXzg+Bmivnb5M83vPYWmvWAWa7996d
	 hzpO7cm0NnaPjvhOtzejwMgDClMg1MLp9ax5pk1XmZGbCU1lHruBWB9vc8OA48Ff7a0VF9WhRLrv
	 K7DWlKN8RE6dzeSLj123LOte2Jwe6I01uK+8Tp7fwfNJHmn84kczvEyQ1SHxUgRD4HvZorVGOQtY
	 oARvlKUAbElmT29BfoAth6rrWgyZUmERlr7iEczpjnFu0YF1RfGKLF+B9paypz8rlE0jWr/UoS3s
	 SJ2YDlzo+msJkHMDapPLmX5IffcRO+DcSmj/rmyK0tUYSiE4rdxJsf5AfzimHdvkPN680LIIda3z
	 2vTbB8AYCGxP260Q6CjNRL1lE0N7V5pdzd07/0xdHyNpLgyIfyirquXR+bvCcJfA6//18riyvWVx
	 SQAX/boV3QLUT4B8gReWwq7SgOmN20Hsg4zyUL7D5mxGEY3OexC4aX3Y0luiSZQO71tMAF67QCyc
	 /jarx+5nWjrlbkEq/XlpOvjcZ5KuuR
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9ef37ac20608f4836256@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] possible deadlock in nilfs_dirty_inode (4)
Date: Sun, 20 Oct 2024 11:09:39 +0800
X-OQ-MSGID: <20241020030938.2303274-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67134033.050a0220.1e4b4d.001f.GAE@google.com>
References: <67134033.050a0220.1e4b4d.001f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make sure all allocations with GFP_NOFS

#syz test

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index be6acf6e2bfc..183c16ad8776 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -252,11 +252,14 @@ static int nilfs_write_begin(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	int err = nilfs_transaction_begin(inode->i_sb, NULL, 1);
+	unsigned flags;
 
 	if (unlikely(err))
 		return err;
 
+	falgs = memalloc_nofs_save();
 	err = block_write_begin(mapping, pos, len, foliop, nilfs_get_block);
+	memalloc_nofs_restore(flags);
 	if (unlikely(err)) {
 		nilfs_write_failed(mapping, pos + len);
 		nilfs_transaction_abort(inode->i_sb);


