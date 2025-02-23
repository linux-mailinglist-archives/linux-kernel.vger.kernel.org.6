Return-Path: <linux-kernel+bounces-527999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDCA41249
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A66C18927DB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628B2080E1;
	Sun, 23 Feb 2025 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7W5rXcZ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43671DDE9
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740354236; cv=none; b=MFnS4T07/DcSyFdC9dsA4oCqzVgIr5lE1nNVZBOlyFEzBuHIqCYjXhcrELvlAbXK1AhqCRNiyn24F5tpsLyJ9orqxAsVsy9xuuOo/oJGC7/WB706gOpFB1Dw5QapxUCn4Mtrv5Y6Xk1nPPT7XkUcFlQbBPmavoVeHOL4Tkyy/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740354236; c=relaxed/simple;
	bh=deTx+omgnbLOs8r75CSTqyV8OyfmK0sMG1fGy+1WAXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpM+b24KeMn9YqHz7ywe/y24FC2Ugdn2DY7MnuWRX1TW8Fbwyzgu76Nf1vomMXe4U01lpkpUufn5XWwOc13JOjvB4bn/2aoy5HB1RkPaQfXVGDjqETfLLpMMk0pXAMBXfEToiudQPfgpgZMa0SNf9LhzQZkj+ia8vo6x/7lG3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f7W5rXcZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54622829175so3668898e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740354233; x=1740959033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28j2oUhHrE0UtIm5Z7Iu9myzi6x7Y72gOBfh9gvCc7A=;
        b=f7W5rXcZfjbLnPu9d2Fjv268Mx56fiFxIf7KMch/7XYFz5jSR8G6VpdD5oxO6TSti9
         ZgLPrEdkKf/2JBZMhBv5BHOrjyvIJu/pNsEr+wS7t1ujiDfvJlNEaXJkNEhbTxX2AmvU
         rQhc657cnWk/CH4/Qie0Vk4zZFHb5F3QdHhX/nOpjlkVkstIRXLcPryCBD+ONifqrpN2
         YZH3dPrWnt4R/Z9SD4yh2wFoV+1vJRRw5mmBgP3kuw0Ej9Dp2AFyUJRpeitI1PCOYRac
         IHO31DPVQImRqq3/jEt8OkWGH3CdKhuMp4mnco9zXXwD75m4U1hu7NUon02d3SKAOcZJ
         5tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740354233; x=1740959033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28j2oUhHrE0UtIm5Z7Iu9myzi6x7Y72gOBfh9gvCc7A=;
        b=uWvBbtRarEcV/UqfykzQqMcIzEVTA3gse3Fi5N+X7XQPUX0pokBEwVqT8zyu6bESuC
         mZns04PEHSQbljDvUvK7x5EuyGFGLVOs1eP6ru0pG6MBRevqQ53gi4zkZYzocvgB/u3v
         hsG0kFnYz3F8hNOrxOA2GEI48zZeCQ3ZiNDpkjyLJwj/+DeUfa9R/VDUsnZHgbq2fqXY
         rK1/2vXqZ/Nty4noVp8jccLhnSI6xJGgiT6XY7mv8iukW/6rdNFT9vLy7UqhnpRwvdYd
         LhPxAa3aMg7QycimUB6Bwj3a4hjqKtCDeOb8CLdNpcSHQpPGfUMatsONyVuAe3k0uxo0
         6f/w==
X-Forwarded-Encrypted: i=1; AJvYcCXoC5ZaMXD0GIU0dgdzxeM/rZdOH+rcBR5zKtIDitR63m5Npvor0Y4LkW9qqIM3tqDeVor+IjR+OL5BO7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSLDjbip7BeIfkwU5lDgLeeN3CGA+Pa7085qTLHS4Cnfqjt3Q
	rpsh7U4nvZeytGXyp7ZkEcazzkU8pLDcbhpRZ52kSKmHISvX/oumnuqCkVPEIrk=
X-Gm-Gg: ASbGnculbM1weRaSrhJXjIXx/JS0rE9FgQ73sp3Zl/RG9yuSwRSZrlGeJ0722yBOkwI
	JOk/+tF0nzhQ2mRmfY8tmA5GpA8E43tSHuersJdDDyf5LYsSrSaO3wzA9ObuP4LuryDa2VVQ13B
	ZPa6+CS8Rp+p3FkPmTdO30aS6Bk5uPiTkzoSdoVCAyMM+aqiLjbRrPctX3uHZU7ynjYKbns/xnn
	Ff5c2IWUoHRGH/s/kQ5qIri/AT+DgaaN/IJZ/LoFIdC1CYwm7CVb5PTHixr5bRyphCXoW0R4sO5
	iEEdoDWmCDzoodRInq0jhzIgIqzEj5DlMc5ujUTJgA7uvuSHIopPKs8mHLoho7imSMiu1huweWZ
	X36noAQ==
X-Google-Smtp-Source: AGHT+IHqDyDmO/r2yjSG30eHo/aZTvnzBBS3IoH2SUfydcMTabalwcojF162vAWAlTXJ3voBa2nsQQ==
X-Received: by 2002:a05:6512:308a:b0:545:296e:ac28 with SMTP id 2adb3069b0e04-54839144ee2mr4857016e87.24.1740354232909;
        Sun, 23 Feb 2025 15:43:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54526741fe5sm3065509e87.90.2025.02.23.15.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 15:43:51 -0800 (PST)
Date: Mon, 24 Feb 2025 01:43:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: snps-eusb2: add exynos2200
 support
Message-ID: <4tvpl3pujnuw2qjwu7f7ryrr5dndxow7srkkp2223wmexr23bi@7nmgrpq6znpg>
References: <20250223122227.725233-1-ivo.ivanov.ivanov1@gmail.com>
 <20250223122227.725233-3-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223122227.725233-3-ivo.ivanov.ivanov1@gmail.com>

On Sun, Feb 23, 2025 at 02:22:21PM +0200, Ivaylo Ivanov wrote:
> Exynos 2200 makes use of the Synposys eUSB2 IP, so document it in the
> binding. Unlike the currently documented Qualcomm SoCs, it doesn't provide
> reset lines for reset control and uses more clocks.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov@gmail.com>
> ---
>  .../bindings/phy/snps,eusb2-phy.yaml          | 64 +++++++++++++++++--
>  1 file changed, 57 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/snps,eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/snps,eusb2-phy.yaml
> index 22c77968f..f4164db71 100644
> --- a/Documentation/devicetree/bindings/phy/snps,eusb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/snps,eusb2-phy.yaml
> @@ -23,6 +23,7 @@ properties:
>                - qcom,x1e80100-snps-eusb2-phy
>            - const: qcom,sm8550-snps-eusb2-phy
>        - const: qcom,sm8550-snps-eusb2-phy
> +      - const: samsung,exynos2200-snps-eusb2-phy
>  
>    reg:
>      maxItems: 1
> @@ -31,12 +32,12 @@ properties:
>      const: 0
>  
>    clocks:
> -    items:
> -      - description: ref
> +    minItems: 1
> +    maxItems: 3
>  
>    clock-names:
> -    items:
> -      - const: ref
> +    minItems: 1
> +    maxItems: 3
>  
>    resets:
>      maxItems: 1
> @@ -58,11 +59,60 @@ required:
>    - compatible
>    - reg
>    - "#phy-cells"
> -  - clocks
> -  - clock-names

Why? Clocks are required in both if clauses.

>    - vdd-supply
>    - vdda12-supply
> -  - resets
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm8550-snps-eusb2-phy
> +
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        clocks:
> +          items:
> +            - description: ref
> +
> +        clock-names:
> +          items:
> +            - const: ref
> +
> +      required:
> +        - clocks
> +        - clock-names
> +        - resets
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos2200-snps-eusb2-phy
> +
> +    then:
> +      properties:
> +
> +        clocks:
> +          items:
> +            - description: Reference clock
> +            - description: Bus (APB) clock
> +            - description: Control clock
> +
> +        clock-names:
> +          items:
> +            - const: ref
> +            - const: bus
> +            - const: ctrl
> +
> +      required:
> +        - clocks
> +        - clock-names
>  
>  additionalProperties: false
>  
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

