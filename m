Return-Path: <linux-kernel+bounces-427294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E78629DFF4E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9F1B26161
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642521FC0E8;
	Mon,  2 Dec 2024 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EX+y2EBp"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3AB1FAC51
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733136378; cv=none; b=SKKjuy0toV8/53v2yLvkSDOcwEqlwFEoxPTtMiuHdYr85xO3JsXNzIfiPMBIxbYUCrhhoMvqJ98SpmKHrl068WoOeHhk8JhNvIJtb9GBfHO7Nwn4NBeBE9U78kFmYxpGv5eMcZP3r3oJRqFYIbv+FF4rnkXDUjISQk1LrLoMGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733136378; c=relaxed/simple;
	bh=5p8OUOuS/ridzS/kqnWUfKyqUfh+3kPVWpYCu+TMNBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHRUA2z6QznbosBaGY0nk+l52h5Y/7qLjiQvmmO3OQ/uOgmjM5EUC3gJRCjiuDW2qhvWICO/7Pc6gvoxmIGmBAK8nqX2IIPF/zUT+xA4Ikh2jzYGBybXSn/BoChI1UHsA9vPIBdiNrRHB/ojPWur8pn5ZShAVmxhgBEJNzsaBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EX+y2EBp; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de6b7da14so4065682e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733136375; x=1733741175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sW5g5zNCxuwuA9CkgMzqa+U4e2iYbFVfy38zh54cXVg=;
        b=EX+y2EBp6j6xxOoc1ajD18Heer2Xrvoqq89MXU+9qKOzMADD0SET01AjnLZG49zecW
         CmdSiZRHBmrPDXcl+Wboe2REwFz2l3mIC6kcLXEAtNc3KzKZca7Mh7CpCBhO21YIl77X
         G0qXr3N1+usIEMgOv6pD+If5rB2Pw3n37+lNGZpKaNn+MH6odNX++TjtOkIQbEQTYc7s
         c3klUY/sOoSAB4W2gee21tYNjCH99EDCUogI4ursg+HV6GUskkF2XdxofxurFyfv83zH
         EfYssD46YU3DM8mAQs2q13o6y1VDepIsG1ABHvFDaxf6fdVCmOMF7HFojTveRVAzLIw3
         uBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733136375; x=1733741175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW5g5zNCxuwuA9CkgMzqa+U4e2iYbFVfy38zh54cXVg=;
        b=F7F8ncHE3fGbFqpMH7TdmWifomXPXyD1aZpcKuuvLrsZ5+OelgEd2sxSwfEa7a13Sl
         g4ABtnmagtsdKJpuAm5/0p4Mbt1hmLBhXQUnVPbEZEML06SZS+AXsZ0NnEdmEXh3wr32
         ymf7PxSq/KKXhOON9uq0uCLp8p5ArH3fAqktw9JnvU+gxZtXdoyIElnyI0auZfoN/83V
         fuXNPDeaRninW5ZVCPPdVIS7egFvpit5NIiqvOg4FiMKfg/4t/s3gUNd6HUdhlkzecb4
         nO0SKqO0HsWOM6/hkszffjAIPukwq4YUIr8UX7GRyQXy77MOee3tOnt+GCi6Q0pKMSPP
         GB2A==
X-Forwarded-Encrypted: i=1; AJvYcCX8fJRYS9BwEXsHGaQyLSKLn8ElPi+tIm0UWwifxebZGccm+6JlDB2R7EPnbBgT5LicgoqJUdRQADbuzrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZSa0bF5IA8DVzYIU99AKy4ORuJOs/qo0b/8/Q4uXTOdkaiVD
	FKKVJEGNIMy52x2yZGHFTJZCHUev5EtCIOIb+GuCgUeVcakT9rBWSwl1y5gUiqA=
X-Gm-Gg: ASbGncu8dcoCFwyZanNQv/KgCD+NoP8uPIYiiswiSbhLt+irm/5kxd3+iHUnCeJh2Kx
	njtOi+wCypcxYkWzSjNU4F6iLkUjnNyJk2ZqGj7l87A3PRPnLba5O4gbXqN3jBbHBjm+SaXYXtZ
	SURa0aYcPjrjaI7lNX974VgUztcocM7HDa6uatnPdRXLv0Sl9k+i3uV5iQBI9yXa5R5ZmnqyQZL
	gjlGdQcHGIXJEZSwUoH9qw2GIJpCSstyWWMbPxfiZLDhU5QiabGblc8mOygdYz8CyOJCr3tEN4q
	vo9jT73yiNrp4ch+KiJFgmTC6tnA6w==
X-Google-Smtp-Source: AGHT+IHSCZMOjWupesy5/0HxHZeda2UBmkbWGoOoF1ozJXCQtPgXFWsr4uPvfC7x0xE42+mBQm6WWA==
X-Received: by 2002:a05:6512:124e:b0:53d:d3bc:cc11 with SMTP id 2adb3069b0e04-53df0112095mr7509493e87.48.1733136374959;
        Mon, 02 Dec 2024 02:46:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644341bsm1424070e87.99.2024.12.02.02.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:46:14 -0800 (PST)
Date: Mon, 2 Dec 2024 12:46:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_lliu6@quicinc.com, quic_fangez@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/8] drm/msm/dp: Add support for lane mapping
 configuration
Message-ID: <zvapsvfftai4fp6vwrn33edqsyuuprq2pxz6spij6j7t4y6xmn@zzgp7gbsivbk>
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-5-09a4338d93ef@quicinc.com>
 <CAA8EJpoY8hySQd00yODGeHjSpVZpEBLjF3aBiKGJPUhpr-2mgw@mail.gmail.com>
 <d2a3cd6f-1077-4edb-9f0c-0c940a639050@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a3cd6f-1077-4edb-9f0c-0c940a639050@quicinc.com>

On Mon, Dec 02, 2024 at 04:40:05PM +0800, Xiangxu Yin wrote:
> 
> 
> On 11/29/2024 9:50 PM, Dmitry Baryshkov wrote:
> > On Fri, 29 Nov 2024 at 09:59, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
> >>
> >> Add the ability to configure lane mapping for the DP controller. This is
> >> required when the platform's lane mapping does not follow the default
> >> order (0, 1, 2, 3). The mapping rules are now configurable via the
> >> `data-lane` property in the devicetree. This property defines the
> >> logical-to-physical lane mapping sequence, ensuring correct lane
> >> assignment for non-default configurations.
> >>
> >> Signed-off-by: Xiangxu Yin <quic_xiangxuy@quicinc.com>
> >> ---
> >>  drivers/gpu/drm/msm/dp/dp_catalog.c | 11 +++++------
> >>  drivers/gpu/drm/msm/dp/dp_catalog.h |  2 +-
> >>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  2 +-
> >>  drivers/gpu/drm/msm/dp/dp_panel.c   | 13 ++++++++++---
> >>  drivers/gpu/drm/msm/dp/dp_panel.h   |  3 +++
> >>  5 files changed, 20 insertions(+), 11 deletions(-)
> >>

> >> @@ -461,6 +460,7 @@ static int msm_dp_panel_parse_dt(struct msm_dp_panel *msm_dp_panel)
> >>         struct msm_dp_panel_private *panel;
> >>         struct device_node *of_node;
> >>         int cnt;
> >> +       u32 lane_map[DP_MAX_NUM_DP_LANES] = {0, 1, 2, 3};
> >>
> >>         panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
> >>         of_node = panel->dev->of_node;
> >> @@ -474,10 +474,17 @@ static int msm_dp_panel_parse_dt(struct msm_dp_panel *msm_dp_panel)
> >>                 cnt = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
> >>         }
> >>
> >> -       if (cnt > 0)
> >> +       if (cnt > 0) {
> >> +               struct device_node *endpoint;
> >> +
> >>                 msm_dp_panel->max_dp_lanes = cnt;
> >> -       else
> >> +               endpoint = of_graph_get_endpoint_by_regs(of_node, 1, -1);
> >> +               of_property_read_u32_array(endpoint, "data-lanes", lane_map, cnt);
> >> +       } else {
> >>                 msm_dp_panel->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
> >> +       }
> > 
> > Why? This sounds more like dp_catalog or (after the refactoring at
> > [1]) dp_ctrl. But not the dp_panel.
> > 
> > [1] https://patchwork.freedesktop.org/project/freedreno/series/?ordering=-last_updated
> > 
> We are used the same prop 'data-lanes = <3 2 0 1>' in mdss_dp_out to keep similar behaviour with dsi_host_parse_lane_data.
> From the modules used, catalog seems more appropriate, but since the max_dp_lanes is parsed at dp_panel, it has been placed here.
> Should lane_map parsing in msm_dp_catalog_get, and keep max_dp_lanes parsing at the dp_panel?

msm_dp_catalog_get() is going to be removed. Since the functions that
are going to use it are in dp_ctrl module, I thought that dp_ctrl.c is
the best place. A better option might be to move max_dp_lanes and
max_dp_link_rate to dp_link.c as those are link params. Then
lane_mapping also logically becomes a part of dp_link module.

But now I have a more important question (triggered by Krishna's email
about SAR2130P's USB): if the lanes are swapped, does USB 3 work on that
platform? Or is it being demoted to USB 2 with nobody noticing that?

If lanes 0/1 and 2/3 are swapped, shouldn't it be handled in the QMP
PHY, where we handle lanes and orientation switching?

> >> +
> >> +       memcpy(msm_dp_panel->lane_map, lane_map, msm_dp_panel->max_dp_lanes * sizeof(u32));
> >>
> >>         msm_dp_panel->max_dp_link_rate = msm_dp_panel_link_frequencies(of_node);
> >>         if (!msm_dp_panel->max_dp_link_rate)
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
> >> index 0e944db3adf2f187f313664fe80cf540ec7a19f2..7603b92c32902bd3d4485539bd6308537ff75a2c 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
> >> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
> >> @@ -11,6 +11,8 @@
> >>  #include "dp_aux.h"
> >>  #include "dp_link.h"
> >>
> >> +#define DP_MAX_NUM_DP_LANES    4
> >> +
> >>  struct edid;
> >>
> >>  struct msm_dp_display_mode {
> >> @@ -46,6 +48,7 @@ struct msm_dp_panel {
> >>         bool video_test;
> >>         bool vsc_sdp_supported;
> >>
> >> +       u32 lane_map[DP_MAX_NUM_DP_LANES];
> >>         u32 max_dp_lanes;
> >>         u32 max_dp_link_rate;
> >>
> >>
> >> --
> >> 2.25.1
> >>
> > 
> > 
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

