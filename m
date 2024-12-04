Return-Path: <linux-kernel+bounces-432250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 387D89E483D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF12C2811D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D9C1FC7C6;
	Wed,  4 Dec 2024 22:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXiSUX49"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0ED1FAC5B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353167; cv=none; b=LMQxxMK6Riy/jpm6rPomLlFInP2JBX6OhaMT/H1W4WtWuGfffkj5hfqy2IbTiQbg5CQpG/TFyradkxko28LZAtzl/Ctlmkiq9/eXtZXWdSL4WccMd8WrX19XgHxG7tbTgfVfpHpWR5mSd2q8di0BkPim4jJhOPp/O19Vz8Y0GN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353167; c=relaxed/simple;
	bh=zu2zn/CG8LATXGnamKjYNIPIAQAZIUfMCZnfMDljbJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaqQFYCeQVWIQOulbmD+BYo2c32ORZEy9Th/Dey6SaHU6n1ejZDwcLAA3TcBfni8bsB5iKfJ4dInaQ5u57A84SG2wU05UBUvXr3T/UGdezmBMAdnTrgWhvT90MsXDW1pLzi7D0FkAGX6qpzGypWjf4ude2y1RjZoFd58mPPJmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IXiSUX49; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so366305e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733353163; x=1733957963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTycC8k0POiTYVULvZ4XnFfri7Upa5YgerEMaIs+Jd8=;
        b=IXiSUX49C5EBU55+Vp5Lm6WBVLlKpOw12VSzXQiQ9BctKqBt2mNbFdy4bApo0/hCL6
         y/1P++taUn1sfQz75tL3k466L2ZAbQXHbOXbRkbMQ8lp+FjfM9HTWkO/7BM2j4yKfZ6S
         XJnL2Mc1oJaj3iEzTBGlpjCS+IbsqQcWckJWcvM7qQ5WRGSB8pr0GT/1aRJzELYvB1u4
         717qhqxcVAKjrFo8pWSqOhcYn+MjtR3MHrn1d4ABUjMe15DpzGI8+A/4Kb4Zf7DMBgqi
         eM4sUPSErrJ8SO4gOlICgpUtTXcp4cLqlmxuzaEiyHEH4ms1PTjQq3aBi1pO89Ie94ve
         uzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353163; x=1733957963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTycC8k0POiTYVULvZ4XnFfri7Upa5YgerEMaIs+Jd8=;
        b=QBv1gJfoOWZq7CoYxR1Atnjf/Ssfet2R31KczI5U5zIDwBrFQr+Np/WoakNlBUKDuk
         90w1FJf6aNAO0+ywXfUw+FPBzeAN16dyYUE3WMLRhRQOr4pp6Yy737z4K9R44ka0bC6z
         V6mf8GdOxQsRSdmSLZGH5G1eQ66YdSqkf8ks0rFsG4DPdPa0xb3R/kVUU9c9NWEjG+Mt
         MuJ60zrtuzpUUI/4y0BbX4vHkRQSqcx9VtkjPRto9ZjzXlA4TZ8JtiKq0j8ppAzxU7eW
         lBR1Kfd8ixRFtIDun34fQKZmjH+NrjQ32Rn1W8B8pjoiq/icdbLAM5SoGrfsTI1QfSrw
         Brzw==
X-Forwarded-Encrypted: i=1; AJvYcCWjqAvxCgvIGrXC+oEEsojWUQQNrZ/7+UcSXlWk1bSQRkgS3mN1I9unlUO5rat8QBLItX8Yzvr/83jUQiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1WJNQdaV4BpgRx5oK7T/1eeDMTOr4w2QBSwK7H3B/cwdvVfxI
	J8A2SsCyDFYJgSkRqPad16xSoiw5w+SocfT0ecIxCGf11RFMy+3rSsjQbZ5TMx0=
X-Gm-Gg: ASbGncuroaly9Kq4J8kp5eX2F0k8B+3IXuxTm8b22yeC/yef3TnV6MGl2pdSnZnhUWq
	g/90ewRGnIZuBeeNx6B11ci3ClxlasrjbAdh0OSAE43Xzuvn39i7cTW+tYqZ6Faj+7fKzudhA29
	wbST++mBNLq/o5yk2YJuTJPFdlmBiokArWCCHr4t8ZTTfsVuA74XRzYpqj/wx3RfFL97yCH/e8W
	0+VXGhjXuNRICpy3YTeLWcwnHoQB4rA8ERYlZSW8jHrRyc7f3MKh8Xz3OiA/518qV41xceNdxNW
	J8omzQC6j0W8cFhLNn0Y8s3zgCb6wg==
X-Google-Smtp-Source: AGHT+IFRjL/KhmDcGC8MucpwxgwNr0ZNRoGoJL7sxAYkJFIl0HN1ssgHjTDj9GY1umPdAlN+l8LS0A==
X-Received: by 2002:a05:6512:2252:b0:53d:d3ff:77f6 with SMTP id 2adb3069b0e04-53e12a22f22mr5085713e87.46.1733353163247;
        Wed, 04 Dec 2024 14:59:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22947a16sm29976e87.33.2024.12.04.14.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:59:21 -0800 (PST)
Date: Thu, 5 Dec 2024 00:59:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable
 BT node
Message-ID: <pzkijkdswskaq6232uldapz3b6v6zplif7uah24iwq3ymlezft@skbcy2vod3c5>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
 <20241204131706.20791-3-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204131706.20791-3-quic_janathot@quicinc.com>

On Wed, Dec 04, 2024 at 06:47:04PM +0530, Janaki Ramaiah Thota wrote:
> Add a node for the PMU module of the WCN6750 present on the
> qcs6490-rb3gen board and assign its power outputs to the Bluetooth
> module.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 165 ++++++++++++++++++-
>  1 file changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 27695bd54220..07650648214e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  /*
> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  /dts-v1/;
> @@ -33,6 +33,7 @@
>  
>  	aliases {
>  		serial0 = &uart5;
> +		serial1 = &uart7;
>  	};
>  
>  	chosen {
> @@ -217,6 +218,63 @@
>  		regulator-min-microvolt = <3700000>;
>  		regulator-max-microvolt = <3700000>;
>  	};
> +
> +	wcn6750-pmu {
> +		compatible = "qcom,wcn6750-pmu";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en>;
> +		vddaon-supply = <&vreg_s7b_0p972>;
> +		vddasd-supply = <&vreg_l11c_2p8>;
> +		vddpmu-supply = <&vreg_s7b_0p972>;
> +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
> +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
> +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
> +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
> +
> +		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;

Doesn't WCN6750 also have SW_CTRL and wifi-enable pins?

> +

-- 
With best wishes
Dmitry

