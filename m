Return-Path: <linux-kernel+bounces-424704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E0B9DB84C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D154B20D83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51A11A0BFE;
	Thu, 28 Nov 2024 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqKwMc/4"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F819EEB4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799372; cv=none; b=svgJ4XmXt4j0kVZ3KYr6n8wuFPFOc4XVGhzbSKE0nXu6ePpV46YynCnFwwo7OpaB/71tSNwIph32DlOh2KGw+mRAmBc7m4pBHKe4brPb1FEp1p2PwEbBMbPxaKdpkiVCyUHO5nHZA3a/WzQqboXG+hTIh7hVa6t/SamyjG9fVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799372; c=relaxed/simple;
	bh=ApOFSGhe55GZ4QVWZoUZP1i/pea19qWRSGaCsmAqK8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoQFIVZrdMvv/n/83xBkglZQMTQbi6Nep1APOsN3LtWpRK9+1w4Caxuh+34b7Z2ChP0qHqSF3ZuDW6fcaLgsFvEseIXsJXHhM1xzhWP2DyUHCMf92lQlRV2zPZINX0UDs7AYD+77N5rKlqVmM/OWxXra7adUeCdFIeL831w+A+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fqKwMc/4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53de556ecdaso757619e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732799367; x=1733404167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pnBfiN/XYPpvgzOixVlWSYVVdbmqQBAJ8570i6TyiI=;
        b=fqKwMc/4s+4aLGXpsbhkuT9wLbXo2BN3lX+MlaSk5BnvUi6SpLFRNf6ogCesVsHYPP
         suQttkUxCpLnK3PLuTfl24vnCeSsV0AHTRn482601qIFNQChyLCT8uqbJrwBww0RzhPN
         j9TR7wd1WVWP+7kfPNgaFf32fBFwy4BECFrCgKCOBn2LezWjU5MhqPcv7HAWAYj9BXMk
         xG1IhW8pDVNoNv/qfnIxDw91/Jy4JyZVKqjvPkdiLohr7xYCTK5INZPKTGDvhOSfBeKy
         MssG8WrsXl1P+JdNkyGb2ozUsXmYNE76zpe4VM2kMIifg7wmDZqCyZcsLUNhLvwNJZGB
         KBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799367; x=1733404167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pnBfiN/XYPpvgzOixVlWSYVVdbmqQBAJ8570i6TyiI=;
        b=VkUXJVXkPnjqFGpsWVBDa1B4eJBjZE1G1ZSO9JkZB8qrkNqpFhzhZyIB46bFf3fSku
         JfUxhqnXOJyEoQxUitTH3feY+UmSdVfjYL+Mfe440FZmUimtYE6yN397lDLIfQDbhNMC
         rNLu1EqAoQ1DBBJQ7YcE7YjiHLPIuxfJAN6cWg9G2yZ8wPKJCmqxv+SA6fzv1kdoHovE
         gliRd5y2xUF5pRv/6UqPat8T/XRodfQY1QSACem5Ovx3M8rWn/gyrH00Tzdb1Yu8leH0
         hBVcpLYv1potbtneK4AvrzmXSxOojZ/sZgDmKWiwgXPg0BOgtk3vxG8g4YdEfYNp2cJJ
         zNQw==
X-Forwarded-Encrypted: i=1; AJvYcCWwtDq8db2oK82e8e+5aP8kj9vbTtjePU/nccuzV5MU8FFjRyLMZMs4/3YT8BnINb0zQNz6KhvziV0G258=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLx8OSe8fAowfib9JRt+oq1P33JKpIwrNEYs+xAqcmGhy/2Wg2
	0NqYx6aiKuzx9I5Z/84SGj6yupsEZq1knTHyh/eREbmPOT5G69StnB41Otws0zA=
X-Gm-Gg: ASbGnctvbpRfL+QdKxpiHZkIqh+va/Tht8IOY+XI/k6hg4z5SbjqOJFHEX3zdcQPGIe
	xtt/qQAPEPAN+M1NHxsOrpTbwjz+Ki6sNK7XDnUYqSkptCEAQ0K3Gky436oSe6GZz7aiK+ldi3O
	NpNAypDE2rImBNkijsKBupyfdKPeiFksSuKfCP+sbTyoe/Ub7a4OO43RQV7boWHvmRc2JPa4j4f
	PdjiO3SO82SfBEk1sN4f/abnDu5a7sRCpBct1UNKFg0o1zINE9kwP6nuQAaFCcntd4LjHTzsxnN
	RuuMBQQK6tIO3pvaCMpbt9x+/LaHGg==
X-Google-Smtp-Source: AGHT+IEiT8tbWGw0qja41b5xkk9iyirW1j/0Ief7lF46UoZHYslLEZ4Yj8zzr1ziZ4ihxMBHaTRbEA==
X-Received: by 2002:a05:6512:2822:b0:53d:d0a5:aaa9 with SMTP id 2adb3069b0e04-53df00d1b43mr4100198e87.20.1732799367024;
        Thu, 28 Nov 2024 05:09:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6496e1fsm170952e87.218.2024.11.28.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:09:26 -0800 (PST)
Date: Thu, 28 Nov 2024 15:09:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	kernel@quicinc.com, quic_eberman@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: move pon reboot-modes from
 pm8150.dtsi to board files
Message-ID: <n3bqppo2upt64emlfljoin73a5ubgouztmdtitjbds522swgvi@s7re3z55eutw>
References: <20241128-adds-spmi-pmic-peripherals-for-qcs615-v5-0-ae673596b71c@quicinc.com>
 <20241128-adds-spmi-pmic-peripherals-for-qcs615-v5-3-ae673596b71c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-adds-spmi-pmic-peripherals-for-qcs615-v5-3-ae673596b71c@quicinc.com>

On Thu, Nov 28, 2024 at 07:55:27PM +0800, Tingguo Cheng wrote:
> Reboot modes were originally managed by PMIC pon driver on mobile and
> IoT platforms. But recently, some new platforms are going to adopt PSCI
> to manage linux reboot modes, which involves firmwares to co-work with.

Which platforms? Please be more exact. Also this patch needs to come
before patch 2, enabling this PMIC on QCS615 board.

> In this case, reboot-modes should be removed from pon dts node to avoid
> conflicting. This implies that reboot modes go with devices rather than
> PMICs as well.
> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/pm8150.dtsi                      | 2 --
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts                  | 5 +++++
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts                  | 5 +++++
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts                  | 5 +++++
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts                   | 5 +++++
>  arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts | 5 +++++
>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts                   | 5 +++++
>  arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   | 5 +++++
>  arch/arm64/boot/dts/qcom/sm8250-hdk.dts                   | 5 +++++
>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts                   | 5 +++++
>  arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      | 5 +++++
>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 5 +++++
>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts           | 5 +++++
>  13 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> index a74a7ff660d2b1be0df0dc26d79e1921a3935f14..d2568686a098cb4d78573000b34840d8f5f674aa 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> @@ -49,8 +49,6 @@ pm8150_0: pmic@0 {
>  		pon: pon@800 {
>  			compatible = "qcom,pm8998-pon";
>  			reg = <0x0800>;
> -			mode-bootloader = <0x2>;
> -			mode-recovery = <0x1>;
>  
>  			pon_pwrkey: pwrkey {
>  				compatible = "qcom,pm8941-pwrkey";
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index e65305f8136c886c076bd9603b48aadedf59730a..82f6b4a3e24aa2caba90715e12bca25b693a0d65 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -239,6 +239,11 @@ vreg_l18a_1p2: ldo18 {
>  	};
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &qup_i2c1_data_clk {
>  	drive-strength = <2>;
>  	bias-pull-up;
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 52eef88e882c356a62bf563fcd7ce3d54b5ea824..7afa5acac3fcf7cb6f8c5274acdc2e55192c1280 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -964,6 +964,11 @@ led@3 {
>  	};
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> index 1c781d9e24cf4d4f45380860c6d89c21e8df9925..fe0b782aa3ff5f4b73e921880fc3cd9908398705 100644
> --- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> @@ -239,6 +239,11 @@ vreg_l18a_1p2: ldo18 {
>  	};
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &qup_i2c1_data_clk {
>  	drive-strength = <2>;
>  	bias-pull-up;
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> index bac08f00b303ff6e6d47697f1cd9bff53efaf27b..6ea883b1edfa6c511730550f4db0cb9c25fc633d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> @@ -578,6 +578,11 @@ pm8150b_typec_sbu_out: endpoint {
>  	};
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> index b039773c44653ae8cd5c2b9fdeccbd304ad2c9e5..fc11ef0373c6920e970886ce2eb2c4f20c75154a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> @@ -430,6 +430,11 @@ &i2c19 {
>  	/* MAX34417 @ 0x1e */
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> index 256a1ba9494560b93dc324751ee8327f763aad90..2e1c7afe0aa7d4ad560dd8e5aab2ce835991cc9d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> @@ -358,6 +358,11 @@ &gpu {
>  	status = "okay";
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> index ae0ca48b89a59f669e0f359e48632b335050a2eb..70fd6455518b9101ba25dda6e1fb5f87c1053a71 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> @@ -601,6 +601,11 @@ main_cam_pwr_vmdr_en: main-cam-pwr-vmdr-en-state {
>  	};
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
> index 1bbb71e1a4fc0f1289663165e0a8f7ef88d9b429..f5c193c6c5f9b4bf007a17926bcce319f2608706 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
> @@ -373,6 +373,11 @@ &gpu {
>  	status = "okay";
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> index 21b2ca1def8363cbaf7857215f42ff8492a8f7fa..7f592bd3024868c6ab4c9c61051d3f2cf5707a1a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> @@ -627,6 +627,11 @@ channel@4f {
>  	};
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> index f6870d3f2886fc68aaf914caecdd3a22ba249c5a..d8289b2698f37bce0501ac20c356bd5ae017e1ab 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
> @@ -591,6 +591,11 @@ focus_n: focus-n-state {
>  	};
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> index 3596dd328c31d6f0430fed343c7e2307147d21f3..0bf3d6a826fcbad9c84303e6016c4657c5f89ef1 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> @@ -673,6 +673,11 @@ &pm8150b_vbus {
>  	status = "okay";
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts
> index 86e1f7fd1c2058202c9506d7e737fadabf476d5d..668078ea4f04a7ead052d28bf111be6daf25805f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts
> @@ -554,6 +554,11 @@ vol_up_n: vol-up-n-state {
>  	};
>  };
>  
> +&pon {
> +	mode-bootloader = <0x2>;
> +	mode-recovery = <0x1>;
> +};
> +
>  &pon_pwrkey {
>  	status = "okay";
>  };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

