Return-Path: <linux-kernel+bounces-386840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556ED9B4881
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89252B21E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F22205152;
	Tue, 29 Oct 2024 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYCHcQwh"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBA1EF0B7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202278; cv=none; b=kDKjMJoOLPrCWqLrkRBHBmiKTGh6dniu1iq/naxRx3R7cuIJE7d44J1x5bHOYoTCNEqrmDx8uZiULmBYsmyGY6B6C1ciWKecPumse9+1wL0+3wITRRepN1i5KbFqMHSFX2bS+xSnkXUvJaSYx/pLDtc48TrYeuoK+gqPFIg73eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202278; c=relaxed/simple;
	bh=IbFFAMrJLvQo30z8pg2rsKB+1kTjDx71ERRrbeqnS4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1vLEl5Fs8prMCbkNpngaEqdsCmD20Ax6womCnVYRvuvlkkuGtq+TLfmnHF5igpXnItDF8m6WsrcNxFM9l9ljaKcd9fIx+cPJmD3jeZ/Is9+bw13/Ex//PNCF9ryHPbLPM1qaci56jJa620s5fzLBu26HCXkH8YQnj4OlGPDPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iYCHcQwh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37f52925fc8so3782096f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730202275; x=1730807075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOPyb6ao0PrywvVpk663yQrTNB+Ud3N7OoWXzltTzAA=;
        b=iYCHcQwhZRMUqGeS4a0rwPs51UjwTPPXi/vtlr3Zwb/cP7tH7fDjCHXHkMrcvpDAh2
         nU4IqjsZ0Du3+v3Ypu1fxl6SWroii7ZuJ9ibg+eZ7gttACDrODne4EMu5+gL4hRUTATX
         7l2sApxP+glQowO1ddCy+okxZJGfetrWSTKvMueumkH2LEzE310L/YyCHQNbrwOOIvNT
         7uFqy4uTwnizndCrl3mx5ta0Du0kMvSuCvo0VafdNz4BccDF7TQEhFX5khLM3WFfpbnR
         regW58XH3OkSJOEt5HK/I1eUdZ1de9XG9naS/FGtQ7c9ut1DgaOlhauJK/9aSRiJICw9
         KVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202275; x=1730807075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOPyb6ao0PrywvVpk663yQrTNB+Ud3N7OoWXzltTzAA=;
        b=qaDpK6ciwiMNNn0SpXoDUZpVYlhIflmCE57uZu3j6U6iIGKMOJJ0bW4NU7uMIQM83j
         N+PUc9WSYoZb2NmuZl4PIrNun+qHmecbVvHh7/yfbh2Eo4cCbvMh/IhwNxf3PkJ/ZKgv
         Hc5Odc8/Q/9lOH6lrUKFdvtK+HJzrFcwduMqFbgsm+uLIesbK559ae2bb4pH3H+AHqe6
         qAm9ECaMIpRBt11PVT+TaDAW9bwRkObxHB6pqKL2ylbCKRyianxjB12pyNa1rj0PT9Ez
         GZO7Ho8B1G/90OofQkvTkFjHIbDfDq78n2dzNXo+xzElxbvzw6Rrmixx3dK93XpGQpET
         tDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz4ncr8P8cpkwmmMuCrj3DcJwSOIYvLfQ8KVHAynsjXiue4QyZBs0wdTTXDpZ6vx0XbuB9FkrFGbvmmoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ4DFTeKzVkbO9V9muw4Qy2zokyjNCf3ERmYelrA5tQNyz8Td8
	nlnEuoHjcD9PgHn/XMhJZrG7yRlVGbPfs5rDPzBEcvobLkrLehiZswuxhHeXpZU=
X-Google-Smtp-Source: AGHT+IFTVPyBGSXq9K2Nq09/FKNYPZ18sFTxehy1VXDZBkWB4o7hGA4nBmflTyiICeW8PB0fl6xL+w==
X-Received: by 2002:adf:e7d0:0:b0:37d:3f5c:5a9f with SMTP id ffacd0b85a97d-380611e721emr8367401f8f.36.1730202274948;
        Tue, 29 Oct 2024 04:44:34 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b712cbsm12334168f8f.77.2024.10.29.04.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 04:44:34 -0700 (PDT)
Message-ID: <c32439a5-4230-4ca5-8d46-fb00d25072e5@linaro.org>
Date: Tue, 29 Oct 2024 11:44:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: media: i2c: Add bindings for OX05B1S
 sensor driver
To: Mirela Rabulea <mirela.rabulea@nxp.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, hverkuil-cisco@xs4all.nl,
 laurent.pinchart+renesas@ideasonboard.com, laurentiu.palcu@nxp.com,
 robert.chiras@nxp.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 LnxRevLi@nxp.com, kieran.bingham@ideasonboard.com, hdegoede@redhat.com,
 dave.stevenson@raspberrypi.com, mike.rudenko@gmail.com,
 alain.volmat@foss.st.com, julien.vuillaumier@nxp.com, alice.yuan@nxp.com
References: <20241028190628.257249-1-mirela.rabulea@nxp.com>
 <20241028190628.257249-2-mirela.rabulea@nxp.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241028190628.257249-2-mirela.rabulea@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2024 19:06, Mirela Rabulea wrote:
> Add bindings for OX05B1S sensor driver
> 
> Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> ---
>   .../bindings/media/i2c/ovti,ox05b1s.yaml      | 109 ++++++++++++++++++
>   1 file changed, 109 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ox05b1s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ox05b1s.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ox05b1s.yaml
> new file mode 100644
> index 000000000000..d47e1950f24d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ox05b1s.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2024, NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ox05b1s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Omnivision OX05B1S Image Sensor
> +
> +maintainers:
> +  - Mirela Rabulea <mirela.rabulea@nxp.com>
> +
> +description: |-
> +  The Omnivision OX05B1S is a 1/2.5-Inch CMOS image sensor with an active array size
> +  of 2592 x 1944. It is programmable through I2C interface.
> +  The sensor output is available via CSI-2 serial data output.
> +

You should add

+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ovti,ox05b1s
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    description: Input clock (24 MHz)
> +    items:
> +      - const: csi_mclk
> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    maxItems: 1
> +
> +  assigned-clock-rates:
> +    maxItems: 1
> +

assigned-clock* should be dropped.

https://lore.kernel.org/all/20241025-b4-linux-next-202041004-i2c-media-yaml-fixes-v2-1-1b4535174a5a@linaro.org/

> +
> +  orientation: true
> +  rotation: true

I think you can drop both of these too.

> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +    description: MIPI CSI-2 transmitter port
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            anyOf:
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4
> +        required:
> +          - data-lanes
> +
> +    required:
> +      - endpoint
> +
> +required:
> +  - compatible
> +  - reg
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ox05b1s: ox05b1s@36 {
> +            compatible = "ovti,ox05b1s";
> +            reg = <0x36>;
> +            reset-gpios = <&i2c3_gpio_expander_20 2 GPIO_ACTIVE_LOW>;
> +            orientation = <2>;
> +            rotation = <0>;
> +            status = "okay";

You should include assigned-clock* here in the example.

> +
> +            port {
> +                ox05b1s_mipi_0_ep: endpoint {
> +                    remote-endpoint = <&mipi_csi0_ep>;
> +                    data-lanes = <1 2 3 4>;
> +                };
> +            };
> +        };
> +    };
> +...

---
bod

