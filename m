Return-Path: <linux-kernel+bounces-337155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F89984603
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635781F23ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408361A7049;
	Tue, 24 Sep 2024 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajEaY0a9"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F81E492
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181247; cv=none; b=NmtNyGYzq3zznCS95jmiQJ1dHofVkOxTRqDhCjjyir5hf/Xi72YbNRUtYhzJo5GnNTQe6aIPRd4StdQBiBMAFzmGUc8NpbbAOv+64gKLMThl3P8WQMzsQyiIr0CF1Jr0yI856slIdxSO6UyVlYmo3mj7SYmYLRTkqpmpdB13xM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181247; c=relaxed/simple;
	bh=Kfk1+2al+7doFaql7D6idULqD7H39m1K97xZAScDVdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg3VkDwkb3NL0iDAA9YSejjn1jeVEv1crQs/24+17hFZah7vY+u1u6FruA5szZQfWMeCYeC5DGrWBGbxa5TZ0JCxxKbjdyllxSk3uBYmp6Blh0pWjxmO7PKllqy9ieRE6RZyGs5WynaH+kcgCp01Z0qIh6CLY8lb2j3olRF++Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajEaY0a9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ddceaaa9f4so42930587b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727181245; x=1727786045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=waVu7uh+CPXnVRmgTe91YMGi0QNyeJbMskc9QqEgC7o=;
        b=ajEaY0a9pmoB+ewG+JreXVTUzML1/BiMiZUwwOA4nQ+l9akiJ8DBrus5pGL59vEeaO
         /h8X6E+r6Cj8pRnY9aBfTRJOGje0LvV2/WjrJQ0W5gOEVUmzZJtFn16hjkYajIcLUxHl
         fUncRrhHHYVlrPhoxxzSQfgB0GzwyNpTs6QqkZZj9+xL/pW423b32dYH1QXEc3ae773F
         SRe2hkkMAtO3uIpixD1UIpz7wpjEFFGARE2TiJ6qHD6wLik5U0NkDrJJfdf1K5gAxqRK
         NBPCZIVGnlB+NLIJYcQszCVL9p3fxSPxtverpQujDvdAjp5NvUz1bywJoTG+WEBR3Jdc
         wWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727181245; x=1727786045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waVu7uh+CPXnVRmgTe91YMGi0QNyeJbMskc9QqEgC7o=;
        b=bTRsK7XIbaa2jMGvRPvWoZDrt2hZBTWswA8kGz7MMRsDswlZyh9mFy67ASOeMZc/Lo
         YB//WmSO98WoRbVqIa262SWL5ICsU4U2Py1xhhYKcrM14PW0lsxcvwEI2s3RGmSyWSyh
         PVpfL43kqkmUZbCO3pi84PWgYsJb4C6v/vwPinUId9MzeOD1Gduk5P5jGXoOZgYKsF32
         K0l46nzLPRtNHliTFF41xiyP0zMivkfaBEQYHEE8XEaed6NOWLScBRJYWk055N0clula
         ku8Yi0xqYBb+aZX3UZr8938T6ry2I/UeCLz/aRI9MNFYqQUu2dZYEl+ZmIJlYoXzSnAK
         hUIw==
X-Forwarded-Encrypted: i=1; AJvYcCWknXV4kt4kEa+f3yC8tdAvbUph4NoWfYitSPTjaHfPs6yUXLp9zsu3DvX6S2BuZO7YBrnqUq+6Ts7F1wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMY8n5in+sKO72sHbj+3Bz9qJmRq6ElRvxkuNtPae3P4czRz4F
	vd1CDqKX4swLaE7tOHeZsEt7Pr6MOEbgc/NlA6MS2cm/cvFNDaROp4SPFe4PyNNzY2668NDa5sE
	CO0yLGVYL2O2Xhx2gRmN5f1kqup7WSeDkApDT/A==
X-Google-Smtp-Source: AGHT+IF8d9t+DAekHL9aAw+MGEhPwN2Iu/txmTGUHM5WZpE5W7o9yq1MbHa+UZYEZdxq36DGWi2W/HUmyRo6OrH4l1Q=
X-Received: by 2002:a05:690c:6d82:b0:6e2:ed0:9dc3 with SMTP id
 00721157ae682-6e20ed09ffdmr14679487b3.38.1727181244680; Tue, 24 Sep 2024
 05:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918103119.385597-1-manikandan.m@microchip.com>
 <20240918103119.385597-3-manikandan.m@microchip.com> <pjc75xbvdn4n7tqzjx33st2lf6bzryrs7zixahbv7j4fi5xa7j@xujs6wx7qeqs>
 <4cd72332-a718-42e0-8006-f589410c920f@microchip.com>
In-Reply-To: <4cd72332-a718-42e0-8006-f589410c920f@microchip.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 24 Sep 2024 14:33:53 +0200
Message-ID: <CAA8EJppZNW7-qwkqPke-8vbf=PGhf0MU-h47EJHuVgKmdV9+8Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] drm/bridge: add Microchip DSI controller support
 for sam9x7 SoC series
To: Manikandan.M@microchip.com
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux@armlinux.org.uk, Nicolas.Ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	Dharma.B@microchip.com, arnd@arndb.de, Hari.PrasathGE@microchip.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 12:17, <Manikandan.M@microchip.com> wrote:
>
> Hi Dmitry,
>
> On 20/09/24 9:45 pm, Dmitry Baryshkov wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Wed, Sep 18, 2024 at 04:01:17PM GMT, Manikandan Muralidharan wrote:
> >> Add the Microchip's DSI controller wrapper driver that uses
> >> the Synopsys DesignWare MIPI DSI host controller bridge.
> >>
> >> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> >> ---
> >> changes in v4:
> >> - Fixed issues reported by kernel test robot
> >> - replaced syscon_regmap_lookup_by_phandle with
> >> syscon_regmap_lookup_by_compatible
> >>
> >> changes in v3:
> >> - make remove callback return void
> >>
> >> changes in v2:
> >> - use static const with global variables
> >> - replace dev_err with dev_err_probe
> >> - move clk_prepare_enable to simplify the error path
> >> - use FIELD_PREP calls
> >> - remove unused macros and unused functions
> >> - rename function name with mchp_ suffix
> >> - add suspend and resume pm calls to handle pllref_clk
> >> ---
> >>   drivers/gpu/drm/bridge/Kconfig            |   8 +
> >>   drivers/gpu/drm/bridge/Makefile           |   1 +
> >>   drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c | 545 ++++++++++++++++++++++
> >>   3 files changed, 554 insertions(+)
> >>   create mode 100644 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c
> >>
> >> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> >> index 683cb33805b2..317246509601 100644
> >> --- a/drivers/gpu/drm/bridge/Kconfig
> >> +++ b/drivers/gpu/drm/bridge/Kconfig
> >> @@ -196,6 +196,14 @@ config DRM_MICROCHIP_LVDS_SERIALIZER
> >>        help
> >>          Support for Microchip's LVDS serializer.
> >>
> >> +config DRM_MICROCHIP_DW_MIPI_DSI
> >> +     tristate "Microchip specific extensions for Synopsys DW MIPI DSI"
> >> +     depends on DRM_ATMEL_HLCDC
> >> +     select DRM_DW_MIPI_DSI
> >> +     help
> >> +       This selects support for Microchip's SoC specific extensions
> >> +       for the Synopsys DesignWare dsi driver.
> >> +
> >>   config DRM_NWL_MIPI_DSI
> >>        tristate "Northwest Logic MIPI DSI Host controller"
> >>        depends on DRM
> >> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> >> index 3daf803ce80b..32e4233e6b5e 100644
> >> --- a/drivers/gpu/drm/bridge/Makefile
> >> +++ b/drivers/gpu/drm/bridge/Makefile
> >> @@ -14,6 +14,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
> >>   obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
> >>   obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
> >>   obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) += microchip-lvds.o
> >> +obj-$(CONFIG_DRM_MICROCHIP_DW_MIPI_DSI) += dw-mipi-dsi-mchp.o
> >>   obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
> >>   obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
> >>   obj-$(CONFIG_DRM_PARADE_PS8640) += parade-ps8640.o
> >> diff --git a/drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c b/drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c
> >> new file mode 100644
> >> index 000000000000..35cfca1ff000
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c
> >> @@ -0,0 +1,545 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
> >> + *
> >> + * Author: Manikandan Muralidharan <manikandan.m@microchip.com>
> >> + *
> >> + */
> >> +
> >
> > [...]
> >
> >> +
> >> +static int dw_mipi_dsi_mchp_get_lane_mbps(void *priv_data,
> >> +                                       const struct drm_display_mode *mode,
> >> +                                       unsigned long mode_flags, u32 lanes,
> >> +                                       u32 format, unsigned int *lane_mbps)
> >> +{
> >> +     struct dw_mipi_dsi_mchp *dsi = priv_data;
> >> +     unsigned long best_freq, fvco_min, fvco_max, fin, fout;
> >> +     unsigned long min_delta = ULONG_MAX, delta;
> >> +     unsigned int target_mbps = 0, mpclk, desired_mbps;
> >> +     unsigned int max_mbps = dppa_map[ARRAY_SIZE(dppa_map) - 1].max_mbps;
> >> +     unsigned int min_prediv, max_prediv;
> >> +     unsigned int _fbdiv, best_fbdiv, _prediv, best_prediv;
> >> +     int bpp;
> >> +     u64 freq_factor;
> >
> > This function is significantly overlapping with dw_mipi_dsi_get_lane_mbps().
> > Please extract a common helper and add it to dw-mipi-dsi.c. Other than
> > that, LGTM.
> >
> I find it difficult to understand your concern.
> The dw_mipi_dsi_mchp_get_lane_mbps() is the .get_lane_mbps phy_op
> specific to Microchip DSI wrapper. The dw_mipi_dsi_get_lane_mbps
> functionalities across different SoC wrapper is not the same to extract
> a common helper.

Ok, somebody didn't do a proper prefix naming. I was looking at
dw_mipi_dsi_get_lane_mbps() from dw-mipi-dsi-rockchip.c. It looks
pretty close to your code.

> >> +
> >> +     dsi->format = format;
> >> +     bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
> >> +     if (bpp < 0) {
> >> +             dev_err(dsi->dev,
> >> +                     "failed to get bpp for pixel format %d\n",
> >> +                     dsi->format);
> >> +             return bpp;
> >> +     }
> >> +
> > --
> > With best wishes
> > Dmitry
>
> --
> Thanks and Regards,
> Manikandan M.
>


-- 
With best wishes
Dmitry

