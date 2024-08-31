Return-Path: <linux-kernel+bounces-309660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C6B966EB3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 03:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AACE1C220B5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E522C87A;
	Sat, 31 Aug 2024 01:59:40 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5118C31
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725069580; cv=none; b=uPjU6Rq43IKWm/o/oUDurCVexHq4gsJ1ZOMZup3hkNFzlITStVhLzilga0V4J60b0Vo2XpfqXqd5USFzjNDVm00YrxBaSUK/Q2SqN4zYqBp+Ikk+trDiz5L77FIHK7SSCSKq7XjDX4D4R1picFD6/zkvhR/ViUAk7/fpd02ajDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725069580; c=relaxed/simple;
	bh=kt7qO0fPMmi0stpWN8v5r09xwBk+fZycMq5bARFsZBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BWPObwu5pI6/tFMRq/V68cPmm7AUA8gzYmavrhvXlRUYP/wWq8Mw3tm8iuzi5redLBW97CS8AH9eCNySSt8MoRqXrCIwXh4tNxIjFIYKGk/HpE9vA1quGZUpNVAwjDAm6Qq70GvGJdLPfxdI5xDxKLKd/DfmpAz97RCNNdz34Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwdPG1yZqz20l6g;
	Sat, 31 Aug 2024 09:54:42 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 846B2140133;
	Sat, 31 Aug 2024 09:59:34 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 31 Aug 2024 09:59:33 +0800
Message-ID: <29edea69-92ce-2ac9-2aa8-bb9a4674ca01@huawei.com>
Date: Sat, 31 Aug 2024 09:59:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v2 2/4] soc: ti: knav_dma: Use dev_err_probe() to
 simplfy code
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>,
	<"ukleinek@kernel.org  u.kleine-koenig"@pengutronix.de>
CC: <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>, <jic23@kernel.org>
References: <20240830063228.3519385-1-ruanjinjie@huawei.com>
 <20240830063228.3519385-3-ruanjinjie@huawei.com>
 <20240830103155.5vs2hdokw6yysq47@finance>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240830103155.5vs2hdokw6yysq47@finance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/30 18:31, Nishanth Menon wrote:
> On 14:32-20240830, Jinjie Ruan wrote:
>> Use the dev_err_probe() helper to simplify error handling
>> during probe.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v2:
>> - Split into 2 patches.
>> ---
>>  drivers/soc/ti/knav_dma.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
>> index 15e41d3a5e22..eeec422a46f0 100644
>> --- a/drivers/soc/ti/knav_dma.c
>> +++ b/drivers/soc/ti/knav_dma.c
>> @@ -708,17 +708,13 @@ static int knav_dma_probe(struct platform_device *pdev)
>>  	struct device_node *node = pdev->dev.of_node;
>>  	int ret = 0;
>>  
>> -	if (!node) {
>> -		dev_err(&pdev->dev, "could not find device info\n");
>> -		return -EINVAL;
>> -	}
>> +	if (!node)
>> +		return dev_err_probe(&pdev->dev, -EINVAL, "could not find device info\n");
>>  
>>  	kdev = devm_kzalloc(dev,
>>  			sizeof(struct knav_dma_pool_device), GFP_KERNEL);
>> -	if (!kdev) {
>> -		dev_err(dev, "could not allocate driver mem\n");
>> -		return -ENOMEM;
>> -	}
>> +	if (!kdev)
>> +		return dev_err_probe(dev, -ENOMEM, "could not allocate driver mem\n");
> 
> These make no sense to me :( -> just using dev_err_probe when there is
> no chance of -EPROBE_DEFER ?

I noticed a change in dev_err_probe() this year, which is described in
this patch:

For an out-of-memory error there should be no additional output. Adapt
dev_err_probe() to not emit the error message when err is -ENOMEM.
This simplifies handling errors that might among others be -ENOMEM.


And the comment of dev_err_probe() said below:

* Using this helper in your probe function is totally fine even if @err
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
is
~~
 * known to never be -EPROBE_DEFER.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

https://lore.kernel.org/all/3d1e308d45cddf67749522ca42d83f5b4f0b9634.1718311756.git.u.kleine-koenig@baylibre.com/
> 
>>  
>>  	kdev->dev = dev;
>>  	INIT_LIST_HEAD(&kdev->list);
>> -- 
>> 2.34.1
>>
> 

