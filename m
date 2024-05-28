Return-Path: <linux-kernel+bounces-192156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0DA8D1932
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D05E1F21FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4696E16C45C;
	Tue, 28 May 2024 11:14:22 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686443AA4
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894861; cv=none; b=im/YcOma48+5Q0PR4ngiFNLqHTTBMOBM9xtiLBxRdZT1uLtyHy4GVcHR83UvTucOqruOit6Pm++kzVRR9re1Vg3It4wwEW8++Ve6ZNuuxNEwH/hg8qvgPTSEzFh/cY67KyWLmd0fhr2ixSiX4k6sDMfNU9PuLV7lk2YIS1DNax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894861; c=relaxed/simple;
	bh=/gFFAU2auLhmhxu454w6yyFhUWIb3Wtfh3/SVGitNgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqwUMbDIpQh7jgVtnaRYhqPBRYghw/QuJfWGihLIfPpoYQbgvO+8+LDVIAeWE/b+9LfP0URj1GNngAfeNWXnQlwUnF4pAvNxMJHMp7fK8BPv3pYnKSQDKLYJlyBMxEq+D1ipJTYM6TxRwKkZgXyZy4VXN/x6tBjKHmS3eK3DsxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.255])
	by sina.com (10.185.250.21) with ESMTP
	id 6655BB390000097A; Tue, 28 May 2024 19:08:43 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9875393408442
X-SMAIL-UIID: B577EAE081C847F68FF11E5A971C23A2-20240528-190843-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Tue, 28 May 2024 19:08:30 +0800
Message-Id: <20240528110830.2701-1-hdanton@sina.com>
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
@@ -952,7 +952,13 @@ static int do_dentry_open(struct file *f
 	if (!open)
 		open = f->f_op->open;
 	if (open) {
+		struct super_block *sb = inode->i_sb;
+
+		error = -ENODEV;
+		if (!super_trylock_shared(sb))
+			goto cleanup_all;
 		error = open(inode, f);
+		up_read(&sb->s_umount);
 		if (error)
 			goto cleanup_all;
 	}
--

