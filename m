Return-Path: <linux-kernel+bounces-535552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED246A47477
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB57A7A3269
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02141E835B;
	Thu, 27 Feb 2025 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0rimY+x"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6B4A1C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630626; cv=none; b=MuKaJaDdMW7a77R77RosW6yfH/tYyLRiGUBuylhxzZW+BTyJPzNiZyMwB/3RamMW9AIZA1+ZUxUQ2peJnAT1H8qYye0ULGIbHQ0tf/2iuqZc3up705H5+i4P8X/ga0SD3Zjw75xfwNcqDDNMeqRqWV9JrzK7RJvHleHw0lM3FtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630626; c=relaxed/simple;
	bh=K5Ig3YWAa+ZrYmIukjgNYwh4zK1sumsgYolE4PtduI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbABsDgXz3lib2FGcejShwY6EPCPNmKqkrlxyljD7Z84reySXCTJw7jNF2bLmL7g2PQTtihmCnUdmfWx0D8to3RB9XsReuvQXETTkvN9tWhQRmpgBCI5ervWxoUCtrYIbVKzxTlHFqAuKdH6wFTRyu1CeHYUIw9TpCqAvMnk6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0rimY+x; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-545fed4642aso471511e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740630621; x=1741235421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xImYWDi5dHhhhMYMyVIYxjxB6DJ6bmImK4QBDVtyf4=;
        b=m0rimY+xPxa6Rt9eD08HgZpGg8Ufd978jWDP7E4h4nx7POfHYrERe9sZxNsD5bgi13
         dNOFSqkegTp7FG3APXGDW2G9HHtfP0kENY4g16xAEPeATEwh8YO+a4dVt3oLmlAsUNSe
         XNUdcnlwvGOy54bDCdhB0t66SgmDVGI4whLN0gmset1MmCqOj1m2iDaqlKQp6Yw3XWp3
         NfpWrjqL7/iZhZfoqb1r3giKn7iZaO0Poj5BDDCrOOGIe985ink4dZzQVziwA4rv4I2g
         OnijiDfD7bcurP/pl47Yp35iQi4J83i7HPSOqxeLhfX6/sNPNW+CJ97MFS1lKhc9kwBF
         1tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740630621; x=1741235421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xImYWDi5dHhhhMYMyVIYxjxB6DJ6bmImK4QBDVtyf4=;
        b=F4g/3pKx+ilXDu1N0xJ7OHfjsXXHoHaF55LUxrXHFWKLCzOAsN75d6ECBlW8GyXaVt
         frs7NV2zPF8aPyb8UT0FMcuZzyFyp+kjY05JuH3yRpKPRhNfVvqeKfT9BAh/3hQnSeRg
         CbL8U+cKYrI6QbyBHURc+f+0a7uDG//0ylwNlVI86hLoCUNZncFD+TZBXyTCOYJoOa5q
         JOmuahPp6dC8Llf0jJRanONcYTsp5vvZBVbwF72MYkuXMGSYRSqSWuUWAngh2gwieVxz
         sv8BMpBmi+YrUEIAhM38a7P4vrHUUrhtg0yPQfNGhfVV49ky6nDPZoF7BTsKWUX6Saxp
         RBRA==
X-Forwarded-Encrypted: i=1; AJvYcCUpRLtnL/r6JfFThx+K2hKEfd1qEOUVsXViC6mgP+3CatkuYeGe+XKR7zU8M5u040wDrKI7uf03MaxbBRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4kMWFEhLObpvQI4/o+i1QZa5K9XIKW3MYwGa9y93mMfCWpTLF
	9Epe7lzWeI2C78nkUqwnqou+IP/7/GKa1HDvqgZIGbKTFOzGn88ZVBCK5XlGg2Q=
X-Gm-Gg: ASbGncswkx15gaf74iv4zr56EhP/k2Z7mcC04Oun/gL9fnIc+56XEHf0nzVuf+5eSd5
	qFS+HyVoWwt7y/0VXGHgqgpnRt/ftSNt7l17JNz43JrBsX8TXg0Bp8V8dv36j8mUdyxZxIzzNvs
	XSNzlLlBnkRCpR2G7RyQHprD4fN6t1A7k0hfuWExX9O/kLTwlhM1RiKpeq0vz1uPXvQB051ceQY
	54iGy/f1fn1BUuGf5qKxgeTD+YgTZusxVlMoEgbkcI0rQ+4wN42ZulJByBtR2jvReB/7cR1zJjY
	TfvWzRDeUGwk0nP13ln2/KYBoUljBNy9Zk4W5jviRUBkUsJNbYe8iXy5y0IE5lqNxC1A63tjSel
	vF44wmQ==
X-Google-Smtp-Source: AGHT+IGL7HDk5Dk+8hhQWHKYR6eLK127rmTECoFhOD2p60rLksOSOUqbp9cBZQmHY4NpEr7VKXUNsg==
X-Received: by 2002:a05:6512:ea1:b0:545:2c25:44e6 with SMTP id 2adb3069b0e04-54838ef5865mr10147861e87.25.1740630621185;
        Wed, 26 Feb 2025 20:30:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cd06fsm60825e87.228.2025.02.26.20.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:30:19 -0800 (PST)
Date: Thu, 27 Feb 2025 06:30:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Hook up
 DisplayPort over USB-C
Message-ID: <it5pyziyolnzjlfzfcvugiupauf6vqrbes4kdjpae2edgoc2pc@zr3d4iqczuvc>
References: <20250226-fp5-pmic-glink-dp-v1-0-e6661d38652c@fairphone.com>
 <20250226-fp5-pmic-glink-dp-v1-3-e6661d38652c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-fp5-pmic-glink-dp-v1-3-e6661d38652c@fairphone.com>

On Wed, Feb 26, 2025 at 03:10:20PM +0100, Luca Weiss wrote:
> Extend the USB graph to connect the OCP96011 switch, the PTN36502
> redriver, the USB controllers and the MDSS, so that DisplayPort over
> USB-C is working.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 67 +++++++++++++++++++++-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |  2 +
>  2 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index b3fc37dba51523ce5678ae6d73f7d835f8b26d9e..1e04c7ec7163538d93543f36094203e58212f600 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -101,7 +101,15 @@ port@1 {
>  					reg = <1>;
>  
>  					pmic_glink_ss_in: endpoint {
> -						remote-endpoint = <&usb_1_dwc3_ss>;
> +						remote-endpoint = <&redriver_ss_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_sbu: endpoint {
> +						remote-endpoint = <&ocp96011_sbu_mux>;
>  					};
>  				};
>  			};
> @@ -758,6 +766,16 @@ typec-mux@42 {
>  		interrupts-extended = <&tlmm 7 IRQ_TYPE_LEVEL_LOW>;
>  
>  		vcc-supply = <&vreg_bob>;
> +
> +		mode-switch;
> +		orientation-switch;

Should be a part of the previous patch.

> +
> +		port {
> +			ocp96011_sbu_mux: endpoint {
> +				remote-endpoint = <&pmic_glink_sbu>;
> +				data-lanes = <1 0>;
> +			};
> +		};
>  	};
>  
>  	/* AW86927FCR haptics @ 5a */
> @@ -778,6 +796,30 @@ typec-mux@1a {
>  		reg = <0x1a>;
>  
>  		vdd18-supply = <&vreg_usb_redrive_1v8>;
> +
> +		retimer-switch;
> +		orientation-switch;

Should be a part of the previous patch.

> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				redriver_ss_out: endpoint {
> +					remote-endpoint = <&pmic_glink_ss_in>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				redriver_ss_in: endpoint {
> +					remote-endpoint = <&usb_dp_qmpphy_out>;
> +				};
> +			};
> +		};
>  	};
>  };
>  
> @@ -799,6 +841,15 @@ &mdss {
>  	status = "okay";
>  };
>  
> +&mdss_dp {
> +	status = "okay";
> +};
> +
> +&mdss_dp_out {
> +	data-lanes = <0 1>;
> +	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
> +};
> +
>  &mdss_dsi {
>  	vdda-supply = <&vreg_l6b>;
>  	status = "okay";
> @@ -1297,7 +1348,7 @@ &usb_1_dwc3_hs {
>  };
>  
>  &usb_1_dwc3_ss {
> -	remote-endpoint = <&pmic_glink_ss_in>;
> +	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
>  };
>  
>  &usb_1_hsphy {
> @@ -1326,6 +1377,18 @@ &usb_1_qmpphy {
>  	status = "okay";
>  };
>  
> +&usb_dp_qmpphy_dp_in {
> +	remote-endpoint = <&mdss_dp_out>;
> +};

I think this one is static, plese push it to the SoC dtsi.

> +
> +&usb_dp_qmpphy_out {
> +	remote-endpoint = <&redriver_ss_in>;
> +};
> +
> +&usb_dp_qmpphy_usb_ss_in {
> +	remote-endpoint = <&usb_1_dwc3_ss>;
> +};

And this one too.

> +
>  &venus {
>  	firmware-name = "qcom/qcm6490/fairphone5/venus.mbn";
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0f2caf36910b65c398c9e03800a8ce0a8a1f8fc7..4880d26e745566fa7ef906a0489e3772f2426ab6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3639,6 +3639,8 @@ usb_1_qmpphy: phy@88e8000 {
>  			#clock-cells = <1>;
>  			#phy-cells = <1>;
>  
> +			orientation-switch;
> +
>  			ports {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry

