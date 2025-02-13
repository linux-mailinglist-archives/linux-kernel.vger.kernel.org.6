Return-Path: <linux-kernel+bounces-513628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2902BA34CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9DA16BA38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96285221725;
	Thu, 13 Feb 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM1JBmkc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E582128A2AE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469684; cv=none; b=M/xKASLIiflolaNLBMOmHt6LEmDCroAfaOHxxul+u8nxhKyG49jDE+yMZad81N+gPruPX8AN5oyTbe5X1UQHdR/di0ALSik7tTw9tI2I9o/tjffwb6VS64yllaRSpoFRPcNbpwmFs8Qw4LtGT8rYUHklu/QNL10fh8/a9rvkJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469684; c=relaxed/simple;
	bh=D+/vdJ8x43Y7tH3mHS8FOCprLNgHQv5bttwXyXFdFJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhTg6QVHCEuQEN/c9G4mHGvjtXdI5ASUJq33j0rjH72G2fP1qTOX1ja961Ta3s7K28lJzJweIL8MONHTQ4xJE/puNXaN1GV1/9F+Cvx4sc+4JduDRia7A+YZrhNIS3dAJ1azRkGtbH9u7qEVb8qMRH4EUFxIcHhbaN1F9SwAGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM1JBmkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99098C4CED1;
	Thu, 13 Feb 2025 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739469683;
	bh=D+/vdJ8x43Y7tH3mHS8FOCprLNgHQv5bttwXyXFdFJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VM1JBmkc8yxs32Xupt2EZs2OpEisQNQWdebs/TDoPAlu+gpcHeIBwLiWGqOvV0NH3
	 g4L5kxBZWtMzm+y4+aAfX3XfRtSHVeN5jmFGJTlyNj21n6k7UIVYwfhY1sbHnslxHh
	 Ijj5rAhSUUSnu7zWOZasGTK2v9PE/s4av8xpvaga6cKM3SKvftAH1Mkg/9DzB9RV8P
	 UxVTU8J/jPssXzukxy9yZUCGM9xwmF64r401jIWtm6ZjAXhqV6lbcRdCHWd+VA8vxh
	 pYVAn7m/3wnqF99xWsLobH9zeG1Xz8oVa4/DwTnVX09jypq6yAatIFLVxUvu7/dCb5
	 /2vz3TByplLdw==
Date: Thu, 13 Feb 2025 18:01:21 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: fix to avoid accessing uninitialized curseg
Message-ID: <Z64zcac0_dw1_rML@google.com>
References: <20250212075242.988652-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212075242.988652-1-chao@kernel.org>

On 02/12, Chao Yu wrote:
> syzbot reports a f2fs bug as below:
> 
> F2FS-fs (loop3): Stopped filesystem due to reason: 7
> kworker/u8:7: attempt to access beyond end of device
> BUG: unable to handle page fault for address: ffffed1604ea3dfa
> RIP: 0010:get_ckpt_valid_blocks fs/f2fs/segment.h:361 [inline]
> RIP: 0010:has_curseg_enough_space fs/f2fs/segment.h:570 [inline]
> RIP: 0010:__get_secs_required fs/f2fs/segment.h:620 [inline]
> RIP: 0010:has_not_enough_free_secs fs/f2fs/segment.h:633 [inline]
> RIP: 0010:has_enough_free_secs+0x575/0x1660 fs/f2fs/segment.h:649
>  <TASK>
>  f2fs_is_checkpoint_ready fs/f2fs/segment.h:671 [inline]
>  f2fs_write_inode+0x425/0x540 fs/f2fs/inode.c:791
>  write_inode fs/fs-writeback.c:1525 [inline]
>  __writeback_single_inode+0x708/0x10d0 fs/fs-writeback.c:1745
>  writeback_sb_inodes+0x820/0x1360 fs/fs-writeback.c:1976
>  wb_writeback+0x413/0xb80 fs/fs-writeback.c:2156
>  wb_do_writeback fs/fs-writeback.c:2303 [inline]
>  wb_workfn+0x410/0x1080 fs/fs-writeback.c:2343
>  process_one_work kernel/workqueue.c:3236 [inline]
>  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3398
>  kthread+0x7a9/0x920 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> Commit 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT") allows to trigger
> no free segment fault in allocator, then it will update curseg->segno to
> NULL_SEGNO, though, CP_ERROR_FLAG has been set, f2fs_write_inode() missed
> to check the flag, and access invalid curseg->segno directly in below call
> path, then resulting in panic:
> 
> - f2fs_write_inode
>  - f2fs_is_checkpoint_ready
>   - has_enough_free_secs
>    - has_not_enough_free_secs
>     - __get_secs_required
>      - has_curseg_enough_space
>       - get_ckpt_valid_blocks
>       : access invalid curseg->segno
> 
> To avoid this issue, let's:
> - check CP_ERROR_FLAG flag in prior to f2fs_is_checkpoint_ready() in
> f2fs_write_inode().
> - in has_curseg_enough_space(), a) verify status of curseg before accessing
> its field, and b) grab curseg_mutex lock to avoid race condition.
> 
> Fixes: 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT")
> Reported-by: syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67973c2b.050a0220.11b1bb.0089.GAE@google.com
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/inode.c   |  7 +++++++
>  fs/f2fs/segment.h | 27 ++++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 02f1b69d03d8..5c1b515eab36 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -799,6 +799,13 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  		!is_inode_flag_set(inode, FI_DIRTY_INODE))
>  		return 0;
>  
> +	/*
> +	 * no need to update inode page, ultimately f2fs_evict_inode() will
> +	 * clear dirty status of inode.
> +	 */
> +	if (f2fs_cp_error(sbi))
> +		return -EIO;
> +
>  	if (!f2fs_is_checkpoint_ready(sbi)) {
>  		f2fs_mark_inode_dirty_sync(inode, true);
>  		return -ENOSPC;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 943be4f1d6d2..e9fcf2b85b76 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -559,15 +559,23 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>  			unsigned int node_blocks, unsigned int data_blocks,
>  			unsigned int dent_blocks)
>  {
> -
> +	struct curseg_info *curseg;
>  	unsigned int segno, left_blocks, blocks;
>  	int i;
>  
>  	/* check current data/node sections in the worst case. */
>  	for (i = CURSEG_HOT_DATA; i < NR_PERSISTENT_LOG; i++) {
> -		segno = CURSEG_I(sbi, i)->segno;
> -		left_blocks = CAP_BLKS_PER_SEC(sbi) -
> +		curseg = CURSEG_I(sbi, i);
> +
> +		mutex_lock(&curseg->curseg_mutex);
> +		if (!curseg->inited || curseg->segno == NULL_SEGNO) {
> +			left_blocks = 0;
> +		} else {
> +			segno = curseg->segno;
> +			left_blocks = CAP_BLKS_PER_SEC(sbi) -
>  				get_ckpt_valid_blocks(sbi, segno, true);
> +		}
> +		mutex_unlock(&curseg->curseg_mutex);

This looks a bit worrisome, as it'll block user-facing allocation. Can we
have another way to prevent the issue?

>  
>  		blocks = i <= CURSEG_COLD_DATA ? data_blocks : node_blocks;
>  		if (blocks > left_blocks)
> @@ -575,9 +583,18 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>  	}
>  
>  	/* check current data section for dentry blocks. */
> -	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
> -	left_blocks = CAP_BLKS_PER_SEC(sbi) -
> +	curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
> +
> +	mutex_lock(&curseg->curseg_mutex);
> +	if (!curseg->inited || curseg->segno == NULL_SEGNO) {
> +		left_blocks = 0;
> +	} else {
> +		segno = curseg->segno;
> +		left_blocks = CAP_BLKS_PER_SEC(sbi) -
>  			get_ckpt_valid_blocks(sbi, segno, true);
> +	}
> +	mutex_unlock(&curseg->curseg_mutex);
> +
>  	if (dent_blocks > left_blocks)
>  		return false;
>  	return true;
> -- 
> 2.48.1.502.g6dc24dfdaf-goog

