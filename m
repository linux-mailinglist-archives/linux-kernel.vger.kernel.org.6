Return-Path: <linux-kernel+bounces-442898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D599F9EE3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D1F168120
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA63210F45;
	Thu, 12 Dec 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixob5xQS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97A210198;
	Thu, 12 Dec 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997894; cv=none; b=f/slUPT82FNaLt168LHtBFtBdqtYJKcZ5cfsrPY6L4igAHCQyr5vIHAspRKexu7XKC/QnvgmqdC49UYJNvA3h9+he6fzdOXsTVKJllQOaHbCcSeGFJYyWJCsGSX5WXen1Sbzu7O4h9CykckxPtIKLl/IZ6hE7Q/mld0cVMCEZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997894; c=relaxed/simple;
	bh=UeX80lfb499kn+ov58ejv+wnhX5jVuNu0bMwJi5xZUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3xsjVm+t9N9gY98x4j6v1SpSpUZxlNO6fTpxaT3yuqz79SN+sSSurwagBJFMgbqcQ00HFdMAMuXd+EPnniReyqxuR1nxo9JhxEXQqSvNFikULeA0XyEYPceXeHmJ4ffXkw96VXutxsZqtd3Do85LaGU4/oUz0WjWIUjqN6Ehbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixob5xQS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ec267b879so78158066b.2;
        Thu, 12 Dec 2024 02:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733997891; x=1734602691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcNqGkwIauu/8vGqbL9sA5oDKvOeKbiw9sBlkhBTUJc=;
        b=Ixob5xQSh40JOplnw8cWo3niAvTHKb3EKNRLnJZqDoM2K8tnIZamSPFy8ccm3iNXXF
         rG+DTHncwnZLisgsG75qTVlL3q7L0qD9nfdTKUanSajo3nd9fXVtyK+kfJbpwr5mCj78
         gNFAkDG30cbXUO0y++6Xy+AjEedZ/5Ntdp98/6iDzAB3DQUeyBj/iXTbL8w0cgnrGDX9
         zpjTOl/Smp96bnQ16N5T1uwQVkTI3fwSFd2n7j+0zcOLwj3tHmFWmGIide9T9ICqn1u5
         VD78ojE6DeYzmcRB4uF9X5ZOW084tCwxmCOwt3sMqc48XaJ52oxgqEP/PEj3KSfRAKgH
         P8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733997891; x=1734602691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcNqGkwIauu/8vGqbL9sA5oDKvOeKbiw9sBlkhBTUJc=;
        b=XSoeViU8NEcI9X9Y9k2VIowDIx1gOcJT49a/PJxjbSWwXBbKLg7X9jPge7ix88tb6c
         X8M609r1xBHTp+wrLGLOMOgsz9rDJTDkpuXZrdaZOuQU9QvYPtJ37a7sY8taUkwyIAmk
         tnCT+b+aP1T7eUagEsXIjRk08VRS+51qmcnDGO1Pk+nc5E8NvcfCgcG7YIwav9CkbkzA
         33QrW8XLC2yYjN0wT6q4NuZjckKRkCSZlEdyQnaSLr15GQaiCdn9kYZbpTL57Uvenebw
         qZUJgesycjqevKRYEg5dJPv7FqrBSgvVdsymrB9C4k7zR3hMs4ajHkFmrm7EEElqV7oE
         M4zg==
X-Forwarded-Encrypted: i=1; AJvYcCU6bVjsXKLZ36rzMvrVe1JdMko9w5xmfGWdxpBxi2F+yjt1avsAuPCQCP0JDkmSZvs1Iq83xkF5ggGDkxU=@vger.kernel.org, AJvYcCWU1rOwWUeybGT9vnR+BoUiZ1vYmLFxhONT55LbsfV0oP3g/GpRF5dXRw5mxewM3iGUF5ryfKZ8FSzB@vger.kernel.org, AJvYcCXLG3priE5qKL6wWoYtYCvIERnYJI1YhE5AQvmee0hSvIZNpkp9VT+CsuIm0Z8vGotKa00AGvNM4aGhLHJE@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFuEEIKUkqMsXk2lsgO1jNYd/pQxRisexC0fb0lc8A7TbRu6I
	G/1LIbvVwPzH4JXjT4OYxDWPFq+fwH8Z5NdyD6SHimM8P2ojk6E9
X-Gm-Gg: ASbGncvfzdCImd+2+wNMC6nFZsih7I5ur4VF1q4syEfjpVvVAvSEd/5BKLi/WpsZbxt
	CkMBGxusJuHN95NPTEunsa9sgr6wblW6ed9KseZDPdFaE6ExiphvBU2d5d6K5QGV82CfR4x7sCY
	oT3Q8J46zYdInbmLSvIwr7BMNdIabUQt71DjqiEga6ya2/o58dRDPz4r1c1+Z8LICjmr3FshbDZ
	0G1pn/XLi3HYG14V1x/PGNZoFFQ/9wYKWINwCbWawhjHby557iSdPkLgUS1GlmcCyEu+Yek2ndO
	66p9hw==
X-Google-Smtp-Source: AGHT+IFQT5iUBDmZUMai1sO2ZlzqvJN+RIKe3rhjwPSdU4AZtZ7Q43WieJ/g7Z/ZNDQAZtHYn7R+CQ==
X-Received: by 2002:a17:907:8284:b0:aa6:6696:4072 with SMTP id a640c23a62f3a-aa6b13f4f48mr539712866b.49.1733997890532;
        Thu, 12 Dec 2024 02:04:50 -0800 (PST)
Received: from [192.168.7.105] ([92.120.5.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67d63f867sm641007166b.133.2024.12.12.02.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 02:04:50 -0800 (PST)
Message-ID: <392884c8-0f4e-43a5-b81c-bf2e80cbddfd@gmail.com>
Date: Thu, 12 Dec 2024 12:04:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: imx: add imx95 dts for sof
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 Mark Brown <broonie@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
 <20241113195240.3699-6-laurentiumihalcea111@gmail.com>
 <ZzUKPehw2G9XcRsb@lizhi-Precision-Tower-5810>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <ZzUKPehw2G9XcRsb@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/2024 10:21 PM, Frank Li wrote:
> On Wed, Nov 13, 2024 at 02:52:40PM -0500, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Add imx95 DTS for SOF usage.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>>  .../dts/freescale/imx95-19x19-evk-sof.dts     | 74 +++++++++++++++++++
> look like it should be dt overlay.
ah, interesting idea, but I don't really see its usage here? As far as I was able to understand the overlays are used to dynamically change the DTB (via u-boot), which we don't really need at the moment.

>
>>  2 files changed, 75 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index 42e6482a31cb..0a313133d013 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -269,6 +269,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>> +dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
>>
>>  imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
>> new file mode 100644
>> index 000000000000..3fa4c252e355
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright 2024 NXP
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "imx95-19x19-evk.dts"
>> +
>> +/ {
>> +	reserved-memory {
>> +		adma_res: memory@86100000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x0 0x86100000 0x0 0x100000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	sound-wm8962 {
>> +		status = "disabled";
>> +	};
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
>> +		routing =
>> +			"Headphones", "HPOUTL",
>> +			"Headphones", "HPOUTR",
>> +			"Headset Mic", "MICBIAS",
>> +			"IN3R", "Headset Mic",
>> +			"IN1R", "Headset Mic";
>> +	};
>> +
>> +	sof_cpu: cm7-cpu@80000000 {
>> +		compatible = "fsl,imx95-cm7-sof";
>> +		reg = <0x0 0x80000000 0x0 0x6100000>;
>> +		memory-region = <&adma_res>;
>> +		mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
>> +		mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
>> +		cpu: port {
>> +			cpu_ep: endpoint { remote-endpoint = <&codec_ep>; };
>> +		};
>> +	};
> please sort by node name.
Fix in v3

>
>> +};
>> +
>> +&edma2 {
>> +	dma-channel-mask = <0xc0000000>, <0x0>;
>> +};
> Why need change dma mask here ?
Channels 30 and 31 are reserved for firmware usage

>
>> +
>> +&sai3 {
>> +	status = "disabled";
>> +};
>> +
>> +&wm8962 {
>> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
>> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
>> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
>> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
>> +			  <&scmi_clk IMX95_CLK_SAI3>;
>> +	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
>> +	assigned-clock-rates = <3932160000>, <3612672000>,
>> +			       <393216000>, <361267200>,
>> +			       <12288000>;
>> +	port {
>> +		codec_ep: endpoint { remote-endpoint = <&cpu_ep>; };
>> +	};
>> +};
>> --
>> 2.34.1
>>


