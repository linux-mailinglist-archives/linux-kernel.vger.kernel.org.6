Return-Path: <linux-kernel+bounces-196649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5C68D5F48
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE231F2152C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63867149C76;
	Fri, 31 May 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOF5Gutv"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744B150981
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150206; cv=none; b=fJtvmJiMlwXmvs53kUxzU3e5PjJTTGrrCG/dRFVPwaOsA0eGuv6Aph50j81nQCxqckx9MJl1uUcHpQkonXoxcxnSX57zo+WdTjjo2HeceNO0oNJhqY9r1Oxx5ULRqWJaic6wFvg8iP7TeClbOH7CYGJeWw9WEjSca6yy5XkKBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150206; c=relaxed/simple;
	bh=fTksmndDTvX3FXV3M5XklCCIM8WuaJli4n1k2WWdSFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4ky549vpTm1DJWG4AmNRRe3ahfDVtmU5M2hjU5z4f8tHPIusPOg++5pvsnPkc7gARjHS0vaSBnwnUzJD0+ZmocHI5K0LHo0u05x02VBwRamkw8DLDBkWR+4iVVOFou4JPhrkfSRICmU8SpwlOaidiDd6Obw+mHG55LbNynrDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OOF5Gutv; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e95a1f9c53so23162121fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717150203; x=1717755003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwfOQ3dECageVJLKD3vAG2UoJX5hF/uRp6wCRRPuE0w=;
        b=OOF5GutvbZI2UqeiQBWVZ+Rzjb58volBByeBuBOpUUkggR+EUEAXnF0jGNrEEDbhRt
         JKjnmpd9riIahy8LeBswIrJjvFbAGBh6GFfBvlGNi18C3GCiTOmCm3Okws2pIsV1hiOo
         JGhZAxkR3+RTufw+QxlhYZtmlrIdaK3cxvFsRd9ISEFYKuV9nGOdvAnS8pe0RZckQguc
         9wLp92yjFLmBubgaYqkQyL+tSeBy+7hOlCh/Ii/ivfMUkheRRCvEqSEXWfNm55KIsuAA
         vnvVYElW8aNKVjxMsewL/681N9QUK/vPfbd2eS6k90KY56yArPfO345OQkEmROOX6Mty
         m36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717150203; x=1717755003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwfOQ3dECageVJLKD3vAG2UoJX5hF/uRp6wCRRPuE0w=;
        b=woa/GUL/iidaDwC1ZVaZlt750YC9cgrnMWE68jgbtPDAIm83RQUMJLLlYlJNG7TqE4
         /YmhWcXT5amoEYhcmezfAuMoBEP5X5siwc/JsnIUr+zfhsVaBZjri2CLg8AfS6NrjcOs
         uy2VQfe9mtOpCqLGlKZeF7vUj+FfC8pjofo+zqpeEGFLoOro0oQcBpUXuD2sMzfJZeiM
         CQVOnXom2Mg16AgxfEznCugMFrYVNoFYJJEnKWd91xjPI9c36xRZGkraW7jHePSq5yq3
         T/a/BX2Swg1pANh16qc5Wapz1z8Se3qgWMq2zbygPAVbg54xSPvgG3S8x50OZa+6J3BH
         +3+A==
X-Forwarded-Encrypted: i=1; AJvYcCUPLuSR3Kw39vYy4ed8BrJ4YuM790bTXYk/Z1A5t0HvdX24RV0kEpJBSvMtMjRl3ZWomRYuCTT0SWrPwjHw/8uNiSflI4vM910wLja4
X-Gm-Message-State: AOJu0YyUUwp+PXghBAjxDRevAIXDGK+2wS+kQsFPMc1E06yfQG7OkoWi
	za/qoNoFzu7cfpD4nT0jhMWuqYI5tSIX6WVJ83D7uknA+Yp671GoR+gLjiS6diQ=
X-Google-Smtp-Source: AGHT+IEc2ysTUGY93B1Uge/CdR+H0J0ryAE+foagqOAZWTBhmukV2jutJ1gpYzXjeDOFKZ2EHUzIGw==
X-Received: by 2002:a2e:9c0f:0:b0:2ea:8370:8a86 with SMTP id 38308e7fff4ca-2ea950c923fmr10767981fa.10.1717150203308;
        Fri, 31 May 2024 03:10:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cc65cbsm2524041fa.73.2024.05.31.03.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:10:02 -0700 (PDT)
Date: Fri, 31 May 2024 13:10:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sm8550: Move usb-role-switch to
 SoC dtsi
Message-ID: <twgk3ufjkx2d5g2eoqdgcnfcch7jduihgy7iqmpaem6yryp7vt@c3e55qt7qoqo>
References: <20240531090422.158813-1-quic_tengfan@quicinc.com>
 <20240531090422.158813-2-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531090422.158813-2-quic_tengfan@quicinc.com>

On Fri, May 31, 2024 at 05:04:21PM +0800, Tengfei Fan wrote:
> The usb-role-switch is SM8550 SoC property, so move it from board dts
> to SM8550 SoC dtsi.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 1 -
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 1 -
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts                     | 1 -
>  arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts | 1 -
>  arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 1 +
>  5 files changed, 1 insertion(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

