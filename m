Return-Path: <linux-kernel+bounces-226614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C60C9140FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89298B228DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ED7376;
	Mon, 24 Jun 2024 04:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8isRJ8W"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5EB4A31
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719202427; cv=none; b=l6BhPtlNHxPVmZyE9JHkgkB448FsTYxmykUUuhTngl1PVcVHTuiZWCpCSa5QiGQ8SkZebQowLQm3W3rBK028iPZj4WQ5Q2oqnECwrXFqDsDOzEfOWgADEXkISvcQTZVL/X6osU0K8g05dGWW5P3A2rSSVAM3AiB0ecx8lc5TWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719202427; c=relaxed/simple;
	bh=g40p/038wh7aZoKP0QQSTY6JQqMKagXDwC16tPe4zhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgZ1lUHRi965WRaVj3Gy0mwIyHDX7sA4SYgozhaxeqcrATCf1A0pScNDEur6sQiyCHWMdYI66qof6dN3caov/emdq9ayXsEHawtsgPK93qlBqAU0Wic2d7Gjmq/LYKqolrFdbBYDsuiU8xENfbzVsObGBqKJsxXFQfTN/vnw310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8isRJ8W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa07e4f44eso13175935ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719202425; x=1719807225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8cBzkTKbl++ipTccj+tqWjGiU8poirFQQErpQeRckjI=;
        b=I8isRJ8WsI8CdsASd+vWuGIv/oixor/Z/MwVtLx8yClY+RYsZPdtyuEHU2mKIDm9p7
         ly5m0XeNrc4m2J2c9DoDkGMyuDItKW8mo02K909+H0Zws7uLG4SjMU9xsql4ncfSEnqA
         3ueL2YiJuzuJdPZaTnla1f98NeXbA7KUf/yedYkpnLikIQdrsKo/CboLpq0UhSSDNCRs
         b7TlTaLdSUnejsAZQpD7TIeB9fid/ZfFasRTtIcPbdU/Ru5gz41gYZUzI2yFqs4olXaD
         3yeabTv0fIb/qDDKu3Gbzgtbj671i1q32xLuLx4MBAC4xtVB3gGSnVqEa2mROCSBwF8T
         L6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719202425; x=1719807225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cBzkTKbl++ipTccj+tqWjGiU8poirFQQErpQeRckjI=;
        b=bVVC/E3mdpPL/HW5V4+PDdTRD7VGOKTJkht2Rj9o05M1vdZHc3lzGNvEMbsgEf3bqY
         7SCjWv8uCWZCRQhfu78tW/PKzJoV3to5zBf2ZmjQzrm1n9JeoyWwveSWcKbZtqkn1/m1
         /p4sBOKPvcl5msP8qh70PpossJA+Mwe7PFIzLf6ijLiPf23T+CZfrHxzUyV7mRE4SNqu
         D41FOLCpC2X6rDJV8vHt3vEncaSo3KCE8ItiLn9m988Hyyj3dihSrpbchc2nfoykss2g
         XzMfpS92/OUj6MQsfnIbtcpGrWAF5P/7ZGFNgzzrfRc384e+Q+L5QIT4PjLacvKGDyO1
         W9/g==
X-Forwarded-Encrypted: i=1; AJvYcCVWpFuJAkOpX2cGubKsMfnNl5U1MLeThOO5oz6vYFIZ3gqH8RiheesVQbzAp2LwzTA7Nw/Y6GvPmL1xO4gLG2YvOI2S6MPDx3RXDqS0
X-Gm-Message-State: AOJu0YzLZb53CPdruvQpuSwTG8sGS50/WSQmCdBlDq204wP6gFRdH2ag
	b9amQt9Jxp8u7ggoaCe17AK9p0r3R+lEeXE9m9S8nL2drQoWEmC6dDnybebeag==
X-Google-Smtp-Source: AGHT+IEFH6u4Phxu4XFbcP6oZlGouPp6ySyJ7RzMJnUbJnrqSy6lUpugRFFKO7YbCnXWz8uf73KoHg==
X-Received: by 2002:a17:902:cece:b0:1f4:9b2a:b337 with SMTP id d9443c01a7336-1fa238e4490mr46624255ad.3.1719202425410;
        Sun, 23 Jun 2024 21:13:45 -0700 (PDT)
Received: from thinkpad ([220.158.156.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d8b7esm52445395ad.207.2024.06.23.21.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 21:13:45 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:43:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/8] dt-bindings: PCI: qcom: Add IPQ9574 PCIe
 controller
Message-ID: <20240624041339.GC10250@thinkpad>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
 <20240501040800.1542805-13-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501040800.1542805-13-mr.nuke.me@gmail.com>

On Tue, Apr 30, 2024 at 11:07:54PM -0500, Alexandru Gagniuc wrote:
> IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
> The difference is that the "iface" clock is replaced by the "snoc",
> and "anoc". The "sleep" reset is replaced by an "aux" reset.
> Document these differences along with the compatible string.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index cf9a6910b542..ac6d2b1b8702 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,pcie-ipq8064-v2
>            - qcom,pcie-ipq8074
>            - qcom,pcie-ipq8074-gen3
> +          - qcom,pcie-ipq9574
>            - qcom,pcie-msm8996
>            - qcom,pcie-qcs404
>            - qcom,pcie-sdm845
> @@ -161,6 +162,7 @@ allOf:
>              enum:
>                - qcom,pcie-ipq6018
>                - qcom,pcie-ipq8074-gen3
> +              - qcom,pcie-ipq9574
>      then:
>        properties:
>          reg:
> @@ -397,6 +399,39 @@ allOf:
>              - const: axi_m_sticky # AXI Master Sticky reset
>              - const: axi_s_sticky # AXI Slave Sticky reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq9574
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4

There are 6 clocks defined for this platform but binding just requires 4?

- Mani

> +        clock-names:
> +          items:
> +            - const: axi_m # AXI Master clock
> +            - const: axi_s # AXI Slave clock
> +            - const: axi_bridge # AXI bridge clock
> +            - const: anoc
> +            - const: snoc
> +            - const: rchng
> +        resets:
> +          minItems: 8
> +          maxItems: 8
> +        reset-names:
> +          items:
> +            - const: pipe # PIPE reset
> +            - const: aux # AUX reset
> +            - const: sticky # Core Sticky reset
> +            - const: axi_m # AXI Master reset
> +            - const: axi_s # AXI Slave reset
> +            - const: axi_s_sticky # AXI Slave Sticky reset
> +            - const: axi_m_sticky # AXI Master Sticky reset
> +            - const: ahb # AHB Reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -507,6 +542,7 @@ allOf:
>                  - qcom,pcie-ipq8064v2
>                  - qcom,pcie-ipq8074
>                  - qcom,pcie-ipq8074-gen3
> +                - qcom,pcie-ipq9574
>                  - qcom,pcie-qcs404
>      then:
>        required:
> @@ -566,6 +602,7 @@ allOf:
>                - qcom,pcie-ipq8064-v2
>                - qcom,pcie-ipq8074
>                - qcom,pcie-ipq8074-gen3
> +              - qcom,pcie-ipq9574
>                - qcom,pcie-qcs404
>      then:
>        properties:
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்

