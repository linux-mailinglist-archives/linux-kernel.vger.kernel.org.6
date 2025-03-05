Return-Path: <linux-kernel+bounces-546354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A073A4F98E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99D11891A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE3202C24;
	Wed,  5 Mar 2025 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ispboAbq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E31FAC5C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165839; cv=none; b=iWZ0QeDD22+HKE2DNNAeS2xZqBIakZKUJqkCQyAgjpVPqKqXQhdLGJ1VgK9le+riP8J8TnNKmpq0h7W81lpSi6F5j+hFi7hapW5FLiH9O3ckEFeRDWZAc7WByzT68HcucbdMoX31fYd+SvwoUTOwepLgUJzBD5yxDtFKRmylNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165839; c=relaxed/simple;
	bh=uT2qFvkPEhiXZfnzHsLaR+FVpRjC893uHKYrLcZSt98=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q2JKvZYhoM/gWWw2s/ZxJtMR7pZDD53HD0DfXCSC9jqPxkoWFx210225M5QBgOmdmac4ms3WOWy4D8I6qKuIObbOmcjITi11Tp+v9qsTICfKXh/r3VI2n9hATLi8++IC5/IVf5x/IWUiNQ+LJ0MTAimn6Dz+Dq9ZNCajtEbhWVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ispboAbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDE5C4CEE8;
	Wed,  5 Mar 2025 09:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741165838;
	bh=uT2qFvkPEhiXZfnzHsLaR+FVpRjC893uHKYrLcZSt98=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ispboAbqDsc7sG8WbNWD0u6k7+QPEWMdVf6mZfdArUgVcrwOLwsHocRA+tf2wavPW
	 Gjib4fabaOpvtwzeYH6+olnGNPIvdYai30eqg/uvz5oBO98MV8OSWO4MEuIZRPHU7t
	 9PyAXupTfFjjJxf8qvkQe8qhJFVasGucvvQt0TK0z7TNEiyi1qJhRNNBkc84v3oJJX
	 sxpRQ5qejPweRgtwkwzFxiASFddQ06zsQnO/GPsjNdJax5dMffETzgM58T+V4KzQ81
	 twF5+z/wrBy5vpbPc4i256NNBCcUM2+8BkDshD3EKdAfOOzYV6g9pub7qEkzPZtX6O
	 nX8pzUmb7zzrg==
Message-ID: <41160b37-16ad-4c12-aad2-1214d87d3df0@kernel.org>
Date: Wed, 5 Mar 2025 17:10:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: subtract current_reserved_blocks from
 total
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250304192041.4048741-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250304192041.4048741-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 03:20, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> current_reserved_blocks is not allowed to utilize. For some zoned
> storage devices, vendors will provide extra space which was used for
> device level GC than specs and we will use this space for filesystem
> level GC. This extra space should not be shown to users, otherwise,
> users will see not standardized size number like 530GB, not 512GB.

Hi Daeho,

However, if there are other users e.g. oem or vendor want to use
reserved_blocks and current_reserved_blocks sysfs interface to
reserve space, then, total size will be less than 512GB?

What do you think of adding a new variable to indicate reserved
space for zoned storage case only?

Thanks,

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 19b67828ae32..c346dcc2518a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1833,10 +1833,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_type = F2FS_SUPER_MAGIC;
>  	buf->f_bsize = sbi->blocksize;
>  
> -	buf->f_blocks = total_count - start_count;
> -
>  	spin_lock(&sbi->stat_lock);
>  
> +	buf->f_blocks = total_count - start_count - sbi->current_reserved_blocks;
>  	user_block_count = sbi->user_block_count;
>  	total_valid_node_count = valid_node_count(sbi);
>  	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;


