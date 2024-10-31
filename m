Return-Path: <linux-kernel+bounces-391206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3939B83D0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D791C20B57
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7F1CDA25;
	Thu, 31 Oct 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nue2FU6c"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D801CC8AF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404553; cv=none; b=nB+EX6oPQ2QnSmWGWyZzQlCL6A7nD2w8/B9op4RLElze8On5NeXnIi4lLQSuLKxw0OS19Via8ofOwbm4rRDPUx5a/1gKb7TZ17cCnHkBK/gNnrutgCn/szNK93QTRlIxBEdiP1wdorn9icFjQyqRskv07uSJjhukNAFq9PfgjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404553; c=relaxed/simple;
	bh=g5QJfhEMJiTk+WJw1cjnBMGHG1UD+VJLO39T0Dc2IJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnTBT3yb+wtcYpy9ag0U6O1vIBHk/0qOutheH+uPmCbhEaCRAgUl97vjIpm10qnLwmD9KRsz8AxNVIFDqAsPimkp8whtSccOHwT9E4OzWsA85/FvfJKo/XD4AtlB8GItaRQVZBcIhS2hRVL3UqDxk3Hixp/kCuLbZNERMjpA/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nue2FU6c; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so10150131fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730404549; x=1731009349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JfYq9s6ngpopb/HFUrI8d6+rkmKVhmoYL6XuSM5GkQ=;
        b=Nue2FU6cIaw1XLB5HqtjLrPOzvfxDuKDjJM4nNYXrnYI7iB+FMtlfYSWOp9JLJO7PH
         htw9rWNJOZ7XasfSFCyjD5lZlyBxvHnf95i/U2HMTv+as0qAEUNL8p96fsCuerrERZAv
         oDXui+p3Eqfzub2Z/FSGVgBLOCbaTrcj5phBtiUn8+5r/DrC5+u/4KG5aDUFULSw0+QA
         0u/fGMG3edZwGq/UKR979pQ8Wv5udG5GijT90hI7qfawbzc2BwqC20V6bVNrERu/AmKW
         t6Ey4IhavL3ObrcHDBzB6ow2juNFmE5thXCj6zNShaYfR43uitjIiHPh962c8BY/Q1fy
         +ABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404549; x=1731009349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JfYq9s6ngpopb/HFUrI8d6+rkmKVhmoYL6XuSM5GkQ=;
        b=OluLZK2fz4Qz0mNybSkjk3SqtPn5WGEzOzf5hEZruymVRq2l9Ao4PMCmgYfJava0E5
         KvA9yQZ5HpYVPeeEGT5vUUUC3rb6jzH88Al64aYlD5AeU3Jh6XjpJCP+oPbonjMP+/ic
         EfktacLMTHvFNOan2K2yE9UnXSAkc6pcVzVY4EBjSpnMPvkucKjkjYWYLHpRVqktI+cj
         b5Q6/xIAavvpTLtrxtHZZS2lapmGoxUeW/qn6NmZZIpZwWzBZgX1R1tRDoilvdXTV/h6
         U5wf7Skd9F7cT0lNUvSOg0fKw4cZRCEAPlp1T7Y0GvYJCiw7wVujg/WdwJzH7p3wq6sg
         wXHg==
X-Forwarded-Encrypted: i=1; AJvYcCXYyalMB/Ir0CCwLcNGy/jL0PgM2AL0pr/VB5wlty34ZvlUyjsMuhaknEhZa+chCWcLmshCGvE3Ma0lZSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxaaM8984mklKgzK+xlp/deRAIIsg+hMfuTEC2AHSBvo1Gnygg
	+pu+CqzruHiA7lDxgmmY4q+jyfolHf5hmGvpgqpyG93DdLoQ6L5opZIuMHlwkdM=
X-Google-Smtp-Source: AGHT+IFST23M4a8b1pktfQRWTCWa5bDO89YGeshcwWLCnCkXGUc3a5M1/Bok3OaH8Ct0VxyqE0z6DA==
X-Received: by 2002:a2e:b895:0:b0:2fb:5014:8eb9 with SMTP id 38308e7fff4ca-2fdec4b5a95mr24056941fa.10.1730404548868;
        Thu, 31 Oct 2024 12:55:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef5d77aasm3192261fa.47.2024.10.31.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:55:47 -0700 (PDT)
Date: Thu, 31 Oct 2024 21:55:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, mripard@kernel.org, 
	kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v18 3/8] dt-bindings: display: bridge: Add Cadence
 MHDP8501
Message-ID: <22f3pkf63uphnx3opld6ibkhptbtxqoguqgu6iswb6w4hzkxxd@pwbdwjdodcnc>
References: <cover.1730172244.git.Sandor.yu@nxp.com>
 <e11ba0cf836d6f27935f58b7987e792026ab0233.1730172244.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e11ba0cf836d6f27935f58b7987e792026ab0233.1730172244.git.Sandor.yu@nxp.com>

On Tue, Oct 29, 2024 at 02:02:11PM +0800, Sandor Yu wrote:
> Add bindings for Cadence MHDP8501 DisplayPort/HDMI bridge.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
> v17->v18:
> - remove lane-mapping and replace it with data-lanes
> - remove r-b tag as property changed.
> 
> v16->v17:
> - Add lane-mapping property
> 
> v9->v16:
>  *No change
> 
>  .../display/bridge/cdns,mhdp8501.yaml         | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> new file mode 100644
> index 0000000000000..e4b900ecf1ac9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> @@ -0,0 +1,112 @@
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
> +  data-lanes:
> +    $ref: /schemas/media/video-interfaces.yaml#/properties/data-lanes
> +    minItems: 4
> +    maxItems: 4
> +    description: Lane reordering for HDMI or DisplayPort interface.

So, HDMI or DP port? I don't think the format is actually the same, so
it is either-or.

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
> +  - data-lanes
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
> +        data-lanes = <1 2 3 4>;

0 1 2 3

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

