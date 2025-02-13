Return-Path: <linux-kernel+bounces-512986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6CA34020
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED2C3A9B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969CF227E95;
	Thu, 13 Feb 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fO/1QNBH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FE23F420
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452699; cv=none; b=T7XAVGYMS5mDLTGCdWjTYAIl5Vb0mLUqINzE1T5xJSnHY9EHofVk9U4j4ktyMeRV4R3AcEoewb1WDgSR4ZAzkuaLdvo6LNZCuMBLiBf6HoU0maWUH5Ol6ebytsgsJjuhSelBBXwrLdu+PEPTIXxbwDi7fVo19hp+0EcCRdxINFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452699; c=relaxed/simple;
	bh=VYOekO3BhgmyJ2mRkTHWmdQc7mvwMTx6VCsRCmwif3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhmvphR/P6gNnA7jtREZxSQ75jPtfZml4KTDdV7Ch6k9mCLHQKnEdUusI3MU+p1uOrHTeI4RzF+4CbTlsidkw2/N+N22dmrZvodk0q9ivOBnyICDvXlVDxcECoWVdCpauZUbDYXXv47IjXt7V9qEAqHeIefoxevFG13StMqYXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fO/1QNBH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43957634473so9412435e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739452694; x=1740057494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWhe4fmPRfS/OuuLJyzpwpMFHkOJTb48vA//XF7nq9c=;
        b=fO/1QNBHYu64PUCvliYqzbVO+9vtspSOPymDC4RZwvxk/2ngkxyt5z/MoPfpV139eI
         zBQlLsTYrhcv8XMHQAmkiU99JE1zT5Mo50pPcGqjgESyrsiMlktaNGpV2nhplgQgbfQ6
         iI86K7iDM7vTw+OdMbKFmhDgEotvTfWKdLdyjmJP/UHvK55rR972ko/q5KTIrZjR9LGG
         mX6fgBsPbSxLlD7LOBwzJRLO1bohK1OmQGtWgQpQla0NDzEAk3RxqSmZ2OkHCQKGk1LQ
         i1m8xcrKRAT8+TDAzpevtzzsZWZX2RkbTlKggZoJEfOp99QW169iFBsTLd+JBm9nrjqk
         LE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739452694; x=1740057494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWhe4fmPRfS/OuuLJyzpwpMFHkOJTb48vA//XF7nq9c=;
        b=F6UIOIb6ehSWQl0NPuOBABKy1bdiT/o8KgEWddHPwCTn20Mdg94bjdHInmO1aLJHn+
         xjMeB3YP6ce/BdaQ8xVn6W0tMBQMDwm3DKOraLnlX/U+j1Ydsn0ATphgHN/mUtf8QUVa
         p8BnTlOhTgrVSlVoK/333xjXf5wiovTheyBSmz7FGYU42qdYnE86/IP10PoYSyjx1RL8
         8gMA2BH3nqeFQMC07ZMWLvmcjdLezMVlrmhW/DQdz1Z25RX+wRj+Mx85TidujJGbBQuL
         hTzK4EbHrYnRWA78c/vWJSpq+kyeGnqhiWwSPRjtRaSKgf4mbV3rgin40LfxGBTZwl9X
         T+9w==
X-Forwarded-Encrypted: i=1; AJvYcCWqIVAEWWtfxDGws2FI8sQICJjvVdnOLoRM0/Dxr7JTUancVuM9rYsI12NBa/t+q6r7b/DDjEhFk6rUYpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIquQBXxsAHucoM7sIfqNRi/qf0Us6a9qW+JUp3DtByueWYue
	KSnhidEGHuuCZhwTjwxJq/FO/3thGCMhcGEEIIjtGOxDwesb91GYhxLljECu+Ag=
X-Gm-Gg: ASbGnct+zoFGmVOYY/mdB61F3H4+7V1t/Tz/L39OFClRmGoJvxmwWMMD4tcmEnCRlmI
	Jvsi1qyZ6kJKQDzhCLKFbvGar3HuN+hqnBns33IwP5Nbr7bC2MjO1yn9fp6+s+8euYSW9dZvHiG
	mh0RIR9HOlUj/IfSoPnYJQV0ORCgQboSelExde8TIFEvED650tC749IhrUyKoF4lKMo5eGZcH5q
	355zxGiZFYLcq7I5jJTlpGL+ChtW1CjLRx6EIfOgHOOIT60LyX2lXol7XkE1jKcD6ilOTyUizNt
	EVWY3RCyfR8HC6TFyROepzsNgFA=
X-Google-Smtp-Source: AGHT+IGHqjRAk+WlggZTFqzb819IIhxvnxQcq7g9sio13JgVwPMgDgJww0I8NXCQ3krJi8bYVfB3tQ==
X-Received: by 2002:a05:600c:3b92:b0:439:4c83:2b8b with SMTP id 5b1f17b1804b1-439581b192dmr69872385e9.19.1739452694323;
        Thu, 13 Feb 2025 05:18:14 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:5695:683f:dbf5:a2f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618a9b03sm17254135e9.38.2025.02.13.05.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:18:13 -0800 (PST)
Date: Thu, 13 Feb 2025 14:18:09 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Add crypto engine
Message-ID: <Z63xEdcvCRHchHWu@linaro.org>
References: <20250213-x1e80100-crypto-v1-1-f93afdd4025a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-x1e80100-crypto-v1-1-f93afdd4025a@linaro.org>

On Thu, Feb 13, 2025 at 02:44:02PM +0200, Abel Vesa wrote:
> On X Elite, there is a crypto engine IP block similar to ones found on
> SM8x50 platforms.
> 
> Describe the crypto engine and its BAM.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> https://lore.kernel.org/all/20250213-dt-bindings-qcom-qce-x1e80100-v1-1-d17ef73a1c12@linaro.org/
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 9d38436763432892ceef95daf0335d4cf446357c..5a2c5dd1dc2950b918af23c0939a112cbe47398b 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3708,6 +3708,36 @@ pcie4_phy: phy@1c0e000 {
>  			status = "disabled";
>  		};
>  
> +		cryptobam: dma-controller@1dc4000 {
> +			compatible = "qcom,bam-v1.7.0";

Hm, I would expect this is at least "qcom,bam-v1.7.4", "qcom,bam-v1.7.0"
given that this is a pretty recent SoC. I don't think this makes any
functional difference though, and we don't seem to have it on other
recent SoCs...

> +			reg = <0 0x01dc4000 0 0x28000>;
> +
> +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			#dma-cells = <1>;
> +
> +			iommus = <&apps_smmu 0x480 0>,
> +				 <&apps_smmu 0x481 0>;

Should be same as <&apps_smmu 0x480 0x1> (0x1 is applied as mask to the
SID, and 0x481 & ~0x1 = 0x480).

> +
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;

Please add "num-channels" and "qcom,num-ees". Otherwise you risk causing
crashes if the interconnect listed below isn't up (anymore) when the
driver probes the device. See:
https://lore.kernel.org/linux-arm-msm/20250213-x1e80100-crypto-v1-1-f93afdd4025a@linaro.org/T/

> +		};
> +
> +		crypto: crypto@1dfa000 {
> +			compatible = "qcom,x1e80100-qce", "qcom,sm8150-qce", "qcom,qce";
> +			reg = <0 0x01dfa000 0 0x6000>;
> +
> +			interconnects = <&aggre2_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "memory";
> +
> +			dmas = <&cryptobam 4>, <&cryptobam 5>;
> +			dma-names = "rx", "tx";
> +
> +			iommus = <&apps_smmu 0x480 0>,
> +				 <&apps_smmu 0x481 0>;

<&apps_smmu 0x480 0x1>;

Thanks,
Stephan

