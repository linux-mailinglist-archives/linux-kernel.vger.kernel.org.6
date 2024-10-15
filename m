Return-Path: <linux-kernel+bounces-365194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C0D99DEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C26B23DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878A118B468;
	Tue, 15 Oct 2024 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lRp2p7f8"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3614037F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975452; cv=none; b=l/039+556V1W5iTglKMAGj6zuKdfm5xoNl4efjd880n1MA9hS/6XufA89wwW6FuOKwNstIaSWMJpS3A5gkDhR2cl0fYxmV3u5u+bdncPUC2lJ6gceilHmw/eiX31XtCQRA6ju26mRxy8tzzxTRyy7Oy1zYRqBc22tXWvg87hmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975452; c=relaxed/simple;
	bh=Y4iYisPE+jBJC8rD/H+PzqkPMgerWST/XJ2cDwjOk2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YO4jG6nPenVB4pqfK2iHn4Q4nt3d3qQ1M8ySInApYJTx0XklYiI/rYLTE4CR6Sevt50f2fjnkRJn3DLSvqTWCnlAthdCDfzZjjruKlSaFEuz9QAzUZ6QQmQ3NczNIsXWH9p7c9J70wTjYXl5Wbdcsnn3P1DNYFelD2lwWIY3kYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lRp2p7f8; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728975448; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=B8nxFyU5YMoHcqu1ZHV4lDe6X80IG0w/RG5iDyYGDEA=;
	b=lRp2p7f8DzTymk7GEAc/nM5/0/bm+ASyxcRpCwLqy7CT43nR1wknOs6TMOLt2JLzquoWCsyO4Y/Fd/9S6aZBOf2wrFomdtwumVktbCD4jlMvtFxBZxrZ/MSnyYiHl7kcptwFXDEFQ0W5Z8fRewmRz0Wecn1TVM728zmswvzDnr8=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHCKdPH_1728975447 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 14:57:27 +0800
Message-ID: <f14d3bf9-ae99-40fb-ac4f-a0bd905259e6@linux.alibaba.com>
Date: Tue, 15 Oct 2024 14:57:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix blksize < PAGE_SIZE in fileio mode
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20241015064007.3449582-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241015064007.3449582-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/15 14:40, Hongzhen Luo wrote:
> In fileio mode, when blcksize is not equal to PAGE_SIZE,
> erofs will attempt to set the block size of sb->s_bdev,
> which will trigger a panic. This patch fixes this.

Please fix trivial typos:

erofs: fix blksize < PAGE_SIZE for file-backed mounts


Adjust sb->s_blocksize{,_bits} directly for file-backed
mounts when the fs block size is smaller than PAGE_SIZE.

Previously, EROFS used sb_set_blocksize(), which caused
a panic if bdev-backed mounts is not used.

> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> 

Unnecessary blank line.

> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v2: Add support for blocksize < PAGE_SIZE in file-backed mount mode.
> v1: https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/
> ---
>   fs/erofs/super.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 320d586c3896..abe2d85512dd 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -631,9 +631,15 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   			errorfc(fc, "unsupported blksize for fscache mode");
>   			return -EINVAL;
>   		}
> -		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
> -			errorfc(fc, "failed to set erofs blksize");
> -			return -EINVAL;
> +
> +		if (erofs_is_fileio_mode(sbi)) {
> +			sb->s_blocksize = (1 << sbi->blkszbits);
> +			sb->s_blocksize_bits = sbi->blkszbits;
> +		} else {
> +			if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
> +				errorfc(fc, "failed to set erofs blksize");
> +				return -EINVAL;
> +			}

Please use

		} else if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
			errorfc(fc, "failed to set erofs blksize");
			return -EINVAL;
		}
Here.

Thanks,
Gao Xiang

>   		}
>   	}
>   


