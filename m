Return-Path: <linux-kernel+bounces-388115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FAB9B5ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DCCFB23581
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5A194085;
	Wed, 30 Oct 2024 04:45:58 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D133E1;
	Wed, 30 Oct 2024 04:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263558; cv=none; b=HPKahziTIXcRBKqn2aCBEIX12/nxOTJeQ1qANjYgRK0C5j/bUaRWpF2o8/Soaf8wuIzuuiAcSr0i3f7WVn8PMLwyyyWthfJIetYJ9QpdmijjWBslAeZZYN7G/wIKGhwP7dOXbpbCd6GsV5p8TbDE2oiZXD+GfzeZE6GUUWOjWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263558; c=relaxed/simple;
	bh=RiFRkTeWzWYOTOtTRqaMOnoGPHNFLH5m+GN2G8KKyes=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T0Zqulj5+Qnr+OTmFY+qyXbwgxByEHdHn5HYzxJXzNL2BxfGOomVyXEHBxojI5Co8HREq8T2pkBfUNYwxiX94vA5oS/brfj7Uio8uK+1Ooj8W/EqZ+4rnXHnvtDrVaBnS5bHYmUIuJ2EvpTlBzJYZl29umy1IYfkB0nLXURlq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XdZKn1Vmjz20r5F;
	Wed, 30 Oct 2024 12:44:45 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 4631B1A016C;
	Wed, 30 Oct 2024 12:45:44 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Oct 2024 12:45:43 +0800
Subject: Re: [PATCH] jffs2: remove redundant check on outpos > pos
To: Colin Ian King <colin.i.king@gmail.com>, David Woodhouse
	<dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241029222015.3069873-1-colin.i.king@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <cf07a880-1429-cc75-657e-55b32841cc00@huawei.com>
Date: Wed, 30 Oct 2024 12:45:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241029222015.3069873-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/30 6:20, Colin Ian King Ð´µÀ:
> The check for outpos > pos is always false because outpos is zero
> and pos is at least zero; outpos can never be greater than pos.
> The check is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   fs/jffs2/compr_rubin.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/fs/jffs2/compr_rubin.c b/fs/jffs2/compr_rubin.c
> index 556de100ebd5..9854253d0108 100644
> --- a/fs/jffs2/compr_rubin.c
> +++ b/fs/jffs2/compr_rubin.c
> @@ -276,11 +276,6 @@ static int rubin_do_compress(int bit_divider, int *bits, unsigned char *data_in,
>   
>   	end_rubin(&rs);
>   

Maybe this check could detect the overflow of 'pos', I guess.
> -	if (outpos > pos) {
> -		/* We failed */
> -		return -1;
> -	}
> -
>   	/* Tell the caller how much we managed to compress,
>   	 * and how much space it took */
>   
> 


