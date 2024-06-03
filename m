Return-Path: <linux-kernel+bounces-199798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F18FA60F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8DCB24AC1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2213CF98;
	Mon,  3 Jun 2024 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNs1uKu5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B7F9E9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717455206; cv=none; b=Rn4pd319V5C49pA/36SH2C26anLeW8TM36/0kV10tfL9UPOWbBwRujSYqP4NRsTCXGyIWMt1i3WIhfesO+Z81VWpn2VPaLfe+zYgKYZEVYg1HWhkE1XAr97WDjX5p+wD2ZClWM/KIKyz6Kbk4oqVskxmF4ny8/NwJQChsLiZQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717455206; c=relaxed/simple;
	bh=oBsznC+UevVh615u4wf6L5X3iY4TMbGxHYqIHduASSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsaqeHzYmIuM0HgwkLqLnUWZ5LYlL9NGtfL1RqWstBoePEXWZdtGFs31O49AUw9U5JLtcfWQ9ws0Vlp9PbBaql3nfsbCnd4hiUEDh1ons6MeeaqTTtIQ1pWyKHZfqBqwKHBBUZjMzI3ilrreMaWVb9/TgDSaUzn7M/cOEjRkOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UNs1uKu5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42137366995so28282165e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717455203; x=1718060003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHxPmcn8NBPRCew+UgSGoajPk8qIaDUfay5Y7XccfBs=;
        b=UNs1uKu55g77J1OncpXg5qq0J2hJrD4ecSRXgbrwLWBgxLZ3zeisMVM4Laod9cjsRI
         LzDPpRwhp1qH0ntPjaKqeppAYaKoJ67b4v/A6wzvGYcPbwx0b1WH76X+pQxc0fbYOCqD
         pdwHpjl352oXA7+YPDOixKQzwJOD1c80u+yoWH9zgo1FJhjRYRNhjdvFyAsAx4ltcoVY
         LNR7LZnL8MyT47hGr7LJh/AN/DBka+C7kyLsBP8+dqVCboJUsquLQTSYrmZZckVqc77E
         OdTWOWpyRN2onDVE8L9GtD8I+9oiWxjbkPaLToR3O+hVN5pCRbjdXACxHj0M/XT7uDZF
         A1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717455203; x=1718060003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHxPmcn8NBPRCew+UgSGoajPk8qIaDUfay5Y7XccfBs=;
        b=UARj+0shnOw6ZFvdjQOSIMo36bzcksP8nkJomE/DTBb0NPyovGuubpBHppHSrSM2na
         0AsCZbsFb6h43E4TaupIk9z6bkWSwuohc5GDNI/RsrJmUXzLB9/s5NyssqBYFWw+xT6Y
         O3WCXSqebUCAv8kVEV/ssE8DAb5Rl0OHJ/bLSu0NpX9K7Ku1QcVv5jdoRwlhd3lPOdJu
         J/Q9DQhJRVsifLHzjudaRDV06r3xFNVUIbIKdYgDIq5OBvqHQw2GJ8FyureZRMwiI9aL
         ddjajSFNZmo8Xnd9pdPcLTQPxXHEdx6dqPYLaR7jtoYtQWR8XecBO+IGGPdCUebKEhWB
         lShw==
X-Forwarded-Encrypted: i=1; AJvYcCVBQChPf3nArrG3v6r8vjJki0vnhOCoHa3NFf7414Vz/kXwLvdVF9zW2/poDxYujE7kwpWdtkApVRs+K5LEZWbKE3bcG41bHjwWhKMG
X-Gm-Message-State: AOJu0Yym5cZ4Aixnkp6X8rQ0L1478KhIa/KqSVA4Fu3zD0SHAC4XSQOy
	d2Jrb5G2xCq9uVxE7+TfHHcFYcTp6SXwPuI4fIAJ01kUBfWyZAV/UAKbtOahawA=
X-Google-Smtp-Source: AGHT+IEURfJLad+7UzsuYE9O4FrsNz6zu5sZ7BCnFy+vex0kNyGPgn3BnDdjLi2iBPQGPBiHjPu9Vg==
X-Received: by 2002:a05:600c:4f82:b0:421:222e:96db with SMTP id 5b1f17b1804b1-4212e0bfefcmr112147885e9.33.1717455202781;
        Mon, 03 Jun 2024 15:53:22 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133e66ce0sm111773405e9.23.2024.06.03.15.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:53:22 -0700 (PDT)
Message-ID: <036ed2c7-02da-4461-940f-591fa68c36fe@linaro.org>
Date: Mon, 3 Jun 2024 23:53:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] spi: Introduce internal spi_xfer_is_dma_mapped()
 helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Yang Yingliang <yangyingliang@huawei.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Thangaraj Samynathan <thangaraj.s@microchip.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Cc: Serge Semin <fancer.lancer@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
 <20240531194723.1761567-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240531194723.1761567-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/05/2024 20:42, Andy Shevchenko wrote:
> There are few drivers that use the same pattern to check if the transfer
> is DMA mapped or not. Provide a helper.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/spi/internals.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/internals.h b/drivers/spi/internals.h
> index 4a28a8395552..47a87c2a6979 100644
> --- a/drivers/spi/internals.h
> +++ b/drivers/spi/internals.h
> @@ -40,4 +40,12 @@ static inline void spi_unmap_buf(struct spi_controller *ctlr,
>   }
>   #endif /* CONFIG_HAS_DMA */
>   
> +static inline bool spi_xfer_is_dma_mapped(struct spi_controller *ctlr,
> +					  struct spi_device *spi,
> +					  struct spi_transfer *xfer)
> +{
> +	return ctlr->can_dma && ctlr->can_dma(ctlr, spi, xfer) &&
> +	       ctlr->cur_msg_mapped;
> +}
> +
>   #endif /* __LINUX_SPI_INTERNALS_H */

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

