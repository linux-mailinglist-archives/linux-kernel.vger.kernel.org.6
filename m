Return-Path: <linux-kernel+bounces-422317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1862A9D97BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1AF2860FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B382E1D47C7;
	Tue, 26 Nov 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMYVFlay"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AE1D432C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625767; cv=none; b=nzUQs2aZDR2ITDrWkcCzMLCnlBL7jTPtK9Uf//JiBWtfRLVv4Q+gLNQJd5P3gMjm1dsxHQfAs1jNR1oR+yaOoYvmng4LRqD4IdhaX7u7o5RmvBNOCr8lK6oc3F6osctPXld8X0oPrF1w2oaVU+HEXRVUEtmoa/XbC9ze+/5qH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625767; c=relaxed/simple;
	bh=bzBJ5ySU8iyC+cTGOrqLjv/wf4htjtDCeE2Z/8l0Yew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7aziQlBOwlbuhdq1rpL4dxKKjjZtf1RJgix7pwzs93cx7OLnWFv/AffgQ73848HWSrzhdedICtwQN/DamAXFbSA6daikSrrVEs+xhyret+85mgwnsAs2Nes8PWQ0xFdXnmc0Lfj151pnzzTEUFoSBCnDSHSDEC9FqxdH+NYW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PMYVFlay; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71d4c462ab1so935191a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732625764; x=1733230564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dXE3QYJ5LikeczgQTvHoKWrWw3sPXnz+0dNSvQEom74=;
        b=PMYVFlayZbYKDjEyVTe5fZj74kzP54VAZ/lHXm4fqVF/LvelXMGdUopWDfJG+A7TIH
         Wdc+NeTyppMffNMciIJvha4WFY03DoVCPJo4ecBg3U/waVbaxQdlLkKDVdJ45I1CNkAw
         3M+qZ6RrcME5lTjpnYFihsS8u8nlECyxbuo1PdKc18EukNyl0B3WmAsxe3K3E9u3aRKF
         Dk/Ff/tifeLb+TWZfcioitKpzsH3KY+dm5iEjXoS78Mxki+GMLqooWzksW8yBWj0jSM5
         E7g41da/hePC55oE3iCmQSYduxKwgQXFbfcT6WyXfBaotmly2kf1xwUXJEM6XyllQDd1
         l5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732625764; x=1733230564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXE3QYJ5LikeczgQTvHoKWrWw3sPXnz+0dNSvQEom74=;
        b=FUZli8N/UKtnB43Div9fWIUboXfrBBFvUZsbwov1d+hQnGmt1/M5BcyUwfTLt6KAsY
         a11NNWdNljVoFYRJUZgWuKLlEjLjmStpxerza/ik0gS7jdwbv8XIW5ngTUzgVPpYUF/B
         gi4QmsYsYs4RGAsRn+Dp4iSla12Ay+hLhpxkyaBAPeiHT+bE0VOQq5bMdJf6iI1XkfGk
         JQsGmq9sJ2SremnuHoexOvus2iv/b57ytFjquG7nIC9adTGiW6TxueC8k/oC9tlrdka4
         cR/w074mGvBGM8v8iE7cAveWfNxFKSVVE9kbnhIFRnpmyTIBZ4VmoDvpirejWfUL2rLV
         6Rtg==
X-Forwarded-Encrypted: i=1; AJvYcCVYvpoflr1FBU1n3QrZEYlZLmn6GxzREc7LM9Eh9YIO9IG69H5tR+vHLMdIRXTid2HIFbVOr2dDEmpSn3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGruFKRxMKAVpQV5m0ZnLuRqReq/yHkC7myNPA3bpzKM6tb6UE
	SZzcnUbFEEbKQr7yC4+FISrNhoYCrjGbY7XklhycDUbZ5AdXyE4ivuhanQ+vQw==
X-Gm-Gg: ASbGncuXerqYDeRYiQo/X04LAXid6MSQOrt4lx4ne43HvFZdPoXhklBU5V9Z47VuFU/
	vGip2sRBnpbO0rreKl1p9xGLytIABQc5UCqHpz43Tm8Shd1Wx08kn8laGbVAUvVsa9EQb1pVJkv
	Z99EV6P+QiiiwI5meR/nBlPHL1/DArkiMIdr4pJIDbZA8wonlYQM5KWjJuNzi/mATGbNlZHKhbe
	Uvx7ad5PxyBsmKP91hOhrgTf46KOfZg+aJb3u/Bs6GneScJNtYYNCq9zXPs
X-Google-Smtp-Source: AGHT+IFNm2gT/rtGSM3QDKFPVSFCgKiQoR/R4Xr++om1Vj/nQzObB88rsH3X/oaoAwNa1JWVmpMuRw==
X-Received: by 2002:a05:6830:6403:b0:718:4073:62bf with SMTP id 46e09a7af769-71c04b7eecemr17953453a34.7.1732625764057;
        Tue, 26 Nov 2024 04:56:04 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3de284sm8598526a12.55.2024.11.26.04.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 04:56:03 -0800 (PST)
Date: Tue, 26 Nov 2024 18:25:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8550: Add 'global' interrupt to
 the PCIe RC nodes
Message-ID: <20241126125556.oncvvkyrwj5s7u65@thinkpad>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
 <20241126-topic-sm8x50-pcie-global-irq-v1-2-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-2-4049cfccd073@linaro.org>

On Tue, Nov 26, 2024 at 11:22:50AM +0100, Neil Armstrong wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPUs. This interrupt can be used by the device driver to
> identify events such as PCIe link specific events, safety events, etc...
> 
> Hence, add it to the PCIe RC node along with the existing MSI interrupts.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 9dc0ee3eb98f8711e01934e47331b99e3bb73682..44613fbe0c7f352ea0499782ca825cbe2a257aab 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1734,7 +1734,8 @@ pcie0: pcie@1c00000 {
>  				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "msi0",
>  					  "msi1",
>  					  "msi2",
> @@ -1742,7 +1743,8 @@ pcie0: pcie@1c00000 {
>  					  "msi4",
>  					  "msi5",
>  					  "msi6",
> -					  "msi7";
> +					  "msi7",
> +					  "global";
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> @@ -1850,7 +1852,8 @@ pcie1: pcie@1c08000 {
>  				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "msi0",
>  					  "msi1",
>  					  "msi2",
> @@ -1858,7 +1861,8 @@ pcie1: pcie@1c08000 {
>  					  "msi4",
>  					  "msi5",
>  					  "msi6",
> -					  "msi7";
> +					  "msi7",
> +					  "global";
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

