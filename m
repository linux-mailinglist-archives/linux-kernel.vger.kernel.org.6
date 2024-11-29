Return-Path: <linux-kernel+bounces-425630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 064659DE807
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56022B20CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D011B19F429;
	Fri, 29 Nov 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCTJ1Dn5"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CF198E61
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732888248; cv=none; b=tLaDqXRjB9OVSB2CwKAmSnwuKSCuWrLmRK3zQh9E8Ckdy1BozDU+/E1zWv786sOgjOOaO3UeH2d4IS5g8vlwHQ/dS/ZvVDvNd2cM4V653OJDPHdj5LJWlCHGf0suVYWwPuyksQyYli4Uzm94/6a4BHFF1aj+Ea9d8POnpfjRgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732888248; c=relaxed/simple;
	bh=BhCDKc0iEXoahws27sDKI0bAvnVW0+0Ai6Dt3BbLGgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxuuDaWINcm3P9chQ/vRpDWa9uUB0ok2YenQAxpobqXWBbguK4TF1exIpW3Pt6OA/HRlKmMk92cJOCjQc+7DDgdba6o3wB1rHVfkKO7VjtL9WO6KMQQkGOiwXdp2ZuJgSm87ABp52dbCvHXYXQTngVAuUd79YNHmaFl2bmFSYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JCTJ1Dn5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3985aabf43so659154276.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732888245; x=1733493045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7WQXtZAjWFqN8mKK3853FsLiUq722zhwbqGIVz24roM=;
        b=JCTJ1Dn5CT6gyQzW6/wWYGqdmwJQI4y+U1yTYSUuzvvzLqdgnzawRbCuOSkqKw/Hpl
         acXuAS1yMKyHipRO0BL256Bx0xls1NLZWykG0RRenB0ggs6IapwUK69kCXV3vD31UIMC
         RfC7RyF11PnS3219s3yWbUKKN5nQs5MmP6PIcWVJ+2h10q0J0juPIFJQmIG2w7e1C9m1
         VH3jxdgorqz0SUHFGqFbwZA/HA09VvAU0P+sElMD1UqlOJZOIv0f5aIltSQhbdXTpdoO
         IdWGwLALbtBIpdJGPwyH5F55S74gWI5+jJ+kiqlQ0fSh7Mv15Csu/LRM/Nm+J2lmHpWE
         s+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732888245; x=1733493045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WQXtZAjWFqN8mKK3853FsLiUq722zhwbqGIVz24roM=;
        b=TOhlh7p8SOcY48qiB2X8VP2xh9PeS0Ki/WXN2uMo/NyqDxoaKp2u08KJoeos1FjKkc
         YXjGOj7fqZ+ddSQKRG69rdP9TOqO0xoQVY99E6Cb6E4Bf/BrTk2s7WGNP9h3dhfNpjbH
         kcdYMV5g5jYIFQ91XAxC+HBrhM1pfDagoFVm1egECsOj5M2SwUP+HXLlk/7BaN3DxA6p
         TWBp+ioAws5LOPlGSoSVEVUxEdlKsTUVhfxELhlUs29e+8TyOEHbnlAkXgkVuDGlujOu
         sPBrt/VGu2p4NU/U0i8WSoVUes+b/WmTU9X6lUzzeghOVcIIRhEmJADR5+Ei/CMKCdkL
         fzBg==
X-Forwarded-Encrypted: i=1; AJvYcCVyXsPzOuS5w94QnYqJUYNkf5Wv5oKdJnkxqHlNzsrImOh+GvluOdh6Bmn5OnP0vJ5nXF3KwD62DH3OR30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIrAMpIEHcrfd10FwRccF/LFYVPx34d+6BzkIo+wKAd1PRPTc
	xP9YhAiIMe2J9K0M2KF2gCo34FHUJp97ARaFwmhg4tl+kJRj4x3bUS1+dJ6mmzH07tkAZXxSH2z
	nPhQkdV1AD0o8Y+jDXE17xCsVLbPTd3lkGBDsdA==
X-Gm-Gg: ASbGncs64Z42Sz10BE6iQj85OnIrU6GFWltE7O4ho1ny1Q6ZCLWzaJ7BtfvELRJsCzg
	x4ts9rauXYEQuMTzqNpBSh3vF76fmPwE=
X-Google-Smtp-Source: AGHT+IE0BIIdCa1JDpOjyTRYlwlbjuOqEl95UYxl+xvUnPElLVGBvG1eFLCUkRkyHmX0HZXqS4NsAg2SmNUQAHEPcuE=
X-Received: by 2002:a05:6902:2b0e:b0:e38:f30e:9b52 with SMTP id
 3f1490d57ef6-e395b8698e0mr9367911276.4.1732888245294; Fri, 29 Nov 2024
 05:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-5-09a4338d93ef@quicinc.com>
In-Reply-To: <20241129-add-displayport-support-for-qcs615-platform-v1-5-09a4338d93ef@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 29 Nov 2024 15:50:40 +0200
Message-ID: <CAA8EJpoY8hySQd00yODGeHjSpVZpEBLjF3aBiKGJPUhpr-2mgw@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/msm/dp: Add support for lane mapping configuration
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_lliu6@quicinc.com, quic_fangez@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 09:59, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
>
> Add the ability to configure lane mapping for the DP controller. This is
> required when the platform's lane mapping does not follow the default
> order (0, 1, 2, 3). The mapping rules are now configurable via the
> `data-lane` property in the devicetree. This property defines the
> logical-to-physical lane mapping sequence, ensuring correct lane
> assignment for non-default configurations.
>
> Signed-off-by: Xiangxu Yin <quic_xiangxuy@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 11 +++++------
>  drivers/gpu/drm/msm/dp/dp_catalog.h |  2 +-
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 13 ++++++++++---
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  3 +++
>  5 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index b4c8856fb25d01dd1b30c5ec33ce821aafa9551d..34439d0709d2e1437e5669fd0b995936420ee16f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -361,17 +361,16 @@ void msm_dp_catalog_ctrl_config_ctrl(struct msm_dp_catalog *msm_dp_catalog, u32
>         msm_dp_write_link(catalog, REG_DP_CONFIGURATION_CTRL, cfg);
>  }
>
> -void msm_dp_catalog_ctrl_lane_mapping(struct msm_dp_catalog *msm_dp_catalog)
> +void msm_dp_catalog_ctrl_lane_mapping(struct msm_dp_catalog *msm_dp_catalog, u32 *l_map)

lane_map, not l_map.

>  {
>         struct msm_dp_catalog_private *catalog = container_of(msm_dp_catalog,
>                                 struct msm_dp_catalog_private, msm_dp_catalog);
> -       u32 ln_0 = 0, ln_1 = 1, ln_2 = 2, ln_3 = 3; /* One-to-One mapping */
>         u32 ln_mapping;
>
> -       ln_mapping = ln_0 << LANE0_MAPPING_SHIFT;
> -       ln_mapping |= ln_1 << LANE1_MAPPING_SHIFT;
> -       ln_mapping |= ln_2 << LANE2_MAPPING_SHIFT;
> -       ln_mapping |= ln_3 << LANE3_MAPPING_SHIFT;
> +       ln_mapping = l_map[0] << LANE0_MAPPING_SHIFT;
> +       ln_mapping |= l_map[1] << LANE1_MAPPING_SHIFT;
> +       ln_mapping |= l_map[2] << LANE2_MAPPING_SHIFT;
> +       ln_mapping |= l_map[3] << LANE3_MAPPING_SHIFT;
>
>         msm_dp_write_link(catalog, REG_DP_LOGICAL2PHYSICAL_LANE_MAPPING,
>                         ln_mapping);
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
> index e932b17eecbf514070cd8cd0b98ca0fefbe81ab7..8b8de2a7d3ad561c1901e1bdaad92d4fab12e808 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.h
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
> @@ -69,7 +69,7 @@ u32 msm_dp_catalog_aux_get_irq(struct msm_dp_catalog *msm_dp_catalog);
>  /* DP Controller APIs */
>  void msm_dp_catalog_ctrl_state_ctrl(struct msm_dp_catalog *msm_dp_catalog, u32 state);
>  void msm_dp_catalog_ctrl_config_ctrl(struct msm_dp_catalog *msm_dp_catalog, u32 config);
> -void msm_dp_catalog_ctrl_lane_mapping(struct msm_dp_catalog *msm_dp_catalog);
> +void msm_dp_catalog_ctrl_lane_mapping(struct msm_dp_catalog *msm_dp_catalog, u32 *l_map);
>  void msm_dp_catalog_ctrl_mainlink_ctrl(struct msm_dp_catalog *msm_dp_catalog, bool enable);
>  void msm_dp_catalog_ctrl_psr_mainlink_enable(struct msm_dp_catalog *msm_dp_catalog, bool enable);
>  void msm_dp_catalog_setup_peripheral_flush(struct msm_dp_catalog *msm_dp_catalog);
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index bc2ca8133b790fc049e18ab3b37a629558664dd4..49c8ce9b2d0e57a613e50865be3fe98e814d425a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -177,7 +177,7 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
>  {
>         u32 cc, tb;
>
> -       msm_dp_catalog_ctrl_lane_mapping(ctrl->catalog);
> +       msm_dp_catalog_ctrl_lane_mapping(ctrl->catalog, ctrl->panel->lane_map);
>         msm_dp_catalog_ctrl_mainlink_ctrl(ctrl->catalog, true);
>         msm_dp_catalog_setup_peripheral_flush(ctrl->catalog);
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index 5d7eaa31bf3176566f40f01ff636bee64e81c64f..8654180aa259234bbd41f4f88c13c485f9791b1d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -11,7 +11,6 @@
>  #include <drm/drm_of.h>
>  #include <drm/drm_print.h>
>
> -#define DP_MAX_NUM_DP_LANES    4
>  #define DP_LINK_RATE_HBR2      540000 /* kbytes */
>
>  struct msm_dp_panel_private {
> @@ -461,6 +460,7 @@ static int msm_dp_panel_parse_dt(struct msm_dp_panel *msm_dp_panel)
>         struct msm_dp_panel_private *panel;
>         struct device_node *of_node;
>         int cnt;
> +       u32 lane_map[DP_MAX_NUM_DP_LANES] = {0, 1, 2, 3};
>
>         panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>         of_node = panel->dev->of_node;
> @@ -474,10 +474,17 @@ static int msm_dp_panel_parse_dt(struct msm_dp_panel *msm_dp_panel)
>                 cnt = drm_of_get_data_lanes_count(of_node, 1, DP_MAX_NUM_DP_LANES);
>         }
>
> -       if (cnt > 0)
> +       if (cnt > 0) {
> +               struct device_node *endpoint;
> +
>                 msm_dp_panel->max_dp_lanes = cnt;
> -       else
> +               endpoint = of_graph_get_endpoint_by_regs(of_node, 1, -1);
> +               of_property_read_u32_array(endpoint, "data-lanes", lane_map, cnt);
> +       } else {
>                 msm_dp_panel->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
> +       }

Why? This sounds more like dp_catalog or (after the refactoring at
[1]) dp_ctrl. But not the dp_panel.

[1] https://patchwork.freedesktop.org/project/freedreno/series/?ordering=-last_updated

> +
> +       memcpy(msm_dp_panel->lane_map, lane_map, msm_dp_panel->max_dp_lanes * sizeof(u32));
>
>         msm_dp_panel->max_dp_link_rate = msm_dp_panel_link_frequencies(of_node);
>         if (!msm_dp_panel->max_dp_link_rate)
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
> index 0e944db3adf2f187f313664fe80cf540ec7a19f2..7603b92c32902bd3d4485539bd6308537ff75a2c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
> @@ -11,6 +11,8 @@
>  #include "dp_aux.h"
>  #include "dp_link.h"
>
> +#define DP_MAX_NUM_DP_LANES    4
> +
>  struct edid;
>
>  struct msm_dp_display_mode {
> @@ -46,6 +48,7 @@ struct msm_dp_panel {
>         bool video_test;
>         bool vsc_sdp_supported;
>
> +       u32 lane_map[DP_MAX_NUM_DP_LANES];
>         u32 max_dp_lanes;
>         u32 max_dp_link_rate;
>
>
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

