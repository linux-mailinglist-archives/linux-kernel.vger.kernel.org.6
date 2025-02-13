Return-Path: <linux-kernel+bounces-512984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF84A3401A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E593A9B41
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78A3242906;
	Thu, 13 Feb 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ti/HQKA1"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961F242904
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452651; cv=none; b=hSpHUsNzszQxuQAcmCNq8LTXEjI2zvNZhTau2Xehlax3X/hCiT0Tgvos0mljywk3ttXXXtaJ8nRlgDy8jsGspjqN7cCmBpS9uOUPQilsF6MlHrUtLP47B85r8IgdvaiNSofe3dwu1paEM1A2mBBA0y+chDhp1LvojNdmTLy8NAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452651; c=relaxed/simple;
	bh=twos7VfiREI1lt7gyyuE3NukwS7GJ2VzxwoMptj2Rn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td5lAG+lNKUMV9vGG4RVv2yxDEa+aoT3d3SO1S0Us+2TGv9bkiLwDQr8/Mg9INyu/LSGeXD3Mbdkq1ifILspoJ+oQq7PsBeryy1b798OYoyHez2d5M0yQqleP4bunM7TKG73GySUEppueFc1gsCoV3rbw9PImILlgcm6DskzB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ti/HQKA1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5450f38393aso771358e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739452647; x=1740057447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDPL6pwh9XndS7ixZg6tkUnBBXi8JbHU1IwBI+r54wg=;
        b=Ti/HQKA1djgCEHPW4gGCrpE9Hqlk8r9OfGTUE7Wd4ld0pKZkd3ZMtEcogoABEavxX4
         gR8sTHt8aB/quVbCBLrzShhwpCFDyytOY3xz5kCNn26npq0Qk6LAnj0wu86ga/U+/Zx1
         luv0iJ5bvaoWQ9Rse3uwqU6bOKi54KDf5Upjy2Us9GZZLOM/1nKi/jPpSUynSUPlEKVu
         nDmfXitw5C8dBKsYzlfoiBVekYVkCmTXAcfYPblxxclX6RBde9CycaccW9c5K2iTOups
         KHfsSHFggaJ26cnjmgNoHcJBH0XWg+l4AB4VOM+dbyUjnfH6XJrVrAoj6EDz33hoMpw2
         FFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739452647; x=1740057447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDPL6pwh9XndS7ixZg6tkUnBBXi8JbHU1IwBI+r54wg=;
        b=KXdXLlPJKm7pHzcxpeTlWn3Ksdpc25A3zWgQgAS6diD75AdfVX4qYHXXFd6LnTbuQH
         SaXFmPAGwTYLSrkb+6ymn90+C/XzrFDZ7S3VmpbcsLmDr7zsPX3m2uM/TuYOD5y/F7lX
         V/B6ZDhpjrhOJRkBqNPjn3JDNeBH6Qw0izL7ko5k/3o5RXpoN0cJZiqC0T7XgVeW3A3S
         wwQDAY6IA3wqyZ5z709k+WNaRkCYdqXhLHIufjJjlbfKachwQ0Xu4ISJe2hCNLjWbmKZ
         QDFucf8SYdtEoTKudEyv6WWba/soR6IZNu/5OIm8xspmmgpeuUoC8jbQ++PWxV1fDFYN
         T9sg==
X-Forwarded-Encrypted: i=1; AJvYcCWtj8x5EP9mvgPR2aWpie39V0qV1cOPiAFjoOFTC/NtJtRrHUGFg9HqA+w/r8T90YFY1FaUF5ui3JGAW4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJQn57DwXDyiiEVMuxGPXiW8tirPsFJ8O/e28I+zEVSO/OixA
	UeoTb5lJIFsU1Big+UbEByNI/tEy43ksdQz6v+JP+0gMnDcgBtvJOBfomuBq5pc=
X-Gm-Gg: ASbGncvBVv5ORvWKrEoLDsWrbcGzSbUcB+SZsvpm+gchbJ43nCbCl7jmt/oSfZdN8qJ
	J1clJcavI2jj1aAt3YEch3R7+OmaHgr9lC8W4lNNWiIGk/4TX9XYDZuxJbO2sgPDzpvEmPJYSt1
	9VODPgHUeKKgL/BNxlmI0hKeKeVbp1Yebo2g9BDOjrOBLv2wO3KipFDev3a0KpHpK9FB01nwZ6x
	1k7QSIQnNx+n+jqQi+eiJ/eCu6XJM9xpM9K79GFWhGUYXm2kVM66MqyV92/SLt07Dh8MxrO/MV2
	ogxKVxOTjM3TDvljasWXLXW8z9O2VPWT5c9TD9YzAK6TO9SSACYBeLbZXDz4MqvvGDZ483o=
X-Google-Smtp-Source: AGHT+IEbRbF6dkll0oMN+nTaE2De1fjnXOByxIocahjqxLVMhtL0WOpihglBcb99LvBdKAgDOxR9iQ==
X-Received: by 2002:a05:6512:4024:b0:545:bf4:4bc7 with SMTP id 2adb3069b0e04-54518282f24mr2585384e87.19.1739452647405;
        Thu, 13 Feb 2025 05:17:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09b21esm176186e87.62.2025.02.13.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:17:27 -0800 (PST)
Date: Thu, 13 Feb 2025 15:17:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: ipq5424: Enable PCIe PHYs and
 controllers
Message-ID: <rikpqwgeitxengmlhahnl5nzk2skityqmgurjx65fjq4q3nejq@6pqmbvaqkcz7>
References: <20250213071912.2930066-1-quic_mmanikan@quicinc.com>
 <20250213071912.2930066-3-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213071912.2930066-3-quic_mmanikan@quicinc.com>

On Thu, Feb 13, 2025 at 12:49:12PM +0530, Manikanta Mylavarapu wrote:
> Enable the PCIe controller and PHY nodes corresponding to RDP466.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V4:
> 	- Added a new line before status in pcie2 and pcie3 nodes.
> 	- Dropped 'output-low' property from pcie2-default-state and
> 	  pcie3-default-state nodes.
> 
>  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 41 ++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> index b6e4bb3328b3..e73f61266012 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> @@ -53,6 +53,32 @@ &dwc_1 {
>  	dr_mode = "host";
>  };
>  
> +&pcie2 {
> +	pinctrl-0 = <&pcie2_default_state>;
> +	pinctrl-names = "default";
> +
> +	perst-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;

Don't you also need wake-gpios? Here and in pcie3.

> +
> +	status = "okay";
> +};
> +
> +&pcie2_phy {
> +	status = "okay";
> +};
> +
> +&pcie3 {
> +	pinctrl-0 = <&pcie3_default_state>;
> +	pinctrl-names = "default";
> +
> +	perst-gpios = <&tlmm 34 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
> +};
> +
> +&pcie3_phy {
> +	status = "okay";
> +};
> +
>  &qusb_phy_0 {
>  	vdd-supply = <&vreg_misc_0p925>;
>  	vdda-pll-supply = <&vreg_misc_1p8>;
> @@ -147,6 +173,20 @@ data-pins {
>  			bias-pull-up;
>  		};
>  	};
> +
> +	pcie2_default_state: pcie2-default-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	pcie3_default_state: pcie3-default-state {
> +		pins = "gpio34";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
>  };
>  
>  &uart1 {
> @@ -166,4 +206,3 @@ &usb3 {
>  &xo_board {
>  	clock-frequency = <24000000>;
>  };
> -
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

