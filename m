Return-Path: <linux-kernel+bounces-183288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5616E8C973B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22462811A3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BACD6EB7E;
	Sun, 19 May 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uf2JQlbZ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E424C80
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716157547; cv=none; b=X/HvSHV7UkPPLEK1cCXCaechw2TqsSQf1uiW7+uzxzH2JBp6ivELlLSzolX9fqG3eC6kV3W5NMRGikUKRA+l7tpskBbXiT3ALh/eawckv6+Ml3Ds40RsnwxmAMQtM1u7o7K+VvtPdgMTBpm2YXOsxKBVuSW+2cu9K3T2MB0jlv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716157547; c=relaxed/simple;
	bh=hFSuRs0LC/TbYzrEDL213VX8qP4mHny/uqx9gunUjWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6R39zEPeoYyVcnxNCDpuzJ2MEucr0VlTGTlecJ9TLUqd0QMCFXpm27cshnr/hEDME3OSbB/cEFZceeT7Y1l50kcX4ulzWI2cJoBvNu8tE3+CJYokebTYzMaL1k04ujuuGIDoWYfzTpFFdjYg6JNEM93Mw8mrzwyJ4n6vq/Rje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uf2JQlbZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f74fa2a82so2741230e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716157544; x=1716762344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYrU+XJ27k761lwCe7kCnnPwdlOuBzaG8t6NtqUWwio=;
        b=Uf2JQlbZmBoBeDAcuJclKBFisqT/G4jHoaaBpd0zL/kYz80GOdolM9qH8hMp/VzcHX
         Ir7D6GwYGprqzYq00g500CuUuRlNPEc+58aWLi0w8P+zOlbngkYXhkFDdbXemUV9GrBt
         rr856sNiTZ6lqE8JGVeNYPhbVTZb6JsBt5cwcw2F6ipj20JuDg2uEOOxkMFyLElhHGwT
         sK7ZuoqgBieRuBl01Y+ZGdpxyHe/4v/4QCtJgjmKD1FoqgrDQXZotdK7LipsHfKO/RqN
         GUevgli4Rx9oePTGR7pKS3yC0mbcIjg+tn5ixNHL1e2BE2jd553hMjHG69yez9Ku5Xm7
         +4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716157544; x=1716762344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYrU+XJ27k761lwCe7kCnnPwdlOuBzaG8t6NtqUWwio=;
        b=giAEgPNIqiS5fEjO3kohElmUcA0iJ5iW8bxNnZuZpfAz3zRChn9qHkAGDDHKN2xN4B
         Bzi6Sg7JY2PVT8n2F8ObUlYyubie679unvFY3vX+WrIZyU5wcjDLqEGIhzS9GOXxQtbG
         /+IEPfcJYHxPw7t13yEEaW+TJabOsX5qecGnDUZU81AIrNVyA/Q3sRKe1lJGockRfsxy
         cw62m7Se210iytWG90bAYnnqqDclaxGs1JKAgMSSCamrO+OYxYv9uoiXZD0JUzp6ohqU
         Rhb9zYRIpi3HxgxdlHV75jJy+2bSM3pT/cW/J1OdeSeWOLfOQ0b474nJFO9E0AZQfALD
         tiaw==
X-Forwarded-Encrypted: i=1; AJvYcCVXe4dwNKdF5LHwqCyw9B5RmT6T9czDPvlFbZjgL47kjIuWflapup5AHGkrmmhGioe4bzVjejiXWN+ag9JHs2Hdbdo34m1RAfEnUGYM
X-Gm-Message-State: AOJu0Yy+n0P4R5ZCOjCZSFNwEvl8A9aoOwgikSvxvKUa+2jEvWnpxfwz
	6itQgqBMhG3CaWBmI4+aRNxY+IIt+vBSL7ik1gEPIkFPjjGNM0jfPCiGB+jekK0=
X-Google-Smtp-Source: AGHT+IGdC3FYdpnOZLHS9Ly6tvajsrdS+bTijHOKS6oAZvUcSjfsM10rZHFWNisj6ZI7WMc1O7UGeA==
X-Received: by 2002:a05:6512:475:b0:51a:d08d:bab4 with SMTP id 2adb3069b0e04-5221016b518mr22160660e87.55.1716157543835;
        Sun, 19 May 2024 15:25:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d338bsm4050078e87.166.2024.05.19.15.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:25:43 -0700 (PDT)
Date: Mon, 20 May 2024 01:25:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <megi@xff.cz>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] drm/panel: himax-hx8394: Handle errors from
 mipi_dsi_dcs_set_display_on() better
Message-ID: <rl75kajstjmm2nvzwx4mwjeeygzgj4p6fshl4zktdjs37bjj5x@cdwg4oghnpua>
References: <20240517213712.3135166-1-dianders@chromium.org>
 <20240517143643.1.I0a6836fffd8d7620f353becb3df2370d2898f803@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517143643.1.I0a6836fffd8d7620f353becb3df2370d2898f803@changeid>

On Fri, May 17, 2024 at 02:36:36PM -0700, Douglas Anderson wrote:
> If mipi_dsi_dcs_set_display_on() returned an error then we'd store
> that in the "ret" variable and jump to error handling. We'd then
> attempt an orderly poweroff. Unfortunately we then blew away the value
> stored in "ret". That means that if the orderly poweroff actually
> worked then we're return 0 (no error) from hx8394_enable() even though
> the panel wasn't enabled.
> 
> Fix this by not blowing away "ret".
> 
> Found by code inspection.
> 
> Fixes: 65dc9360f741 ("drm: panel: Add Himax HX8394 panel controller driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/panel/panel-himax-hx8394.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

