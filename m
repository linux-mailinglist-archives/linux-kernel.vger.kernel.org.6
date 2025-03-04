Return-Path: <linux-kernel+bounces-545387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9875A4EC5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F78D7B04F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921BB27E1D4;
	Tue,  4 Mar 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGSH5jDs"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17124EABB;
	Tue,  4 Mar 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113525; cv=none; b=VzVRs03rnPigct5qEB0zG2P8gYgK8ibKRcRkx0uUeTG2pvsyxTqx0MXPmughZaMuQbrim7T+/zWYClFyDWTPY+PzNfyb3oxdDDyynW9kGuyFQa3UUGVTo27yAT2nDAgglthFoi2Skty6ssOheVdecRVNjVIxPSiNRyNIWko3B4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113525; c=relaxed/simple;
	bh=hSLwXWcUbwo7t49r9pt8k3ZvIyCKvfSqv0ZtVn9VHGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ehmnz5SnipFsgYdl8Dm7o8Fe5c4CULeGlMf/8GmYYmWRx0k3dDNHAHSTj+lrAoLn+3EvBgxtOP1mv+hQinswMC/qn9F6XHxP32TAHk1Cb90FVqsNMv/sZSLqNGCCg8Cqi5L1Qc0dlC07IYkktcCLAnieWXIiS0RAJdrAwXSYCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGSH5jDs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bcc02ca41so9679595e9.0;
        Tue, 04 Mar 2025 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741113522; x=1741718322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H948FRDwgMsgmADI+OEoZ51nO5/psSifQe84iLy+MzA=;
        b=XGSH5jDsUtaockX1m53nZXnhweaC5VTNy28DVAr5sL11aFnN5lPakJbph7tNfRZtQe
         Emu5/FogYSYUnhG6tRTxw/oXTSeydP4PdzXYYdaEAbDhf3CyAu56rTVQHW3SPIz6YJA1
         mM8X+9MsMlAT7DDFFMi8RcQadWQ4Lz1XYciHTpch1iJAseYTa9+hyCZAWuCH/OEku5Mg
         b89B62RKFdEfvNbsnHbjI6Jlr6H3JttE9PjZbLZ4dI6GEL+WrHLyAsBcMRWFZPZM1jAC
         jR/lVC+HMCAPHdcpHGnmY9/gO/bRdUv+0JdY36ITMJuGbzlZ6q8wX2ZSNE59sH4BP8gh
         /PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113522; x=1741718322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H948FRDwgMsgmADI+OEoZ51nO5/psSifQe84iLy+MzA=;
        b=rpBf2kGrhGsyo+eBbbrGwmVq84Qmw6uwY3uWHaQ+EUDZxmIlBB8Ua9DBCnjzvmnp7s
         luI9TAmqm2BaMsYX+8odWEcniTiTwjQn7qy7Zum7s6IqOkFh7moHpaJLrSoKnWsDHDg+
         IfUC+eRHdnSwvGNb8w1mflLrebm+pdTPt5lVYOxb0gSz4CAba8BF7WJlLKAC3L59ck2+
         eNh424vPirr9CwdDXYugLArWVzf05uU/Ab2ofUyqkt5e2LCFrfNHc6UxkftWtn7m6Zhj
         8r2rwY1APclxcFzV3/tptPtS7Xpxwxy1GrQj3TgKogTUvxHRwj5xbDjXpSq8q2t3mpAJ
         0jkw==
X-Forwarded-Encrypted: i=1; AJvYcCUdog6xWjbF0Yg0oIApqBdWzJgOjDJgCxY0dMiiZp8iIvlyintrhIeR+mZmTZKXWg4r47jUxFd8d892@vger.kernel.org, AJvYcCUidiimEmBq4bWKqeCDcp7KsrfCha06TXYocMczXEImWPn9LARSpMEyshqCsdDdOdUw17LWrHk8MxguUTs=@vger.kernel.org, AJvYcCXQzOXf0uysmbkXbwqi1TTf11T4e3xoC8EXfxEr04lW6ssZeyJUqxQkWv/K+O8/ky1pMVZJkSIMXe09/8ES@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4AOl9VrhUpIYiyFaxA9KZkAQvi5/OxAilAJl7gVYxbd6QRfG3
	Zcucks0ApeUEiSvKFpcT7tPKRejpWGCoQd/nT/47XYCf1IhGIjkilbiW0976B+A=
X-Gm-Gg: ASbGncsdJv4NYYdEf0mSVWcyxDqcVJblgF4rkU5KJY4WkBLWqKVO2CnDRMAqSSgQp1k
	snxPKEGHWfnVlY41UfQjlMWfzplKSmvnyctTdEhWiHS+ITNaThX+TkClOmth5C+GIFcvwUEP9A0
	HrJ3KUb7cjxjR5M76nCnhIp1eh0W0XCsnmKI9LNoGuz161ya4JyCyWx37OvKrXgbE2XlC0N0peE
	CbDZewUd7KfWftu4GlsmfAaN/eFATFS/eIPrKP2RUH99gTpEdge/EIXlxTXz0zJTH6TlEldmjc9
	6KuFhtbycQ+YFZIWrM6CteejHe9U9mb1Gm+DRbtd/0pha6AtF4DL+x3l9qBHL3h4FJEcAaZiZQ=
	=
X-Google-Smtp-Source: AGHT+IG1166SxCE4sFCdzuiE0V7QxZDudPu8M9dvEeKEFshASL6QcVMXEy639K5WegyKjMIjEPWGqA==
X-Received: by 2002:a05:600c:1384:b0:439:8bc3:a698 with SMTP id 5b1f17b1804b1-43ba66e5e9bmr153210385e9.6.1741113521738;
        Tue, 04 Mar 2025 10:38:41 -0800 (PST)
Received: from [192.168.1.132] ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbe676b41sm93370475e9.11.2025.03.04.10.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:38:40 -0800 (PST)
Message-ID: <31451d28-d179-49b7-81fb-0f8914cc9c1a@gmail.com>
Date: Tue, 4 Mar 2025 20:38:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx: add imx95 dts for sof
Content-Language: en-US
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
 <36ca7549-aee7-4f14-9311-77978a42362a@gmail.com>
 <Z7zNymSs5qeHp9wL@lizhi-Precision-Tower-5810>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <Z7zNymSs5qeHp9wL@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/2025 9:51 PM, Frank Li wrote:
> On Mon, Feb 24, 2025 at 09:17:03PM +0200, Mihalcea Laurentiu wrote:
>> On 12.02.2025 01:23, Frank Li wrote:
>>> On Tue, Feb 11, 2025 at 05:58:08PM -0500, Laurentiu Mihalcea wrote:
>>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>>
>>>> Add imx95 DTS for SOF usage.
>>>>
>>>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>> ---
>>>>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>>>>  .../dts/freescale/imx95-19x19-evk-sof.dts     | 85 +++++++++++++++++++
>>>>  2 files changed, 86 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
>>>>
>>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>>>> index 839432153cc7..27f64e333e4b 100644
>>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>>> @@ -282,6 +282,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>>>> +dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
>>> look like should use dt overlay ?
>>
>> can you pls explain why you'd see this as an overlay?
> It is addtional option, which base on imx95-19x19-evk.dtb. Default wm8962
> is used for built-in dai, this provide option to move it dsp.
>
> Ideally this option should work for all boards, which use wm8962.
>
> We try to move MxN problem to M + N. otherwise, there are huge numbers of
> dtb files.
>
> Frank

Yeah but these are not cameras/sensors (for which there's a lot of possible combinations)
we're dealing with. Unless your board has the same codec, same GPIO for headphone
detection, and uses the same SAI instance this overlay will not work. For instance,
this wouldn't work for the imx95 15x15 EVK board as that uses a different GPIO for
headphone detection. As such, you'll most likely end up with a different DT overlay for
each board instead of a DTB.

Also, from the experience with the IMX8 series, we really don't have many DTBs. Usually,
it's been 1 for the base board and 1 for the audio board if applicable (which can probably
be turned into DT overlays. It would certainly make more sense this way).


Given all this, I'm still not convinced that DT overlays are the way to go.

