Return-Path: <linux-kernel+bounces-331750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351497B0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A39D1F2379B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE01618594F;
	Tue, 17 Sep 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMhRPGKG"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108518757D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580334; cv=none; b=bsOmui6Iq5tchPLEdZbJ4GrgIuonSyJkTyQyndw//3j+bP/AxlijX6HtdCzasTeUOgRpCvgpyTU40tLUQt3i+WPHGt4V95+WeIT2BlZO8GhvjMI1KuYSGwjGHcpFEhiH4Gms+NZFEPzRHXgZiPHHqX4q6RdGoq2r9FW8s3uOrAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580334; c=relaxed/simple;
	bh=ZG1vxeD3EgoOOwm9exxEQewT3p4f8/J4YXV48auODqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8uDeWx0g5Li8CQRPScUkgfsIw+MBcMwzQ5ZX2cwWifG9geMAKaWtIupMldczgncUb7iS+sdHi+TSXfzLqKhmGTQ2mm1uK+Idsxd0Iv5POGiVhP8J7wHwMuAudkRep8tjgoSQWx8In5QTA3joZYzubjfJB7fVIR8rpbmAQqi7tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iMhRPGKG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75c0b78fbso59895741fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726580303; x=1727185103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7oEZwCbDIQ8F+t4Rs5Bvaf5j4IlFxDz2ZFbzuElzFFQ=;
        b=iMhRPGKGN1Rod39srcMpq7d9KknSbl06Wa8LgN01LnEX8o21jlNpURD/MmHqadr5ce
         8WOJe2CRnV7nYhajsphNI+6Fkhh+jwYjP+2gTHzabrqcXZyLzBHQ53gHGDjwOtx3v0y+
         1pWXT1BJd2LM0uoDoLhU6AUGaRaGMYF0mgszFvC6jxkBa5ygrjbauPHl8b+HBsrtDlm8
         ClJynL7ANSIlpjxCfhql+RJZRhEG2MAoEf5LxDf9FAqiTP5/MSW5sWOK1TBNYa0tsbNk
         7z931rNADc+rNOYwYtAxnhxiC6/UBoQdEekOcTA8/huLFHkOctGW64I3aAgPMLZpoWLN
         O8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726580303; x=1727185103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oEZwCbDIQ8F+t4Rs5Bvaf5j4IlFxDz2ZFbzuElzFFQ=;
        b=QnegMDLrsPLnwpD9M4w5n862AeMJnmQYv/hnY9Fsxo45NN4XVkTw2NIjtrdch94Lz3
         /L2w8XMqu9Tg69Q3XjMWwlVaCJ+8HScfytO7uRFXuTASlsv/uewbQ9cSrcoYu0+I4Y95
         0UrJn+5cu+VSkjYR6Iubm7gH8DXjJNk0ewKu1dgH9nxphBfkMZuL2r5X8e+J0DC0Jvx2
         EOIyGy8leAjH48FpcPGcx60Q5sXrId5hm3jQTbdl99Rg6ZPRlVHZlRuxQNmrqvdhmkHd
         4kg2vihn3plQ1Ho+XaPYob4YdQUl7QGqolMrDcCur73YkTO1lf0vMqexiCGFcC0yK9sY
         fUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoy16cIjpm0UqrnpRsXFfbwU+CSstWtKiGCV7kj2gU86+7yYbBsk908SJS4laS/+PMLSA2UnLtjDGt5tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzREaXt1TJ2/icYtfvog8Mu5/sVGutWBJn+HVVl086gWXdSHSnl
	mFMnXBQAY0rGDEywid6br9gKIhtzSBwv5/kPIpN7jxcmLanm4gFWhBhyafGq1N4=
X-Google-Smtp-Source: AGHT+IGjeiZlF4mZL1r/PNyz6+OKRKX0/62xZ9kMPvlixKz4htlJC6nn+3BuxQ2/JVRsRDBmL4KaIA==
X-Received: by 2002:a2e:b8c2:0:b0:2f4:5d9:e8e3 with SMTP id 38308e7fff4ca-2f787dad4c0mr109899051fa.7.1726580302686;
        Tue, 17 Sep 2024 06:38:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d30175fsm10821131fa.53.2024.09.17.06.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 06:38:21 -0700 (PDT)
Date: Tue, 17 Sep 2024 16:38:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sachin Gupta <quic_sachgupt@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_mapa@quicinc.com, quic_narepall@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_rampraka@quicinc.com, quic_sartgarg@quicinc.com
Subject: Re: [PATCH 1/1] arm64: dts: qcom: qcs6490-rb3gen2: Add SD Card node
Message-ID: <gyasvmb5q3e4pgmfpj7njovclydwhsvsxt4ayfxzbh5njwgwsq@zfhlm6lqfirl>
References: <20240917090630.1025-1-quic_sachgupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917090630.1025-1-quic_sachgupt@quicinc.com>

On Tue, Sep 17, 2024 at 02:36:30PM GMT, Sachin Gupta wrote:
> Add SD Card node for Qualcomm qcs6490-rb3gen2 Board.

Consider adding mmc0 or mmc2 alias for the sdhc_2 node.

> Signed-off-by: Sachin Gupta <quic_sachgupt@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 0d45662b8028..5df3167651ca 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -716,9 +716,42 @@
>  	status = "okay";
>  };
>  
> +&sdc2_clk {
> +	bias-disable;
> +	drive-strength = <16>;
> +};

Please move all pinctrl-related nodes below the PINCTRL comment.

> +
> +&sdc2_cmd {
> +	bias-pull-up;
> +	drive-strength = <10>;
> +};
> +
> +&sdc2_data {
> +	bias-pull-up;
> +	drive-strength = <10>;
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +
> +	pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>, <&sd_cd>;
> +	pinctrl-1 = <&sdc2_clk_sleep>, <&sdc2_cmd_sleep>, <&sdc2_data_sleep>, <&sd_cd>;
> +
> +	vmmc-supply = <&vreg_l9c_2p96>;
> +	vqmmc-supply = <&vreg_l6c_2p96>;
> +
> +	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <32 2>, /* ADSP */
>  			       <48 4>; /* NFC */
> +
> +	sd_cd: sd-cd-state {
> +		pins = "gpio91";
> +		function = "gpio";
> +		bias-pull-up;
> +	};

There is also a special PINCRTL_related TLMM imstance down the file,
move it to that node.

>  };
>  
>  &uart5 {
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

