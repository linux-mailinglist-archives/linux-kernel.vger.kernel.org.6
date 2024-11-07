Return-Path: <linux-kernel+bounces-399524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB339C0028
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13519283606
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78399199EA8;
	Thu,  7 Nov 2024 08:39:49 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908EC2ED
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968789; cv=none; b=bTXp/2eixtAzqHetF5HHWLKso5+7RxE+ii3J3irt0gHiWoTJm3wLe5RwI2uimFZ1n7TLQh7l9X3mJJOOginrasU/u63ZYTugUBULMB2M6QqWHxhdli2qqBTbfjqbBqX3mdKjQwhDN06X0lKkkiHTaRAy9Z/qlCSidgqMohpMpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968789; c=relaxed/simple;
	bh=5AuA8vocEZm36Mrb/IOxZall9HGxFfk4cvHc/ZvHSjo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ejCDyc0Ew42MhzuK9Zd5tthxfPMgnpinyOfLTl3uKt+YTQ4R6nMLypFSxcrDbrtMi5RKfz2Snd9xuRxMjT68oXx9DWHl/LrNWxsnR+cDSKl55H0ERRAle7sA9vNjpMXLV3grqvQlo3824wvDw9oYL7HqIj5Toi8pIfaFGa5x3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xkb7D20N1z1SCjb;
	Thu,  7 Nov 2024 16:38:00 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 1837F1A0188;
	Thu,  7 Nov 2024 16:39:43 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 16:39:42 +0800
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
To: Waqar Hameed <waqar.hameed@axis.com>, Richard Weinberger <richard@nod.at>,
	Sascha Hauer <s.hauer@pengutronix.de>
CC: <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryder Wang <rydercoding@hotmail.com>
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0f040e0a-c27f-2f29-6d9e-9c7152a18513@huawei.com>
Date: Thu, 7 Nov 2024 16:39:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/9 22:46, Waqar Hameed Ð´µÀ:
> Running
> 
>    rm -f /etc/test-file.bin
>    dd if=/dev/urandom of=/etc/test-file.bin bs=1M count=60 conv=fsync
> 
> in a loop, with `CONFIG_UBIFS_FS_AUTHENTICATION`, KASAN reports:
> 
>    BUG: KASAN: use-after-free in ubifs_tnc_end_commit+0xa5c/0x1950
>    Write of size 32 at addr ffffff800a3af86c by task ubifs_bgt0_20/153
> 
>    Call trace:
>     dump_backtrace+0x0/0x340
>     show_stack+0x18/0x24
>     dump_stack_lvl+0x9c/0xbc
>     print_address_description.constprop.0+0x74/0x2b0
>     kasan_report+0x1d8/0x1f0
>     kasan_check_range+0xf8/0x1a0
>     memcpy+0x84/0xf4
>     ubifs_tnc_end_commit+0xa5c/0x1950
>     do_commit+0x4e0/0x1340
>     ubifs_bg_thread+0x234/0x2e0
>     kthread+0x36c/0x410
>     ret_from_fork+0x10/0x20
> 
>    Allocated by task 401:
>     kasan_save_stack+0x38/0x70
>     __kasan_kmalloc+0x8c/0xd0
>     __kmalloc+0x34c/0x5bc
>     tnc_insert+0x140/0x16a4
>     ubifs_tnc_add+0x370/0x52c
>     ubifs_jnl_write_data+0x5d8/0x870
>     do_writepage+0x36c/0x510
>     ubifs_writepage+0x190/0x4dc
>     __writepage+0x58/0x154
>     write_cache_pages+0x394/0x830
>     do_writepages+0x1f0/0x5b0
>     filemap_fdatawrite_wbc+0x170/0x25c
>     file_write_and_wait_range+0x140/0x190
>     ubifs_fsync+0xe8/0x290
>     vfs_fsync_range+0xc0/0x1e4
>     do_fsync+0x40/0x90
>     __arm64_sys_fsync+0x34/0x50
>     invoke_syscall.constprop.0+0xa8/0x260
>     do_el0_svc+0xc8/0x1f0
>     el0_svc+0x34/0x70
>     el0t_64_sync_handler+0x108/0x114
>     el0t_64_sync+0x1a4/0x1a8
> 
>    Freed by task 403:
>     kasan_save_stack+0x38/0x70
>     kasan_set_track+0x28/0x40
>     kasan_set_free_info+0x28/0x4c
>     __kasan_slab_free+0xd4/0x13c

Hi Waqar, is that line 2639 ?
2540 sstatic int tnc_delete()
2541 {
2608         if (!znode->parent) {
2609                 while (znode->child_cnt == 1 && znode->level != 0) {
2634                         if (zp->cnext) {
...
2638                         } else
2639                                 kfree(zp);
2644 }

>     kfree+0xc4/0x3a0
>     tnc_delete+0x3f4/0xe40
>     ubifs_tnc_remove_range+0x368/0x73c
>     ubifs_tnc_remove_ino+0x29c/0x2e0
>     ubifs_jnl_delete_inode+0x150/0x260
>     ubifs_evict_inode+0x1d4/0x2e4
>     evict+0x1c8/0x450
>     iput+0x2a0/0x3c4
>     do_unlinkat+0x2cc/0x490
>     __arm64_sys_unlinkat+0x90/0x100
>     invoke_syscall.constprop.0+0xa8/0x260
>     do_el0_svc+0xc8/0x1f0
>     el0_svc+0x34/0x70
>     el0t_64_sync_handler+0x108/0x114
>     el0t_64_sync+0x1a4/0x1a8
> 

Looks like there is one possibility:
1. tnc_insert() triggers a TNC tree split:
    zroot
    /
   z_p1
   /
zn
   z_p1 is full, after inserting zn_new(key order is smaller that zn) 
under z_p1, zn->parent is switched to z_p2, but zn->cparent is still z_p1:
    zroot
    /    \
   z_p1  z_p2
   /      \
zn_new   zn
2. tnc_delete() removes all znodes except the 'zn':
    zroot
       \
       z_p2
         \
         zn
     TNC tree is collapsed, zroot and z_p2 are freed:
     zroot'(zn)
3. get_znodes_to_commit() finds only one znode(zn, which is also zroot), 
zn->cparent is not updated and still points to z_p1(which was freed).
4. write_index() accesses the zn->cparent->zbranch, which triggers an UAF!

Try following modification to verify whether the problem is fixed:
diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index a55e04822d16..7c43e0ccf6d4 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -657,6 +657,8 @@ static int get_znodes_to_commit(struct ubifs_info *c)
                 znode->alt = 0;
                 cnext = find_next_dirty(znode);
                 if (!cnext) {
+                       ubifs_assert(c, !znode->parent);
+                       znode->cparent = NULL;
                         znode->cnext = c->cnext;
                         break;
                 }

