Return-Path: <linux-kernel+bounces-180840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D58C73C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A55282072
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CB14374E;
	Thu, 16 May 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFVDV6Tw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B121182AF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851941; cv=none; b=ZgoLDpymqwoeg0px+fpQLt+AJqhEdN8KoxWynuZlna+iYtCqhJzNlqsr6acaw5TCtNzYiwNTeG8nGiY/yLmhqNoob1g4JDP3CHkDmZirvV6iMyxRGn0BpXohScJGEv5FBjQVM6ruWbX5QkSR33GDv764AiT+3cbklAWvUimoc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851941; c=relaxed/simple;
	bh=SoLSBSXOsFBOvO+gPHVZLRXS6EZu2pbQEyZVtrcKK3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ow2bSHPQYwVzk9AEJ+jZ78rClfG7Bb9Cd9zTdv0L/heC6ek4nS8bdZ09ac47QsMrR7vJ7JbujEshNdoDCB57Gu/1wiLp+FYkaPtpxuDDUKcReqB5vWXbo0OD1CXznhiZwFn9tZK/LI1VIx2hPBnvR6xHYiRzGonScIqc2BP8diE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFVDV6Tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57965C113CC;
	Thu, 16 May 2024 09:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715851940;
	bh=SoLSBSXOsFBOvO+gPHVZLRXS6EZu2pbQEyZVtrcKK3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nFVDV6Tw6MegjNUCIw2T1Ejg155ZkAuh8A+czvCBrt5T//NKR/i0aaHFXrIGJL6oO
	 28ZBSgCVy0iZMCqxaNuRmtwdIS2NG97fYxappghSog8kgJ0fzeLOm/1Ei2+hgtdx+x
	 Kvr4NajbgMRxp6zCKVmoK4bg+qWolpqPLY2LyzSw688PrI5AdaFAGS8wEbTh30/Qvg
	 23tDtRgMy79L7nwMA0mp/Ouzppe5abAR/exk5XTYRvsWGqY9Ip2LUGnzvx+2979bRw
	 U2qM8P07+2kq6R6ScxAkK1sHj7RJuh40pecyzGu8E1OCN1dJPHE3wDlYvbtOCwCf8V
	 D2iEBrWQP8RGg==
Message-ID: <30a5f29b-886f-4ee7-93d1-8c3e1bb8bb49@kernel.org>
Date: Thu, 16 May 2024 17:32:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix panic in f2fs_put_super
To: sunshijie <sunshijie@xiaomi.corp-partner.google.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: sunshijie <sunshijie@xiaomi.com>
References: <20240516085512.1082640-1-sunshijie@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240516085512.1082640-1-sunshijie@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/16 16:55, sunshijie wrote:
> When thread A calls kill_f2fs_super, Thread A first executes the code sbi->node_inode = NULL;
> Then thread A may submit a bio to the function iput(sbi->meta_inode);
> Then thread A enters the process D state,
> Now that the bio submitted by thread A is complete, it calls f2fs_write_end_io and may trigger null-ptr-deref in NODE_MAPPING.

I didn't get it, if there is no cp_err, f2fs_write_checkpoint() in
f2fs_put_super() will flush all dirty pages of node_inode, if there is
cp_err, below flow will keep all dirty pages being truncated, and
there is sanity check on all types of dirty pages.

	/* our cp_error case, we can wait for any writeback page */
	f2fs_flush_merged_writes(sbi);

	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);

	if (err || f2fs_cp_error(sbi)) {
		truncate_inode_pages_final(NODE_MAPPING(sbi));
		truncate_inode_pages_final(META_MAPPING(sbi));
	}

	for (i = 0; i < NR_COUNT_TYPE; i++) {
		if (!get_pages(sbi, i))
			continue;
		f2fs_err(sbi, "detect filesystem reference count leak during "
			"umount, type: %d, count: %lld", i, get_pages(sbi, i));
		f2fs_bug_on(sbi, 1);
	}

So, is there any missing case that dirty page of node_inode is missed by
f2fs_put_super()?

Thanks,

> 
> Thread A                                          IRQ context
> - f2fs_put_super
>   - sbi->node_inode = NULL;
>   - iput(sbi->meta_inode);
>    - iput_final
>     - write_inode_now
>      - writeback_single_inode
>       - __writeback_single_inode
>        - filemap_fdatawait
>         - filemap_fdatawait_range
>          - __kcfi_typeid_free_transhuge_page
>           - __filemap_fdatawait_range
>            - wait_on_page_writeback
>             - folio_wait_writeback
>              - folio_wait_bit
>               - folio_wait_bit_common
>                - io_schedule
> 
>                                                    - __handle_irq_event_percpu
>                                                     - ufs_qcom_mcq_esi_handler
>                                                      - ufshcd_mcq_poll_cqe_nolock
>                                                       - ufshcd_compl_one_cqe
>                                                        - scsi_done
>                                                         - scsi_done_internal
>                                                          - blk_mq_complete_request
>                                                           - scsi_complete
>                                                            - scsi_finish_command
>                                                             - scsi_io_completion
>                                                              - scsi_end_request
>                                                               - blk_update_request
>                                                                - bio_endio
>                                                                 - f2fs_write_end_io
>                                                                  - NODE_MAPPING(sbi)
> 
> Signed-off-by: sunshijie <sunshijie@xiaomi.com>
> ---
>   fs/f2fs/super.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index adffc9b80a9c..aeb085e11f9a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1641,12 +1641,12 @@ static void f2fs_put_super(struct super_block *sb)
>   
>   	f2fs_destroy_compress_inode(sbi);
>   
> -	iput(sbi->node_inode);
> -	sbi->node_inode = NULL;
> -
>   	iput(sbi->meta_inode);
>   	sbi->meta_inode = NULL;
>   
> +	iput(sbi->node_inode);
> +	sbi->node_inode = NULL;
> +
>   	mutex_unlock(&sbi->umount_mutex);
>   
>   	/*

