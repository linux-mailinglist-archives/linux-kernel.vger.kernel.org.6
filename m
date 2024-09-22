Return-Path: <linux-kernel+bounces-335329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C497E42B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7431C20F94
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F47F7C3;
	Sun, 22 Sep 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPHj4WNj"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891B7581A;
	Sun, 22 Sep 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727047164; cv=none; b=QZEZsCuqcfTgW0vinWU2DNXZMf5FYgHbvIeuq/9fSK1C8ogUWCHb7NrdEHJIqVPTCv4gAwnIM93XEsemlGJQkcx+J1mX+y2edhSzmMK8WMlU+4ZALnaUwji4ZQBdzSo3Pu9CPhwCojnmn4syl6xZmUZccs3L31c2VK0hFJoKlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727047164; c=relaxed/simple;
	bh=/fsL83JiV5QpzmbHyytfrwF5t0swH4mJJm8/vQzPfT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2rzAQB0oYOrK4cvYqMqvPY9FWNpizbbKSavQe6vzgK3N/j9l1C8AMpN/yVOgYOfXSAxHhCXSpn94PJzQ/aEj6PyRQBbQnCtHBoPQEa8KCpZLfaw/81sDfXtKBWGBzlbXoa3J5X3PlHLOGSgKeaCMFXFDK47oatB3KSjX98Ufqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPHj4WNj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42e5e758093so31574215e9.1;
        Sun, 22 Sep 2024 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727047161; x=1727651961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QmeQYM479yzZexFRDFHjQcwG9TTAWkIzn56oUaf14U=;
        b=iPHj4WNjZA2uEuHjtq7to1Bpt6fTPGxNwILnARt1bxMUOKCWA1Wjqmb6uh+j2pPhun
         cvlEfSbxXs4HhfFZ41MG/7x7gtl+MxuQkHQccX7T9pILhO+6euXEtryK+4I3hzF7QuVb
         tdftv+ahP3vK187nphtBmw7iQjizKJBke68IUnCvBJ1c/acPiqj7wv/iI6JcmpmgM3Ng
         R6aHAEcUmJuRpt9/HRWO/gJYcMoZHIwUmCV4p97ISyc/U++H1HmtZ5onlGTT3tgWJOx0
         nthaGmhIqu7izUg2iEBle4YtF8gx8gjIpDsYazEXUJVLy2nOaAQDwT54oEmcFG5S/Ha1
         cj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727047161; x=1727651961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QmeQYM479yzZexFRDFHjQcwG9TTAWkIzn56oUaf14U=;
        b=fGpYgBHgyCyivi1v54mJ9Nx2LECn0HPxVP/vVVXvawr4yI6OjLAYx18r/3B4ZP/dtX
         TXUCgBt2+sp6kS43PSfsAOmCvKvKLmTIymso4ItJ3fN4bPXyTf8VlCKCxaSmHt42vMOE
         D12zQ5nTuZVaEwZ9kR9TF/ALrxWFYuRcVpg+WBSsNEVpUlIuW5lNTM88uPP8GQtY6Axu
         fYceY2vKYYOCynVUsTo4kmNkGHzmfSuzhvLHem4++TJtORmt90LVsZk+hwlwmmUM2+gs
         acIm3OO7Mu/jsTwX3a3j6GDuQTMmrTN4lOxpOjNuTshKvuZz0SVKOcIGh4ZBsGw24eQH
         I8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUKbY5ueUYFSVfF8ob5Yhy3yP3k3kTyeNRDjnBUuSwtUNerdEYyGAGKJs42HU+rxoS47IAW8WSlXM42@vger.kernel.org, AJvYcCVuDzxgdOlSBIIAxIZqa9xFGzHewlNgVpQEEamvcIWyeZxJgbJCqWZIHs/h7/rk+z3Qnw0PvSth8Pdzg9F4@vger.kernel.org
X-Gm-Message-State: AOJu0YxREASIQeJzBY3WSr9STTx8u+8g9WoKW2Jyx4njPrRSmVGWJgsz
	WIgVeQmywyz9lGgboi6PJL99J/Sb4I6uihIU0QBMWPLYOb1ULjYp
X-Google-Smtp-Source: AGHT+IGZZw5+3WxxKggocLFzJxwqoSd1f5PjjLcsXXYGL35zdx9oJLvHztzhdL/betnYcPItTEYQ7Q==
X-Received: by 2002:a05:600c:4e92:b0:42c:bde5:9082 with SMTP id 5b1f17b1804b1-42e7ac225b4mr82073095e9.17.1727047161066;
        Sun, 22 Sep 2024 16:19:21 -0700 (PDT)
Received: from [192.168.1.130] ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7af895b8sm85431855e9.14.2024.09.22.16.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 16:19:20 -0700 (PDT)
Message-ID: <d02ea50c-249a-4221-8884-cd6674075184@gmail.com>
Date: Mon, 23 Sep 2024 02:19:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: imx8qm: add node for VPU dsp
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Baluta
 <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-5-laurentiumihalcea111@gmail.com>
 <ZusijsRFJPtFc0h8@lizhi-Precision-Tower-5810>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <ZusijsRFJPtFc0h8@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/2024 9:57 PM, Frank Li wrote:
> On Wed, Sep 18, 2024 at 02:21:16PM -0400, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Add DT node for i.MX8QM's DSP, which is found in
>> the VPU subsystem.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 27 +++++++++++++++++++++++
> why not add a file imx8qm-ss-vpu.dtsi to keep consistent with others.

Don't see much value in doing so right now. It's just two extra nodes (should stay that way AFAICT).

>
> Frank
>
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
>> index f8b577ebdbef..ae0165a44dcd 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
>> @@ -581,6 +581,33 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
>>  		clock-output-names = "mipi_pll_div2_clk";
>>  	};
>>
>> +	vpu_subsys_dsp: bus@55000000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x55000000 0x0 0x55000000 0x1000000>;
>> +
>> +		vpu_dsp: dsp@556e8000 {
>> +			compatible = "fsl,imx8qm-hifi4";
>> +			reg = <0x556e8000 0x88000>;
>> +			clocks = <&clk_dummy>,
>> +				 <&clk_dummy>,
>> +				 <&clk_dummy>;
>> +			clock-names = "ipg", "ocram", "core";
>> +			power-domains = <&pd IMX_SC_R_MU_13B>,
>> +					<&pd IMX_SC_R_DSP>,
>> +					<&pd IMX_SC_R_DSP_RAM>,
>> +					<&pd IMX_SC_R_IRQSTR_DSP>,
>> +					<&pd IMX_SC_R_MU_2A>;
>> +			mbox-names = "tx", "rx", "rxdb";
>> +			mboxes = <&lsio_mu13 0 0>,
>> +				 <&lsio_mu13 1 0>,
>> +				 <&lsio_mu13 3 0>;
>> +			firmware-name = "imx/dsp/hifi4.bin";
>> +			status = "disabled";
>> +		};
>> +	};
>> +
>>  	/* sorted in register address */
>>  	#include "imx8-ss-cm41.dtsi"
>>  	#include "imx8-ss-audio.dtsi"
>> --
>> 2.34.1
>>


