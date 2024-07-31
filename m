Return-Path: <linux-kernel+bounces-269064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE47942D04
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19727286D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A281AD9C0;
	Wed, 31 Jul 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqAYGOpX"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1411AC43E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424433; cv=none; b=DXwl4lfOeNkZZww8UxBUpj+vRGtFm0Jrelmhdk8WnHiM2UXK92A/j23SQwovowLhtimRLTbsMg7BgMmnVsBNlhwCKcPTOr/gKTKtRvQUQriH4bOQKZi28d78FcqKn1ml2SOcP/Kzo1f4jGJWRHgGyFyEcRw7+L7rUnm35BE/k7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424433; c=relaxed/simple;
	bh=k85fIEDQsiqzt/RqUNSYKo+/sV4yzirvaADWzzxO5Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGh36IuaNUcP0MgrISS8QDqQwU6DDZRonhkW2dz+oQEJ5+INa4FIAkyPz+XEj4oN4xHqNS9faApfyTEPuprD5nHtE7CG0ScOgG7z9qkaxGwo9NAiUXxMPjejNAmuZH2TOj/XkufhwmEC5VwvGb0r0GwbulhCJChFJLPSSXjQwSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IqAYGOpX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a83a968ddso783013766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722424430; x=1723029230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlLQXU1YYTz38Qbe2t9ZiljMXVGAE2UwbufdyYLNy6A=;
        b=IqAYGOpXOaCP9qYaPuQM6sZhAx0eq2hFGtZGAvbBxp4mTSrxH7dEK8BFcbpvoKF26Y
         ecwVwtnEfDDh5Gl+X1GdEvLxmHvO8EoqPH6TdWAbJymnb2S/87eO2RAQ8GQbbPT5aigT
         YJ29Hd9nZtypqv85TEA5IM6Y89PuSnM1FBgWJlLPeX1maTJ8CYjRN4/TqB+CZMQP/wM3
         xCBlYIB7MJlq2pNbmGwFFTOIcjzdKbs9fX8yTJI5I5m9BzAJqIrsozWnG1ftS259vGdz
         RaVbyrRV1JzpBPjs3Qx+cX+R+Ev7VFHyXQzMPnAAavdjDl8yD/rDhnV0tfdHjodAn3dI
         sbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722424430; x=1723029230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlLQXU1YYTz38Qbe2t9ZiljMXVGAE2UwbufdyYLNy6A=;
        b=dyBNYgc2m9LLNCIkazujmpxiV44JJ2GWn1ANj9QNPQ5BLv3yCKrSefHifJV6SSyIj1
         /Sqss7JDM52eL116AqSroTklJ23ZWOEs8+Zb6Uci7VjxUplN5DjHaYZHJRff/kIerDPl
         dOfSQeJayzBGiXIlPKxMHsXVgH87Qz/dpJxLBg+xfEXMIOlLh/+3J5pN/CgcPzkwcW7C
         prVLroI0MErXmyg5g+4ymJ1EF1EinJkShxeCp7pSuO1XlTKNbl2RNyFBWJ3noJFJAf82
         4NaA+bOkhzZPyOryS4xRRtQgO5U7qsrKAoS6YFccn9fjA4OZRiR698Gj9XwdKY49LzBN
         n5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVgroAQS/fqIvqTq9rYDBQYkzuQEKnRk4HEOA8jB2FflnCxOYm+VucM6KUqpdktVyJ3OTIPKqBO/gdBOns6gX22QMS5JBFMTmqdKxoF
X-Gm-Message-State: AOJu0Yxvz1Byu3TTC6zS7cCWX0DCNx4KluhafKMe9Tm+WUIQsJ1lRDuz
	dWHTCBnoTvkAwe03OgrsjgEOqPV8uX4LOWHzJmWV09fECTDOUe8fkfMl3QlGM3Y=
X-Google-Smtp-Source: AGHT+IHGjJTeTxJqEgwE71cEFYOEfZQxduOvoGQx3kI/0iNz9R/KYl4BEutWT+YryytsPXhOaeT02g==
X-Received: by 2002:a17:907:7205:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a7d40129016mr1005259366b.43.1722424429589;
        Wed, 31 Jul 2024 04:13:49 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9819sm752741466b.205.2024.07.31.04.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 04:13:49 -0700 (PDT)
Message-ID: <023d4ea8-635d-435f-bae2-87284f70123b@linaro.org>
Date: Wed, 31 Jul 2024 13:13:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Enable EUD on Qualcomm sm8450 SoC
To: Elson Roy Serrao <quic_eserrao@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240730222439.3469-1-quic_eserrao@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240730222439.3469-1-quic_eserrao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 31/07/2024 00:24, Elson Roy Serrao wrote:
> The Embedded USB Debugger (EUD) is a mini High-Speed USB on-chip hub to
> support the USB-based debug and trace capabilities on Qualcomm devices.
> The current implementation lacks in below aspects that are needed for
> proper EUD functionality.
> 
> 1.) HS-Phy control: EUD being a HS hub needs HS-Phy support for it's
>      operation. Hence EUD module should enable/disable HS-phy
>      accordingly.
> 	
> 2.) Proper routing of USB role switch notifications: EUD hub is physically
>      present in between the USB connector and the USB controller. So the
>      usb role switch notifications originating from the connector should
>      route through EUD. EUD also relies on role switch notifications to
>      communicate with the USB, regarding EUD attach/detach events.
> 
> This series aims at implementing the above aspects to enable EUD on
> Qualcomm sm8450 SoC.

Are there any plans to make this feature available for folks outside of 
Qualcomm / an NDA?

There is an openOCD fork on CodeLinaro but it still requires some 
proprietary library which is only available to folks with a quicinc 
email as I understand it.

Kind regards,

~ someone eager for JTAG access
> 
> Elson Roy Serrao (8):
>    dt-bindings: soc: qcom: eud: Add phy related bindings
>    dt-bindings: soc: qcom: eud: Add usb role switch property
>    dt-bindings: soc: qcom: eud: Add compatible for sm8450
>    arm64: dts: qcom: sm8450: Add EUD node
>    arm64: dts: qcom: Enable EUD on sm8450 hdk
>    usb: misc: eud: Add High-Speed Phy control for EUD operations
>    usb: misc: eud: Handle usb role switch notifications
>    usb: misc: eud: Add compatible for sm8450
> 
>   .../bindings/soc/qcom/qcom,eud.yaml           |  17 +++
>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |  15 ++-
>   arch/arm64/boot/dts/qcom/sm8450.dtsi          |  29 ++++
>   drivers/usb/misc/qcom_eud.c                   | 125 +++++++++++++++---
>   4 files changed, 164 insertions(+), 22 deletions(-)
> 

-- 
// Caleb (they/them)

