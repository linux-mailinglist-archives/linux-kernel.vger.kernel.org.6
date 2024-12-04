Return-Path: <linux-kernel+bounces-432260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77019E4884
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCB216317B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F6D1F03FF;
	Wed,  4 Dec 2024 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FotN6tnC"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002919DFB4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354267; cv=none; b=FAYyp2QLOZBZYgRBkabcp+3AE5tSPEGZ0VSF6Dvs+ELUh+h/F1BHTj6ywyHB486YOQQ4zd6GGk5TFvmL2Zg0IWtP/HR9kb7gWGjaeWyRMer71rMk/7xSBAYCff1k29qgXNHgiMeyhIQc8sZAbLKtqlu82Kq1kQ5vwteHPEZwJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354267; c=relaxed/simple;
	bh=6gz/5JCvku0V5yr9ixVyR9+FNlFCkvwcxxf4D0X90ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7vxSoN8JNz0d1nhcuJeaGbGFOREJyDY6OQAsp4/nsED/TwR34O3ZGFUsOl3jVZ+28zmXQzbJHD2bTQJ8Rpvuu3Nl7FeWXlBRkwHoq6QQjfrXB7Kyfv3Qh7Ny9F/Q2aaotdJub0DTTIb/qVLvihpZCPgFPHI9ryCNJOkbp+u8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FotN6tnC; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df7f6a133so263980e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 15:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733354264; x=1733959064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+qyWMAaxSXjS/GuoQtdsJ9zo8e90abOj5J8SrRL65M=;
        b=FotN6tnCZCSpJq3dIQKpLY6hsyU/QkOWsmUZWT6AoSl4H7VVj83y4bykbZH+QYhZ/D
         CgngLSiN2uxozRcewUkdHitjzNLLcozG+AKLiN62HiJwNE829/Zv/LlIp27hHt+QGU/D
         oTJS5Ff2IdwgvZIAuj1t3XPPXmWizukxB57tFLqu0xp55cTJgJ4h0NljgXALyriNlU6X
         dq2LFmoNOG+jRo4J5KzDRbnn5RoM7SkY/WwbItpSxg/NSPleJMpXJ1phiqs7TjXQq+Uf
         ANIFAP/FnLt0HyMNQ4Pg14q/chrOSXdS9hi8vEjzK6fDWOcjKBoMnEev4EhydtpxGFK5
         HaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733354264; x=1733959064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+qyWMAaxSXjS/GuoQtdsJ9zo8e90abOj5J8SrRL65M=;
        b=OLynF6sYs9JEVUO/xtRBvM4aKaJ7y83tA8bKJUPw6xrjpQMi7dCz30PZU2RhJkF5pB
         QgogcL4Uuponlmy3xZLvX83C8IUJjdljBABv9moH/XKIvMpoLrdU/vkLDnmrrHYKajxF
         DMkIZiyQhUsSAutLzbm2jwHCaAL6qGIcMyVopqXE4fcAFwN1BQ/2ubsx5ZTzUWwwx/Cz
         mQeZi1rwdE/74kzOEbmtIK+qpnzBq8xAjo9p+1a0N7csXdb+es+/n15MeyIHrfEnW9ao
         N7KNfnFluMpr4pcLsNMQNzMiFFm9YLriksFLO37kE7hOfTWbJuXEqkyxxJh8zBrDNUed
         lv1g==
X-Forwarded-Encrypted: i=1; AJvYcCUCKJpN3kKrMh9e2HoZWaoI16m7T78hI3uGn0EAntOChBX5g4ifG8H2VqdkHX8AanaGi9DFy/3haUZIdf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfs0IDpvwzo3w+MvtrKTXOq1XJJtTz2YPSl2LN19N5iT04TOs7
	0E2nqDNRXPGct/MXwGrHWhXANxrrJi18VorHyvkJMGPRqg6L4u/w1+TaUIJsrAo=
X-Gm-Gg: ASbGncuZ2IiX1gteOAbsKz8A8RkkROPnqQ6LdhE8jYbQHgFMI4gIM47qn3tIjDasZh6
	eHKO6V5+eNhe/2qWhGE126WXElNo8ZN2dHuhpMSBLGW5sI3n3ilrpoM6Nk9hidDW65WLXpVCyta
	HZXMkwc3pExH8895vdk9rgzpoUvdQh4uj2ENJNzcn48r9/KwnMwXnGDPQLf0ILB7rbs3aL4tNQR
	Vtlw1ajE9Jdmb0nHBSRI5LAilA/tEz8JJ9YnRx/EodLxXOz/p9pkk8ytqdzqxD7OBw3pwXEYaQj
	iljL7JMMZTS3dHYPeaHyT+8thKIrKA==
X-Google-Smtp-Source: AGHT+IG2aNoUrJvkerXSq3eWJ+qwjRlvZ17m+biwTB/m1eLy8NPmwfbxly/t8CsrnbMCJEk1wfQi/Q==
X-Received: by 2002:a05:6512:3f16:b0:53d:dd09:124a with SMTP id 2adb3069b0e04-53e129ed245mr3412222e87.8.1733354263629;
        Wed, 04 Dec 2024 15:17:43 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ca4c2sm31823e87.269.2024.12.04.15.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 15:17:42 -0800 (PST)
Date: Thu, 5 Dec 2024 01:17:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Phong LE <ple@baylibre.com>, 
	Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 7/9] drm/bridge_connector: hook
 drm_atomic_helper_connector_hdmi_update_edid()
Message-ID: <3oz2k3ywwdkxhi4t4setfqjl54yzxg3nxe7upxwl4syyyygf42@3ynkabu2bmvs>
References: <20241201-drm-bridge-hdmi-connector-v5-0-b5316e82f61a@linaro.org>
 <20241201-drm-bridge-hdmi-connector-v5-7-b5316e82f61a@linaro.org>
 <87a5dc4zd5.fsf@intel.com>
 <txzri7x4pdeakx4juandk3hfhsbx3dhlulxfuehqlmrr7b3wpw@jaunqktsro6x>
 <87v7vz3ne4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7vz3ne4.fsf@intel.com>

On Wed, Dec 04, 2024 at 09:42:11AM +0200, Jani Nikula wrote:
> On Wed, 04 Dec 2024, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > On Tue, Dec 03, 2024 at 04:25:58PM +0200, Jani Nikula wrote:
> >> On Sun, 01 Dec 2024, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> >> > +	drm_edid = drm_bridge_edid_read(bridge, connector);
> >> > +	if (!drm_edid_valid(drm_edid)) {
> >> 
> >> What's the case this check is for?
> >> 
> >> My preference would be that bridge->funcs->edid_read() uses
> >> drm_edid_read*() family of functions that do the checks and return the
> >> EDID.
> >> 
> >> There are some cases that just allocate a blob and return it. Would be
> >> nice if they could be converted, but in the mean time could use
> >> drm_edid_valid() right there. Additional validity checks are redundant.
> >
> > This was c&p from drm_bridge_connector_get_modes_edid(). If you think
> > that the check is redundant, could you please send a patch dropping the
> > check?
> 
> Mmmh. It's just scary to *remove* them, and that's the reason I didn't
> want you to add one in the first place! :)

Ack

-- 
With best wishes
Dmitry

