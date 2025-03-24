Return-Path: <linux-kernel+bounces-574017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE2EA6DF9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05BE7A5876
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785E2638AA;
	Mon, 24 Mar 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3Bn6TkT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427F2638AD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833726; cv=none; b=oFoQlN9uIvA/0I9WgNSzB+U1wasgw4E/W9ppeNW8ALoYtx3uM7FvjZfTQocdKzJU0X3fopzn6Kl4dPBt4ZD3mZd/vBsdJA60zNUX20840Xx0NkqyOQrVA7RlaJW3F+yU3eJVEj9csQInIIBWbpBa4X+f8aPmnhh5+5orv+cWxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833726; c=relaxed/simple;
	bh=aqrTfLY/lrY8xTfxHcwLv+bhNXJYhqwQeO1RoOh0ZDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvWwxHwUZWM1LjCIUI0EhfOXRcGcZ9bD78xalDbz8qg4/ae0XEhzc06Z0UIrKlnI43E/ji1qaMhvs5yxnkxX+tS7fPM44DUcqJKU6nN3jHH0eQGjCJ1cezkNffhujLHwZQK6G7ms+5BbRIT90qrBjB3ETxIS3UqrK1XxC0X5cyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3Bn6TkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6923EC4CEDD;
	Mon, 24 Mar 2025 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742833725;
	bh=aqrTfLY/lrY8xTfxHcwLv+bhNXJYhqwQeO1RoOh0ZDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3Bn6TkTgcdqsU5DfZ1FRKhsgAYnp8/9A7XfFyKdWmMGez/mlI7wWkmtaEAiEa406
	 OxbpuTpu8/eO6hAqUAEssea9Us64zqmj9piH4jV8YvUEWOHg1rZjIBonvIZa6EMYV2
	 K/KMKTecVCjLY7/odCyHUB/PC66cwzNG6FhHE9KzRfbIY7ZX8erLfMBRZ8DNVs8X+O
	 bHA7TJtEuyvNh8Lb3Y0rZk5Qz+bD1xhCSkVMlLnOCz26THmDaxbYn3/o7q6+62fr4e
	 H8DDtT0WYLgQvMIFtiP1KeqaurtxyMa1kK1dH4C5/tJiHwxtRRo7ROIx7scC4zTLAO
	 /e4mA4eXi6+Jw==
Date: Mon, 24 Mar 2025 16:28:43 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v2] f2fs: support zero sized file truncate for device
 aliasing files
Message-ID: <Z-GIOxj1reO87F6E@google.com>
References: <20250321213328.1170234-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321213328.1170234-1-daeho43@gmail.com>

Do we still need this patch?

On 03/21, Daeho Jeong wrote:
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
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

