Return-Path: <linux-kernel+bounces-555654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE274A5BAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C6717042E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14352224251;
	Tue, 11 Mar 2025 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjAJA3HS"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE11DE2A4;
	Tue, 11 Mar 2025 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681826; cv=none; b=dP4IYr/pVhTXv3vnVzQA9SHdIH9LVMx2C7zKw5/uzzhLzWp72ejK1arQypm/8ZbYIPTodDVIL4pzSL5Fz5+M010dkAmDKVNNKp2swlC+EoVcEdcv0st38lkoP7hLfUPeNaW6cuq6S01rV8RvYFt1Y5834sV1n2WhqAgqtOsiIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681826; c=relaxed/simple;
	bh=SlVTnK3vDqccU6cZFFpsWdMPhd31kMhyhL/i7QCcsvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEHCH+YpnQ7nUjU5AtFak9N11XzZXG+w4O70c7FU/oEXV/YplzS5RzQLBhd2jq3OjF56Xuv4VM+drRKdzYY3aDWsNPEsNV15lD87xpogrlMY1ZcqaogVjWz69Vltzi4wG7EVEcRKGspql/WDqHRjycXEWeFBEiOtXXKlopfIvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjAJA3HS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so339925766b.0;
        Tue, 11 Mar 2025 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741681823; x=1742286623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wBUIzbfRjL8cYbjpKbIUr1nM3k/ZT4ERi+YMbxa2AA=;
        b=CjAJA3HSlme6BdE9gcZK81tfe2Ez+al+pm9zrdtyxhJ8Q0Qowr+iAH62vT7M/Y1Fhl
         UfsSpneGbPSXhgkg1IkXuUxpgRLbaRjDTMwIBvnLd3b8VYYCdNIyTZEUbZrVIzn+Db/Z
         wHxt2YP1nkErqsBtgaAMVky2/XEt8/cxswXJTgrp6IzVV+R+BcpYG7FcXjCS3bA9Anqz
         Ebn7ruFZDFxSdBgRbZs++0rtizSLapCKQL7tlW2sDEwPqfiYok8cbTUB1rEXdIwhyk/+
         LFJv001hiuTiNeF8iFoK6qIvFOE4wSAr2w0ZD5PHGiUMae1zvmS9r7SPR5Nd+7JZF8Y+
         U7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741681823; x=1742286623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wBUIzbfRjL8cYbjpKbIUr1nM3k/ZT4ERi+YMbxa2AA=;
        b=edCbec+MzXqXFO38QB8d6XPOCTakR94zGsgD2sSU+UrDPHTI9PMmseVDMKxIzqkfAs
         iiVo4TnW/uF7H648kehKGEtEMNfv9ZxCIv+4ofh5zdisvU3JsF59ACUl8n1WioInZiFb
         ir9oWwaApz7Rjes7aGby2V4xHJzVjCl/SK1vHUuar+qRy2nCQmZTxnXLynNN8PFvNT1f
         1NOGS6u+3JpoAa5FqFSV++AfiJInWPuNoNoZi3JK+kfvCiQReZ/3G8lKyLcDrBDQ+rB6
         yNecj2knQin9J0mtwGEAOlhKcxnDnrNh+YmOjsQyW3CX0NHGvmJv7nxsLCV3N9uM8gPf
         nQXg==
X-Forwarded-Encrypted: i=1; AJvYcCUa9NXCdQaen9h7VETqErOs+wYrLdpBoA7/JDH7GsqBGtPro2JD7MYsAi+Fot+C6berbSCVDwPS3YVzuz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuQLTcwT76KGxttP/Um6fvCy92PfNWSAQ48lSZUohF3deMI9U
	PoM0KnPy6mJqtuEsF4o69fv3Bn36wXpzQkxL6DjhpqbUe7QYeiJ/
X-Gm-Gg: ASbGncsA9kztCH5/Z6/HCOxFoN9a2TF8FFwWsX2brp+p4u544Nh1ZwpcdOuzCiwl7r+
	/s9HLGSpTzvvB/jMlxEZNWmG4LrLLtuVQ2b4O569J/bjwJpdm1wKeiY/TisVUOeFNFrJXvXYulB
	XqD1OXMfYXmez7emkRxueF561lWJ4erTeuFQ8FXR1ANxAE9I4Yyub7byhVGCLtQ2DUWRbp/mGV4
	VGVWn+URDW70nf7pnByKWDF6Ym+IOaHjyMjcb4Pxr8CjZoFROvTfTlGbUow7uOvIloBY6EONNuH
	8WUBNftT0NnY3ClIyEpe+AJm7yzAkPo1DojDzFsVcP81/VU/TjAmEw==
X-Google-Smtp-Source: AGHT+IED4/BdBzDJtL90V4GvyA5vlzRx5/AdyTSCLrwu2fkiBvJHxCgGCstqtAFDn9HSo6VY65AMJw==
X-Received: by 2002:a17:907:6d08:b0:abf:742e:1fd7 with SMTP id a640c23a62f3a-ac253096a6amr2126965266b.57.1741681822638;
        Tue, 11 Mar 2025 01:30:22 -0700 (PDT)
Received: from [192.168.1.130] ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394825efsm877216566b.45.2025.03.11.01.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 01:30:22 -0700 (PDT)
Message-ID: <23c708ef-c52d-40c1-a9e8-b05555b21667@gmail.com>
Date: Tue, 11 Mar 2025 09:30:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: stm32: add initial support for
 stm32mp157-ultra-fly-sbc board
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?=
 <gradenovic@ultratronik.de>, =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?=
 <bstruempfel@ultratronik.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250310154804.326943-1-goran.radni@gmail.com>
 <20250310154804.326943-5-goran.radni@gmail.com>
 <6af3a9fe-0c0b-497d-b143-77edc12f0c1e@kernel.org>
Content-Language: en-US
From: Goran Radenovic <goran.radni@gmail.com>
In-Reply-To: <6af3a9fe-0c0b-497d-b143-77edc12f0c1e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank You for the feedback. I will fix this. I have to solve the problem 
with my e-mails in MAINTAINERS first, because I cannot use them to send 
e-mails "inline".

Best regards
Goran


On 10.03.25 17:08, Krzysztof Kozlowski wrote:
> On 10/03/2025 16:48, Goran Rađenović wrote:
>> +&gpioj {
>> +	gpio-line-names =
>> +	"", "", "", "", "", "", "", "",
>> +	"", "", "", "", "", "", "", "";
>> +};
>> +
>> +&gpiok {
>> +	gpio-line-names =
>> +	"", "", "", "", "", "", "", "",
>> +	"", "", "", "", "", "", "", "";
>> +};
>> +
>> +&gpioz {
>> +	gpio-line-names =
>> +	"", "", "", "#SPI_CS2", "", "", "", "",
>> +	"", "", "", "", "", "", "", "";
>> +};
>> +
>> +&gpu {
>> +	status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +	pinctrl-names = "default", "sleep";
>> +	pinctrl-0 = <&i2c1_ux_pins_a>;
>> +	pinctrl-1 = <&i2c1_ux_pins_sleep_a>;
>> +	i2c-scl-rising-time-ns = <100>;
>> +	i2c-scl-falling-time-ns = <7>;
>> +	status = "okay";
>> +	/delete-property/dmas;
>> +	/delete-property/dma-names;
>> +
>> +	rtc@32 {
>> +		compatible = "epson,rx8900";
>> +		reg = <0x32>;
>> +		epson,vdet-disable;
>> +		trickle-diode-disable;
>> +	};
>> +};
>> +
>> +&i2c4 {
>> +	pinctrl-names = "default", "sleep";
>> +	pinctrl-0 = <&i2c4_ux_pins_a>;
>> +	pinctrl-1 = <&i2c4_ux_pins_sleep_a>;
>> +	i2c-scl-rising-time-ns = <185>;
>> +	i2c-scl-falling-time-ns = <20>;
>> +	status = "okay";
>> +	/delete-property/dmas;
>> +	/delete-property/dma-names;
>> +
>> +	pmic: stpmic@33 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> pmic?
>
>> +		compatible = "st,stpmic1";
>> +		reg = <0x33>;
>> +		interrupts-extended = <&exti 0 IRQ_TYPE_EDGE_FALLING>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +		status = "okay";
> Does not look disabled
>
>
> ...
>
>
>> +	dac_ux_ch2_pins_a: dac_ux-ch2-0 {
> No underscores in node names.
>
>> +		pins {
>> +			pinmux = <STM32_PINMUX('A', 5, ANALOG)>;
>> +		};
>> +	};
>> +
>
>
>
> Best regards,
> Krzysztof

