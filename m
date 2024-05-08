Return-Path: <linux-kernel+bounces-173561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD28C0229
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C61C21CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6F04C91;
	Wed,  8 May 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbpWtO5K"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28E2652
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186350; cv=none; b=iXlT3NEZTQGDIKM8quSuXx+lqqd2ibYINnF9PcR6YmWIUzHx9Iire4qHWfwVe3x1nqjt0GjjDpeYrv+8WOXlRHKKySIpQUNy4tRbfzVeJN4my8+eCS21o5wIbPzLQJmf2YDyMNjGxBTGOMpcHavygt6gQFsA6M5Wk6ULtcZ2iHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186350; c=relaxed/simple;
	bh=eXSo6LODCjadFOS+EQ+S+4IbdWK65dyA5w3m9oMB4lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAUBTqup+G7C1X37ajLejdxQSQIRBxFEkNbIZFnG41wM0j4hk3cVw2GZ8//YK0fOi6vjtgsUiaCFg/WlBQ5aOj3l+6ilmLq263YYa7Tp3gJNMgya10NH5gqwalYP0oT0TbbWUkxv6cn2br7ETyMyrjpqLeLYrsdUqQ2+x0z5Z7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cbpWtO5K; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a599af16934so1162475866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715186346; x=1715791146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJhRl2DGBF5j+0kWEi1ldoyZEE3ffy3xPMEl3BQlZ74=;
        b=cbpWtO5KKdePbR3iyzQjMsTieilQhwZBts5QbZsrvyKd5lbrQQLl30wHoOhm2Tk+Na
         1kySECIGN8nBBKBLMtCnsTTxfzsl+IV8LABU1iCF29a8GR6gSxiqeBdHUzJwgwAFMrbE
         jR17tDVwF9NG0lmgRTGxKh7xvVOWx9Gksq+8jY+uSj+fZDLVabNpEo+4n1ILgUt+N6Dx
         nK5BtmTw9AIVXQJrALNFT/y5p9MZVa0qG0C9/AsSiL5wNwjph7lOhuJ6Jr9fB8awZam3
         UgPfB4oWkE3OwVx2GHT6JmHeWZwZPc14J2QlxBhiRbX+A7fFlZ7/i/eVUFGXMZxNVl1N
         06DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186346; x=1715791146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJhRl2DGBF5j+0kWEi1ldoyZEE3ffy3xPMEl3BQlZ74=;
        b=Awrrv2R+SAFevT7I8ou3ZpCsnyJMBRLOp0MHBWQXyoNmqwxbkkh6d7VJIYN/5idNrg
         uqQNnFm9Vn32vxu/xWB0PKHKSWsu4FAsLkw4Q01N6y+ZNOwRk3R1eh1IGSSpTEuWJdCw
         LuRWAzRSRrRQfb8e72R2FfM9T0rwcl+u4Ybxlyt4+8xJAy0Vs4ZM1JA/+qAzcjxLTlIy
         kcUDBTWnj9UjBTq4gIh4UkFuOZCHwSqAu4WpKmKqNNG/TeQIeZeLlm635LQ7JmAs8qSU
         cGi9wEo4HcPc2GhEzqE1G7dbcSO7vrvgQ/YKr5H3nXpg+CSATm2y3xHE5E1Iu4JLkUC8
         vM/A==
X-Forwarded-Encrypted: i=1; AJvYcCWu/tZlNyoYRSDMxMuneSo5K5crnZ1/MJ8GRi1eECRP1YgMbTtylFCMKkT6jUNKBw6/kkTULORctFLp56rLO8KtNku9DMIMqPUqm4Kf
X-Gm-Message-State: AOJu0Yxt3bbXkCCTN1S2H2cdkxxfY1UIcBZMntEnBdr4l2x6smSCh70P
	v1uf8aCafiTNT4o8yiNim6hR3GBsW1S9gA3TtNeZvxtb4kS1fu6ZShGhSVWZCmc=
X-Google-Smtp-Source: AGHT+IHCZyqVbpsx0DOVZ1A4z4AqaM4SNm2yM5sWSBx/6eRKLtXlUNVtYwQb5CKbqyEuaYhh+TU9Ig==
X-Received: by 2002:a17:907:78cf:b0:a59:ca33:6841 with SMTP id a640c23a62f3a-a59fb9588bamr195153966b.32.1715186346181;
        Wed, 08 May 2024 09:39:06 -0700 (PDT)
Received: from [172.20.10.10] ([46.97.168.217])
        by smtp.gmail.com with ESMTPSA id fw17-20020a170906c95100b00a59cfc54756sm3716424ejb.210.2024.05.08.09.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 09:39:05 -0700 (PDT)
Message-ID: <f7528434-6780-48f6-87a4-3d56d87f44fe@linaro.org>
Date: Wed, 8 May 2024 17:39:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: microchip-core-qspi: fix setting spi bus clock
 rate
To: Conor Dooley <conor@kernel.org>, linux-spi@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20240508-fox-unpiloted-b97e1535627b@spud>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240508-fox-unpiloted-b97e1535627b@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/24 16:46, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Before ORing the new clock rate with the control register value read
> from the hardware, the existing clock rate needs to be masked off as
> otherwise the existing value will interfere with the new one.
> 
> CC: stable@vger.kernel.org
> Fixes: 8596124c4c1b ("spi: microchip-core-qspi: Add support for microchip fpga qspi controllers")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> CC: Mark Brown <broonie@kernel.org>
> CC: linux-spi@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/spi/spi-microchip-core-qspi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
> index 03d125a71fd9..09f16471c537 100644
> --- a/drivers/spi/spi-microchip-core-qspi.c
> +++ b/drivers/spi/spi-microchip-core-qspi.c
> @@ -283,6 +283,7 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
>  	}
>  
>  	control = readl_relaxed(qspi->regs + REG_CONTROL);
> +	control &= ~CONTROL_CLKRATE_MASK;
>  	control |= baud_rate_val << CONTROL_CLKRATE_SHIFT;
>  	writel_relaxed(control, qspi->regs + REG_CONTROL);
>  	control = readl_relaxed(qspi->regs + REG_CONTROL);

