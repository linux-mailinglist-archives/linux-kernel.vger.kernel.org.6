Return-Path: <linux-kernel+bounces-345500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9100598B702
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE76B20F50
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C419AD4F;
	Tue,  1 Oct 2024 08:31:50 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE586199FCD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771510; cv=none; b=gbETlT+Ib/4Pk6BHN/MqRfd9P0Xlc7WjBgV4laipdApI8mk8YPWfBGEJsbJMBekCI0cVUbVJCR7Lb/t6bjxbeY5wY0ak++y6HiJUupVf0bWqVAoauuVv5d2tqemDkCKPPtmmIQkfcqH5tiJb4VvQumg4RlO5qRDfXsCk6+e9Z6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771510; c=relaxed/simple;
	bh=PCZ3l2IQcaXsjRpvxzEYgyfe6ufdvByHTTJwWBObvQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A44m1e+pwV2vFRUVX/oXoy+cKTTmhStIvz8PbZsrUbAlMgoA7X8eJcNfHm57YPn8mJkcU8z33TxVY3eVx+DzXOgR/LW8CT3dqI66OJ3oK+PkZuixOCbYsrH03QG7nHolrklmPJC7d/C3u2ChFVsGEQh7jkKH2HZXC95QN98Q/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.0])
	by sina.com (10.185.250.24) with ESMTP
	id 66FBB36800000B39; Tue, 1 Oct 2024 16:31:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 98588510748251
X-SMAIL-UIID: 7E2E223CAF264B2A8FA21EB8A4C39402-20241001-163138-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8aaf2df2ef0164ffe1fb@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel] WARNING: locking bug in try_to_wake_up
Date: Tue,  1 Oct 2024 16:31:26 +0800
Message-Id: <20241001083126.1792-1-hdanton@sina.com>
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
@@ -4316,7 +4316,6 @@ void __cold close_ctree(struct btrfs_fs_
 		btrfs_error_commit_super(fs_info);
 
 	kthread_stop(fs_info->transaction_kthread);
-	kthread_stop(fs_info->cleaner_kthread);
 
 	ASSERT(list_empty(&fs_info->delayed_iputs));
 	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
@@ -4349,6 +4348,7 @@ void __cold close_ctree(struct btrfs_fs_
 	 */
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 	btrfs_stop_all_workers(fs_info);
+	kthread_stop(fs_info->cleaner_kthread);
 
 	/* We shouldn't have any transaction open at this point */
 	warn_about_uncommitted_trans(fs_info);
--

