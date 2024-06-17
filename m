Return-Path: <linux-kernel+bounces-217265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F0B90AD94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6732B2427B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593C17FAA2;
	Mon, 17 Jun 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ls2FLN+8"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166A194AF1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625847; cv=none; b=LilJnwSVyJ3oxqC1KaZKq+JTJCjHdE0XHnuGCd8AWQVHl1YJo/KlXCP7z7gGFsaQG8U0LveqG0ZGrI0fWfvvI6IPb5KSojyMBNreRhfLfLl/vb4kSdzMqHk+AkyuZQH/rryNpcsWWnV3gPUjCgfCvuy7mK1A98H1iMAoeLjLw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625847; c=relaxed/simple;
	bh=zoxmQYg42Ni3z9Gr3Gd2T2Y2475RYWkhSjdxLIJoAg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYYiq4qZAGemdqaTae6LjtEo6gXfO+T5z+kFVsYpATatx+DdVrAYDDvES6naoraMXCSf/qnJBHQuB3WhnjCDuXb1f7U2db59/0LVmGyVv62AQz6BpYw9ZBkmJjvhBmbD64GmWnD49w/qixVVqC9Md2BgMNLwTLaKF8guTELCHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ls2FLN+8; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso71342591fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718625844; x=1719230644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMO4mdkOR6FkFmYRW6aL9nqj0CKGlqd49FnlIe+Tzw0=;
        b=Ls2FLN+8fMAQ1F5XXAdg/EK9jrGCV/rv7dTQbv+zdLqe1+VRRxQF+gIF/p0iH71rDc
         /EFcFMcr9XhjFg4JLaQ2z7oeFVwMwt3eUltZtMpN0ByMfCyMQw+9lDrSlm4wi5ZNvXl9
         fwyNHNaMVLnhRGFVsOKG5ZrmZWvsKREXSazflh0vbJ4uPx0PUAUM2X0vL6lnbVYANp7B
         BccH8hvxj4vC9//Z2LJkHWaIvRxzbyoeCzFSQ0/IHj5WkjJDpKmZhidnvdS1+wD/SyXT
         3shA5it7/0qIY4g1SAMMPsxf7pc5ggTRDDkcLH8VX+axD7il6KD8qZxnwxLMsLbGCcCL
         yU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718625844; x=1719230644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMO4mdkOR6FkFmYRW6aL9nqj0CKGlqd49FnlIe+Tzw0=;
        b=N5h+Mw8Mfb7pVOUzYGlwUu/6b0f/4eI7RBdviJiuzJVZa5UTkslMXz5ziR38cRUJHl
         IoZOG+7M8Oi/QFzKH1wldHHDFVRUtNaumaEronFlmpg54prcASAhUsi+7R6CY/ZxenFp
         1woQtF21WPjp/R1vlv9TX0M9+h5sGkcGllCoTIpbxe1KjS/JSmn68wUpjyKf6P0PpxvD
         EpwZVibTxMLdPinh7d1ec8KUDxGr2x8IDPYdV70MimZmmkZ++szJAozCoWjiShDphmKC
         nTLLLTA2Io8yWXcQ+zOnF/bEzIADubCZvrxT9Ue3xBAwwTjhaHqVX8mMpSy2m0haIuKZ
         C3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU1+ypRAsHsfdRyO45DIWzJZcp3sETvt/kU9qeYntEYRhuJ4PPT5MiCA24OFbdUEbh7agUA7ogM20bDY0BwONrqmPwz2jqRxT/mrdN
X-Gm-Message-State: AOJu0YzEIYg+bDdYmqR72vZR99frgEVANlLVh5ZmDEd7ysQ3aUkG88ob
	Nag9ULp/q+yZMqiOqXRRjAhGBGzp7LqhK3mFzbw4R34bhiCwXQnUTCV9ZiPD9gg=
X-Google-Smtp-Source: AGHT+IH5qlLLJTAfKvCWX5szD04D6YYgsijtmFj095bqr+1145mMD9t8FPMSGpCiR41/LZmhrHNh0w==
X-Received: by 2002:a05:6512:34d9:b0:52c:993d:b462 with SMTP id 2adb3069b0e04-52ca6e6e25amr6597787e87.29.1718625844211;
        Mon, 17 Jun 2024 05:04:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cae24eae2sm811360e87.231.2024.06.17.05.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 05:04:03 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:04:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	DRI Development List <dri-devel@lists.freedesktop.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Dominik Haller <d.haller@phytec.de>, Sam Ravnborg <sam@ravnborg.org>, 
	Thierry Reding <treding@nvidia.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
	Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v3 06/10] drm/bridge: cdns-dsi: Reset the DCS write FIFO
Message-ID: <aiusds2i3gtfojjffxtbxnay7l37cuubgiysiz23cr452nhqry@o2jpj4tyesvc>
References: <20240617105311.1587489-1-a-bhatia1@ti.com>
 <20240617105311.1587489-7-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617105311.1587489-7-a-bhatia1@ti.com>

On Mon, Jun 17, 2024 at 04:23:07PM GMT, Aradhya Bhatia wrote:
> Allow the DCS Write FIFO in the cdns-dsi controller to reset before any
> DCS packet is transmitted to the DSI sink device.
> 
> The DCS FIFO reset is optional. Not all panels require it. But at
> least one of the DSI based panel that uses Ilitek ILI9881C (DSI to DPI
> bridge) doesn't work with without this reset.

Could you please be more specific, why doesn't it work. Are there any
leftover bytes in the FIFO? Is there any additional delay?

> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index 05d2f4cc50da..87fdd07ca0bc 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -1037,6 +1037,9 @@ static ssize_t cdns_dsi_transfer(struct mipi_dsi_host *host,
>  
>  	cdns_dsi_init_link(dsi);
>  
> +	/* Reset the DCS Write FIFO */
> +	writel(0x00, dsi->regs + DIRECT_CMD_FIFO_RST);
> +
>  	ret = mipi_dsi_create_packet(&packet, msg);
>  	if (ret)
>  		goto out;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

