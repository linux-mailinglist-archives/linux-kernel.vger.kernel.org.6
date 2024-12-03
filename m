Return-Path: <linux-kernel+bounces-429577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4E9E1E12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C74E162398
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75D71F1315;
	Tue,  3 Dec 2024 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpNk56ja"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9111F12F6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233421; cv=none; b=SCHqUSA+nOqG0nFVWu29T/AGzFLcdGhEc2wnAY/DDYSeVI12r/XX55m4TjW18ldxXHz3CA8WtsJoVLjq9GOTsMFMJPaOmv0gK3Bi0Zd0VaU1RgU0wHQn0HHrNxBGg0VSgL/D64I7x5G091rmsSH/aG5ThJ9thsUvNhbA5s95XCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233421; c=relaxed/simple;
	bh=F6JTPbaZ0AnfReoQLyIReQvRzUqbdKV8lK42/skKSls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiYbYQGN+Ju4qgnXskXADbRe0s9bWqfzdm11y1TRmhPnZ2JsubFhwFVUnCtGzdkd82X/VQn9O6SPhTGSIh4My7+Sb9Aao5I8ug4RBTy1ljsmnfcQb4P/wg0ACmjn3vXn/UTIihZK2x77RMxIiVtduYtI4VFdiHnTScAoo5iRz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DpNk56ja; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de771c5ebso6519094e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733233418; x=1733838218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BexXqu1YANquKbhWrZTOr7m0R8hKt1AEONAGEhu8ML8=;
        b=DpNk56jauH1VgV1EFVhyi8NKrDtLYmWxaJ1llpxq5Bz1lbg4x+hD+gWz6VwoSo/Q8i
         uzqYgEZz84KA55k7CJ4VTo4rJa2Ygj73OuC5jC5aRqy9v0woVUAZvJsYNaOCIfp+pCRx
         jdhk7rtbwzEEMrRIGr/SHPejX6dvaV9d5MWwKkk8MRE5hxX8e3ps5XqBYfZ9+Dxjbijj
         loIHr3/4SBZLZ8odYI6MSX2vdSMaQedhiCfKx9DEqU0MsWokPerJaETqSSVWxJMShkv3
         64NEqei5qVdCXS87Lw5tcdLwoOq5vGwnCye/NSv9y4xlrTt1mepDxXRu3RjOeRTJYYOF
         tglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233418; x=1733838218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BexXqu1YANquKbhWrZTOr7m0R8hKt1AEONAGEhu8ML8=;
        b=OiIuvDQWOcvkxFxN9zlGeNVexBp0GlYh7msGmQ0ps+heGoUB6gQNQcp8/0nroR4khq
         0Jnmiv3KxWHaBRS0jM3bIxCGuH1deX8HkZ8E/grOvU6zWR68DHqgOofFg52Ix2TWxEQS
         wi49W46vf+AO4WUxp7o2cYiv3IBE/VqoHsurVgi1tUKDTdHg/dRtxqZv3BmerFEkNBub
         DGhUbn8rb0vKVC2sgp8/UtORzyD/wcYcS1CdBNSr/11JdMFZwrHyCW5fgBNQERaZ7Fpf
         L267fA5bgEFQWEZRsSpdKzPCYEoeSWGmD1kUNTrQsKXgDwwtZbu39E+DJI9uveAXq5XW
         X0bA==
X-Forwarded-Encrypted: i=1; AJvYcCXJFvmPMr1lIwPLVgn1E+ABlOVI1bEL7a6HyQ1388th9mZp1bjzO94tvpU2BYEcEAOBHYaxHuVJyF5Yf9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Jt/hHtUtCfSgNLUf/ORCJCnxtrooqMGpGQ/9V5vgDzqSuexz
	qt2Y1T5Kp/p9wVCu+gABjoeKvwRMzttZmNT8gTh4lbSNCQkbzB4vevAoZ0j3y+g=
X-Gm-Gg: ASbGncvxhriTRp/MrcRofWVkr+qYW6HE9D/NcxS7wKDptRcf7351fXuJBMZiYUw2PcU
	VHrXYMnJzOyFSLW/s8g/HD2v3WRLQORwR7mvA7xFEkxxQG3+3yX6xiEDpF+/a/L+0smsGZD+GBT
	3o3JZBZs3pTe2Y4JOje04SdQHnA+xdsaCfPiDXiGk8ZoRfNNqcri3WIuJoD40rP9uAqasKLLDxq
	RlmMn7++yZzqkuUUhbTjtMwo2SWEx9qL5FZwfE4nWdko6VFXMizMfz0a+QIka6bXzRQg2/8KKOF
	JKgwg9CMVyPRiFpLqY2jRIIvkQfzqA==
X-Google-Smtp-Source: AGHT+IE8R6jm4cCT/ek6WXdRlNZG6O64AcF1SkyDRfFBDn4mzR/uUulOEMTuStC5oxV2xJ+QqSD9DQ==
X-Received: by 2002:a05:6512:12cd:b0:53d:ea1d:50fc with SMTP id 2adb3069b0e04-53e12a28351mr1659356e87.48.1733233418239;
        Tue, 03 Dec 2024 05:43:38 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1394662fsm197862e87.38.2024.12.03.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:43:37 -0800 (PST)
Date: Tue, 3 Dec 2024 15:43:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Mahadevan <quic_mahap@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: display/msm: add stream 1 pixel clock
 binding
Message-ID: <edlw7grqy74rihy5jw5t2krcyfn24c6b2lfxht4b52wx6fvck6@pqeqrbnwtsf3>
References: <20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com>
 <20241202-dp_mst_bindings-v1-3-9a9a43b0624a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-dp_mst_bindings-v1-3-9a9a43b0624a@quicinc.com>

On Mon, Dec 02, 2024 at 07:31:41PM -0800, Abhinav Kumar wrote:
> On some chipsets the display port controller can support more
> than one pixel stream (multi-stream transport). To support MST
> on such chipsets, add the binding for stream 1 pixel clock for
> display port controller. Since this mode is not supported on all
> chipsets, add exception rules and min/max items to clearly mark
> which chipsets support only SST mode (single stream) and which ones
> support MST.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  .../bindings/display/msm/dp-controller.yaml        | 32 ++++++++++++++++++++++
>  .../bindings/display/msm/qcom,sa8775p-mdss.yaml    |  9 ++++--
>  2 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 9fe2bf0484d8..650d19e58277 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -50,30 +50,38 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 5
>      items:
>        - description: AHB clock to enable register access
>        - description: Display Port AUX clock
>        - description: Display Port Link clock
>        - description: Link interface clock between DP and PHY
>        - description: Display Port stream 0 Pixel clock
> +      - description: Display Port stream 1 Pixel clock
>  
>    clock-names:
> +    minItems: 5
>      items:
>        - const: core_iface
>        - const: core_aux
>        - const: ctrl_link
>        - const: ctrl_link_iface
>        - const: stream_pixel
> +      - const: stream_1_pixel
>  
>    assigned-clocks:
> +    minItems: 2
>      items:
>        - description: link clock source
>        - description: stream 0 pixel clock source
> +      - description: stream 1 pixel clock source
>  
>    assigned-clock-parents:
> +    minItems: 2
>      items:
>        - description: Link clock PLL output provided by PHY block
>        - description: Stream 0 pixel clock PLL output provided by PHY block
> +      - description: Stream 1 pixel clock PLL output provided by PHY block
>  
>    phys:
>      maxItems: 1
> @@ -175,6 +183,30 @@ allOf:
>        required:
>          - "#sound-dai-cells"
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-dp

Why do you need an extra platform conditional?

> +
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: core_iface
> +            - const: core_aux
> +            - const: ctrl_link
> +            - const: ctrl_link_iface
> +            - const: stream_pixel
> +            - const: stream_1_pixel
> +        assigned-clocks:
> +          maxItems: 3
> +        assigned-clock-parents:
> +          maxItems: 3
> +
>  additionalProperties: false
>  
>  examples:
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> index 58f8a01f29c7..7f10e6ad8f63 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> @@ -177,16 +177,19 @@ examples:
>                       <&dispcc_dptx0_aux_clk>,
>                       <&dispcc_dptx0_link_clk>,
>                       <&dispcc_dptx0_link_intf_clk>,
> -                     <&dispcc_dptx0_pixel0_clk>;
> +                     <&dispcc_dptx0_pixel0_clk>,
> +                     <&dispcc_dptx0_pixel1_clk>;
>              clock-names = "core_iface",
>                            "core_aux",
>                            "ctrl_link",
>                            "ctrl_link_iface",
> -                          "stream_pixel";
> +                          "stream_pixel",
> +                          "stream_1_pixel";
>  
>              assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
> +                              <&dispcc_mdss_dptx0_pixel1_clk_src>,
>                                <&dispcc_mdss_dptx0_pixel0_clk_src>;
> -            assigned-clock-parents = <&mdss0_edp_phy 0>, <&mdss0_edp_phy 1>;
> +            assigned-clock-parents = <&mdss0_edp_phy 0>, <&mdss0_edp_phy 1>, <&mdss0_edp_phy 1>;
>  
>              phys = <&mdss0_edp_phy>;
>              phy-names = "dp";
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

