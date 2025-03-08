Return-Path: <linux-kernel+bounces-552551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB7AA57B2E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1043B2B6C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CFE1DC9A3;
	Sat,  8 Mar 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmVlQQs2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C101FC8;
	Sat,  8 Mar 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445173; cv=none; b=pJ3HTH5QmnV69tPNCrPI3Pxgd/HzY42FqKaBayDz5QQBWTAkiMQhBJEGqRpRRRI/C46d7VR7hlDFOMGK1hx0cequd4O0YaaVKrjRHg+GfV64o6RbT6/LjlpNiKWeJiEULJhPO06Eo+YOS/qLZEcuLQyyumn64gkt+sBet0hIqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445173; c=relaxed/simple;
	bh=vKeLXNSMscKa6TRRuO6w0YtidDuTX+xhbFjxpIOkdQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sp6GTtha39ZAeq0WyILFIwtiilQrfHlwvi4TEOmvtLth+zmgXZlOqdJE16lNyO8mU9r5jGJSEIYco5SR7nacpcKbYfdmnniX56bLseUldkx5Wrihc/D+5pTRMkW9LUCjoj6uoqSrNVUTXhw32+k50G9IqrF+kweQ/c8c53sgsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmVlQQs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FF8C4CEE0;
	Sat,  8 Mar 2025 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741445173;
	bh=vKeLXNSMscKa6TRRuO6w0YtidDuTX+xhbFjxpIOkdQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QmVlQQs2TEbCuOKGLbNZR6PKhhsJxLRjdHB6T9PLa538BuoV9dXo3Mw27efc3vrWt
	 gaYrsVTDGsJCsjTtAoKP+xCFG3ylOoVI4wwEH+rFczO9Tx5k+bizn3PUjdY2njTLn/
	 6Y6MN8/IkvQJ26R5bFUs6G50wS1E0vaYaxD+nFS/eOKtUHC/bfG84yUihB51BNileg
	 s7oLk3x/fkhCYYGtqFZ0e4Y29oCG7QMvlLwJfitHcjnS46ch1/pXMLClQYTC4kNbmw
	 Gnvvy8KNFeqzFtmWAlbe3qCT2MjsNVyRHuK0knlclqNEmGXkh34EpyIRRDb1kWQyfF
	 sSAhBNyl6JeQA==
Date: Sat, 8 Mar 2025 14:46:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Saalim Quadri <danascape@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: iio: ad9832: Use
 devm_regulator_get_enable()
Message-ID: <20250308144607.7f95b984@jic23-huawei>
In-Reply-To: <20250306000040.1550656-1-danascape@gmail.com>
References: <20250306000040.1550656-1-danascape@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Mar 2025 05:30:40 +0530
Saalim Quadri <danascape@gmail.com> wrote:

> The regulators are only enabled at probe(),
> hence replace the boilerplate code by making use of
> devm_regulator_get_enable() helper.
I rewrapped the description to 75 chars and applied.

Thanks,

Jonathan

> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
> V1 -> V2: Fixed indentations and commit description
> 
>  drivers/staging/iio/frequency/ad9832.c | 37 +++-----------------------
>  1 file changed, 4 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 140ee4f9c137..db42810c7664 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -74,8 +74,6 @@
>  /**
>   * struct ad9832_state - driver instance specific data
>   * @spi:		spi_device
> - * @avdd:		supply regulator for the analog section
> - * @dvdd:		supply regulator for the digital section
>   * @mclk:		external master clock
>   * @ctrl_fp:		cached frequency/phase control word
>   * @ctrl_ss:		cached sync/selsrc control word
> @@ -94,8 +92,6 @@
>  
>  struct ad9832_state {
>  	struct spi_device		*spi;
> -	struct regulator		*avdd;
> -	struct regulator		*dvdd;
>  	struct clk			*mclk;
>  	unsigned short			ctrl_fp;
>  	unsigned short			ctrl_ss;
> @@ -297,11 +293,6 @@ static const struct iio_info ad9832_info = {
>  	.attrs = &ad9832_attribute_group,
>  };
>  
> -static void ad9832_reg_disable(void *reg)
> -{
> -	regulator_disable(reg);
> -}
> -
>  static int ad9832_probe(struct spi_device *spi)
>  {
>  	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
> @@ -320,33 +311,13 @@ static int ad9832_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->avdd = devm_regulator_get(&spi->dev, "avdd");
> -	if (IS_ERR(st->avdd))
> -		return PTR_ERR(st->avdd);
> -
> -	ret = regulator_enable(st->avdd);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->avdd);
> +	ret = devm_regulator_get_enable(&spi->dev, "avdd");
>  	if (ret)
> -		return ret;
> -
> -	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
> -	if (IS_ERR(st->dvdd))
> -		return PTR_ERR(st->dvdd);
> +		return dev_err_probe(&spi->dev, ret, "failed to enable specified AVDD voltage\n");
>  
> -	ret = regulator_enable(st->dvdd);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->dvdd);
> +	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
>  
>  	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
>  	if (IS_ERR(st->mclk))


