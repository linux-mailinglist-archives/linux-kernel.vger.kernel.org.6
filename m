Return-Path: <linux-kernel+bounces-354648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6D0993F96
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B4D1C20DAF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060711DC1BA;
	Tue,  8 Oct 2024 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eabudE1o"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF41D88DC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371922; cv=none; b=fZ/a5pT4Ztn6k49jf5czrtH6f1Ob2zz7IEWyKTSUHDVdPWbIYKaxefAzZ102eWm6QUHa4Cz7SY69sXIDy9La5ilN12hOc/tPsBMmzTcOYpCzhLZ0DQt+QD77lak1O3Yx6J2ZWg2B6mJvYElSoSXaejbZ8jbMXPCoVHPGV1OfKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371922; c=relaxed/simple;
	bh=GFbxMiAB7DSLQw+XtVfFYni0MPAosv7ossEV6PGKMQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JscvErLLGkU8AtEoQY5G+SZL07JeMohosjFVvZHguAiAzSMwpDi+ldDUz5nsyEmGE0s8CzsG/BlM8bcldrsOmNpTS1YPBsaMGkaB35TJ195bmavSgzMqE9eplm7+7TW4J7D5qlxZlTqonyJwCLFMQ/llswuFnTanTR95IeGG8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eabudE1o; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728371917; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=go74r5TsXs1gXoSIc8tuf4tNzA7cG6cIRrMjnnWiskQ=;
	b=eabudE1oy+1k98ymH+JDs5YqyQX1eXranSHLvQ16iimWABPJYd8XVHaYhYYk7s2/SCnGwnbVz0nbe7bxPbCuvKTZKHuNiawr8r8gE6CXhRXwrCCeXaPnGdctleL1iAL5aewI5LPLyBf4+bUEMHbpo6Xj/rPu3Hk1Z4MHalaivk8=
Received: from 30.221.129.116(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WGbLbjm_1728371916)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 15:18:37 +0800
Message-ID: <52e66e96-5edc-4b31-bc72-df2cf7881a9e@linux.alibaba.com>
Date: Tue, 8 Oct 2024 15:18:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ocfs2: adjust spinlock_t ip_lock protection scope
To: Heming Zhao <heming.zhao@suse.com>, glass.su@suse.com
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240908140705.19169-1-heming.zhao@suse.com>
 <20240908140705.19169-4-heming.zhao@suse.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240908140705.19169-4-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is a standalone cleanup, so please send in a separate thread.

Thanks,
Joseph

On 9/8/24 10:07 PM, Heming Zhao wrote:
> Some of the spinlock_t ip_lock protection scopes are incorrect and
> should follow the usage in 'struct ocfs2_inode_info'.
> 
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> Reviewed-by: Su Yue <glass.su@suse.com>
> ---
>  fs/ocfs2/dlmglue.c  | 3 ++-
>  fs/ocfs2/inode.c    | 5 +++--
>  fs/ocfs2/resize.c   | 4 ++--
>  fs/ocfs2/suballoc.c | 2 +-
>  4 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index da78a04d6f0b..4a5900c8dc8f 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -2232,6 +2232,8 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
>  	else
>  		inode->i_blocks = ocfs2_inode_sector_count(inode);
>  
> +	spin_unlock(&oi->ip_lock);
> +
>  	i_uid_write(inode, be32_to_cpu(lvb->lvb_iuid));
>  	i_gid_write(inode, be32_to_cpu(lvb->lvb_igid));
>  	inode->i_mode    = be16_to_cpu(lvb->lvb_imode);
> @@ -2242,7 +2244,6 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
>  	inode_set_mtime_to_ts(inode, ts);
>  	ocfs2_unpack_timespec(&ts, be64_to_cpu(lvb->lvb_ictime_packed));
>  	inode_set_ctime_to_ts(inode, ts);
> -	spin_unlock(&oi->ip_lock);
>  	return 0;
>  }
>  
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 2cc5c99fe941..4af9a6dfddd2 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1348,14 +1348,15 @@ void ocfs2_refresh_inode(struct inode *inode,
>  		inode->i_blocks = 0;
>  	else
>  		inode->i_blocks = ocfs2_inode_sector_count(inode);
> +
> +	spin_unlock(&OCFS2_I(inode)->ip_lock);
> +
>  	inode_set_atime(inode, le64_to_cpu(fe->i_atime),
>  			le32_to_cpu(fe->i_atime_nsec));
>  	inode_set_mtime(inode, le64_to_cpu(fe->i_mtime),
>  			le32_to_cpu(fe->i_mtime_nsec));
>  	inode_set_ctime(inode, le64_to_cpu(fe->i_ctime),
>  			le32_to_cpu(fe->i_ctime_nsec));
> -
> -	spin_unlock(&OCFS2_I(inode)->ip_lock);
>  }
>  
>  int ocfs2_validate_inode_block(struct super_block *sb,
> diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
> index c4a4016d3866..b29f71357d63 100644
> --- a/fs/ocfs2/resize.c
> +++ b/fs/ocfs2/resize.c
> @@ -153,8 +153,8 @@ static int ocfs2_update_last_group_and_inode(handle_t *handle,
>  
>  	spin_lock(&OCFS2_I(bm_inode)->ip_lock);
>  	OCFS2_I(bm_inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
> -	le64_add_cpu(&fe->i_size, (u64)new_clusters << osb->s_clustersize_bits);
>  	spin_unlock(&OCFS2_I(bm_inode)->ip_lock);
> +	le64_add_cpu(&fe->i_size, (u64)new_clusters << osb->s_clustersize_bits);
>  	i_size_write(bm_inode, le64_to_cpu(fe->i_size));
>  
>  	ocfs2_journal_dirty(handle, bm_bh);
> @@ -564,8 +564,8 @@ int ocfs2_group_add(struct inode *inode, struct ocfs2_new_group_input *input)
>  
>  	spin_lock(&OCFS2_I(main_bm_inode)->ip_lock);
>  	OCFS2_I(main_bm_inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
> -	le64_add_cpu(&fe->i_size, (u64)input->clusters << osb->s_clustersize_bits);
>  	spin_unlock(&OCFS2_I(main_bm_inode)->ip_lock);
> +	le64_add_cpu(&fe->i_size, (u64)input->clusters << osb->s_clustersize_bits);
>  	i_size_write(main_bm_inode, le64_to_cpu(fe->i_size));
>  
>  	ocfs2_update_super_and_backups(main_bm_inode, input->clusters);
> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
> index 9e847f59c9ef..3f91615d8702 100644
> --- a/fs/ocfs2/suballoc.c
> +++ b/fs/ocfs2/suballoc.c
> @@ -798,9 +798,9 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
>  
>  	spin_lock(&OCFS2_I(alloc_inode)->ip_lock);
>  	OCFS2_I(alloc_inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
> +	spin_unlock(&OCFS2_I(alloc_inode)->ip_lock);
>  	fe->i_size = cpu_to_le64(ocfs2_clusters_to_bytes(alloc_inode->i_sb,
>  					     le32_to_cpu(fe->i_clusters)));
> -	spin_unlock(&OCFS2_I(alloc_inode)->ip_lock);
>  	i_size_write(alloc_inode, le64_to_cpu(fe->i_size));
>  	alloc_inode->i_blocks = ocfs2_inode_sector_count(alloc_inode);
>  	ocfs2_update_inode_fsync_trans(handle, alloc_inode, 0);


