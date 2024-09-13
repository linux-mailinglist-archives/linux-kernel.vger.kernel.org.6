Return-Path: <linux-kernel+bounces-328067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5919E977E85
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845E51C21F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493B1D86F1;
	Fri, 13 Sep 2024 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtqSG+lI"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C81D86C3;
	Fri, 13 Sep 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227295; cv=none; b=QrUgntBdOQHxg2Lj9jDezGJOHu2ai4UEMrULcY+8SGrJ2dptpW5vqNvqhyKEXxqvD7+Da542M6nRu5ddnoWI2RUJo4yNLPDHYG+yZdqcMuL0YzLmJTdK5B/4WYbFAPPRsvnsOShdVyJ/Wo5MLhSVu2LRB+i9wuuGo+flYCQKSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227295; c=relaxed/simple;
	bh=aox+2AgEiNYG1u0TgPXG6D1t/7jiNc6huiqp4LX58qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAe993AKqTrw3ciYRuATz3VIOecp4yx3B2MgNC4hYJ883SmDvIYVGq97MmfomHmz+olsYdO5QQQSDkjpTwxj9Qchz1BRYhHF6VJZZn1TygrMGSjNowyPgI9AkiufRFHHAZN9tPNdGIYh9C/ChlGPHbyfW45nhGs+knG9M/Z26hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtqSG+lI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso19672745e9.0;
        Fri, 13 Sep 2024 04:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726227292; x=1726832092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X9PVZTr1fh4UFLRanBhn9s1OhJ/Bjd4ZmZyv8BDZt9A=;
        b=GtqSG+lIRiOn5e+UcCfJPVCeSYBruUrsggnrSGk/RqBphrcgb7/vE40yQ0Fw+gyvci
         PV9OWTxEHvaUIeE9nvb8hn6D8s8H5mTL+/nmY0CfF5BS4VGF8pGBtqMBBDVKgPQrQy8h
         wUfJsanY4DjNfbuujBWeUhU/RIM9vWId/tHM3e1kcIpfpgJvdMJDToyKRBrC8OZEpwuQ
         qu7wQqRB1RM+a3d8UbD4ajfd6y9JaFOU6I5b7xppibfzqc5G0eFqNBIVOI9UZxJmGvm7
         tZ+KnFfdx6IuJB7T1dynHTj07Wn1hOwWN7WZLc6TzD7JgE15cYzikVk9/r7VLQnbRIhL
         GIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726227292; x=1726832092;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9PVZTr1fh4UFLRanBhn9s1OhJ/Bjd4ZmZyv8BDZt9A=;
        b=pNWksjE9I3vtsht708Dwor8VeD4x1hI2V9bbDj+qAQMsdobSJB8X+3KSeqcbrE9CM4
         clIXrQcZmVSpKUVJj116LpLmYcuPu4mxmpArK2S4PWL5bAiacslnTFl24i5NSsKCA2Gv
         LS5pBWBxutIMJo+tyd9zTsB/LJr9Hz6+QjWiZDbtYlJ+UgQnt9Ivw71HLeCRJ2LDxcMP
         fqzWB4jIghQe4xLPlzojDhDY6E2+UJypTOrMBBx7MnoXQTzTGW+Am3x5M6k1RhBFV4bu
         APddWYqr3Rc2WMDhGOSjb+R5Qqt2xzvpJLFH/NlehAR+MiPxeyGk5Wv8CgVUIuEJLlyO
         eIvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpEdjsGYrqKArc2Pqu04uJA6SVyuOJTxPOs4ZqYg1wFPvFPSfzPie9fOlAVmpaMEyL4mVlRXqbBtznNlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhTX6nVelKb/RqXMWGnMuJvR1hRtc8N7Rf+0cjYizxVxs7AQE
	e/8jNzn1+lqCH7lWY0ByYp8i3UbWyqfTpeuqgxj4B+haaMhFkL9O
X-Google-Smtp-Source: AGHT+IEl7GKlmReq3OGYMyX5zDP86AfYN6alFNLZd/Xy9rw9+fboK/8UqpKzwm5ckrE89LwvpwuS1A==
X-Received: by 2002:a05:600c:3505:b0:42c:a8d5:2df5 with SMTP id 5b1f17b1804b1-42cdb586ee0mr48328435e9.24.1726227291420;
        Fri, 13 Sep 2024 04:34:51 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05a700sm22547905e9.10.2024.09.13.04.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 04:34:50 -0700 (PDT)
Message-ID: <edf25359-1804-445d-bd49-45c7238a3cd5@gmail.com>
Date: Fri, 13 Sep 2024 13:34:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable
 GPU
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240912070624.25540-1-pablo.sun@mediatek.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240912070624.25540-1-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/09/2024 09:06, Pablo Sun wrote:
> Enable the Mali Valhall GPU on Genio 1200 EVK by providing regulator
> supply settingsi to gpu and mfg1, and enable the GPU node.
> 
> In addition, set the GPU related regulator voltage range:
> 
> 1. Set the recommended input voltage range of DVDD_GPU to (0.546V-0.787V),
>     based on Table 5-3 of MT8395 Application Processor Datasheet.
>     The regulator mt6315_7_vbuck1("Vgpu") connects to the DVDD_GPU input.
>     Note that the minimum voltage in SoC eFuse data, which is read by
>     MTK-SVS to adjust the regulator voltage, does not go below
>     the recommended operating voltage in the datasheet.
> 
> 2. Set the input voltage of DVDD_SRAM_GPU, supplied by
>     mt6359_vsram_others_ldo_reg, to 0.75V, the recommended typical
>     operating voltage in MT8395 Application Processor Datasheet.
> 
> This patch is tested by enabling CONFIG_DRM_PANFROST and
> on Genio 1200 EVK it probed with following dmesg:
> 
> ```
> panfrost 13000000.gpu: clock rate = 700000092
> panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0 minor 0x1 status 0x0
> panfrost 13000000.gpu: features: 00000000,000019f7,
> 					   issues: 00000001,80000400
> panfrost 13000000.gpu: Features: L2:0x07120206 Shader:0x00000000
> 					   Tiler:0x00000809 Mem:0x301
> 					   MMU:0x00002830 AS:0xff JS:0x7
> panfrost 13000000.gpu: shader_present=0x50045 l2_present=0x1
> [drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0
> ```
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../dts/mediatek/mt8395-genio-1200-evk.dts    | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> index a06610fff8ad..4f7d66d6d785 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> @@ -194,6 +194,11 @@ eth_phy0: eth-phy0@1 {
>   	};
>   };
>   
> +&gpu {
> +	mali-supply = <&mt6315_7_vbuck1>;
> +	status = "okay";
> +};
> +
>   &i2c0 {
>   	clock-frequency = <400000>;
>   	pinctrl-0 = <&i2c0_pins>;
> @@ -337,6 +342,10 @@ &mfg0 {
>   	domain-supply = <&mt6315_7_vbuck1>;
>   };
>   
> +&mfg1 {
> +	domain-supply = <&mt6359_vsram_others_ldo_reg>;
> +};
> +
>   &mmc0 {
>   	status = "okay";
>   	pinctrl-names = "default", "state_uhs";
> @@ -407,6 +416,12 @@ &mt6359_vrf12_ldo_reg {
>   	regulator-always-on;
>   };
>   
> +/* for GPU SRAM */
> +&mt6359_vsram_others_ldo_reg {
> +	regulator-min-microvolt = <750000>;
> +	regulator-max-microvolt = <750000>;
> +};
> +
>   &mt6359codec {
>   	mediatek,mic-type-0 = <1>; /* ACC */
>   	mediatek,mic-type-1 = <3>; /* DCC */
> @@ -839,8 +854,8 @@ regulators {
>   			mt6315_7_vbuck1: vbuck1 {
>   				regulator-compatible = "vbuck1";
>   				regulator-name = "Vgpu";
> -				regulator-min-microvolt = <300000>;
> -				regulator-max-microvolt = <1193750>;
> +				regulator-min-microvolt = <546000>;
> +				regulator-max-microvolt = <787000>;
>   				regulator-enable-ramp-delay = <256>;
>   				regulator-allowed-modes = <0 1 2>;
>   			};

