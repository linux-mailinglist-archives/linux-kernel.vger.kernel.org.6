Return-Path: <linux-kernel+bounces-439391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D249EAEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4695D16105C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFCE215774;
	Tue, 10 Dec 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtE9uQW+"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C1B2080FD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827701; cv=none; b=ul2XPziDAcdOY2USdVRKNuL8VqrH053sJRYmdxFLced8UTAgZw6SqPNJwKAadQ0sMkdE8C4AaaAcoz32iGyJOSN/KrXaP1cfNd+Dqv4As1r4aTJrFvvSq9T0fRdFyTQDsiazIkEqeQ5Y8oxNxvzso+UBaM1RxtEt/U8dt62FfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827701; c=relaxed/simple;
	bh=yg6mqnRnjya98cIEcHfmAv/X4rPVtV86GGq0D+perBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3RQ7Uf7pW4Hz88UOSmD1RcZDGYotHO2huxI76d/M/CiQiNV3bCSJ3HJCftQ0AkImM9G4ZgN5cc12Xq+4AMjS1Av4rNxhgURP18ognMa8a2uvxh6I4TbNjv41R3RwJO7InDdiuRClhh74UWVU3CLqic2l6sZXZdM6Us8Q88NGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WtE9uQW+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df6322ea7so6265541e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733827697; x=1734432497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTm9JpbxLTN9ernGYfcdV8cr+yCRX12AUqwg0JNmPOg=;
        b=WtE9uQW+M+JpIweDKNPjpbCer3lOURkVHd8RBAo9RlcT8rQNPnmK1u1zsiqXDsy+E9
         PgRJNNQwDbyH0tk9wjDyNPANzuKv5JBdL0QlGs6SLk+s9VuMHqfHr45BH530SLwEODEj
         ayCgxMJu08BxsuM7H5FCC9wAQLBI6g9jmwiur0aNZ6Eb2Xys70sDqtDr+QPt8EdjNZ5U
         HIFP78Y1J7eD8wOcuJ5mvAL1PWp327D5g//NB8Du78503/eD0Jnz1hb2KzUsJGFrkaoS
         Z9aE6eTTyUFRhszsMoL1hVDxPy0fl4wUsMwRaXExtb/W4m4mgX42ReEDjQqsLIIwBcTz
         dXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827697; x=1734432497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTm9JpbxLTN9ernGYfcdV8cr+yCRX12AUqwg0JNmPOg=;
        b=ZrOX/kdJta5fzu3Kg/jKEQdiFGV580qJvrM3CvIt+Y+ORt3UcbXyE+aTmuNbSS8iFv
         iOP6FbbG7pd7XTJjCrUKIoxMHqvbuk1b5yypQx+X9JaHi11grQUTCRXPYAfTmZIn7jYK
         IHZJnsa5fls2UpsPlGdaGR8jw136imSZAuvTc/6aZf//7frdceWL6Hmjlcds2zwWeQ9Q
         IfuMqjOWt5d4noXXWcvSagTjYOD+fMRtKWJfzKMSmyEgGbul5+UAcdkNzlA1hD6nJXEI
         NY4mECMAEEutE7IMq7BRMRb1iCmwMMYP6hk7pB6VC72OFOVL2hIhbNqKIyXxoBq1wlq+
         7/HA==
X-Forwarded-Encrypted: i=1; AJvYcCXeLB3GScaIYy2dQKbJxO8qKKW1Bz3xn3fTSfhfaP+CpbYucRiNPzczoGXs8IPu120SZvqo9Lz/DiELnfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmg9N3bN7afqvhnRzAJnvWJarDjyPbzBN8W6+YXCktXtPRqoso
	fdLzyFhHQitQuMhpnW4iGJKIhV39/bLAPcH6BTRxGW6xFc2RMNpxd8Mb28BgD48=
X-Gm-Gg: ASbGnctmGKOyPmeJwjJwtzZRDOi/llMQIw1JGPDhLLHnzyw7UGCiMs2Rck2+5LvhWVH
	oINQugtFQy2iXCX7srnDrGESMxZpm1rzQpfNc4FVFrBuOX/mO23OIIXm3+l9B/rbsj2SWZcCF9I
	S7QXp7VZB5lPzsR3kTDwmSTDYRZ2bdUILVSq0UBfYEZD2iTggCxiYXeIjuABTEsTJCZnXcfCC53
	6aQdEVZBkt2lVFQ66wo6WwdFN3zPTBNxPFVtWwhe6Ak74sJei7uEW7p99koffVjIGOi0HnEI6zD
	c9Yobzym8ypNmk0lO5sHB5IcOokA5+12Hw==
X-Google-Smtp-Source: AGHT+IEYIG0BNjT2FuP4i1xockiULg5HGcfkNFZZ/rLtudxr0/2wNLHD2/ZqAkMAF7rMzr2LwBYpsQ==
X-Received: by 2002:a05:6512:6cc:b0:540:2257:22ab with SMTP id 2adb3069b0e04-540240cd641mr1438417e87.27.1733827697306;
        Tue, 10 Dec 2024 02:48:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f22fa81a8sm995927e87.91.2024.12.10.02.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:48:16 -0800 (PST)
Date: Tue, 10 Dec 2024 12:48:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fange Zhang <quic_fangez@quicinc.com>, Li Liu <quic_lliu6@quicinc.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Enable DisplayPort on QCS615 RIDE
 platform
Message-ID: <qwx6ieolctmsmlruku2bmxv2ufd3soa64ygsjjzt5b6ntweoan@tpv7w73utvmm>
References: <20241210-add-displayport-support-to-qcs615-devicetree-v1-0-02f84a92c44b@quicinc.com>
 <20241210-add-displayport-support-to-qcs615-devicetree-v1-2-02f84a92c44b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-add-displayport-support-to-qcs615-devicetree-v1-2-02f84a92c44b@quicinc.com>

On Tue, Dec 10, 2024 at 05:11:06PM +0800, Xiangxu Yin wrote:
> Enable the DisplayPort node, config related regulator, lane mapping,
> hpd-gpios on the Qualcomm QCS615 RIDE platform.
> 
> Signed-off-by: Xiangxu Yin <quic_xiangxuy@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index 694719a09ac46bfa2fe34f1883c0970b9d0902be..0ac543577ec1850d6e4f19ff1d64252b00fffae3 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> @@ -44,6 +44,20 @@ dp_connector_out: endpoint {
>  			};
>  		};
>  	};

You mentioned v3 of the display support series. However v3 doesn't
contain dp_connector_out label.

> +
> +	dp2-connector {
> +		compatible = "dp-connector";
> +		label = "DP2";
> +		type = "mini";
> +
> +		hpd-gpios = <&ioexp 8 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			dp2_connector_in: endpoint {
> +				remote-endpoint = <&mdss_dp0_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> @@ -291,6 +305,22 @@ &mdss_dsi0_phy {
>  	status = "okay";
>  };
>  
> +&mdss_dp0 {
> +	status = "okay";
> +};
> +
> +&mdss_dp0_out {
> +	data-lanes = <3 2 0 1>;

This hasn't been agreed upon yet. Please abstain from using the
configuration bits that are still in discussion.

> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000>;
> +	remote-endpoint = <&dp2_connector_in>;
> +};
> +
> +&mdss_dp_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +	status = "okay";
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

