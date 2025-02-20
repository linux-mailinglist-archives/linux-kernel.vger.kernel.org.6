Return-Path: <linux-kernel+bounces-524003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D7A3DDD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCE2189F91E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F431FC0E4;
	Thu, 20 Feb 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bY4xgWWN"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509DB1FA851
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064081; cv=none; b=bawBx1I/axQ3zEtFldrmh2FvqnOsCOaK/ApYnu7DUsVV6x6ukJANx5czMgcRip8dEnQ9ZE+TKH+TezOL+Lc69tR8BYx+bpKWMSlIa37qPb0YqXYob9PRDj+dyBw48B2pi+h3pGSbnqJE94cDLPbUBdLRYXUcgUIqlA+VhdBP8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064081; c=relaxed/simple;
	bh=DskybEvK/iMXKPAa/BMagEJdXgaU1LnkK2tQcrWpJyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4vD+YlvkmRxa++2CXfjC03wFpgc4nE6ULPFGpkNVBuNpM2waMn4MAjmzoTrRSn6lsyPw9w2sUZhbwSBGwF9TaPT3ppWfQeFgfL3BFPwZywwEGtspY2fB11pSPCv9DdRAg2NLFMwvbHGGItxI6zpi7NF2Px/fX0ZKLPMsUOGN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bY4xgWWN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5452ca02bdbso1009987e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740064076; x=1740668876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cEJSeCFqx2jIiUOzyT1xW8iWa5v32DCCHFMZB/CCGbQ=;
        b=bY4xgWWNr//Up4tIfv8XRSz7cnXLIedd8FZPSy3EUSxfCWNb+j3N3McmfJXGpOqlRw
         1J4FqJ1IpcAYKEFbIct8UYcmQerIlyjrRh1IY50eEgRehJq6Z1TY2byQduNv5XqBLfQo
         86IC+6nn7qb0KIjbjwTlcCn1l29ePc3p79LYUrFOxnR39kDtAr26EYwsEgSgKFRZe3cv
         oLOFghU5ly/RefaGDtom76Rhx25HrfHcgTd8kFniu0gBlyQUjVBAt1YeTzk+XRynq+8+
         8jzZfG4SYCCOmp3qBV4JblUruAb0R112Gua9AF0DzH8KnAAgdiXjGTnNk2BDrdB1VVOB
         lNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064076; x=1740668876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEJSeCFqx2jIiUOzyT1xW8iWa5v32DCCHFMZB/CCGbQ=;
        b=MqOnVgfHWEEHklpgBIw1QqmDtGHR1mSZRfAV0vajS8SWlPYtsVyZTcuYoG4o/Rb8e7
         hwmb7C9+/rKkAo+pru7Td3xrqcWtXQ7KeLDtxapETJzxf6YKJXPFe986ZNW2Q+k91Qqb
         0HSMzYYPnY/RPjHQX+dljmEVx6bKa2fJLue8a8nCYkuG1tvBCwXk/umgI5vy25enBoY8
         c7QgGUvqcZ2YSjbFufTwSf3zY5P+tkkVU93nQ7ZhuChwzPI6+hlHyUy1YEGOfoNJcxhX
         ggl1sbGuTMT8Wf3qR5OxsYe9ya9sQMbbej9q8/XQAqrohUm+0qB/yV5ndpFZ8koLibOI
         J0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCX8YzunZzp4b0BW0t5n/K4KBXKHJoYEiihMkenaCs7cUjnxCL2k75nmODKFhGGIhK9zQ7seTscgaATnzxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfC61iIBoaHczTVH25SXIAFryCCwC03sv0imiIU9qYTJSw2lHx
	aOgPIMdOJ3Lz2F4Xjv0oSFwtUYolaw6yuOMlO7W00T6vDbBlLqaEclO3m0HSTp4=
X-Gm-Gg: ASbGnctePIiY2PIOBLH7LnG6TLOd1u47xS1Wg6lHrorK8Qmi/xPalqAz2xWvT49eeJm
	9/jLpRXa29aX8fYzwcYqKWDY/IWbrAWcoqnfsSkj3cYzvHJwJDEdShVmO0LR9VE4QRxY+jj7Lin
	e9l5PaRO9A5jtiQh6iO4UiPRC3ceDWZC0nhtCRSGdF47qqHFgU+y54p6kcQA7rbO+fuV3ACmfcc
	SgAw+z4KgbmUsK0zOdSt0A6udBOrjeiHsxfgGzwlisK26YCDLIFuoZZSG7kBJ3ycBcNRvbiY+Yp
	BDIdCUMkVcN2u6gkoXIUzuptH8KoI2FY3VQQuHlZFsJ8bAn1o2Rj2E1QPtKU7YDyF2uxg8k=
X-Google-Smtp-Source: AGHT+IHJX5t7ip2QzH5cblh1WHfilz6lVgI355L9ZI6OwFdPInUsiQ0UXYlmnzSJSJ6tJWRrMS2Y1w==
X-Received: by 2002:a05:6512:2214:b0:545:2474:2c98 with SMTP id 2adb3069b0e04-5452fe5be3emr8203069e87.23.1740064076194;
        Thu, 20 Feb 2025 07:07:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452771c15esm2158841e87.190.2025.02.20.07.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:07:54 -0800 (PST)
Date: Thu, 20 Feb 2025 17:07:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm: bridge: Add support for Solomon SSD2825
 RGB/DSI bridge
Message-ID: <eard52ujlocxwshi6ynoimmvfyktpx6f5gcwfn2chaxul2l7my@e24kauxjsw2a>
References: <20250217140910.108175-1-clamor95@gmail.com>
 <20250217140910.108175-3-clamor95@gmail.com>
 <zmwn3dnnmwhms2qxqwb6ksshx27fcq2i4wujz5utuldaiqs6oz@idvy3dirrmuo>
 <CAPVz0n3bqLhuC0gxXD-=L0ETMmhOv1Ku0PrWUb_Yn09v3UNuOA@mail.gmail.com>
 <hemnpzzz3ddibdbqwkazwuoalmvuc2mekebqxfrnxiod6futni@sgdjgtrbcwza>
 <CAPVz0n24o5yar-0oO5dPb3vLzuK=Ln8+JKuaooSRwPfiaLQ9vA@mail.gmail.com>
 <jo7nnxrzwi43qqii7wtekdbc6vluakkvg4ndw266ajgkpe3y52@whd5nly34nju>
 <CAPVz0n3HsXJeyRJGP=_UMhs7d4OA-P_yXx5B9EQDU7vQCz8qoA@mail.gmail.com>
 <3lms6xzzu3hfhkncikcmvl6btzdcc2cwoh4kwhw53hdakecrij@yqoyl3bqmm5m>
 <CAPVz0n3YZass3Bns1m0XrFxtAC0DKbEPiW6vXimQx97G243sXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n3YZass3Bns1m0XrFxtAC0DKbEPiW6vXimQx97G243sXw@mail.gmail.com>

On Thu, Feb 20, 2025 at 02:26:22PM +0200, Svyatoslav Ryhel wrote:
> т, 20 лют. 2025 р. о 13:35 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> пише:
> >
> > On Thu, Feb 20, 2025 at 09:37:18AM +0200, Svyatoslav Ryhel wrote:
> > > ср, 19 лют. 2025 р. о 15:34 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> пише:
> > > >
> > > > On Tue, Feb 18, 2025 at 04:36:17PM +0200, Svyatoslav Ryhel wrote:
> > > > > вт, 18 лют. 2025 р. о 16:20 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> пише:
> > > > > >
> > > > > > On Tue, Feb 18, 2025 at 02:45:19PM +0200, Svyatoslav Ryhel wrote:
> > > > > > > вт, 18 лют. 2025 р. о 14:31 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> пише:
> > > > > > > >
> > > > > > > > On Mon, Feb 17, 2025 at 04:09:10PM +0200, Svyatoslav Ryhel wrote:
> > > > > > > > > SSD2825 is a cost-effective MIPI Bridge Chip solution targeting mainly
> > > > > > > > > smartphones. It can convert 24bit RGB interface into 4-lane MIPI-DSI
> > > > > > > > > interface to drive display modules of up to 800 x 1366, while supporting
> > > > > > > > > AMOLED, a-si LCD or LTPS panel technologies for smartphone applications.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/gpu/drm/bridge/Kconfig   |  14 +
> > > > > > > > >  drivers/gpu/drm/bridge/Makefile  |   1 +
> > > > > > > > >  drivers/gpu/drm/bridge/ssd2825.c | 824 +++++++++++++++++++++++++++++++
> > > > > > > > >  3 files changed, 839 insertions(+)
> > > > > > > > >  create mode 100644 drivers/gpu/drm/bridge/ssd2825.c
> > > > > > > > >
> ...
> > > > > > > >
> > > > > > > > From v1:
> > > > > > > >
> > > > > > > > Most of these flags should be set depending on the
> > > > > > > > mipi_dsi_device.mode_flags.
> > > > > > > >
> > > > > > > > > +             ssd2825_write_reg(priv, SSD2825_PLL_CTRL_REG, 0x0001);
> > > > > > > > > +             ssd2825_write_reg(priv, SSD2825_VC_CTRL_REG, 0x0000);
> > > > > > > >
> > > > > > > > Why? Why do you need this special handling for the
> > > > > > > > MIPI_DCS_SET_DISPLAY_ON? Why can't it just go to .atomic_enable()?
> > > > > > > >
> > > > > > >
> > > > > > > This has to be called after panel init dsi sequence completes, is
> > > > > > > atomic_enable called after panel init dsi seq is completed? Maybe you
> > > > > > > can suggest where to place it.
> > > > > >
> > > > > > That depends on a panel. Significant number of panel drivers call all
> > > > > > DSI programming in .prepare because some DSI hosts can not transfer
> > > > > > commands after starting DSI video stream.
> > > > > >
> > > > > > So these commands should go to your .enable().
> > > > > >
> > > > >
> > > > > This is weird and counter intuitive to send dsi commands in prepare,
> > > > > there should be smth like enable_post. Oh well, fine, I will try to
> > > > > fit this somehow.
> > > > >
> > >
> > > Who had made this cursed framework?
> > >
> > > Functions are called in the next seq
> > >
> > > panel_prepare > bridge_pre_enable > bridge_enable > panel_enable
> >
> > Use drm_bridge.pre_enable_prev_first or drm_panel.prepare_prev_first. I
> > think that fixes your order issues.
> >
> 
> This seems to have no effect. I have set panel.prepare_prev_first =
> true in the panel probe, which should result in
> bridge_atomic_pre_enable be called before panel prepare,
> and yet I still have this:

I've cc'ed you on the patch that should fix this behaviour.

> 
> [   45.280653] renesas_r61307_prepare start
> [   45.300873] renesas_r61307_prepare end
> [   45.301070] ssd2825_bridge_atomic_pre_enable start
> [   45.317248] ssd2825_bridge_atomic_pre_enable end
> [   45.317287] ssd2825_bridge_atomic_enable start
> [   45.331650] ssd2825_bridge_atomic_enable end
> [   45.331677] renesas_r61307_enable start
> [   45.520959] renesas_r61307_enable end
> 
> With or without the flag it is same
> 
> > > There is no gap in between bridge_pre_enable and bridge enable, hence
> > > I cannot call dsi commands in panel_prepare since bridge is not even
> > > pre_enabled, and if I call then in panel_enable, I cannot complete
> > > bridge configuration since bridge enable is called before. like WTF!
> > >
> > > I enclose log with function call seq
> > >
> > > DSI commands in panel prepare
> > > [   75.149700] ssd2825_dsi_host_transfer start  << this is panel prepare
> > > [   75.149737] ssd2825 spi0.2: Bridge is not enabled
> > > [   75.149750] panel-renesas-r61307 spi0.2.1: Failed to exit sleep mode: -19
> > > [   75.149779] ssd2825_bridge_atomic_pre_enable start
> > > [   75.178518] ssd2825_bridge_atomic_pre_enable end
> > > [   75.178552] ssd2825_bridge_atomic_enable start
> > > [   75.179026] ssd2825_bridge_atomic_enable end
> > >
> > > DSI commands in panel enable
> > >
> > > [  102.821580] ssd2825_bridge_atomic_pre_enable start
> > > [  102.852000] ssd2825_bridge_atomic_pre_enable end
> > > [  102.852057] ssd2825_bridge_atomic_enable start
> > > [  102.852840] ssd2825_bridge_atomic_enable end
> > > [  102.852866] ssd2825_dsi_host_transfer start  << panel enable
> > > [  102.853876] ssd2825_dsi_host_transfer end
> > > [  102.948420] ssd2825_dsi_host_transfer start
> > > [  102.949289] ssd2825_dsi_host_transfer end
> > > [  102.978389] ssd2825_dsi_host_transfer start
> > > [  102.979567] ssd2825_dsi_host_transfer end
> > > [  102.980117] ssd2825_dsi_host_transfer start
> > > [  102.981248] ssd2825_dsi_host_transfer end
> > > [  102.981809] ssd2825_dsi_host_transfer start
> > > [  102.982851] ssd2825_dsi_host_transfer end
> > > [  102.983537] ssd2825_dsi_host_transfer start
> > > [  102.984556] ssd2825_dsi_host_transfer end
> > > [  102.986743] ssd2825_dsi_host_transfer start
> > > [  102.988078] ssd2825_dsi_host_transfer end
> > > [  102.989445] ssd2825_dsi_host_transfer start
> > > [  102.990411] ssd2825_dsi_host_transfer end
> > > [  102.990912] ssd2825_dsi_host_transfer start
> > > [  102.992274] ssd2825_dsi_host_transfer end
> > >
> > > In both cases there is no gap in between bridge pre_enable and enable
> > >
> > > > > > But what is the case for these calls? Are you manually implementing the
> > > > > > MIPI_DSI_MODE_LPM flag? What exactly do they do? What happens if the
> > > > > > panel driver asks for the MIPI_DCS_SET_DISPLAY_ON command after you've
> > > > > > programmed those registers? What happens if the panel asks for the
> > > > > > backlight control?
> > > > > >
> > > > >
> > > > > Backlight is externally controlled, at least on my device, so I cannot
> > > > > test other cases. If I configure those registers before dsi sequence
> > > > > is completed panel stays black. If I simply remove those
> > > > > configuration, panel stays black.
> > > > >

-- 
With best wishes
Dmitry

