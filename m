Return-Path: <linux-kernel+bounces-248545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7C092DEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B791F224A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7AC17BBB;
	Thu, 11 Jul 2024 03:06:36 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA5175A1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720667196; cv=none; b=bklUy5K49DoWu5ke04drR3Pl8qhNAksQPKK9xeztkl+arxMzG3R1i/upcwPrMykqTkWUvZnLjd3DWla1Wrt0BHwGhCljO3xq0/p2kRRD67cd3IL+URMr/R4q+Xxpx2MXuzxXXLga3s1KcbyQ4Q6RUEh/QglQY9g6HQohdW8ugm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720667196; c=relaxed/simple;
	bh=zJUK6J/NYVhEQe7c74t0ge1PW15evCmnHL4WppNcYI0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dgWRYm4gF1CdqghuPrkXPbgyxoI+e3H3tVANv2SYiBTNAYXz0HlrXHiQDjtxdDTtA6kPRjDoksguabdzUEFMasgwMnQzkEPBaVdPr6drZkfhWqv4nBrTtZRNPPAdhVzIWHxIId8b2Azd6lJId9xF2eFxEa2BPNa2l7jiIJM/UkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WKKJh2Ns8z2Cl7k;
	Thu, 11 Jul 2024 11:02:12 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 6053B1A0188;
	Thu, 11 Jul 2024 11:06:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 11 Jul
 2024 11:06:24 +0800
From: Wang Zhaolong <wangzhaolong1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>
Subject: [RFC 0/1] ubifs: inode deletion deadlock 
Date: Thu, 11 Jul 2024 11:06:23 +0800
Message-ID: <20240711030624.266440-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200001.china.huawei.com (7.185.36.224)

Hi.

While the previous patch set [1] aimed to address the ABBA deadlock between
inode reclaiming and deleted inode writing, I discovered that the problem
still persists in the form of an AA deadlock after applying those changes.

The core issue is that although [1] avoids the ABBA deadlock by getting the
xattr inodes before locking BASEHD's wbuf->io_mutex. But the inode reclaiming
process can still get stuck waiting for the xattr inodes that have already
been marked as I_FREEING.

root@debian:~# cat /proc/537/stack
[<0>] __wait_on_freeing_inode+0xb2/0xf0
[<0>] find_inode_fast.isra.0+0x63/0xb0
[<0>] iget_locked+0x72/0x1c0
[<0>] ubifs_iget+0x3e/0x5c0 [ubifs]
[<0>] ubifs_jnl_write_inode+0x11f/0x6c0 [ubifs]
[<0>] ubifs_evict_inode.cold+0x39/0x6a [ubifs]
[<0>] evict+0xd1/0x1a0
[<0>] inode_lru_isolate+0x238/0x2b0
[<0>] __list_lru_walk_one+0x77/0x150
[<0>] list_lru_walk_one+0x4a/0x70
[<0>] prune_icache_sb+0x49/0x80
[<0>] super_cache_scan+0x124/0x1b0
[<0>] do_shrink_slab+0x13e/0x2c0
[<0>] shrink_slab+0xac/0x2b0
[<0>] drop_slab_node+0x45/0x90
[<0>] drop_slab+0x38/0x70
[<0>] drop_caches_sysctl_handler+0x74/0x90
[<0>] proc_sys_call_handler+0x143/0x260
[<0>] new_sync_write+0x116/0x1c0
[<0>] vfs_write+0x1b7/0x250
[<0>] ksys_write+0x5f/0xe0
[<0>] do_syscall_64+0x33/0x40
[<0>] entry_SYSCALL_64_after_hwframe+0x67/0xd1
root@debian:~# cat /proc/541/stack
[<0>] __wait_on_freeing_inode+0xb2/0xf0
[<0>] find_inode_fast.isra.0+0x63/0xb0
[<0>] iget_locked+0x72/0x1c0
[<0>] ubifs_iget+0x3e/0x5c0 [ubifs]
[<0>] ubifs_jnl_write_inode+0x11f/0x6c0 [ubifs]
[<0>] ubifs_evict_inode.cold+0x39/0x6a [ubifs]
[<0>] evict+0xd1/0x1a0
[<0>] do_unlinkat+0x1df/0x2f0
[<0>] do_syscall_64+0x33/0x40
[<0>] entry_SYSCALL_64_after_hwframe+0x67/0xd1

The root cause of the problem lies in two aspects:

1. UBIFS uses inodes to represent xattrs.
2. During the eviction process, iget_locked(), which waits for I_FREEING,
   is called again.

Therefore, in this patch, I aim to provide a solution that avoids
waiting within the eviction process. However, I must admit that my
current code implementation is not very elegant and could be improved.

Wang Zhaolong (1):
  ubifs: avoid deadlock when deleting an inode with xattr

 fs/ubifs/journal.c | 42 ++++++++++++++++++++++++++++++++++--------
 fs/ubifs/super.c   | 15 +++++++++++++++
 fs/ubifs/ubifs.h   |  1 +
 fs/ubifs/xattr.c   | 12 +++++++-----
 4 files changed, 57 insertions(+), 13 deletions(-)

-- 
2.34.3


