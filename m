Return-Path: <linux-kernel+bounces-523106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C99A3D209
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F5A1893800
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0151E379B;
	Thu, 20 Feb 2025 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ad69B3qC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876815A85E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036029; cv=none; b=hehfRUxA58dxk0MzmL34F1qapKih1MSxSsGDvM797skmx7PtGJr5hodgejomDSi4x6m8enisfP+pFz97dIUq5yRELaQ2GKrioCkiiBPnEfEUaZcB4s5cmvfcmqdU+AYy9G2jbceCu931kkuAFfMjzs6NAmFoN3Crk804luvD/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036029; c=relaxed/simple;
	bh=3z3bFkW/fyAsXfeUae+7quyDfO6ipvjNyjoRSl7BG7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbw786erU/bXVG4MtuJnNpznSEPVKeviSytI1DAccemtzabZUpfy6/4v65p+t016DW8GuTXzSk6j3pM46V+RWSNjw3RP+pnNa4H6HFkiZNohm530fu46TMHTMpdNCeF14G8ZMlAHfPZQWRmGk9eTdLrDfvaKlUhqWkIZcjeMYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ad69B3qC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2212a930001so15103055ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740036027; x=1740640827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=09LWZQ5e3emn1W6KyZY0f1EZuF11DtnHuRBnesOGMy0=;
        b=ad69B3qC5dR2WEQIgybbHp3CwjTNX1CNdfI/M4EFJrs9eXLoNeoY9+fd7NtKPoOtJC
         KcvwcMdJDlaK7BXXpmiqN/yQPbeo4tiwBS7LUVYgaXOwqvds9lkkyDpa4WA3JMreDhtq
         l6MyUWAMo/psVhvgU1gZbRO7hf+GMJnDxXQ187DxyRxNWswCGIiJQ/SEl3BwL9Q6wmNY
         Fbl5ucdMgwwNklDDj/tPIriWUnTDLq48tTKxFSaTpKrRZKLk0QtnKR04KVnDaTSgRguT
         8imqrIo1iHUFmgGRxrNjGm3Mxz4q51thQePWen3cwAyptqEPNcNRLb/QbzEFVZqtyPtp
         EZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036027; x=1740640827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09LWZQ5e3emn1W6KyZY0f1EZuF11DtnHuRBnesOGMy0=;
        b=jcH1MH4vZaLnUEzqKTzDb6YLZeJqjcvifXr4XKt2ni6qnZiySXW1hx2vkls0SNswVc
         l8Q2Y5grZvWpPl+BkFbgEsUUejktDaZCWVcmrgtz3/2UZte9hKvsWl2YfjjFIQ0f5Vhc
         sWWBmHx7iwaa2NZBh0zg4BfABWDvQhK7Pt5WGUtO1Dg5V1AZMujqz47NQ+DJCwsMxlbj
         pPbPWmcAOjY0EW1CDwiMzNi/H+STKhRBMEKmjgMVyHKywFzlGLTDcEjR9N+yc3mMeF3/
         rQ7JXMhho8PjowRDmLVZhEMQNhS2I/LEDCVXTjtY4hJ09jtBWhB5Q7vLr6SAY3Ky7TX7
         BoxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXT4ImPpWaaf8Li5DF80sRDFQL+PnUsc+/TBd6xm48vrtqMlk66mPXR/8wQ3zAZVKGgrzQe5XMh0ZBtSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVR/xjBgPL2bugMnO2PfT3jPqi9824PXYR4X42RJVZY0aAxAag
	M72ZLJP7tECfvp1ndS5yncydN1aaqGjjVqJyDgp6j0J37a5AW+M9cXIQv/gHRw==
X-Gm-Gg: ASbGnctmpdw+FIyY1S5cG09cqf1yFnXwL+TZVBBjIxhlBL8HxBLe+MdTEXaUSU9P05/
	+c9sHFFH6SXXhjsXNhKLS6MnufrvuEcNkRR3yoqK00qBTKHa9QTW8N3pqhCLjZCTJ1LTx6WGjkJ
	9yr84qwaoL2bKqH2tU4y9K4Gnn90aIn4uqaO4NAKvLUP1+tM1n99wkM9ZiH+wklxCBUcCJjsw8b
	RsEqjgj8mM+DYke6dCYNLjabciNT8bM6JghQVXiIZ4xW6En8X3IXl5Jm490jSgLfOzUlq3G0Qft
	HUTvwcJiS+2UmwdaV1Fh9xER0A==
X-Google-Smtp-Source: AGHT+IFYaTRFrJf2YGhtVpgfx2oiIlsTNAuzM5/7P2/cYdUCg+S2sl6dwZT2iWA7mQfRcQOfKwNPlw==
X-Received: by 2002:a17:903:32c6:b0:21f:ba96:5de9 with SMTP id d9443c01a7336-221040c09c9mr340960585ad.49.1740036027570;
        Wed, 19 Feb 2025 23:20:27 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98d3b80sm15090743a91.17.2025.02.19.23.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:20:27 -0800 (PST)
Date: Thu, 20 Feb 2025 12:50:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: PCI: qcom-ep: enable DMA for SM8450
Message-ID: <20250220072020.sj6grl24bfzwxvh7@thinkpad>
References: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
 <20250217-sar2130p-pci-v1-2-94b20ec70a14@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217-sar2130p-pci-v1-2-94b20ec70a14@linaro.org>

On Mon, Feb 17, 2025 at 08:56:14PM +0200, Dmitry Baryshkov wrote:
> Qualcomm SM8450 platform can (and should) be using DMA for the PCIe EP
> transfers. Extend the MMIO regions and interrupts in order to acommodate
> for the DMA resources. Upstream DT doesn't provide support for the EP
> mode of the PCIe controller, so while this is an ABI break, it doesn't
> break any of the supported platforms.
> 
> Fixes: 63e445b746aa ("dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 800accdf5947e7178ad80f0759cf53111be1a814..460191fc4ff1b64206bce89e15ce38e59c112ba6 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -173,9 +173,9 @@ allOf:
>      then:
>        properties:
>          reg:
> -          maxItems: 6
> +          maxItems: 7
>          reg-names:
> -          maxItems: 6
> +          maxItems: 7
>          clocks:
>            items:
>              - description: PCIe Auxiliary clock
> @@ -197,9 +197,9 @@ allOf:
>              - const: ddrss_sf_tbu
>              - const: aggre_noc_axi
>          interrupts:
> -          maxItems: 2
> +          maxItems: 3
>          interrupt-names:
> -          maxItems: 2
> +          maxItems: 3
>  
>    - if:
>        properties:
> 
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்

