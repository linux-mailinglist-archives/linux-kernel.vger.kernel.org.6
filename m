Return-Path: <linux-kernel+bounces-324857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE969751A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAE81C214EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC89190671;
	Wed, 11 Sep 2024 12:13:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E395B187342;
	Wed, 11 Sep 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056828; cv=none; b=ZIxHMLi3RbXDLa7Kh2JQWnRjuT0aA0DXKa8HyrEl9/a2yBEsd9Rbyv/hQne+se1usL++3PavyPCdW/FHJHws2GPNasyPx8zs+PcYcH5e9M1TlbdAsh3kTg4VL3unse66CYRJo/7MBIl1HUwQepvrM3jj2y4XXnmSKR1kl3zzbWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056828; c=relaxed/simple;
	bh=jx5Wlnh9G6QigmBJO1dFY8YiPBCehSxeoR4AHtmUFcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5tgSk9noNXtoPlg8Yfl/dFM7XlXhxRJL2oAq29ufLqfZssP555ydzqmodcQAz+N6KpbQtxUOZ+5IAeHPgZnWZrq+IRkA59NR87sIiIwiQJvIN7fwGpI1ZKeCeQqhdcRLGs6IqpL5LfcoaNEoed6jO0DkNNrAmJL8bFEHZXGh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4CCA1007;
	Wed, 11 Sep 2024 05:14:15 -0700 (PDT)
Received: from [10.57.76.6] (unknown [10.57.76.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 336653F66E;
	Wed, 11 Sep 2024 05:13:45 -0700 (PDT)
Message-ID: <948daae7-8d94-4d44-93e7-1764f6500be6@arm.com>
Date: Wed, 11 Sep 2024 13:13:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] perf: arm-ni: Fix an NULL vs IS_ERR() bug
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <04d6ccc3-6d31-4f0f-ab0f-7a88342cc09a@stanley.mountain>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <04d6ccc3-6d31-4f0f-ab0f-7a88342cc09a@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-11 8:39 am, Dan Carpenter wrote:
> The devm_ioremap() function never returns error pointers, it returns a
> NULL pointer if there is an error.

Ah, this code went through a few evolutions, and apparently I missed 
that devm_ioremap() and devm_ioremap_resource() helpfully have different 
behaviour, urgh. Thanks Dan!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 4d5a7680f2b4 ("perf: Add driver for Arm NI-700 interconnect PMU")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/perf/arm-ni.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
> index b72df3aea93e..90fcfe693439 100644
> --- a/drivers/perf/arm-ni.c
> +++ b/drivers/perf/arm-ni.c
> @@ -603,8 +603,8 @@ static int arm_ni_probe(struct platform_device *pdev)
>   	 */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	if (!base)
> +		return -ENOMEM;
>   
>   	arm_ni_probe_domain(base, &cfg);
>   	if (cfg.type != NI_GLOBAL)

