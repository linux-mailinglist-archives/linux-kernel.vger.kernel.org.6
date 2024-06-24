Return-Path: <linux-kernel+bounces-227730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217ED9155F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABB31F21062
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4E1A0AFF;
	Mon, 24 Jun 2024 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emrSZSLO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AF19FA86
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251607; cv=none; b=YN/VAgpMVCdQWKj+9yCyF0JLokRLyzVb89YIS81gxYEz5038YlqR+ivCJZLoC2YMBjZtoKtAZXudzH4gn4iigWkOgz+FPf07FfqOJhrqMmpjv5r3HZbT7fkcAVQxadrRj/YVKQnhk6seWpjOP3xYeZIUSFgh7152StQPEPj3Bmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251607; c=relaxed/simple;
	bh=sV7eppB4xqZxl7orWq5DEhrQtYxq9XdZxd/7zbygi5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZn1/V7hCgs7k5stzekkUqC0HJRJy1N0zzZLC6ejxtY1R/kkGBi1sKf1SWiQFRUy1Gsc4gpoPjFBwvAS+OClkoYqvTZuTOTqojDu5gjtmjieNElMGdbLonwtPIU1CX80cOL9LWZ2xKzRXitOA8ly5iDutpOWAaVHEka7wAXFDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emrSZSLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41ADC32789;
	Mon, 24 Jun 2024 17:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719251607;
	bh=sV7eppB4xqZxl7orWq5DEhrQtYxq9XdZxd/7zbygi5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emrSZSLO81R0j6/M/RlR4nDU5/cXe/8EtimLnx4K76ipJHenhNkolVfyNvHthEJw8
	 PIPWOvrZOPigrlWsyjSEWsvgNZjERHYPodUeom2ibbJCHBBn//pjt+fWq8ov1KF5OE
	 0BcQt2WEYpQICQU8QMaain3NtTb7mfmUWOECXtjKvF2HKiPGmUd283CW/8M+/Q1Qk2
	 prvZ8U88rPTjY8220bzZZkqgEqtBZdbUpwFTxw8rrIV5TBaTzaZedfETcLRoODwZlT
	 mFeWQqvRoC20pkbCFb6VC8L2AFrHxRWUtkT58oXkUFhYLT2q0cA+PblXkglIkk69uR
	 lF0nx0KaNr8Ow==
Date: Mon, 24 Jun 2024 17:53:25 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Yunlei He <heyunlei@oppo.com>
Subject: Re: [PATCH] f2fs: fix to update user block counts in
 block_operations()
Message-ID: <ZnmylaqsdF65PVDp@google.com>
References: <20240606095451.4088735-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606095451.4088735-1-chao@kernel.org>

On 06/06, Chao Yu wrote:
> Commit 59c9081bc86e ("f2fs: allow write page cache when writting cp")
> allows write() to write data to page cache during checkpoint, so block
> count fields like .total_valid_block_count, .alloc_valid_block_count
> and .rf_node_block_count may encounter race condition as below:
> 
> CP				Thread A
> - write_checkpoint
>  - block_operations
>   - f2fs_down_write(&sbi->node_change)
>   - __prepare_cp_block
>   : ckpt->valid_block_count = .total_valid_block_count
>   - f2fs_up_write(&sbi->node_change)
> 				- write
> 				 - f2fs_preallocate_blocks
> 				  - f2fs_map_blocks(,F2FS_GET_BLOCK_PRE_AIO)
> 				   - f2fs_map_lock
> 				    - f2fs_down_read(&sbi->node_change)
> 				   - f2fs_reserve_new_blocks
> 				    - inc_valid_block_count
> 				    : percpu_counter_add(&sbi->alloc_valid_block_count, count)
> 				    : sbi->total_valid_block_count += count
> 				    - f2fs_up_read(&sbi->node_change)
>  - do_checkpoint
>  : sbi->last_valid_block_count = sbi->total_valid_block_count
>  : percpu_counter_set(&sbi->alloc_valid_block_count, 0)
>  : percpu_counter_set(&sbi->rf_node_block_count, 0)
> 				- fsync
> 				 - need_do_checkpoint
> 				  - f2fs_space_for_roll_forward
> 				  : alloc_valid_block_count was reset to zero,
> 				    so, it may missed last data during checkpoint
> 
> Let's change to update .total_valid_block_count, .alloc_valid_block_count
> and .rf_node_block_count in block_operations(), then their access can be
> protected by .node_change and .cp_rwsem lock, so that it can avoid above
> race condition.
> 
> Fixes: 59c9081bc86e ("f2fs: allow write page cache when writting cp")
> Cc: Yunlei He <heyunlei@oppo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 66eaad591b60..010bbd5af211 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1298,6 +1298,12 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  	 * dirty node blocks and some checkpoint values by block allocation.
>  	 */
>  	__prepare_cp_block(sbi);
> +
> +	/* update user_block_counts */
> +	sbi->last_valid_block_count = sbi->total_valid_block_count;
> +	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
> +	percpu_counter_set(&sbi->rf_node_block_count, 0);

Need to add this in __prepare_cp_block()?

> +
>  	f2fs_up_write(&sbi->node_change);
>  	return err;
>  }
> @@ -1575,11 +1581,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		start_blk += NR_CURSEG_NODE_TYPE;
>  	}
>  
> -	/* update user_block_counts */
> -	sbi->last_valid_block_count = sbi->total_valid_block_count;
> -	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
> -	percpu_counter_set(&sbi->rf_node_block_count, 0);
> -
>  	/* Here, we have one bio having CP pack except cp pack 2 page */
>  	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>  	/* Wait for all dirty meta pages to be submitted for IO */
> -- 
> 2.40.1
> 

