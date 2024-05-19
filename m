Return-Path: <linux-kernel+bounces-183293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC358C9746
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8CD1F211CE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD03D71745;
	Sun, 19 May 2024 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSiQ9E8t"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BBC73539
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716157621; cv=none; b=AJMF3nGbOby0ulJVIDHUOREOVcVYkZi8+GlmdRIV1lLEgTi+a54etj0fKPHIgl6unwJjkn3SM00xoqmd9JLfw3eqOifC/h2FqK7zVGX3D024X0qhe0SmIYwbOU1+VAPzekQLHxmi2ZUcwiBEGcGzJ2uGva028y9GYOk29C6KY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716157621; c=relaxed/simple;
	bh=APqm5vZYk5fZwyPGV/Yl0Fqw/GDJhq6xn7cCXcqyaew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDLvZLM8PHZBFGURMZc8sVG/WI6kTqJqSdSmi9DConfSXoFb+d/ePnOR98VIeM5Dhi6lXmNU1teHeOjci8JwHCBszOooVRGC0SI1WMbk8s9gp+E0/XXCnN+9sMjhUBL4SSRmMtuwvUYnhPtn3pbQcp5nfAg3mizOBUAZy6vvSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iSiQ9E8t; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5231efd80f2so4007787e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716157618; x=1716762418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kntjofAjVrPtjfwG/3VjdEX2fgrp/tTQedXHTLXviaU=;
        b=iSiQ9E8tROaB0q2RGCRRv50mu8KR02yPb1c6Updmu8DJFaIeI13sxKqhWexzoejMvQ
         AqCCCOyVBqN1StWwN6sFoVbQwaFrx9SrAOYMSCHFufNlGYlAkeofbP0s2lVHVGY7BQk5
         ZW/Wlx/2Nsk67Fh4dVQqsUX/9z8aAEdzbbP5W7M7NlxEjzMlNZX+zqHtQE4Xml2B/LVc
         Eqn9NEy9L+SEKE0eYtZGjShVFOKtBWxUj7BsbmRQO6wmJERZDgxuNSl0FTswjjTrXAUd
         OvQSsGN1a4oq4iOoDdlkiQr1S2X09NrTDT8HqmXlhEVW64O/1JEPXNNBeqnITn0c59WL
         Fx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716157618; x=1716762418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kntjofAjVrPtjfwG/3VjdEX2fgrp/tTQedXHTLXviaU=;
        b=TYAzJaUZiEDEZk66Fxh0S/UXOHfLXifEdAGcoC1gGrdzxxqRjrOhQuuYg6Lba8saru
         wKenDWrQlBIPHt1pDCt4e+1BXtc4WZTC328qARvpVyCe4h7Jd3wyW9aHwoRxiJiWtxXz
         iPnR/gD+LzDH0ibpdUa+a8Pf5gvRHeb09gvvRemzcNUBylWFh8majqBV7Zh/PbEjo8QL
         /OynLar+OxRGgilU5t+fNrapHoPB9ChzKnoMfvopV3EjYQdbn6/+S+Zvicl6wRbLgaW3
         n0r1PZ5F/cp16FG48SKw3HcDObfqATqGUyKQIWsvq3l/m9BanC5SSvlr3R5pEmCBrzkn
         NOEg==
X-Forwarded-Encrypted: i=1; AJvYcCU2CKaLZdMNXG1whWmF1EzW5gY9adHhXi+Aq4pPF9GD5W2AJNGGxmxeTdlAMcnTdFWEXuuvIdnwsPMwrxng2zLHCWyDxxh2ngl8wdZG
X-Gm-Message-State: AOJu0Yya2NSzG4PZwKJp+w1h6p10MuckqQwkHFl3BVg/g1rlNBaB8wqV
	+bAyIkRbUYAPmMB7055FVTA4+FpU/ChP2pbOpsXjHfUqAbibUe6eUyzkoGrViTA=
X-Google-Smtp-Source: AGHT+IHSVkTQw6fC/AOFOdi2o1xjmtHUhk0iYyMSoh6STTi619bhD/w7bGvnjRDe3wCN8cIvVh7axg==
X-Received: by 2002:a05:6512:3683:b0:524:34ad:ba77 with SMTP id 2adb3069b0e04-52434adbaf2mr1252703e87.12.1716157617932;
        Sun, 19 May 2024 15:26:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52399b5065esm1717187e87.38.2024.05.19.15.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:26:57 -0700 (PDT)
Date: Mon, 20 May 2024 01:26:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] drm/panel: ilitek-ili9882t: If prepare fails,
 disable GPIO before regulators
Message-ID: <6zzgvutlhm6wg6y3rj6fgcbiwl4rxy4wbjsocxezirhtafw24y@kakchlwtlybg>
References: <20240517213712.3135166-1-dianders@chromium.org>
 <20240517143643.4.Ieb0179065847972a0f13e9a8574a80a5f65f3338@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517143643.4.Ieb0179065847972a0f13e9a8574a80a5f65f3338@changeid>

On Fri, May 17, 2024 at 02:36:39PM -0700, Douglas Anderson wrote:
> The enable GPIO should clearly be set low before turning off
> regulators. That matches both the inverse order that things were
> enabled and also the order in unprepare().
> 
> Fixes: e2450d32e5fb ("drm/panel: ili9882t: Break out as separate driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

