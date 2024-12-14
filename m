Return-Path: <linux-kernel+bounces-446177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701359F20B1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 21:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F110167037
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C471ABEBB;
	Sat, 14 Dec 2024 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ONu7iTlN"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D04DDA9
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734208186; cv=none; b=GjmhIjSg1ADG+BcaZLyzP7lCtj2k4ppPLK6reK+0UpuMaNVYzRv75eoUXYqJ73mBP4lUym6vT83UEDg6cXoRJca3E8jpnGOe4wHz3Y/hH9+v+edySEjFgm2+u/QvC6fEmAtJFLu6cBG817m9FrZTJseGMJAFZvz77nCryWj/IZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734208186; c=relaxed/simple;
	bh=QTxXMH5UTUUuT8FLw/plrPNbZtUIWNZsmAa68YVMRHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVYCfzg84tu3/7KXANA32hhjbrCwDSYG6uNmWbx0by26b/rL+uX4uf64ltSb/beTT//TkSAkhNQjjcMdR8ENyjF4R5JpgjRLXY/VUd506+0rW5G/6v1Z/IBsQSBgg72IWvzfIaQxtOCu8/mG1bM161FjSUy7nMLrmYC1O/AAIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ONu7iTlN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 45881741;
	Sat, 14 Dec 2024 21:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1734208141;
	bh=QTxXMH5UTUUuT8FLw/plrPNbZtUIWNZsmAa68YVMRHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONu7iTlNyG1ZQpIOSNGJ23rDxpj23rUct2etRutHVxFCDahfz4d4F+3R2YYWy3eTe
	 C/H6jcaYnamkjGwe6qr2a/zKtGjZU0HSNmFa4fOKZrt1rEO3n7/pSgKUoxm07aISL8
	 WMqYIJ1pQ9KL2qX+21vKLyaubPOFgCMCsz5sskl8=
Date: Sat, 14 Dec 2024 22:29:20 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/nouveau: incorporate I2C TV encoder drivers
Message-ID: <20241214202920.GC8294@pendragon.ideasonboard.com>
References: <20241214-nouveau-encoder-slave-v1-0-beda767472e3@linaro.org>
 <20241214-nouveau-encoder-slave-v1-1-beda767472e3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241214-nouveau-encoder-slave-v1-1-beda767472e3@linaro.org>

Hi Dmitry,

Thank you for the patch.

On Sat, Dec 14, 2024 at 05:35:44PM +0200, Dmitry Baryshkov wrote:
> Chrontel CH7006 and Silicon Image sil164 drivers use drm_encoder_slave
> interface which is being used only by the nouveau driver. It doesn't
> make sense to keep this interface inside the DRM subsystem. In
> preparation to moving this set of helpers to the nouveau driver, move
> the only two I2C driver that use that interface to the nouveau driver
> too.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/i2c/Kconfig                          | 18 ------------------
>  drivers/gpu/drm/i2c/Makefile                         |  6 ------
>  drivers/gpu/drm/nouveau/Kconfig                      | 20 ++++++++++++++++++++
>  drivers/gpu/drm/nouveau/dispnv04/Kbuild              |  2 ++
>  drivers/gpu/drm/nouveau/dispnv04/dfp.c               |  2 +-
>  .../gpu/drm/{ => nouveau/dispnv04}/i2c/ch7006_drv.c  |  0
>  .../gpu/drm/{ => nouveau/dispnv04}/i2c/ch7006_mode.c |  0
>  .../gpu/drm/{ => nouveau/dispnv04}/i2c/ch7006_priv.h |  3 ++-
>  .../gpu/drm/{ => nouveau/dispnv04}/i2c/sil164_drv.c  |  3 ++-
>  drivers/gpu/drm/nouveau/dispnv04/tvnv04.c            |  2 +-
>  .../gpu/drm/nouveau/include}/i2c/ch7006.h            |  0
>  .../gpu/drm/nouveau/include}/i2c/sil164.h            |  0
>  12 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kconfig
> index 6f19e1c35e30b0e595c1a60628a6b8cf313fcabc..d5200f67958e68a8ec73401f1d3b79cbe0aa303d 100644
> --- a/drivers/gpu/drm/i2c/Kconfig
> +++ b/drivers/gpu/drm/i2c/Kconfig
> @@ -2,24 +2,6 @@
>  menu "I2C encoder or helper chips"
>       depends on DRM && DRM_KMS_HELPER && I2C
>  
> -config DRM_I2C_CH7006
> -	tristate "Chrontel ch7006 TV encoder"
> -	default m if DRM_NOUVEAU
> -	help
> -	  Support for Chrontel ch7006 and similar TV encoders, found
> -	  on some nVidia video cards.
> -
> -	  This driver is currently only useful if you're also using
> -	  the nouveau driver.
> -
> -config DRM_I2C_SIL164
> -	tristate "Silicon Image sil164 TMDS transmitter"
> -	default m if DRM_NOUVEAU
> -	help
> -	  Support for sil164 and similar single-link (or dual-link
> -	  when used in pairs) TMDS transmitters, used in some nVidia
> -	  video cards.
> -
>  config DRM_I2C_NXP_TDA998X
>  	tristate "NXP Semiconductors TDA998X HDMI encoder"
>  	default m if DRM_TILCDC
> diff --git a/drivers/gpu/drm/i2c/Makefile b/drivers/gpu/drm/i2c/Makefile
> index a962f6f085686674ed33010345730db776815ebe..31fd35527d99d7eb23851d290175a3ff0c756772 100644
> --- a/drivers/gpu/drm/i2c/Makefile
> +++ b/drivers/gpu/drm/i2c/Makefile
> @@ -1,10 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ch7006-y := ch7006_drv.o ch7006_mode.o
> -obj-$(CONFIG_DRM_I2C_CH7006) += ch7006.o
> -
> -sil164-y := sil164_drv.o
> -obj-$(CONFIG_DRM_I2C_SIL164) += sil164.o
> -
>  tda998x-y := tda998x_drv.o
>  obj-$(CONFIG_DRM_I2C_NXP_TDA998X) += tda998x.o
>  obj-$(CONFIG_DRM_I2C_NXP_TDA9950) += tda9950.o
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index ce840300578d8a4011c448b61caf830cef3805bf..4cffac26f90ae6130ef30ba389b2a8c9b732058c 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -109,3 +109,23 @@ config DRM_NOUVEAU_GSP_DEFAULT
>  	help
>  	  Say Y here if you want to use the GSP codepaths by default on
>  	  Turing and Ampere GPUs.
> +
> +config DRM_NOUVEAU_CH7006

You need to update the defconfigs files to rename the Kconfig symbols there
too.

> +	tristate "Chrontel ch7006 TV encoder"
> +	depends on DRM_NOUVEAU
> +	default m
> +	help
> +	  Support for Chrontel ch7006 and similar TV encoders, found
> +	  on some nVidia video cards.
> +
> +	  This driver is currently only useful if you're also using
> +	  the nouveau driver.
> +
> +config DRM_NOUVEAU_SIL164
> +	tristate "Silicon Image sil164 TMDS transmitter"
> +	depends on DRM_NOUVEAU
> +	default m
> +	help
> +	  Support for sil164 and similar single-link (or dual-link
> +	  when used in pairs) TMDS transmitters, used in some nVidia
> +	  video cards.
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/Kbuild b/drivers/gpu/drm/nouveau/dispnv04/Kbuild
> index 975c4e2269366d57e928eedbbbc669d24744379f..949802882ebd53c15e124c218a092af9693d36bc 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/Kbuild
> +++ b/drivers/gpu/drm/nouveau/dispnv04/Kbuild
> @@ -10,3 +10,5 @@ nouveau-y += dispnv04/overlay.o
>  nouveau-y += dispnv04/tvmodesnv17.o
>  nouveau-y += dispnv04/tvnv04.o
>  nouveau-y += dispnv04/tvnv17.o
> +
> +include $(src)/dispnv04/i2c/Kbuild

I don't see this file being added in this series.

> diff --git a/drivers/gpu/drm/nouveau/dispnv04/dfp.c b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
> index 504c421aa176ef3d944592a0109cb72e21fd47b7..28a42ab5cb900ebe8a526e154f9e90598333356c 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/dfp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
> @@ -35,7 +35,7 @@
>  #include "hw.h"
>  #include "nvreg.h"
>  
> -#include <drm/i2c/sil164.h>
> +#include <i2c/sil164.h>
>  
>  #include <subdev/i2c.h>
>  
> diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
> similarity index 100%
> rename from drivers/gpu/drm/i2c/ch7006_drv.c
> rename to drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
> diff --git a/drivers/gpu/drm/i2c/ch7006_mode.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_mode.c
> similarity index 100%
> rename from drivers/gpu/drm/i2c/ch7006_mode.c
> rename to drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_mode.c
> diff --git a/drivers/gpu/drm/i2c/ch7006_priv.h b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h
> similarity index 99%
> rename from drivers/gpu/drm/i2c/ch7006_priv.h
> rename to drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h
> index 052bdc48a339df47073ab305f224f96c8630d66c..c66ca7f525034bb9fd113c5edf10c371a01c3c79 100644
> --- a/drivers/gpu/drm/i2c/ch7006_priv.h
> +++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h
> @@ -29,7 +29,8 @@
>  
>  #include <drm/drm_encoder_slave.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/i2c/ch7006.h>
> +
> +#include <i2c/ch7006.h>
>  
>  typedef int64_t fixed;
>  #define fixed1 (1LL << 32)
> diff --git a/drivers/gpu/drm/i2c/sil164_drv.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
> similarity index 99%
> rename from drivers/gpu/drm/i2c/sil164_drv.c
> rename to drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
> index ff23422727fce290a188e495d343e32bc2c373ec..74fc961c0d0de06f1fe8dd93d351452cd20cead7 100644
> --- a/drivers/gpu/drm/i2c/sil164_drv.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
> @@ -30,7 +30,8 @@
>  #include <drm/drm_encoder_slave.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/i2c/sil164.h>
> +
> +#include <i2c/sil164.h>
>  
>  struct sil164_priv {
>  	struct sil164_encoder_params config;
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv04.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv04.c
> index d3014027a8122be499b85459b038fdcce5800720..67f3e0ac0e109b223ca8ec4ddc4e688247373b2e 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv04.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv04.c
> @@ -32,7 +32,7 @@
>  #include "hw.h"
>  #include <drm/drm_modeset_helper_vtables.h>
>  
> -#include <drm/i2c/ch7006.h>
> +#include <i2c/ch7006.h>
>  
>  static struct nvkm_i2c_bus_probe nv04_tv_encoder_info[] = {
>  	{
> diff --git a/include/drm/i2c/ch7006.h b/drivers/gpu/drm/nouveau/include/i2c/ch7006.h
> similarity index 100%
> rename from include/drm/i2c/ch7006.h
> rename to drivers/gpu/drm/nouveau/include/i2c/ch7006.h
> diff --git a/include/drm/i2c/sil164.h b/drivers/gpu/drm/nouveau/include/i2c/sil164.h
> similarity index 100%
> rename from include/drm/i2c/sil164.h
> rename to drivers/gpu/drm/nouveau/include/i2c/sil164.h
> 

-- 
Regards,

Laurent Pinchart

