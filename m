Return-Path: <linux-kernel+bounces-210891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B8F9049B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1F21C234FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9F520332;
	Wed, 12 Jun 2024 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItJOrarJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997B1799B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718163574; cv=none; b=XkxvICrCU8XsgLsydLXvBMwifpXeS+FdkEVheU6yGx4RJdSuBvE6VrJc9WHJ9yf3qN/Ysf5DjyXhloWuaIA0YMA/ntdA9P/lKbXtg5ZDfI2XA7ZpaflYQqdeUqh40Lzukbius3KynJb/3OrlcEb9Zy/mhYgP24sFBQLDru7fiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718163574; c=relaxed/simple;
	bh=rcGTD1NatArwiA0ZaZbZWpjBQNKwW0dWWPYaKK68C9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nunX2RW00AI6Ga7gCy9a814mI98ZC0TvfIRgwscL6UVNKXY2Y8YFOED5TnbvkMAnr3EHfohnRGO9ey0sRNbu1Co6mOXvzSLeskZz0hRFsdlfHOHmg80qrsecBtpFwuO8Az39BQ3hM3nJzr+7p1GF3CuBpWPVxH8zvywxkZrrhyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItJOrarJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD64C2BD10;
	Wed, 12 Jun 2024 03:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718163573;
	bh=rcGTD1NatArwiA0ZaZbZWpjBQNKwW0dWWPYaKK68C9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ItJOrarJ6UePkisoSxV5WrMfDHj+OxxwDL1bsCm/ovyOEQzdY+dGpZZ1zW8i3LSsG
	 lsr5xHWPLC+y7UMjGtnFZjnMv6xb3jk5KZidGVSRcnF6p9uVr+75+iUXwQK9uqAj8S
	 MU/LHJzFRh3oQ6WZL4BHyeX/K6NN4pMDyyJiLjyjO7tR5O5BuNdjMvMg3fSBKxuGN+
	 vIdqqxYp4gzrsg2dJzxmJGpzsjVq8+U2x/RxGPZnoqIjhjex/Di59QKO3CfkhtuUDF
	 j2UV7JsWGLB3jxZVEeQgHdgK1xsMeZ+03a7KmNvbY7KFhesn5bmONachK402SdqLgT
	 9169DUfwann7A==
Message-ID: <dfdf7dac-90e2-4ee7-8258-ffca0c777d9e@kernel.org>
Date: Wed, 12 Jun 2024 11:39:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix convert inline inode on readonly mode
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Dongjin Kim <dongjin_.kim@samsung.com>,
 Seokhwan Kim <sukka.kim@samsung.com>, Yonggil Song
 <yonggil.song@samsung.com>, Eunhee Rho <eunhee83.rho@samsung.com>,
 Jaeyoon Choi <j_yoon.choi@samsung.com>, Nayeon Kim
 <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
References: <CGME20240612022012epcms2p77300b5130d18b0397c9fc2877704949d@epcms2p7>
 <20240612022012epcms2p77300b5130d18b0397c9fc2877704949d@epcms2p7>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240612022012epcms2p77300b5130d18b0397c9fc2877704949d@epcms2p7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/12 10:20, Daejun Park wrote:
> syzbot reported a bug in f2fs_vm_page_mkwrite() which checks for
> f2fs_has_inline_data(inode).
> The bug was caused by f2fs_convert_inline_inode() not returning an
> error when called on a read-only filesystem, but returning with the
> inline attribute as set.
> This patch fixes the problem by ensuring that f2fs_convert_inline_inode()
> returns -EROFS on readonly.
> 
> Fixes: ec2ddf499402 ("f2fs: don't allow any writes on readonly mount")
> Reported-by: syzbot+f195123a45ad487ca66c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f195123a45ad487ca66c
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Hi Daejun,

I guess below patch has fixed this issue, so we need to tag the report
as duplicated?

https://lore.kernel.org/linux-f2fs-devel/20240603010745.2246488-1-chao@kernel.org/T/#u

Thanks,

> ---
>   fs/f2fs/inline.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 7638d0d7b7ee..ae1d8f2d82c9 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -203,10 +203,12 @@ int f2fs_convert_inline_inode(struct inode *inode)
>          struct page *ipage, *page;
>          int err = 0;
> 
> -       if (!f2fs_has_inline_data(inode) ||
> -                       f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
> +       if (!f2fs_has_inline_data(inode))
>                  return 0;
> 
> +       if (unlikely(f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb)))
> +               return -EROFS;
> +
>          err = f2fs_dquot_initialize(inode);
>          if (err)
>                  return err;
> --
> 2.25.1
> 

