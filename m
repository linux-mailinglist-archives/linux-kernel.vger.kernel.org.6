Return-Path: <linux-kernel+bounces-310739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B009680A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104EF1C21C66
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD4C155A52;
	Mon,  2 Sep 2024 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sci4iq/H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B700EAD0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262358; cv=none; b=DrHv0tb3T3TSwTxgXjPXHwP57/JjROfZLPiuf60SzW+HkwJpgyZ0DA3JBKUinBZ1FxXnyUV1P1Qr1qtxTpVjdMsRwovFdUKioyekHp3rniBm8GdBCa9onqJnAMCFrN1x+fBIW1HHp5+7OrP+LKlfv5gm19xiMMofEVtdR2p0BMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262358; c=relaxed/simple;
	bh=dVuVc86J5b6OHhIlLTRhxSstrU4YAQzxLh10N76gTQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qErBR1OuJsyJJgkz7baq31Uso6Kg33OLf4I55xZLcxRcjwCUcYIkX84OwNyqPAj50Q+r1+Xokxt3/nvyhv+vB8fXjsHAY5Qc1QXAhKei2a2fHsMt5gP8e8yqHECmy3A9AvT2sFjdXRZCH0jkqGeklJ6OAlxckQpZaUoUUr0vqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sci4iq/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D87C4CEC2;
	Mon,  2 Sep 2024 07:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725262357;
	bh=dVuVc86J5b6OHhIlLTRhxSstrU4YAQzxLh10N76gTQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sci4iq/HrBHDanQRfrc7SyyAlOd+dZFkkWqJNfJpgL1uGzaGAoOu4yMhrQyMDIo9w
	 NGo+GO7oNZZvf/AwErVfp94eprDZjpJ5JduwX2KQYj1L/GbJe1ASlyQS2/u8KilJ/e
	 jfkcIrSCIg/aTBcuiqRzeAWdtIqonHMvCa2S1N341CCY9Lbn+OOdWQc6FKieTU0CRG
	 ZRsArh73A+yD+cv5sLUnJQkQGj94ICUBB4tVtiesAGb9PcQdPkkEtusDIoYXyh1frD
	 lNW7W+Cvjxklfi0OHXyBgGI/x3LNC6WjGNawMRXwK+Gvr0n/vfTL1Che5f3beCPclr
	 x6ZA0cf6ck5Rw==
Message-ID: <52ced02d-728b-4e3b-9079-73efd91c90e3@kernel.org>
Date: Mon, 2 Sep 2024 15:32:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] f2fs: don't set SBI_QUOTA_NEED_REPAIR flag if receive
 SIGKILL
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 bintian.wang@honor.com
References: <20240827062242.776881-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240827062242.776881-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/27 14:22, wangzijie wrote:
> Thread A
> -dquot_initialize
>   -dqget
>    -f2fs_dquot_acquire
>     -v2_read_dquot
>      -qtree_read_dquot
>       -find_tree_dqentry
>        -f2fs_quota_read
>         -read_cache_page_gfp
>          -do_read_cache_folio
>           -fiemap_read_folio
>            -folio_wait_locked_killable
>             -receive SIGKILL : return -EINTR
>         -set SBI_QUOTA_NEED_REPAIR
>     -set SBI_QUOTA_NEED_REPAIR
> 
> When calling read_cache_page_gfp in quota read, thread may receive SIGKILL and
> set SBI_QUOTA_NEED_REPAIR, should we set SBI_QUOTA_NEED_REPAIR in this error path?

f2fs_quota_read() can be called in a lot of contexts, can we just ignore -EINTR
for f2fs_dquot_initialize() case?

Thanks,

> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>   fs/f2fs/inode.c | 3 ++-
>   fs/f2fs/super.c | 6 +++---
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index ed629dabb..2af98e2b7 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -837,8 +837,9 @@ void f2fs_evict_inode(struct inode *inode)
>   
>   	err = f2fs_dquot_initialize(inode);
>   	if (err) {
> +		if (err != -EINTR)
> +			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>   		err = 0;
> -		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>   	}
>   
>   	f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1f1b3647a..f99a36ff3 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2650,8 +2650,8 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>   			if (PTR_ERR(page) == -ENOMEM) {
>   				memalloc_retry_wait(GFP_NOFS);
>   				goto repeat;
> -			}
> -			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> +			} else if (PTR_ERR(page) != -EINTR)
> +				set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>   			return PTR_ERR(page);
>   		}
>   
> @@ -3070,7 +3070,7 @@ static int f2fs_dquot_acquire(struct dquot *dquot)
>   
>   	f2fs_down_read(&sbi->quota_sem);
>   	ret = dquot_acquire(dquot);
> -	if (ret < 0)
> +	if (ret < 0 && ret != -EINTR)
>   		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>   	f2fs_up_read(&sbi->quota_sem);
>   	return ret;


