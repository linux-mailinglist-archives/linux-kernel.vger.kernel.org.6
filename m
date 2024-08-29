Return-Path: <linux-kernel+bounces-306194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD70C963B00
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEA01C24114
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7631E157A55;
	Thu, 29 Aug 2024 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfQq23Pw"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD114885D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911779; cv=none; b=g22+wh43fIRa5ETESZQ50uccdHLbLa4AXVBd4S/YInEDSpgjMdSQzxwNALKJKaNSyqzhf4KElBFelqMYMZuZ1d29a5orARc+nnFhB8K+uPe3WiFjdPqZH5AXHLmK/wZMKAg1tpZv2ClrkDCqtA2QG9kQ6Y0u81IpW5iJm7/N350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911779; c=relaxed/simple;
	bh=FdVFyLT/x1rsG14wGDYAOcBYWaGG2qbCcDt24uqUXLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeM4xtl5ZxC/cKXycwEJA9ZPYg7hOSEFZh01RqVFtvnHm43Ujbgic/iLWh9QxFZNgxwYRvqb/oOBO3O0rVJlXrjgOK32uyJkqyRE0Le51eiTMEqVJgFgGaK3Lp0hIJCYHjmlMNW0RycqmDuft/2yXw8GotYqBHHLdEqgfmMLEB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hfQq23Pw; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53349d3071eso310514e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724911776; x=1725516576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3pkh/ED0BxrYfQgLbjlqIU28qynPeADtyfaWsIf8Rc=;
        b=hfQq23PwwCRwBzwfRWbvbUBRI/rlsVBLrGHR8gyTK3FjmLh+RYPV2tP4SbbXxp0A1Y
         YY+Act7YRtsMOPcJBF18fG6svUownM99bJXeeUTewTMb/V4dkSaBrCQoMRjfnx5bS8cC
         DDJugOriy0qxPVB5Mts92epFagXtZ5MNTRCbKnJhE9f53u/4m3fbsaF3VdLBBm9St93N
         5Hxdf0z4/Zx4AgKoN9DxKOkqwb842DmWaFwVC7MyKIuqdrub8aLBpXGIIGE15nqy7ySo
         1zfwHsApxu3uofujtyaipkpDWPJaHXxkKmUuMA0vHhjlhvDKlACJvQHPUJbonnaE6xHx
         LZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911776; x=1725516576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3pkh/ED0BxrYfQgLbjlqIU28qynPeADtyfaWsIf8Rc=;
        b=SSkS5w7KRtyfPGb13WbSATHVg4ADlm7PvKiFF+8lZ9AIeTp2N55UGqP8PTMNr3aDoI
         jb733iw2bl20jfVvyZsJ0UxRYTzY9L7q2JO9R7kJHDg8ZqWyj9uKKsAHB7tjayNkyHpe
         plBIR2hkJERtRC6XBzdZ46uwjCcJfdTrhGhXnwP99Na6CZcnto0r0+ucfN8ORFZO0KHv
         Fru9lxAEzZAwexD18F6XGDG//Ecgh6jOMA2Fp5iLgFBo2coKkGOQo3dOpq0EdCo2bR29
         y4zhd2NI8CIC216zHJfdNdfIiKMzDbKf8P0suc15FuAUqr1xUnFXdScLxzmZQ1Zsf8PE
         21wg==
X-Forwarded-Encrypted: i=1; AJvYcCWL6ofBDqf65Fo5kiacYt+gkYzCf6RRPsMNqGOiXxIMruX/59E3ABi1beBlqga7ybf/4buGf9XF87kmMRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HBrXUG7FVZf2AVdSdd9zoYEO9DvV3kNDmePPHRvfs6JHQdnQ
	uQHJBGF5eVJz0fYDvWDDKEVZ+3/iNj7aUo1V7BkaRpzMKobYDZy5DdHjITKwWMrgbVr1Gr0MANo
	b
X-Google-Smtp-Source: AGHT+IErhxCewvU9PV2ayjz+bdB6RfWmVGeB2Gdz/UBsTPEUAIjsolzfgF/RaX19bHrgtd7ZCUTk2A==
X-Received: by 2002:a05:6512:138e:b0:533:1cb8:ec6b with SMTP id 2adb3069b0e04-5353e57edbcmr1010194e87.27.1724911775332;
        Wed, 28 Aug 2024 23:09:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354082751asm61004e87.151.2024.08.28.23.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:09:34 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:09:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sachin Gupta <quic_sachgupt@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com, 
	quic_rampraka@quicinc.com, quic_sartgarg@quicinc.com, quic_mapa@quicinc.com, 
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com
Subject: Re: [PATCH V2] arm64: dts: qcom: Add SD Card node for qcm6490-idp
Message-ID: <35ajtwyzlnna46fatvnbnqqnks4ii7x52k56c46cy5ztv62twk@rkdp3ctk4mz3>
References: <20240822054457.16314-1-quic_sachgupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822054457.16314-1-quic_sachgupt@quicinc.com>

On Thu, Aug 22, 2024 at 11:14:57AM GMT, Sachin Gupta wrote:
> Add SD Card node for Qualcomm qcm6490-idp Board.
> 
> Signed-off-by: Sachin Gupta <quic_sachgupt@quicinc.com>

It doesn't look like this patch was tested, see below...

> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 27 ++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index a0668f767e4b..8cfbb42af6a3 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -641,6 +641,21 @@
>  	status = "okay";
>  };
>  
> +&sdc2_clk {
> +	bias-disable;
> +	drive-strength = <16>;
> +};
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
>  &sdhc_1 {
>  	non-removable;
>  	no-sd;
> @@ -652,6 +667,18 @@
>  	status = "okay";
>  };
>  
> +&sdhc_2 {
> +	status = "okay";
> +
> +	pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>, <&sd_cd>;
> +	pinctrl-1 = <&sdc2_clk_sleep>, <&sdc2_cmd_sleep>, <&sdc2_data_sleep>, <&sd_cd>;

Please point me to the sd_cd definition that is going to be used here?

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
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

