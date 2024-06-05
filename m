Return-Path: <linux-kernel+bounces-202603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004A8FCF24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F577B286A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8263219B593;
	Wed,  5 Jun 2024 12:27:16 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155614D447
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590436; cv=none; b=fcPCS47vYXAzA6nORHVfhUGipTFDeuT9C0BSWxzKojriVQdx4mp4vnR/Fo9LwRJKMsJLtEOWD1CB6T+jPuNcmlhLjoV0Zw0yW6EwWF9auvt3zJnXE+s5LJKSvjG6q7vngEH/euHXfafk4p57Jwh1ge3Z3BySpLvmKlKAKKw8QwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590436; c=relaxed/simple;
	bh=UH+a2KNv7+kayHPhr6nzPqbtcC4qYCR4EJS1G8kFWxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHhs4kgToqxN6VJues1VZc2yw2irhRqCrPy5zlN8cAdpZ/ycoAH72xJco0u1kYVDS9siZkDssLovTWhsxUQ1PYFAH8MnLp1AXrY6h/hgoDvrA9vnQiTX8EuwkDrncVlzoNryGZYt2pHluiAnFmAYxQ04j6PdSSY22VVX7AbjRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sEpjH-000000005ku-0xUu;
	Wed, 05 Jun 2024 12:26:59 +0000
Date: Wed, 5 Jun 2024 13:26:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: linan666@huaweicloud.com
Cc: richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
	chaitanya.kulkarni@wdc.com, axboe@kernel.dk,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3] ubi: block: fix null-pointer-dereference in
 ubiblock_create()
Message-ID: <ZmBZj6wnh_UvuabD@makrotopia.org>
References: <20240522171035.3776026-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522171035.3776026-1-linan666@huaweicloud.com>

On Thu, May 23, 2024 at 01:10:35AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> Similar to commit adbf4c4954e3 ("ubi: block: fix memleak in
> ubiblock_create()"), 'dev->gd' is not assigned but dereferenced if
> blk_mq_alloc_tag_set() fails, and leading to a null-pointer-dereference.
> Fix it by using pr_err() and variable 'dev' to print error log.
> 
> Additionally, the log in the error handle path of idr_alloc() has
> been improved by using pr_err(), too. Before initializing device
> name, using dev_err() will print error log with 'null' instead of
> the actual device name, like this:
>   block (null): ...
>         ~~~~~~
> It is unclear. Using pr_err() can print more details of the device.
> The improved log is:
>   ubiblock0_0: ...
> 
> Fixes: 77567b25ab9f ("ubi: use blk_mq_alloc_disk and blk_cleanup_disk")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Li Nan <linan122@huawei.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
> v3: spliting this patch into two in v2 is not a good idea. This version
> is consistent with v1, but only optimizes the commit message.
> 
>  drivers/mtd/ubi/block.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index f82e3423acb9..bf7308e8ec2f 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -390,7 +390,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
>  
>  	ret = blk_mq_alloc_tag_set(&dev->tag_set);
>  	if (ret) {
> -		dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
> +		pr_err("ubiblock%d_%d: blk_mq_alloc_tag_set failed\n",
> +			dev->ubi_num, dev->vol_id);
>  		goto out_free_dev;
>  	}
>  
> @@ -407,8 +408,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
>  	gd->minors = 1;
>  	gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
>  	if (gd->first_minor < 0) {
> -		dev_err(disk_to_dev(gd),
> -			"block: dynamic minor allocation failed");
> +		pr_err("ubiblock%d_%d: block: dynamic minor allocation failed\n",
> +			dev->ubi_num, dev->vol_id);
>  		ret = -ENODEV;
>  		goto out_cleanup_disk;
>  	}
> -- 
> 2.39.2
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

