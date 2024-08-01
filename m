Return-Path: <linux-kernel+bounces-270004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945609439E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A733284CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B115C0;
	Thu,  1 Aug 2024 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/x5EGeO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A50632
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470734; cv=none; b=ucjlLUZesicQcFbJRebWKDs02REnns7hERHYYCdhpYoDOhev0lJ86XsbrP+aWECtOhAf7BxBklGE+GWZyxkulCKDm/5GGzW7Kijh4hxPQuo6BTCeoKt5UTcEoMZwOO4um9CrTGapxilrSaLTcNd3d+FeMW75PS4vGt4GFf9nytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470734; c=relaxed/simple;
	bh=PcSwOaeBNnuWyfGJrlb4vYSUy8kUQ7LYViMOl+jJiTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0A4ilgJ5K8XD+ERi3bng+0YjNXgq6UFh5g2S3Nnd8Pa0+o8v7hTPly0FAeGlP+qd+GYZOZAsrorVu2Mt8ZtnKVy8RZbzfu9i42QI1nrzvHi0nt+rxmxVzmcAWq857VES0ygu1cWvy1RCq0nV9IfZNk51UAjPdv1r/OJQ74Aeqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/x5EGeO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ef9bc3a64so1022720e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722470730; x=1723075530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pz5xVu7GfVie1rlwMxXqazxoSkocaQmglWq8ysVH5kw=;
        b=j/x5EGeOiXwZhdQUH5kluh+sGOOhh7QJwSV5AsMl+BW2Wl1C9CBmSafoIGou+iBDzE
         aoXxgOI256Scz73spJg6nE+HleA3IjR8ONrrp/G4tUSuRyqDIjWOumgdfjsj73MgYY7g
         Z0KmjPQGPLfAg0z9EKfENbz0DdStpUN30DzMqBfyXgyg9thnfKOD1DcrGxWP54SHg4ww
         orOEUP3Rw3vs0ZGtWhWeWuH+lUDf0cZEnHzdsaJU9UEdcRCjcTRO9DRyiM1DEby/krR8
         GzNMhgYtd5m/YG4G7rnUFjq5hk/yuWuHry50qouVEc8Om+QDO/NBG2wMPZ5roNxoOY2D
         Qrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722470730; x=1723075530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pz5xVu7GfVie1rlwMxXqazxoSkocaQmglWq8ysVH5kw=;
        b=S6SCcscirokMdzSFxYTa8qm5BXFJdFykhT6VolCxK1v0h3lGkdYl4fI/fb0Wt1wHBg
         PQj1hnp0r8KGiL0gAk1RSvrWET/hIa3ivvXs70fRVwkOKpeBPE9OzO7vYUS5T2kKzBZ1
         zvI3gMmNyABMlR4CtaVTQ+/KncQU8ke4ikOYQZHpyQuD7/W4DWx2lPmk2/8VpK8ZnmTA
         +KbsyIsTJUYggjwm/6SoQseJIr9cPfQNaFc68dmeuScIBUWMHE7HugvEbVN14e+40oV9
         U0y1oG2STCQXGpfa/MaFF7E6r/hrXxSMqaIajOdLrN68PbPxRVmcfyFsmPr15SIpztzz
         4BJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4rD0qZkhoLXDtcLjXQaqNp2Vi9pFAVYvyAI43SRulFbkMBZ2ZLrjh5BUvQ1yWVTXHbKyCStv1v3fGCPXRlKSKAqrCWjP+uspjyUV
X-Gm-Message-State: AOJu0Yx2ORl5noJ7/3KPWlkPAER9gKzJO8+s3Pm3SiFAU04NqW+4g/Ol
	fOVrUnSg1AqL/oqE7g9c8phPAfcPub+x0Q0KSrZ5voYN2cMS5DB3UOh9oVuUlFc=
X-Google-Smtp-Source: AGHT+IH9kyZrP/8NIvkUJ6Vj1dhXFILyMVp4lJb40Zr9svdVbsP49+yH0RTOgbYkkV7lA+cOzDizLA==
X-Received: by 2002:a05:6512:3b06:b0:52f:4ed2:88f0 with SMTP id 2adb3069b0e04-530b61a9e14mr200959e87.2.1722470729681;
        Wed, 31 Jul 2024 17:05:29 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2bcefsm2380110e87.246.2024.07.31.17.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 17:05:29 -0700 (PDT)
Message-ID: <f4cb1082-9689-4e09-89ce-bb83b7b485ba@linaro.org>
Date: Thu, 1 Aug 2024 03:05:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
Content-Language: en-US
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Yongsheng Li <quic_yon@quicinc.com>
References: <20240709160656.31146-1-quic_depengs@quicinc.com>
 <20240709160656.31146-8-quic_depengs@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240709160656.31146-8-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 19:06, Depeng Shao wrote:
> Add bindings for qcom,sm8550-camss in order to support the camera
> subsystem for sm8550
> 
> Co-developed-by: Yongsheng Li <quic_yon@quicinc.com>
> Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> ---
>   .../bindings/media/qcom,sm8550-camss.yaml     | 545 ++++++++++++++++++
>   1 file changed, 545 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/qcom,sm8550-camss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-camss.yaml
> new file mode 100644
> index 000000000000..d002b0ff119e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8550-camss.yaml
> @@ -0,0 +1,545 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,sm8550-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM8550 Camera Subsystem (CAMSS)
> +
> +maintainers:
> +  - Depeng Shao <quic_depengs@quicinc.com>
> +
> +description: |
> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8550-camss
> +
> +  clocks:
> +    minItems: 47
> +    maxItems: 47
> +
> +  clock-names:
> +    items:
> +      - const: cam_ahb_clk
> +      - const: cam_hf_axi
> +      - const: cam_sf_axi
> +      - const: camnoc_axi
> +      - const: camnoc_axi_src
> +      - const: core_ahb
> +      - const: cpas_ahb
> +      - const: slow_ahb_src
> +      - const: csiphy0
> +      - const: csiphy0_timer
> +      - const: csiphy1
> +      - const: csiphy1_timer
> +      - const: csiphy2
> +      - const: csiphy2_timer
> +      - const: csiphy3
> +      - const: csiphy3_timer
> +      - const: csiphy4
> +      - const: csiphy4_timer
> +      - const: csiphy5
> +      - const: csiphy5_timer
> +      - const: csiphy6
> +      - const: csiphy6_timer
> +      - const: csiphy7
> +      - const: csiphy7_timer
> +      - const: csid_src
> +      - const: csid
> +      - const: csiphy_rx
> +      - const: vfe0_fast_ahb
> +      - const: vfe0_src
> +      - const: vfe0
> +      - const: cpas_vfe0
> +      - const: vfe1_fast_ahb
> +      - const: vfe1_src
> +      - const: vfe1
> +      - const: cpas_vfe2
> +      - const: vfe2_fast_ahb
> +      - const: vfe2_src
> +      - const: vfe2
> +      - const: cpas_vfe1
> +      - const: vfe_lite_ahb
> +      - const: vfe_lite_csid_src
> +      - const: vfe_lite
> +      - const: vfe_lite_cphy_rx
> +      - const: vfe_lite_csid
> +      - const: cpas_ife_lite
> +      - const: cpas_fast_ahb_clk
> +      - const: fast_ahb_src

I believe most of *_src clocks should be removed from the list above as
parent clocks with no need for own separate management.

> +
> +  interrupts:
> +    minItems: 18
> +    maxItems: 18
> +
> +  interrupt-names:
> +    items:
> +      - const: csiphy0
> +      - const: csiphy1
> +      - const: csiphy2
> +      - const: csiphy3
> +      - const: csiphy4
> +      - const: csiphy5
> +      - const: csiphy6
> +      - const: csiphy7
> +      - const: csid0
> +      - const: csid1
> +      - const: csid2
> +      - const: csid_lite0
> +      - const: csid_lite1
> +      - const: vfe0
> +      - const: vfe1
> +      - const: vfe2
> +      - const: vfe_lite0
> +      - const: vfe_lite1
> +
> +  iommus:
> +    maxItems: 1
> +
> +  interconnects:
> +    minItems: 4
> +    maxItems: 4
> +
> +  interconnect-names:
> +    items:
> +      - const: cam_ahb
> +      - const: cam_hf_0_mnoc
> +      - const: cam_sf_0_mnoc
> +      - const: cam_sf_icp_mnoc
> +
> +  power-domains:
> +    items:
> +      - description: IFE0 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: IFE1 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: IFE2 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: Titan GDSC - Titan ISP Block, Global Distributed Switch Controller.
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
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - clock-lanes
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
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - clock-lanes
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
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@3:
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
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@4:
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
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@5:
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
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +  reg:
> +    minItems: 19
> +    maxItems: 19
> +
> +  reg-names:
> +    items:
> +      - const: csiphy0
> +      - const: csiphy1
> +      - const: csiphy2
> +      - const: csiphy3
> +      - const: csiphy4
> +      - const: csiphy5
> +      - const: csiphy6
> +      - const: csiphy7
> +      - const: csid0
> +      - const: csid1
> +      - const: csid2
> +      - const: csid_lite0
> +      - const: csid_lite1
> +      - const: csid_top
> +      - const: vfe0
> +      - const: vfe1
> +      - const: vfe2
> +      - const: vfe_lite0
> +      - const: vfe_lite1
> +
> +  vdda-phy-supply:
> +    description:
> +      Phandle to a regulator supply to PHY core block.
> +
> +  vdda-pll-supply:
> +    description:
> +      Phandle to 1.2V regulator supply to PHY refclk pll block.
> +
> +required:
> +  - clock-names
> +  - clocks
> +  - compatible

I would suggest to put 'compatible', 'reg' and 'reg-names' properties as
the first ones. 'clock-names' should follow 'clocks' property in the list.

> +  - interconnects
> +  - interconnect-names
> +  - interrupts
> +  - interrupt-names
> +  - iommus
> +  - power-domains
> +  - reg
> +  - reg-names
> +  - vdda-phy-supply
> +  - vdda-pll-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,sm8550-camcc.h>
> +    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        camss: camss@ace4000 {
> +            compatible = "qcom,sm8550-camss";
> +
> +            reg = <0 0x0ace4000 0 0x2000>,
> +                  <0 0x0ace6000 0 0x2000>,
> +                  <0 0x0ace8000 0 0x2000>,
> +                  <0 0x0acea000 0 0x2000>,
> +                  <0 0x0acec000 0 0x2000>,
> +                  <0 0x0acee000 0 0x2000>,
> +                  <0 0x0acf0000 0 0x2000>,
> +                  <0 0x0acf2000 0 0x2000>,
> +                  <0 0x0acb7000 0 0xd00>,
> +                  <0 0x0acb9000 0 0xd00>,
> +                  <0 0x0acbb000 0 0xd00>,
> +                  <0 0x0acca000 0 0xa00>,
> +                  <0 0x0acce000 0 0xa00>,
> +                  <0 0x0acb6000 0 0x1000>,
> +                  <0 0x0ac62000 0 0xf000>,
> +                  <0 0x0ac71000 0 0xf000>,
> +                  <0 0x0ac80000 0 0xf000>,
> +                  <0 0x0acca000 0 0x2800>,
> +                  <0 0x0acce000 0 0x2800>;
> +            reg-names = "csiphy0",
> +                    "csiphy1",
> +                    "csiphy2",
> +                    "csiphy3",
> +                    "csiphy4",
> +                    "csiphy5",
> +                    "csiphy6",
> +                    "csiphy7",
> +                    "csid0",
> +                    "csid1",
> +                    "csid2",
> +                    "csid_lite0",
> +                    "csid_lite1",
> +                    "csid_top",
> +                    "vfe0",
> +                    "vfe1",
> +                    "vfe2",
> +                    "vfe_lite0",
> +                    "vfe_lite1";
> +
> +            vdda-phy-supply = <&vreg_l1e_0p88>;
> +            vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +            interrupts = <GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            interrupt-names = "csiphy0",
> +                    "csiphy1",
> +                    "csiphy2",
> +                    "csiphy3",
> +                    "csiphy4",
> +                    "csiphy5",
> +                    "csiphy6",
> +                    "csiphy7",
> +                    "csid0",
> +                    "csid1",
> +                    "csid2",
> +                    "csid_lite0",
> +                    "csid_lite1",
> +                    "vfe0",
> +                    "vfe1",
> +                    "vfe2",
> +                    "vfe_lite0",
> +                    "vfe_lite1";
> +
> +            power-domains = <&camcc CAM_CC_IFE_0_GDSC>,
> +                    <&camcc CAM_CC_IFE_1_GDSC>,
> +                    <&camcc CAM_CC_IFE_2_GDSC>,
> +                    <&camcc CAM_CC_TITAN_TOP_GDSC>;
> +
> +            clocks = <&gcc GCC_CAMERA_AHB_CLK>,
> +                 <&gcc GCC_CAMERA_HF_AXI_CLK>,
> +                 <&gcc GCC_CAMERA_SF_AXI_CLK>,
> +                 <&camcc CAM_CC_CAMNOC_AXI_CLK>,
> +                 <&camcc CAM_CC_CAMNOC_AXI_CLK_SRC>,
> +                 <&camcc CAM_CC_CORE_AHB_CLK>,
> +                 <&camcc CAM_CC_CPAS_AHB_CLK>,
> +                 <&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
> +                 <&camcc CAM_CC_CSIPHY0_CLK>,
> +                 <&camcc CAM_CC_CSI0PHYTIMER_CLK>,
> +                 <&camcc CAM_CC_CSIPHY1_CLK>,
> +                 <&camcc CAM_CC_CSI1PHYTIMER_CLK>,
> +                 <&camcc CAM_CC_CSIPHY2_CLK>,
> +                 <&camcc CAM_CC_CSI2PHYTIMER_CLK>,
> +                 <&camcc CAM_CC_CSIPHY3_CLK>,
> +                 <&camcc CAM_CC_CSI3PHYTIMER_CLK>,
> +                 <&camcc CAM_CC_CSIPHY4_CLK>,
> +                 <&camcc CAM_CC_CSI4PHYTIMER_CLK>,
> +                 <&camcc CAM_CC_CSIPHY5_CLK>,
> +                 <&camcc CAM_CC_CSI5PHYTIMER_CLK>,
> +                 <&camcc CAM_CC_CSIPHY6_CLK>,
> +                 <&camcc CAM_CC_CSI6PHYTIMER_CLK>,
> +                 <&camcc CAM_CC_CSIPHY7_CLK>,
> +                 <&camcc CAM_CC_CSI7PHYTIMER_CLK>,
> +                 <&camcc CAM_CC_CSID_CLK_SRC>,
> +                 <&camcc CAM_CC_CSID_CLK>,
> +                 <&camcc CAM_CC_CSID_CSIPHY_RX_CLK>,
> +                 <&camcc CAM_CC_IFE_0_FAST_AHB_CLK>,
> +                 <&camcc CAM_CC_IFE_0_CLK_SRC>,
> +                 <&camcc CAM_CC_IFE_0_CLK>,
> +                 <&camcc CAM_CC_CPAS_IFE_0_CLK>,
> +                 <&camcc CAM_CC_IFE_1_FAST_AHB_CLK>,
> +                 <&camcc CAM_CC_IFE_1_CLK_SRC>,
> +                 <&camcc CAM_CC_IFE_1_CLK>,
> +                 <&camcc CAM_CC_CPAS_IFE_1_CLK>,
> +                 <&camcc CAM_CC_IFE_2_FAST_AHB_CLK>,
> +                 <&camcc CAM_CC_IFE_2_CLK_SRC>,
> +                 <&camcc CAM_CC_IFE_2_CLK>,
> +                 <&camcc CAM_CC_CPAS_IFE_2_CLK>,
> +                 <&camcc CAM_CC_IFE_LITE_AHB_CLK>,
> +                 <&camcc CAM_CC_IFE_LITE_CSID_CLK_SRC>,
> +                 <&camcc CAM_CC_IFE_LITE_CSID_CLK>,
> +                 <&camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
> +                 <&camcc CAM_CC_IFE_LITE_CLK>,
> +                 <&camcc CAM_CC_CPAS_IFE_LITE_CLK>,
> +                 <&camcc CAM_CC_CPAS_FAST_AHB_CLK>,
> +                 <&camcc CAM_CC_FAST_AHB_CLK_SRC>;
> +
> +            clock-names = "cam_ahb_clk",
> +                      "cam_hf_axi",
> +                      "cam_sf_axi",
> +                      "camnoc_axi",
> +                      "camnoc_axi_src",
> +                      "core_ahb",
> +                      "cpas_ahb",
> +                      "slow_ahb_src",
> +                      "csiphy0",
> +                      "csiphy0_timer",
> +                      "csiphy1",
> +                      "csiphy1_timer",
> +                      "csiphy2",
> +                      "csiphy2_timer",
> +                      "csiphy3",
> +                      "csiphy3_timer",
> +                      "csiphy4",
> +                      "csiphy4_timer",
> +                      "csiphy5",
> +                      "csiphy5_timer",
> +                      "csiphy6",
> +                      "csiphy6_timer",
> +                      "csiphy7",
> +                      "csiphy7_timer",
> +                      "csid_src",
> +                      "csid",
> +                      "csiphy_rx",
> +                      "vfe0_fast_ahb",
> +                      "vfe0_src",
> +                      "vfe0",
> +                      "cpas_vfe0",
> +                      "vfe1_fast_ahb",
> +                      "vfe1_src",
> +                      "vfe1",
> +                      "cpas_vfe1",
> +                      "vfe2_fast_ahb",
> +                      "vfe2_src",
> +                      "vfe2",
> +                      "cpas_vfe2",
> +                      "vfe_lite_ahb",
> +                      "vfe_lite_csid_src",
> +                      "vfe_lite_csid",
> +                      "vfe_lite_cphy_rx",
> +                      "vfe_lite",
> +                      "cpas_ife_lite",
> +                      "cpas_fast_ahb_clk",
> +                      "fast_ahb_src";
> +
> +            iommus = <&apps_smmu 0x800 0x20>;
> +
> +            interconnects =
> +                    <&gem_noc         MASTER_APPSS_PROC          0 &config_noc SLAVE_CAMERA_CFG  0>,
> +                    <&mmss_noc        MASTER_CAMNOC_HF           0 &mc_virt SLAVE_EBI1           0>,
> +                    <&mmss_noc        MASTER_CAMNOC_SF           0 &mc_virt SLAVE_EBI1           0>,
> +                    <&mmss_noc        MASTER_CAMNOC_ICP          0 &mc_virt SLAVE_EBI1           0>;
> +            interconnect-names =
> +                    "cam_ahb",
> +                    "cam_hf_0_mnoc",
> +                    "cam_sf_0_mnoc",
> +                    "cam_sf_icp_mnoc";
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    csiphy_ep0: endpoint@0 {
> +                        reg = <0>;
> +                        clock-lanes = <7>;
> +                        data-lanes = <0 1>;
> +                        remote-endpoint = <&sensor_ep>;
> +                    };
> +                };
> +            };
> +        };
> +    };

--
Best wishes,
Vladimir

