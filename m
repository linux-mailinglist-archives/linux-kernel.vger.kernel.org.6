Return-Path: <linux-kernel+bounces-529407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C20A425BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7649424E79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484918A6AD;
	Mon, 24 Feb 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJfNoUym"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C73282F0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409283; cv=none; b=ZI03NJUuu01Y/a3XE7vDk4jS2gDHkvagJARni4RPs1PVA9bwNybtKwPrMgG8aAZaLD1+I0O2r/nLDiHjCi44xWL5Zs/NiAbfLMyRGzqgGFhMyhH708xoWiiGlMz2F3cbXINJcmdiA4sF4rYaDie5ItRr33HAW8MvsodheZTgxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409283; c=relaxed/simple;
	bh=e+fGuFYihqFYKDT1VXWhmaDTiPW7MSXQnExkELgZB6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adKm/2uyifv2+rjhbKHL908Buh53B/sQtBv1tE3Qi2GsstF7OapnnMBgy9gCZ594kSc21RxjdfW+tjDHOmYyabqhRlS7nywiaqiwQYWrkQ/ANPden9BzFM3vFhXBRau/u+CITsLTjkL68hOiKKYPiNolZO70jYmw1swzyhjTrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJfNoUym; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4399d14334aso39631405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740409279; x=1741014079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zO1QOaq79Jegtn1MMv2Nhkvx1JoPb9ukrAV5cHqtoJE=;
        b=VJfNoUym/jxU9++z6JczaRxwt/hiuS8RTWEHMH6PcA9W+j9/usBHvEftu8zlGV03+C
         P/Gd9taEiBjMGRkGxueuyJ9oM8njL9NsqnZxZS4j1UbRZuBzZZIbSid5oZ+suBjp8reu
         E1mWhDoOzbQnf/jzfejHhh3RXk0piUzR64JCrg4SD8e6wZ4Js5h7LqRN8lHc4g+kleUh
         xhi4FJ6xKv7ZkyDn7BCSBNphFzVT6WehM9v9K8j3+A3VZCz2gZPiNKXwuf785kCPS48i
         6zkzyD7RIsFpAyaSr9T5yBiX4Ly9E0yFmQnjxrh/Wl5jZXrECrg1qHo2Lzh/nrsybCph
         Uq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740409279; x=1741014079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zO1QOaq79Jegtn1MMv2Nhkvx1JoPb9ukrAV5cHqtoJE=;
        b=KTUWzwEQVbR6lCB86mbD5vfgb3WnLl79fi5f/LHokxpor73NplnB0si/qbGQZBx1jP
         jY+GqKzsHmUJVHr5JUVPnhOGZ6RiK0YPDQ6pONEFpRaCeUzEUSz8gTBQq9xGjrne38Mi
         Ko6GcVPnTBwtG81Z4K4NR2r33pL+aAiOtdA3ZcVjXhThZT27Mn/1l8r6ZqdI6V2ZqMNJ
         upURaqm97FOt+zd4kxgWUttgcf+YSfHvx/cVOHeJfZ3CuoMFtgpQAhJb8cpruj6/5pCq
         LRTP3KuTli395iAoLk9r9f6LuF+ttuSEln6gWmosrEJs6WxupCcUA/RS437LFvXaN43V
         nTFg==
X-Forwarded-Encrypted: i=1; AJvYcCV+atxOFHsZnwIRagpuh4g/pilkc1Hw9AGCgmsYVpqbtoLvLR/s+R5ZwyRV/iTbTOJllOoCdS9gjT9hvmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcGFOcEHk12FmhICsQ20Ni+MKQMTHb9utGvprbRYqZbdbtICz
	9y6qOOuSqovZh2zckfMWWt0335h1+pvyHeU3x2glM3CGtxeWJeh/5iVV+7LlE2c=
X-Gm-Gg: ASbGncuL/yWxUxfuqOl6AUWpQQgOapDiRvDbG7/M75lP3GdvjXRvRaz2NFDn3ezyuLi
	ZF/GzwheSQphWXwChP3C8ZYrcc4PIlCriuxoN6GB/9mShniBtbihWhHt4kzji9LS1T3OjMU3ksX
	1yDrIs/SMz8LIvBaeIfZn5JLueyJPRz4XGw3wOmV9moM7jpDvFNfzaXLqWyhZhDz3Dhojuegiy8
	2Ft/FxnBmPUqC7zSRUCLLvhapa3BR1TAme151bpKryWodWx65HItt7Hj8HjEOyr1x6twUBXeCF/
	xLoyLuZDu3gczof6Tu95haUeDGRw5yfhawEpkg==
X-Google-Smtp-Source: AGHT+IHy32IsayllVzcL5y6Hco/yU7QMFhwvQV+h4VDJSb2zJULlU9qCiE/moLz0IrzCr+zonZR92A==
X-Received: by 2002:a05:6000:144f:b0:38d:bec9:c8d with SMTP id ffacd0b85a97d-38f6f0c6be9mr13502818f8f.53.1740409279076;
        Mon, 24 Feb 2025 07:01:19 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:dba4:b92e:251f:5bd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b434fsm32352273f8f.16.2025.02.24.07.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:01:18 -0800 (PST)
Date: Mon, 24 Feb 2025 16:01:11 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100: Add crypto engine
Message-ID: <Z7yJt4ARAM39F9b6@linaro.org>
References: <20250221-x1e80100-crypto-v2-1-413ecf68dcd7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-x1e80100-crypto-v2-1-413ecf68dcd7@linaro.org>

On Fri, Feb 21, 2025 at 03:07:03PM +0200, Abel Vesa wrote:
> On X Elite, there is a crypto engine IP block similar to ones found on
> SM8x50 platforms.
> 
> Describe the crypto engine and its BAM.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> The dt-binding schema update for the x1e80100 compatible is here
> (already picked up):
> 
> https://lore.kernel.org/all/20250213-dt-bindings-qcom-qce-x1e80100-v1-1-d17ef73a1c12@linaro.org/
> ---
> Changes in v2:
> - Added EE and channels numbers in BAM node, like Stephan suggested.
> - Added v1.7.4 compatible as well.
> - Link to v1: https://lore.kernel.org/r/20250213-x1e80100-crypto-v1-1-f93afdd4025a@linaro.org
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 9d38436763432892ceef95daf0335d4cf446357c..71d5f5eed4511030a51fb12e453f603d294080cc 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3708,6 +3708,38 @@ pcie4_phy: phy@1c0e000 {
>  			status = "disabled";
>  		};
>  
> +		cryptobam: dma-controller@1dc4000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0 0x01dc4000 0 0x28000>;
> +
> +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			#dma-cells = <1>;
> +
> +			iommus = <&apps_smmu 0x480 0>,
> +				 <&apps_smmu 0x481 0>;
> +
> +			qcom,ee = <0>;
> +			qcom,num-ees = <7>;
> +			num-channels = <30>;

Hm, the hardware registers report the same as SM8550 on my X1E CRD:

			qcom,num-ees = <4>;
			num-channels = <20>;

[   17.679161] bam-dma-engine 1dc4000.dma-controller: bam_init() ees 4
[   17.679163] bam-dma-engine 1dc4000.dma-controller: bam_init() num-channels 20
[   17.679164] ------------[ cut here ]------------
[   17.679165] bam-dma-engine 1dc4000.dma-controller: DT specifies num-channels = <30>, but hardware reports 20. Please fix the device tree!
[   17.679175] WARNING: CPU: 5 PID: 121 at drivers/dma/qcom/bam_dma.c:498 bam_init+0x10c/0x150 [bam_dma]

(You don't have this warning yet, it's part of an upcoming bam_dma patch
 series from me that will start validating the num-channels given in the
 device tree.)

> +			qcom,controlled-remotely;
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

iommus = <&apps_smmu 0x480 0x1> seems to work fine for me, can you try
again? Not sure if this is related, but make sure to apply

https://lore.kernel.org/linux-arm-msm/20250208223112.142567-1-caleb.connolly@linaro.org/

since that can easily cause crashes for bam_dma. I added this diff for
testing and it's working fine so far:

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index afb8bd3b6a94..bac3d6a38055 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3732,8 +3732,7 @@ cryptobam: dma-controller@1dc4000 {
 
 			#dma-cells = <1>;
 
-			iommus = <&apps_smmu 0x480 0>,
-				 <&apps_smmu 0x481 0>;
+			iommus = <&apps_smmu 0x480 0x1>;
 
 			qcom,ee = <0>;
 			qcom,num-ees = <4>;
@@ -3752,8 +3751,7 @@ crypto: crypto@1dfa000 {
 			dmas = <&cryptobam 4>, <&cryptobam 5>;
 			dma-names = "rx", "tx";
 
-			iommus = <&apps_smmu 0x480 0>,
-				 <&apps_smmu 0x481 0>;
+			iommus = <&apps_smmu 0x480 0x1>;
 		};
 
 		tcsr_mutex: hwlock@1f40000 {

Thanks,
Stephan

