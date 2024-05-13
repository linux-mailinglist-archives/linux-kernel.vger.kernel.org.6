Return-Path: <linux-kernel+bounces-177862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC18C4575
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9D1281FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF681BF40;
	Mon, 13 May 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBXzduYc"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB01AACA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619511; cv=none; b=gBVHzokoGpoFKG7WkoI0FdMj0cnFBf5NOS8rzBJHmH2lxQznY3/SjQNKaE3xMB1LyzXKh9mrB1oMJTNljrEAOK4d4ffWCdcZ/QQpLIs1ZfgsPExzSJyou9PrUX03hMnRXghBDh0/5q8WincMoUyCg4AndPrf/myZ0JfNPONfnRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619511; c=relaxed/simple;
	bh=HttPajzv7fEGbK6R/qTzuYIYvzP2qDiXxqGFl1yM1xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSLIUr8W5O5pHf3aA81eK3abfwDXQzuf1WV1z2II3DScPCk6OUtVx7jS6ft1VLcEnYTW6G8V0sjypYKFBfm1Ui9D6yQM63XwqSNoZkIwO4lw5vzpgzNUq6s9IpyKvXoOJCtZ/ZFs5OWLpUN2e/Fd6NwO5IdpzsNXaALo7PX6POI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBXzduYc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6153d85053aso34811247b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715619509; x=1716224309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FYzGbEJKkgXKMkF8uHa4ezT70rrAZuIzkboCItlGciY=;
        b=MBXzduYct3kKpbXPvtlvYLXfvVaERSeHPId6U+3EQXu0qny2SM8syK2ypfLJ5SDcb2
         6SDZhUXPzcI6tWFqKK/ogrThpQ/angO0EflfzSkmRTcgjtJQ2lQSK0ZZdzrtIcFf6HoD
         87ZVjbnmHKePSECEVPc0ufoAvExeYwfnd/TE1G7T8mCZOlv46dzH3008u1u4DqTk9W21
         S3gan5BS0aPpKy2BWqKL59XckBxoRi0VmdO7gUCdKOe37g95JD1zCNfKSY72teYXAIP5
         xt4PsBtMns0MQ6SnLn2Q2qVPHlOiV/i7zX6RzZk5FvNgt52mRLOaDMZFf01+L2vAX8t8
         8Wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619509; x=1716224309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYzGbEJKkgXKMkF8uHa4ezT70rrAZuIzkboCItlGciY=;
        b=qDGHqJCyknRl6W9rtFspYdpsNOK0EKAJ3m4/vf5oQUpTQ2pblYzaNev3M8Dy3ej9Rx
         vo2muUQGKZg2fdMO1koWlPpcfUXMK1U14pO1d55+0YEaLG7dUiLVjXEU925uCTo0JSZL
         V7D8ApBQNbh0jouVMiIYyjsJxLoe87nC7N2q0158vEXluVG2uPAeanzSZkVXTvz96GAh
         k1QFe1nqxFawxxOBSFy1A3cwQTQmFOgrqJnGUH6ptYEn1Zrn+yP63dYJIIZp9/svXdV4
         WBEs1QfRFtYHVpP3eZXG+DveujYCSqvPGHy5Ydph9F936Hu6RbMdnpP4oztPx+vi0khl
         GKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyBA0sZCltTrR6eGskIYJMozC1+Zaugn+SKh8F6KQ7rcTAOrN25UXqOV3s3RovTIJRnU1BcKhkeMV2M/xz8drNtnuk5T9FxKLxsf/V
X-Gm-Message-State: AOJu0YyDmCaaHgsuJ+sslYYIYZIO8JBdHC+TMCOq/aPP8iTjmN4mAdR3
	arsiDtCKyF4qF6DLzMAUkVWTcmxyuXRf6YtEKDpbbeee5gzQBRylVpc9yE5BwIgZvROl/iWZ7JJ
	NAyhhapz4J9Ypafzxwvyrh79RnAjm14jJavo4ng==
X-Google-Smtp-Source: AGHT+IEXpWRGnmuY+t5qHCD88rsKWAw2KXbR51bgXSwAaMdoMKoJahXIhcHPVPgOfm/Ra24Cx8KycPeeNLhV7xaRYXc=
X-Received: by 2002:a81:a0cd:0:b0:61b:33f6:9bbb with SMTP id
 00721157ae682-622affdf582mr100457647b3.28.1715619508910; Mon, 13 May 2024
 09:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513080243.3952292-1-victor.liu@nxp.com>
In-Reply-To: <20240513080243.3952292-1-victor.liu@nxp.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 13 May 2024 19:58:18 +0300
Message-ID: <CAA8EJppT63E-4YnCM+hQhbAK_ZXh4O2L0Bz+XzTyywto22AYVA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: adv7511: Attach next bridge without creating connector
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, biju.das.jz@bp.renesas.com, 
	aford173@gmail.com, bli@bang-olufsen.dk, robh@kernel.org, 
	jani.nikula@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 10:55, Liu Ying <victor.liu@nxp.com> wrote:
>
> The connector is created by either this ADV7511 bridge driver or
> any DRM device driver/previous bridge driver, so this ADV7511
> bridge driver should not let the next bridge driver create connector.
>
> If the next bridge is a HDMI connector, the next bridge driver
> would fail to attach bridge from display_connector_attach() without
> the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
>
> Add that flag to drm_bridge_attach() function call in
> adv7511_bridge_attach() to fix the issue.
>
> This fixes the issue where the HDMI connector bridge fails to attach
> to the previous ADV7535 bridge on i.MX8MP EVK platform:
>
> [    2.216442] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /hdmi-connector to encoder None-37: -22
> [    2.220675] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] using ADMA
> [    2.226262] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@30800000/i2c@30a30000/hdmi@3d to encoder None-37: -22
> [    2.245204] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@32c00000/dsi@32e60000 to encoder None-37: -22
> [    2.256445] imx-lcdif 32e80000.display-controller: error -EINVAL: Failed to attach bridge for endpoint0
> [    2.265850] imx-lcdif 32e80000.display-controller: error -EINVAL: Cannot connect bridge
> [    2.274009] imx-lcdif 32e80000.display-controller: probe with driver imx-lcdif failed with error -22
>
> Fixes: 14b3cdbd0e5b ("drm/bridge: adv7511: make it honour next bridge in DT")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

