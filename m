Return-Path: <linux-kernel+bounces-191360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F348D0B41
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E496828207E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6815FA85;
	Mon, 27 May 2024 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQmfo1UY"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA911078F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836858; cv=none; b=fCiX79vuPObGTub8fJamK3ANkNRCGLaMXCfa6e3eZHr8aK2Ch4gFViTyzO/OBDwzVw0DvmhgKS+Iu9ydUn3sqvqe0AASljOUu/BKyWoKi0JYO1RlXubsmKFo6LVe7ZzqPhwoj8sPLJpkYZnR+Sz3q5sC4hnUs3GsHb8DQpfCzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836858; c=relaxed/simple;
	bh=tSHuEMxJouR4cSNe/6JdiZ4bbwdl6FmRIp/8udEk/vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjOJNcqgM09v/zeo/FjH6bhe/pyUBLF8/DWlNCzXIXsLCesTRAvFIdwhDu0rqr/+nepGK+wvdVknvuMjWxehoHCkCAt6ZwWsgMBpZ+cxGlsPcNZb08zouuLHta9SwVyNS2p6aNdLYpG1Evf2APjYJZ2kJfMHI2BZXl+IomdVSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQmfo1UY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e974862b00so298861fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716836855; x=1717441655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MMb8cqOGHOlYvluE+ZypX3WOvmD8Wjx3TnYK5qZF94M=;
        b=BQmfo1UYoTH5tjllwLxuw0ihQb2mGq8N4GHmMZJaT9if6hYkZRxjD2s+g7vpkmPOXb
         8lw23itcTG6NI7xeovFEZiT7BC/CoiU5+8t0uBt98NU+/yvftzoL2aEDV94SYmugCsoF
         UUapaSpo4WTsVahb6sQWaB/gOXEbd4SLQ0I286IF8uQSODlpENTmdiXxEzpoHF0H0aub
         WQmak19ERCpnWC4lHMdyjxyYCv8BPhm3X8TiTdIpdRsMU7x2OzMMFOpDTsg2FbjQEAJO
         Bo24yFpYoQzv/PCwif8aMA7ANeq1lxUbfwprTBbDxNppTVWhN840KgpAWTCLq1qMtBfT
         vxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716836855; x=1717441655;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMb8cqOGHOlYvluE+ZypX3WOvmD8Wjx3TnYK5qZF94M=;
        b=Xh6K3p0PfFJKQd7KO0cfdyu2JbHuA6BkgcntL6IGq3pRXLMmIIe3er1vkYs/sXUxZv
         3G8qeU5x/N6ZWDj/59u0l8B2muMkdfKX/mnoGWzrTLNeKEUVFEa6Tn7wYQr5dCWQYDKX
         p5y9yRm9yL8nfOyzF8oVcCklM//yFSgMjHiADhUDPfAThFu07GiNZdjEJpK+pekMFBRa
         eHwTi4gEgZEQYv9ap8nLFkrUlMQGF/KgBAo90aodkhu2fLT9Z5mJxqIaRrzxFICd22uE
         K2MY3YX/izm/nIjbzaxjWrMVtjpORmBWzmH3IPKIBhQKZ0niNKpFBC3XjIDDg5TqZhx/
         Q73A==
X-Forwarded-Encrypted: i=1; AJvYcCWstORYUmryQHdaolJ7Zdv4VGZM/WZcWMWheWszlkUaUWi2iw3iPcKn1LE8RhvZ4VGNRLyb30M5o/hAAfquQm2cfiHLIBOGYMi1m+sm
X-Gm-Message-State: AOJu0YwTBf9RTepvgR2VT4r72LWoiIgOyotYQC5zuetyIEYLXJEbWvW2
	HI4whVMKlN2GpMIyf6N4y9yj2RksUUrhr59fQgMvyPXsONj+q066KYSi5relQOw=
X-Google-Smtp-Source: AGHT+IH5U4venbl2NzsLrKNcps4t4Gp/IpeMMHzyGog1s4eLpoa67ICa5GNm24fgsm4lauKXMm34qw==
X-Received: by 2002:ac2:4a9a:0:b0:522:36f7:3660 with SMTP id 2adb3069b0e04-52965198b61mr6454265e87.36.1716836854746;
        Mon, 27 May 2024 12:07:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c987cf8sm520773066b.94.2024.05.27.12.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 12:07:34 -0700 (PDT)
Message-ID: <c4e7ea45-bd81-49c1-a461-e418a32d6122@linaro.org>
Date: Mon, 27 May 2024 21:07:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: ti, sci: Add property for
 partial-io-wakeup-sources
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240523080225.1288617-1-msp@baylibre.com>
 <20240523080225.1288617-2-msp@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240523080225.1288617-2-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/05/2024 10:02, Markus Schneider-Pargmann wrote:
> Add a property with an array of phandles to devices that have pins that
> are capable to wakeup the SoC from Partial-IO. In Partial-IO everything
> is powered off including the DDR. Only pins belonging to a couple of
> devices are active and wakeup the system on activity.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> index 7f06b1080244..c8ed0dd4fee4 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> @@ -61,6 +61,12 @@ properties:
>    mboxes:
>      minItems: 2
>  
> +  ti,partial-io-wakeup-sources:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      List of phandles to devicetree nodes that can wakeup the SoC from the
> +      Partial IO poweroff mode.

We have binding for this - wakeup-source in each device - what's wrong
with it?

Best regards,
Krzysztof


