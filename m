Return-Path: <linux-kernel+bounces-292063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7466B956AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290561F22C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE916B397;
	Mon, 19 Aug 2024 12:22:29 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5ED16B75F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070148; cv=none; b=XmydpMb3rvBA4lSfHandh3EOmW841CflekMCMhyJfuR9OMoz7Yp1UihAbIkNsUwPtPpwtlvuoyIBCSTI8OtSNLyOu14vsBMIlZ2eiXU5PKVqtQiK97d/9XmwddOBnjHRDx9i7mJt3MP3oQb/7ravXRWYf9f6+5WIaWIRDF1Z+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070148; c=relaxed/simple;
	bh=mRyHg+Uftbj/JVe254gX3KhhMMXU6u24yzX1aJuT4v0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=jpBbrUd2U+1B0p6sFVlAAL5PyH0U+pUPCyp5Y2dSNErpdcsluQ60xDAuvR17CSG/MNquNDoICnTPnf2xQ0ZDCigJRHmlwCCLOKam+IbRxvwfwdUdV7qQ0kPE8nLdJij0hS2B2yDqwXmUBKcs7+BEQc9ZfPlk1Ey3EAfxP7jkbhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnWsN2J2JzpTWy;
	Mon, 19 Aug 2024 20:20:56 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id BEB98180101;
	Mon, 19 Aug 2024 20:22:24 +0800 (CST)
Received: from [10.67.108.52] (10.67.108.52) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 20:22:24 +0800
Message-ID: <9fb8ef10-2009-4c47-ac5f-298e57621e3b@huawei.com>
Date: Mon, 19 Aug 2024 20:22:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] soc: ixp4xx/qmgr: fix module autoloading
Content-Language: en-US
From: "liaochen (A)" <liaochen4@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <linusw@kernel.org>, <kaloz@openwrt.org>
References: <20240814031004.3876441-1-liaochen4@huawei.com>
In-Reply-To: <20240814031004.3876441-1-liaochen4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500020.china.huawei.com (7.185.36.49)

On 2024/8/14 11:10, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>   drivers/soc/ixp4xx/ixp4xx-qmgr.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
> index cb112f3643e9..dabcf91c3cae 100644
> --- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
> +++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
> @@ -454,6 +454,7 @@ static const struct of_device_id ixp4xx_qmgr_of_match[] = {
>           },
>   	{},
>   };
> +MODULE_DEVICE_TABLE(of, ixp4xx_qmgr_of_match);
>   
>   static struct platform_driver ixp4xx_qmgr_driver = {
>   	.driver = {
Gentle ping

Thanks,
Chen

