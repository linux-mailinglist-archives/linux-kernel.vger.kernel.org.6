Return-Path: <linux-kernel+bounces-328275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D38978151
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EAB1C22313
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45B1DB921;
	Fri, 13 Sep 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uReTE3yz"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33B186E5E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234684; cv=none; b=L7fb9pUTpEZP0Zx1HlTeYww8mheCCiXDa0yGIxSPS5Uyipv26ArsKxt/h1lnOBDVofWja8z3yzr9jFNFb+0knYjPJyLxc1uKIGEVo/4ZWSopdX8OvoycDqNCmgHLeV/1FwbG93XqC9DdcIbt4/ZgDlQz072Fvzh24GuSWBQzrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234684; c=relaxed/simple;
	bh=PWgO44z09ebmgMtrjRxx7dE2A2UuqzUQ+JDOYxYQtpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1sB8XPHzTvUpDUKcm3CCpnKdsD0lv3J8PXw/wkEc9bmhTI+deU23bDdBLaPsuziOFaSqXwpHvMGWgv8u4774HIBWUTLbsrSDUjup3/5Gu9mH/BDP4JNYvvF91m2hrRqZIwsTvQtoZWfeqoEC8vq1gnCv8xA/SLDAb8ugpt6kW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uReTE3yz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7179802b8fcso740325b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726234683; x=1726839483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BI2hDmwwKJCOx3VYE7RIwF7HNSiMnl3DjwM5Z3iw39A=;
        b=uReTE3yzkZMxJLBygzZm/+F/nhnRqFeFBsbDzCE/xZ1J8G9UaS9JJQWBJR3T2CFXnv
         qjPTlIKJAm6mcY12Ir4dTyqCmiZIg+ltlf2e5BP/VtWXuf5PjGoeKE46T5EuRg2UMvqL
         jwX0nN0i+1B5tUHtkuiNN7SjG+uWSColIzBuMNtRTs3nFjegHBNnLDKNdQ9qhC1gx743
         pKhYFPM94EcvRjtPQgIIdcWnz4GbueuxEsLZkyMz0g1O0rP8K+4WATRYRyj2g0UaMi95
         YwoG0Rsq1apHNEpdgIxTqKtjDCzU08PkrCGWO1nsbk4jy26WxkcUQzkwLO3c5vn148EI
         CIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726234683; x=1726839483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BI2hDmwwKJCOx3VYE7RIwF7HNSiMnl3DjwM5Z3iw39A=;
        b=AwGRyGdQ+K7nKSa4tj9GS9Cv+ZoqI/hHriN4c93Rrr050m75XNr+hfYIwod/jbVvwT
         p8udccjpFs5CdhZ+vRnrBp8OngkX0m9nYlWLZAPg6SNVZgUN2Cj954Ma8oVQD7iUIFzj
         xwtlpwri0T4f/KUqvYSFNgaiRswQjQkP/jJ/YtKrhfILQBLjvhYL7q0wPpgp3N3Q7aZD
         l3VJXfVu51eC4vDh3oqh6aFIVfN5qjBdoZZkThHAm/HL8FEcwm3eQcLatGAw7KQoPDpf
         qCGT8cO78Beie8xRRTl4ayt1gst1jEGtrV7MzvwhRuDdWox3rXYtDAK12HN6zifxtPVo
         rrWg==
X-Forwarded-Encrypted: i=1; AJvYcCXpyPL3nvkmv6mk9grznCXtRWlwLP5HWRAayx89ZR2vm6iJo1Yjvw2H1uNlqa75QjHjJ2dwVbgigTKOBT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOwyphojfmwpfy+YCbpgLA2PwuDuEWvW8pIHghVlM8b6BKvyr
	c9MJiyNfpZ23GRyeNbU9CcgWBge3MaMPIfpeLu2dnjxJjEkToT3uHx/7gkG0Hg==
X-Google-Smtp-Source: AGHT+IHkmtRHQ+rUmoFYCE/1t6yyLL89sOdatHoosm5maSEtNzYl+sXUvxBNTHJPrww1u/l+DLihkw==
X-Received: by 2002:a05:6a00:1ad3:b0:714:17b5:c1d9 with SMTP id d2e1a72fcca58-71936a2f094mr4539801b3a.1.1726234682735;
        Fri, 13 Sep 2024 06:38:02 -0700 (PDT)
Received: from thinkpad ([120.60.66.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090b2c3fsm6095724b3a.165.2024.09.13.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:38:02 -0700 (PDT)
Date: Fri, 13 Sep 2024 19:07:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the X1E80100 QMP PCIe PHY Gen4 x8
Message-ID: <20240913133751.2yegqbobvfzbogxc@thinkpad>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-2-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913083724.1217691-2-quic_qianyu@quicinc.com>

On Fri, Sep 13, 2024 at 01:37:20AM -0700, Qiang Yu wrote:
> PCIe 3rd instance of X1E80100 support Gen 4x8 which needs different 8 lane
> capable QMP PCIe PHY. Document Gen 4x8 PHY as separate module.
> 

Nit: please use 'Gen 4 x8'

- Mani

> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml    | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index dcf4fa55fbba..680ec3113c2b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -41,6 +41,7 @@ properties:
>        - qcom,x1e80100-qmp-gen3x2-pcie-phy
>        - qcom,x1e80100-qmp-gen4x2-pcie-phy
>        - qcom,x1e80100-qmp-gen4x4-pcie-phy
> +      - qcom,x1e80100-qmp-gen4x8-pcie-phy
>  
>    reg:
>      minItems: 1
> @@ -172,6 +173,7 @@ allOf:
>                - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x4-pcie-phy
>                - qcom,x1e80100-qmp-gen4x4-pcie-phy
> +              - qcom,x1e80100-qmp-gen4x8-pcie-phy
>      then:
>        properties:
>          clocks:
> @@ -201,6 +203,7 @@ allOf:
>                - qcom,sm8550-qmp-gen4x2-pcie-phy
>                - qcom,sm8650-qmp-gen4x2-pcie-phy
>                - qcom,x1e80100-qmp-gen4x2-pcie-phy
> +              - qcom,x1e80100-qmp-gen4x8-pcie-phy
>      then:
>        properties:
>          resets:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

