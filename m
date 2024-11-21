Return-Path: <linux-kernel+bounces-416834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB59D4AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F460B23056
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE023099D;
	Thu, 21 Nov 2024 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsuEJyP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05721CACD6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184885; cv=none; b=SkCY8ovypWgWod5FHSw06l9QkmlwDbRuycaKz8nQqzKEqWlDJs/FTejsse9pV90Qwx5YKmmgZrrKa1AEk9F8V1TSxq1uVByBwmBXnm7iEgmRN+vfnrKQhBf4x0IMFD7yaQo18D7RxeSoYSisvb5ChnJLF4210iIBRX6OQy4vhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184885; c=relaxed/simple;
	bh=sQyHjoPV6h9sOqmsyfmf7/IL7whikxmmoPsVmcB/N60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJ90+ChVq3i+XKz1PNQ9DjuhIR5hAww9CfIG1kGuWKassb8sCyesRzX+T/ErJuhF4zUl99U9Ye5dXbKwjFzTxUI/xnjBoPi4b+BW1hC//hEziXCAiuBO4eYo4Rq8FPVeuOsLr6kLNPCXKf/X1gbqgN66b09GFCFxdiUQgChZlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsuEJyP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF167C4CECC;
	Thu, 21 Nov 2024 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732184885;
	bh=sQyHjoPV6h9sOqmsyfmf7/IL7whikxmmoPsVmcB/N60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZsuEJyP9kAwvE66L7VrUbX+2DfxflCnkfKESz2/y8fu0M2wXPLGAucDyBHxxcVDzP
	 bro3MIzWsr2UvOzBIlKOeog/Wj08VSoJwwCJy9MFb3+XkdKuBu/LlGAon4DeTRJGEG
	 A2vGxjYmWyjHG7GCvmrBt5VMqkhrYsHVPLilkGeV5W511AtX8p3Fc+pKpXzD2mIa0z
	 rZ/STFsVhfbytfCHMO3MKlk+Wu1utazVRjRpC/eph8h8T5zApZVi/aHm9EXgSpY5Yq
	 9mGZb7kJaO2zjcD5yksGKlRzQjer1rMdoQRzBtIugVi8321CKQIH1WW8koVAk4tM7I
	 HSQxSEjJozhFQ==
Message-ID: <e3b8366d-b365-43a3-8f40-c2374ff9e8bf@kernel.org>
Date: Thu, 21 Nov 2024 11:28:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] memory: ti-aemif: Create
 aemif_check_cs_timings()
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
 <20241115132631.264609-5-bastien.curutchet@bootlin.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241115132631.264609-5-bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/11/2024 14:26, Bastien Curutchet wrote:
> aemif_calc_rate() check the validity of a new computed timing against a
> 'max' value given as input. This isn't convenient if we want to check
> the CS timing configuration somewhere else in the code.
> 
> Wrap the verification of all the chip select's timing configuration into a
> single function to ease its exportation in upcoming patches.
> Remove the 'max' input from aemif_calc_rate() as it's no longer used.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  drivers/memory/ti-aemif.c | 107 +++++++++++++++++---------------------
>  1 file changed, 49 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
> index aec6d6464efa..5c1c6f95185f 100644
> --- a/drivers/memory/ti-aemif.c
> +++ b/drivers/memory/ti-aemif.c
> @@ -132,18 +132,48 @@ struct aemif_device {
>  	struct aemif_cs_data cs_data[NUM_CS];
>  };
>  
> +/**
> + * aemif_check_cs_timings - Check the validity of a CS timing configuration.
> + * @timings: timings configuration
> + *
> + * @return: 0 if the timing configuration is valid, negative error number otherwise.
> + */
> +static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
> +{
> +	if (timings->ta > TA_MAX)
> +		return -EINVAL;
> +
> +	if (timings->rhold > RHOLD_MAX)
> +		return -EINVAL;
> +
> +	if (timings->rstrobe > RSTROBE_MAX)
> +		return -EINVAL;
> +
> +	if (timings->rsetup > RSETUP_MAX)
> +		return -EINVAL;
> +
> +	if (timings->whold > WHOLD_MAX)
> +		return -EINVAL;
> +
> +	if (timings->wstrobe > WSTROBE_MAX)
> +		return -EINVAL;
> +
> +	if (timings->wsetup > WSETUP_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /**
>   * aemif_calc_rate - calculate timing data.
>   * @pdev: platform device to calculate for
>   * @wanted: The cycle time needed in nanoseconds.
>   * @clk: The input clock rate in kHz.
> - * @max: The maximum divider value that can be programmed.
>   *
>   * On success, returns the calculated timing value minus 1 for easy
>   * programming into AEMIF timing registers, else negative errno.
>   */
> -static int aemif_calc_rate(struct platform_device *pdev, int wanted,
> -			   unsigned long clk, int max)
> +static int aemif_calc_rate(struct platform_device *pdev, int wanted, unsigned long clk)
>  {
>  	int result;
>  
> @@ -156,10 +186,6 @@ static int aemif_calc_rate(struct platform_device *pdev, int wanted,
>  	if (result < 0)
>  		result = 0;
>  
> -	/* ... But configuring tighter timings is not an option. */
> -	else if (result > max)
> -		result = -EINVAL;
> -
>  	return result;
>  }
>  
> @@ -249,7 +275,6 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
>  	struct aemif_device *aemif = platform_get_drvdata(pdev);
>  	unsigned long clk_rate = aemif->clk_rate;
>  	struct aemif_cs_data *data;
> -	int ret;
>  	u32 cs;
>  	u32 val;
>  
> @@ -275,68 +300,34 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
>  	aemif_get_hw_params(pdev, aemif->num_cs++);
>  
>  	/* override the values from device node */
> -	if (!of_property_read_u32(np, "ti,cs-min-turnaround-ns", &val)) {
> -		ret = aemif_calc_rate(pdev, val, clk_rate, TA_MAX);
> -		if (ret < 0)
> -			return ret;
> -
> -		data->timings.ta = ret;
> -	}
> +	if (!of_property_read_u32(np, "ti,cs-min-turnaround-ns", &val))
> +		data->timings.ta = aemif_calc_rate(pdev, val, clk_rate);
>  

You just changed these lines in patch #1. Basically this is partial
revert of #1.

Best regards,
Krzysztof

