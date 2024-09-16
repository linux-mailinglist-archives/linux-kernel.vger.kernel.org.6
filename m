Return-Path: <linux-kernel+bounces-330885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5924197A5AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3931C26AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EFD15ADB1;
	Mon, 16 Sep 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvsTzWos"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F7155A3C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502710; cv=none; b=BdQlLlMSLiVfzqwUryB9FOuAo7d99XUAfsJXpSuHNtiXCSU0T0MW3oZRbw35JLYyR9l75JnRNTAXQruKdRTLvADwxcgYLVcjLY6EgK1oPFSEBmqSb86AZmQQ3Zrq8F1VaFGSrjFeum4zCvzVCm5mqSD0+4zb4S9Qu+bSs9gRGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502710; c=relaxed/simple;
	bh=zixPpdyKuqV9m6GpyB+YO7Bf14JsP024FkbBSTKNP44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5nlakvokhXczBRSIgitObGBiSHsbTnkraFdFYK+CExvKF3Ync0TY1zsJdZhqHhsyZtg2WPFJy8u3E+ogkTfQs3R9tsGCH4uotCYsX0DLkX6jIxMg7kmYZEKltqF/NcVmTcFWGtKc4RF1f5MwxhnXEnM/Qj0BVLi0LGCdnmB/Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VvsTzWos; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-378e902cde8so119245f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726502707; x=1727107507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BiJHqI/Fdle6XXJtaWDnTKJvQT9GxBWgyR71PRODTyo=;
        b=VvsTzWosM9BW0Y4KcADeJ3eSz5p/lsAmfUQPFWLEhwHyewLG2kTcwQcrOLwzdNXRc8
         Q7QV7bOShrmaFhfRU5spjfWAX/S2qgQwcRkba0+wxroEIpmlMe1O8eGbl2KJkRRret+0
         edo+U75KieW6yy37Lok5qasBp9+didZ/qCEiiUByD5Wu7t/XWGArhLtuk7BAVOrXmxc2
         Pdoqz5FUa9mRF+gRD+UyiRBczJSQirV+cfbOc3BYo34VfP8OCifZ1ePaWwgF1noB7Nkd
         H59TZpPUuT9LwOhSwevih5zZiIZG+p+utJ7uSEII/L1LKQ2BYUjb8ActQi/EhGtOIUrv
         DxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726502707; x=1727107507;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiJHqI/Fdle6XXJtaWDnTKJvQT9GxBWgyR71PRODTyo=;
        b=bFtTy/iRCAh+XSw5CtDKetAWL/ER/NO+Ba7ZHVkuIb1Q+ozHva58zTiOD9dwzn/Rsi
         43of7jU8/MIHs8NsQuFYYNpyv5MbQZ7RfLEjLhTl4lpXIS2nA+aFjW/cA9VKYjwgj2rI
         tQtjxaNfBxc50AlCwFgPN8hlmPQ7M4/r/UOsABvk4F2PleUbIyK3dWBUFYlWcaEV8XmP
         wA5fqJCR86RQSecqvJ+UN3Ut3FTud/GqFXUapj0q/wHTOith5zhFB32y7eF//qrFkX/b
         dYah9o6xUdAC5kstLGW2vHLcrHORsezoLVxyqelBNFheisEUNl3oFqXtGzjgflim8iVE
         jGfA==
X-Gm-Message-State: AOJu0YxRfRpFSwDGIkQKfAaERL7iEjluflFx1dyURn5JWvt2132PorK0
	HnOKvBUYtFaYuVWo+07ZBl5U0ak3YFeCVUm45GYByeHBGHK0IgJ/oWf5nIhLt8U=
X-Google-Smtp-Source: AGHT+IHTofxDdZaPYmu9EVlvoy3KHhpEgUyPOdWNJhFxR2wvA2TB0Algt2hIHbvSAsuhCzlGMzUx9w==
X-Received: by 2002:a5d:5f87:0:b0:374:bebd:e714 with SMTP id ffacd0b85a97d-378c2cfedc0mr5752907f8f.4.1726502707090;
        Mon, 16 Sep 2024 09:05:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78054c3sm7629484f8f.105.2024.09.16.09.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 09:05:06 -0700 (PDT)
Message-ID: <ae520641-38a4-405e-89d0-e0921dfc7cff@linaro.org>
Date: Mon, 16 Sep 2024 18:05:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] dt-bindings: connector: Add property to set pd timer
 values
To: Amit Sunil Dhamne <amitsd@google.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, kyletso@google.com, rdbabiera@google.com,
 Badhri Jagan Sridharan <badhri@google.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240911000715.554184-1-amitsd@google.com>
 <20240911000715.554184-2-amitsd@google.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240911000715.554184-2-amitsd@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2024 02:07, Amit Sunil Dhamne wrote:
> This commit adds a new property "pd-timers" to enable setting of
> platform/board specific pd timer values for timers that have a range of
> acceptable values.
> 
> Cc: Badhri Jagan Sridharan <badhri@google.com>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>

Please work on mainline, not ancient tree. You cannot get my CC address
like that from mainline. It's not possible. So either you don't develop
on mainline or you don't use get_maintainers.pl/b4/patman.


> ---
>  .../bindings/connector/usb-connector.yaml     | 23 +++++++++++++++++++
>  include/dt-bindings/usb/pd.h                  |  8 +++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index fb216ce68bb3..9be4ed12f13c 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -253,6 +253,16 @@ properties:
>  
>      additionalProperties: false
>  
> +  pd-timers:
> +    description: An array of u32 integers, where an even index (i) is the timer (referenced in
> +      dt-bindings/usb/pd.h) and the odd index (i+1) is the timer value in ms (refer

timer of what? OS behavior?

> +      "Table 6-68 Time Values" of "USB Power Delivery Specification Revision 3.0, Version 1.2 " for
> +      the appropriate value). For certain timers the PD spec defines a range rather than a fixed
> +      value. The timers may need to be tuned based on the platform. This dt property allows the user

Do not describe what DT is. We all know what DT properties allow.
Instead describe how this relates to hardware or boards.

All this is wrongly wrapped. See Coding style (and I am not telling you
the value on purpose, so you will read the coding style) .

> +      to assign specific values based on the platform. If these values are not explicitly defined,
> +      TCPM will use a valid default value for such timers.

And what is the default?

> +    $ref: /schemas/types.yaml#/definitions/uint32-array

I guess you want matrix here.

> +
>  dependencies:
>    sink-vdos-v1: [ sink-vdos ]
>    sink-vdos: [ sink-vdos-v1 ]
> @@ -478,3 +488,16 @@ examples:
>              };
>          };
>      };
> +
> +  # USB-C connector with PD timers
> +  - |
> +    #include <dt-bindings/usb/pd.h>
> +    usb {
> +        connector {
> +            compatible = "usb-c-connector";
> +            label = "USB-C";
> +            pd-timers =
> +                <PD_TIMER_SINK_WAIT_CAP 600>,
> +                <PD_TIMER_CC_DEBOUNCE 170>;

Incorporate it into existing example.

> +        };
> +    };
> diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
> index e6526b138174..6c58c30f3f39 100644
> --- a/include/dt-bindings/usb/pd.h
> +++ b/include/dt-bindings/usb/pd.h
> @@ -465,4 +465,12 @@
>  	 | ((vbm) & 0x3) << 15 | (curr) << 14 | ((vbi) & 0x3f) << 7	\
>  	 | ((gi) & 0x3f) << 1 | (ct))
>  
> +/* PD Timer definitions */
> +/* tTypeCSinkWaitCap (Table 6-68 Time Values, USB PD3.1 Spec) */

Please expand this a bit, so we won't have to reach to external sources.

> +#define PD_TIMER_SINK_WAIT_CAP		0
> +/* tPSSourceOff (Table 6-68 Time Values, USB PD3.1 Spec) */
> +#define PD_TIMER_PS_SOURCE_OFF		1
> +/* tCCDebounce (Table 4-33 CC Timing, USB Type-C Cable & Connector Spec Rel2.2) */
> +#define PD_TIMER_CC_DEBOUNCE		2


Best regards,
Krzysztof


