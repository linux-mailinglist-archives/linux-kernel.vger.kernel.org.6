Return-Path: <linux-kernel+bounces-310693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC5968032
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5C91F2369C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D2182D2;
	Mon,  2 Sep 2024 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E1qWPfwS"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD38914BF89
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261118; cv=none; b=D3tJAifLJyRy6/Buq+OCR58tIxiOx+h2xB7rmF01U6s88cgMhVcR8enF3w0L3gXEB6vp1cYWvg987fPDMGGJvCzCEBgLIz0DCtCdkoVI6Pcj+4OdBz1Zbpvf3AhNeZLfqe5zx9BovkWRfpHjudI5PzzLkwkFXj+y+ZVB7AvaD/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261118; c=relaxed/simple;
	bh=hJCeeH2smdCNPIPMyw0NXWVcV8E/92r/DYvq+PmKub8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4UXmov/cj5g7TITgiTDp8gTEmWBN/2CghanNe5aiPZFPCW7YXUk2GEv4GR+JWNUewooUmfDrmyH5/PoerdtkRD8Xi9mKFIjhL2O/t/JyZiiBpitdGQT4XWsds6Dq2WPiEoScT7IttyXY/rofcy0KDHK4Lp7Ks5Gri9e5wVd0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E1qWPfwS; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725261108; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8CiRHCW9jgKllSt8b4QOJ9tEtCjDj7gOyPLUTr+89X8=;
	b=E1qWPfwSjGiOUFOwKWFTrlM82pxxCPXN/SelSYPaU53lx4LTPfUd6ciXnud+MuXCOAmaZEcc5rVbBOrZCsVSwrQBx4Sp2AzAD6ew8u6bARKx/04bK4eSDqIsy4HL0moFqMqxcTgT9/kIACQ9GGGnmrdogAOcWGPlMdeDKwTP/FA=
Received: from 30.244.151.91(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE4c6OU_1725261106)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 15:11:47 +0800
Message-ID: <bfcd83f8-87ef-4282-b9e9-700c45fc3302@linux.alibaba.com>
Date: Mon, 2 Sep 2024 15:11:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20240902070047.384952-1-toolmanp@tlmp.cc>
 <20240902070047.384952-2-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902070047.384952-2-toolmanp@tlmp.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/2 15:00, Yiyang Wu via Linux-erofs wrote:
> Remove open coding in erofs_fill_symlink.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> ---
>   fs/erofs/inode.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 419432be3223..d051afe39670 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -188,22 +188,20 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>   		return 0;
>   	}
>   
> -	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
> -	if (!lnk)
> -		return -ENOMEM;
> -
>   	m_pofs += vi->xattr_isize;
>   	/* inline symlink data shouldn't cross block boundary */
>   	if (m_pofs + inode->i_size > bsz) {
> -		kfree(lnk);
>   		erofs_err(inode->i_sb,
>   			  "inline data cross block boundary @ nid %llu",
>   			  vi->nid);
>   		DBG_BUGON(1);
>   		return -EFSCORRUPTED;
>   	}
> -	memcpy(lnk, kaddr + m_pofs, inode->i_size);
> -	lnk[inode->i_size] = '\0';
> +
> +	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> +

Unnecessary new line.

Also I wonder if it's possible to just
	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
	if (!inode->i_link)
		return -ENOMEM;

here, and get rid of variable lnk.

Otherwise it looks good to me.

Thanks,
Gao Xiang

> +	if (!lnk)
> +		return -ENOMEM;
>   
>   	inode->i_link = lnk;
>   	inode->i_op = &erofs_fast_symlink_iops;


