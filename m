Return-Path: <linux-kernel+bounces-564307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801D0A65276
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E27177B10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312823F43C;
	Mon, 17 Mar 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1/DiEWi"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49C54652;
	Mon, 17 Mar 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220570; cv=none; b=u2v6Y9X1duJ+D/Q1//aoYakwSHx9p4x6esvLQz3UrWngKWwTCZcqX3Ryml6bI8O/kItVs8DzuvQtvOyfcPVHx8a42eL7acD9MnHdKSrRa8ccUv8FcDFQMxYrZQPAgCNhhihI8nKIq8XHa5aC8lFrnKOwAdaakK29UzsN5HTi5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220570; c=relaxed/simple;
	bh=Zcb6qB6rMW1EA/8uw/YkkJRl4yZh3CJQZTeibQq9g1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/yuAXTU8x/z7L3U5EmSrPXNM4TDSyyLAqqMBHIujSTXRR+79ru2nhp9OO4r7E85rLp9Ej1+gIy9jVVPbPh7+TOuk2qxZR0poQYfMr1N6c/MuQfBD6t56M/yd+oCM/t7ap1b8fzVerd/awkSPv+jILpUK04+rOnETP22DOTwWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1/DiEWi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22359001f1aso32476685ad.3;
        Mon, 17 Mar 2025 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742220567; x=1742825367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=721xA3JxIplEUTUZNHGk1IO2BTumd29vEso1nVItf6s=;
        b=X1/DiEWiOIIqk4gDCBT4uaXSjk1P1xZ1SNjk7vBWg/rWflflSd3CtoTjg71y14zp4/
         fYgOkzHfSo/4XFtZEcH7e5eQXd611kR+HMKDpY8WbRgjcEUPlnWT7DAQunQwZlLOILcr
         gsAOBgN8PqlZCziGL4qcy3xm4OqXAOHWW+dhbtcL02vBO/IoJBrA4XbWzji+S7ON52AN
         Go0lmqBpFTdAbHM0yie7ad3oAr5KVHXLsBq9aLTpehni7Cp0eMtAiIsa6IMs/4wfxulN
         GL0AG09HT6yIowlXbEpPls8daO2dmuCvQMpyWdc8fjAKXfnP4cCTorwzoECB8ShladTX
         gzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220567; x=1742825367;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=721xA3JxIplEUTUZNHGk1IO2BTumd29vEso1nVItf6s=;
        b=O76EP8wSSbUBsSTwGwrVK0OsAghxdj1ZzY3C54agrA32fKNycOpAu0rjsKYaLzmYEG
         5pmtghtnsGU5P2LoOfKaXsNzv7KlQaSLydoVYrZz95QCaOfbUHkrA4oB/fydcP2tps0r
         dpnBaUwgLHgz1thDoPqVyV3Dv8vtPBsG/P8jjONtclreT/0+DFnQXz7IC5NAma0S+l7V
         23HbHNbg1w0wbvlwOylnUaxSJGY8SFTZXBa8JKieyBIelkQigwQlcLu4lc9wHyVF7dyY
         woJmsqrrV3m41lL9+nGTEHulBch5WKuSvne2t0FZdR6uqYPWkCC9m7fE1Z9oDBGjjUc2
         TAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7UsxcSqlJJS8U61gCGC36IOiCyktB+vOfqZO3PpH0/zfHyCJFGX5Mrr0h581QKQjgY5ikMXhkFXiT@vger.kernel.org, AJvYcCXSXvdgMLSfpUImz6pxMCHiFb39+fKhX/t/w8g1+2/Z3zyCQMo1uURFiUMrGFAh9oZSliTtf4ONCOHZR7PS@vger.kernel.org, AJvYcCXTWHN1aBs2q3qvFSUwrrnPr+vTIu+jJFAlooiTUlwZlS3M8NvFr6dWK2NyG3NQtOmAqKWdS6+n4Dxp@vger.kernel.org
X-Gm-Message-State: AOJu0YyaEuHlkYqMVqWFQTC9lf1gidiWYQV/sm1342SB1ddHKDlO//V9
	HVS8EijTYMHtVVXsf9UJxwXh2j5Gj3miNG4blur+MiPdWHYnLe3y
X-Gm-Gg: ASbGncsrrk6kBJpJJ9hOCzHmh7fHag19tplwWxX6HvXTiG9N1lqE6QEfb9vzADUYGcu
	vD+7GIiq/JOtjc4onT0rW3z9V1hcOpnWDGuTByNYbeyF03imo0IICIcD3tL9JhwYLncLswT91vy
	j5k584Hl5Mg0mxcdmi3iSfRCWL4UQpYlwgBAipIa1U1ttQX//a9VnXRKtdsOIPlmGeR7CbggjtZ
	DVG9LIOONMAGwUclx5OLhaPwc0jwwH3742d2WlyizZkfCxN0YPbLqwumNmvqS0QEk+M96JMfnoN
	ZcyEeD6COjP2+josTb5XC+B9NQOLd/hWfrnAHdU71qV2m9TlhV5MPX4V2htTNvztTt2RIgRwAQS
	Ab3lgzcPJiO31riKTaw==
X-Google-Smtp-Source: AGHT+IHRVGXHtJYrtQYEgDvX3SMewBMrFTi7MQLb0PuZ8wSd0MF25+YpvJHTnji9WI74SxJSM6eR2w==
X-Received: by 2002:a17:902:ce0b:b0:224:b60:3ce0 with SMTP id d9443c01a7336-225e0a1d612mr163762245ad.5.1742220567415;
        Mon, 17 Mar 2025 07:09:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688856fsm75695835ad.14.2025.03.17.07.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:09:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9a9de8bd-d864-4e29-89b2-91db8aea8ce5@roeck-us.net>
Date: Mon, 17 Mar 2025 07:09:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 2/3] reset: npcm: register npcm8xx clock auxiliary bus
 device
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 tali.perry1@gmail.com, joel@jms.id.au, venture@google.com, yuenn@google.com,
 benjaminfair@google.com, openbmc@lists.ozlabs.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240912191038.981105-1-tmaimon77@gmail.com>
 <20240912191038.981105-3-tmaimon77@gmail.com>
 <536f5393-478c-4a50-b25f-180e221ef7a3@roeck-us.net>
 <CAP6Zq1ioebnqgJB1B8AqD9UtMZRy5CDT8+_dXF_aBZEjjj_B-A@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAP6Zq1ioebnqgJB1B8AqD9UtMZRy5CDT8+_dXF_aBZEjjj_B-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomer,

On 3/17/25 03:39, Tomer Maimon wrote:
> Hi Guenter,
> 
> Yes, of course, it works in real hardware.
> The modification was made since the reset and clock share the same
> register memory region.
> 
> To enable the clock change needs to be done in the device tree as
> follows (we are planning to send these change patches soon):
> 
> diff -Naur a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> --- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> 2025-02-26 16:20:39.000000000 +0200
> +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> 2025-03-17 12:29:17.876551537 +0200
> @@ -47,19 +47,16 @@
>                  interrupt-parent = <&gic>;
>                  ranges;
> 
> -               rstc: reset-controller@f0801000 {
> +               clk: rstc: reset-controller@f0801000 {
>                          compatible = "nuvoton,npcm845-reset";
> -                       reg = <0x0 0xf0801000 0x0 0x78>;
> -                       #reset-cells = <2>;
> +                       reg = <0x0 0xf0801000 0x0 0xC4>;
>                          nuvoton,sysgcr = <&gcr>;
> -               };
> -
> -               clk: clock-controller@f0801000 {
> -                       compatible = "nuvoton,npcm845-clk";
> +                       #reset-cells = <2>;
> +                       clocks = <&refclk>;
>                          #clock-cells = <1>;
> -                       reg = <0x0 0xf0801000 0x0 0x1000>;
>                  };
> 
> +
>                  apb {
>                          #address-cells = <1>;
>                          #size-cells = <1>;
> diff -Naur a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> --- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> 2025-02-26 16:20:39.000000000 +0200
> +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> 2025-03-17 12:24:52.293171764 +0200
> @@ -19,6 +19,13 @@
>          memory@0 {
>                  reg = <0x0 0x0 0x0 0x40000000>;
>          };
> +
> +       refclk: refclk-25mhz {
> +               compatible = "fixed-clock";
> +               clock-output-names = "ref";
> +               clock-frequency = <25000000>;
> +               #clock-cells = <0>;
> +       };
>   };
> 
>   &serial0 {
> 
> Is it better to modify the reset driver with your suggestion or change
> the device tree?
> 

My assumption was that the devicetree file is correct, and that it would match
the devicetree file in the actual devices. I since noticed that the file is
widely incomplete when comparing it with the various downstream versions,
so that was obviously wrong. Also, my change seemed odd, but then I did
not know how such situations are supposed to be handled.

Also, it looks like the devicetree file needs to be changed anyway unless something
else is wrong, because booting Linux still stalls later. Presumably that is because
the reference clock is missing in the upstream devicetree file (the serial port clock
frequency is reported as 0). Given this, fixing the devicetree files seems to be the
way to go.

Thanks,
Guenter


