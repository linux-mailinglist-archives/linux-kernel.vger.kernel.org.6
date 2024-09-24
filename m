Return-Path: <linux-kernel+bounces-336812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC6598412A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A9D1C2274A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9E1552FD;
	Tue, 24 Sep 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZeyUBnQW"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1891547C5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168125; cv=none; b=RnsOWuxd18wBxlHcBr0qNqJ9X34mk7AxZPeR3BnXHcexpBMx4GYvYg4wBHK8G+yJzvLiO/aIFoCP6udFxktfelFmExJ0nDvc/Spj1gGtapXob8qepHlkS+6gKqfrTSxe3P9Et9MsN7Zcev1AduylD+W0b7/TvgiyWMw2FMN6EuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168125; c=relaxed/simple;
	bh=vfWLfhZrBuhTXxwZqyDsz/aWGPN+pqLDEq5jtptwzls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pumVuZN1tCr2CzB1br6vFsh+dEWhfVXjx4PycwX89i5Yj+zKZnz02wXqhGbNp2S885KNscAIFMIElvW103AudnhXLrRW4krB7CvSBbcAp4PNxzOfMKQuBmFLFHL7fYOnRhrrKWvYdiqfwVVLTmqUomaG+aOxIW24qJ9GqfXWH9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZeyUBnQW; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so55998601fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727168122; x=1727772922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zPekBBQnYE9h1wNiBnPJ1W27ZUNg/CsS+5seicJ1+I=;
        b=ZeyUBnQW2n6TM8uKj74VXgUVheHhJ4hbRMttHerLMjvqmvM3sykh/JR+/Mzk/HCZQZ
         Hv5Jnvchi2JufoCxaki3bN4u1WJcb6VrxHHuml7soIvQKU4N+XiiPteO0Qa1gFMZi891
         jHHdJmYgwK8JtZuUIVX0dTV7mYZOhpIRH0RVAQWi+ZGp8ziSAYDinFxNgSLnL8WPLjYD
         1XHccmOPetOaLsnVpkjaDCcenRwd3QuV+eUd+MxmpaIL5oc7/Gy6D5NTF3UAVDO66R+p
         djf31bNLFBxNsoqg8MmUGAYMGQ5xKehTALbwmJ/3B22EiCl04xVLFKRCuCbTSVjd0dFz
         elzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168122; x=1727772922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zPekBBQnYE9h1wNiBnPJ1W27ZUNg/CsS+5seicJ1+I=;
        b=SK6HuodIg0YCG3LqWTns1IkEmKkRFKdV1+/HMuPi/vwimIF1P9//pjRUpi8ytFTBmm
         Fe55DVU4rs+W2sBrXSYJxKUBxA6reQmQfMoINkZQPQOW84gQgTZLpBodqEhzm01YBOdC
         xnB5ckoQMrckYenVTZckuzrLZW5oreSCWUA4rP1uDyWk9VjBQ+hb3Np3Eeo6PHZ8v61B
         /lpNE2XbmHb9xyS2nE/kwlfqbkRvRYPhIjH+VkWvdakmAFejUYiYaGdA1b03Uzz2dzsh
         Znh0JoQ7/Xc4vUW+MGyT/nDQiii/zBHFJfilWbx7ORsHAT9ICa3LdjxnZOd0LjdKnvw5
         WLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtUX8UHrHswrfH0wv74d5IDsf8bTqBhswMV/FYaLJt8Oh5Kj1t3E5LfgoPGWZCI3NLHxVgW/k6v2OFtWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKnxHSe68BrXNlOldAIQSe0e43Ld0pmsQ1wHa97knu5bHX5yy
	dIn9TzXmOKB0Yc3dqJwfAQYMVq2FfzSTWC7i6im2Po7YErMIrFYRE/g8vLt14TQ=
X-Google-Smtp-Source: AGHT+IF6kGMJj95pD29Vie/S8ZFE7+n7j8iD9RC3u4NBK76/EBw9rwODDmYNVV5BSqgST6bsdkOcKg==
X-Received: by 2002:a2e:510a:0:b0:2f6:5f0a:9cfe with SMTP id 38308e7fff4ca-2f7cb36059dmr56161761fa.30.1727168122127;
        Tue, 24 Sep 2024 01:55:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289b68fsm1458611fa.115.2024.09.24.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 01:55:20 -0700 (PDT)
Date: Tue, 24 Sep 2024 11:55:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, mripard@kernel.org, 
	kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	alexander.stein@ew.tq-group.com, sam@ravnborg.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v17 3/8] dt-bindings: display: bridge: Add Cadence
 MHDP8501
Message-ID: <w72m4bxymngdadhp4x3mxyvv4j6k3mgtoqg3tcw4p3xdmhfpmx@wbkmfj3zmwcv>
References: <cover.1727159906.git.Sandor.yu@nxp.com>
 <b2e1d26f964a03163ec7a1ba6ac8d7c88d6cb111.1727159906.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e1d26f964a03163ec7a1ba6ac8d7c88d6cb111.1727159906.git.Sandor.yu@nxp.com>

On Tue, Sep 24, 2024 at 03:36:48PM GMT, Sandor Yu wrote:
> Add bindings for Cadence MHDP8501 DisplayPort/HDMI bridge.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v16->v17:
> - Add lane-mapping property
> 
> v9->v16:
>  *No change
> 
> .../display/bridge/cdns,mhdp8501.yaml         | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> new file mode 100644
> index 0000000000000..3f79f328c7425
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8501.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MHDP8501 DP/HDMI bridge
> +
> +maintainers:
> +  - Sandor Yu <Sandor.yu@nxp.com>
> +
> +description:
> +  Cadence MHDP8501 DisplayPort/HDMI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mq-mhdp8501
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: MHDP8501 DP/HDMI APB clock.
> +
> +  phys:
> +    maxItems: 1
> +    description:
> +      phandle to the DP/HDMI PHY
> +
> +  interrupts:
> +    items:
> +      - description: Hotplug cable plugin.
> +      - description: Hotplug cable plugout.
> +
> +  interrupt-names:
> +    items:
> +      - const: plug_in
> +      - const: plug_out
> +
> +  lane-mapping:
> +    description: lane mapping for HDMI or DisplayPort interface.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input port from display controller output.
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port to DisplayPort or HDMI connector.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - interrupt-names
> +  - phys
> +  - lane-mapping
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mq-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mhdp: display-bridge@32c00000 {
> +        compatible = "fsl,imx8mq-mhdp8501";
> +        reg = <0x32c00000 0x100000>;
> +        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "plug_in", "plug_out";
> +        clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> +        phys = <&mdhp_phy>;
> +        lane-mapping = <0xe4>;

What does this value mean? The DT should be describing the hardware, not
the register values. Can it be expressed as the data-lanes property of
the corresponding port?

> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                mhdp_in: endpoint {
> +                    remote-endpoint = <&dcss_out>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +
> +                mhdp_out: endpoint {
> +                    remote-endpoint = <&dp_connector>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

