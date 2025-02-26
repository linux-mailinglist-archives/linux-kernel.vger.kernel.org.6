Return-Path: <linux-kernel+bounces-533138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB125A4560E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB643A55EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC63D2698A1;
	Wed, 26 Feb 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWtKojvT"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B22267B77
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552789; cv=none; b=OXjUmTOFwY8zHhZIcWqyTZKaOrCBNDFykcv2MoCARAvZXO/4b4EYxtfcwWieaXAHpVnKZ6mLdZ/d5iif9e900TvUE1tTUfCpSY9m2hIWhNKso0e9fB6LXdLjFC7pou2yQTSYrNerdtNwbrPppndxqhxXefocz3v4nI/Ollvrl3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552789; c=relaxed/simple;
	bh=+IBkviSOgAjspglYgzwuAJjsdAMsAeXdYpGFqD3iUK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqWvelMb5dHuo/T78dQZja7/LxPCeji4yJuUg0tvWLo9/WrQWgcZNAKMvJ3yQZIcKUVuJMqJc7cYmFsmyavmCYClGmeBnj/8qa6m+SSviaZF5pk2djfFxNwEAdGsRTzrx4eFDecHNgn8JZILO7eMEcFcVeysva3lX/tKr/UD97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aWtKojvT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54529eeb38aso5447790e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740552785; x=1741157585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28luXvOgctHQWawFquRNOLl9O0yELRtq1uClua9ph10=;
        b=aWtKojvT0GRIXY7wweZDVG2R/qizfiY/XiADdXtwLwUFqg1+Ah6pJpLEdFwGXnrU37
         3jh08kJRu8p2kpwJaQXJ4uGAU7TQEjelJvlxSKXBdww3uKBeWSKwA5sR+gQi6iBgJrm6
         Yy0PLDVTuoCxmrzaLKHONPyhgn2O3xlo6Hnnw9zdnxYI5pY9Yvj+oPLzo9E6FQTJei1I
         36CdcgxMblDaatkizHOWpD2BQ2Y4Dm9kOXY59zpWFrdQXvKHzULTVcbUdRPDOS03YicH
         YAwlA8kXivy+nTRRPKjKp0/0uR9g5M1W2bntxiyEerMgmNWKZ4Hf9PMXsS8gP1iPETJF
         ZDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552785; x=1741157585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28luXvOgctHQWawFquRNOLl9O0yELRtq1uClua9ph10=;
        b=lw0Q/28Lz60kcNKgkbmtdObpHg9TPM18IQzUiIlhgya7UlFWUBbInKslAwB7jtcxMz
         D0RJGOYbBK8z2tuI21Je1uMB3gKF8QjRcUl38WgSojiTFn2XFLGvC9C3gyKIMNCuKDNK
         Whnc12ckHdRVRGG70fLOr/7a28qe6DDry/PwxVTyWSR7L+cBlCbMv12BU5Q6YH/R1f64
         3AnbAkczwPOsU80sUc50+62y3ymYVm+l1DAUVIWOIH2y4L1WTBIM2r/VyV4X7ZyAi2wP
         xej73wJjsCADhXBCk+lIqj9kIij6V3Aa0+y7ruYlp4k2h9x4upTpwC6RZIjF3x5vo3fA
         s9kA==
X-Forwarded-Encrypted: i=1; AJvYcCXbdk7+Vpm9urQlhfJWXlT3fqAIC3zLUA+oMeslxSX28aWcHt9d/U7ievhjcEx8dLPaKg5/ib2sRlQ86D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSUfomoKJ7oqobhAa0kVYyMBuZurf4Qgl7a/ch+dNMo8IMKBT
	GhtiaJumlrPAAPbRzxX7MO4Z3XH97Ra79KH+AbykpH10reT52tGOPpMvoigKamI=
X-Gm-Gg: ASbGncv47JzsG32C4kCYjIPe3xQ/u/3x53vjlv5Gp9Yzb99d1nkjImpoIdoGgj8zTbn
	2NNlrNhkgQa/Zo5rjbfiiA8vel//48bJTY1uWrNth/24MvtZH1M2LEiLcUgItuOnlPZ5Yd00+iS
	J/M7uzJkwHUNTbSDf4lDPuT0iHy2p59OyMpOM2X/4UJpjyD1f7mhLRQV+MreSr16+p7iMSg5Wvr
	iRIW7jfdZOslj7UJWpGmC0OTpMCc6Vk5ZFHX5Vhk8MfZvFrFBIIJmhla/hCjHvmsOHAHNYg8msI
	bxFSAM/rvdY2p3UjokN6iY2qkX2f9w+oqPAwtVOowruMAF8m5tVz8UCejnWSr0UiMzdr5osk4J0
	oCIdtgw==
X-Google-Smtp-Source: AGHT+IFCrSAXRtytHW1OItp1zy21zcNGHfM8HjDcDTQMkPiyBILsALZmkwg/zbIgag2vjhpeWv8Dpg==
X-Received: by 2002:a05:6512:3b87:b0:545:1166:21a with SMTP id 2adb3069b0e04-5493c5aea9emr2149557e87.39.1740552785496;
        Tue, 25 Feb 2025 22:53:05 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514fa070sm357764e87.236.2025.02.25.22.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:53:04 -0800 (PST)
Date: Wed, 26 Feb 2025 08:53:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 1/1] drm/bridge: ti-sn65dsi83: Support negative DE
 polarity
Message-ID: <j42iq7ujfbnemcwnbfihasnoirnvcdokvbxiqr23gnj7mq4jc3@tjxs5yjpli5f>
References: <20250225135114.801884-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225135114.801884-1-alexander.stein@ew.tq-group.com>

On Tue, Feb 25, 2025 at 02:51:13PM +0100, Alexander Stein wrote:
> Polarity for DE is stored in bridge state. Use this flag for setting
> the DE polarity in the bridge.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

