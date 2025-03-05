Return-Path: <linux-kernel+bounces-546363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB693A4F9B2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B653ACF6C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999C1F416F;
	Wed,  5 Mar 2025 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSyL9xcr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690A2E3387
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166189; cv=none; b=kUtpQ414Mi6H3rmxungdB0DTiTfLSSDcJUo2fsjjb3bJQI5m+lE5AKZ4A/kqGue/ucUOq/f3pYkvRC3yH5bgsL5xo9sD3ftZ0Cefhfe8H+j18XFQfNrV+bOem3g22aCv/EyBOR/+HAyMhDaPE/5TV4iNiNUFEC4eqBKpVV03p5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166189; c=relaxed/simple;
	bh=kJfhrOkYBZK257yyh7KPJtYTba5DWjhEPU1ijD/QhwE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z3ngb7f/aOpkkwLSmKGgPlWDigq7VBigtk9c3g7YqOBD/2HIZxf5eQiXUmiyEI4mrll456vG9NmqvV0gBDgRjoH38hyoXh2MRrofCizJPBG4aGgBlkCE6Oz88XE+IdcicyfZ0YwK2XAjPH3usXHJgO7qd+UxRoc+BKQdYLvcLbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSyL9xcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0479C4CEE2;
	Wed,  5 Mar 2025 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741166189;
	bh=kJfhrOkYBZK257yyh7KPJtYTba5DWjhEPU1ijD/QhwE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=eSyL9xcrA7P7YdahqoF3nfZyKoTGnSQrPbOKz0CpsOlsDlhavhc+lFN/DPQXKR9k9
	 JDMyhb0b6FCEXM8DGG/3J694oVM4JSZQ4+iJ5iaTeKnsnDHBYqJVYc9E228feEdwsa
	 FN+Z4sEweoBZOhbXlNLZXHAJ0YzSUPFONOmq2JnrCkeoKcOL9V5vWT/6j6um9NtkvA
	 Kegbbs5fPqPfJpxCPus+R21HM+Xa9P38UsFEJDnMuSfxfoSRV/AneESBuyVYDoLnqF
	 +o+NNOCmpVrho2c0HeH65AwTx1KnzkpJ3knvxoXZ6oC7HdVmcBzW6UBwj8yNEi/YSs
	 p51U3hkSgEDpA==
Message-ID: <9be24599-39de-4440-bd49-8f0629fa8a2b@kernel.org>
Date: Wed, 5 Mar 2025 17:16:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] f2fs: fix to avoid accessing uninitialized curseg
To: jaegeuk@kernel.org
References: <20250224102923.93758-1-chao@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250224102923.93758-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jaegeuk, missed to check this patch?

On 2/24/25 18:29, Chao Yu wrote:
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
> - in has_curseg_enough_space(), save curseg->segno into a temp variable,
> and verify its validation before use.
> 
> Fixes: 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT")
> Reported-by: syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67973c2b.050a0220.11b1bb.0089.GAE@google.com
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - get rid of potential blocking on curseg_mutex
>  fs/f2fs/inode.c   | 7 +++++++
>  fs/f2fs/segment.h | 9 ++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index d6ad7810df69..6aec752ac098 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -793,6 +793,13 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
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
> index 943be4f1d6d2..0465dc00b349 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -559,13 +559,16 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>  			unsigned int node_blocks, unsigned int data_blocks,
>  			unsigned int dent_blocks)
>  {
> -
>  	unsigned int segno, left_blocks, blocks;
>  	int i;
>  
>  	/* check current data/node sections in the worst case. */
>  	for (i = CURSEG_HOT_DATA; i < NR_PERSISTENT_LOG; i++) {
>  		segno = CURSEG_I(sbi, i)->segno;
> +
> +		if (unlikely(segno == NULL_SEGNO))
> +			return false;
> +
>  		left_blocks = CAP_BLKS_PER_SEC(sbi) -
>  				get_ckpt_valid_blocks(sbi, segno, true);
>  
> @@ -576,6 +579,10 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>  
>  	/* check current data section for dentry blocks. */
>  	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
> +
> +	if (unlikely(segno == NULL_SEGNO))
> +		return false;
> +
>  	left_blocks = CAP_BLKS_PER_SEC(sbi) -
>  			get_ckpt_valid_blocks(sbi, segno, true);
>  	if (dent_blocks > left_blocks)


