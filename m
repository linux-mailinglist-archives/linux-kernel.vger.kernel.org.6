Return-Path: <linux-kernel+bounces-215615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B692B9094EE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FAFCB211BC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2342635;
	Sat, 15 Jun 2024 00:05:38 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12250624
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718409938; cv=none; b=ceXktShEa68lNn2s3OnIM3qKEQ9x3XpCTF6DwD4Ac1jxNbn57XvgSQNC3WN0juq9SvuqpTmbK18cp+/SvsqPPM3p+XUbP1G1FLWe4X1et7B9Sn+5mM2UZO86wwBKbQo5O5QmTVPDrikejut+W/+xdaFkxbd7Mdp+Kz1mE0E35f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718409938; c=relaxed/simple;
	bh=Txqx05lA5LCNNLfiBhVlh+gJ8bDP80qJQBV6kbq9pbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMpsiFV2GvsVxRGeae/HWLJEuz2Jk3K4CPBLS6618KCUV1Riu3808vQP0IEkY6uiWMJsTtGpcujhEox7K0i0BtrtFu1quH4W/2kBZTV4mBYPrD2SJbNirK7YO6+CIvQVOAUlP4JxabRuIbNeFOyicp5XZNYafN0SN+wfTk7BizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.75])
	by sina.com (172.16.235.24) with ESMTP
	id 666CDAA1000029F8; Sat, 15 Jun 2024 08:04:51 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 22004145089287
X-SMAIL-UIID: D5AD2C2BE59F4C98BAAE19EB3E4F858D-20240615-080451-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Sat, 15 Jun 2024 08:04:41 +0800
Message-Id: <20240615000441.861-1-hdanton@sina.com>
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
@@ -952,7 +952,18 @@ static int do_dentry_open(struct file *f
 	if (!open)
 		open = f->f_op->open;
 	if (open) {
+		struct super_block *sb = inode->i_sb;
+
+		error = -EINVAL;
+		for (;;) {
+			int a = atomic_read(&sb->s_active);
+			if (a < 2)
+				goto cleanup_all;
+			if (a == atomic_cmpxchg(&sb->s_active, a, a+1))
+				break;
+		}
 		error = open(inode, f);
+		deactivate_super(sb);
 		if (error)
 			goto cleanup_all;
 	}
--

