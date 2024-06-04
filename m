Return-Path: <linux-kernel+bounces-200179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6998B8FAC7B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24819282FB3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21414198E;
	Tue,  4 Jun 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoWwmz5m"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682E1384B1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487217; cv=none; b=OS63+wU9aTK97kPdhjDV4aRqShSCCB0EP26QQJbOC8mBZqE4gJPwKwDllP1O1aI3v4XpsNUIN0x2243AxC9zePMGPJAzBrZZ/fiQU/14LA2DtknslKCbzSCIAFqVdIIdurcSWv17V2awbzY5Zpu3R67Bxoux3u/5qsjZWwGm/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487217; c=relaxed/simple;
	bh=YVcF5oOm/Aj59C6GyqaXLxFiawVjvVSm5hVjKvyuPts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2tvhgINXU1D6JeX+IMO6ja71EUy9EPO2Co2WmbGPlsjtmnd/yRgf4BTCcO/nNXs9ukl35/oyFPCKQoQdlCURm7jNP5wvsyzMjLrv08OaGCxvWzdDZQTUogsnwfFM2yTXnZINH7/q3U384SLE/3/+UVX9vXDBs7Yu17pRPO3b90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OoWwmz5m; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b93370ad0so3716625e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 00:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717487214; x=1718092014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ArnO6Bp/HX6I0nIH5t2d1ahKjgBn1rOK4gnpq4M2PLM=;
        b=OoWwmz5mNGVz+qaRo/LDPyfcHrcsobmB2mg1LT/9CrtlGbTwt2eLAqBqfhzresQbwU
         zeSS88DRNYsp0V6eQ9WPDFB3xuaSt9C/xWJiVVc2gzJ39d/iYNBWYXJXqPmTepeWjOOd
         quMcoyhI6RkuTTNfoDs6o7j2rFpDbXMnq9TOfEYMUaEKZ1+16P+WltmeCdN2AttxupWg
         keDGh5Fl7gvDw8dw4V7SXFD+PPU6pCevLMXyHbCT2Xye573Bt8oqiQiFS2GZExtSb1QJ
         tmpq3j3NKe2zqTnkUqYL5t19cW5Y+0t+EG6NoJPzmmHfMoOz0te0S7xVev6CBqxaK2Oc
         zpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717487214; x=1718092014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArnO6Bp/HX6I0nIH5t2d1ahKjgBn1rOK4gnpq4M2PLM=;
        b=wOzpDmw3ku3Q/7cPrP0dQtDgdmM2S05m/4sMd/R54Eo6JKh6FI8rHIfDRnLvD27O3t
         Ey14shr4uSujk/fNIsUCwfKAkp5TOzNDVor+76B+l+1H0QFTpJDaEmiZ588rLsWTBWfY
         6WAS5ZS59soEOBx36hdovpqsiUwIfQ+1EPN6WsFzm8vTlPh0plW1k/ZWQSGEGLvVgL6S
         VVxRthaF7nKZchfp4J0m0fPmx/v0EIU7AyFpfFRRyrS0lhiq138mSBt31AOJ3ByTquCL
         e4LudJJZUY3jgOORLT6lPZ/3DiwCba97W8eOXmLOsId+CHYiKpVGub8k8y7LzsVuy2Su
         N1sw==
X-Forwarded-Encrypted: i=1; AJvYcCX5icHkMTtBhBjG1jnPr1gz6f57MYimaxCTgEkidy2WNlnllwo7B4dTJ642cSkgHDNc9inBUmb87baYPM6lVsx853r4Bedul4mDgUco
X-Gm-Message-State: AOJu0Yw5baCzvCjW13YVqmmh4KoIXB4djw7m0aO2ASk3+P2I52U7BkIj
	vHFVUN+VgkI80jrj1Z+SWE1Mbu8smSkRu2RkMjZKCTgLoFpd+raNzOg09hxhHs4=
X-Google-Smtp-Source: AGHT+IHt4EbuxRZrDYFrpec8oTySyjp1DrafnJTOx3RdW5qC5jdHWApwUFrCEtRNhy14a3agjZ5xyA==
X-Received: by 2002:a05:6512:444:b0:52a:39aa:7767 with SMTP id 2adb3069b0e04-52b89533ad5mr9251601e87.3.1717487213717;
        Tue, 04 Jun 2024 00:46:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d761f1sm1438590e87.160.2024.06.04.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 00:46:53 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:46:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com, Doug Anderson <dianders@google.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sc7180: Disable SuperSpeed
 instances in park mode
Message-ID: <le5fe7b4wdpkpgxyucobepvxfvetz3ukhiib3ca3zbnm6nz2t7@sczgscf2m3ie>
References: <20240604060659.1449278-1-quic_kriskura@quicinc.com>
 <20240604060659.1449278-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604060659.1449278-2-quic_kriskura@quicinc.com>

On Tue, Jun 04, 2024 at 11:36:58AM +0530, Krishna Kurapati wrote:
> On SC7180, in host mode, it is observed that stressing out controller
> results in HC died error:
> 
>  xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
>  xhci-hcd.12.auto: xHCI host controller not responding, assume dead
>  xhci-hcd.12.auto: HC died; cleaning up
> 
> And at this instant only restarting the host mode fixes it. Disable
> SuperSpeed instances in park mode for SC7180 to mitigate this issue.

Let me please repeat the question from v1:

Just out of curiosity, what is the park mode?

> 
> Reported-by: Doug Anderson <dianders@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Removed RB/TB tag from Doug as commit text was updated. 
> 
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 2b481e20ae38..cc93b5675d5d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3063,6 +3063,7 @@ usb_1_dwc3: usb@a600000 {
>  				iommus = <&apps_smmu 0x540 0>;
>  				snps,dis_u2_susphy_quirk;
>  				snps,dis_enblslpm_quirk;
> +				snps,parkmode-disable-ss-quirk;
>  				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";
>  				maximum-speed = "super-speed";
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

