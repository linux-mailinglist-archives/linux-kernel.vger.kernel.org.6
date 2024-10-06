Return-Path: <linux-kernel+bounces-352584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE88992109
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DD71C20A1B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12C218B483;
	Sun,  6 Oct 2024 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVAB5WRP"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57729405
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728245233; cv=none; b=WdkAN4T59u5HygDF2tXLAXynq7vJ9IDPdJFKJdAEdfS208SyL29mXTCQmDqDoTOn51D1zWYOmHMFV1YwyGU9O2ky9a1Q47TDt6PHcohIj5P3gQyJK4rnb3+pur4s2REt5xm72jKcCGxAQR3KXZayaN1RlG1Ef3/18IAZqg7t0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728245233; c=relaxed/simple;
	bh=hWlVn6wqYOiZf/D380nxzst1Ny3r+QrTd4JE5sBLCm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW/PhMiKIAL83KAVM/ReGvjxL5gKTcectYumuQHiDPRTIAnqXSqNhKbMv6Gets9zGTlpCVXXZ0OjFOZT18oRJkj3DXMoPjyVFmnU7GmZFQX5QM1ZDbes33gnE4ghH/CQQS2LkD4XhkNTLHdaS10f4u1l2ix2O5fR741LVbpYYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVAB5WRP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398df2c871so3891996e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728245229; x=1728850029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1aKTq90Vhx5SEGbGXZgfVnFGr2p8A90AYr+7ozDiYY=;
        b=FVAB5WRP5WKmhHJlnq4Rvj8inClkLG1ReUyfc09COMcSSL/ELs+ju4YyiSrvu3ktIb
         cXQszaDwIrmZhHrOcGYghofr4ngQYSYRtcZPnR7UsHdRVCwmsXJwbvbkX+xiW9W+DZu/
         JVZCLgW/7YQlgV55tCcxfl+sUBfDguQFAJGtNSUdHG04DvzLQlWycFLIt8z8F9kvF/21
         N5yMPAEOOMo0PLVHgi8PkqquOEapbnecYBQon7LEMxwLZxbeWzJ3VixJkXu9uT/PT5UU
         Sh1vXCPTzVHyCSOnCd9lvmf1EF3rUqu1F+XIkc0ao/SmAsYhNSITYhUpL0oTRqNoNdAt
         yqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728245229; x=1728850029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1aKTq90Vhx5SEGbGXZgfVnFGr2p8A90AYr+7ozDiYY=;
        b=KchOBPTbjswroP41BGUSnfGDDCoePKXqjoGpvahlnUOSVNv8m3W1EH4IT0JXGSF/AJ
         0e6/KeaSjw3pOs2p/7uOQ5l8hFHTP4z1t9DmKeYCriElS2CRA0+7Xq74rdaFz1UablP2
         kd9xcuL7/2jWl93NjFSPkWf6vkMRdJK82EtMRJAZCsKoAYqlC2HZf449/WoUE2gBBt8z
         OTy+KsbJoFBWpgPCDFqOmE4iG5/4vrgdAbP4g98dhflbDtQ/Js2kGCJmWgK4KPVZu2T4
         ibGTi8VmOpZfdunDkjngIcz3qRrLwAgyVFvD8g4izbNXkpaO78ryObg105rAg7OAgc8H
         DHdw==
X-Forwarded-Encrypted: i=1; AJvYcCXTJzwnBjuZbEFz4D5LxPOrNqtNxcM9BwhmQbdfln2ZSLQTW7z8XzzpBAtRP9fmkJeOrOPfT6VBt4cHGLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQ/Fk2hgoXWGVXNtZL19egmAW1VU47bRO2VNVbK8shLg5i7o8
	uFAf+zSN40b+m0jFD55m/JX85J/8qIyvyouitBiqPiL9uNYX1kxwN0IW5dajL/I=
X-Google-Smtp-Source: AGHT+IFKknDCxNnpYRFa+g3cPJbjZFRd+fx1yS92WOXtOwvo4hAI4DPBzjNxMcxwiu6wMUNEhhPAqQ==
X-Received: by 2002:a05:6512:3d0c:b0:533:455c:8a49 with SMTP id 2adb3069b0e04-539ab8adbccmr4075594e87.38.1728245228683;
        Sun, 06 Oct 2024 13:07:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d1f3sm599873e87.153.2024.10.06.13.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 13:07:07 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:07:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rakesh Kota <quic_kotarake@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_kamalw@quicinc.com, 
	quic_jprakash@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490: Allow UFS regulators
 load/mode setting
Message-ID: <jid5coqe4tpsafbi2haem6ye4vrpwyymkepduxkporfxzdi6cx@bfbodoxoq67l>
References: <20241004080110.4150476-1-quic_kotarake@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004080110.4150476-1-quic_kotarake@quicinc.com>

On Fri, Oct 04, 2024 at 01:31:10PM GMT, Rakesh Kota wrote:
> The UFS driver expects to be able to set load (and by extension, mode)
> on its supply regulators. Add the necessary properties to make that
> possible.
> 
> While at it, UFS rails have different voltage requirement for UFS2.x
> v/s UFS3.x. Bootloader sets the proper voltage based on UFS type.
> There can be case where the voltage set by bootloader is overridden
> by HLOS client.
> 
> To prevent above issue, add change to remove voltage voting support
> for dedicated UFS rails.

add change to remove smth doesn't sound correct to me.
Please don't depend on the bootloader and describe hardware
configuration. If there can be two types of IDP boards and you can not
identify the voltage via other means, please create something like
qcm6490-idp-ufs3.dts. Please add proper Fixes tags.
Last, but not least, as Bjorn wrote, please split into two patches.

> 
> Signed-off-by: Rakesh Kota <quic_kotarake@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index 84c45419cb8d..8a4df9c2a946 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -258,13 +258,15 @@ vreg_l6b_1p2: ldo6 {
>  			regulator-name = "vreg_l6b_1p2";
>  			regulator-min-microvolt = <1140000>;
>  			regulator-max-microvolt = <1260000>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM RPMH_REGULATOR_MODE_HPM>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l7b_2p952: ldo7 {
>  			regulator-name = "vreg_l7b_2p952";
> -			regulator-min-microvolt = <2400000>;
> -			regulator-max-microvolt = <3544000>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM RPMH_REGULATOR_MODE_HPM>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> @@ -277,8 +279,8 @@ vreg_l8b_0p904: ldo8 {
>  
>  		vreg_l9b_1p2: ldo9 {
>  			regulator-name = "vreg_l9b_1p2";
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <1304000>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM RPMH_REGULATOR_MODE_HPM>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> @@ -467,6 +469,8 @@ vreg_l10c_0p88: ldo10 {
>  			regulator-name = "vreg_l10c_0p88";
>  			regulator-min-microvolt = <720000>;
>  			regulator-max-microvolt = <1050000>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM RPMH_REGULATOR_MODE_HPM>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

