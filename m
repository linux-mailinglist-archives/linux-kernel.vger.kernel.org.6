Return-Path: <linux-kernel+bounces-362423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F1899B4D2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465822834B9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD416DED5;
	Sat, 12 Oct 2024 12:30:26 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47186149E1A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728736225; cv=none; b=OxoeAQ+AhSTDALH+jKX6IvUUMo6jm1Xu7RlRNGL5XRTnTGGsPeMqqNXhV9WNOGrnbvTF3xq334jtt7hr4FYhpfbuNGBFCUl1eTYegM+O4Wm70DZwpQmSOWNXlP6tB1bzIrMcpSNwwKL3jSllcritUq2ImeiGPKk0AqB5+t8zzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728736225; c=relaxed/simple;
	bh=QHLkF5gDlFSxRHzb9sH9SC/74/DEMscMZ9T/FKrKBJE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UQv6rW5ELuIz/6sX2HWEc7aisU+YogB4di2O5qdPwTnjl3vdTgoRS+UdDxUWNPBw+mboZmXU5p5T/PwoDTYDmwu/ZdmUyqOrVq9cp5Nr0rr7uew8yzUVHVCFWcrOD5xumAIOYj1h1oeDrDdzyrIJdyI1aMjGZ04sW1F5oRa5paI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XQjTy1bxnz1j9mH;
	Sat, 12 Oct 2024 20:29:10 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 38D64180019;
	Sat, 12 Oct 2024 20:30:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Oct 2024 20:30:18 +0800
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
To: Waqar Hameed <waqar.hameed@axis.com>, Richard Weinberger <richard@nod.at>,
	Sascha Hauer <s.hauer@pengutronix.de>
CC: <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <5173d3d2-4a6b-8b0b-c8f7-8034c9763532@huawei.com>
Date: Sat, 12 Oct 2024 20:30:17 +0800
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
> The offending `memcpy` is in `ubifs_copy_hash()`. Fix this by checking
> if the `znode` is obsolete before accessing the hash (just like we do
> for `znode->parent`).

Do you mean that the UAF occurs in following path:
do_commit -> ubifs_tnc_end_commit -> write_index:
while (1) {
    ...
    znode = cnext;
    ...
    if (znode->cparent)
      ubifs_copy_hash(c, hash, 
znode->cparent->zbranch[znode->ciip].hash);  // znode->cparent has been 
freed!
}

If so, according to the current implementation(lastest linux kernel is 
v6.12), I cannot understand that how the znode->cparent is freed before 
write_index() finished, it looks impossible.
All dirty znodes are gathered by function get_znodes_to_commit() which 
is protected by c->tnc_mutex, and the 'cparent' member in all dirty 
znodes is assigned with non-NULL. Then I think the znode memory freeing 
path 'tnc_delete->kfree(znode)' cannot happen, because:
1) If a znode is dirtied, all its' ancestor znodes(a path from znode to 
root znode) must be dirtied, which is guaranteed by UBIFS. See 
dirty_cow_bottom_up/lookup_level0_dirty.
2) A dirty znode waiting for commit cannot be freed before write_index() 
finished, which is guaranteed by tnc_delete:
   if (znode->cnext) {
     __set_bit(OBSOLETE_ZNODE, &znode->flags);
     ...
   } else {
     kfree(znode);
   }
> 
> Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> I'm not entirely sure if this is the _correct_ way to fix this. However,
> testing shows that the problem indeed disappears.
> 
> My understanding is that the `znode` could concurrently be deleted (with
> a reference in an unprotected code section without `tnc_mutex`). The
> assumption is that in this case it would be sufficient to check
> `ubifs_zn_obsolete(znode)`, like as in the if-statement for
> `znode->parent` just below.

I'm analyzing tnc-related code these days, however I can't find places 
that may concurrently operate the same znode. And I cannot reproduce the 
problem with your reproducer:
while true; do
   rm -f /UBIFS_MNT/test-file.bin
   dd if=/dev/urandom of=/UBIFS_MNT/test-file.bin bs=1M count=60 conv=fsync
done

Can you dig more deeper by adding more debug message, so that we can 
figure out what is really happening.
> 
> I'll be happy to get any helpful feedback!
> 
>   fs/ubifs/tnc_commit.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
> index a55e04822d16..0b358254272b 100644
> --- a/fs/ubifs/tnc_commit.c
> +++ b/fs/ubifs/tnc_commit.c
> @@ -891,8 +891,10 @@ static int write_index(struct ubifs_info *c)
>   		mutex_lock(&c->tnc_mutex);
>   
>   		if (znode->cparent)
> -			ubifs_copy_hash(c, hash,
> -					znode->cparent->zbranch[znode->ciip].hash);
> +			if (!ubifs_zn_obsolete(znode))
> +				ubifs_copy_hash(c, hash,
> +					znode->cparent->zbranch[znode->ciip]
> +					.hash);
>   
>   		if (znode->parent) {
>   			if (!ubifs_zn_obsolete(znode))
> 


