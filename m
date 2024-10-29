Return-Path: <linux-kernel+bounces-386444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342A29B4390
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B990A1F235C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BD2202F64;
	Tue, 29 Oct 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8vBIsQj"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B196A2022EA;
	Tue, 29 Oct 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188420; cv=none; b=TC/M5uB1mA2hqXZTmw1+jtwAxdjPFIyMDlkNKQMf4c6RWlxlDYeP9UcXO4Rxx+MmRNxdaktudbM625aGQs3J2v+z5xBStElYpb1hVot1s+DAOIG9FTiYNTdJoJXBLtKV6BwiB4wzSTiKkuz2XuBunC7iWODKfgRdGxIm9CZz76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188420; c=relaxed/simple;
	bh=HOCb3f9hLfDS0KMvOMasmmI2vyK/m+oTMPg+Aa8Oy5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NEMp1G3oi7vbev1PLq28NLZmq9rqmlWeFD1qqTzV/jHxpQe3B3T7UIPkoFyMaTgnHIg7EjXL1EGaA6iyb0PnwC729V5e82b8/zirWGPbq6oYuYWFDdL9UKJR24Qvk14zf0Oz/cUNq3XQ7PaTRrupEmVo2Lco+UsqV5Kht9att7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8vBIsQj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539ee1acb86so5120957e87.0;
        Tue, 29 Oct 2024 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730188417; x=1730793217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4C1nIRdVvB18ebQ3for2XC65VIyhOskwKvhIjCaNvVI=;
        b=e8vBIsQj1mfhc/Ls+oSUMEVVWG9aXSci5JjwjKgCTjgOmAnDaqb3n2IKcWbbwskKPw
         vgsDhRUL1qCC5HGQGflWp2YHnPROP0n5dNunBZJOa/LDz8ORnK49qBWuXXgAQ9AS8Ufw
         y5shPaxB5Jy+o+lcwEnIOhSp8IIHc4KV1/nBu2ui7sPAdS1YO0wTpqzR5oEOm3GmL46G
         tWInO8i5yKe8ue0RFb0wWqD9OGYqCp2wNT51fNoOLTL+8z33g8NGDFw+ssX4q/PAcniP
         FXN/uLki99wo+hwYv0lXVOgy7nekZpaVrKIL5CusAofsC6o/kuXzQIgjaAagJ0L2q/39
         QFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730188417; x=1730793217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4C1nIRdVvB18ebQ3for2XC65VIyhOskwKvhIjCaNvVI=;
        b=SVkS84jjOFt7iv1vQth0em+iyJqlfu5rsTQPMAERpwvUi34gcy3JBfroc8ZnYNXcQF
         UzNhDPwR6Zd2UPRgbyWbC2bW/CIy5JAoGUyVho/alD3n15LG96YQfWPp/9ESi6tMh+Mi
         xcclxt1VDAwp4mf0eAGJf6P1sX9Gpyd8B05Z33dWUcoHQLLV3GDemAnfD5tc8ponIZ6B
         8Nut+x8enZnExIsT5AmBbnA7oX89VxMhAGIbNAC8wnAYf29wshJPbq1O+tOTF53qnjvE
         +TDgQOqGEO1umNOfsd6eKgattSM720tWbFO1OWNixXA3qXwNE7tCnxkXWq4wLsp1sMv4
         WgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj/Udjq/vvmmPKjRcxT+a2o5LgfG0fNMCbRX0DbAY02gy8LokyToGTbCvBhy8fJW0dXwxB6Pv1z5wn@vger.kernel.org, AJvYcCXpYNdstGsThZEJGzYl0XapAIheaLM2w3J+qrjClxesUI9zIL/Xj4Ho9WO/TPgNtazESZmKLIF8f8nywkuG@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdXH5FNBZ5lJKr+uVT8AS8gVMihziehdTcqP8hqsJgsANIuRP
	CWfcdPY6/StHD2XlRVaEoftRpHqU91/hHao7Pe/9nyHtJeF0JIdN
X-Google-Smtp-Source: AGHT+IFX3omEHoD4JMYIBlaDhHQFN4sNVOKfMjc39GiZe38I9QMTzCKzecpErYGK0y+EHQaRGeWtVg==
X-Received: by 2002:ac2:5683:0:b0:539:8fcd:51f with SMTP id 2adb3069b0e04-53b348deb3bmr5368808e87.30.1730188416343;
        Tue, 29 Oct 2024 00:53:36 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1de04bsm1296446e87.247.2024.10.29.00.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 00:53:35 -0700 (PDT)
Message-ID: <f2bb661d-8ef5-43d4-aece-c7fec01ff9fe@gmail.com>
Date: Tue, 29 Oct 2024 09:53:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: dts: imx: Add devicetree for Kobo Clara 2E
To: Andreas Kemnade <andreas@kemnade.info>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, imx@lists.linux.dev
References: <20241024142206.411336-1-andreas@kemnade.info>
 <20241024142206.411336-3-andreas@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241024142206.411336-3-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2024 17:22, Andreas Kemnade wrote:
> Adds a devicetree for the Kobo Clara 2E Ebook reader. It is based
> on boards marked with "37NB-E60K2M+4A2" or "37NB-E60K2M+4B0". It is
> equipped with an i.MX6SLL SoC.
> 
> Expected to work:
>    - Buttons
>    - Wifi
>    - Bluetooth
>      (if Wifi is initialized first, driver does not handle regulators
>       yet)
>    - LED
>    - uSD
>    - USB
>    - RTC
>    - Touchscreen
> 
> Add human-readable comments for devices without mainlined driver and
> binding. Such comments can e.g. be help to find testers if someone
> starts to work on the missing drivers.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

...

> +
> +	pmic@4b {
> +		compatible = "rohm,bd71879", "rohm,bd71828";
> +		reg = <0x4b>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_bd71828>;
> +
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> +		system-power-controller;
> +
> +		clocks = <&clks 0>;
> +		#clock-cells = <0>;
> +		clock-output-names = "bd71828-32k-out";
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-reserved-ranges = <0 1>, <2 1>;
> +
> +		rohm,charger-sense-resistor-ohms = <30000000>;

I am afraid that this one is _my_ very much terrible brainfart. Yeah, 
pile up the stones and start casting ;)

I am fairly sure the sense resistor is 30 mOhm (0,030 Ohm), not 30 MOhm 
(30 000 000 Ohm). (And I am the one who misinterpreted the M in some 
email/data-sheet in the past - and never questioned the sanity).

In short, AFAICS the sense resistor is added "in series" to the system 
load. Eg:

           --------
       ---| Rsense |-----
      |    --------      |
  ---------           -------
| VSupply |         | Rload |
  ---------           -------
      |                  |
       ------------------

Hence, by measuring the voltage drop on the Rsense gives us the current 
flowing through the system ( good old U = RI ).

I believe having 30 Mohm (30 000 000 Ohm) resistor there would not make 
much of sense... With a Fermi estimate that the system works with 
voltage magnitude of 1V and current magnitude of 1A and then applying 
good old P = UI and U = RI would give us wonderful results :) Quite a 
battery on poor Kobo, right? You'd better to not touch the battery 
termninals ;) Oh, and looking the driver code I've written for handling 
this property... Sometimes I really don't like mirrors :)

Well, now that I got this out - I suppose this could be
rohm,charger-sense-resistor-milli-ohms = <30>;
or
rohm,charger-sense-resistor-micro-ohms = <30000>;

I further guess there is no upstreamn binding doc for this property. I 
think there is also no upstream charger driver for the BD71828/BD71879 - 
only an early RFC and some downstream mess - but stil it'd be nice to 
have the property in place as the size of the sense resistor is needed 
when converting coulomb counter register values to current.


Yours,
	-- Matti


