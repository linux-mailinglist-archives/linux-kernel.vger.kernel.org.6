Return-Path: <linux-kernel+bounces-529906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 022FCA42C58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5923B18901C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D01EDA26;
	Mon, 24 Feb 2025 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJWhvfWx"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6D1DB34E;
	Mon, 24 Feb 2025 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424099; cv=none; b=d61mXzRwplYJhvpG3fzcpIVoGAVf+ANvEuciAsSRbCy5TVb4pTTsldlPXvwsgR656aDRyvIGrlwMT+eL1mWArebfoSp/fE8SL0iZLNaMh4SvbrY/xIGzMdJ76frRNRJO0b/lzb+d0rgwRhjuB0cczyac2oRs66MoANojZyr2Hbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424099; c=relaxed/simple;
	bh=YgKHn0SXS01Q9qbQJ2WsiYEUqdwLjv45aY/6JKyfLuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVrCI9ky71s7NjqXml44q5aupfyodLm5O10GPWoP+oJso+V7ok889dYuMxbe8yMdPc0eTJDNvzBu5nvUQ+MnnYnUrK96cVqlB3dAODnQozT93XTfX45qS8PabQLmhVIuwUmX6GR+hqTuTrgWN0PdVzppPzM2nP3AV4B8CXfegJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJWhvfWx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso48502625e9.1;
        Mon, 24 Feb 2025 11:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740424095; x=1741028895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pU5W+dP5hQjBmGloMvFYYbU1gFy16R79+oo7OXi+20M=;
        b=hJWhvfWxlnxznJtcr4uuPT40zY/Q7fOsHkbksevKBV2PfMKgBWYQPo/5uy/Xghw4B6
         IpoxN9vTb/K5MJgaGvMUSJk6ugl72lQeJwn/iCtqbR3lga7G8lfRciNhsoTVmxIoZveO
         sQGKFoMk9l0qdHZgXX7/ukhx1bjlzs3LC6sgRiqbtDuVkJNp5JubZRVCAxYYKrHN0XrU
         Z2PJWB+SP++WV6G0CBYW3gGsvb2qSDo5A2sSUaZaohz3tw9XmLGTLtaWmhoG/SUCgw6U
         0LDinuTVoJZYR4UtsEhRW1qCesGbYCaOrXNu/EJINrM2k+Re3SNNIOmNJv5N1EDNCji0
         vLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424095; x=1741028895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pU5W+dP5hQjBmGloMvFYYbU1gFy16R79+oo7OXi+20M=;
        b=oD9p5Px+QZx7wzgzm19n7Zfadgsa2VeXGSnfUpSvDqagX4yMDV0hf+NaRCTegmUiUn
         JxckfWNXSYIHFTCWUcGM2dGj4Y+bQMW0e2efnAZrJBKtNJAb0hMUwJSGq96tmYGzGqaq
         ++hQGLJo1k/1FN8BLtSHs8MQ5Sz7NnUTmK7DcBaEOOvavVcRhBg3LoZry0KiUadYr2KW
         S182qQ3jOqrnfTU9QkyGmcvpaAN965TifsyaLyjLeVzd3hLsUVBPE9JDJs/WhBJimaB/
         /qY6ZjqcDK7hOi9Gep+LgOsGbOZ2Mqt6OgW9t8DMZoADJi6ABl7se4r7yg3vv/fimOLg
         HiDA==
X-Forwarded-Encrypted: i=1; AJvYcCVFb7sKtjlM03Xzw0ousqBBCKy+gwLv626AzadM8jqJUABwuFAPfVxo9zuBUBIzpbDrsmDQJsTbnaP1hKNs@vger.kernel.org, AJvYcCVK4Lcv+OdUFyBUezP6HGnQbVjkUJFHIfovqOYXYwx/UfVHTmvPYpO2Yc1L+geA53AtoI4LPnMcvl4+8LY=@vger.kernel.org, AJvYcCWSOscIDPOTwJI1U1eIGOAeUFY+2T039hw1+lIVSxU+ItANpvmD2Umn4fUZfX9hvgB3Tag2Pc6DPIhq@vger.kernel.org
X-Gm-Message-State: AOJu0YyZEDbEB8Tum1nZvBbP6S/yJEMZ2v3nGbiPpZ8v+T5isH4dUBN+
	uJUtCRnv9lYAp/M/tLWNIFOgSeamQh/hdZZI3zLrgs9fl8MfXiL2
X-Gm-Gg: ASbGnctwJ3Xzi5G2YF09lJyaPs3BIjdWd/fe5siiNMsjciCiVjRGmdCE1ZSg1DHVuvi
	Eqj46OmfcMvy3VBfpPYrjm6RNT0GyylQkk9xunKGQPz+PRuZQbbK7T+wSd3BNQFYVYOYKO3++4C
	tf+wZ/qATkDxdeheptDcf57D37sYWWWfPviTFiqWc/Tv63GIeGU4e6AxTj1gnQdeP4WOY0S+0wR
	ECsFlNGqCUbP8ZI2BZTSNgW0oQ3Zb61lfVDeMjEGthOF8MhR2S6FSLeKxaTYoCvwZs1ofE3v2f1
	wAIidgM/FWQwiOmbmePNwyp/kNqiIglxeAYbrUoeKy7u1Un5Ugl93lI=
X-Google-Smtp-Source: AGHT+IFMZpSkj8mOeTbZpxScUGNxroU6s1DGkIhvD1LVcsUzWU2LZzSOcO2UmaPQci+OsYqbI2Wf4Q==
X-Received: by 2002:a05:6000:154b:b0:38d:d666:5457 with SMTP id ffacd0b85a97d-390cc631b04mr259493f8f.42.1740424094433;
        Mon, 24 Feb 2025 11:08:14 -0800 (PST)
Received: from [192.168.1.143] ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d552e7sm8482966b.48.2025.02.24.11.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 11:08:13 -0800 (PST)
Message-ID: <36ca7549-aee7-4f14-9311-77978a42362a@gmail.com>
Date: Mon, 24 Feb 2025 21:17:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx: add imx95 dts for sof
Content-Language: en-GB
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-4-laurentiumihalcea111@gmail.com>
 <Z6vcBvs4xGQ+pGCJ@lizhi-Precision-Tower-5810>
From: Mihalcea Laurentiu <laurentiumihalcea111@gmail.com>
In-Reply-To: <Z6vcBvs4xGQ+pGCJ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12.02.2025 01:23, Frank Li wrote:
> On Tue, Feb 11, 2025 at 05:58:08PM -0500, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Add imx95 DTS for SOF usage.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>>  .../dts/freescale/imx95-19x19-evk-sof.dts     | 85 +++++++++++++++++++
>>  2 files changed, 86 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index 839432153cc7..27f64e333e4b 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -282,6 +282,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>> +dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
> look like should use dt overlay ?


can you pls explain why you'd see this as an overlay?

(snip)

>> +
>> +	sof-sound-wm8962 {
>> +		compatible = "audio-graph-card2";
>> +		links = <&cpu>;
>> +		label = "wm8962-audio";
>> +		hp-det-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_hp>;
>> +		widgets =
>> +			"Headphone", "Headphones",
>> +			"Microphone", "Headset Mic";
> Generally, align to  =
> 	widgets = "Headphone", "Headphones",
> 		  "Microphone", "Headset Mic";


sure


>> +		routing =
>> +			"Headphones", "HPOUTL",
>> +			"Headphones", "HPOUTR",
>> +			"Headset Mic", "MICBIAS",
>> +			"IN3R", "Headset Mic",
>> +			"IN1R", "Headset Mic";
>> +	};
>> +
>> +	sound-wm8962 {
>> +		status = "disabled";
>> +	};
>> +
>> +};
>> +
>> +&edma2 {
>> +	dma-channel-mask = <0xc0000000>, <0x0>;
>> +};
> Not sure why need mask edma2's some channel, can you add comments for it
>
> Frank


sure, can add comment in commit msg


