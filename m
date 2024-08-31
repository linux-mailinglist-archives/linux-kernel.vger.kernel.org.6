Return-Path: <linux-kernel+bounces-309694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6C9966F63
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFA41C210FC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E113CA97;
	Sat, 31 Aug 2024 05:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqbdTo+8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2788713C682
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 05:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725081718; cv=none; b=Wo3OFJ/6+Eqn0NTc2nQmJKCp8nAT9mkIPCAfzifx+9BLWLdTqqW0g4KAFUdQ6xrvs5eJiOSnNCbmr3FHCiCnPZisTQplpBmUDH9brJjggxDMrJe7SDd91ECKaS1EyFVAFzNTnQMhld7uRyt2uRWe4HACDxLS6Jl+XkKdxrQMcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725081718; c=relaxed/simple;
	bh=t6pvwIAJmY+Lfq5UZ/PkWNLjWOzeiRgOYK52OWCETT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpmFDm+dB8AL3uQQtqtG+aPs2+4B1d3OLoOjGkTOVvgt594742O9l2ZLWmc29QgPZT9xj2xWuzG8yYBlP2qOXItzDLGzjrOG2zGlnWEkw4quZoEApCCzp7R7n86xwMSw1pq0I//f+4F7DDzqpovHCIBqP5oxJZxYjYGDZmWxu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqbdTo+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37638C4CEC0;
	Sat, 31 Aug 2024 05:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725081717;
	bh=t6pvwIAJmY+Lfq5UZ/PkWNLjWOzeiRgOYK52OWCETT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qqbdTo+8TeY6TbTVdQXd3kF8ug+Yx/M+sB+oLWzbQeNLz6OQ5e9POqdf350h3oFq2
	 YzS/ZY93122/xVtkkEJiGnkgZP0AKoISLrQA4Z6ZTzAXR38NP87grbNlX/qmwWsuex
	 tWaFClcY5+2FG2VSe/8rXo2WyJrK1fzq9kWWk0kQXgh1+hbOeST1kfdLmuAog5kJnI
	 Op1g7g0u34BtQRT1kSIntoGAtU5WXbAoBMz2GQfhXtsUSdLMrcW7EPo1T/9PF6xuZE
	 jZ9zrQT3iXfTlPCuNom8RpLJSbjHi8MRMwHEPPXriGCEMOwJEBIFRYamK0ETRCbMkb
	 xBPPQqw320S3Q==
Message-ID: <8a02ecd3-4e3d-4332-85da-8a0bdf4b9ed2@kernel.org>
Date: Sat, 31 Aug 2024 07:21:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/4] soc: ti: knav_dma: Use dev_err_probe() to
 simplfy code
To: Jinjie Ruan <ruanjinjie@huawei.com>, Nishanth Menon <nm@ti.com>
Cc: ssantosh@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jic23@kernel.org
References: <20240830063228.3519385-1-ruanjinjie@huawei.com>
 <20240830063228.3519385-3-ruanjinjie@huawei.com>
 <20240830103155.5vs2hdokw6yysq47@finance>
 <29edea69-92ce-2ac9-2aa8-bb9a4674ca01@huawei.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <29edea69-92ce-2ac9-2aa8-bb9a4674ca01@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/08/2024 03:59, Jinjie Ruan wrote:
> 
> 
> On 2024/8/30 18:31, Nishanth Menon wrote:
>> On 14:32-20240830, Jinjie Ruan wrote:
>>> Use the dev_err_probe() helper to simplify error handling
>>> during probe.
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>> v2:
>>> - Split into 2 patches.
>>> ---
>>>  drivers/soc/ti/knav_dma.c | 12 ++++--------
>>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
>>> index 15e41d3a5e22..eeec422a46f0 100644
>>> --- a/drivers/soc/ti/knav_dma.c
>>> +++ b/drivers/soc/ti/knav_dma.c
>>> @@ -708,17 +708,13 @@ static int knav_dma_probe(struct platform_device *pdev)
>>>  	struct device_node *node = pdev->dev.of_node;
>>>  	int ret = 0;
>>>  
>>> -	if (!node) {
>>> -		dev_err(&pdev->dev, "could not find device info\n");
>>> -		return -EINVAL;
>>> -	}
>>> +	if (!node)
>>> +		return dev_err_probe(&pdev->dev, -EINVAL, "could not find device info\n");
>>>  
>>>  	kdev = devm_kzalloc(dev,
>>>  			sizeof(struct knav_dma_pool_device), GFP_KERNEL);
>>> -	if (!kdev) {
>>> -		dev_err(dev, "could not allocate driver mem\n");
>>> -		return -ENOMEM;
>>> -	}
>>> +	if (!kdev)
>>> +		return dev_err_probe(dev, -ENOMEM, "could not allocate driver mem\n");
>>
>> These make no sense to me :( -> just using dev_err_probe when there is
>> no chance of -EPROBE_DEFER ?
> 
> I noticed a change in dev_err_probe() this year, which is described in
> this patch:
> 
> For an out-of-memory error there should be no additional output. Adapt
> dev_err_probe() to not emit the error message when err is -ENOMEM.
> This simplifies handling errors that might among others be -ENOMEM.
> 
> 
> And the comment of dev_err_probe() said below:
> 
> * Using this helper in your probe function is totally fine even if @err

Fine but not much useful and at the same time huge churn from @vivo.com.

Best regards,
Krzysztof


