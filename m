Return-Path: <linux-kernel+bounces-403447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA459C35D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15391C20DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28013C8F0;
	Mon, 11 Nov 2024 01:17:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529CA29
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731287874; cv=none; b=mfqxAmdUJ0h6OLaAVCbDXyjDGxUa+LoaCMakAA3P8fapOOypNKipX4upPhMutleflMTpzMGllyUSQ8lLeEajHAAUMNk9rp3rbFLMmCWaSD6Rdbhxym0eM8zMyYJM7uEiks7ETacDhAZTe2TpESt9MXWpmINjKYwpkRkL01fbzcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731287874; c=relaxed/simple;
	bh=lR3dZow86LqqLFTAsHoJ8ZdfBqU2d9l1E1FF55TUQKA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A4fjzNw3xnU6z9bB56WrGpfnehoaH8unpI8rwBvHFVplIlelLZNefh1hxclNreTup9MWblY1Uv4BSy/y4Wy6h/mg3xv5LCxerKYbaBuf957F+5LGPbb9obN7RvFEwTD4KUV/oEB6lIXQFIUW6GRXYlGgqb3yRoiD5DfY7bzRWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xms6J3Kp0zsRSw;
	Mon, 11 Nov 2024 09:15:04 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E12D1403A0;
	Mon, 11 Nov 2024 09:17:43 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Nov 2024 09:17:42 +0800
Subject: Re: [PATCH v3] ubifs: authentication: Fix use-after-free in
 ubifs_tnc_end_commit
To: Waqar Hameed <waqar.hameed@axis.com>, Richard Weinberger <richard@nod.at>,
	Sascha Hauer <s.hauer@pengutronix.de>
CC: <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <3712a732100057abc054833c6ec3ccc579eb647e.1731276611.git.waqar.hameed@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <5a3846c9-876f-b8e5-377c-42eafa3b775a@huawei.com>
Date: Mon, 11 Nov 2024 09:17:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3712a732100057abc054833c6ec3ccc579eb647e.1731276611.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/9 22:46, Waqar Hameed Ð´µÀ:
> After an insertion in TNC, the tree might split and cause a node to
> change its `znode->parent`. A further deletion of other nodes in the
> tree (which also could free the nodes), the aforementioned node's
> `znode->cparent` could still point to a freed node. This
> `znode->cparent` may not be updated when getting nodes to commit in
> `ubifs_tnc_start_commit()`. This could then trigger a use-after-free
> when accessing the `znode->cparent` in `write_index()` in
> `ubifs_tnc_end_commit()`.
> 
> This can be triggered by running
> 
>    rm -f /etc/test-file.bin
>    dd if=/dev/urandom of=/etc/test-file.bin bs=1M count=60 conv=fsync
> 
> in a loop, and with `CONFIG_UBIFS_FS_AUTHENTICATION`. KASAN then
> reports:
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
> The offending `memcpy()` in `ubifs_copy_hash()` has a use-after-free
> when a node becomes root in TNC but still has a `cparent` to an already
> freed node. More specifically, consider the following TNC:
> 
>           zroot
>           /
>          /
>        zp1
>        /
>       /
>      zn
> 
> Inserting a new node `zn_new` with a key smaller then `zn` will trigger
> a split in `tnc_insert()` if `zp1` is full:
> 
>           zroot
>           /   \
>          /     \
>        zp1     zp2
>        /         \
>       /           \
>    zn_new          zn
> 
> `zn->parent` has now been moved to `zp2`, *but* `zn->cparent` still
> points to `zp1`.
> 
> Now, consider a removal of all the nodes _except_ `zn`. Just when
> `tnc_delete()` is about to delete `zroot` and `zp2`:
> 
>           zroot
>               \
>                \
>                zp2
>                  \
>                   \
>                   zn
> 
> `zroot` and `zp2` get freed and the tree collapses:
> 
>             zn
> 
> `zn` now becomes the new `zroot`.
> 
> `get_znodes_to_commit()` will now only find `zn`, the new `zroot`, and
> `write_index()` will check its `znode->cparent` that wrongly points to
> the already freed `zp1`. `ubifs_copy_hash()` thus gets wrongly called
> with `znode->cparent->zbranch[znode->iip].hash` that triggers the
> use-after-free!
> 
> Fix this by explicitly setting `znode->cparent` to `NULL` in
> `get_znodes_to_commit()` for the root node. The search for the dirty
> nodes is bottom-up in the tree. Thus, when `find_next_dirty(znode)`
> returns NULL, the current `znode` _is_ the root node. Add an assert for
> this.
> 
> Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
> Tested-by: Waqar Hameed <waqar.hameed@axis.com>
> Co-developed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> Changes in v3:
> * Add "ubifs: authentication: ..." prefix to commit message subject
> * Rephrase the commit message with a short description of the problem at
>    the beginning.
> * Add `ubifs_assert(c, !znode->parent)` when `find_next_dirty()` returns
>    `NULL`.
> * Link to v2: https://lore.kernel.org/lkml/e7b5151bb1186e2342ed677cce0ef77592923084.1731088341.git.waqar.hameed@axis.com/
> 
> Changes in v2:
> * Implement the actual fix from discussions in RFC patch.
> * Link to first RFC version: https://lore.kernel.org/lkml/1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com/
> 
>   fs/ubifs/tnc_commit.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
> index a55e04822d16..7c43e0ccf6d4 100644
> --- a/fs/ubifs/tnc_commit.c
> +++ b/fs/ubifs/tnc_commit.c
> @@ -657,6 +657,8 @@ static int get_znodes_to_commit(struct ubifs_info *c)
>   		znode->alt = 0;
>   		cnext = find_next_dirty(znode);
>   		if (!cnext) {
> +			ubifs_assert(c, !znode->parent);
> +			znode->cparent = NULL;
>   			znode->cnext = c->cnext;
>   			break;
>   		}
> 


