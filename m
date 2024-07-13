Return-Path: <linux-kernel+bounces-251401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D3D930480
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949692838FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644840BF5;
	Sat, 13 Jul 2024 08:16:35 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31711642B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720858594; cv=none; b=AuYcieSc/N+KtrzSIGiarQNCq3dG3KGptmlIufc9wB5yTHtCQ1qUSwYN030oy/+a/npfcJAG2LljlZfT7P7+51DCTRSSFVmYIVI72ejHDRbV/ge5EVwNYKSMFP8VCPaahvuekK5fUwjQ4LatBsTWiyV+a9hdDb1E3S2foE9aokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720858594; c=relaxed/simple;
	bh=Ew1yB2m/jyH3lSVQRVRP9aluvlWKckCw8s7PXNGNSco=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qJoSjiLh2akV8BzSVprRJxCxTgtTu6bRArVQNHTvfZ5vsVCcp0S14tmfDSFJnGo4F760JVrHHWua8hze+mmS5H71mPsV8QBuYd1anKlk9LqWH2mFdKkUgdarExQO55VlBB1t6jAERlIVJxtHvqqWaPAle5BhocmWvUTIoIreLNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WLh512nFlzxTQR;
	Sat, 13 Jul 2024 16:11:49 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id B990118005F;
	Sat, 13 Jul 2024 16:16:27 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 13 Jul 2024 16:16:27 +0800
Subject: Re: [PATCH] ubi: Fix ubi_init() ubiblock_exit() section mismatch
To: Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, Ben Hutchings <bwh@kernel.org>, kernel
 test robot <lkp@intel.com>
References: <20240713073519.25325-1-richard@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3c624cf1-b5a3-f89c-ac6a-0875fcabaf25@huawei.com>
Date: Sat, 13 Jul 2024 16:16:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240713073519.25325-1-richard@nod.at>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/7/13 15:35, Richard Weinberger Ð´µÀ:
> Since ubiblock_exit() is now called from an init function,
> the __exit section no longer makes sense.
> 
> Cc: Ben Hutchings <bwh@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407131403.wZJpd8n2-lkp@intel.com/
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   drivers/mtd/ubi/block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Looks like that you prefer a simpler fix. Feel fine to add

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index bf7308e8ec2fe..60d0155be869f 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -670,7 +670,7 @@ int __init ubiblock_init(void)
>   	return ret;
>   }
>   
> -void __exit ubiblock_exit(void)
> +void ubiblock_exit(void)
>   {
>   	ubi_unregister_volume_notifier(&ubiblock_notifier);
>   	ubiblock_remove_all();
> 


