Return-Path: <linux-kernel+bounces-386644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165D9B4648
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FA91C2221E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935C5204F87;
	Tue, 29 Oct 2024 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDTL3mfq"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BD3204085
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195858; cv=none; b=MAb5sNnGdOfHdmJQ8unNduFy6OGcEuk+GJSTfpPa+kgCCh0Osv6aiqTCknfx/Mrm5ZkRCyy0kGaonOMzovMn1lRO0WGqOzGKvB2cakCn0JUsFoYx1VpXUz+oKu3bnB51y/45DXGeuqODCnTY8IjMPPo2YHh3yyL9TcS1Rug0Q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195858; c=relaxed/simple;
	bh=olqUwa6YUCEmqvZyc4jGc2TK5EVh4TJVBBF2wDX/b7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+b+dKSJXNDhRlyJ42Lvn0PiQ7u0Y5csiqwaoJWyWJZqtVEDrKVfJ5iyjK1u/rAgNNJnk04eyGIL/1GdOK272qIKTfH6CJ9cyUvfaKAUq0/aWh39PyMEOi6HV0AG7T52dmLYp0mfatHNPF24BGfJnUygae1lWo56kzRb8CC7hOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PDTL3mfq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d447de11dso3778281f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730195853; x=1730800653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DN7KbVPzR0Ss7/4UGrf+xZAi7oyW24SdUifFCTdR8uM=;
        b=PDTL3mfq3UiqoAvBC21oik8uWNyiom/xDZfxvV+2K/Jr489hy4JLEWxmhflS5LWMUC
         vXuIPiKeWlqC28V7igZ5wGT/bDoySvSS+AARx1mKYRHWyLt0H5WfmLwYxelLF9zIewrp
         GId/KSVUUjLQnUUasNQ+/m1gR5Ql7acuS4rUEzuDglLBu6LaXbZaLbNlEBW4axtDPYj5
         5lxfxuhmCUi3KW0cBEizYZKlqHiMRrJnxDUWMdisF0F5xsFjWrcATJGvrl0fxcNvZHKN
         pr/dTdmoYr0NZuOgpMK7WHhgxJqrPxak6sZg4tvB07FjuOUzscN3THGSTISjOqZvHFrL
         ACcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730195853; x=1730800653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DN7KbVPzR0Ss7/4UGrf+xZAi7oyW24SdUifFCTdR8uM=;
        b=w1AKvP2PbtONFESQjfemiWm3wr1QfqpAs88GE+CXTcLGMOcBAiomzK6JstRbQOinFx
         aYKTHD4R/kd9JFdjS8/R8Hedx2KGuELh6MzV6Bg68YAX9Jrkt/fD4Fqv+pKI+bhw937r
         Sqp/F4T4rhf8kyH6e2dIIGKZCToOb3Nps6VbdtOzQVJQa8Zb4tT8nkg/iL3jd6sWOd9o
         F5mZ/4SXv5a/mWmwEupoQfz0Ry87kcsJZvqcTaa0P6T9Bgx5IvBKKJiibCAJtpKNmacl
         OiRDXTC+d8RKy2rFXzFmX9NiFBgsnD70KQ/CVpXfHMRgjSxOoo8rYUP7ogNwlxza6ZoZ
         LMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSHXPYaPh0OjGoTLwxmrvapx/XLXLSGe5Mdk99Lhd2d8vxIO96vSkCYZQhpejfYsJ09wZyjvqF5ijamTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXYkZ5s1OlTxud6QVR8ICM5An8nGeo04TtFdyqwb4zf96CTkK
	AFbFXo28+McLM3K8M+phMtGBKzYe2moUWw5Q/nQ5h+hxD2MLPoHZMrs6FCAsfVU=
X-Google-Smtp-Source: AGHT+IHhmgSstrKyHX2Iwez/d7VdkcjXlscKVW8yRli6oSKJ8qbcBw12V0iO42/emHYeLXIDzokkEw==
X-Received: by 2002:a05:6000:bd0:b0:368:37ac:3f95 with SMTP id ffacd0b85a97d-380611850a0mr8235479f8f.31.1730195853404;
        Tue, 29 Oct 2024 02:57:33 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bde6sm12026123f8f.40.2024.10.29.02.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 02:57:33 -0700 (PDT)
Message-ID: <470c0b52-17d1-44e4-9a70-5b410ead9500@linaro.org>
Date: Tue, 29 Oct 2024 09:57:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: support vcc-supply regulator
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20241027-spi-v3-0-42e81723bbcc@nxp.com>
 <20241027-spi-v3-2-42e81723bbcc@nxp.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241027-spi-v3-2-42e81723bbcc@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/24 12:16 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SPI NOR flashes needs power supply to work properly. The power supply
> maybe software controllable per board design. So add the support
> for an vcc-supply regulator.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mtd/spi-nor/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index b6f374ded390a0c0429a61dd0579204e0e98bfa1..d95427c4f4d0839c5df348eeddea59582ef99d9d 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -17,6 +17,7 @@
>  #include <linux/mtd/spi-nor.h>
>  #include <linux/mutex.h>
>  #include <linux/of_platform.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -3465,6 +3466,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (!nor->bouncebuf)
>  		return -ENOMEM;
>  
> +	ret = devm_regulator_get_enable(dev, "vcc");
> +	if (ret)
> +		return ret;

This is all looking good, but please move it to spi_nor_probe().

All the SPI NOR controllers need to move to spi/. We stopped adding
support for the SPI NOR controllers few years ago.

> +
>  	ret = spi_nor_hw_reset(nor);
>  	if (ret)
>  		return ret;
> 

