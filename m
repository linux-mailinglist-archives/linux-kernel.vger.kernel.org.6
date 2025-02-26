Return-Path: <linux-kernel+bounces-534509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A621A467C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0EA1885682
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1B224B02;
	Wed, 26 Feb 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="sVHZxwoX"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608322257F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590037; cv=none; b=I7BBHpxBm94kyYI/Le2QAwor0J5IBMJ1RwlEDIyW5d65cfWEJ4G7l2qfHkOJto7JSkJFfZC/H/0CiYLhWW0WeMWjNfasAA4vKdQIvmhiE3jupbRKEP0rseP8kDPevQUTChpr+9tIoOinjXXjtlrjppfjNsnI6fpk8cvU9twyrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590037; c=relaxed/simple;
	bh=HQSBEPx0iDJabo5iKQ4x317NeHWlkolsMjJAGghkvk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IapraPN5aS5D1vBJjqb/Nv3UJzp2yjuroJIPBZ3VrdaAX4mRm3m1xf3a5qKCT3urbWqvNlLHgrssKM5xrgfEPDZR8mn3djxLTt0aN+7/nKKw5XAa7JoK1CvnI7gKxf8zXEhuROrg3HdVwOkAXDfWvSq6URzwGrVawPQ3yIZI4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=sVHZxwoX; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5dd164f03fso6517582276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1740590034; x=1741194834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v16JSKm7NuBmPVU9q5+qcA5vKYKf3DiQ/loXOvg4m4U=;
        b=sVHZxwoX4Nvp0WVGsBrgVkBu3Rbtybza4o1tyQPrfbon6SxO0nBY23nB+2DI/mbhua
         QYc/s2Pxbp2q4/eNB4VQPvgy1zdw3IT6bksasc+zAj4ia3W8kTTskYqa+SZvNNduIHd7
         S79cVYMChCuawj1d8Mzv2RJ7Bkhmfou/8Fz6EXMPzr70UIaue9de4jPbNLoX+oIczVpQ
         33LAz/xaU4ypk1XXhOoFyr4RwIDcSq0eN3/kYrqu5nGaHKMj4hlpXuDoLpiXDF037Q+J
         NGXzh7hcO2ostF3aM2jUyc0XYpgqDIwb5MV9G/8rkRa1GeDGe4kExTXgIA5e3QeFE3k1
         TRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740590034; x=1741194834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v16JSKm7NuBmPVU9q5+qcA5vKYKf3DiQ/loXOvg4m4U=;
        b=lDkQbneDFO/G2IGS/ZNz5rfLIvKJglMiUljN131E/utHYG2vzSCKjKQKXbykvPUKZR
         OXBNA3OcJIae7OfsB2NrkprKdpMUfzd7ub/c4wa9jnMAkKQ61/e6FK7QEDo1alim2+Vt
         6Cmuu2mxoZIO9DFrBIDGRtBix5JhUhwwG4DseF81Ds1onSC73uJvTSlgMwzWX25WhGBa
         xVe9J88U4kW8k2I1povxE+C0H8B//fmiXjpeNzcE5ZkllnJjjLnRjsZro5Xe9Bncp9Sp
         4sfyVQ7/XProHhaBjxgXJiKxxmmSTvnhtXE9udqBMfbbz/qrbKbXCSSQeun7Web86bKt
         Jk1A==
X-Gm-Message-State: AOJu0Yzjfv9+g9SRltQWli79TJM20TJ6w+M6kepG9ZHXsaEF4HF2IW3A
	Rf6lGygzqJxyy9nNN79FAeGvXs36x915ZktnoWZb2GjWLgVRCQeVdQRuvbi8st9JyMwoWdb0a+d
	2vE0Z5Eqd8F4wM3CsMvMu9VqGM1Br00CiSKgt6g==
X-Gm-Gg: ASbGncuJp4dtfaJbR9NKhHXAfLmLCfEs+P+RoWrrXoL4V5HPXgiCK5Wo5B9psGbdABC
	Us+P9Kb+/wlJCf8+OXm4Ae1lMbkyD9jyfxot5MZnAg+YRGBmU0cEMqx41mDNXq1BKw1/g+C+n23
	XQBplQ24pP7JFOKy2S7gKncUYGf3FeTH9bynYNjGY=
X-Google-Smtp-Source: AGHT+IG7BRekJ/GUeFxp0m+34WDEKrlHgNOI7qMTkO3ePczj09HZOi8iTSNdWu/DGb+qqAztFE0yKyE/JxzmnQCW8Pg=
X-Received: by 2002:a05:6902:2e0a:b0:e5d:dda6:d1d with SMTP id
 3f1490d57ef6-e607a565902mr6860903276.42.1740590034172; Wed, 26 Feb 2025
 09:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226153929.274562-1-mathis.foerst@mt.com> <20250226153929.274562-4-mathis.foerst@mt.com>
In-Reply-To: <20250226153929.274562-4-mathis.foerst@mt.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 26 Feb 2025 17:13:38 +0000
X-Gm-Features: AQ5f1Jo78Bz7szki1OPhZNCoefOi0V3LvTbHL1brFYJAZbXIFOnLIMAl10k6kG0
Message-ID: <CAPY8ntA2eedTY-0hY5ThkiKiKYKpSAij+bbeBWvWAgSeMEzvsQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] MT9M114: Add get_mbus_config
To: Mathis Foerst <mathis.foerst@mt.com>
Cc: linux-kernel@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, manuel.traut@mt.com
Content-Type: text/plain; charset="UTF-8"

Hi Mathis

On Wed, 26 Feb 2025 at 15:45, Mathis Foerst <mathis.foerst@mt.com> wrote:
>
> The i.MX6 camera frameworks requires get_mbus_config to be implemented.
> See [0].
>
> [0] drivers/staging/media/imx/imx-media-csi.c - line 211..216

The docs for get_mbus_config say
 * @get_mbus_config: get the media bus configuration of a remote sub-device.
 *             The media bus configuration is usually retrieved from the
 *             firmware interface at sub-device probe time, immediately
 *             applied to the hardware and eventually adjusted by the
 *             driver.
https://github.com/torvalds/linux/blob/master/include/media/v4l2-subdev.h#L814

All other receiver drivers (including imx6-mipi-csi2.c) that call
get_mbus_config handle it returning -ENOIOCTLCMD by reverting to the
static configuration or the receiver node from device tree / ACPI.

I may be missing something, but as imx-media-csi.c appears to be the
exception, isn't it better to fix that up rather than having to fix up
all the sensor drivers that ever might get attached to it?

> Signed-off-by: Mathis Foerst <mathis.foerst@mt.com>
> ---
>  drivers/media/i2c/mt9m114.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/media/i2c/mt9m114.c b/drivers/media/i2c/mt9m114.c
> index 5f0b0ad8f885..fa64d6d315a1 100644
> --- a/drivers/media/i2c/mt9m114.c
> +++ b/drivers/media/i2c/mt9m114.c
> @@ -1977,6 +1977,24 @@ static int mt9m114_ifp_registered(struct v4l2_subdev *sd)
>                 v4l2_device_unregister_subdev(&sensor->pa.sd);
>                 return ret;
>         }
> +       return 0;
> +}
> +
> +static int mt9m114_ifp_get_mbus_config(struct v4l2_subdev *sd,
> +                                  unsigned int pad,
> +                                  struct v4l2_mbus_config *cfg)
> +{
> +       struct mt9m114 *sensor = ifp_to_mt9m114(sd);
> +
> +       if (sensor->bus_cfg.bus_type == V4L2_MBUS_CSI2_DPHY) {
> +               cfg->type = V4L2_MBUS_CSI2_DPHY;

Not setting cfg->bus.mipi_csi2.num_data_lanes is going to cause some
confusion. What does an assumed 0 data lanes mean?

Likewise it would be sensible to set cfg->bus.mipi_csi2.flags so as to
avoid any ambiguities (did the caller memset all fields before
calling?)

  Dave

> +       } else {
> +               cfg->type = V4L2_MBUS_PARALLEL;
> +               cfg->bus.parallel.flags = V4L2_MBUS_MASTER |
> +                                         V4L2_MBUS_PCLK_SAMPLE_RISING |
> +                                         V4L2_MBUS_DATA_ACTIVE_HIGH;
> +               cfg->bus.parallel.bus_width = 8;
> +       }
>
>         return 0;
>  }
> @@ -1993,6 +2011,7 @@ static const struct v4l2_subdev_pad_ops mt9m114_ifp_pad_ops = {
>         .set_fmt = mt9m114_ifp_set_fmt,
>         .get_selection = mt9m114_ifp_get_selection,
>         .set_selection = mt9m114_ifp_set_selection,
> +       .get_mbus_config = mt9m114_ifp_get_mbus_config,
>         .get_frame_interval = mt9m114_ifp_get_frame_interval,
>         .set_frame_interval = mt9m114_ifp_set_frame_interval,
>  };
> --
> 2.34.1
>
>

