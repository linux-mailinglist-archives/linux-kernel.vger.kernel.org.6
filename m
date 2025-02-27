Return-Path: <linux-kernel+bounces-535539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B27A47446
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56C2188C686
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5A1D90B1;
	Thu, 27 Feb 2025 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5gXPcHC"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6B1B78F3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629824; cv=none; b=UmEKVz0qGZiNFju500WMp9JXJcgSlaQr2zrPhIAmGBQwchBk0xKiRCqfvcw8/c3m28l/eB1EEe21IMYFAU9/xe/NE/5rWHgJn7IV3csV5OqH34lIsPuQ6qcMFSIj7v4wi/XJokE360k8K5273+NQ7PlUDbOwvKlTU/xkTAtzMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629824; c=relaxed/simple;
	bh=cdH66nBgTf0Lwg3K/8eyHtCyVQMYcf9IUF1L6JQC4tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ6SfW9BQQa88cczpO2K8IVCaHjiecQHAmB9pCPJSAQqcILBA+0QyV0FFtxNU4ixQ+AXme4JY4Dw0+rNklFTjMnqJ3msQYgjrK5jFi2vRnMmaJSAaIxj3Xao0UkgWsVlC3aKFWsvGfOPixj1tvy4X8PFl/1XOYPER968TF1VMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5gXPcHC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-546267ed92fso466525e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740629820; x=1741234620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbpE7A80HY+/Mdda5+FpAzRig9IYFvS6m/EoQDwpXAQ=;
        b=Q5gXPcHC5lN5JVX2lf0aUyQc63bMtc0iG5JHy2/dODruChVNW2VZxhugXxooa3WQx1
         OANOD/ClCw/F679fgDtLCFQQwk05hqG7NJWqIO1t44nZwU/aMMhb4fAgkhksL42G70c7
         oydZhdGEKwC6yT3dNFwBRhHEyaOBDj2UU1KqoklO6D3q54Bf4j+tjqAHUufKVRl7Lhrw
         mD3BlgOq9BjY9auio47tCYFtTalb1n6XvfzHLgxaEAfcK6L2nx4Tnc4MtKCYGibBdnRT
         PZsSAB5RkuSshr+5X8fMcbTDraISIEp5EEvNdXLj8aR9L4e0Gnw/Jfluxihi4/Wk4nQo
         wxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629820; x=1741234620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbpE7A80HY+/Mdda5+FpAzRig9IYFvS6m/EoQDwpXAQ=;
        b=kUPaefdVAgBcz2rBKTf4NWMdIoEWK6/hccg9Wlo1uXLuU+OAGA7VlwiA69NqgwnkN3
         hTEhFUDZduu4iS7zLOSPOLYX9JBKsdoFVB0kxms3WwZGewmH6tNYH3rTho6lV+2xXzLA
         WhFxIRhIfjNn2kD17ZaPZYM5UUdfxltRLH5q6Hzj/Sk2Ou1ra8+sVfScsQ/7abcGXkig
         X0hYvszD5wgnIbkDzdhPxKf2aWcztn4nSC+b24C3hdUnw76csv7myh9s45g1CP/rFmg/
         GoXOqJraoPY2w4ogErSjneG5hNEwa3rlC81pinbAHma+Uc+1Np/BguVwtH/375lpRaFX
         uxMg==
X-Forwarded-Encrypted: i=1; AJvYcCUws3T1HhsMftAcRBT5URj8JcfDzBxyIUCWiNS6OluyrfznTVhe9lGbSU2VN1LTh4FKBJG+DPr8bx7I+Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2D4Xyf7VTgwlIb+AU55uNRFzpM9B4GIQudxEvfs2D+AjRH8Al
	epgzu2pjruMyK8ujVPE1o21SePniSj94Gf1xnQRB4EIFv/swCEjCADXCFVQ8t9Q=
X-Gm-Gg: ASbGnctrdVA7jhgyWCRFluzog9lo1KQxH8oZDH4DKg7DfEEgxpgJhhaGQEaUV5wmduS
	eTXnQfKY39/U7+Q8T4U8MUjL9E9gDuwa+LWdn6qVZCbfJV3PMrJxwXUPeKi0ZIfqR8LBLcDKIBO
	L3t/oAyCjR/PqYpVU4/46E7chRHxQp/r3uMKpc4Js7tGyArNmtznKVuAviUtyn94dRr1woGERPb
	L+cNpW2bFpsekLHwcH5BW5qGnmGEWEKmDFGM/Zr10UuKRqYQ2dsggwb301DGrlVYxc8dmGyAWDK
	rbgLkoQbp3D28H5sD+ar17mv2Wk4ymmXdH0T/zwUNIXdnWaTWfiP6tjS43EsatplsfrvwR9Y7i/
	Y/FPw/Q==
X-Google-Smtp-Source: AGHT+IE5VURtJx3akR0wW8QuRF4r2+WixtLJlHwmRqGjmXOtaF1CwM79EnenRC2OLvGzgMnEngZwiw==
X-Received: by 2002:ac2:4e15:0:b0:545:c7d:1791 with SMTP id 2adb3069b0e04-548510ed5d4mr6767391e87.43.1740629820504;
        Wed, 26 Feb 2025 20:17:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441743c4sm61550e87.49.2025.02.26.20.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:16:59 -0800 (PST)
Date: Thu, 27 Feb 2025 06:16:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Nikita Travkin <nikita@trvn.ru>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] {vision/navigation}-mezzanine: Fix overlay root node
Message-ID: <vq5dcsi55aqn56h6ihysqk4lainhmjbyvot3jiqkxm3i7igsak@da5u6ro7rkvg>
References: <20250226-qcom-nonroot-overlays-v1-0-26c6e7605833@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-qcom-nonroot-overlays-v1-0-26c6e7605833@trvn.ru>

On Wed, Feb 26, 2025 at 07:29:54PM +0500, Nikita Travkin wrote:
> While considering to propose WoA EL2 dt overlays upstream I was looking
> at existing overlays and noticed that some of them are broken: they put
> seemingly meaningful fixups into the overlay's "/" node, which places
> them into the overlay "metadata" itself, not into a fixup fragment to be
> applied to the actual dtb. This series fixes those two by changing to
> full path "&{/}" which should work as it was initially intended.
> 
> See demonstration of the problem below:
> 
> $ cat base.dts
> /dts-v1/;
> / {
> 	compatible = "fake,board";
> 	fake,value = <42>;
> };
> 
> $ cat extra.dtso
> /dts-v1/;
> /plugin/;
> 
> / {
> 	foo;
> 	bar { baz; };
> };
> &{/} { whatever-comes-next-after-baz; };
> 
> $ dtc base.dts -o base.dtb
> $ dtc extra.dtso -o extra.dtbo
> $ fdtoverlay -i base.dtb -o combine.dtb extra.dtbo
> $ dtc base.dtb
> /dts-v1/;
> 
> / {
> 	compatible = "fake,board";
> 	fake,value = <0x2a>;
> };
> 
> $ dtc extra.dtbo
> /dts-v1/;
> 
> / {
> 	foo;
> 
> 	bar {
> 		baz;
> 	};

Is this behaviour documented somewhere? I'd say, it would be a surprise
to me.

> 
> 	fragment@0 {
> 		target-path = "/";
> 
> 		__overlay__ {
> 			whatever-comes-next-after-baz;
> 		};
> 	};
> };
> 
> $ dtc combine.dtb
> /dts-v1/;
> 
> / {
> 	whatever-comes-next-after-baz;
> 	compatible = "fake,board";
> 	fake,value = <0x2a>;
> };
> 
> In the resulting dtb foo bar and baz are missing.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> Nikita Travkin (2):
>       arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Fix broken overlay root
>       arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Fix the overlay root
> 
>  arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso       | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> ---
> base-commit: 8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad
> change-id: 20250226-qcom-nonroot-overlays-bfe21d33be8c
> 
> Best regards,
> -- 
> Nikita Travkin <nikita@trvn.ru>
> 

-- 
With best wishes
Dmitry

