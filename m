Return-Path: <linux-kernel+bounces-415708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64AF9D3A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701AA28207B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F92B19C553;
	Wed, 20 Nov 2024 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqI0dZxF"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63419F41C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103879; cv=none; b=BzCCdh2JrxBq+yZnZC7jIgXnAydyRA4htjTSPoAWEfUGVXzi4xxQyaOIXLubi0r+JQ+cVhCJlBfyGyyZC2WPdxCUhQgkkXpeyL7aZxQhZXXGOyCN2JOBgCJEuHioUsfT44kfEmvnj76UyrbXrpNinxZJlEnW8/zRUmHbh4M0AYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103879; c=relaxed/simple;
	bh=0e0nr2aDV/a5TiJuxeZ1nyQWXMPEjp/tJGOao9xoL1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oW/mVAEfs8L5is5bLW/9UWrW2MqAEdthWOw+sNI3Fw4C7cf/NkPPDP+/LHQdcDfcqBdXGsOrnfs0SRrwBPAZpWKAJHJmGxJ+zo6xVSsrNe+ndVCP/h9kUB7xy3j1hhiuZEAhD6PF3ACnubCaEUC+AG6KQ4mUv4YkFR/GXowIyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UqI0dZxF; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53d9ff8ef3aso2384553e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732103876; x=1732708676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kkDJuRPym29fU3HSSlVBvB5wB9QK3I5iEUymjLs3BXM=;
        b=UqI0dZxFjUM6pkeHNrTr9DZly81eUQuGEU7Q4qo+Xn+XbekRXeL3LNkbuLkgpCvBf5
         2BLNPZOSMPIdBKYYc/dSYQat2V1qiSRZmQVbVJFOVMjuIBzYGbTn44wTx7G3gYiD1D1g
         +gZH8FtNWiV7F95q0FV+/HLKtLG5ucCjCRvq7JfSm4gIHNDsvnjB3DPy/EbuAf8d9Mhi
         HGxu4DrP/BXhXmPb2aJ/WHgLdF9k+ZxoUmoATip0Abilz4AuaPhHBc78XEhI6Zt4ivBO
         /XSCmUb0bWR3cx6ZkJUOe5FnmSVKgltDvqCMcZusYShH3qbD8GRXTec2XRll7hFcW+OX
         VcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103876; x=1732708676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkDJuRPym29fU3HSSlVBvB5wB9QK3I5iEUymjLs3BXM=;
        b=LLXLblj+SDAQcibjNPGwiysgUP/oaWuC/xE2skStoWFEZODEd9NxIuHtaFgeaUlZnw
         uIvFqzzZ50u+9jQfgjTVQBDDtevrVghj2SlQGsfJkqi5BQcbL8HZw4ABa6wmZrHHW7Et
         Il2JZohs528mJtxTPRLYCgt8kOBX+qAg93tIWJZ8sOelNSrtLUvgvsRefdbJwdExuVrr
         Fmmx2jYBB63289KxVsnEXH2AJu4UiMI5jAvfmmw4HlUXDB9G7nbuzJS6PBfycWcm1+fx
         p+aH88CQF/kOwhicE87iu/CVuTiVPMZi8RVe/7QEAQLVy5MiyzT+d7OQROlLyj4wcvF+
         gN8w==
X-Forwarded-Encrypted: i=1; AJvYcCULdbv4LZDpS86Sz/48ViYt1pRb3LhsLvJ9sT+7nUvPEq/0CfVWAWKpxzubBQ1KAD25IdnNw8lr2ntV5vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL85YncD5gclwHgPlMXcpbHjQILVW7ob1rWJ8Dk/nogrKhPNiv
	iwBghbN9rbNcUtTS9MLxLlDGhWAWoDMwBWeP9+E9OJRKWcMwmhUmWbqIxfCIxFk=
X-Gm-Gg: ASbGncv8Whwz4Bz0oxvklROzA8MiexI3EWRUWEGTgpPaowJcDz/oJPi1EQYrT0zwK+j
	Rl9ePJYMwknbI+/QZb3dGs74IPxmBJi22eXueWrbmQK3MSLDOxh3t+0ggrcOD3h3tr/VPmfPgVt
	zmF8yfM5K1lCBlKoqD5zh2YF/s1CvrALJtxXyIaqVVIdPECgSx7B16iBuMRBgkxEdNGnJ0D/x5p
	rW2jNoWHPkDjA9ict0hg82b2r3hDYehWBEE4nL3cpglM6BAOPysQavGg33vSw1IFWLtZyvk1EaA
	lV/jSIKEvnOFOynviGcU8kzMAKcexA==
X-Google-Smtp-Source: AGHT+IEhdK1oi5UhEJitu+CYeExmzTppA+htmFSLIfQ47nQb2OOw28dJBcmFit/oz+783D827lApYA==
X-Received: by 2002:a05:6512:3b2a:b0:539:edea:9ed9 with SMTP id 2adb3069b0e04-53dc13275aamr1000536e87.1.1732103875668;
        Wed, 20 Nov 2024 03:57:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd4671d9sm606538e87.115.2024.11.20.03.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:57:54 -0800 (PST)
Date: Wed, 20 Nov 2024 13:57:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Melody Olvera <quic_molvera@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: qdu/qru1000-idp: Fix the voltage
 setting
Message-ID: <orvnnjclxlwrab34daxrepn3m3la3heogkxbncl44yjyn3wxkt@vnp4knb5nedo>
References: <20241119070812.16079-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119070812.16079-1-quic_kbajaj@quicinc.com>

On Tue, Nov 19, 2024 at 12:38:11PM +0530, Komal Bajaj wrote:
> While adding the USB support, it was found that the configuration
> for regulator smps5 was incorrectly set. Upon cross verifying for
> all the regulators, found that smps4, smps6 and smps8 are also
> incorrectly configured. The patch corrects these configurations.
> 
> In particular -
> - smps4 is 1.574V min and 2.04V max
> - smps5 is 1.2V min and 1.4V max
> - smps6 is 0.382V min and 1.12V max
> - smps8 is fixed at 0.752V

Could you please comment whether your values represent the min/max
supported by the regulators themselves or the shared min/max by all the
devices powered by the corresponding regulator?

> 
> Fixes: d1f2cfe2f669 ("arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs")
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
> Changes in v3 -
> * Minor nit pick in commit message
> * Link to v2: https://lore.kernel.org/all/20240524082236.24112-1-quic_kbajaj@quicinc.com/
> 
> Changes in v2-
> * Updated the commit message as suggested by Krzysztof
> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240514131038.28036-1-quic_kbajaj@quicinc.com/
> ---
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 16 ++++++++--------
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 16 ++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index e65305f8136c..6e8f9007068b 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -96,20 +96,20 @@ vreg_s3a_1p05: smps3 {
> 
>  		vreg_s4a_1p8: smps4 {
>  			regulator-name = "vreg_s4a_1p8";
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> +			regulator-min-microvolt = <1574000>;
> +			regulator-max-microvolt = <2040000>;
>  		};
> 
>  		vreg_s5a_2p0: smps5 {
>  			regulator-name = "vreg_s5a_2p0";
> -			regulator-min-microvolt = <1904000>;
> -			regulator-max-microvolt = <2000000>;
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1400000>;

Having 2.0 V regulator with the range of 1.2V - 1.4V is strange.

>  		};
> 
>  		vreg_s6a_0p9: smps6 {
>  			regulator-name = "vreg_s6a_0p9";
> -			regulator-min-microvolt = <920000>;
> -			regulator-max-microvolt = <1128000>;
> +			regulator-min-microvolt = <382000>;
> +			regulator-max-microvolt = <1120000>;

The same applies to this regulator, 0.9V usually can not go to 0.382 V
and still let the devices to continue working.

>  		};
> 
>  		vreg_s7a_1p2: smps7 {
> @@ -120,8 +120,8 @@ vreg_s7a_1p2: smps7 {
> 
>  		vreg_s8a_1p3: smps8 {
>  			regulator-name = "vreg_s8a_1p3";
> -			regulator-min-microvolt = <1352000>;
> -			regulator-max-microvolt = <1352000>;
> +			regulator-min-microvolt = <752000>;
> +			regulator-max-microvolt = <752000>;

1.3V at 0.752V?

>  		};
> 
>  		vreg_l1a_0p91: ldo1 {
> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> index 1c781d9e24cf..8b0ddc187ca0 100644
> --- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
> @@ -96,20 +96,20 @@ vreg_s3a_1p05: smps3 {
> 
>  		vreg_s4a_1p8: smps4 {
>  			regulator-name = "vreg_s4a_1p8";
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> +			regulator-min-microvolt = <1574000>;
> +			regulator-max-microvolt = <2040000>;
>  		};
> 
>  		vreg_s5a_2p0: smps5 {
>  			regulator-name = "vreg_s5a_2p0";
> -			regulator-min-microvolt = <1904000>;
> -			regulator-max-microvolt = <2000000>;
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1400000>;
>  		};
> 
>  		vreg_s6a_0p9: smps6 {
>  			regulator-name = "vreg_s6a_0p9";
> -			regulator-min-microvolt = <920000>;
> -			regulator-max-microvolt = <1128000>;
> +			regulator-min-microvolt = <382000>;
> +			regulator-max-microvolt = <1120000>;
>  		};
> 
>  		vreg_s7a_1p2: smps7 {
> @@ -120,8 +120,8 @@ vreg_s7a_1p2: smps7 {
> 
>  		vreg_s8a_1p3: smps8 {
>  			regulator-name = "vreg_s8a_1p3";
> -			regulator-min-microvolt = <1352000>;
> -			regulator-max-microvolt = <1352000>;
> +			regulator-min-microvolt = <752000>;
> +			regulator-max-microvolt = <752000>;
>  		};
> 
>  		vreg_l1a_0p91: ldo1 {
> --
> 2.46.0
> 

-- 
With best wishes
Dmitry

