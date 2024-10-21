Return-Path: <linux-kernel+bounces-373564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D19A58DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87A9282B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67AA2EB02;
	Mon, 21 Oct 2024 02:30:04 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343719BA6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729477804; cv=none; b=H6Ta6Tq8/cAEnnx8aG4WW8DTLU+PGGtiHvSy+2q/8hUi87aKNDt/gbu/Q7beRA5lsDgCHR20UXgrIbO8ELwpkoG+ljottHRdIR5p5xdBcDl40JyIKpt3KiiZjNY5yNCqdzJM56yESvHIFLNQXpqAaU/5Llsh9HIj8BBbHrl9OLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729477804; c=relaxed/simple;
	bh=APP2ZKmLkrw81biRI32U+QH7TU2wRU9Akwf0S52bu9E=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BH/RrjYmsZaRueOx9TUd3bSLF8rW7x3JmRTjkNVc1SJrvgF1FsAVEK3Blc2unjFeOVVdNwDjCN76PZ091Mk6kXlbZ+z/oZ8RiNhpQQqzJcZddCzX3Th+kAVLfgSsTOQ+luIWxdXXk/SgSjv7gtDRrBsm4g3tLrhkdE1KbgDAOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XWzgM32vLz1HLDB;
	Mon, 21 Oct 2024 10:25:35 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id C2C6314037D;
	Mon, 21 Oct 2024 10:29:53 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Oct 2024 10:29:52 +0800
Subject: Re: [PATCH] mtd: ubi: fix unreleased fwnode_handle in
 find_volume_fwnode()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Richard Weinberger
	<richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Daniel Golle <daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241019-mtd-uvi-fwnode_handle_put-v1-1-f5ef0d0cf9c8@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f475a196-db30-7aef-6bc7-3c7d0e962382@huawei.com>
Date: Mon, 21 Oct 2024 10:29:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241019-mtd-uvi-fwnode_handle_put-v1-1-f5ef0d0cf9c8@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2024/10/20 4:27, Javier Carrasco 写道:
> The 'fw_vols' fwnode_handle initialized via
> device_get_named_child_node() requires explicit calls to
> fwnode_handle_put() when the variable is no longer required.
> 
> Add the missing calls to fwnode_handle_put() before the function
> returns.
> 
> Fixes: 51932f9fc487 ("mtd: ubi: populate ubi volume fwnode")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/mtd/ubi/vmt.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 5a3558bbb903..e5cf3bdca3b0 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -143,8 +143,10 @@ static struct fwnode_handle *find_volume_fwnode(struct ubi_volume *vol)
>   		    vol->vol_id != volid)
>   			continue;
>   
> +		fwnode_handle_put(fw_vols);
>   		return fw_vol;
>   	}
> +	fwnode_handle_put(fw_vols);
>   
>   	return NULL;
>   }
> 
> ---
> base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
> change-id: 20241019-mtd-uvi-fwnode_handle_put-7b220d2778b5
> 
> Best regards,
> 


