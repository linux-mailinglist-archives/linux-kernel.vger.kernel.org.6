Return-Path: <linux-kernel+bounces-400895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3499C13C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DDF1F23466
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CC417579;
	Fri,  8 Nov 2024 01:41:51 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D54DDC3;
	Fri,  8 Nov 2024 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731030111; cv=none; b=qoWQ0jA21Ub1AQ37i+aHW7Oi3JrSY1vpwRgYgOh35a0mxi698+9G40c7mtVxYbXLDwKTNJ7KLjqo9XVftb0w7wDmv1IzmhfE7EGxafNrdYBgZwQZ2gKVXbnea3Qw5vhwO8snmuaGmcak7jtjg+FuqxOWzDdvDt1p8bVYbUzQ8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731030111; c=relaxed/simple;
	bh=3n4VRaBqdU5n0cVEdtc+ZK5ooA4vvZg0q9qsSHRics8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oxyykn+QZ0y1rQLrKcLxTHAl780EbLiZgIIsxkSyJCIacU7J4Q7hyBTLQ8ynySBZFCpU7qD3PI0SwfAfL8Fe5srRqmkkek5A1LqtLxdo25ss1tRbdd+UIjToW2J4g5EpltdgqRmC05j8LO1XQ+nqibdx7NqvZaFSngUY31/9gwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Xl1q85XqvzQs71;
	Fri,  8 Nov 2024 09:40:36 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id AA35818012B;
	Fri,  8 Nov 2024 09:41:45 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Nov 2024 09:41:44 +0800
Subject: Re: [PATCH] mtd: ubi: remove redundant check on bytes_left at end of
 function
To: Colin Ian King <colin.i.king@gmail.com>, Richard Weinberger
	<richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241107152357.63387-1-colin.i.king@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <56b13d09-91ce-6a4b-c6cb-449b478e3335@huawei.com>
Date: Fri, 8 Nov 2024 09:41:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241107152357.63387-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2024/11/7 23:23, Colin Ian King 写道:
> In function ubi_nvmem_reg_read the while-loop can only be exiting
> of bytes_left is zero or an error has occurred. There is an exit
> return path if an error occurs, so the bytes_left can only be
> zero after that point. Hence the check for a non-zero bytes_left
> at the end of the function is redundant and can be removed. Remove
> the check and just return 0.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/mtd/ubi/nvmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Make sense.
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
> index a94a1a9aaec1..34f8c1d3cdee 100644
> --- a/drivers/mtd/ubi/nvmem.c
> +++ b/drivers/mtd/ubi/nvmem.c
> @@ -55,7 +55,7 @@ static int ubi_nvmem_reg_read(void *priv, unsigned int from,
>   	if (err)
>   		return err;
>   
> -	return bytes_left == 0 ? 0 : -EIO;
> +	return 0;
>   }
>   
>   static int ubi_nvmem_add(struct ubi_volume_info *vi)
> 


