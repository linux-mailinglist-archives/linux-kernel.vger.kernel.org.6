Return-Path: <linux-kernel+bounces-431021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA84F9E383F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794D2161D81
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C24A16F851;
	Wed,  4 Dec 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yoKTlx46"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9731B0F2E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310337; cv=none; b=H9JVIPw/L/gJoATlhb7TnJgGN8nUfN5i6eRfsW1+hoGG/Rv6hPV04l9EoHIb6QKmvKdhjWBy38mm8e4R4gsrGXUf7QjBIahYLlgJus+8s736WqSkJXUDonQBOwMxEz95jYDrHtwh5ue4iaD026ZJblg3a2n1SYK44TLRjwwwzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310337; c=relaxed/simple;
	bh=SAidZjBk+fYmt5AwPP6zN/DjTwTQx3RLqG4jvfGi1A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuNvvZCZJY63XxsfFnKmhfz4ivmH32imsFUkQT1uxvWjRUA+XmnyK/ZynZgdG71+X5m7PIkrtyPy8R0IOHbJafQiAdGGMFzYJ2cNgx+ek7iiAQ8UTndRZzWgrEfrSiaRLuFMRytymIWLeyroNLJTZhDeeR8R2KRTB6TInioSDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yoKTlx46; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df6322ea7so11529262e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733310334; x=1733915134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANxqChj2I4LzNaOLgxVnoZiKM49rhNSRtgRob9N8xcA=;
        b=yoKTlx46HI58pC3x4tYD54F8OmpMSE9hQaU0XwKYn79XCm/vPJVydO04iO0xllpQ3n
         /AM4mifHZYaDXQnf3zD/3v+eiciVNHMJ+vUDeP6nz9ZqmVOPa759TTTvzgAR/jAhbeax
         TU4XSHOP+FQ9RvWYG0nlhHrQHUtW3ACeGdE8YGXjraksh9gGUv7NQgGbKLQNDTtPRpHt
         yaDwEOwoMevLB8tQDeceqn3YZOioRzeoe9QXSHWVwIfaYIy2h659rlo42rob630vSTkq
         rwGxhld1FWhSLdnPXStbmQimfmCoEAm+z3HO7y7pLIy9gAY9ylr3vy/9dK6y3m7MZ43X
         rQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310334; x=1733915134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANxqChj2I4LzNaOLgxVnoZiKM49rhNSRtgRob9N8xcA=;
        b=AxTunnQuh9vuYcN0cPbuIfqsm/jgome4Ptcz/GkeC1/lVNLoi6Nmqyh6jSUbMlDp2V
         YolhP7Sr7x6NwF0pfX5RBc0VboTOuew0sJIZPCB3RoNse133ggPVK8gXbBQNAJadSFvq
         2SI3/4vDOxlA+1knAcSpm1roq61WNtfi5tT/gP5efyeZSyiBBCqjbIHd1oq/+ItGIcLu
         lqTZZFVSfuUlBq8F/p0KoW40gfT2GDLuRCTnK1fIkik2KOy8QkrZHHBivym7h9GZyyTh
         /AYsmE3OdDIlN4elUyx6pOL6y5eZtKYD/3GO1tGiGpX3cfQmgdtwAdhZElAiUxoZuP5D
         3vcg==
X-Forwarded-Encrypted: i=1; AJvYcCUDLt6CTbP4oKJyXPPoJ4+IcLFUUNxR44yQ6Nh8IaKBZLUkL1kIQcoLw8+XEIz68bHeE3Rb27oAqj50KWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6JUPeMgyReq4YWDxRgPc4OvMPoo43eM6KpGvXLtWBLb2p9KMU
	yMWkMIxkmRp4MyF7oR/K6ZhtGO6c7whUCrvc6fO8W7y42NCctx6lRbegoZOFdvw=
X-Gm-Gg: ASbGnctVFzUXPHl7zfH8q4jTyW1CD2tqqXQnRwZXqopRZFKdtaVGT2XAOg9GYhLHYp2
	CrWpC98Mfk3+lUhIXkuqLwI5lhZfTEfCmNCIUEqU5C4jyG5vefpHUxPr6WvSKMc4PZ2ohd9QxPF
	R9xDFQ4UA0BLy4MUgD11Ggnz9jspCYcYCPvgDl7bG3U/IrQ5QDto3N/HMupBnSZ489/1FYc3/3f
	XF83M1srvAvXm8wPp3HTKApdcudoNFwo4bLgysdUd7+OX10kf93IUBY6BeDHyogxHr+GkkVyGfV
	NTjsbmGOWlgrklW27t83I1aj6sBdvw==
X-Google-Smtp-Source: AGHT+IE02OylWuhmLiv9NeZ+y1tMELUVhyM1NPSDRneMYjkQCw9UUjW5chQGb5NxXW58BcIkBAdcuw==
X-Received: by 2002:a05:6512:3ba3:b0:539:8f3c:4586 with SMTP id 2adb3069b0e04-53e12a3930fmr4678078e87.55.1733310334049;
        Wed, 04 Dec 2024 03:05:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0065sm2182327e87.263.2024.12.04.03.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:05:32 -0800 (PST)
Date: Wed, 4 Dec 2024 13:05:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom:
 sdm845-db845c-navigation-mezzanine: fix ov7251 lane properties
Message-ID: <vlvchjynnwvevr2raosrwggwmjd5bdrs5skbsztskmzxjjdg7v@6qkhrjyaxlsz>
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
 <20241204-topic-misc-dt-fixes-v1-2-6d320b6454e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-topic-misc-dt-fixes-v1-2-6d320b6454e6@linaro.org>

On Wed, Dec 04, 2024 at 11:56:54AM +0100, Neil Armstrong wrote:
> Bindings documents data-lanes as a single entry with a separate
> clock-lanes property, but DT uses 2 entries in data-lanes.
> 
> This would suggest clock-lanes is missing, fix the DT using the
> bindings example.
> 
> This fixes:
> sdm845-db845c-navigation-mezzanine.dtso: camera@60: port:endpoint:data-lanes: [0, 1] is too long
> 	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
> index 0a87df806cafc8e726aacc07a772ca478d0ee3df..5a16f4c2b346b314af3d614266e1ca034057e643 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
> @@ -115,7 +115,8 @@ camera@60 {
>  
>  		port {
>  			ov7251_ep: endpoint {
> -				data-lanes = <0 1>;
> +				clock-lanes = <1>;
> +				data-lanes = <0>;

Is it really this way or the other way around, clock = <0>, data = <1>?

>  /*				remote-endpoint = <&csiphy3_ep>; */
>  			};
>  		};
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

