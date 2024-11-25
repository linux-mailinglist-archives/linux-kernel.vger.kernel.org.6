Return-Path: <linux-kernel+bounces-421352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD59D8A83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D83B2F9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2141C1B4136;
	Mon, 25 Nov 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTHwYXF2"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F61B412E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551142; cv=none; b=DmZzL4pUIcH+fTgTLlnF3BmoX8+YXbISNt/UUdn8SyXRFwgleiKAId/YBF52bx/fX4wNr0AwkhLXOR7RSsX3RTL+FBNJtOBTV8hEDRz7+GUurf5ONis705pzNeCcIHd5ZjqmP3WcthgeHpeejzwLv0Mi9+69v+YK8ltKFV+4S3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551142; c=relaxed/simple;
	bh=vxAP4GFIepgJNHz+fQvS0YIIG2Ymh4S7ejVPX9wigo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O06ANTXL84suaL2MkaXplVAMf3peqldfYTXB8EnVDP8URuc2XcoSuHtgbRQlQ+PHiLsyR4jmd+459uwTO/e2HILUyf/zeCbYR56aOKhdHeNqnPXLk1wl3qihsel+NQIsJ89tBO93qts8ufoWmYCU8yz7dtiVD9srB68CPx80zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTHwYXF2; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so5231320e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732551139; x=1733155939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw321NaS6TFeLiwFEJugD6+ze9ed51yxaQsv+2sqRFo=;
        b=mTHwYXF2wP6vssquM7cWNaDGXPqpHY1NcylmdoeOImW3Sf1SlgG803dTRV4molkn6R
         fhDuTg65CK74lT4/+ZU7i1hzwZDgWrqv3RtbqtXiy1R6NO+T7dc8riT4WICWFK5Ek1oh
         mRHwoEiw009q9+iebfTQLpbJ7QuPDVKqo7DVVdShZ3EYz8n3Su6b2bLjYb9bp2zLRKGG
         smX6NwuX3bcsRLm1ZHcDXkmPYPRwSd3gDssr8KFiAc54VbYbbZd/ks0x4pPylB03OIm7
         8HbTz26YtYMlTefiiopja5BDvr6o1w5LkfFsAihlPeO4gughxGEC41T+z9Nmjm5zH0I/
         0KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732551139; x=1733155939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw321NaS6TFeLiwFEJugD6+ze9ed51yxaQsv+2sqRFo=;
        b=ZxjSkg6idpNoCMIh6drsmcV2O+B3usUxgU+c68aw1s9V7chT5kzFxzGNuzsMwJP0Ix
         WB45D0lTAnKS5SD8fmSJMhe370Nr8hc+RcNq7mJKvZtx/m4OqR8i/NWBt78u5a5QISis
         j+If29wIsAmmuAi828MCV+dgasKNHqAZJAfxnrO22eXsEGXdfY2GeI3d2ehFZRFV/LZu
         f98eudGuJJ21pfvCiVF6shG9zKDxQ3v3lJR/+pm40enuQwKX3pHF3TW+vv3+OJq1kwTb
         GooSqufE2rGWTcTxfVl+mHD263pxm7fUWZdHX7YQqbTcqXgVcVP9NfQ4fsD8L7PQF7PR
         +LcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKQvqsE4/D/dkezmZT2JFJvNbNkXwTyoRw9V33vH3tX2+4iW2xLzRQtcCJqBwZZ4gRwEkMcL2bQPt6yOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKAL35mBTE1pVCCwlQjX8vujLBeG9CcPb1Jsma3I/tPZ93jI9u
	ueqX+rZetU/shWEMDM6CjG4PwhK90QpzjNpE/nhJD/o83Kb/PujZrwZRzLAOl50=
X-Gm-Gg: ASbGncvXExUym5dGw2X8zgb3jt1CK3zy+GyOnUnw/j706ogCeZ4pjpXnPWcCdkVYDCN
	QS2bLg9e4xNxIgqeQL1ANQ8UypMsXh1YT/Lpsujco/4IZbx/0byNh7eEDJjswmUyrVDeBjhQmRu
	H8KJKrKKhk6nytZY6glNwx1wxHbmCMnGlBes3SEJo5tSx9xvz1KQ5EKimBwQ49XVvhXHurXXeY1
	UgrTenXLxQ+ZZQbE1zZXnsmDcB4dhGz8GL18/4FVezO4XoeMkusTlgI1bhkuTjW6Y3bSGF/LnZY
	+gExnLpliL8t+jg9kkiGXxRTHI14Gw==
X-Google-Smtp-Source: AGHT+IFPfB7a5nwGjr6HKgeHJL/mwlPVXqaOjY4l1GKSJmoWf81K1sAoKuhGr5xOMGSjUBo1nMjr3A==
X-Received: by 2002:a05:6512:33d6:b0:53d:dc3a:ed92 with SMTP id 2adb3069b0e04-53ddc3aeddcmr3261522e87.37.1732551138747;
        Mon, 25 Nov 2024 08:12:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24811b0sm1743109e87.162.2024.11.25.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:12:17 -0800 (PST)
Date: Mon, 25 Nov 2024 18:12:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Renjiang Han <quic_renjiang@quicinc.com>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: qcom,qcs615-venus: add support for
 video hardware
Message-ID: <kdyhkb3tt2lgfuopz7twxjwpfur6vuezaqlc7s7aozkz6ek2as@m2nvqcb5ww4u>
References: <20241125-add-venus-for-qcs615-v3-0-5a376b97a68e@quicinc.com>
 <20241125-add-venus-for-qcs615-v3-1-5a376b97a68e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125-add-venus-for-qcs615-v3-1-5a376b97a68e@quicinc.com>

On Mon, Nov 25, 2024 at 11:04:49AM +0530, Renjiang Han wrote:
> Add support for Qualcomm video acceleration hardware used for video
> stream decoding and encoding on QCOM QCS615.
> 
> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
> ---
>  .../bindings/media/qcom,qcs615-venus.yaml          | 182 +++++++++++++++++++++
>  1 file changed, 182 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,qcs615-venus.yaml b/Documentation/devicetree/bindings/media/qcom,qcs615-venus.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..7a3a01ff06d8b62bc2424a0a24857c86c6865f89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,qcs615-venus.yaml
> @@ -0,0 +1,182 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,qcs615-venus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QCS615 Venus video encode and decode accelerators
> +
> +maintainers:
> +  - Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
> +  - Vikash Garodia <quic_vgarodia@quicinc.com>
> +
> +description:
> +  The Venus IP is a video encode and decode accelerator present
> +  on Qualcomm platforms
> +
> +allOf:
> +  - $ref: qcom,venus-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,qcs615-venus

Please extend sc7180-venus.yaml instead. No need to duplicate
unnecessary things.

> +
> +  power-domains:
> +    minItems: 2
> +    maxItems: 3

So, is it 2 or 3? You don't have legacy here, so you should know an
exact number.

> +
> +  power-domain-names:
> +    minItems: 2

And this one also can go away.

> +    items:
> +      - const: venus
> +      - const: vcodec0
> +      - const: cx
> +
> +  clocks:
> +    maxItems: 5
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: iface
> +      - const: bus
> +      - const: vcodec0_core
> +      - const: vcodec0_bus
> +
> +  iommus:
> +    maxItems: 1
> +
> +  memory-region:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: video-mem
> +      - const: cpu-cfg
> +
> +  operating-points-v2: true
> +
> +  opp-table:
> +    type: object
> +
> +  video-decoder:
> +    type: object
> +
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: venus-decoder
> +
> +    required:
> +      - compatible
> +
> +  video-encoder:
> +    type: object
> +
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: venus-encoder
> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +  - power-domain-names
> +  - iommus
> +  - video-decoder
> +  - video-encoder
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,qcs615-videocc.h>
> +    #include <dt-bindings/interconnect/qcom,qcs615-rpmh.h>
> +    #include <dt-bindings/power/qcom,rpmhpd.h>
> +
> +    venus: video-codec@aa00000 {
> +        compatible = "qcom,qcs615-venus";
> +        reg = <0xaa00000 0x100000>;
> +        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> +                 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> +                 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
> +                 <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> +                 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
> +        clock-names = "core",
> +                      "iface",
> +                      "bus",
> +                      "vcodec0_core",
> +                      "vcodec0_bus";
> +
> +        power-domains = <&videocc VENUS_GDSC>,
> +                        <&videocc VCODEC0_GDSC>,
> +                        <&rpmhpd RPMHPD_CX>;
> +        power-domain-names = "venus",
> +                             "vcodec0",
> +                             "cx";
> +
> +        operating-points-v2 = <&venus_opp_table>;
> +
> +        interconnects = <&mmss_noc MASTER_VIDEO_P0 0
> +                         &mc_virt SLAVE_EBI1 0>,
> +                        <&gem_noc MASTER_APPSS_PROC 0
> +                         &config_noc SLAVE_VENUS_CFG 0>;
> +        interconnect-names = "video-mem",
> +                             "cpu-cfg";
> +
> +        iommus = <&apps_smmu 0xe40 0x20>;
> +
> +        memory-region = <&pil_video_mem>;
> +
> +        video-decoder {
> +            compatible = "venus-decoder";
> +        };
> +
> +        video-encoder {
> +            compatible = "venus-encoder";
> +        };
> +
> +        venus_opp_table: opp-table {
> +            compatible = "operating-points-v2";
> +
> +            opp-133330000 {
> +                opp-hz = /bits/ 64 <133330000>;
> +                required-opps = <&rpmhpd_opp_low_svs>;
> +            };
> +
> +            opp-240000000 {
> +                opp-hz = /bits/ 64 <240000000>;
> +                required-opps = <&rpmhpd_opp_svs>;
> +            };
> +
> +            opp-300000000 {
> +                opp-hz = /bits/ 64 <300000000>;
> +                required-opps = <&rpmhpd_opp_svs_l1>;
> +            };
> +
> +            opp-380000000 {
> +                opp-hz = /bits/ 64 <380000000>;
> +                required-opps = <&rpmhpd_opp_nom>;
> +            };
> +
> +            opp-410000000 {
> +                opp-hz = /bits/ 64 <410000000>;
> +                required-opps = <&rpmhpd_opp_turbo>;
> +            };
> +
> +            opp-460000000 {
> +                opp-hz = /bits/ 64 <460000000>;
> +                required-opps = <&rpmhpd_opp_turbo_l1>;
> +            };
> +        };
> +    };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

