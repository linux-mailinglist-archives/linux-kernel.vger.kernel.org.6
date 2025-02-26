Return-Path: <linux-kernel+bounces-533049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E59A45528
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E086E3A5577
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CA52676DD;
	Wed, 26 Feb 2025 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="he5iouPD"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2627211711
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549558; cv=none; b=m7A/wujPMzoYHDsHpARV4B3uNTO7+O3TTrdHwEcajaDxcwxZClZreTn4s2KiGuHySPm8hnDD4szJzKFl221bb4VWaD7WCT0H0WQyZjiODITFjIkMRz0te6SC9m+24RCrLceiZtOvJn7gHo4kp3usery/G+ZiCj/B4V+aTj5i5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549558; c=relaxed/simple;
	bh=20uJLoHJH8tsE+6AfrND96SpyUccdeO85E8ywgrZKF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpXdsUztS3y1bA4UTKKV2gjiOyYAWuEaatAzoRdxikZTNMl4PuFb2Aw1GRDIYWQi5A0jwx+EsdwMJkIyhuHYPNngnzdev1/tr3bfkp3bJhW+5NUsvun6QYh62gJfEFnVHxpUTM93EG35FLpIckZYqA3wcSZlyot8aasG13i+zis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=he5iouPD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54622940ef7so7242545e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740549554; x=1741154354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eMzggIt5lpYzzVkzOTc1TnN8z6VsZzZu0ORTornTWUU=;
        b=he5iouPD7D3qYSZ8109SS5Gq3/lc3sUys2g+VezqM+MlY6qIn2ew55Nh2ytLa1Rhn6
         LaS7PaT1vZ/KAJw98Vtm0sakwWw/60NkI+7TnH8qW3Xw+L6UQa+ScwGQkNcHflsyvPUe
         Wa3+TpATZCPikwT+SLubd5odHYMs+kGlj53yq1k1nyJuCBx0H/SvvpaLYk7Nb3hBurHo
         5ovA23D2CmmiPEWP8QpsOAwbe3zfmztYAYaZQqiSqUbu/HwOHtlfh7Z5H5BEM+BWKVR3
         xeWqMuvCqMEGiZQ22VnX4VOXMZBZI2DuEcirRJHNLOU8LdxO0q/m9gbx+TdZsCv8XWCb
         qXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740549554; x=1741154354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMzggIt5lpYzzVkzOTc1TnN8z6VsZzZu0ORTornTWUU=;
        b=hCFSJZQCBKAo1HZIRc0Gc4q4BApO+YQU36TO4VxDM8Ybp+yRBJl+7FHpgdmD+kIDP7
         O+Z7SIZBt3VeipP5nmQgRszpDGibn+TLHsdadqLTjoHDNH4itPSZU82LbvQWHYn3oAlw
         0Q1aQ9RgkmXOzY4VAo4JXvCyqXmgYcrNYWucP6wc+GJeTEdeqsC9HplBP2fywaElTQea
         8C+qW5L/IcE/V7QqW9LQvISNCBtalrvZSXKLybnwhi2UJ0tTYzVwYKoEvWfwol78O0/1
         NQ+jxd4GQDK/slR5gS1+hQU7Daf1+rts9Hp/YRV+S+8cKGmSCgTioXnbxFhPrwgpTunx
         9d4w==
X-Forwarded-Encrypted: i=1; AJvYcCWYdhSEtAAPMQTHU87WLiHn1Eul8xX4VddKWS0INODFh1PBC+QAz6SboVemNovjA4/32DejGeO64/d7soE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWEK6lFwfZVs5nOfd2D6Z4Pqr/pPf0V9ScgLYKF6utOb/gYQI
	i4lmzQEJmDwRrN75W/9FT6M3ddJgqM4KGFv8QRiVbnI+uvQq+c2h6IOuUrJxRfw=
X-Gm-Gg: ASbGncvhtQoJMktKqVwfqh5TJwT8h+Yx5TAKniK9LHej7fj+YEJaRULxVHPQ9LdCvDz
	CVF5YfPzkEf4EsG5yCvRnMnqlAJg6XETTNCXLVLHdh1xFuqvhNZBQkdbXWA1MY3IdhzU3BG0rym
	+aKGpi6JFRLmSjzUITV7usQHrLLMrQtaDP2HJsiq+83gVPwWeK5mBRcXvpyCMQfc88nK0v0vpe6
	TmMBf1K4acv4k4siwif1VkZ5sxHArFeOlFG7x5aEE4P+yoXApnqVMdy13t63Bez0Yt65/dzcfvt
	VgPGua6leCkeXgzUodQCReiovmr9OL3x0WwtTFBgfZxaUjHnCzioObr/WDIH6+mPuKW7oQQhdPh
	Phkgt/w==
X-Google-Smtp-Source: AGHT+IEoS4qwP4ua72xrTF0W1n0ce2ri8eECexu7dt46ZDMlqiICPAa9TU2+args7SmvRiq5CJK7wA==
X-Received: by 2002:a05:6512:3f05:b0:545:646:7519 with SMTP id 2adb3069b0e04-5493c39db7cmr2155507e87.0.1740549553775;
        Tue, 25 Feb 2025 21:59:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f4d50sm346333e87.176.2025.02.25.21.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 21:59:12 -0800 (PST)
Date: Wed, 26 Feb 2025 07:59:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/panel: Add driver for DJN HX83112B LCD panel
Message-ID: <xnbncjxfpc3cideza5cemnhskdpedqpiatmvxj3eu3xgtrv24n@iky5ghkh4grs>
References: <20250225-fp3-display-v2-0-0b1f05915fae@lucaweiss.eu>
 <20250225-fp3-display-v2-3-0b1f05915fae@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-fp3-display-v2-3-0b1f05915fae@lucaweiss.eu>

On Tue, Feb 25, 2025 at 10:14:31PM +0100, Luca Weiss wrote:
> Add support for the 2160x1080 LCD panel from DJN (98-03057-6598B-I)
> bundled with a HX83112B driver IC, as found on the Fairphone 3
> smartphone.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  drivers/gpu/drm/panel/Kconfig                |  10 +
>  drivers/gpu/drm/panel/Makefile               |   1 +
>  drivers/gpu/drm/panel/panel-himax-hx83112b.c | 430 +++++++++++++++++++++++++++
>  3 files changed, 441 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

