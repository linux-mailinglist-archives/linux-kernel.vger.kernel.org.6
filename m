Return-Path: <linux-kernel+bounces-336891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F15984227
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546932873F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD56155345;
	Tue, 24 Sep 2024 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3TI0Vsk"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC7482D8
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170268; cv=none; b=jb3ECPjCr8SShmZAUAKMZTqpzz7DuQXaVFqp/lgjHvpXGERxwv5XQsHHE6uszTJgQF/NuSM9Zb0t2wxHG1EzJjvMrDRvi/vPJpsXDzBKscNqGRUFKIZxn5Zy7306rGBWGrJ0brNGUDQTWoc1A32EInQ/sMmfU26f2J4VABLJC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170268; c=relaxed/simple;
	bh=7rEm9JEz9RGM0WGcUj3h1rlyBqcC1eBi895PoRFTQg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQp9NPM5HyzX1t0rp3sChMXw8vd9wk8PJv11eAk8ey7aRqQdsSRW3ZuETfrBmGISt7i5eUizRhSE8aec8oRXrW0vFo1QNv7M97vOs8OKVbAmQmkbWXeMhJfBdGM55yUKexFqKau/52ld3VWear25mZPykOXNmHqovGd6RbxkfRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q3TI0Vsk; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so58374991fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727170264; x=1727775064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yWBIbFHZNiPI/HNmpMhvRGObId3eaCn9wFIzXYkz7to=;
        b=q3TI0VskM3Qp7IW3ebLpJzH+DRyJRVewO8UArC5lGyTCzhhe0cdCBQT1LpfNachVhA
         Z9dP85Y3wRc+OenK8dt08+ykbj0KsfOYUVmLgdnUYmUcQZUWO1KspPcaLp3ht5zhVQ2o
         X8wq3mk5F0blPswE31t478IVAheWHNgXxzNtdagigEVePg3LbsCLsnwUJdZ4egrOjBCs
         TUXo+jywQib6ECGmMI0Hk+Aa3hyqj6QjTiSF5L5YtJInabZQXKyatkMYMSSkWzkn6HRf
         UukAFZpMO6qF+WZEWYJgzjCJWovv7Z0nfASe64R4Xcd8A1rZuJ1Qi4HuVj9+/+aevn9A
         q3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170264; x=1727775064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWBIbFHZNiPI/HNmpMhvRGObId3eaCn9wFIzXYkz7to=;
        b=sBl7bHCbyWlKnIHGZtqMJn8vJi1IMGpkjMgNDE63vqSsStE0k8suK/rfpNkCiN7IGJ
         pTuvLEKumij7iO6T/Uc37dHDqwsaAM8C+skQo/7/O+UCwW9IScZEyR2gxzSZFqVFGwQ1
         1peurc34u+P0Kvu7075x9YfC44ZLbBvRyI4Sic4zxPlEuZizOhcqt7Kz0qRc1zMHs6O+
         bv1xJJdZQC3TAd9VNcCSTuauXrKlJH1tzhGkGAILhOY06MUBVODy7b2HuHUwMqCNMz4C
         cXC+SZiIma61WlC9LXbDWd3/fwUGUAm6IwSGU9uH9W2O5IyWmcdzlXLFJl7x18VxsMpo
         nmwA==
X-Forwarded-Encrypted: i=1; AJvYcCUaNOkcvo+o+iyXJ06WS7PucpFV/4D4bZFKdTp/UCzc/3tkQyA8EySEPqgqyK5QKT1EtLa0Xr8qONTE5sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzONY370TP2GLr6jsJMC4frAiJadzdpUbWd9brZxGMk7VsSZ5oD
	KLrG49SPjvIGnwzqmZa4zKo9hOZyjBKex6sNu/rXD80Il+3uBxEv2hLwmlcnxkw=
X-Google-Smtp-Source: AGHT+IHl/avwAYPIhb6TlrUBum/ZYPGtpNgmakP+vyGoMgDMX9PZ7T3T0XlPukXCsWcNZg9FyHE4qw==
X-Received: by 2002:a05:6512:220f:b0:530:aa4b:81c7 with SMTP id 2adb3069b0e04-536ad3d5526mr6590279e87.59.1727170264125;
        Tue, 24 Sep 2024 02:31:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a864029dsm150753e87.120.2024.09.24.02.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:31:03 -0700 (PDT)
Date: Tue, 24 Sep 2024 12:31:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, mripard@kernel.org, 
	Sandor Yu <Sandor.yu@nxp.com>, kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	sam@ravnborg.org
Subject: Re: [PATCH v17 1/8] drm: bridge: Cadence: Create mhdp helper driver
Message-ID: <vlqcv7pdhyf6rjmkm2ccyvg3fv64gcp536zppns6nc3xpzuew6@j3qrwextsp33>
References: <cover.1727159906.git.Sandor.yu@nxp.com>
 <6e2e4951aa4c69eed68af231c2b0b2ce302b2358.1727159906.git.Sandor.yu@nxp.com>
 <2773403.mvXUDI8C0e@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2773403.mvXUDI8C0e@steina-w>

On Tue, Sep 24, 2024 at 10:41:26AM GMT, Alexander Stein wrote:
> Hi Sandor,
> 
> Am Dienstag, 24. September 2024, 09:36:46 CEST schrieb Sandor Yu:
> > MHDP8546 mailbox access functions will be share to other mhdp driver
> > and Cadence HDP-TX HDMI/DP PHY drivers.
> > Create a new mhdp helper driver and move all those functions into.
> > 
> > cdns_mhdp_reg_write() is renamed to cdns_mhdp_dp_reg_write(),
> > because it use the DPTX command ID DPTX_WRITE_REGISTER.
> > 
> > New cdns_mhdp_reg_write() is created with the general command ID
> > GENERAL_REGISTER_WRITE.
> > 
> > Rewrite cdns_mhdp_set_firmware_active() in mhdp8546 core driver,
> > use cdns_mhdp_mailbox_send() to replace cdns_mhdp_mailbox_write()
> > same as the other mailbox access functions.
> > 
> > Replaces the local mutex mbox_mutex with a global mutex mhdp_mailbox_mutex
> > to prevent race conditions in mailbox access by multi drivers.
> > 
> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > ---
> > v16->v17:
> > - Replaces the local mutex mbox_mutex with a global mutex mhdp_mailbox_mutex
> > 
> > v12->v16:
> >  *No change.
> > 
> > V11->v12:
> > - Move status initialize out of mbox_mutex.
> > - Reorder API functions in alphabetical.
> > - Add notes for malibox access functions.
> > - Add year 2024 to copyright.
> > 
> >  drivers/gpu/drm/bridge/cadence/Kconfig        |   4 +
> >  drivers/gpu/drm/bridge/cadence/Makefile       |   1 +
> >  .../gpu/drm/bridge/cadence/cdns-mhdp-helper.c | 307 +++++++++++++
> >  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 425 ++++--------------
> >  .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  47 +-
> >  .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   |  36 +-
> >  include/drm/bridge/cdns-mhdp-helper.h         |  94 ++++
> >  7 files changed, 507 insertions(+), 407 deletions(-)
> >  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c
> >  create mode 100644 include/drm/bridge/cdns-mhdp-helper.h
> > 
> > diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
> > index cced81633ddcd..e0973339e9e33 100644
> > --- a/drivers/gpu/drm/bridge/cadence/Kconfig
> > +++ b/drivers/gpu/drm/bridge/cadence/Kconfig
> > @@ -21,6 +21,9 @@ config DRM_CDNS_DSI_J721E
> >  	  the routing of the DSS DPI signal to the Cadence DSI.
> >  endif
> >  
> > +config CDNS_MHDP_HELPER
> > +	tristate
> > +
> >  config DRM_CDNS_MHDP8546
> >  	tristate "Cadence DPI/DP bridge"
> >  	select DRM_DISPLAY_DP_HELPER
> > @@ -28,6 +31,7 @@ config DRM_CDNS_MHDP8546
> >  	select DRM_DISPLAY_HELPER
> >  	select DRM_KMS_HELPER
> >  	select DRM_PANEL_BRIDGE
> > +	select CDNS_MHDP_HELPER
> >  	depends on OF
> >  	help
> >  	  Support Cadence DPI to DP bridge. This is an internal
> > diff --git a/drivers/gpu/drm/bridge/cadence/Makefile b/drivers/gpu/drm/bridge/cadence/Makefile
> > index c95fd5b81d137..087dc074820d7 100644
> > --- a/drivers/gpu/drm/bridge/cadence/Makefile
> > +++ b/drivers/gpu/drm/bridge/cadence/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
> >  cdns-dsi-y := cdns-dsi-core.o
> >  cdns-dsi-$(CONFIG_DRM_CDNS_DSI_J721E) += cdns-dsi-j721e.o
> > +obj-$(CONFIG_CDNS_MHDP_HELPER) += cdns-mhdp-helper.o
> >  obj-$(CONFIG_DRM_CDNS_MHDP8546) += cdns-mhdp8546.o
> >  cdns-mhdp8546-y := cdns-mhdp8546-core.o cdns-mhdp8546-hdcp.o
> >  cdns-mhdp8546-$(CONFIG_DRM_CDNS_MHDP8546_J721E) += cdns-mhdp8546-j721e.o
> > diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c
> > new file mode 100644
> > index 0000000000000..c60a6b69a5343
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c
> > @@ -0,0 +1,307 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2023, 2024 NXP Semiconductor, Inc.
> > + *
> > + */
> > +#include <drm/bridge/cdns-mhdp-helper.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/module.h>
> > +
> > +/* Protects mailbox communications with the firmware */
> > +DEFINE_MUTEX(mhdp_mailbox_mutex);
> 
> This is not enough if the driver is built as a module:
> 
> > ERROR: modpost: "mhdp_mailbox_mutex"
> > [drivers/gpu/drm/bridge/cadence/cdns-mhdp8546.ko] undefined! ERROR:
> > modpost: "mhdp_mailbox_mutex"
> > [drivers/gpu/drm/bridge/cadence/cdns-mhdp8501.ko] undefined!
> 
> Not sure if EXPORT_SYMBOL_GPL() on a mutex is considered good style.

Absolutely no. The API should wrap register access, using the mutex
whether required, rather than exporting the mutex for everybody else to
use.

> 
> Best regards,
> Alexander
> 
> > [snip]
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 

-- 
With best wishes
Dmitry

