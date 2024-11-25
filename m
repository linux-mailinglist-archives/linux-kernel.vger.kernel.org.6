Return-Path: <linux-kernel+bounces-421111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D39D882D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2742BB30120
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2A318872F;
	Mon, 25 Nov 2024 13:42:01 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EE1AAE39
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542120; cv=none; b=qG6VDPLDLyJaR9igAY6QBxW9fN+0NfHJoS1TLRjT9KxlXVKUs0oBtBZfr6+IZhS4T34dVCwhc9tQBybl5KoBQBdCHi76x9Ry0yhpGIjvj+PIUSLYnqN7Sk1j5zwuaFWT1pmta58VvLlRPY3SpPNDvqBbo044q8li0VhtUp2YP9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542120; c=relaxed/simple;
	bh=IOb4xkY9FbG/hWBg/6VAOcvJsEjr0AoYgOm/SR1Q8aA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fyY+OlD2mTXy5LSylOhLzbvPG+9FmXC+rfTGUPmEvkOoG40TCg0IbFot60LbRS1i4ALVnQCkCdzLBkT7dsH2fhHvDwT4Z1YTmzAwMZvvg0MLnyQwf2nFdmhlYdN8jU7MsL+UiQ0xb6LiQG+g05xmU0zoAhnoyRGipFteMsMDGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XxmyM3kjKzWfQS;
	Mon, 25 Nov 2024 21:39:07 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 455F81800A7;
	Mon, 25 Nov 2024 21:41:53 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 21:41:52 +0800
Subject: Re: [PATCH] mtd: ubi: Added a check for ubi_num
To: Denis Arefev <arefev@swemel.ru>, Richard Weinberger <richard@nod.at>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241125132354.16188-1-arefev@swemel.ru>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <62854804-c692-0e18-94af-67efd86af61e@huawei.com>
Date: Mon, 25 Nov 2024 21:41:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241125132354.16188-1-arefev@swemel.ru>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/11/25 21:23, Denis Arefev Ð´µÀ:
> Added a check for ubi_num for negative numbers
> If the variable ubi_num takes negative values then we get:
> 
> qemu-system-arm ... -append "ubi.mtd=0,0,0,-22222345" ...
> [    0.745065]  ubi_attach_mtd_dev from ubi_init+0x178/0x218
> [    0.745230]  ubi_init from do_one_initcall+0x70/0x1ac
> [    0.745344]  do_one_initcall from kernel_init_freeable+0x198/0x224
> [    0.745474]  kernel_init_freeable from kernel_init+0x18/0x134
> [    0.745600]  kernel_init from ret_from_fork+0x14/0x28
> [    0.745727] Exception stack(0x90015fb0 to 0x90015ff8)
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 897a316c9e6f ("UBI: handle attach ioctl")

Hi Denis,
I think the problem is imported by 
83ff59a066637a6c28844bbf43009459408240f4("UBI: support ubi_num on 
mtd.ubi command line").
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>   drivers/mtd/ubi/build.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 30be4ed68fad..dae569f48b87 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -920,7 +920,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
>   			return -ENFILE;
>   		}
>   	} else {
> -		if (ubi_num >= UBI_MAX_DEVICES)
> +		if (ubi_num < UBI_DEV_NUM_AUTO || ubi_num >= UBI_MAX_DEVICES)
>   			return -EINVAL;

The ioctl(UBI_IOCATT) already checks the 'ubi_num', so I prefer to add 
the missing check in ubi_mtd_param_parse().
>   
>   		/* Make sure ubi_num is not busy */
> 


