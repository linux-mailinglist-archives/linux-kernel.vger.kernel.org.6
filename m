Return-Path: <linux-kernel+bounces-306478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B7A963F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49977B2368A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8615718CBFD;
	Thu, 29 Aug 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFeu46MM"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7818C927
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922608; cv=none; b=l7A06mkZAzR88eLLo8w3P5Cs1ejxtxW2UiQ6QhBgGkiz+22BlgZ3LWRm8kNPmVmL8Ue/YggPAM2Az+O5EmDgPbIpqSLgrHxGJoKNyvgjI90VbZSgnhmwPFDxWxSUs/Y39dOiRZe6Ka0dsjwm9CODesJXY+DrLHJsdGz+gQ05/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922608; c=relaxed/simple;
	bh=tYHbZEyPmka4Yivy4HduNryMYDS8i6bX02kvNnY6E60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMuznenrXKGVVFraBn/voCYs9hFVgrz3jq9ltofnjCIYUHSuu6kpPU/7HGg/ZbPUgIsAnDNT7sQF6xulYchX+poifSzUw+43SPV+zGUaV2Qgof8yyrF8d0/kRusyq2azKJildBqzr5AmRGeEPpXGmAr4yn4bLnMToQZnAdD2jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFeu46MM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f50966c469so4810081fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724922604; x=1725527404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6NBn/HAssV3X2fUR8nleuDhVgAPEyHrLktSv5/fXyE=;
        b=kFeu46MMO6icQAvijxpfRGAQP3wq8BZnztYdcxKH2HTqfwCy1/Ek3nUFE8MMfEy8hb
         uiWDGQj+y/UTT6srut4r+o8CfbfsB+/Sk5FRKQ35tJj7dVabqkdZ8KHQfhZ9PjpQu+Gz
         IrBHVn3hj3unhNdhPSfa1P3BAF2K1WeXs+q6wp59jk3AN0G1w3a34Kcd/ZWFCVa4UFUT
         iPOKkEGcb+SaM3wMJhooQjntVn13K2h/YpUT6Tq7ZjoyFYx3Nbck5zrLNDDSNJfGPoBy
         vrhwu9+2BTwzxrJGycXsJalYX4rz8pVFSkX3NEKOhauLT9EQNPJnWE4WUyun6ZpW3uzT
         mWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922604; x=1725527404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6NBn/HAssV3X2fUR8nleuDhVgAPEyHrLktSv5/fXyE=;
        b=C8iwm+ksjr7im0Hhb6xDM3bUVFW3MrvfyNPbL5wnJK+fdktPac5f4gWCowGLJIg5z0
         VWxxUVEXFZFSCw7JlSDIURSA9WbdJaXH2diHrs+NhLJpnd7t0S1FxHVM52JaGVIq6q3l
         obQBBgXcs5TvBnQaGzBHr6cznLR81UTEAj/Go2pdyDMaYEdDIiXbXIEx9z4qHQi7oCS5
         XclS53f0UFPZUpzSWQ65ep+G442Rn/qif/2yeS2Y8nMlvaS/UXoTqcisCaxzOcmVxaq5
         m0j+GofpkKqCiNfq8ux2fccE8nWHRuyQIPDo4YCMlc1N1hA/gXD61fNFsdJF2MiAqwww
         /XJg==
X-Forwarded-Encrypted: i=1; AJvYcCWibB0G7xilgggx1AUX/H6C23WL2Ls/KOYNW9Un9iuA5hQdDBsR0YOFZ+XqVUJCOXYxJrJPwakA4LKRbdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRdaj0SBCFktT+v+5nHFKgGkGuvOKfTPzIrWJBimwBUCkShL4f
	8LRBamJJZmVWOIXc7kZu8vIwE23Ezv83uP5zVoOUIlD7xA75FVLbF/X8q9gKBgE=
X-Google-Smtp-Source: AGHT+IFvfk0TEfgAeIuX5KuN0s5sCC0/zMMfp6eawrjxG3Ca1XvBQuxc+Kts21vRxC+bjEIR5246Ww==
X-Received: by 2002:a05:6512:3d9f:b0:533:4820:275a with SMTP id 2adb3069b0e04-5353e5bf517mr1240266e87.52.1724922603591;
        Thu, 29 Aug 2024 02:10:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540827b28sm100441e87.140.2024.08.29.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:10:03 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:10:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, robimarko@gmail.com
Subject: Re: [PATCH V2 6/6] arm64: dts: qcom: ipq5018: Enable PCIe
Message-ID: <nut3ru5rdjf3k3np47gqbpuczvpsuoismx6hp55ivc5mqmdglz@zyzbra46i6iz>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
 <20240827045757.1101194-7-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827045757.1101194-7-quic_srichara@quicinc.com>

On Tue, Aug 27, 2024 at 10:27:57AM GMT, Sricharan R wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Enable the PCIe controller and PHY nodes for RDP 432-c2.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v2] Moved status as last property
> 
>  arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> index 8460b538eb6a..2b253da7f776 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> @@ -28,6 +28,15 @@ &blsp1_uart1 {
>  	status = "okay";
>  };
>  
> +&pcie1 {
> +	perst-gpios = <&tlmm 15 GPIO_ACTIVE_LOW>;

pinctrl? wake-gpios?

> +	status = "okay";
> +};
> +
> +&pcie_x2phy {
> +	status = "okay";
> +};
> +
>  &sdhc_1 {
>  	pinctrl-0 = <&sdc_default_state>;
>  	pinctrl-names = "default";
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

