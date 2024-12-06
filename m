Return-Path: <linux-kernel+bounces-434647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8D19E6957
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AAB283594
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F090C1DF748;
	Fri,  6 Dec 2024 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxEA9n2F"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984F1B532F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475140; cv=none; b=FaRtprLBE8DCZpeN2l2AmtkImLU5h7ouv01EELG5ju5jdAm4B4KXsw4Z1W/XU9FmdSlSPA/xqOkhRD4bHLGJAX4X3Ddk+8K0fP2PPvnGDQT6et9AdvgtG5FaDAbzOA6cAWwkSYbaSUHqxUNNtG0glx2jnw+JB63q1OQplvnWg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475140; c=relaxed/simple;
	bh=vOEb4E4aKxygcaLscuw12g6Ou/Ts3AX4lPHWDBDyG5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVlW8mS7o8FgIBGMSt9spV76oBFislR5QKE6s5nkqxtHP5wrhmbNmoE80WecONDWYT9XJwfcbZX66VcAtXSvsUE3kGhghdptFEx7D/WYj7rSESup0PJrzqakA4Doh5nglYjOrkbPh/mY6sAOEqOnuO8EYz9fvIM6P7eGvhTOq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxEA9n2F; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e152731d0so2570584e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733475136; x=1734079936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWvF0H0EGmUGSVxOV1MB8umQ2kXN27sOruVW1MZF7lM=;
        b=NxEA9n2FMYH1coNkzrdLtfHNHrEdaeBr/SyEjUtDjmSWtSFQdfWaPVArdH+50OlCau
         0n6yh7ueJtRYdOjJ+wPs1LRakKu0CIWwZnJN8hi7o4yeiYdhsi83rD1B2UlnuEzGl+g/
         XvrIcxnlRIOh2M7ahSNXyKeQRATXEYMpccvbhwchVMkW7WsMl3onlS5Ut9UFNnDCTUpy
         CNJVAe99LFlAsduuT43bIJjeKuZEwLilNAs5XlgoGA3Ngo2ZJYqv1NWsOJ2RAWy91Q8Q
         nckFM5BfyuyE6xprv68sdy39TUug5iBJh1WMIk13xJGJhva5+JkZpZ4uRWQUYzva0tlg
         YZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475136; x=1734079936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWvF0H0EGmUGSVxOV1MB8umQ2kXN27sOruVW1MZF7lM=;
        b=Ghxp/P26t3fgcQvQ+KBjaRjOoxUA+ccqrxSRmHxE7wTKeCnNtMv29LXQxy5X1rbSBq
         7yiYiVPCm/DJH5QBQYM3kQnPH4mgmPWpV+N6VrLYBZAzqKud/EyOJsldjiMOOW12Pzh/
         tm6x77mlcuVaEZChqJaYS+SCnLpBAJ1N1zwZLhLm7zTUc8ePyYrQbEW5z0OovXjsiAW3
         xYs7RGmDnqMFTiYx5oh+T3bJk1AEX3tv77Ul9gVWs/7Yo/2aTfpQ0KVIPtl+VU5Jkior
         SDUJSVO5h4MwdBKGJSW9UzQoyMakse8ORKJr2Z0dLcgW/wzTItshpzn20B6v31b9wTNB
         oD0w==
X-Forwarded-Encrypted: i=1; AJvYcCXBLWBh94I9qlSPxkMD+P+MVPqv3vEhdYAOJa0xHJNurnhU2SsAxC2VMAh3v8x5rOlb/DWbHtF0aliQ+xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BmnPC5QjTGHgEl8rew4a5YQiQV/ilHoxVSXhewT8gfP3KwUv
	zgyDxmSKI3wKXdjZ1A5fCqlPoDbjIf+PL1qOieuG6ZRsev/X75VJb8vJL64MSQM=
X-Gm-Gg: ASbGnctbtdm+YUMn0hFMiWD7hHk55fToDzGmKaqeuVhSqOhDFRVT3yoq/m54IavcooS
	jGOyUXT7hoi6aJAGV7dDC1GoyI01Gxt4+4v40ZS2dMnQLfMwl/jkRPhH8kJjYtGOizoAqX+gj71
	dQgGG9bvwpny90IhZsX5qEW9F8g1ctEJmKBDENqIXiJN5n0NCVBw/rgk+ngNpGQmoFUYZi4p8tk
	A+wtD8XVvoVyYEsdSHZL38m7vKFsXnP7BUt7GOzpceZJFbD3+5BdSpSWqbIDK7f4lkXbowLo8eb
	QpGDoh+f29PkN7AsAttqNZ57AaZYbw==
X-Google-Smtp-Source: AGHT+IF6Vdn52CT8JySCn5wU2COywbsd5j5s7R3p4rxRLjto9tXn/oJVzfxtra1uUQQ11wKfZqg7fw==
X-Received: by 2002:a05:6512:3d0c:b0:53e:2246:c262 with SMTP id 2adb3069b0e04-53e2246c7d1mr2115452e87.0.1733475135953;
        Fri, 06 Dec 2024 00:52:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229479e6sm444272e87.28.2024.12.06.00.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:52:14 -0800 (PST)
Date: Fri, 6 Dec 2024 10:52:12 +0200
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
Subject: Re: [PATCH 05/45] drm/msm/dp: add a helper to read mst caps for
 dp_panel
Message-ID: <aksnudxy2oyojjzwm73i4mulftcxccdsnddcdamypmscn6skpq@ijtp7x76m3pt>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-5-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-5-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:36PM -0800, Abhinav Kumar wrote:
> Add a helper to check whether a dp_panel is mst capable.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.h   |  1 +
>  drivers/gpu/drm/msm/dp/dp_panel.c | 14 ++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_panel.h |  1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h b/drivers/gpu/drm/msm/dp/dp_aux.h
> index 39c5b4c8596ab28d822493a6b4d479f5f786cdee..cb97a73cdd6ea74b612053bec578247a42214f23 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.h
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.h
> @@ -8,6 +8,7 @@
>  
>  #include "dp_catalog.h"
>  #include <drm/display/drm_dp_helper.h>
> +#include <drm/display/drm_dp_mst_helper.h>
>  
>  int msm_dp_aux_register(struct drm_dp_aux *msm_dp_aux);
>  void msm_dp_aux_unregister(struct drm_dp_aux *msm_dp_aux);
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index d277e9b2cbc03688976b6aa481ee724b186bab51..172de804dec445cb08ad8e3f058407f483cd6684 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -108,6 +108,20 @@ static u32 msm_dp_panel_get_supported_bpp(struct msm_dp_panel *msm_dp_panel,
>  	return min_supported_bpp;
>  }
>  
> +bool msm_dp_panel_read_mst_cap(struct msm_dp_panel *msm_dp_panel)
> +{
> +	struct msm_dp_panel_private *panel;
> +
> +	if (!msm_dp_panel) {
> +		DRM_ERROR("invalid input\n");
> +		return 0;
> +	}
> +
> +	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
> +
> +	return drm_dp_read_mst_cap(panel->aux, msm_dp_panel->dpcd);

So, it's a one-line wrapper. Do we actually need it?

> +}
> +
>  int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
>  				struct drm_connector *connector)
>  {
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
> index 7a38655c443af597c84fb78c6702b2a3ef9822ed..363b416e4cbe290f9c0e6171d6c0c5170f9fea62 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
> @@ -67,6 +67,7 @@ int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,
>  		struct drm_connector *connector);
>  void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel);
>  void msm_dp_panel_tpg_config(struct msm_dp_panel *msm_dp_panel, bool enable);
> +bool msm_dp_panel_read_mst_cap(struct msm_dp_panel *dp_panel);
>  
>  /**
>   * is_link_rate_valid() - validates the link rate
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

