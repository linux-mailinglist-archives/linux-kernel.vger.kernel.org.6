Return-Path: <linux-kernel+bounces-324313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2DD974B06
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DA8288E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D313AD11;
	Wed, 11 Sep 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qC5UOAzA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED45733086
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038750; cv=none; b=LahB+FZWX9CfMHO+tZNgJzpkMlPzZqfe7aNmXRPc1uBMTYdSpaRLRpnoy57c9Bez1QHWHv23HJnGcoHAAMuGsR6CbSCBSb0JHG2Ps265W9rj1cI7V4y/HKCWEdAAteL7p6DGMY1fTCXRNuQ0sYya1oUPno9a7Fi6Cj3CKFsaeXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038750; c=relaxed/simple;
	bh=I0zM5CLKue7JAHtHnil+T8oLz0L+gRgJPWAmvkeDhsU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MySot5Q24Sq0BkkISf2LNRjpJyv9rz/4A5hXk4myPGY/KYoAL7BwrAnM1+S7wsqU6zaHx98KXTvpu24G728854xrrrv1CwRwa4qy48D3FVmSI4jeqtPvHONZzDeqb0AXbsHX2sIYevsu7DOkriB+KnUOPQqCUex7J23xF7VE1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qC5UOAzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011F2C4CEC6;
	Wed, 11 Sep 2024 07:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726038749;
	bh=I0zM5CLKue7JAHtHnil+T8oLz0L+gRgJPWAmvkeDhsU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qC5UOAzAQBOUONjiafY0N9WmVZEUwJ391+i6A2RqWD/F5U93ed319s1mF8nDI660S
	 GrKtyTMTjtYz6/ZCH2CcKbz4oNn2hL9m2Lev5bHyqWmDYT8AWe8rCORon9izgIaLhk
	 2JOYE2IaijaSq9lsfmr5n54Yu4feBq1MY5Cj/kHqTMcyk0aVZVU3w2eiyGtxwHeupt
	 lxBPGrzrHdYoucT/UsOjfy3SErPTe3JdYTbV8LBBabqLyJiadQnRMg+Bmq6SAhClPU
	 DVMlVuqgO6Pl3MB2wDAA6SX18B5DbMl9ZgFJrevL0syqNorw6fn8nSIThHkaL7QWfk
	 bbF5wI//yzaqg==
Message-ID: <d7b3ad0c-6474-459d-855d-c1c435a2bb17@kernel.org>
Date: Wed, 11 Sep 2024 15:12:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: don't set SBI_QUOTA_NEED_REPAIR flag
 if receive SIGKILL
To: wangzijie1@honor.com
References: <52ced02d-728b-4e3b-9079-73efd91c90e3@kernel.org>
 <20240903060658.1780002-1-wangzijie1@honor.com>
 <973e075b-7044-4448-9cd0-45b5a1ad1382@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <973e075b-7044-4448-9cd0-45b5a1ad1382@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/4 11:49, Chao Yu via Linux-f2fs-devel wrote:
> On 2024/9/3 14:06, wangzijie wrote:
>> From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
>>
>>> On 2024/8/27 14:22, wangzijie wrote:
>>>> Thread A
>>>> -dquot_initialize
>>>>   -dqget
>>>>    -f2fs_dquot_acquire
>>>>     -v2_read_dquot
>>>>      -qtree_read_dquot
>>>>       -find_tree_dqentry
>>>>        -f2fs_quota_read
>>>>         -read_cache_page_gfp
>>>>          -do_read_cache_folio
>>>>           -fiemap_read_folio
>>>>            -folio_wait_locked_killable
>>>>             -receive SIGKILL : return -EINTR
>>>>         -set SBI_QUOTA_NEED_REPAIR
>>>>     -set SBI_QUOTA_NEED_REPAIR
>>>>
>>>> When calling read_cache_page_gfp in quota read, thread may receive SIGKILL and
>>>> set SBI_QUOTA_NEED_REPAIR, should we set SBI_QUOTA_NEED_REPAIR in this error path?
>>>
>>> f2fs_quota_read() can be called in a lot of contexts, can we just ignore -EINTR
>>> for f2fs_dquot_initialize() case?
>>>
>>> Thanks,
>>
>> Yes, in many contexts f2fs_quota_read() can be called and may return -EINTR, we need to ignore this errno for more cases. If we need to do so, I will check it and resend patch.
>> Or do you have other suggestions to avoid unnecessary SBI_QUOTA_NEED_REPAIR flag set?
> 
> How about this?
> 
> ---
>   fs/f2fs/f2fs.h  |  1 +
>   fs/f2fs/inode.c |  3 +--
>   fs/f2fs/super.c | 17 +++++++++++++----
>   3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dfed1974eda5..a1704a19dfe9 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -810,6 +810,7 @@ enum {
>       FI_ATOMIC_DIRTIED,    /* indicate atomic file is dirtied */
>       FI_ATOMIC_REPLACE,    /* indicate atomic replace */
>       FI_OPENED_FILE,        /* indicate file has been opened */
> +    FI_INIT_DQUOT,        /* indicate it's initializing dquot */
>       FI_MAX,            /* max flag, never be used */
>   };
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 008f01348afa..b1dbaeda306f 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -827,8 +827,7 @@ void f2fs_evict_inode(struct inode *inode)
> 
>       err = f2fs_dquot_initialize(inode);
>       if (err) {
> -        if (err != -EINTR)
> -            set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> +        set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>           err = 0;
>       }
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 8e29aba4b7a4..e774bdf875b2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2644,8 +2644,11 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>               if (PTR_ERR(page) == -ENOMEM) {
>                   memalloc_retry_wait(GFP_NOFS);
>                   goto repeat;
> -            } else if (PTR_ERR(page) != -EINTR)
> -                set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> +            } else if (PTR_ERR(page) == -EINTR &&
> +                is_inode_flag_set(inode, FI_INIT_DQUOT)) {

Current inode is quota inode, it's not the same inode we tagged
w/ FI_INIT_DQUOT, so please ignore this diff...

Thanks,

> +                return PTR_ERR(page);
> +            }
> +            set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>               return PTR_ERR(page);
>           }
> 
> @@ -2721,10 +2724,16 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
> 
>   int f2fs_dquot_initialize(struct inode *inode)
>   {
> +    int ret;
> +
>       if (time_to_inject(F2FS_I_SB(inode), FAULT_DQUOT_INIT))
>           return -ESRCH;
> 
> -    return dquot_initialize(inode);
> +    set_inode_flag(inode, FI_INIT_DQUOT);
> +    ret = dquot_initialize(inode);
> +    clear_inode_flag(inode, FI_INIT_DQUOT);
> +
> +    return ret;
>   }
> 
>   static struct dquot __rcu **f2fs_get_dquots(struct inode *inode)
> @@ -3064,7 +3073,7 @@ static int f2fs_dquot_acquire(struct dquot *dquot)
> 
>       f2fs_down_read(&sbi->quota_sem);
>       ret = dquot_acquire(dquot);
> -    if (ret < 0 && ret != -EINTR)
> +    if (ret < 0)
>           set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>       f2fs_up_read(&sbi->quota_sem);
>       return ret;


