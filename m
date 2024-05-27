Return-Path: <linux-kernel+bounces-190111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A58CF99F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160CB1F214AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3716717BA7;
	Mon, 27 May 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhgABS/M"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC02836A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716793017; cv=none; b=ijStH198BrdHMYxmJgLYB/vqH54BhKXpQ5rKCIJG/KdejQ6ysFvw//3ziQhSiE99j/EZE6Cay6hqOpHVMlYFz1UBYbTQS0w0IrsiCFKQogHvaFml1xKfHvoaT+nbWu//Q1rWLzyjmNYo8NHHziONpzXoRQTJbHX4CNMc0xx93eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716793017; c=relaxed/simple;
	bh=Ip3HyV+TwixV9ZJHQtqhXEVzHgpB9zQHR+NAaT+7PG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbAPOZqh2dhiHydBAQGiF3hq2U8kh/TG4di/hNX4VczM7YZwLyeEDtlST5WCyu94EE7IxLsSN8+DLxSfyPIK26Qa78A5ZNNqrWs8XsyHNbDcM2utMERfoxCr9bW+HSCMUf5OmpxV6fdYVq6TK0hOXc48TwZNdxmyWXLT1dipxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WhgABS/M; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-529aa4e988aso1495469e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 23:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716793014; x=1717397814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ09OIEijtK7C2A3jYTqDcFl+COEux6T8i6drV3crdQ=;
        b=WhgABS/MNGu+bQUmPyhuxHNFsuW6Yn4TtL5wDgDiXuS19/7VBZqcIUveff49LS7iT0
         YH+8DNoByzTHahQe/QXhzkqBnTRoMWhpWXyouZ1iL1DsEflWjvXfo3pC5I2t8znt6VBn
         MRS1HZNFP5H2MN8biligUIN196ungPL1kQpGDH2roOJMt7qWpIrMwy0D4lSIZLDU4xFs
         tpKxzKUGWO4JCBji+rZtuJmfaKg/MkSmZIsq+JDyfPcdS0ffjNErGI0I5cXclSIHQOEb
         QndD9nTERRXrx67UBkkaJLHhqYXOtUl+oqJ/dE5qWUmsy/YzOpCmilMpmI9gCZmw21iy
         JKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716793014; x=1717397814;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZ09OIEijtK7C2A3jYTqDcFl+COEux6T8i6drV3crdQ=;
        b=l0T9hsrF2YmaEa24t+T38KQ9wtK0lZQNMBg5ZrzRNoDrBFcCapNZyOXv4JkVOoSdQa
         hPWDh6/9wGwhRlJ3xwNS8k58nQcCr20jeaEIdmLSW4qkNqqjncfFLOlQDFz+1JyyfbWZ
         VQK/AnHLsUtCAqMmx1kThsQrM49cVevYvwbB/yMRl7rl5Gg4HvdxzMb3JO8shUrFUNHD
         aAJ0eGRqJqF13P8EEIzbV1x/TWJKBYKFIAYdoEPMq6jkB+TP8GDnfVwecqsNAZMBA8+Z
         unai4mpLuhITH5Ar8Bv57rysdk2o1AVMu6e6Ghnpd8nPsmKBWvBj57e2QCk8r1scIcga
         GT8w==
X-Forwarded-Encrypted: i=1; AJvYcCWfmY6WZPNZaVJ4+gJ28B8v93RzI/DhL3/rtf6273rSbidwEnnoyDCSpAl8OIGTR9ecxuGURAlyijQwEQtcq2UslqZBsbmZn6F4S4yN
X-Gm-Message-State: AOJu0Yw8l1CWA9yGxF7iXmZvVJ4WUzYZcWT17yoiETjvVNVHY4wZLn36
	S8I8MggEFl3C9S0IGzEM4HDLvNJyjg3Kfhbmmnm4e+GTyfDfjMtGtNmGRux5LAY=
X-Google-Smtp-Source: AGHT+IEksji+C8SdKEcN0/ERudcieW1rIvO6gteM7TN0sGfhxja4qB8gUnNjhftbdS6zTM1idUY6OQ==
X-Received: by 2002:a05:6512:110f:b0:51c:6c59:627e with SMTP id 2adb3069b0e04-529661f2c34mr6606138e87.42.1716793014216;
        Sun, 26 May 2024 23:56:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c81773bsm458298366b.30.2024.05.26.23.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 23:56:53 -0700 (PDT)
Message-ID: <1b691b03-1d2c-48ee-9907-dc043ea1ed5d@linaro.org>
Date: Mon, 27 May 2024 08:56:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] ARM64: mt8195: Use thermal aggregation for big and
 little cpu
To: Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240524143150.610949-1-abailon@baylibre.com>
 <20240524143150.610949-7-abailon@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240524143150.610949-7-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/05/2024 16:31, Alexandre Bailon wrote:
> This uses the thermal aggregation for the mt8195 to get the maximal
> temperature of big and little cpu clusters.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 212 +++--------------------
>  1 file changed, 27 insertions(+), 185 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 5d8b68f86ce4..8aa2bf142622 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -3600,50 +3600,31 @@ dp_tx: dp-tx@1c600000 {
>  	};
>  
>  	thermal_zones: thermal-zones {
> -		cpu0-thermal {
> +		cpu-little {

How is it related to the commit?

Does not look tested. You just introduced warnings.

Best regards,
Krzysztof


