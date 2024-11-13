Return-Path: <linux-kernel+bounces-407072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5409C6836
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F65B27754
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56D7170A31;
	Wed, 13 Nov 2024 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2mWKxeB"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A4433CE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731473248; cv=none; b=q+u0cvyxWheADmgsmpVlgJ8wCUdysBa/NU5bikVXCzH65yN22g9UNqrNSTsTQvRMqHQPWWZMA+60x+ikaieZAHrZ/H1zqPYOz1flFSfx2xeWwdG7CHmVjWV7uggxnT6zdoq+B2ag8lL89jE3s334ccUT/1M58B9K4xlqTV3eRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731473248; c=relaxed/simple;
	bh=t556vTKdcokw1QiP1v2UEOR/MdrHGHOWhS+IOQTrdfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=av4s3qKAF5BduyNjU6uAgo+6aMghx7iacErZmdobm5QcYHENMGj6w5VCnfWuorQ4FQVHM8h/cOvjyU0rMH8Vr02HSSFJOHjQW9DSwLSZpoPVphS7EpA9mCdxVHgCJKDwldr1H/t4SCYh+uj773PsUgHWglbgj/ciANut8QuwsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F2mWKxeB; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-539f4fb6312so187343e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 20:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731473244; x=1732078044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dGB3hBZMSwphMtSVShWjrDUtFJI/kLJc6Mqsr7oFuo=;
        b=F2mWKxeBqPn+acZW+R/BaVwVz5IUQWVvbU0b0kIrrx07LdbEWSJJcTuUdmw2hNt1da
         PnTG8uZ3L8gQF8gFlf08aKklFoHwrNrOCwjalk59vBzDTqv4TErtZ526vHI9ZTG6ziXs
         Iqm0746rnMFZMgb7DMVujY/TPuC8K1uOH2XBpLbUZpoQD4lMKaUMpiskFXfqxpajEr7a
         vqEqu1KJMWCbGbW2/lsVhuHHuc7BAQapbOMlmlEBStRqD5SXfNx9iLfxNO9kf38rsjyL
         W5031hQRGROXaUwhSFe7bkBRm735MZaxmC0XlD9g+U0gL8sPnrAy1E61sGtQUtHWCnm7
         QT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731473244; x=1732078044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dGB3hBZMSwphMtSVShWjrDUtFJI/kLJc6Mqsr7oFuo=;
        b=Zl5/cDSd4Z+IBij4fd1lUHpp54iLXdfZh5wh7S9ooMWlBi3sfTRX95HYjae8YShQPn
         2EDXSqN/ItnXAX8rphGg4g6dvgZ6x5CyJugXnAZu4wZ2pDnU7rjTkDFNgGPMP5E9sgUd
         ZM9ZJ6881XcWeYhzonj7Um9r4D331JAcg9tEOK8rjDRIRMprZ+UH0PhYGDExRsVH5reS
         vP2xPdPfusSMfkyIGs9fem4Zc7+vXzFedNRj8gFZTMK3sYDV7vxMFtCnXID0MZrbzDBT
         k5xwn6uSWZIu/1Bi3vWEk7ArS2r8klJfd6Uzxp/mxCLthlkhL8wtGSqqWoA3D+CD9KP1
         EGpw==
X-Forwarded-Encrypted: i=1; AJvYcCWIo2PC/Ax0yuWb9qb9cUxj12LsEZ85oCDYbzXHOweWPJNu36PeBEWf7VjAj8KlUm3g52PP3x0+8OdGOVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2M4a1vRDG40aqWgpGgWxNLOVLE+RtiWtXym7NOa6x3IIuyCq
	rrgtxnI20hwX1j9dQBXRzTWOWfgOE3FTtuFGrxKCg+4XfHS1Hbti6OOLlIyrgyA=
X-Google-Smtp-Source: AGHT+IEEne+ni1xg9vHNA01trBMnMhEavnyZbiiPuefDmFINoHhe79xWLFeYLF5t6KVJQ0Nk4NlX8w==
X-Received: by 2002:a05:6512:3c9d:b0:52f:c337:4c1f with SMTP id 2adb3069b0e04-53d8620eec5mr2715453e87.0.1731473243403;
        Tue, 12 Nov 2024 20:47:23 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9b2bsm2101348e87.173.2024.11.12.20.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 20:47:22 -0800 (PST)
Message-ID: <cf394d47-8708-4d88-a773-7af64e500e1c@linaro.org>
Date: Wed, 13 Nov 2024 06:47:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] media: dt-bindings: Add qcom,msm8953-camss
Content-Language: en-US
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241103-camss-msm8953-v4-0-48d0ec75958d@mainlining.org>
 <20241103-camss-msm8953-v4-2-48d0ec75958d@mainlining.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241103-camss-msm8953-v4-2-48d0ec75958d@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/3/24 11:45, Barnabás Czémán wrote:
> Add bindings for qcom,msm8953-camss in order to support the camera
> subsystem for MSM8953.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>   .../bindings/media/qcom,msm8953-camss.yaml         | 322 +++++++++++++++++++++
>   1 file changed, 322 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..8856fba385b1123d748199b46c5009c97700ad9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml
> @@ -0,0 +1,322 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,msm8953-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8953 Camera Subsystem (CAMSS)
> +
> +maintainers:
> +  - Barnabas Czeman <barnabas.czeman@mainlining.org>
> +
> +description:
> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms
> +
> +properties:
> +  compatible:
> +    const: qcom,msm8953-camss
> +
> +  clocks:
> +    minItems: 30
> +    maxItems: 30
> +
> +  clock-names:
> +    items:
> +      - const: ahb
> +      - const: csi0
> +      - const: csi0_ahb
> +      - const: csi0_phy
> +      - const: csi0_pix
> +      - const: csi0_rdi
> +      - const: csi1
> +      - const: csi1_ahb
> +      - const: csi1_phy
> +      - const: csi1_pix
> +      - const: csi1_rdi
> +      - const: csi2
> +      - const: csi2_ahb
> +      - const: csi2_phy
> +      - const: csi2_pix
> +      - const: csi2_rdi
> +      - const: csi_vfe0
> +      - const: csi_vfe1
> +      - const: csiphy0_timer
> +      - const: csiphy1_timer
> +      - const: csiphy2_timer
> +      - const: ispif_ahb
> +      - const: micro_ahb
> +      - const: top_ahb
> +      - const: vfe0
> +      - const: vfe0_ahb
> +      - const: vfe0_axi
> +      - const: vfe1
> +      - const: vfe1_ahb
> +      - const: vfe1_axi
> +
> +  interrupts:
> +    minItems: 9
> +    maxItems: 9
> +
> +  interrupt-names:
> +    items:
> +      - const: csid0
> +      - const: csid1
> +      - const: csid2
> +      - const: csiphy0
> +      - const: csiphy1
> +      - const: csiphy2
> +      - const: ispif
> +      - const: vfe0
> +      - const: vfe1
> +
> +  iommus:
> +    maxItems: 1
> +
> +  power-domains:
> +    items:
> +      - description: VFE0 GDSC - Video Front End, Global Distributed Switch Controller.
> +      - description: VFE1 GDSC - Video Front End, Global Distributed Switch Controller.
> +
> +  power-domain-names:
> +    items:
> +      - const: vfe0
> +      - const: vfe1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    description:
> +      CSI input ports.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                description:
> +                  An array of physical data lanes indexes.
> +                  Position of an entry determines the logical
> +                  lane number, while the value of an entry
> +                  indicates physical lane index. Lane swapping
> +                  is supported. Physical lane indexes;
> +                  0, 2, 3, 4.

Drop the rewritten description, it's given in the referenced above
video-interfaces.yaml

And that 0, 2, 3, 4 array is invalid apparently. Lane 4 is the clock lane.

> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - data-lanes
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - data-lanes
> +
> +  reg:
> +    minItems: 13
> +    maxItems: 13
> +
> +  reg-names:
> +    items:
> +      - const: csi_clk_mux
> +      - const: csid0
> +      - const: csid1
> +      - const: csid2
> +      - const: csiphy0
> +      - const: csiphy0_clk_mux
> +      - const: csiphy1
> +      - const: csiphy1_clk_mux
> +      - const: csiphy2
> +      - const: csiphy2_clk_mux
> +      - const: ispif
> +      - const: vfe0
> +      - const: vfe1
> +
> +  vdda-supply:
> +    description:
> +      Definition of the regulator used as analog power supply.

Is there such a thing as "analog power supply" in general, and
in connection to CAMSS PHY in particular?

I believe it was just wrongly copied from somewhere. Instead please
explicitly specify that it's a CAMSS CSIPHY supply and provide its
expected voltage level in the description.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - iommus
> +  - power-domains
> +  - power-domain-names
> +  - vdda-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,gcc-msm8953.h>
> +
> +    camss: camss@1b00020 {
> +        compatible = "qcom,msm8953-camss";
> +
> +        reg = <0x1b00020 0x10>,
> +              <0x1b30000 0x100>,
> +              <0x1b30400 0x100>,
> +              <0x1b30800 0x100>,
> +              <0x1b34000 0x1000>,
> +              <0x1b00030 0x4>,
> +              <0x1b35000 0x1000>,
> +              <0x1b00038 0x4>,
> +              <0x1b36000 0x1000>,
> +              <0x1b00040 0x4>,
> +              <0x1b31000 0x500>,
> +              <0x1b10000 0x1000>,
> +              <0x1b14000 0x1000>;
> +        reg-names = "csi_clk_mux",
> +                    "csid0",
> +                    "csid1",
> +                    "csid2",
> +                    "csiphy0",
> +                    "csiphy0_clk_mux",
> +                    "csiphy1",
> +                    "csiphy1_clk_mux",
> +                    "csiphy2",
> +                    "csiphy2_clk_mux",
> +                    "ispif",
> +                    "vfe0",
> +                    "vfe1";
> +
> +        clocks = <&gcc GCC_CAMSS_AHB_CLK>,
> +                 <&gcc GCC_CAMSS_CSI0_CLK>,
> +                 <&gcc GCC_CAMSS_CSI0_AHB_CLK>,
> +                 <&gcc GCC_CAMSS_CSI0PHY_CLK>,
> +                 <&gcc GCC_CAMSS_CSI0PIX_CLK>,
> +                 <&gcc GCC_CAMSS_CSI0RDI_CLK>,
> +                 <&gcc GCC_CAMSS_CSI1_CLK>,
> +                 <&gcc GCC_CAMSS_CSI1_AHB_CLK>,
> +                 <&gcc GCC_CAMSS_CSI1PHY_CLK>,
> +                 <&gcc GCC_CAMSS_CSI1PIX_CLK>,
> +                 <&gcc GCC_CAMSS_CSI1RDI_CLK>,
> +                 <&gcc GCC_CAMSS_CSI2_CLK>,
> +                 <&gcc GCC_CAMSS_CSI2_AHB_CLK>,
> +                 <&gcc GCC_CAMSS_CSI2PHY_CLK>,
> +                 <&gcc GCC_CAMSS_CSI2PIX_CLK>,
> +                 <&gcc GCC_CAMSS_CSI2RDI_CLK>,
> +                 <&gcc GCC_CAMSS_CSI_VFE0_CLK>,
> +                 <&gcc GCC_CAMSS_CSI_VFE1_CLK>,
> +                 <&gcc GCC_CAMSS_CSI0PHYTIMER_CLK>,
> +                 <&gcc GCC_CAMSS_CSI1PHYTIMER_CLK>,
> +                 <&gcc GCC_CAMSS_CSI2PHYTIMER_CLK>,
> +                 <&gcc GCC_CAMSS_ISPIF_AHB_CLK>,
> +                 <&gcc GCC_CAMSS_MICRO_AHB_CLK>,
> +                 <&gcc GCC_CAMSS_TOP_AHB_CLK>,
> +                 <&gcc GCC_CAMSS_VFE0_CLK>,
> +                 <&gcc GCC_CAMSS_VFE0_AHB_CLK>,
> +                 <&gcc GCC_CAMSS_VFE0_AXI_CLK>,
> +                 <&gcc GCC_CAMSS_VFE1_CLK>,
> +                 <&gcc GCC_CAMSS_VFE1_AHB_CLK>,
> +                 <&gcc GCC_CAMSS_VFE1_AXI_CLK>;
> +        clock-names = "ahb",
> +                      "csi0",
> +                      "csi0_ahb",
> +                      "csi0_phy",
> +                      "csi0_pix",
> +                      "csi0_rdi",
> +                      "csi1",
> +                      "csi1_ahb",
> +                      "csi1_phy",
> +                      "csi1_pix",
> +                      "csi1_rdi",
> +                      "csi2",
> +                      "csi2_ahb",
> +                      "csi2_phy",
> +                      "csi2_pix",
> +                      "csi2_rdi",
> +                      "csi_vfe0",
> +                      "csi_vfe1",
> +                      "csiphy0_timer",
> +                      "csiphy1_timer",
> +                      "csiphy2_timer",
> +                      "ispif_ahb",
> +                      "micro_ahb",
> +                      "top_ahb",
> +                      "vfe0",
> +                      "vfe0_ahb",
> +                      "vfe0_axi",
> +                      "vfe1",
> +                      "vfe1_ahb",
> +                      "vfe1_axi";
> +
> +        interrupts = <GIC_SPI 51 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 315 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 55 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "csid0",
> +                          "csid1",
> +                          "csid2",
> +                          "csiphy0",
> +                          "csiphy1",
> +                          "csiphy2",
> +                          "ispif",
> +                          "vfe0",
> +                          "vfe1";
> +
> +        iommus = <&apps_iommu 0x14>;
> +
> +        power-domains = <&gcc VFE0_GDSC>,
> +                        <&gcc VFE1_GDSC>;
> +        power-domain-names = "vfe0", "vfe1";
> +
> +        vdda-supply = <&reg_2v8>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +        };
> +    };
> 

--
Best wishes,
Vladimir

