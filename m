Return-Path: <linux-kernel+bounces-219055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D5290C95A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7461F20F33
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C396C15EFDB;
	Tue, 18 Jun 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdKxIzOJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5315EFD4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706308; cv=none; b=Lv+ukQQT8Ke6EDKifgUThwR+PBvC5VayJIrETJWscTo/XR6IyhZAOCjjeW8QtGD4lBJT880Y2GxCsdTQBGgY2VJXOGsv4On7N13g8iGUh5lIIz0VYTWoRLfFUBhxn5FvkJKBvk8rYijsC1avPcB9R3ZdnHMro7p69SUs0XIcBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706308; c=relaxed/simple;
	bh=LqK8v8L6085Sefypgf1V3diltFl9sECNHVEvbocsyUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLr7DzPlcH1nfknnhaTdajL//Bs7zb6H4+f6Tri7wNuyajx7hT+LVOgnGDy/41b8kFu6UshqfNAvhrnbX5HctxuNNswxRZfyG3oQH4df0ojH4E8NM/JXRXYfWHDPwvg++bb142KDRIhWYohj5Gl2TxHXaWNlLJ/G+1wLa7eGs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdKxIzOJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec3c0dada3so935351fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718706304; x=1719311104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6eO5TUpK8rT/f3c3WcP+sjjePLm+0H56buqyYkDvJss=;
        b=RdKxIzOJWgCSbeH/GM4xnJemyiZdv9ubIqKBMU41TMZoRKwu/ra1xtIqhCfa+jtZOx
         fTWx4eu5gjUNghGQRnWDmty3AWprLnZSACrPzp3kuoDO7V9khZv5o/DUuvs3cAqwJ+mm
         vhMpPp8MqMNUjTczLdr3VOzlOM7xWMM7lgoHWIcSCIGRdX0CnTrOukOiyjDNelLH66Vw
         UgcXHvc6m8gIARRu6lzEbObMDIvCP8+xMbE+QIEaEk3bO7YHVjahB5dbGIeDTaRU4DDN
         cGYLzPQsEpQmOVWxXNONlEZo+irXVATgLKrS29obzsuPJhMgwOje5LF6WFZ30tr6rEOg
         u4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718706304; x=1719311104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eO5TUpK8rT/f3c3WcP+sjjePLm+0H56buqyYkDvJss=;
        b=g7wqadfdZKDPby06pfBg69vONaeSTXsgALCzVbgITMRal9+olpGZhqZdrlCmIjTz5U
         jigiLQLEXILdlH/YHsudmfAQv//3kqm4bvQvqDMz3ghjS+wnJPk8IE3xmdZJlQbNTz1u
         Ye8VJFBKIA7/SuBnN+s7EQCFuanTVaP09bI1ywzT+N3ovWKF3TMuPMoTmXdzC8hg5ZS9
         wpMjmTYViHLRCfZpgz6tnengLMv3R7KG8VqE3DWaeg/dPJnp4rhuYeStGb/pLkS/LluQ
         7XjM9ZuGfkNLlWQTkneqU/aqNqMWvqntTNkZEYnRiASrvfNhxZBruwm/FcyG4/j2fUqj
         1XCA==
X-Forwarded-Encrypted: i=1; AJvYcCUBrROcEvmfhwL8nYDqS2+9G0NCIezRj/ZPGp79RtpShyspga+VNqrChLIQFP2NXL3FJbj/0r7IfEd2Za0QVMGSAzu9f04JPdlmrUWX
X-Gm-Message-State: AOJu0YxNMR47EG6rT6p0kja+DllusKjHIyM5qDtwUvc7apd6iHprYsrN
	BB2qDkSpP3Jyjc/ZYiQy/XAkHUlv4iV3H/J++H8O4+LZ6Z93IwdAL5srBIgkfHI=
X-Google-Smtp-Source: AGHT+IEiuZRNVMN76y6yOjWtf+3j+4HWW8RylKCvG8GARgK6ahHJIkTtS4MoJIzqIS0COIpvqo83xQ==
X-Received: by 2002:a2e:9807:0:b0:2eb:d7f0:5edd with SMTP id 38308e7fff4ca-2ec0e5d15femr93327051fa.27.1718706304083;
        Tue, 18 Jun 2024 03:25:04 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a64bsm185126885e9.46.2024.06.18.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:25:03 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:25:01 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v2] dt-bindings: drop stale Anson Huang from maintainers
Message-ID: <ZnFgfbFmHhP7wLPM@linaro.org>
References: <20240617065828.9531-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617065828.9531-1-krzysztof.kozlowski@linaro.org>

On 24-06-17 08:58:28, Krzysztof Kozlowski wrote:
> Emails to Anson Huang bounce:
> 
>   Diagnostic-Code: smtp; 550 5.4.1 Recipient address rejected: Access denied.
> 
> Add IMX platform maintainers for bindings which would become orphaned.
> 
> Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for I2C
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 
Acked-by: Abel Vesa <abel.vesa@linaro.org>

