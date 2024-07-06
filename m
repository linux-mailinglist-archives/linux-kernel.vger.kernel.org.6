Return-Path: <linux-kernel+bounces-243068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC0F929114
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C211F232A6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01318C3B;
	Sat,  6 Jul 2024 05:08:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4790405CC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720242517; cv=none; b=fgAWDv6MpAbBsaBCBi5z/hdsgEqTJQ2QHPVeleJvmqeZVlXMnHnhrgLtXFxIejCRt/knixO3epgT2AhjqHQNa473LD8uETjMK/d9g21/pWwSZIVjnzx5fNwEbxWG0YGLBw44pdbZG4acgWmiJ9hGIwQKI/yZUlleTM6Z7UTklro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720242517; c=relaxed/simple;
	bh=8jdMxxXbT6y02VK36z1BPd7lJxLpS2ah7tvvgVKBBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6yX8yIH71wj2MKbp17J9x/S0sP2xab2X+PeoPDDWEMc5o529+MHxFY5ynm2XfHacwH+IiWoDrJ+AwS6rY/gcP/kixutrpd0YEi79TRFJx5Eh1TvR9HSTRPMWMOT2s2teKQmTe/SqpyXA0zxWid5Ii7QuWLh561j66Mb8Jdk7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPxek-0001bt-VF; Sat, 06 Jul 2024 07:08:18 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPxeh-007V4g-TI; Sat, 06 Jul 2024 07:08:15 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPxeh-000hrD-2b;
	Sat, 06 Jul 2024 07:08:15 +0200
Date: Sat, 6 Jul 2024 07:08:15 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Dan Robertson <dan@dlrobertson.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, kernel@pengutronix.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] iio: adc: ti-tsc2046: simplify with cleanup.h
Message-ID: <ZojRPxa0SWUvqGgC@pengutronix.de>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
 <20240705-cleanup-h-iio-v1-5-77114c7e84c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240705-cleanup-h-iio-v1-5-77114c7e84c5@linaro.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2024 at 12:40:48PM +0200, Krzysztof Kozlowski wrote:
> Allocate the memory with scoped/cleanup.h to reduce error handling and
> make the code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!


> ---
>  drivers/iio/adc/ti-tsc2046.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index edcef8f11522..24b1d4390872 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> @@ -273,7 +274,6 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
>  				u32 *effective_speed_hz)
>  {
>  	struct tsc2046_adc_ch_cfg *ch = &priv->ch_cfg[ch_idx];
> -	struct tsc2046_adc_atom *rx_buf, *tx_buf;
>  	unsigned int val, val_normalized = 0;
>  	int ret, i, count_skip = 0, max_count;
>  	struct spi_transfer xfer;
> @@ -287,18 +287,20 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
>  		max_count = 1;
>  	}
>  
> -	if (sizeof(*tx_buf) * max_count > PAGE_SIZE)
> +	if (sizeof(struct tsc2046_adc_atom) * max_count > PAGE_SIZE)
>  		return -ENOSPC;
>  
> -	tx_buf = kcalloc(max_count, sizeof(*tx_buf), GFP_KERNEL);
> +	struct tsc2046_adc_atom *tx_buf __free(kfree) = kcalloc(max_count,
> +								sizeof(*tx_buf),
> +								GFP_KERNEL);
>  	if (!tx_buf)
>  		return -ENOMEM;
>  
> -	rx_buf = kcalloc(max_count, sizeof(*rx_buf), GFP_KERNEL);
> -	if (!rx_buf) {
> -		ret = -ENOMEM;
> -		goto free_tx;
> -	}
> +	struct tsc2046_adc_atom *rx_buf __free(kfree) = kcalloc(max_count,
> +								sizeof(*rx_buf),
> +								GFP_KERNEL);
> +	if (!rx_buf)
> +		return -ENOMEM;
>  
>  	/*
>  	 * Do not enable automatic power down on working samples. Otherwise the
> @@ -326,7 +328,7 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
>  	if (ret) {
>  		dev_err_ratelimited(&priv->spi->dev, "SPI transfer failed %pe\n",
>  				    ERR_PTR(ret));
> -		goto free_bufs;
> +		return ret;
>  	}
>  
>  	if (effective_speed_hz)
> @@ -337,14 +339,7 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
>  		val_normalized += val;
>  	}
>  
> -	ret = DIV_ROUND_UP(val_normalized, max_count - count_skip);
> -
> -free_bufs:
> -	kfree(rx_buf);
> -free_tx:
> -	kfree(tx_buf);
> -
> -	return ret;
> +	return DIV_ROUND_UP(val_normalized, max_count - count_skip);
>  }
>  
>  static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,
> 
> -- 
> 2.43.0
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

