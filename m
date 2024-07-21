Return-Path: <linux-kernel+bounces-258247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013493857A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 18:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09A12812E0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AE0944E;
	Sun, 21 Jul 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vl9eFEDL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65295167271
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721579255; cv=none; b=kCZx7dh5LOHyTXDfY/i7SHfKUoHedHvizp2Nkc4izBy7Eb96s+aY+RcJOnKR81j4T9BWePXZKCnpGVZQ+iSwT3ihepVryxEQz7WnNGGtwaYEmuqMFHb2/VvGxCaRcnncM/Vyt7hGD5C0er0tkaxvTwjf7Jll8EnZQmZ7jTg5Itg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721579255; c=relaxed/simple;
	bh=P+7CjZPdLR4mLuLE5UB9w3uVyAalwaQ2HLGx/4gOxG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucKCpDFMMfflTMn8w7QlSQGf5vj+q/ryr30X8ZVfgtEo04wOdXj9jr0m7pXfjsdIUmHRp45e+EOr9MUqqqwgPhoZS8WT0NpA+GzpkSUdAuv6uF5T4lg3MoeT31wJXNMgMoyx7BmYN0M29xkdC8e31zF7h566LVl3I7HsJdO8nUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vl9eFEDL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-427d2c8c632so24286965e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721579252; x=1722184052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKcJ4KYW4wXVfoSKqiMkmDlwhFJlq1lDLVQoBAvTYmU=;
        b=Vl9eFEDLQM6DCnebD6+IdT0JkjKrj6VITtaO5xKs80YyPujhDixHFw465ptTt1lMKp
         /hg/PldfuprrnAnDgH1yHeBxbNwXY0en3z5xxRSmUH9afydFaGzu7ab+VUoe1oRcrG0C
         nQumsp1WDeXhJw9NN7284IO7KjPrSmIIINRx2dxMwR+Vvmol77LmbhAAbEL35LYhhkq5
         xHOLF7ocGpmmWV406R+fxJ8vt+REWha8Wmy++M9M2zkFQPJYWs5QizZYcL7Iiq7AkEfP
         JXBJ5kL7qIu2BQO1+1Sf+jiBQoB9RYHJoejNgJma4hdsOblaPdK5J00gpiAKaFLnw++1
         mblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721579252; x=1722184052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKcJ4KYW4wXVfoSKqiMkmDlwhFJlq1lDLVQoBAvTYmU=;
        b=HEtjjrVXRXTgzG9JilVOW4eTz9F7QeDnNFCYn0AqK9bfDfKwg1+Nzls6SXWhzIzyaQ
         11KlhpWGG7WgRzdzWXIvSBDs+tVOgl8dCebSfFZ5YDzwq1Ddwtdm8X08BA4wJWzpW0W8
         BxO/3VGKfJ57Odhq6X0I7JXrL8ivASyRAHACohW434coeYA0C6G3AEWQ6pyj4DQGmX/9
         8HY/JTWHkT9mhhmLqCVW69msZtSkqdo4LBNeSmg20oy2V+l3GujnV53iaB2abXlRdIKD
         D4wqMMJEojRWYdwHQavptHzNI/ut3sRbokTWm4WW7oJ3nJbYSb4kr5XPUaqjCgw/onma
         Tq1A==
X-Forwarded-Encrypted: i=1; AJvYcCVSav2f18U6MglwhIrmO6qhAD5+I7Qh90bHqxeGO7NiwpnMuvIF9XsETM0sUrsfmSBYIHZIcoeUmI+/yR0a/CLuCRco6mLvccuItxNW
X-Gm-Message-State: AOJu0Yx4oj0iCfHI28kQnNeHbOIHM+TezWIrIK0U0cLq3+Ax8IWWNF86
	qK8Dp+CZUPxqheersF9858pPUCVTJa6n1k1sLpaChNQEpuyzSveIiMDTSzr3PJU=
X-Google-Smtp-Source: AGHT+IEsO3Y1qTWskCsQShqN7vS04iBPOTsEwG41iTFXyoCITuBrAzLI1WAFLsk20IDrTB9bTKDdYQ==
X-Received: by 2002:adf:fa03:0:b0:368:5d2:179 with SMTP id ffacd0b85a97d-36831755ea0mr8056826f8f.56.1721579251517;
        Sun, 21 Jul 2024 09:27:31 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a947fasm123149335e9.43.2024.07.21.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 09:27:31 -0700 (PDT)
Date: Sun, 21 Jul 2024 19:27:29 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: x1e80100-yoga: Update panel
 bindings
Message-ID: <Zp028V1KzO/bWFdd@linaro.org>
References: <20240719185250.4877-1-robdclark@gmail.com>
 <20240719185250.4877-2-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719185250.4877-2-robdclark@gmail.com>

On 24-07-19 11:52:50, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Use the correct panel compatible, and wire up enable-gpio.  It is wired
> up in the same way as the x1e80100-crd.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts   | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index f569f0fbd1fc..28a6ea5a24fd 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> @@ -592,9 +592,13 @@ &mdss_dp3 {
>  
>  	aux-bus {
>  		panel {
> -			compatible = "edp-panel";
> +			compatible = "samsung,atna45dc02", "samsung,atna33xc20";
> +			enable-gpios = <&pmc8380_3_gpios 4 GPIO_ACTIVE_HIGH>;
>  			power-supply = <&vreg_edp_3p3>;
>  
> +			pinctrl-0 = <&edp_bl_en>;
> +			pinctrl-names = "default";
> +
>  			port {
>  				edp_panel_in: endpoint {
>  					remote-endpoint = <&mdss_dp3_out>;
> @@ -663,6 +667,13 @@ &pcie6a_phy {
>  	status = "okay";
>  };
>  
> +&pmc8380_3_gpios {
> +	edp_bl_en: edp-bl-en-state {
> +		pins = "gpio4";
> +		function = "normal";
> +	};
> +};
> +
>  &qupv3_0 {
>  	status = "okay";
>  };
> -- 
> 2.45.2
> 

