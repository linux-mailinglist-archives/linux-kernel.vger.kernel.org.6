Return-Path: <linux-kernel+bounces-352587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D939A99211B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4FC1F216A7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6B918B49B;
	Sun,  6 Oct 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7hCGmKv"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C8189F56
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246397; cv=none; b=MsRo/4nCDKLUI4NX9vuZK//WR+M9bF9TQ/7n7MkOCvS5bh3ejl/uBnQuMySL/HhGUxEaF5rdfeg71dnk3v/7Q6sz/szCcjVIbSYrtdOR2HmaWHQ0+FO+gXlXKnd5Ky5Czb4JMsRQYzF8k3qWGCd0Mop+xUuvTiewBzQddAkeyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246397; c=relaxed/simple;
	bh=i1HSlcfG6Gk/k+UqtSwJNp1NND5qicT3kFk53HYZUe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abdAkTkyfCq2tQQHf2RpRYoOo4zEeHOTpmuW0NXZLzsvnGNw7AfTOdtHjEedU8KsFqhAyU2rUgrNdyBYGbvMsdd/CnfEwdJCNM21zVSokpRqS6Zit2c3LbtOGm1OmY47Yz70UeVezi6khWYXm9ibO08LqZv67dE8F8QhAZ9VYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7hCGmKv; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so4129045e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728246392; x=1728851192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBuPk8VD/ExsghxOi7SybSYIm/8sA+XnlePRO8akAWg=;
        b=d7hCGmKvqcaYbXke9FlfQ9E+9EcrwGRTml1Z2N+3RK6hqeFsFr58iSCDT+qkrX6IIG
         tnx4AD46SGeTadjAZe+MgAFCxDt1T/qR72R/NQV6ctDiTfqSlXkO94gQHslzt1yPY4De
         AFOJ267G6c/hVI7C3Bt/Yj/MmITxSktYArh6yFd2JUQ8uvqz+F+vMkM2zARnzwwUNVgC
         neaBIpuwbNDtonld4K4Tt9GMsJ+aoT4caagv6T5uML1W8meKHxAEpCiNcKKPGpLSnSVV
         PJDsIahJZ6Sy6D4kJ+4bI9YMGAYAmu2K2ZY1mKF8yQiUoXSoInxPItGovsEE2iXEFQzG
         zjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246392; x=1728851192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBuPk8VD/ExsghxOi7SybSYIm/8sA+XnlePRO8akAWg=;
        b=qwTEDb7zoWbSs/v5puthFB47Nrb+fPtE/jdY1x9WLer2onatBFo9LTG6lS6vVnuZS2
         d/W+fT6UEHAaVsURLWIMhANV+AAarYNCkmrEYDJM8TYL4FQQZu5sNCn91ZMfhyzK4KnP
         LVvEmNNK/RZ+mMHt9MPZndPOqc/Xm5C9JgLhLf0aCQVOKlB55vM3KpGVqsETfMy6uRla
         BJwN/h/C/Qgq7EatEzGRA5aVDKYgkELpICUv6LAfLr9J3iXNUOpmJFvaGaY5hOvL0yW5
         JimAQF0lK4IWx5hfgcLpse9DdCfveVtmaGCaUrwF1p5ykqbIqsubUQaotIHgXh0z3Fv5
         hg8w==
X-Forwarded-Encrypted: i=1; AJvYcCWRmXkG5X+2jkYYRSSjSUeCiPNdmZP9OdUfQeiAKv6s/T4pdIqfckf5XSPQPhkeKUhWw6yyT3KDItEDCaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAouwHfTYbngxk/RV5hH5iE3fmRSRPHAHWkZqcB3OG8EcJgo8n
	Ybr/eycIo0o2Gddh5O3vCgVO8okGD3JhHDLcBMQoZ8CPJyn3jpsPCphjt+NQnqI=
X-Google-Smtp-Source: AGHT+IFWMqbwIyqjBvX1et2WcBrUvnbXH6lIH+e+p5RToYoqEH6r+OtkMZyvqhjPIOtHuKw7nRa7mw==
X-Received: by 2002:a05:6512:3d10:b0:533:4522:7409 with SMTP id 2adb3069b0e04-539ab8c2165mr4593871e87.53.1728246392322;
        Sun, 06 Oct 2024 13:26:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec8b66sm602501e87.119.2024.10.06.13.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 13:26:31 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:26:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-fairphone-fp5: Add thermistor
 for UFS/RAM
Message-ID: <fshhw6lknar4z36rc2sjjcgkiixpp7hak7gq3j373mjvbokax3@7s7kmzlmtjal>
References: <20241002-fp5-ufs-therm-v1-1-1d2d8c1f08b5@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-fp5-ufs-therm-v1-1-1d2d8c1f08b5@fairphone.com>

On Wed, Oct 02, 2024 at 03:01:08PM GMT, Luca Weiss wrote:
> Configure the ADC and thermal zone for the thermistor next to the
> UFS+RAM chip which is connected to GPIO_12 of PM7250B. It is used to
> measure the temperature of that area of the PCB.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index 8ab30c01712e0b7c0cc1b403e0fe01650315b9e2..fdc62f1b1c5a398abaa71818fdf2858fdc445d28 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -207,6 +207,20 @@ active-config0 {
>  			};
>  		};
>  
> +		mem-thermal {
> +			polling-delay-passive = <0>;
> +
> +			thermal-sensors = <&pm7250b_adc_tm 2>;
> +
> +			trips {
> +				active-config0 {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "passive";

Is it really just "passive"? Especially with no cooling devices it
sounds more like "critical". LGTM otherwise.

> +				};
> +			};
> +		};
> +
>  		pm8008-thermal {
>  			polling-delay-passive = <100>;
>  			thermal-sensors = <&pm8008>;

-- 
With best wishes
Dmitry

