Return-Path: <linux-kernel+bounces-190282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC028CFC66
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E37B21AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E3F6BFC0;
	Mon, 27 May 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJFFVgoJ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B4381B1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800617; cv=none; b=VREIsJ/oFwVpdCuoxidZn83N3I4nGTE+Dj0e3AWCtpWS7Kq87SRaGrrZjBQIxCVugFpyL/8MFVOBnm5q+eqhwbLjt89mnPwgsODVqcYpXl0fgdWoxgRH13djOTrKMpEBoh7wtijXSM80xCjEKFKoHVl+qFRuhQ7xAU4OCKCY4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800617; c=relaxed/simple;
	bh=G5Bh2X2s8X3dIBYLrkIYsnBHdHVh3//9YRXeeJxI2sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFrzHEisHpEUlp4VNsUkK8g/XrEhXnqAtXALFNNg8Lm/svNtc7Fo14u+X0DsOVreKju1ZE0046LXMMrvZuKbqXwHX8nvdQVGeIg6sLQZdxbZYKgOeYI0/vqb4FXX7MVG8lI3ogC8ba+QUHMb/ZIn86nl5uiD8gdKiEixJ88ChUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iJFFVgoJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso8338178e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716800614; x=1717405414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDbfSg8Bk1OlV44IsJpk4n7yxHQg+kBBcGX0Pm6RSHY=;
        b=iJFFVgoJ6Ex4O0PBiwRP671jlXp2VHvYUrmohAPCHAqP/fuYB33g0cBNPTnhMhTdkL
         eIiygNBp3N7sQj5gSvz4Ijd5YrdoUJsnqjV6NXqVnv2Pt6W+KyF8Wr9upFj5x2GVHWPZ
         zxMxnZJJj/91KxqmgLL2qz2sxjxnIMwxWeUi6S7cMbZTG/1weaM38O/XLrusPqXAdmaQ
         7sjdsyyRDpbRGH7p0Mf/6+vxFxl6NlKO1iGC5tJI0qcvglUj6uFNH2YW5zvLp62t2c3L
         imlig7IdorX7t9MAxpnUHU7xCMSTXN29q5sAogRPMXoVytSOO363MyP+qFT96XOUg7jV
         mh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716800614; x=1717405414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDbfSg8Bk1OlV44IsJpk4n7yxHQg+kBBcGX0Pm6RSHY=;
        b=Ekm+1pPgGuu2mtIvp3ovKcAJAyTtnxGjipGO5u0ymUMUcYUGqB6wrHIuYy5K4+RNVh
         bKldF7QYynlVKpU1auJFzpFKDz2ppj+/Vbcb7sbS5x70aj4p0qRRRtPf58VJM1DhIBM8
         jKIEybZjFG7mYAceT1II4OxoH3c3R7EeO7dkjFrGV8fvHo8OqvwGBj3HfUxxnBrdfdA8
         H3SS5kF9njJe+Ap50DvfZ+r49dzDYmUkrbrpRevbiKmBbQVLo36lwXhv2kj2kGLPcIFd
         TUwLZgGN5QwYYVRg6PyaOuQKEKhH7+W8BW9iT5k5iAc4Xhi04Q2gHS9wyAZgRaiWpsSv
         HrwA==
X-Forwarded-Encrypted: i=1; AJvYcCXyaDwnrI7grVtqJSZ1EH2y+XwHqTvyV0IRr7tFv9knRSk47jlWBJZTZxfdTccwXAH/KpT1ktPzycFUDGeQs9dD0WqG7/3DjbxkRZ2O
X-Gm-Message-State: AOJu0Yyg8DPf5GklhJy92D8VctDWz2394yyiPMfEQWxcCoWiUPcQnrHG
	V7FPpr83IoC2r1K3w0XPxzbCgtHjCagq9Py6DLP+8tuFFKlO6TBYUKyWtf89BW0QIscW1O+hN+B
	w
X-Google-Smtp-Source: AGHT+IEmCeUDXcsw6FPQgssqSnh256ZdtCG0rOxDKXtIzEh9uHIxpd7toGyYzGtLMhIFgkbWc1Awmw==
X-Received: by 2002:a05:6512:1d0:b0:527:a952:44c with SMTP id 2adb3069b0e04-52966ca6455mr4519498e87.55.1716800613864;
        Mon, 27 May 2024 02:03:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296ee4a9cfsm490355e87.75.2024.05.27.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:03:33 -0700 (PDT)
Date: Mon, 27 May 2024 12:03:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom-sm8550: allow 4 lanes for
 DisplayPort and enable QMP PHY mode-switch
Message-ID: <jwgt2aa662ig7max5k7f24uu4zpv4urvg5aplgl2pwo2ty4zp3@a644uqdn2avh>
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
 <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-5-a03e68d7b8fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-5-a03e68d7b8fc@linaro.org>

On Mon, May 27, 2024 at 10:42:37AM +0200, Neil Armstrong wrote:
> Allow up to 4 lanes for the DisplayPort link from the PHY to the Controller
> and allow mode-switch events to the QMP Combo PHY.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 3 ++-
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> index ccff744dcd14..a95949c01f25 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> @@ -941,7 +941,7 @@ &mdss_dp0 {
>  
>  &mdss_dp0_out {
>  	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
> -	data-lanes = <0 1>;
> +	data-lanes = <0 1 2 3>;
>  };
>  
>  &pcie0 {
> @@ -1280,6 +1280,7 @@ &usb_dp_qmpphy {
>  	vdda-phy-supply = <&vreg_l3e_1p2>;
>  	vdda-pll-supply = <&vreg_l3f_0p88>;
>  
> +	mode-switch;
>  	orientation-switch;

Please rebase on top of https://lore.kernel.org/linux-arm-msm/20240429-usb-link-dtsi-v1-0-87c341b55cdf@linaro.org/

After that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


>  
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index 39ba3e9969b7..fbac5270b4d7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -795,7 +795,7 @@ &mdss_dp0 {
>  };
>  
>  &mdss_dp0_out {
> -	data-lanes = <0 1>;
> +	data-lanes = <0 1 2 3>;
>  	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
>  };
>  
> @@ -1142,6 +1142,7 @@ &usb_dp_qmpphy {
>  	vdda-phy-supply = <&vreg_l3e_1p2>;
>  	vdda-pll-supply = <&vreg_l3f_0p88>;
>  
> +	mode-switch;
>  	orientation-switch;
>  
>  	status = "okay";
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

