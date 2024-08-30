Return-Path: <linux-kernel+bounces-308333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE7965A71
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9730C286E99
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155A16D317;
	Fri, 30 Aug 2024 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWtnQLDE"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DEB16D332
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006962; cv=none; b=kRHl0xe4TVLoZ3wUsqChBKdHDeq6CmmJ/ThgIfzrRDtivCX1hEn4dGtaLsUyIqEkbflrLOoEA+RZ1BEG3AE9BtcpR7Sn0E5Mc9NAOVO/5PmIJevp1eAFruDWmkP10XmCBZCTDDdPrR6Fl98Px3NgwL9m0TmjZ9/NFjD0KuOetuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006962; c=relaxed/simple;
	bh=AQdl9xmsK8ZMt1kvTa1HmFVUzpMAE8Xf7jM0R7oI+ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAJQX3hAAy1ZVBC7NrK2BH18dkAoGXfZwye1aaeOdJ4dLvwbMnsJJcYAsUmufg3erjvavrYvDUa/HTXy+pkasPG+JOw3f+i9FBQogut3t2o93QzzHu2n7rBUaXHtV3x3opCo+7USarRpYLvS4tXrWxi5Fin5xPLvvA6g5y4eOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MWtnQLDE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso1157145a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725006960; x=1725611760; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HRHmHWrP9aGbtsGBj3sSUa2W5O9vCt0AWItUOkadt2Y=;
        b=MWtnQLDEotjVGwRD8x2jJQlPXUavaLCtAok/8AauIKs8WgpKFuVk5dfUSdnXya6hFb
         7xDyebGN3RKnW0xAbTarnWJjq5CG4LSjmNG7xKybp9ifd2Qo2swh5Qe3oUmdjXNpiBBk
         WJr9vCbtQiBmxt1bAfVNgvcnGbJ+Xo9oO//0csk3YgOQXZfKTi0pnWymStsbVTe8Sww7
         Rg18jgVpcNhV1T/mOV8xNnp7UQU9LNRwN+tmvwe8JjDvvUcfqOag2yD2rAB9O8PzfOSG
         snw1T629O+zDuEbz+DxCZkbGb2pzwr1C9z5WL8Qh8q7KupWuU71XjPtoy1ahvPZ+7oXd
         1NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006960; x=1725611760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRHmHWrP9aGbtsGBj3sSUa2W5O9vCt0AWItUOkadt2Y=;
        b=q4jqd5nxgbpAtXh40cQU12j8+pHQG57pNktObTmlvTSVbYG4psjTgQETf3BiCXjJHc
         ec4PzFfolHGT3Z6mKWGatoTMi6wCkmNh3ChklEsocYa90esDwPqKGlLuuYtZyUHJsUJJ
         5y856E2INHA1M+kRLTNsAiwxS69mORNrSoHLM++R5xBjMTWjgetypNhmbHQTI7fj+Yxr
         HOjlhhuzIR4oYCDf61vAU3eFfQYIJ36Mf85v5U0Q+WhHPKZ5ay+SIsltx18dagYi0pl9
         ZrDX9Zhht94AvlSQ1rSJ3OsEbQZUKYZFTjYSV3AiNNW6h33vDA8xvjQ49lIoThyWmQl+
         sb7g==
X-Forwarded-Encrypted: i=1; AJvYcCVYROyrOkBQwKkHnJkuWsBilnTLK+SYmu0LHZzdI7o3JkqlRscJDPRBbvEGn5WOLlOandFKqqgO68UhCkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSylqpz9YOyIkhkewznX/0itp/4/8oga6Gxy8rdWY1Puuuyq9K
	OuHFu42iZIZtmpC8S5IIzMrScILNnBOAkf4SVArtFLcpePH5HQG8Vd8kIJ1vOw==
X-Google-Smtp-Source: AGHT+IEg701oVGHlnE52pK3OQhbcRTjhhzAp3dBmqRMQAHDvR10F57i/IZHuH1pve1bxSwuJqV6lAQ==
X-Received: by 2002:a17:90b:4b01:b0:2d3:ce8d:f7f1 with SMTP id 98e67ed59e1d1-2d8561c7556mr6135729a91.25.1725006960007;
        Fri, 30 Aug 2024 01:36:00 -0700 (PDT)
Received: from thinkpad ([117.193.213.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b39ce64sm3134091a91.39.2024.08.30.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:35:59 -0700 (PDT)
Date: Fri, 30 Aug 2024 14:05:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, robimarko@gmail.com
Subject: Re: [PATCH V2 2/6] dt-bindings: PCI: qcom: Add IPQ5108 SoC
Message-ID: <20240830083551.yazww3kj2shf4ocq@thinkpad>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
 <20240827045757.1101194-3-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827045757.1101194-3-quic_srichara@quicinc.com>

On Tue, Aug 27, 2024 at 10:27:53AM +0530, Sricharan R wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add support for the PCIe controller on the Qualcomm
> IPQ5108 SoC to the bindings.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  [v2] Added reviewed by tag
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index f867746b1ae5..c12efa27b8d8 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -21,6 +21,7 @@ properties:
>            - qcom,pcie-apq8064
>            - qcom,pcie-apq8084
>            - qcom,pcie-ipq4019
> +          - qcom,pcie-ipq5018
>            - qcom,pcie-ipq6018
>            - qcom,pcie-ipq8064
>            - qcom,pcie-ipq8064-v2
> @@ -312,6 +313,39 @@ allOf:
>              - const: ahb # AHB reset
>              - const: phy_ahb # PHY AHB reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq5018
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: iface # PCIe to SysNOC BIU clock
> +            - const: axi_m # AXI Master clock
> +            - const: axi_s # AXI Slave clock
> +            - const: ahb # AHB clock
> +            - const: aux # Auxiliary clock
> +            - const: axi_bridge # AXI bridge clock
> +        resets:
> +          minItems: 8
> +          maxItems: 8
> +        reset-names:
> +          items:
> +            - const: pipe # PIPE reset
> +            - const: sleep # Sleep reset
> +            - const: sticky # Core sticky reset
> +            - const: axi_m # AXI master reset
> +            - const: axi_s # AXI slave reset
> +            - const: ahb # AHB reset
> +            - const: axi_m_sticky # AXI master sticky reset
> +            - const: axi_s_sticky # AXI slave sticky reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -503,6 +537,7 @@ allOf:
>                enum:
>                  - qcom,pcie-apq8064
>                  - qcom,pcie-ipq4019
> +                - qcom,pcie-ipq5018
>                  - qcom,pcie-ipq8064
>                  - qcom,pcie-ipq8064v2
>                  - qcom,pcie-ipq8074
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

