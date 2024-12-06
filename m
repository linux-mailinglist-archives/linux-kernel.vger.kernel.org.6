Return-Path: <linux-kernel+bounces-434719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F529E6A25
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A73E18854C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18861E102A;
	Fri,  6 Dec 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQ8XAqdA"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B93D6B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477572; cv=none; b=WGdU8kyGlqLuS1DEjSchQTCL16dfZNEvHpa5CY/zwuiEiS8Izs8lXWFPJuAuLlmmYYNbQ/mXkdLsFtL2ZG2NK58fFKKy0rbJGH8aUYSBIDplhxLMt43R49As/ox1GG1vkRNHINjbho47PgJj1Xe83siKVrwp6ZMSw/wQBu5OxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477572; c=relaxed/simple;
	bh=EmKTRyxfg9lnl9kzJeHA2gWiYkvhXSnTs3qA2lMvXCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ilp3KxhYMazW/lgZJiBQ1QbVAzG92Zmba/GPDnDpqMzJ295YRDVMr68JahepIrycg7qvEdX/oF0+/zh/telThSu0SsyGjFZKoXdlLucJTS70bQNi03NTBqAjh3MIiW+FRX3kt0QJuL0EDrweO7qcrqzY3l4ff+8w99sPEBrmnCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iQ8XAqdA; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3002c324e7eso11321501fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733477568; x=1734082368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zadEHboo0cdlPFvzQWo8pskzaBuEAY7TqZ8rPSIgr8o=;
        b=iQ8XAqdAoW4bzWYHQInHogmFX2hvpv4rlT35GSSzLmRmQXS0MNaoAKSXq7VKaigKlm
         1P6+GKXJBIqfj+TuoPKYec1g8lIkUZ/2WBOQQX1Qxz3S03OJvyaTPkecdnAOtrKgqwCb
         oymqD4Vn6PQt5UaTPf/CnNw0BBh+vRkCf9KSr7yDn5O9Qp41ASFdgAZe8leDPqwSO9bD
         bAlrhodeOQTUTkjfTpZrB36c9K4g6p/Uc07456aahuyfEqgi/1x4WscmB+V8rKapTqz6
         VIknAnutci9ZKZlLQotRukyWWyM5nCMLJIp9rbZM5WhXbAWxSAFQgUotUHccMIcwFq7J
         T+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733477568; x=1734082368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zadEHboo0cdlPFvzQWo8pskzaBuEAY7TqZ8rPSIgr8o=;
        b=FMPd4jVdRn0m0QGQST278yJF+hLWdkQgEBtDogs4BhoXiV1bZsErcZ9qx7zHblSO48
         pvC+19IJGlfac5qLCCr9Bi9tsZI1f/2B5cLnShkKPM86N/YL6HnkAbzVTntEiX/n/7Ki
         zWWuVYYwZOx6318nAUi/Zx24SPQRpaXq/HXKOPB9apM59OmF+pTAX3H0XWC///p0jXgP
         awLaiDT/cwbGpyhsNpU1AomWvYqbC5TR/L4x14kwHIbxFvNcE/d1aH6GiaDubTbpA705
         p2QUWSXAsfpQCHOp+ND80IZsXkCKGEUMEp9ju/45okM31okBffVrRXouulDBiKE+dm5b
         3a2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFkl6gjW54psq2Rqqnite9bwWC/ZZGuKCY5ncp1aP2zSutpHxjaIgBESGFCm8cXogXELIXTIEvu8/S4xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPE19KiVcYOEJgd1ulSDR3FYJs761ReyLgsUeWVxcOThLxTdX
	uPY/eKcj6oZ2PI9LOhHC1VNXMQATaAmGxPfCoo5gBflD1V7Vnbht7YuFiqV1MX4=
X-Gm-Gg: ASbGncsr1qPNEVJM/KmL6pKeq7rD5Hz6iysSws4zZo+cCtIPjE7aQuDQtbLAORlR0CL
	VYHOPURwc6U9pRwyBEuQLej/MFXJ2C92ZkXPmnNb8jelxyI57NdpL9M4N9lMCCiGO3sdl59jcTT
	HXvovGxuAKbMZlnM4OEP/8IekhBWk1ENe1yqM98xhhc+x2USJjXa8TdtHUQtKZQsIjh5Cb3O0FW
	UvRyinRdkS/0te4OX8VGV/zucfZ3azh2NhIm6aIZiNKA63iYce2jmiYMMUXWJ3pfMw2jVLITKTw
	6AhEfgGAJtFhnqSeIYIM30ljh5WUFQ==
X-Google-Smtp-Source: AGHT+IFt0oQZraChA0vm7bTmEKxi678+NtImtNYWtNbmFt/Emc59radqf3VL2rny8/rMaB+weccu/w==
X-Received: by 2002:a05:6512:31c9:b0:53d:eec4:2bfa with SMTP id 2adb3069b0e04-53e2c4fed10mr1145884e87.37.1733477567848;
        Fri, 06 Dec 2024 01:32:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba6fdsm449887e87.151.2024.12.06.01.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:32:46 -0800 (PST)
Date: Fri, 6 Dec 2024 11:32:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 29/45] drm/msm/dp: skip reading the EDID for MST cases
Message-ID: <7khoxaafl2eclgqe2jfwgdmruvtoug5fpjdkvcrmpcynddnloa@toooyaio7rzm>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-29-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-29-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:32:00PM -0800, Abhinav Kumar wrote:
> For MST cases, EDID is handled through AUX sideband messaging.
> Skip the EDID read during hotplug handle for MST cases.

But why? Isn't EDID being read at the hotplug time to update
drm_connector's data?

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 033d238e956263c1212fce45aab01316ef341edb..a67bc7c1b83a5a9996435804ff7337f72dae93a0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -420,9 +420,11 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	if (rc)
>  		goto end;
>  
> -	rc = msm_dp_panel_read_edid(dp->panel, connector);
> -	if (rc)
> -		goto end;
> +	if (dp->max_stream <= DEFAULT_STREAM_COUNT || !msm_dp_panel_read_mst_cap(dp->panel)) {
> +		rc = msm_dp_panel_read_edid(dp->panel, connector);
> +		if (rc)
> +			goto end;
> +	}
>  
>  	msm_dp_link_process_request(dp->link);
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

