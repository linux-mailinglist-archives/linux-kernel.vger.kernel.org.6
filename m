Return-Path: <linux-kernel+bounces-266475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101AB940066
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426D51C2208E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A918D4A4;
	Mon, 29 Jul 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOgYJwNz"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF518A93C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288559; cv=none; b=SyxHhfckVuEQ5P7t9mBOGSlNrgU+nOLY1KvDuYCWullfQuuirIHj8CQwRuCNBTInOdKwIM++h2JkTBapa2lzIP7jng3CjZy+lnPNAit3bfXfL+vi7pawfrgiHQNEpjqPCkr2UVgFu1Rj1QFH/rm3xkhFUWiOSS05vBqMtaGDEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288559; c=relaxed/simple;
	bh=TVFN/CXZ51tNyS9FDN34bX0XjUq6i+6bt6GMO8uJeCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzToEzgSeNq9lnsEKBCKkQneQ8NJw/bUKuVixeu93+5Ug42wEI4dMinbG/cO0Xxa+EOYZhF7tZbl6vDdzKX43cSGRX/kQBMUf4jsZYO9pYVTsZKNyzkTqBHCGoJZP5zt7MCL1uRH7zDUpXeum6B8nFjjj5ASEQWVuhO2yYFWC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOgYJwNz; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso48498991fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722288554; x=1722893354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3tBjhHkIyFqAEajxTJPjMrc5LRc364fGp0t/5OMkxw=;
        b=xOgYJwNzBKMtEUjIXPz5krdDzaDV47wLY4/Lt9lyvXX1O7W/S1EJha060cHAvm72Vg
         JNT0567w/zdDwAPF7dEwN+b/URq5ZhR6N9pxj8wWrsYUryKW5Oie+wtnwyi+TmO+2sY7
         Q4lvBnAYoiUNIkES5yHfdTJZkQB/54JigBewd80VCpu+XSKc6DsYCrnNU+u/8+3mYTez
         Kvrc+3I2dpFokM/vwodDa8V0iVQ+cUjSKqvG5dce7SrDKa40SmUGmz2LB2gfa+fcPfxL
         rEyD3rpDliLBm49gFVi1TdUb1PyHJB2Xne2JQLo1SVRhssRyI5a+QFt6nTpoe0iRS7x0
         O+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722288554; x=1722893354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3tBjhHkIyFqAEajxTJPjMrc5LRc364fGp0t/5OMkxw=;
        b=WpKohTRpbeJpWyXPu4izWZKCF+I0XFgsjIVeQnOsISY+N6lEG8l/PVTR1OhCsMIzeh
         6GUsSNAFIjeB6w6TYx9YTFA9vnsBe16S0//wAVQgTz/uuwbpn2zoI1C0bq/wHmhq7NTh
         BpwyiwAnK/vBuNhERICgOryrBlGuse2+TmFZ63rppQw26lfyQT0vCKZ6MlyzlJjTZwn0
         obpqAeXDnC64nL5he39P9qLnk1gllidSszfRmwSYAReY5za4sCp/XwZGlD2fn9NFPWz7
         QwtiVV6mF9WyRbyisAE5yP2i+jGn7/aUsSoibHROeU3Orn24NG2uimsBG9qF9SPCrj/C
         0WkA==
X-Forwarded-Encrypted: i=1; AJvYcCV/NLiKpfgf0r3dCIWkfx8mUFxB4JPBwUY1UwqA/iKpUwp4r6w1k22AYZ0vUvohbZlL5WVtUzjRa+3062nGEEHUEfyxlgzv747raxT8
X-Gm-Message-State: AOJu0YypJqKgA3kI06c5FlDwIJdcVm1e6cDs0VHzVwpr7H3vF6XdorxG
	jQaliAFlR3l/abGA72b2qkxkwRm/KyMT6oXfkQCX3INeQNFHpwMH+uN9PJ7wtr8=
X-Google-Smtp-Source: AGHT+IHGXIrdh6i1p9LXgEyc3MwjtnVaZOQUxFLXA43PhKktUbIyS0XJQZwMOAUl5Oc4lX823qdsTQ==
X-Received: by 2002:a2e:95d4:0:b0:2ef:dd45:8755 with SMTP id 38308e7fff4ca-2f12edf7f37mr56827991fa.9.1722288553889;
        Mon, 29 Jul 2024 14:29:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d04e138sm14669861fa.85.2024.07.29.14.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:29:13 -0700 (PDT)
Date: Tue, 30 Jul 2024 00:29:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	kees@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com, sudeep.holla@arm.com, 
	quic_rjendra@quicinc.com, andre.przywara@arm.com, ulf.hansson@linaro.org, 
	davidwronek@gmail.com, neil.armstrong@linaro.org, heiko.stuebner@cherry.de, 
	rafal@milecki.pl, macromorgan@hotmail.com, linus.walleij@linaro.org, 
	johan+linaro@kernel.org, javier.carrasco.cruz@gmail.com, quic_kriskura@quicinc.com, 
	lpieralisi@kernel.org, fekz115@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org, linux@mainlining.org
Subject: Re: [PATCH 06/11] usb: typec: ucsi: Add qcom,sm7325-pmic-glink as
 needing PDOS quirk
Message-ID: <vfo3bwozhf3f5bv6yipx6h3zgapiwzotw5l43he2q5h5ofpg5s@o34fxv3ly5ue>
References: <20240729201843.142918-1-danila@jiaxyga.com>
 <20240729201843.142918-7-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729201843.142918-7-danila@jiaxyga.com>

On Mon, Jul 29, 2024 at 11:18:13PM GMT, Danila Tikhonov wrote:
> The SM7325 Linux Android firmware needs this workaround as well. Add it
> to the list.

Which one? quirk_sc8280xp enables two workardounds: one for the firmware
crash on GET_PDOS command and another one for the empty PDOs being
returned unless there is PD-enabled partner.

> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 16c328497e0b..80fb04473617 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -294,6 +294,7 @@ static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
>  	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8280xp, },
>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = &quirk_sc8180x, },
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8280xp, },
> +	{ .compatible = "qcom,sm7325-pmic-glink", .data = &quirk_sc8280xp, },
>  	{ .compatible = "qcom,sm8350-pmic-glink", .data = &quirk_sc8180x, },
>  	{ .compatible = "qcom,sm8450-pmic-glink", .data = &quirk_sm8450, },
>  	{ .compatible = "qcom,sm8550-pmic-glink", .data = &quirk_sm8450, },
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

