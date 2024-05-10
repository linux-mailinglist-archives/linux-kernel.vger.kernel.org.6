Return-Path: <linux-kernel+bounces-175418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F373C8C1F56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E471F22562
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4AD15F335;
	Fri, 10 May 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xo1NTgKJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129914A084;
	Fri, 10 May 2024 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327732; cv=none; b=kgRMp7dKDCZW36dO7yhqu2XKKRtZ60M1ejK08PGxB3cCEj5NChzsqntZt15SMDptihxMxYvD67oKNrc6S6paA7NFSGCBRYCBJUw/7hdTdtxwxW8mscs6+vouT6ltQX+4574kpj3nHuGLsYeZReHhnuds5KxLUqQIoBswCLilA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327732; c=relaxed/simple;
	bh=NfCq0znA9xiQQKOgqCjjhCeBv5JL4GapTvi5dTTgNg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7PTau1rzR0qN8tLOs8njbtaJAnSgVs+nLPRbyO2DrMJtDyAhVu/umNd+uOGfrIsCnn+c6VtsrKFp5oP+COS1QX/WHMkseaSF3OLHBDpYk5zhXBJf21v1kW48knJ+UQ+XtgZ0SzuAQYsaIuS0YzpHSkEDJEf/rIFvAEaqnDhl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xo1NTgKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EE9C113CC;
	Fri, 10 May 2024 07:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715327732;
	bh=NfCq0znA9xiQQKOgqCjjhCeBv5JL4GapTvi5dTTgNg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xo1NTgKJVcIRWizY4Moj56cCaQqKaTr4IAt9qxFmN4ftE2ovyUckVKIsaj6OQWTdN
	 p86jCzWoCSRCCiTfMnXkXGX3NXMw08h66lE5PowpDhAXWq2u3Y+Z7pr5/8a4Fpw19p
	 ndykkCosAuEu5zcVjtsTvIIljbS1e25t5ZhP5xMI=
Date: Fri, 10 May 2024 08:55:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Saravana Kannan <saravanak@google.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 5/5] misc: add ge-addon-connector driver
Message-ID: <2024051039-decree-shrimp-45c6@gregkh>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
 <20240510-hotplug-drm-bridge-v2-5-ec32f2c66d56@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-hotplug-drm-bridge-v2-5-ec32f2c66d56@bootlin.com>

On Fri, May 10, 2024 at 09:10:41AM +0200, Luca Ceresoli wrote:
> Add a driver to support the runtime hot-pluggable add-on connector on the
> GE SUNH device. This connector allows connecting and disconnecting an
> add-on to/from the main device to augment its features. Connection and
> disconnection can happen at runtime at any moment without notice.
> 
> Different add-on models can be connected, and each has an EEPROM with a
> model identifier at a fixed address.
> 
> The add-on hardware is added and removed using device tree overlay loading
> and unloading.
> 
> Co-developed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> This commit is new in v2.
> ---
>  MAINTAINERS                      |   1 +
>  drivers/misc/Kconfig             |  15 ++
>  drivers/misc/Makefile            |   1 +
>  drivers/misc/ge-sunh-connector.c | 464 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 481 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 672c26372c92..0bdb4fc496b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9905,6 +9905,7 @@ F:	drivers/iio/pressure/mprls0025pa*
>  HOTPLUG CONNECTOR FOR GE SUNH ADDONS
>  M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
>  S:	Maintained
> +F:	drivers/misc/ge-sunh-connector.c
>  F:	Documentation/devicetree/bindings/connector/ge,sunh-addon-connector.yaml
>  
>  HP BIOSCFG DRIVER
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..99ef2eccbbaa 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -574,6 +574,21 @@ config NSM
>  	  To compile this driver as a module, choose M here.
>  	  The module will be called nsm.
>  
> +config GE_SUNH_CONNECTOR
> +	tristate "GE SUNH hotplug add-on connector"
> +	depends on OF
> +	select OF_OVERLAY
> +	select FW_LOADER
> +	select NVMEM
> +	select DRM_HOTPLUG_BRIDGE

Can these be depends instead of select?  'select' causes dependencies
that are hard, if not almost impossible, to detect at times why
something is being enabled.

> +	help
> +	  Driver for the runtime hot-pluggable add-on connector on the GE SUNH
> +	  device. This connector allows connecting and disconnecting an add-on
> +	  to/from the main device to augment its features. Connection and
> +	  disconnection can be done at runtime at any moment without
> +	  notice. Different add-on models can be connected, and each has an EEPROM
> +	  with a model identifier at a fixed address.

Module name?


> +static void sunh_conn_reset(struct sunh_conn *conn, bool keep_reset)
> +{
> +	dev_dbg(conn->dev, "reset\n");

ftrace is your friend.

> +static int sunh_conn_handle_event(struct sunh_conn *conn, bool plugged)
> +{
> +	int err;
> +
> +	if (plugged == conn->plugged)
> +		return 0;
> +
> +	dev_info(conn->dev, "%s\n", plugged ? "connected" : "disconnected");

Please remove debugging code from stuff you want to see merged.

Same for all dev_info() calls here, when drivers work properly, they are
quiet.

thanks,

greg k-h

