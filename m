Return-Path: <linux-kernel+bounces-511750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4FCA32F35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107561889991
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8471261376;
	Wed, 12 Feb 2025 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfCX1ByG"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1B257AC7;
	Wed, 12 Feb 2025 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387095; cv=none; b=uhUnOFKJOFrrq79+2wmp/JhcHWGPtYcJw53s3Vc5e6Kny/2IE69CQ4DBasmkJQTas/pv8bEm6Yt/q2j/i7dLziMWux0acI15S2cGcf/alldSniEak3gMxJ/c7oBL7zYUgXge0fIAPkSdD3XRAdhl6Mw5mg2bXw5/CI1VihFQGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387095; c=relaxed/simple;
	bh=GByBzklmfX23pRSpc2MBYgFPIh6J9o3kWfHsq1LZtCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joBLW8ZKSjLCtkkiRhbDkmBz0a4DBCVndicUdN+01JUBUB5LQQXbGN3u+uzjtJtLSsJPTYtNWK91pKe222FKFtgMJ4mxir9VfHZ1K/IdeGLv6yylcjIF4lUXzcivhOrV92u5H3bYmnkBosjhARCug60qXHxJkKEeK7DERkgGUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfCX1ByG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de5bf41652so7546a12.1;
        Wed, 12 Feb 2025 11:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739387092; x=1739991892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5n7rB0wdq5vMXsxf8BJiZz2GQf3El+y7mHlJDy65vBI=;
        b=ZfCX1ByG6lLEddjENxnUcdZF+ePcjir4JHcS1wLRN5Wr1tqSLT7PI0eGYy4HrYChfI
         4uJMsWtbY8kx7o5VxIu48iAM/erua191Rc2NvjLWKPsCxSDV9avzByN+QNCy12p7zeVt
         ICgk/pJvgYg9fEpPyjSFx2hOQG8lslDHoBaQvA9crMZbCc7kOZejUReu6GKsN3tTnH8B
         OOIm8f/P//+JJs1QJPAKAiiWaEqq5T/vNyvNQtZqi3NoF/THO3IYBdQccGpLCm3tFCqt
         uUCfk/rHnrg/wFFcHqy8u9Ja3CLch8KkpoWbxmbbEwrJis2Oj/ikcChBVHAKoR9bgzXY
         NcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739387092; x=1739991892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5n7rB0wdq5vMXsxf8BJiZz2GQf3El+y7mHlJDy65vBI=;
        b=WdII9MZYSaIQmAsOO7SDBw3hVPEfO8GXQW2mCAeEd6rN1gtThoCDR797xl4sR5CPH0
         qU5g947cjRIEuvIMmbgEf7SO1amKfMZoSnLdh1h6s+XB8Nd//gsqugIw9vt6eM18glOE
         WSPG3lGuyCfwS7UZhi2bnVgSi2mY37s4M7cDlshp1C0meJS1zi7MPP3ofd2ANmxBuB8l
         Q/lZnmwMkTASzSa0UU9l5C/EnPeL5AY3W/T+84G/OJlft7PyNDqvebGiPiNpjHog7TXs
         KfjgVg8a3Oqbpp7xXP0TNNDNyiora4oNCvSKohcPFMjwCAdCGGCA3f9eVBXIJI1ILlQc
         O8dg==
X-Forwarded-Encrypted: i=1; AJvYcCWcroc7Lr16vZCl08SjhRz42qL0RhUMh7vEzfZYov7EAkY3yNz/M4CH67zvXqLtnYfGbfLRi3HHAzzVIiky@vger.kernel.org, AJvYcCX2bJYBywFsaMxCxL7Nzf3ho3Xfg5E/zPzGT/XeUJhi+whvGmko46X2UR+bJ3WvEYhS/M+YLPUJS7+U@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4dgLqzJ7i+Qw2SrvdGwNVZczCILFIowk8/8ozWtGQbAsbhBa
	CRR8uFYwEEVple54pOGK8+5rvdxapOWGlM0/jqC3wya9K28rzCZ8
X-Gm-Gg: ASbGncu1FrUsiW0XsvAyGFbdIAeRuKM/TtbYFO62d0qXph5iuO+lIyhGEIY3F8RKBlw
	rOuW7VjlcK7mu6nJtXzgUBGY9g+6AdUlj2ne2cwMQIlZjjCOpVsv+CGq3s1JPQc5SBkLWClHVnr
	okkQalwCkkCBXXJMTvzzICArGZxH4hsxgEuRk9G8QiHbLHF/UetVOLKwjajNC0yBiqOv21+hDnV
	wXDqxqTSQeFHSqhsPi5IbNujtbVrn2JQsL5h4Pf8wqj9YU1YKEn4MnJkD19AWnYjf3SuVg5jJsk
	QdT3pVA2hni0OkQqLFhfNbiDRPjEcgGbZOfoOu5GfD+i
X-Google-Smtp-Source: AGHT+IEZn0+ju/iW8MyZm8pcKU9jLpSB3rBPfVfpKrwdB6064zci1oEw5mVOcdEw7A8E0QsKoeQlTA==
X-Received: by 2002:a05:6402:348d:b0:5dc:882f:74b7 with SMTP id 4fb4d7f45d1cf-5deade1c945mr4021549a12.30.1739387091464;
        Wed, 12 Feb 2025 11:04:51 -0800 (PST)
Received: from [192.168.1.130] ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9343226a12.45.2025.02.12.11.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 11:04:50 -0800 (PST)
Message-ID: <da63fc79-76f6-443f-b1fe-c4242cb45328@gmail.com>
Date: Wed, 12 Feb 2025 21:04:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for
 dsp
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
Cc: shawnguo@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 aisheng.dong@nxp.com, daniel.baluta@gmail.com, laurentiu.mihalcea@nxp.com,
 shengjiu.wang@nxp.com, iuliana.prodan@nxp.com, a.fatoum@pengutronix.de,
 Peng Fan <peng.fan@nxp.com>
References: <20250212085222.107102-1-daniel.baluta@nxp.com>
 <20250212085222.107102-6-daniel.baluta@nxp.com>
 <Z6zGLn3B6SVXhTV1@lizhi-Precision-Tower-5810>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <Z6zGLn3B6SVXhTV1@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/2025 6:02 PM, Frank Li wrote:
> On Wed, Feb 12, 2025 at 10:52:21AM +0200, Daniel Baluta wrote:
>> Audio block control contains a set of registers and some of them used for
>> DSP configuration.
>>
>> Drivers (rproc, SOF) are using fsl,dsp-ctrl property in order to control
>> the DSP, particularly for Run/Stall bit.
>>
>> Note that audio block control doesn't offer the functionality to reset
>> thte DSP. Reset is done via DAP interface.
>>
>> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> index 14cfbd228b45..46b33fbb9bd1 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> @@ -1609,7 +1609,7 @@ sdma2: dma-controller@30e10000 {
>>  			};
>>
>>  			audio_blk_ctrl: clock-controller@30e20000 {
>> -				compatible = "fsl,imx8mp-audio-blk-ctrl";
>> +				compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon";
>>  				reg = <0x30e20000 0x10000>;
>>  				#clock-cells = <1>;
>>  				#reset-cells = <1>;
>> @@ -2425,6 +2425,7 @@ dsp: dsp@3b6e8000 {
>>  			mboxes = <&mu2 0 0>, <&mu2 1 0>, <&mu2 3 0>;
>>  			firmware-name = "imx/dsp/hifi4.bin";
>>  			memory-region = <&dsp_reserved>;
>> +			fsl,dsp-ctrl = <&audio_blk_ctrl>;
> I think kk's comments in v3
>
> "This should have been implemented as reset controller, not syscon. It's
> really poor choice to call everything syscon. It does not scale, does
> not provide you runtime PM or probe ordering (device links). Quick look
> at your drivers suggest that you have exacvtly that problems."
>
> The above is quite good suggestion.
>
> Your reply "But for Run/Stall bits we need to use a syscon.",
>
> Run/Stall actually is reset, Most system, release reset signal means dsp/core
> RUN.
>
> Frank

RESET and STALL are quite different signals w/ different purposes so
calling them both RESET is confusing and inaccurate.

The syscon is used here to control the STALL signal (name of the bit we're using is RunStall)
and has nothing to do with the RESET signal, which is why it's implemented as a syscon rather
than a reset controller.

While Krzysztof's comment does make sense, I still find it odd to have this implemented as a
reset controller despite it not having anything to do with the RESET signal.

Also, do note that the two nodes are in clock provider-consumer relationship
so unless I'm gravely mistaken this should at least guarantee the probe order.

