Return-Path: <linux-kernel+bounces-214916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721A908C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77439B23817
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B5199E82;
	Fri, 14 Jun 2024 12:48:36 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B47195F1D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369316; cv=none; b=bRR2jv/8sdgdi7zha3aEUaynO3q8CXVlbDNnT7dABcag29BwiE/xpf9+K89Hq8S3AoDc+FSU+Z5b6+qSW9i4ht/O3yQ799EZQ+G/mLY5U8DQdaJByFJfpRRkzY0QEiiEo/kFKmcrw+pp54ANvgX1jU/4c2mNkna4MDgyIh0sCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369316; c=relaxed/simple;
	bh=RnmKOna3nYue/o4cvIy7xgOLKViUK5SNZJN5+9nxjrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQa0XnaB5VvVhawjnzWO9LGr/AFZhLYbDWhEDLa2VsTGMMbPQxh1vj7/eSURKxqYuasKegBQc7wWLwdJ63irLFk6W2q1LP4EDJHNC2pRJl4ZWlaLfkgfCtZrGRfwD3s2M1/F3TdMA5Wg1rVR031YZJygOr6uYGzHxZkexPNyEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.97])
	by sina.com (172.16.235.24) with ESMTP
	id 666C3C1300007525; Fri, 14 Jun 2024 20:48:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 65500945089441
X-SMAIL-UIID: 2912F4638ABA4588BCB67CB5842AE2A2-20240614-204821-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Fri, 14 Jun 2024 20:48:11 +0800
Message-Id: <20240614124811.689-1-hdanton@sina.com>
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
+			if (a == atomic_cmpxchg(&sb->s_active, a a+1))
+				break;
+		}
 		error = open(inode, f);
+		deactivate_super(sb);
 		if (error)
 			goto cleanup_all;
 	}
--

