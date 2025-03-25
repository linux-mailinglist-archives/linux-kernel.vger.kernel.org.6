Return-Path: <linux-kernel+bounces-574668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F72A6E849
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40CC175019
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441711494C9;
	Tue, 25 Mar 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDaT83ys"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4921210FB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742869197; cv=none; b=DZ0mHhS5hifnZ4rd/3n8EIxnr5JPXYy4A5QL3iDiUWQj0DtvCyR/T8t6aBlKWZIpB6a9V1lbNtsUhahaw4Tz7G56Rj70X3rKs2JwaUHXuv5EZKJN3HR4HqfYjFPAQ2TAxczOFzg1NndH14/EaXgZyheK1bOOcb9n5R5ZY6UpyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742869197; c=relaxed/simple;
	bh=wSctBKNRe6g0GRperENT7TTEViMYOGbWLRHvCzoCGg0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QP98J7VxRL9uHVqlspV0vQc+UW0rjOKOTQz53jXpb/Gj+nmy6QbohAwYe0pGFljxt/drrS7D+iGUJlBpAKdMeQi+KivohGbzgd4Ls5+6aJAH+Exqb7In8pMVp410ocULfHDtmnCzxSNjmiLNuufMSkUYFPF6C+JxF4f3OfV4qSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDaT83ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE2DC4CEE9;
	Tue, 25 Mar 2025 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742869196;
	bh=wSctBKNRe6g0GRperENT7TTEViMYOGbWLRHvCzoCGg0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qDaT83ysn6M7wv/3T6om+wUVRvMdiV1X/824PEvJ9DwSvyWlsz/8zlsMCOzYiHNjg
	 A8F8WXR/zWX1iXSjKkG0YFKMt4JpEZnwK7k/WJ4aLd6rAQGAEOam1hYulf9YZSVYPJ
	 p+BctDvU6XdaHYD8ezhKBOq9qfjZMcWZWdWe9WbRJ3x2fpm+TnB/yU8AMj5eymGETI
	 c55dacx0zKvdINJkCTOlwA86Cj689khZsW9gG+cxS0GPoqIhXel4cp1NEKR5fh62H7
	 fqv9Y8vDjWD2VLtVr8ZpkWF3d1mkxatIMX/lP8+2cibaCHwYS0RVuoP/R4h37Ko0hY
	 Sly2uw+7GP+aA==
Message-ID: <84f619ec-50cc-4767-81d8-f100ebbc9ae9@kernel.org>
Date: Tue, 25 Mar 2025 10:19:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support zero sized file truncate for
 device aliasing files
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250321213328.1170234-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250321213328.1170234-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/25 05:33, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> support a file truncation to zero size for device aliasing files.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: make the extent length zero
> ---
>  fs/f2fs/file.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f92a9fba9991..69952f208086 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -775,6 +775,11 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
>  		f2fs_update_time(sbi, REQ_TIME);
>  
>  		f2fs_put_page(ipage, 1);
> +
> +		write_lock(&et->lock);
> +		et->largest.len = 0;
> +		write_unlock(&et->lock);

f2fs_mark_inode_dirty_sync(inode, true); ?

Thanks,

> +
>  		goto out;
>  	}
>  
> @@ -1036,7 +1041,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  	if ((attr->ia_valid & ATTR_SIZE)) {
>  		if (!f2fs_is_compress_backend_ready(inode) ||
> -				IS_DEVICE_ALIASING(inode))
> +				(IS_DEVICE_ALIASING(inode) && attr->ia_size))
>  			return -EOPNOTSUPP;
>  		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
>  			!IS_ALIGNED(attr->ia_size,


