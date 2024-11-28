Return-Path: <linux-kernel+bounces-424772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92D9DB933
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487FDB20F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4361AB6F1;
	Thu, 28 Nov 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXjsJq5v"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF2145A0F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802781; cv=none; b=In5SeSK1zADDmAjul/XAX27BAjXKyS0NfdJfL0GrsEZSUmWIYDrwM4muehF9gJwyWdK60r80/C09w7E2Bx4oUiL2fOuvcRo3xlgr/Ykeg3Dxoe3dj9whSA+ei6E5r6y2wBVlMDelI3kwjrJtLmcI/JXAwbO7/Tqwdgb9HChPZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802781; c=relaxed/simple;
	bh=8u4WHlHlXdoHUtL7x7iWsPFH1aFzthA492+VfAh+1hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVaxo7DrbKDbZds0MKkbVUZxLSLaBvOT202fIxteWy46hBt6fxb4LbLBYWSgGCetnTUbUrmSegO0hS5PenBIAJ4Rv89hLu8WKJh3LOk2MamERPqNrdJxyCRsr/4+bSgm+ccF6sITwIO0wlYC1kXaaprWtWfNjWQVIp2YWM3XqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dXjsJq5v; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de035ea13so869791e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732802778; x=1733407578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/o2zy7i5114Efr8+iIYf65CIfVuVv3coOHufvDEg/14=;
        b=dXjsJq5vgM8Pbww0oKbCMkIU4GUJU/t0b9FIJBS2UI/cGudHz0+iQUj6Xw4y8uqR+a
         fkKO+6cg5HMBYn0UuxKWMlHPo8JxWICeRQWJcKk0D8J2lEisCIebAANWXZB+p/xj++4v
         BfY1hensvnvI1xLpdFK0uuabJ7x8CWrbcTJ42ryd/UULc+Vi2K2tsaBBR7AoDa3swD61
         +dL6Ks90eVWpOQYDWWojNexNORILRTR6HKUkzPJJLxF+d4SE2lIMQUJ8VfMeGrmKA2sJ
         0E6MTyDOBog8hhrb+E6gnc5orWdE/g4ADU9NAsM4K92i+v4Xs1ssvLHoaidCtvNICvro
         ttEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732802778; x=1733407578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o2zy7i5114Efr8+iIYf65CIfVuVv3coOHufvDEg/14=;
        b=wbMrXAd91nnM+QKXK0ZCCSKXmJMsLX0gQHAg9drkzRKDjOE1KUK31F4Ege82YClU08
         KAftaojhEo3szs/7rDkWIlUw0xq1z4XiT2zPzjukl0io2OtFciNxl8wq4+9RYViIKc60
         TwjLT4UJWw+zsVZHS8oH3ICE/P7Y+KMuzbEOcFzHQYeBzvQBYitK50Dbxkqc+e8VuvTB
         BoSMLnIeh25IWFQqxpajrQz51D+opL0rO0XhAsC8lo5zANxA87upeVciTdweaa6CMBWe
         nn362s8hphvXGgJqIYYYt2xkD8NQPBYwP/zYzRowTBWor1qOZIVaddLRYpIUXxuHjz6L
         pHLg==
X-Forwarded-Encrypted: i=1; AJvYcCVKTio+Ygcj984hN/prmxpxNd96nUxB08ZEs3M00+VzUlIl3arMl5Lk2IaqSZwJEjjcr432sER/wirPSIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBQBb6McZAbRGsxq435EWZ0DWJu35iaVNKapATTPsTqC/koAX
	CfcVGDIclrmgKIluElxrnaAuqfko6RhtPZpUd0drGlmvUDoDQa5BNPcgQNYZiHcDeaPD2wT3dme
	G
X-Gm-Gg: ASbGncvwEK6LhgvtOgokSPwWAMqGYN2DCuYn9vMy6td1YMRoDU5lb6WJQ6bl+FTysio
	nw2xOBn8Z4zOToa9yX9NwRO/CF9chrEU2wpK4Sf4IPhNVkcsQJjnA4jfEaWPMZSd0/HFqm2QEeA
	XWrcCTD+S3XsZFTg176pMhOZIQyuQJ4ethTiMPnLrNre0yNcs7kvGHNEor90Nakd6if1TnUbIzv
	RglSIgO4ATxuvkwWUfAsZ6Zp6pLi7KMWWbLRSEo/03FGelVyTrRgDvwesgxdLj7VpVvL3lfjZhO
	HA0MTpT6NC+esW+3uWSNV17GmU7UNg==
X-Google-Smtp-Source: AGHT+IFsOdfp2e1GEmTXUNNuiA5M1HdtsT/qwpeAjD8lPPqRXA9Imbs3wJner1XQ5fKID4zal6nk5A==
X-Received: by 2002:a05:6512:3c89:b0:53d:a2cb:349e with SMTP id 2adb3069b0e04-53df00c5ebamr4575727e87.4.1732802777846;
        Thu, 28 Nov 2024 06:06:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f1a7sm183496e87.165.2024.11.28.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:06:17 -0800 (PST)
Date: Thu, 28 Nov 2024 16:06:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v2 2/2] spi: spi-geni-qcom: Add immediate DMA support
Message-ID: <dou77hbrpdqsdlzx3ymco6fgbbmimimt6rrzzezghzmc3a2hle@fgdnpbmg6xsb>
References: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
 <20241128133351.24593-3-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128133351.24593-3-quic_jseerapu@quicinc.com>

On Thu, Nov 28, 2024 at 07:03:51PM +0530, Jyothi Kumar Seerapu wrote:
> The DMA TRE(Transfer ring element) buffer contains the DMA
> buffer address. Accessing data from this address can cause
> significant delays in SPI transfers, which can be mitigated to
> some extent by utilizing immediate DMA support.
> 
> QCOM GPI DMA hardware supports an immediate DMA feature for data
> up to 8 bytes, storing the data directly in the DMA TRE buffer
> instead of the DMA buffer address. This enhancement enables faster
> SPI data transfers.
> 
> This optimization reduces the average transfer time from 25 us to
> 16 us for a single SPI transfer of 8 bytes length, with a clock
> frequency of 50 MHz.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> 
> v1 -> v2:
>    - Moved the spi changes as patch2.
> 
>  drivers/spi/spi-geni-qcom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 768d7482102a..53c8f6b7f3c5 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -472,11 +472,18 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
>  		mas->cur_speed_hz = xfer->speed_hz;
>  	}
>  
> +	/*
> +	 * Set QCOM_GPI_IMMEDIATE_DMA flag if transfer length up to 8 bytes.
> +	 */
>  	if (xfer->tx_buf && xfer->rx_buf) {
>  		peripheral.cmd = SPI_DUPLEX;
> +		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
> +			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;
>  	} else if (xfer->tx_buf) {
>  		peripheral.cmd = SPI_TX;
>  		peripheral.rx_len = 0;
> +		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
> +			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;

NAK. Please finish discussions in the previous iteration before posting
new revision. Sending your responses together with sending next
iteration is a bad practice and is frowned upon (unless one agrees to
all the comments).

There was an open question here and your answer doesn't sound convincing
enough. Please continue discussion in v1.

>  	} else if (xfer->rx_buf) {
>  		peripheral.cmd = SPI_RX;
>  		if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

