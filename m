Return-Path: <linux-kernel+bounces-435876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4709E7E2B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BEB1886842
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714363CF73;
	Sat,  7 Dec 2024 04:17:41 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152ED219FC;
	Sat,  7 Dec 2024 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733545061; cv=none; b=AEoIQrytjxaGoyXsxE/+yboEL6vZpgNLguhG04Klf8KIba1eUxweEuo3YRwHLw9OlbmE7IBiyJQws7kgIBRmiHB76AjRrX4NR/HasHs6RHonkE7zB3CuqWFMXL0dQ058IRGq1BioXs8UMkjSrLyGpsiI1JfuhknsCrAwvdRTJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733545061; c=relaxed/simple;
	bh=w1vUuuw2lEabhaxmKYm8/Hy8J1FHp8Q8/ya1gdv3jJs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pnRKlw4hXqSvEe3PXA2OMove8TQch2sRrq/D/AJhbqFCaLaQBmIhF/jUxGhd6VYMolVHGMpluTQhbWeCnetrAbrSnoEs3KdPPuCWV1xnPmLZFx+pgYOM0bETHrCR+DxRb0BIkCvfrttCpPBGUe/jGYKJDFkjHzPOAK1rLj2F+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y4vty5fvNzRhmq;
	Sat,  7 Dec 2024 12:15:54 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 426C51800FD;
	Sat,  7 Dec 2024 12:17:35 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 7 Dec 2024 12:17:34 +0800
Subject: Re: [PATCH] mtdchar: fix integer overflow in read/write ioctls
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <020f98d2-eee1-434e-8236-775cca9fd157@stanley.mountain>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e3da1bba-9740-6b6f-385a-1bdf25f056a9@huawei.com>
Date: Sat, 7 Dec 2024 12:17:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <020f98d2-eee1-434e-8236-775cca9fd157@stanley.mountain>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/12/7 4:26, Dan Carpenter Ð´µÀ:
> The "req.start" and "req.len" variables are u64 values that come from the
> user at the start of the function.  We mask away the high 32 bits of
> "req.len" so that's capped at U32_MAX but the "req.start" variable can go
> up to U64_MAX.
> 
> Use check_add_overflow() to fix this bug.
> 
> Fixes: 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE ioctl")

Hi, Dan. Why this fix tag? I think the adding result('req.start' and 
'req.len') could be overflow too before this commit.

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/mtd/mtdchar.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 8dc4f5c493fc..335c702633ff 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -599,6 +599,7 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
>   	uint8_t *datbuf = NULL, *oobbuf = NULL;
>   	size_t datbuf_len, oobbuf_len;
>   	int ret = 0;
> +	u64 end;
>   
>   	if (copy_from_user(&req, argp, sizeof(req)))
>   		return -EFAULT;
> @@ -618,7 +619,7 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
>   	req.len &= 0xffffffff;
>   	req.ooblen &= 0xffffffff;
>   
> -	if (req.start + req.len > mtd->size)
> +	if (check_add_overflow(req.start, req.len, &end) || end > mtd->size)
>   		return -EINVAL;
>   
>   	datbuf_len = min_t(size_t, req.len, mtd->erasesize);
> @@ -698,6 +699,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
>   	size_t datbuf_len, oobbuf_len;
>   	size_t orig_len, orig_ooblen;
>   	int ret = 0;
> +	u64 end;
>   
>   	if (copy_from_user(&req, argp, sizeof(req)))
>   		return -EFAULT;
> @@ -724,7 +726,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
>   	req.len &= 0xffffffff;
>   	req.ooblen &= 0xffffffff;
>   
> -	if (req.start + req.len > mtd->size) {
> +	if (check_add_overflow(req.start, req.len, &end) || end > mtd->size) {
>   		ret = -EINVAL;
>   		goto out;
>   	}
> 


