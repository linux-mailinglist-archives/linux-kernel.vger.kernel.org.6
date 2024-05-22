Return-Path: <linux-kernel+bounces-185983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D1A8CBDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AD11C221F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D42380628;
	Wed, 22 May 2024 09:22:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742F80604
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369732; cv=none; b=O32kSCaMEGbb7Vg66MLLGAbwHY3MpvC5Pj0fhul0BNZaNZ9i0NNJqfF+9La7sFg9nCL1Tf+C3h4oIclkNt7ankGazwlANSxkkA5AMyABl70ofD1sm1TJl0sYBy+EBSxdbplZJ8eA+pXzpPXZ/PQW2Jo2ypU7X+X1HfoJzeF5nfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369732; c=relaxed/simple;
	bh=O8htgIkuoIFQNuH/VPOT1x12yQuup/Xx/2BAEISPZO8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fgcv8inUjykMBPKNYvWLvu33StsPC+dJL+B5yiKt8gWc/ETUbtq+5NzQA9uzNFBuNs/ZNk7it7A1kWAZHwrrWV37ZdJpPbya7CFZ1XbXwiO/iop8sW3h7hbuQZSfFQXQA3epsI2PFqL899Ik5OX+0jm/UgLnIHNx79gced/2PZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vkm1q58g1zxNj0;
	Wed, 22 May 2024 17:18:23 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 189E7140382;
	Wed, 22 May 2024 17:22:05 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 17:22:03 +0800
Subject: Re: [PATCH v3] ubi: block: fix null-pointer-dereference in
 ubiblock_create()
To: <linan666@huaweicloud.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
	<vigneshr@ti.com>, <chaitanya.kulkarni@wdc.com>, <axboe@kernel.dk>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yukuai3@huawei.com>, <yi.zhang@huawei.com>, <houtao1@huawei.com>,
	<yangerkun@huawei.com>
References: <20240522171035.3776026-1-linan666@huaweicloud.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <2ff2133d-ba50-08b4-a16f-b33d0470fa12@huawei.com>
Date: Wed, 22 May 2024 17:22:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240522171035.3776026-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/5/23 1:10, linan666@huaweicloud.com Ð´µÀ:
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
>    block (null): ...
>          ~~~~~~
> It is unclear. Using pr_err() can print more details of the device.
> The improved log is:
>    ubiblock0_0: ...
> 
> Fixes: 77567b25ab9f ("ubi: use blk_mq_alloc_disk and blk_cleanup_disk")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
> v3: spliting this patch into two in v2 is not a good idea. This version
> is consistent with v1, but only optimizes the commit message.
> 
>   drivers/mtd/ubi/block.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index f82e3423acb9..bf7308e8ec2f 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -390,7 +390,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
>   
>   	ret = blk_mq_alloc_tag_set(&dev->tag_set);
>   	if (ret) {
> -		dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
> +		pr_err("ubiblock%d_%d: blk_mq_alloc_tag_set failed\n",
> +			dev->ubi_num, dev->vol_id);
>   		goto out_free_dev;
>   	}
>   
> @@ -407,8 +408,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
>   	gd->minors = 1;
>   	gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
>   	if (gd->first_minor < 0) {
> -		dev_err(disk_to_dev(gd),
> -			"block: dynamic minor allocation failed");
> +		pr_err("ubiblock%d_%d: block: dynamic minor allocation failed\n",
> +			dev->ubi_num, dev->vol_id);
>   		ret = -ENODEV;
>   		goto out_cleanup_disk;
>   	}
> 


