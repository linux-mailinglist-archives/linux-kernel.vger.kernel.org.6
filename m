Return-Path: <linux-kernel+bounces-384436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474139B2A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A415281B73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722E6191473;
	Mon, 28 Oct 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Np38qnw5"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E38191461
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103817; cv=none; b=du/0hWPP74FDbuH/LpePVMCpJpu/fBqUsPgaYcesdR57csYZOuFOuGN8OY/9VXDOTVgi2YjAqJQE3IPvDm7xM+UFGZVVQXmzj0UXY0a6zVPY4aDMeHIcenpHfvQ6Ah3YM3QDif4ClxkBjQcoodtIJyd1ekudg3cPUUSfqILdKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103817; c=relaxed/simple;
	bh=/d+2IkSJCNwNIupVTrTEHcvMojPg0UGDOxZl2Lce5ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaQOWLrGFURpJMOA6Fensjk9u3QTY92BiigcKq/ruPkVgras0VQKrITugR3nrKcVWfD1mjTBcspPQ9OY9o/MyNMPKBoWxwDJkWcpUiERJLOK+1EYU+xogB/VSUnw0sieGZBeL1KQ/VtvL2PxisM1EuqpIMFgxPojJZthQXjlX+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Np38qnw5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539983beb19so4685860e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730103814; x=1730708614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUoMe7Gw0VEvJOuEYm6YZ2LWFp8oPbVLGHudNKpQpt8=;
        b=Np38qnw5XBLvrNJIh9ho4hUEpUUgNw0XxofnA+YJaCviM+t5KyjTFcQHjk4ME07mcv
         Xs4o+5+FwhrmwIb+703IxUYxgJDcuVp1pIllAF1sTq3Zt7mKV08m9EV44bOf8eUfywsr
         l/U0qFZKF3ASgtQ0aaLHgwRN4s7HuWr6sVbqtibdlt8TFzm6616CYCOZmwlyiTsh4DZS
         /fL1wJiMEjs+dKNxHsBJNfjpm7nP6fRM/sS+Co5Cv+05h5wkEW4ENGDksOgqlhhFj101
         lZlPVcLvadNmRKrFvxAhZwFapQR4oZcONejlBpd+e/T6GN5xFnm9p+Cj9nev7C87E676
         IvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730103814; x=1730708614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUoMe7Gw0VEvJOuEYm6YZ2LWFp8oPbVLGHudNKpQpt8=;
        b=mnE7Mmh082QVStfSy/aGI4fVT4Jyd3XBPkKrdc53PoN2pUahyWtNlCZJs9YQMnxmT5
         1jMgpwTe077/a5kZYkgja15ZAjEpK2bOSZKlHC44FO8VBqAr01Ece7IZaM+mTX6lA4TY
         nmtMJX9+IJkC9dVeMqqiM6EGtA90fdPUmaYRp+XFjiDFVqk2M7sKLRHCR835CknJE3Dj
         2U9lVTKYXeFHZq8qrjVwjqPAXl4Cv16uOPoR/c4vTZHmiM49BR3FQ6AmqSnZQKfGK3CS
         vzM/vD9mFQMzk4ooxfyj4Vr4R+Gch0xogxF9P92eSORK6MbYa5N+CX2gWGPlxBWQNbSp
         oYCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfjhzjNEuFeRDEjZNQktH2xc/m8C+eD7U4TgJSPwM3z9TQjZc4msu9BOve/tDxyKQC8y/xgI14GsH2PxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMS76Tu3yjvQnoT/jeRq4sDKG0WIu1Ag5PxK2H6lAvMEZKlOXH
	RuzTXmQ04t2mECZ+rKqcZChzbqayT6ZSgl0/UmMZFH9GIBxbJC+E3e71/I5C8jQ=
X-Google-Smtp-Source: AGHT+IEhxspZK5wru21G6gRgmfpfz8XSi40k3sCmsCihw73y8CtFR9K4gZ8rSF+ukjO3fUGagpJSmQ==
X-Received: by 2002:a05:6512:2304:b0:53a:aea:a9e1 with SMTP id 2adb3069b0e04-53b34a1afd9mr3321756e87.54.1730103813913;
        Mon, 28 Oct 2024 01:23:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1af4e2sm1004236e87.170.2024.10.28.01.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:23:33 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:23:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs615-ride: Enable PMIC
 peripherals
Message-ID: <j4ggfrynyoriseef5r5x6uwgo6cespll2np7uitc64yagoa6pz@r3ro2cpqrrry>
References: <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-0-f0778572ee41@quicinc.com>
 <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-2-f0778572ee41@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-2-f0778572ee41@quicinc.com>

On Mon, Oct 28, 2024 at 04:03:25PM +0800, Tingguo Cheng wrote:
> Enable PMIC and PMIC peripherals for qcs615-ride board.
> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index ee6cab3924a6d71f29934a8debba3a832882abdd..37358f080827bbe4484c14c5f159e813810c2119 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> @@ -6,6 +6,7 @@
>  
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "qcs615.dtsi"
> +#include "pm8150.dtsi"
>  / {
>  	model = "Qualcomm Technologies, Inc. QCS615 Ride";
>  	compatible = "qcom,qcs615-ride", "qcom,qcs615";
> @@ -210,6 +211,20 @@ &rpmhcc {
>  	clocks = <&xo_board_clk>;
>  };
>  
> +&pon {
> +	/delete-property/ mode-bootloader;
> +	/delete-property/ mode-recovery;

Why?

> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

