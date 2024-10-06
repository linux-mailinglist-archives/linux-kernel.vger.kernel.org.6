Return-Path: <linux-kernel+bounces-352447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A84991F5D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFC11F21D4F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF1E17CA19;
	Sun,  6 Oct 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/a9ul9Z"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0E17C99B
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228539; cv=none; b=feaiCJWYdUeIBLh5tTEhLfzct1KrpDPI/az5PenRZnfoo99vz60YyCgMK/HXLbt6iD/gOFkNPTqowIC+dy5Ci86WsjkZ36PUtDi64XIrlyC/abxsNxA/Wq1Fz13LGMhf6I5vP3Ie4rqeRADt1fMJwYZACn5z4L1FEN8xLUjxq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228539; c=relaxed/simple;
	bh=Nx3HWT2Zr7VmN+DjiFf8rjZsEQjnvNf09OHEoSGc59Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swwakWZizcLzlo6CmfhlR3Gblqii9OZNSX/XtU5BP1fLVuDl3zhaZ7Gg3e5viK1tTyJpAQodvJrst3BKTYxX3Ttmg/jH6GzbwPd/gL4akqAPIIvfp2gzXlSSdpPv15ZoaGAhvnoEHglNGGL5c1pAhIvY3W7pbGezbTuTcDIPym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K/a9ul9Z; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fad75b46a3so32783281fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728228536; x=1728833336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ThlZWj7Dx9fwP3BeAQPiHzm2d1SypJQ5DEsbdDuRU2s=;
        b=K/a9ul9ZfIv/qyRl6AZIdsvtbuogYXHbNwv5bjUI0OkAh6WIxJXZ8DAgCWHeFLqOmq
         XGTRexSG4Qf30TiiCxTxkP7OoPMvLpJ2HOwNrmAFVradi9UBBIGSaAnJn5+I6ieaoto7
         5/jTgzRxIZr8xO9RoeTz6aJ+GR3TMIal272t+/OZ+Zx02kCR4VMIl1gAr9+AnzNK7bGk
         /s6zrnmZzaKyLnhNI4e9ydsUhgoVOCenTHIpTE5ZvQ3bx1NypcKNG0WJVOrBHZiLoJfH
         WvQ97BeuYBvks2kMyPUt3xcWg2respsWNv5eWsO1Ft30vnm2mJlVnVC24kP5grnbKYCO
         2aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728228536; x=1728833336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThlZWj7Dx9fwP3BeAQPiHzm2d1SypJQ5DEsbdDuRU2s=;
        b=Ym/HVjRtv74jFEXxUrVQJXXQ3rAujpkVOe7hmLxupzaz7Yn7uARxbsTEFjQe9VJj7q
         zOVqyBBk6sbSF0X2M7ivne59HlIAI3kMAZAwbvLbZdNRMx8i4eGTTRt49jfZDa2RrUa0
         bgsWtR+qq9p9kQT2MOgcxaqvOsI/bHT+rvLWvjSc1m9o6j5QdP1XwJ49EX+7xgglx+0B
         lkQjBLpr7+R4cJBTlNsbhRu+mBZyjvct7JetyNAW/AeVvUN8toTBjOqvvctpfMrADCkL
         lrQTWu38/tH9mO6uf73CbW6FhROzFkm5Wuz6cv3vSqbzea1RmRAxHrVYbFgELF4oQLwh
         N3dg==
X-Forwarded-Encrypted: i=1; AJvYcCWwg6KpmE+xQ5g9KygBwyppGrnZDBANR6iCkUvAJXb6lToZcoRxIhEm8dTycw+DmpFI4gYeASTRB8QIPsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMIebD1TN2BRRC+LKAQoY8KbS4xi1RwRfB5M9HtKknPvMRzcZK
	x9pf9YxHiwA7aYWg8MqATL9YHdmuiUqVYDLYMlZwr9erIzMpl20GqLrjVtZINk+3efDK+hPNGqH
	GwHrLGtFD
X-Google-Smtp-Source: AGHT+IEJ8wxuoS6Go6cFGbv5TTVaMKmUAiBI7qUeJwG6vs5acx5f9vVLKLFZQLz0o4NTGs6UYlInUA==
X-Received: by 2002:a05:651c:220d:b0:2fa:d84a:bd93 with SMTP id 38308e7fff4ca-2faf3c6635fmr39135041fa.32.1728228535812;
        Sun, 06 Oct 2024 08:28:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9b3ace7sm5526791fa.132.2024.10.06.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 08:28:54 -0700 (PDT)
Date: Sun, 6 Oct 2024 18:28:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Johan Hovold <johan@kernel.org>, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add Parade PS8830 Type-C
 retimer bindings
Message-ID: <657a2qb727tm5ndz2wokxb5aiyqysppufm7evtwfbplu34yzmp@mlm4k775zm7a>
References: <20241004-x1e80100-ps8830-v2-0-5cd8008c8c40@linaro.org>
 <20241004-x1e80100-ps8830-v2-1-5cd8008c8c40@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-x1e80100-ps8830-v2-1-5cd8008c8c40@linaro.org>

On Fri, Oct 04, 2024 at 04:57:37PM GMT, Abel Vesa wrote:
> Document bindings for the Parade PS8830 Type-C retimer. This retimer is
> currently found on all boards featuring Qualcomm Snapdragon X Elite SoCs
> and it is needed to provide altmode muxing between DP and USB, but also
> connector orientation handling between.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/usb/parade,ps8830.yaml     | 129 +++++++++++++++++++++
>  1 file changed, 129 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/parade,ps8830.yaml b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f6721d6eee26c6d4590a12c19791b3d47a8145f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/parade,ps8830.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Parade PS8830 USB and DisplayPort Retimer
> +
> +maintainers:
> +  - Abel Vesa <abel.vesa@linaro.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - parade,ps8830
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: XO Clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: power supply (1.07V)
> +
> +  vdd33-supply:
> +    description: power supply (3.3V)
> +
> +  vdd33-cap-supply:
> +    description: power supply (3.3V)
> +
> +  vddar-supply:
> +    description: power supply (1.07V)
> +
> +  vddat-supply:
> +    description: power supply (1.07V)

Any additional details?

> +
> +  vddio-supply:
> +    description: power supply (1.2V or 1.8V)
> +
> +  orientation-switch: true
> +  retimer-switch: true
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Super Speed (SS) Output endpoint to the Type-C connector
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: Super Speed (SS) Input endpoint from the Super-Speed PHY

or from another SS signal source, which can be a mux, a switch or
anything else. I'd say, just 'Input Super Speed (SS)'

> +        unevaluatedProperties: false
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Sideband Use (SBU) AUX lines endpoint to the Type-C connector for the purpose of
> +          handling altmode muxing and orientation switching.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: usb-switch.yaml#
> +
> +additionalProperties: false
> +

-- 
With best wishes
Dmitry

