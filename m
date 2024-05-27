Return-Path: <linux-kernel+bounces-191017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F43A8D05B7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F583B371AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BC016B74D;
	Mon, 27 May 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z8z/9WSs"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0116B731
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821608; cv=none; b=ADnV27d3w2u+37sWE+cqdgtWN50XvcDE0z+CdH0c31ImXlPLJa7EBKDONhNSSUQyePbSlSQtRxwmweKvJf1YdFa24iVG2Wnx3J88YgUaqs38tce/Tjr/zjsBgH85VGuXJIyIDoi3jg9PUPl1osyh6L6vZjWbGW3UxGpV/TCkaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821608; c=relaxed/simple;
	bh=YC0GySOBJKaQBQBOvF1uhc+50t8E3hxcqr5ZtTfM9T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbKN6WfC1k5F4Oi3SI1r9b7WEMi6CjQuhyNOzQNvikTCrYGryLBfiQ1R7gKfKa1M1kw7pmurymiKDcGE0032GiM1m4TKjtSMSnaodApNPYhwkXufL12TJ3SBYt1PNCBQamMJy9aDQJabJj0btsg05ICFrdwX2mLUawlrfYJpL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z8z/9WSs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6265d3ccf7so400993866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716821604; x=1717426404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hna0WN7JjlKVki9CKW7L0dNcuFoKFDF6IdzoULKxqX4=;
        b=Z8z/9WSsLlX1UV9qLQoCZkSKTo6lGvXxsDUg9Yuw3KLoFbSi0o7aWSL9AvoQS3Ivh7
         2nLAvIowtIWa0D9XeV5sNtuo2LGZcvRfu0BTGuF1cUe7QGMlYW04ThbBRrKdSTriXYiI
         kRC9DsKPbB6y/TCizYNICggLOymSAoJGJv3FzOxbetT2+iIQjNXyQa+7QcLz/JK1A9Hv
         wBzbI90oWwOct2vagDwXqYIn8KYAe3oh9i9tiP0mXk/UZOgsOl55cIMOZ0E2q874nmuj
         a2a7xubUqUUd8VK1dFJKDZYAV/Q6DL4UsNg4G8Bmi0gu2p8eYJaYtI2fKprdO88U/DEu
         eLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716821604; x=1717426404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hna0WN7JjlKVki9CKW7L0dNcuFoKFDF6IdzoULKxqX4=;
        b=SCkvSMVLS+t+tBT4DN2Xay4HVXQ4bMriX597+pn+KPC0aOMm9IkRAhHOGEsIPybFgy
         X8AHqvhi+IPMrzhXZPpGc5tqejkw6PdP3jdOteYa3psFakY/5wk89tqbu8aLxLFNc+xv
         q4/ZSXzmllpI7KfoPtKrKMlchAtH2QYpxXk9w+7bJ1KnpJitqfptZPj8zxwtCiV6Vc4R
         Zpk9+aOnyFMTsNcfq3arU+bXclTd66lh4j1aWd2auOrcSf7iZlV7cUP5c/xURwB79XGZ
         bePX8oyWnj/LvOx7XtFqq9HObxHfJSiE0JimxNKzYlPrGTjLn51/KqV4Zdcy+aeO9AQ2
         TJEA==
X-Forwarded-Encrypted: i=1; AJvYcCWNUX87clAX8eHf3VJSCUVLnGuz3zBs/al8K/d/AXzmg2n/e8bKsKFnEwwuMOw0xnn0E2phkTlcQPCE5m/azojng97axerfD5NcWf4c
X-Gm-Message-State: AOJu0Yx751c1FgnIzCmb+SathldeVxL2YyF8V4dvZZ7gHCd7WIWACSaD
	CPfYCZDBb/BaH3OsE64FzBarz+NC2VoWil1DyYizoB/xRxRkJsBP/T7TM/mB2t0=
X-Google-Smtp-Source: AGHT+IF0cBRnqOxCG5tbMSyKBE410khljOPfZUZyo5RRnH39akZSBsPRH0RsV2L6AMGFjz3XyzjUsQ==
X-Received: by 2002:a17:906:a0a:b0:a5a:4683:e961 with SMTP id a640c23a62f3a-a6264f0eeaemr626181766b.52.1716821603593;
        Mon, 27 May 2024 07:53:23 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c97a029sm502902966b.93.2024.05.27.07.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 07:53:22 -0700 (PDT)
Message-ID: <f553b3f2-d895-446a-a741-7a151ebeb3ed@baylibre.com>
Date: Mon, 27 May 2024 16:53:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: mediatek: mt8188: Add support for Mali
 GPU on Panfrost
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, mandyjh.liu@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
 <20240527093908.97574-6-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240527093908.97574-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 11:39, AngeloGioacchino Del Regno wrote:
> Add the necessary OPP table for the GPU and also add a GPU node
> to enable support for the Valhall-JM G57 MC3 found on this SoC,
> using the Panfrost driver.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

[...]

>   
> +		gpu: gpu@13000000 {
> +			compatible = "mediatek,mt8188-mali", "arm,mali-valhall-jm";
> +			reg = <0 0x13000000 0 0x4000>;
> +
> +			clocks = <&mfgcfg CLK_MFGCFG_BG3D>;
> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH 0>,
> +				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH 0>,
> +				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>;
> +			interrupt-names = "job", "mmu", "gpu";
> +			operating-points-v2 = <&gpu_opp_table>;
> +			power-domains = <&spm MT8188_POWER_DOMAIN_MFG2>,
> +					<&spm MT8188_POWER_DOMAIN_MFG3>,
> +					<&spm MT8188_POWER_DOMAIN_MFG4>;
> +			power-domain-names = "core0", "core1", "core2";

Hi Angelo,

I think you should add something like that here:
#cooling-cells = <2>;
(the warning is raised when I run 'make dtbs_check')

Julien


