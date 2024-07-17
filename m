Return-Path: <linux-kernel+bounces-255742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEEA93449C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4975328455D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC154437C;
	Wed, 17 Jul 2024 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuxXmvNr"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DA5588E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254293; cv=none; b=ueNe8Kttr0hRdXSa4sqnTazcBogesRhOHb9hmmd0E4Ld2R05EHeBWxSPM72ZgpzDsggXQaryH5LCGaVgQ/tgAXK2ck7vhRe8M5KvYP0fKeRa5HZjgIPMqj8jzmS5nYWFWdISP6z4qWf5OQr6IYv6h8mO1/fqSGYImFskLl1I9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254293; c=relaxed/simple;
	bh=mN46T/B5S0+VZbxv+QTvO7CnblMS2+dX0N0FDtySNaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1rrgk3Ebz6Bbi1PZTswNzCyX2xJbv7aUmRjRmlWXWfNbkHu3B/0aiwl2E49U35yNivW6d/czNbfj0Af3munC25xvFb7KAm6Ks6qhZRar0N1K/HLulmsJOHn7pjtcj3K9l/XCHT7J/3KxllFrnmHhmq8u0KAOo8NvLrK0k5KJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UuxXmvNr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eeb1051360so2532541fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721254289; x=1721859089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YdknVgUnt+O5pCK+EMdo/Gub1e64a/mmcVnpk3pt8s=;
        b=UuxXmvNrvkxiKsqOLkrF01r+DRzTBr7CtcU1mU0l7kplkA3w3KN4VbjhQIbfRHCnjA
         CZti63WNCQodUOUiZ2WMOfyep9LyU6ul1edba/UJwWAf+ueR28r7l5vBa1T5dBWWdzXP
         kHvuqn8SEqUVf7oE4Q/t2xseGnvW3ZznH4IyQJOguSn9z06BUKlrd66DI3OCI6em9Vf/
         Bw3tltn0ArpjhCYd6bWVhvqlsC0W5Dguo7BK0o6OLLTB2ZG1SOUDTKKGvc4oG8XL44Kw
         AdRo3HbUlvcJFJZ9NqcOPRCk2DGzCe+LP5dT4s81oU/e8RD5TWY/LlvhGtdv+WIaKWAr
         tGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721254289; x=1721859089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YdknVgUnt+O5pCK+EMdo/Gub1e64a/mmcVnpk3pt8s=;
        b=YFO8xHjgEk3+X/ijavP3U5MO13LsN2TYznVM1262GVI/ckJkz2eekdPkdCvCuoAEYc
         esGZ3hnS3xb5CuIDhYxaIg1+n9KfWoymAWXrrFqyxemu0s6lfMqiJEHLqHhbDOq8TpM9
         wpkMhq0E+z5wWioiy8+WLciI+4JyiNHhr4Tw2St8dhshwQst8KFSOWDvY9SCybGVTRmr
         JtS2RhyNzEgaEdy3jjyOAnjfuR7gGNpgSbQxydCA7NLtFw5QIs9i6ZScQy4RQMnKnjmT
         l9R0+RmPa9QJa1SpC/ZdLEp0PtrQOvgNiCAm6GGY15A16Le5A3VM5prWk3raX5edKMHp
         R59A==
X-Forwarded-Encrypted: i=1; AJvYcCXz9gOhcJuqymWZyYomgcMjoK2gs5S0y60d353wBXbrbxS0ZmoKJBYY1cvRQfP34OulyEJ3EoGVCifV3nNklEDi7OkRBZdUYLuvZqJB
X-Gm-Message-State: AOJu0YzSite97AkF1tWLkRIyy/SidRziQWd3FnBK3svUGe+u7s+cDcEl
	pF0ErA30Gsy7d+293ZC06sZcSh+0ALcLs7cAfHylTMhl9Be3qBR+elqZQ5i1F44=
X-Google-Smtp-Source: AGHT+IFqxbDhjqt1SFKpp0mp6NjBvSH2RuOSJ/cJ9Xo8lyQSMxmjHBeRbrP7BDO0diRgPwW3eRF5UA==
X-Received: by 2002:a05:651c:235:b0:2ee:8c8d:d9dd with SMTP id 38308e7fff4ca-2ef05d24f2dmr3860471fa.36.1721254288711;
        Wed, 17 Jul 2024 15:11:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef05dbb5ccsm700231fa.121.2024.07.17.15.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:11:28 -0700 (PDT)
Date: Thu, 18 Jul 2024 01:11:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] drm/panel/simple-edp: Add Samsung ATNA45DC02
Message-ID: <d23yw632nypm3erlx2tdxgyyiysmg4wl6en6q5daupc3yeczxe@pqzibea7ya6w>
References: <20240717215847.5310-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717215847.5310-1-robdclark@gmail.com>

On Wed, Jul 17, 2024 at 02:58:46PM GMT, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Just a guess on the panel timings, but they appear to work.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> This adds the panel I have on my lenovo yoga slim 7x laptop.  I couldn't
> find any datasheet so timings is just a guess.  But AFAICT everything
> works fine.

Could you please add EDID to the commit message?

> 
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 38e5178f55ac..411b7218af55 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1966,6 +1966,8 @@ static const struct edp_panel_entry edp_panels[] = {
>  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
>  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
>  
> +	EDP_PANEL_ENTRY('S', 'D', 'C', 0x4189, &delay_100_500_e200, "ATNA45DC02-0"),
> +
>  	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081116HHD028001-51D"),
>  
>  	{ /* sentinal */ }
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

