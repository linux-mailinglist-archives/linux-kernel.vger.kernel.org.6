Return-Path: <linux-kernel+bounces-563249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C86A63B38
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C312E3A827F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE1E14F9D9;
	Mon, 17 Mar 2025 02:13:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40E3D6A;
	Mon, 17 Mar 2025 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742177623; cv=none; b=Vj750767x6ZXPL0E0pioGa7a56SRh7UuCSD4irY7BGShO8b0sJdICHdfdPNz9AKaKg0w/tuOnBuGHywLU0he6DLMNUNv8X4Fajcl7ZsRTSErVNVZHRRwRxbWrDTuTnGAdz31zp3DLeBdX7yVokNkPN0+vDGx5DtyylMNGLrA4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742177623; c=relaxed/simple;
	bh=YfNwa41wrkrqag74tI1PFC+5fccxZcnx0yDp1vQgfEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4itPKeedx7XoM+WBIqdq84sfbadK6QlVDRublB0H6r1j8cYAoS4EKvgv52QNERYIzCbf1+jYSiZLgShmsr2gmoI+xKkhuaW8QQKSF5pbzO0dunWdfvckqaZl6m1+jom8+QxAL8TWql7sdBhyQUMSx54Xvk75L2+rtCidY4qBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1741213D5;
	Sun, 16 Mar 2025 19:13:49 -0700 (PDT)
Received: from [10.162.16.153] (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 191513F673;
	Sun, 16 Mar 2025 19:13:36 -0700 (PDT)
Message-ID: <a636ce0d-a5cf-4718-9d39-1a6e74bdea5f@arm.com>
Date: Mon, 17 Mar 2025 07:43:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] Coresight: Fix a NULL vs IS_ERR() bug in probe
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Jie Gan <quic_jiegan@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <dab039b9-d58a-41be-92f0-ff209cfabfe2@stanley.mountain>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <dab039b9-d58a-41be-92f0-ff209cfabfe2@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/25 16:25, Dan Carpenter wrote:
> The devm_platform_get_and_ioremap_resource() function doesn't
> return NULL, it returns error pointers.  Update the checking to
> match.
> 
> Fixes: f78d206f3d73 ("Coresight: Add Coresight TMC Control Unit driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-ctcu-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
> index da35d8b4d579..c6bafc96db96 100644
> --- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
> +++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
> @@ -204,8 +204,8 @@ static int ctcu_probe(struct platform_device *pdev)
>  	dev->platform_data = pdata;
>  
>  	base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> -	if (!base)
> -		return -ENOMEM;
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
>  
>  	drvdata->apb_clk = coresight_get_enable_apb_pclk(dev);
>  	if (IS_ERR(drvdata->apb_clk))

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

