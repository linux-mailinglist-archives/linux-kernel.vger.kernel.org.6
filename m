Return-Path: <linux-kernel+bounces-324711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76591974FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F4228D5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F97186607;
	Wed, 11 Sep 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zY0EqP5S"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94B91802DD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051438; cv=none; b=ufw9xw/ECfa6sb5l0FGagbfyzxo5kj/KAmCo9Ws977uF2sReuYrlbANHGywYyBb1NN2DnDvM76NHzxAZPXz96XctE7g1Hcwh/z++pHNkc9VgCVqVoy8ZadKNJlskVQKaMNO2IgMaNf/958X1ccUJuWBiU0CRQziK5WvMzHrP0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051438; c=relaxed/simple;
	bh=h/LBrWSpUs8DPI9U1+af2i3m6dozVC63fYk7NBtw7Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgfXpzpYq6C7QsxEbVzHSR8jcoYy+IQWh8z8ksDZ+E0wogVjYQGE8m2Zg9CmbmlF70YszflGiLsUXEjNzejiRkfJ9hnafvA3lN5sqzmJXwA0UKmQ/tpjeOq2p7WlS9LnbxN58nmmRXTXQe+RaVLTkPKum2ZHe6KDSUDyLxGuBYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zY0EqP5S; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75f116d11so48702821fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726051435; x=1726656235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEmg0mv3aZiw4epk0S/D8wOQJkCJdi8IprxOeJvP7ug=;
        b=zY0EqP5S6SX3+wBo+e/hQFGJWZlDvJAuXMh6/WVH4CvjO6w3nXiP8ElqFXsZ71XiKE
         d0NUCFbRCJZ6+JLRwwwuS3tszGBJWOfvA23YrtD/cFLOAgrImnbVzXR8fTE8GzuOHA7Q
         WsKBilNJpLU9KpdYez8v9JKWFhpFmoUXsoWafI8sh1MH59cK1PPglRD3btbafmK+Lyhv
         1inidNZ3Z2e71pz/H35eSewK3NBdbWpdvA8Hwknp3CO+LadYDv0A3XHck702SsWl90RF
         dvUEjnS2YjtmtpgKbUIF24arxeK6SL6SDk6d5emKJ64dJvehGi1Mq87PE9BjikljXN2g
         5+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051435; x=1726656235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEmg0mv3aZiw4epk0S/D8wOQJkCJdi8IprxOeJvP7ug=;
        b=PxvB+zTRz0EnwwyR5+62ReuT6SGOHBcGKb8QimrjIM2i91yyY7p+FaYt7yaPX8AkBx
         WfS4d8zx49amnluioY59awJ0DJMUWwib+v04PuI0DYfZCIDGHUxQ0x8XR0UvH4Q/DY3y
         RbC+zAd0T0bbvd+Zob68IOJ8EtbYI/G+uG6197d3G3pQ/yZ6vIl3PunDQw2uTDUijnig
         dP1XitY9+N0yjMl62q63MkHxMRvMrD1xIt9GPTp1VHDtnJv/qGLYwAUUUOL4GQCky2l4
         LdlSF3lf1Q8CL07lzJRZaKnvyy20iLPjVhLTWBMPwZZ3qKBWDDJFI0De+OskCnTwVr8/
         9h0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMd2gIR6D2+bWjM6a/oBAxnXRGH8WW9Q32GRixpAJcStc5oicfJdcFAMOM6QW/bM9da/ghWX6v7AaRNHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJI/2TKwQ+hEMv85WWA+l5oSs2bN8V3XKg9vd8RGjelfGc7Nz
	RWA8cfOwv9+9SutiSo7vb20zyfsUgtfKKTOAimDTd32zyUCxYrYzI9n1VFBGb28=
X-Google-Smtp-Source: AGHT+IHlGG8lUNXquAJHd6tZISj+TQ2YsszM2ZdBtl/KjJ9veSTZvzSOCuVd6OHtGTOCf+LGCgfwiw==
X-Received: by 2002:a05:651c:50b:b0:2f7:6129:5804 with SMTP id 38308e7fff4ca-2f761295a15mr75354701fa.15.1726051434260;
        Wed, 11 Sep 2024 03:43:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c07c5bcsm15188951fa.96.2024.09.11.03.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:43:53 -0700 (PDT)
Date: Wed, 11 Sep 2024 13:43:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@quicinc.com, quic_psodagud@quicinc.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4] dt-bindings: watchdog: qcom-wdt: document support on
 SA8255p
Message-ID: <j4yhwags7refg2qxc2ykkykxjv5sue3yghucsiykoyuvzmk4zj@zvh3fd6avmgi>
References: <20240910165926.2408630-1-quic_nkela@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910165926.2408630-1-quic_nkela@quicinc.com>

On Tue, Sep 10, 2024 at 09:59:26AM GMT, Nikunj Kela wrote:
> Add a compatible for the SA8255p platform's KPSS watchdog.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
> 
> Changes in v4:
>         - Added Reviewed-by tag

If this is the only change, there is no need to post it as a new
iteration.

> 
> Changes in v3:
>         - Removed the patch from original series[1]
> 
> Changes in v2:
>         - Added Reviewed-by tag
> 
> [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 47587971fb0b..932393f8c649 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -26,6 +26,7 @@ properties:
>                - qcom,apss-wdt-msm8994
>                - qcom,apss-wdt-qcm2290
>                - qcom,apss-wdt-qcs404
> +              - qcom,apss-wdt-sa8255p
>                - qcom,apss-wdt-sa8775p
>                - qcom,apss-wdt-sc7180
>                - qcom,apss-wdt-sc7280
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

