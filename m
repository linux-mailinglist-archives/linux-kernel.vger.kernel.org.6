Return-Path: <linux-kernel+bounces-205962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCD59002AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1F31F25310
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191715DBB6;
	Fri,  7 Jun 2024 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdjoH8kC"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D481AC4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761155; cv=none; b=EJqUfWsQoE7ow17B6OMs3zxav/3Nc/UCgipRoje2RZ0AxNUTrVATXjMo1jvtlrtk8KJAU99XI0Xkv5AGs+lmTJO4XfOlp28M+mmiM1vZsyYkr1kfhbw2qXwZFY1BUr1pSJw0AAn4N5r7zkAG8/4dnH8mHk2ayTIxrz/KrWxKalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761155; c=relaxed/simple;
	bh=fdeqPpnAPXCFODbGLL/diIQAGBeosl713q3KkJA/Vi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ/1Db/aPBBOH/m5MI6P+IJQhc5zs8pT/iWUqIKZWs3gJJ7Z12Yzh+wWkDbOZ6hlZ0697ETsMC5Ln5nFMNU2CV1OcYJo4RsWyOiDqexLa5lHtryxJp4gqqDAZUGX8DDXZxxI6bttmGpBVOfmq6lA35ayQMB0DFiKb7784HFdcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KdjoH8kC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so269988e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717761152; x=1718365952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfxTauYnQKQisjXwxnNunMTLSl53yMGzyCyy7lURrtQ=;
        b=KdjoH8kC+QYJK2zX2WdE4jNk7g0877KusHfjLaqEM0l4CgeLc61Dxto0QPz9me0xUX
         Zwmb0nwpqUg1vt2J3cc36U9UK54jg839gXBs+xHD81y30DkS0NGpnLdGRN0oV9OxlIr9
         VaeHT8flbB5CfpSIXvCkyRCFchOTOcarg0uuwby8FxI/vzzAawVGCKmGw5VUIAByHbdy
         GzMpBLE6b3dEupeJMCcrdLSiCZ9sJmDIpzto3BPDWUhUe/ZkuWtRUo9g4CRHENzEeFJt
         4ZimpqrD2orye5c4C1eOh2/5ok8UGqetwj/tldDQoyTdbfPxcb0PqTfk1KewmIo6ceKI
         da+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717761152; x=1718365952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfxTauYnQKQisjXwxnNunMTLSl53yMGzyCyy7lURrtQ=;
        b=qD1V37hnuGZTuBjjVuLK7N1sj1vUteVPZGqkwmVshUylppWFFz4hQoi3FmA47eNPqz
         zHJFPZZI259VyuoofYWlhzmyaBfc1vDnXqx6m3A8uUxebfd57UbJv/aExBFNepigXDiJ
         HSAva47PW9UsJqzYxJ6QGBA/zS9NXH2o7wWpfGLir3M5jXv3VgDO6VhM9aiMtf8znUM4
         K+OpXFXqcOeKYr1qvFzntma9ZQuQcH/3PY7Zl63xp4EXh+RWUa1Xz2mvW6vXnJUX1OG/
         7J0fvdfDLJi6G5wze+jFjPk62zvKyhh9ngRuJiPQhbl7evhKckER8xvSH5GM8zTspPjQ
         YWug==
X-Forwarded-Encrypted: i=1; AJvYcCXvuXGEXdDDuI52qhvsqtC1+rbOu40GZpwBLudLROjctqc2r1jqLGz/8sH/AffQohN6OlI1OAw/Nm/EEJKYdnaCIxE4ohbJgijdO2nA
X-Gm-Message-State: AOJu0YwbBWrJ1ktHqEO06sY+zq1Sshbq+6lnkfAkCmvOG/+22d0PK81N
	fwFD8+nMmxYQopOIkczGVqS5Q2o6rdWi1X81vST/OT+yEwAGn2De+25zjRXDsWg=
X-Google-Smtp-Source: AGHT+IEzmS8xVuepYdRPEOD54V7+IMoDbdrIJFm4dNUKsWDnLdcZnTpTFA8AyCQj83pGyC6jsDsDdA==
X-Received: by 2002:a05:6512:404:b0:52b:8ad9:cf0a with SMTP id 2adb3069b0e04-52bb9fc5e89mr1695052e87.51.1717761152337;
        Fri, 07 Jun 2024 04:52:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb4216536sm508426e87.129.2024.06.07.04.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:52:32 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:52:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qdu1000: Add secure qfprom node
Message-ID: <mjkxgytrdzm7gz6jjjbe3tjemussrcqyvz52n4o4cwhdr6y557@h4im5qv4itpc>
References: <20240607113445.2909-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607113445.2909-1-quic_kbajaj@quicinc.com>

On Fri, Jun 07, 2024 at 05:04:45PM +0530, Komal Bajaj wrote:
> Add secure qfprom node and also add properties for multi channel
> DDR. This will be required for LLCC driver to pick the correct
> LLCC configuration.


'will be' or 'is' ?

> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 7a77f7a55498..d8df1bab63d5 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -1584,6 +1584,21 @@ system-cache-controller@19200000 {
>  			reg-names = "llcc0_base",
>  				    "llcc_broadcast_base";
>  			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			nvmem-cell-names = "multi-chan-ddr";
> +			nvmem-cells = <&multi_chan_ddr>;
> +		};
> +
> +		sec_qfprom: efuse@221c8000 {
> +			compatible = "qcom,qdu1000-sec-qfprom", "qcom,sec-qfprom";
> +			reg = <0 0x221c8000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			multi_chan_ddr: multi-chan-ddr@12b {
> +				reg = <0x12b 0x1>;
> +				bits = <0 2>;
> +			};
>  		};
>  	};
> 
> --
> 2.42.0
> 

-- 
With best wishes
Dmitry

