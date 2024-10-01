Return-Path: <linux-kernel+bounces-345090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEDC98B1EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2065B1C20CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFFE22094;
	Tue,  1 Oct 2024 01:50:04 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9ACC8C0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747404; cv=none; b=cC4T1mfll1zihY36R98hbRHYAyivJv4PEExRnqvZmQDR5QatVFChHTgraxfISDq+1AI1pO/2YtmZuIdEhwOrLQgeI0ftH//3Hd2izMqOL8dSa4Ah0ANlfwbAItCWhfZRxQiPAICz2JWpAyoqMZtS7f808oHn1fbJvA2gs72bt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747404; c=relaxed/simple;
	bh=A+YoB8ay4PZPw8P4WlusllumHZj6DrlxZWmxADkJM08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C3zntjvXLjRC4ge3JR1xYMA3SrnVAKowdMgHTPNhySc53Q3xVr4uPiU8NAn9l6joMFVyNx9RcCgq+r4focIot/xGkMcmaVeI5rHAcwhwde1iwLUfl0sjZmwdyJ/dL3xKU3nmdzVLFHBwClhsYcqJH3ftUgSzIQ5pGRW3ZVjxbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.0])
	by sina.com (10.185.250.23) with ESMTP
	id 66FB553C00001D0B; Tue, 1 Oct 2024 09:49:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1605918913454
X-SMAIL-UIID: 0C32306F838240A69C41A3BBB3802020-20241001-094952-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8aaf2df2ef0164ffe1fb@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel] WARNING: locking bug in try_to_wake_up
Date: Tue,  1 Oct 2024 09:49:39 +0800
Message-Id: <20241001014939.1736-1-hdanton@sina.com>
In-Reply-To: <66fb36b1.050a0220.aab67.003b.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 16:39:29 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    9852d85ec9d4 Linux 6.12-rc1
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ad839f980000

#syz test

--- x/fs/btrfs/disk-io.c
+++ y/fs/btrfs/disk-io.c
@@ -4315,9 +4315,6 @@ void __cold close_ctree(struct btrfs_fs_
 	if (BTRFS_FS_ERROR(fs_info))
 		btrfs_error_commit_super(fs_info);
 
-	kthread_stop(fs_info->transaction_kthread);
-	kthread_stop(fs_info->cleaner_kthread);
-
 	ASSERT(list_empty(&fs_info->delayed_iputs));
 	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
 
@@ -4349,6 +4346,8 @@ void __cold close_ctree(struct btrfs_fs_
 	 */
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 	btrfs_stop_all_workers(fs_info);
+	kthread_stop(fs_info->transaction_kthread);
+	kthread_stop(fs_info->cleaner_kthread);
 
 	/* We shouldn't have any transaction open at this point */
 	warn_about_uncommitted_trans(fs_info);
--

