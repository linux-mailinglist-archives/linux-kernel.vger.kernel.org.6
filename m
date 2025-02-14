Return-Path: <linux-kernel+bounces-514606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A177DA35937
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473C61891597
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426D227BAE;
	Fri, 14 Feb 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKHT8AUr"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BFC224885
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522677; cv=none; b=XTyILWt4Eb/tWvRiP/ksfkOPedkv0hvbtxsC9zC4Po5CRpxNW2HQz6Z3DDzsPBLObY//5nB7YYKGXAcHsVq3uDrRrC0DoUvzEvHZwOuoGPIY4hr5AXf5ELBt/ABWHmscouDY5qAo6D3AFY3OCbjZVZfmfiJNrb0PmVyBgK8QOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522677; c=relaxed/simple;
	bh=fjEHbbRs5nHg4MXcaxjuv+AzQnmbn/LO1Vj4x5e+g9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgOzO1R6AeJaJuk5xYxvk0ZvqfaAx77DpTSd4Wcyw5NoGhcVQQt7TnA4t16UQpulopWtNT98ipUZCO07bKwL99t5Ur9qbTtq49EQ409HViiKMpem6aX5weOK/LePTL/+aaUEMCbLyVn9od//XV2O3kyH725PuZoiBQHwImWiet4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MKHT8AUr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220bfdfb3f4so37211215ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739522675; x=1740127475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ceqbqK+CUw72OCIX9AcVUP6vB2bb9Jm70S/zYtdneEg=;
        b=MKHT8AUrKJj5+NGFgdpVnBtQV7Qr9FhouA7dQTEm7h9eTo2AW+kPSuiO2Y5ai1sKCO
         a5d6RTYvfrjVsaE3M7HlaQ7yMWNTtqbUOSVLatewLxVBQxcuK3AoSZsnD7kLnfYeCVrd
         oauM6Rg3Ww7bFR+/wlnvusIgUtFH62FbZebphbP8W0TjfthwrzNb9mp6b01+IWpIDocS
         OG2poG/JMhq9syw/a4oE7KTMxhY8Uv3pcv7GxNKcvCOAdZKwBH3Ai2kxMsMym+qrTT7u
         fhNt3wmI2oI//opfS6E8zUBAsCvdNDb7a+krtgFcIFSZBoNnvUHy0nkyoC+WEToDL+Lu
         gG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739522675; x=1740127475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ceqbqK+CUw72OCIX9AcVUP6vB2bb9Jm70S/zYtdneEg=;
        b=gww6cxdHeV6PcUjAcml1JJAfnQu0hVt6Hec81+niHuwBCJDTraHC0028gBvZ0fbv6B
         rTbfRCEOVvw5p0q53eCoFbf3EeO5nR3O9XZ59FAgX2NE8ecx3B1JqiA4fLJgppU7dxxT
         ePAUNU0mxAiHG2rQCasZYkTynz1571gUl8mZ41FkYxzAA9M4BLuDucU/rXZPQV70x+uQ
         AcdUSo2asdpvzYdj9/Ok3zSrjTyybO5VvY8VLx52nAzkWvwPWoQvrBtABnN8PLSVWxRz
         LBG5XCA5VTtXCuiTuJTtXXVAEC5TNXSPwCVmNnOAIuOlh8WPz4AmTRbRngeY0dnTyMvN
         Fn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWD5BTcgDFyEqg6RcgRXtPGBx9eY/qxorJkopY7Zn5i9zdhBUS23XdxhLMJqGOJ3WTvDNRLeY12ejhE/5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0uKK2IFFoatJTjOJdTVksV8sdUqBd2qYi1KHNwxZK4g1YRZA
	RWz23ee9xxiqogse+h7bL3R7YAD8eY8zDrv25u6Qntgd/agWTqgdwk+P+csWRQ==
X-Gm-Gg: ASbGnctIj0VAv7QfPYv8mSQ7IXTgJDIZzSTOUNpD4o9WvAEI3b38zwHc/zoddbWYWMV
	RtCZtyMDEZN83bjs2pS58efWWc0p9MErZvWHACy86+HG6RAuuh4wpYH4zrU/qVFmnMgvrJPsMAH
	1os8AK/ilpuPmFmhFI9BlRjPlU/O1jbnaPPBbHlXElFNwc9ZctzOs2MQ/ymdeOaj5Wxz9BF7uFB
	RMtdra6SMAkhuPNiAsx1IFXaXlCry1RDIbs1MJO0cwL0Z+ls7uAgo7yDdieXWpGqGLcSs+oFw8b
	Ea7e4q59CpLVB68KCQl4ZqUoT9QQEd8=
X-Google-Smtp-Source: AGHT+IEN8kvNLK7tPERMpY3Zx8RkLW09NICOccWPZzuvH4t8jd8F+7P8elAc+5o7ai9jS7oByn15dw==
X-Received: by 2002:a05:6a00:1c8d:b0:730:9860:1240 with SMTP id d2e1a72fcca58-7322c39c33bmr15562042b3a.13.1739522675029;
        Fri, 14 Feb 2025 00:44:35 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:a164:8397:3a17:bb49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324254681asm2614182b3a.25.2025.02.14.00.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 00:44:34 -0800 (PST)
Date: Fri, 14 Feb 2025 14:14:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v6 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Message-ID: <20250214084427.5ciy5ks6oypr3dvg@thinkpad>
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
 <20250210-preset_v6-v6-1-cbd837d0028d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210-preset_v6-v6-1-cbd837d0028d@oss.qualcomm.com>

On Mon, Feb 10, 2025 at 01:00:00PM +0530, Krishna Chaitanya Chundru wrote:
> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
> rates used in lane equalization procedure.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> This patch depends on the this dt binding pull request which got recently
> merged: https://github.com/devicetree-org/dt-schema/pull/146
> ---
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 4936fa5b98ff..1b815d4eed5c 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3209,6 +3209,11 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  			phys = <&pcie3_phy>;
>  			phy-names = "pciephy";
>  
> +			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>,
> +					  /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;

Why 2 16bit arrays?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

