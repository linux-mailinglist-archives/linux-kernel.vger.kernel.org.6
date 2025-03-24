Return-Path: <linux-kernel+bounces-574261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06550A6E2C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB43E1892061
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D87A266F07;
	Mon, 24 Mar 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sFlQQW75"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D947266EFE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842542; cv=none; b=ons6JQM43TnywHKNpAQ8NFBckfCbFtGymAAZUk8DoT74evndoPT+X+HIQ1OG+T3exSqsrCrXgCzd05h8rnfa9+Hp7ERTkuury22lw2iQcK9yb0MhXtjKl6YT2GRWgyHbfAieG1AQIMUMSZezWJ2CvjOofMGO25oqpCrsnwj7ZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842542; c=relaxed/simple;
	bh=fnUwfpQgP5nSxubyeb3rbtBfI1XlojZDKOnU1ysQ25o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A4X4flNi2dxx49jM7tBFeS2U4COfRXemYlD4eULU2CeZInGwJvqpSriHAnXC64qcoqgiV9qpUDpZ+smmYc7DZAqn3ez+DT6sgZSCyiH0h1MGpjEFcJqfrFNvqQrppA5h5x7Z2G0i6doNCKFvGC/KmCIC4gGcdVmAtpnbGl7bvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sFlQQW75; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c7b2c14455so999646fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742842539; x=1743447339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8cSKX9G+X7Klicv0ii6T0Vayugf74Hd1S+HWFAQfa0=;
        b=sFlQQW75a4UVSiZ1xaOZ3LNIWBdxaEhTiARZi8l1FXdOv/Ww/e8eozGt4v5FfDy9FG
         cTIcBDTZ0kS2hZT8hvPXbxPATuJ4XZFsLDudybppmL9Tgdv4EKU+3l9YCxELs7gmORN2
         5l7T+bf44c9nXKvnO6xgjORtfYXo6O+IahTsta8KWK4fyBetYq2eIenPVaDW7bPMNekA
         ojzz+5/v4pu1mxDlXlEa2INT4dbhA0Mwld4h+fEMVkYxygfgCt9IqQIySVO83GmMGIPV
         ut6FIOLL1SQ36xq/dKwZ3g6dNAXNvaXfZaONc2NS/ACaadTf3Y8OnFhQGTXn3/cMQ1Yr
         JBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842539; x=1743447339;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8cSKX9G+X7Klicv0ii6T0Vayugf74Hd1S+HWFAQfa0=;
        b=YMTt9Q0ErX1py9/tMa0lv+GGf6On1Orf9ezPX/1LaWtqWnhXe+p8N/c0A/UfQkTxzd
         nOIfGtSQwgFztec0r8JmI0MOQft+vcz+8uTxr/2ntHdWHk1clDXeLEnow+XBi66gaAOl
         HnwZZ38YRP1bV0G2Olu9U2nFRmp9VshQu4Tgld/eOxFOZ6vmBHbgsMbTsgmmKcIzqYNQ
         Ub8/DaUGJ99VhquJg+0T/HrSMM3Kvws4eBhFGK8HV/OHMrt+KH9a6jwjvK1QfWrbDJ8Z
         VXo1HenWYo/8t+sM4RjfLrt2TcRSuyC8+4HhIXHmtKO69Qd04sikXvEEf3HYvW8j0agN
         3jCw==
X-Forwarded-Encrypted: i=1; AJvYcCXiEBc/aYLKpOlNBSxYgyw9mSVLyihu/qemIWJWQon1Gf2Z4IE6kl3UCJsfmt/z2vAclYGzTxW6aF5YbnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaKVCrVFleb3DXbBYEbCVoJ2cR2tTeM1z5a5L3016j5KXCb0A
	bxSWjLOrRndAFdVZTiKpSa1xcCHDMi20zedRFPsmWEsd1GlknpGq5vR4WCtFu+E=
X-Gm-Gg: ASbGncupaUD3wXzUAqD6lyBMLV71uQRMphCQAJelHVaqctiD5oPNSgPHpLIIjeumqrW
	t1WefhoLbFUxTO2OqXhMkkPNgn5rdsig/gWPv8+e6GK63HPL6YDJjs7u3A3aND+WftyaSq9KiMD
	AT4lB8YToBO2qkFevpgRMcnMptroSEFHj9EIzatt3cxSRQ4NpdIcvCpCjdp4+Ea6vy0wgYoo/Dc
	fbNRmrvVzX8O3jbxoJANGnYo2V85bxvygfSkVoHj2oaRl+uJQ4+FRuRCJc8kpvfqklQ1wl6BKR4
	305kzA5w45Tqw+ONG3zfAVhMF7v/PVKB5z1X+J3CkbuUl/p3an51k1qd2HEajr8MjSy2XrnBvV8
	sTOSWLQ==
X-Google-Smtp-Source: AGHT+IEOgpjRWbUHuAnyGX6WHqizOfqn4uoM0Z/ExAuOWBNPeeoKO+dZVWDyA/Ub+w+vjZVTT47Nhw==
X-Received: by 2002:a05:6870:8089:b0:2c1:b58c:c0c with SMTP id 586e51a60fabf-2c780533179mr9623307fac.34.1742842539343;
        Mon, 24 Mar 2025 11:55:39 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0abac233sm1677280a34.1.2025.03.24.11.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 11:55:38 -0700 (PDT)
Message-ID: <cfec0b2d-cbdd-4b64-8fea-2676e7dbc1f1@baylibre.com>
Date: Mon, 24 Mar 2025 13:55:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: iio: adc: add ad7405 axi variant
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Guillaume Stols
 <gstols@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-4-pop.ioan-daniel@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250324090813.2775011-4-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/25 4:07 AM, Pop Ioan Daniel wrote:
> Add a new compatible and related bindings for the fpga-based ad7405 AXI

It's just a new compatible string. There don't seem to be any other related
bindings. So we don't need to say that in the description. 

And typically, FGPA is written in all caps.

> IP core, a variant of the generic AXI ADC IP.
> 
> The AXI AD7405 IP is a very similar HDL (fpga) variant of the generic
> AXI ADC IP, intended to control ad7405/adum770x family.

It helps the DT maintainers review if we can say specifically what the
difference is. In this case, I don't actually seen any registers that are
different from the generic AXI ADC IP block, so I'm not sure we actually need
a new compatible string in this case.

The REG_CHAN_USR_CNTRL_2 that you add in this series for the decimation rate
is documented in the generic IP block [1]. So the generic "adi,axi-adc-10.0.a"
should work. The chips that needed their own compatible have conflicting uses
for CUSTOM_CONTROL in the CNTRL_3 register, but it looks like this isn't used
for ad7405. 

[1]: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip

> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> index 4fa82dcf6fc9..1b02217ff8b5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -27,6 +27,7 @@ description: |
>        the ad7606 family.
>  
>    https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> +  https://analogdevicesinc.github.io/hdl/library/axi_ad7405/index.html
>    http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
>  
>  properties:
> @@ -34,6 +35,7 @@ properties:
>      enum:
>        - adi,axi-adc-10.0.a
>        - adi,axi-ad7606x
> +      - adi,axi-ad7405
>  
>    reg:
>      maxItems: 1


