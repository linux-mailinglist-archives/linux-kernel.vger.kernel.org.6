Return-Path: <linux-kernel+bounces-308612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F106B965FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3FB2B9A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4118B474;
	Fri, 30 Aug 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtug+pcL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61112184543
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014548; cv=none; b=opGoubd6YxGRAvv0cU6DPzvPnUnTo72Fq0VqCX5bwjIaMSfFhURp8SOB2KnKYHZmnk0uvyrISGuKEVXmYQtpQ+n9tQJ2e541NgtSYSKjBZTpSw9EMX1udUlrBnjzAaNKqeSVPZHF/y0OiQnHvcAT6fi+nBVlz1vSI9DUzmH5ceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014548; c=relaxed/simple;
	bh=jA4lsgsFD3X8QkYNItr6qi1y+umk+wphRQhygk8nt0c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IB9Ov2plXVPat5tM6/XDmkhKu3EW7gBKHnXV4pkagSeHnDomzNwkLMnKB0XAZdcHIPbAi8s99rjlq3QA+XgipAd5/K45pV2ZUlgQPjJ47+TGU4mqwY6ypM+hw2fdZyfz0Lfh78kwybm+aJCKyPV7ILSRNwoUufZjUgOy0Nk1A2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtug+pcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9481FC4CEC2;
	Fri, 30 Aug 2024 10:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725014548;
	bh=jA4lsgsFD3X8QkYNItr6qi1y+umk+wphRQhygk8nt0c=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Gtug+pcLEhXm1o4ptqD2oXpjWByeNyAkqMC+xTmyG7+Cs+7axtNBqHbtE3KDsEYTQ
	 iMAFTcSHVOJNrgYZfjEigiw/cX7ZsJ3ky4yGDfaT+q6NG9+qGX0QFpsjfiUKTm1sbA
	 yoalz97N1Rspmtd9aGt1yCKEFn3+32KbsMSZKiB40K090tRG3Pl4P+gnhFDP0OA71W
	 QVWvxqTGAfqve1yFziZoVHMc0Gz43ieqtiQKm26MjqQ6JyRsl2bQl+XwHZF9pFqwuJ
	 sywxqej+OHLSdx1Yi58cVIht9T+l2P51vrTWO8qsWSsLsQiDTKj/SOHR8csMW66AJ6
	 WbGPKE+xnYnVw==
Message-ID: <dc5cd6e7-5cdb-4418-b67f-555a34138cba@kernel.org>
Date: Fri, 30 Aug 2024 12:42:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/4] soc: ti: knav_dma: Use dev_err_probe() to
 simplfy code
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nishanth Menon <nm@ti.com>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: ssantosh@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jic23@kernel.org
References: <20240830063228.3519385-1-ruanjinjie@huawei.com>
 <20240830063228.3519385-3-ruanjinjie@huawei.com>
 <20240830103155.5vs2hdokw6yysq47@finance>
 <1757c33c-a407-4a23-806d-658d9abe051f@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <1757c33c-a407-4a23-806d-658d9abe051f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2024 12:36, Krzysztof Kozlowski wrote:
> On 30/08/2024 12:31, Nishanth Menon wrote:
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
> Well, this does not make sense from other point of view - memory
> allocation errors should have any printks...

s/should/should not/

obviously :)

> 
> This patchset - like several others from Jinjie - is some sort of
> automation without careful consideration and without thinking whether
> code makes sense.
> 
> Therefore I suggest to review it thoroughly and do not trust the
> "innocent" look of such changes.


Best regards,
Krzysztof


