Return-Path: <linux-kernel+bounces-308610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E05965F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DBFFB2CA1A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5AD18EFE6;
	Fri, 30 Aug 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFQHhGKG"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682EF17C7BE
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014537; cv=none; b=o7tKloppk/divjzK/2w7pCa+tOSeYTtRXKz7Xjrf7evqprufni6kOYtoKEplHh7lmhXXQseVCrnceWjms4JBtU3BXCHkjMzOWT3dVf/NVAwiLnPzj0H1q6lK4mkHgSI7ZqlGgnqQTAfEtuMCrN7gR1l7PCpfrbArY0wS1pLB7+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014537; c=relaxed/simple;
	bh=GU8GsIPo5vVjv/FvznuyCG2RVrBUnZEpDYjAsHhlquw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb7l94w1ANGmcosyhNPLbE8ZKkExTVdqZ9whM6T+lXlVs1f0m7Vj67UjL4DCCE1q6j0ql7stq+hmxcT7u3s4/z2j4v2Z6A1pnLKLCzGg6Cl0ec+mIJ/Q4/4RRkr0rvqTrA1G25kKx1zq5HpX/5jWiwpEXSrsOh9UuBV+L+FRkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tFQHhGKG; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53345604960so1698513e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725014533; x=1725619333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nnBATt0aCdgUC6P5YWHuzTeqt0mGO1EjpThrCVktSJU=;
        b=tFQHhGKGHNM1rtvgKIlpxuNJPRDt33PXee+r4BAR4dg72iHb7VtG0x+1Tgz4LD6JCR
         bQrB7/wCRo+8tZ09EnY35f5Q9NLhvUtnVEUhQ9qn70NR4UeCeM23QL5vgoef+vT61ry7
         /3TxOv7JNW+nlCJwhfmb4MJPF58jEzDzYmgMIVnzflG3L+c1zMBpNm6Sej5Iu+xvj2YH
         0yTEgliQJclplRn/QzVHGPRnmVviOSoLa0cXkCLaJsYv1Lr3X0z88guGkZ7OIrdYL73M
         3gPBt+/cNKxasTB7nk0NzyDeLVVd/D473J8yFMhpPRjzHZ3njR44MLpSgJB/BZmL7QS5
         RfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725014533; x=1725619333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnBATt0aCdgUC6P5YWHuzTeqt0mGO1EjpThrCVktSJU=;
        b=A1OaAH5rxMK/VGA/iym1AtK6m6I2I9tnQPQ1qiSDkVKaH/7iHkkPNkxEZ17m5MJoDA
         t6mfhC6HZXH1sY3HOqcvkjn2nEtaqcsh6GNsCc49246DuwIX6RxdISa8eWIqYF/DWlCo
         tvgvWFDb4O5xgcP8LBkxfB58Pew/VNsQO8G6fK2zz5rS4PA9NLwjC6+Eh2SIM1hSM56W
         fishxajOK4GuEMAmV8HK7HFaYNrndZ4c6e2aBYZOHR8Lpi8byUShBWBplwjtdz4ADMpb
         X8OtBu5gSsJjJv5pdFdGwWbWy87qiIklqTqWnryIiEUBgW9z5JgGPJcEp+uOfaZxBEK7
         FBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW78XoiBg8GOKgZvpfgprNhBth3R2B1B287wP9RU4Gy/sMLdqptXAoT1etjIdn5VcnN/YiBZBZnCPtby8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFeO1K/GtBz4Rv+r5SU61JNn+Sa3xqyqe5DwCZrGTQAzR1MOD0
	bgnkB692GiioKzdh3OfJe7biSQUAsY9J5XklBvv0750p3UubDl+4zxg2Si+qA3c=
X-Google-Smtp-Source: AGHT+IHIVMMpPiudJNRkic59qjcS0uvC6Loc8Pvi0x8IGyPMyVB8soyXpzs69J1ZylJShtWwpCcRFA==
X-Received: by 2002:a05:6512:3c99:b0:52e:9f17:841a with SMTP id 2adb3069b0e04-53546af3048mr1391073e87.6.1725014532644;
        Fri, 30 Aug 2024 03:42:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079bb9dsm540503e87.21.2024.08.30.03.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:42:11 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:42:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the X1E80100 QMP PCIe PHY Gen4 x4
Message-ID: <gvx3sdsdxigel3iwu7vgvvgxohvnaqq6suogsqojeumobhwhdk@5qct23m5ncda>
References: <20240823-x1e80100-phy-add-gen4x4-v3-0-b7765631ca01@linaro.org>
 <20240823-x1e80100-phy-add-gen4x4-v3-1-b7765631ca01@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-x1e80100-phy-add-gen4x4-v3-1-b7765631ca01@linaro.org>

On Fri, Aug 23, 2024 at 10:04:15AM GMT, Abel Vesa wrote:
> The sixth PCIe instance on X1E80100 can be used in either 4-lane mode or
> 2-lane mode. Document the 4-lane mode as a separate compatible.

As the patches were merged, it's too late for this series, but as a
note: we should think of a way to describe the PHY configuration without
changing the compatibility strings. The hardware stays the same, it's
just the number of lanes being wired that changes.

The obvious way to handle platform-specific differences is by using
num-lanes property of the PCIe host and then passing required
configuration (num lanes, max speed, etc.) to the PCIe PHY via
phy_configure() call.

> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 03dbd02cf9e7..dcf4fa55fbba 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -40,6 +40,7 @@ properties:
>        - qcom,sm8650-qmp-gen4x2-pcie-phy
>        - qcom,x1e80100-qmp-gen3x2-pcie-phy
>        - qcom,x1e80100-qmp-gen4x2-pcie-phy
> +      - qcom,x1e80100-qmp-gen4x4-pcie-phy
>  
>    reg:
>      minItems: 1
> @@ -118,6 +119,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> +              - qcom,x1e80100-qmp-gen4x4-pcie-phy
>      then:
>        properties:
>          reg:
> @@ -169,6 +171,7 @@ allOf:
>                - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> +              - qcom,x1e80100-qmp-gen4x4-pcie-phy
>      then:
>        properties:
>          clocks:
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

