Return-Path: <linux-kernel+bounces-565502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED2CA669B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10563A98F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72DE1DDA3B;
	Tue, 18 Mar 2025 05:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtmDtES4"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A871A3159
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276588; cv=none; b=H+Dv8V+SQ9Qa5Td5LE7ww2dtOA5PmdxvgImXVQYXF/9JQyoCpz7MQq3sCkA/Sq+ml1RWSxFAK6YxZL/jOGyT83niZINsYwvUAvaZiGxGmUVS7M9AQTtaguUrHmuOomF+34FPh5fbjbykTBxzzG2Pt85zhbypI1MgubutoDUxCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276588; c=relaxed/simple;
	bh=pTkKiqBvzqQ4A08SySDFb1VvCKVdJT+dQzkGmZq4KOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVczDe3B0QE9W+EUjRE3vlb6gdjCaAEGbO5j8L4yTLucB+V/41I1IizMyJeJVDg8tZE2UysaFEw59MsScPVhdE+cLDU3Cy99e9+DwesWKoJeglFQilh0K3kZVG00/H8bvYdkbOrHb3xg09rDJdgUjhRBzHTxa/B5DPXAXQuC/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CtmDtES4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224341bbc1dso96205435ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742276586; x=1742881386; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FEoinY9MBp6fBxPU4owelu4oiM4ylGd59Qy+F2Dob3M=;
        b=CtmDtES4wZiSXVNIoMq9TQWWn6/XRVk+yRor3HsYaDDurJ77aFbHs3LNxrJMTO4FIq
         AI+g4+MiWbhPrB8dhcb5nnZKZuqFQ7E5DCYZqsgPT2iUh184oUFWHToVn67PYyMEJL0h
         96b+xfhmPKXqdIKtsYAwvxp29PY8wh7wUoHAQlUbD4FbBxjQdT6bK0kZGYgcQVrxWG3r
         cTudyLrAPpEMZiUbeYENd8GqLQWREda3JknLg8v6I4TwwNxH4+NICcaO0VGRA7Um2yAr
         DogmpxI9TOz80lmklqXztiZAkZXXRF3UhXYasybum6OSojuojMSoCO8hiLjGV5SeNew1
         RTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276586; x=1742881386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEoinY9MBp6fBxPU4owelu4oiM4ylGd59Qy+F2Dob3M=;
        b=C89cW3dJ1jCwgtH865Ar6qqjTl0E9xnuQQw5enB9Dbwfkydho7WBp+Sd8rOeLMM0Zx
         1Ame67Qckpck8D83TAaGna/j09qC1nJVTeGHN8UoC6Jhm4YX8XHqpKtakS4rDatAcVds
         h9Oq8O6FkmlaEnHL5jZtLA4yg4moj1sXm4qk1sz0IFTGtvpWWas2c6vtUrhEE0ddg5JL
         yQbztrwUsqunRH9zvGObVgP5BaPAMAjTW7uFNC6pt8y1RR5gs8hIRkiBT0ODPnchhmw2
         JPXyWnfPrsyr9EqEZQU87C+iVb6P4jQwN0zwdztSIAmQlHFoCc9rkqZRGZqXMQ53m6G2
         7Oug==
X-Forwarded-Encrypted: i=1; AJvYcCVrH10qx4pE5MDMvfL2g3pRIHN3TR2iTLXc7znaBD86sgclZd7b1NaHG6TAZvXuAPuGD9/e5McgKxjPe24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQ/yeNcf8wMBwPyiGzt5//e4Q11BQ+5FM0l30SMfNnRg0mfp1
	ZjADZLvk+AZR4JzSHIBgohfWJtT/gvWU5nQ3+oSLW9UYMyJo1pJqhiXBeD6QbQ==
X-Gm-Gg: ASbGncuB4i5HPdfv6qCAZ0afiNKCeC2T/q8QJd49+2kaRJLc1Vut6FuA/+lBGx8L9+Q
	9uoaPPRU9eSb8VERdZcUaoGjYqyxrXdl/pfH0NptZHKzEnj/2y6dZ8ZMEcNa/+8rzM+a/3OpY6B
	8syZZklWpKiu+avUiS+BxXVr0JxPNcsSlhBCPSSOCWSyUvo8c+MU3I+l9o5hTBBbXj/7+sCEtb8
	6zzF01QecMWHibiEvuEC/Jyr4YLaCV06znudNigjw/0EUupVYhzHFC782/eDDcETVoRSkk0YvTJ
	ppi+BUhpAmwjDhtNautejP2U+8mQQ7w3nL+PMYUygdCC9Jhv6SpfrX4G
X-Google-Smtp-Source: AGHT+IHFAYycRh8yAvQ6rzKtJ7IEEozCZPfvduhinevYL/RlGjWqSKDVBSpP0w/WLSUpzr4TkOvmSw==
X-Received: by 2002:a05:6a00:98f:b0:730:7600:aeab with SMTP id d2e1a72fcca58-7375723f9afmr2788650b3a.13.1742276585611;
        Mon, 17 Mar 2025 22:43:05 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711578a67sm8596953b3a.78.2025.03.17.22.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:43:05 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:12:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org,
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com,
	johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: qcom: qcs8300: enable pcie0 interface
Message-ID: <20250318054258.roq5zifhqfkjge4e@thinkpad>
References: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
 <20250310063103.3924525-7-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310063103.3924525-7-quic_ziyuzhan@quicinc.com>

On Mon, Mar 10, 2025 at 02:31:01PM +0800, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe0, board related gpios,
> PMIC regulators, etc.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

With subject change mentioned by Dmitry,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 40 +++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index b5c9f89b3435..c3fe3b98b1b6 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -285,6 +285,23 @@ queue3 {
>  	};
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-0 = <&pcie0_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l6a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +
> +	status = "okay";
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -310,6 +327,29 @@ &serdes0 {
>  };
>  
>  &tlmm {
> +	pcie0_default_state: pcie0-default-state {
> +		wake-pins {
> +			pins = "gpio0";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		clkreq-pins {
> +			pins = "gpio1";
> +			function = "pcie0_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +	};
> +
>  	ethernet0_default: ethernet0-default-state {
>  		ethernet0_mdc: ethernet0-mdc-pins {
>  			pins = "gpio5";
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

