Return-Path: <linux-kernel+bounces-174656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E88C1249
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068FC1F21E99
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471F116F287;
	Thu,  9 May 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmxnUoNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27D3F8E2
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269980; cv=none; b=ql9YRQdnmVAhwiuJZpdvvs0nOR/VYRcHRqhFhmjEnhojytUapqpZJMu+Y1zooMXRz/G8wsTgPZxp3HZ0vkm51Dka2b03uzM6A3oI1vgEziek7jhKQhWCMEYgagO/9vCe1ED0IqDJc8BpgQcld6O4ZsFIUHFvS39Z2+nV0xc9rzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269980; c=relaxed/simple;
	bh=EyTwGmTH6PChSbRLYLFE7d/gisUiJhHgzpqM5Qc1hCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKM2C0szJZBkyPNgzNvOi+L2LvWzbk/erJVxahPO3m+hzcO4pzKWh4iXC4AO8Ul5wEsvgxbfVGgDfNqBHHMOjXQuEdmqmQL4eZnYU8IkaF/gbYM7Q8WE/uduqWj89tbWUHL4m4eoWJjhHF8GQ1q5Jndrx8EYdkczjQgc6hwGj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmxnUoNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57E6C116B1;
	Thu,  9 May 2024 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715269980;
	bh=EyTwGmTH6PChSbRLYLFE7d/gisUiJhHgzpqM5Qc1hCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fmxnUoNQ0HMljqxekQNwpiEU3pr0qzZotqFdeU4FWe3sUCVO+IoCENO4XfPH8b1Ul
	 yogZ/YJVL48PLj6Ap7nnQAwUbF5OXNS9AznxxtHWMK3uGWbhAi4ba0JNNgrfCOgM2L
	 WyCNt4Vxs8xQOEEJqm5jHhevpo6XNievOB+5oq7kEFKQkHTTpKzXLUe+XeJ17403wd
	 mMkD4nphS0bsjc58yKG+4w2yerBPmBx0Q/D9U8WJAy+mbKo35/IZ/YHmk3ZMRh0anG
	 jxCadXoIv7wLGBL7onfgPHfs/ppPgUWGk0Hl10u8yVivifSP3jY9Os6iPvLvYMipY7
	 9FSyB/GP8xfVw==
Date: Thu, 9 May 2024 15:52:58 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
Subject: Re: [PATCH 3/3] f2fs: fix to do sanity check on i_nid for
 inline_data inode
Message-ID: <ZjzxWp4-wmpCzBeB@google.com>
References: <20240506103313.773503-1-chao@kernel.org>
 <20240506103313.773503-3-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506103313.773503-3-chao@kernel.org>

On 05/06, Chao Yu wrote:
> syzbot reports a f2fs bug as below:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/inline.c:258!
> CPU: 1 PID: 34 Comm: kworker/u8:2 Not tainted 6.9.0-rc6-syzkaller-00012-g9e4bc4bcae01 #0
> RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
> Call Trace:
>  f2fs_write_single_data_page+0xb65/0x1d60 fs/f2fs/data.c:2834
>  f2fs_write_cache_pages fs/f2fs/data.c:3133 [inline]
>  __f2fs_write_data_pages fs/f2fs/data.c:3288 [inline]
>  f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3315
>  do_writepages+0x35b/0x870 mm/page-writeback.c:2612
>  __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1650
>  writeback_sb_inodes+0x905/0x1260 fs/fs-writeback.c:1941
>  wb_writeback+0x457/0xce0 fs/fs-writeback.c:2117
>  wb_do_writeback fs/fs-writeback.c:2264 [inline]
>  wb_workfn+0x410/0x1090 fs/fs-writeback.c:2304
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>  kthread+0x2f2/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> The root cause is: inline_data inode can be fuzzed, so that there may
> be valid blkaddr in its direct node, once f2fs triggers background GC
> to migrate the block, it will hit f2fs_bug_on() during dirty page
> writeback.
> 
> Let's add sanity check on i_nid field for inline_data inode, meanwhile,
> forbid to migrate inline_data inode's data block to fix this issue.
> 
> Reported-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000d103ce06174d7ec3@google.com
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h   |  2 +-
>  fs/f2fs/gc.c     |  6 ++++++
>  fs/f2fs/inline.c | 17 ++++++++++++++++-
>  fs/f2fs/inode.c  |  2 +-
>  4 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index fced2b7652f4..c876813b5532 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4146,7 +4146,7 @@ extern struct kmem_cache *f2fs_inode_entry_slab;
>   * inline.c
>   */
>  bool f2fs_may_inline_data(struct inode *inode);
> -bool f2fs_sanity_check_inline_data(struct inode *inode);
> +bool f2fs_sanity_check_inline_data(struct inode *inode, struct page *ipage);
>  bool f2fs_may_inline_dentry(struct inode *inode);
>  void f2fs_do_read_inline_data(struct page *page, struct page *ipage);
>  void f2fs_truncate_inline_inode(struct inode *inode,
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e86c7f01539a..041957750478 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1563,6 +1563,12 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  				continue;
>  			}
>  
> +			if (f2fs_has_inline_data(inode)) {
> +				iput(inode);
> +				set_sbi_flag(sbi, SBI_NEED_FSCK);
> +				continue;

Any race condtion to get this as false alarm?

> +			}
> +
>  			err = f2fs_gc_pinned_control(inode, gc_type, segno);
>  			if (err == -EAGAIN) {
>  				iput(inode);
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index ac00423f117b..067600fed3d4 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -33,11 +33,26 @@ bool f2fs_may_inline_data(struct inode *inode)
>  	return !f2fs_post_read_required(inode);
>  }
>  
> -bool f2fs_sanity_check_inline_data(struct inode *inode)
> +static bool has_node_blocks(struct inode *inode, struct page *ipage)
> +{
> +	struct f2fs_inode *ri = F2FS_INODE(ipage);
> +	int i;
> +
> +	for (i = 0; i < DEF_NIDS_PER_INODE; i++) {
> +		if (ri->i_nid[i])
> +			return true;
> +	}
> +	return false;
> +}
> +
> +bool f2fs_sanity_check_inline_data(struct inode *inode, struct page *ipage)
>  {
>  	if (!f2fs_has_inline_data(inode))
>  		return false;
>  
> +	if (has_node_blocks(inode, ipage))
> +		return false;
> +
>  	if (!support_inline_data(inode))
>  		return true;
>  
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index c26effdce9aa..1423cd27a477 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -343,7 +343,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  		}
>  	}
>  
> -	if (f2fs_sanity_check_inline_data(inode)) {
> +	if (f2fs_sanity_check_inline_data(inode, node_page)) {
>  		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_data, run fsck to fix",
>  			  __func__, inode->i_ino, inode->i_mode);
>  		return false;
> -- 
> 2.40.1

