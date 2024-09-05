Return-Path: <linux-kernel+bounces-317052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F9196D8A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D244B22536
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646619B3C1;
	Thu,  5 Sep 2024 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiYEv8eB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6F199395
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539624; cv=none; b=f9RRnjCoe+DYKSmrtsKrBqW4wjNwxtZHXMhDEqWYC38jscMWOMY4tGHXNofl2R2F3Y9821/21nade2+IZWSFc7Vn9/IVsizaPgXiLpQELcnddiYWwyZenyY1Q8n3y1bksJH57TfGUW4ongcVS/olBOZABGlSAlcTlp/+47LjwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539624; c=relaxed/simple;
	bh=xIwxP87qxh9RVgm0/rrqDpZ09n2YYoaz3LXY2vZkBK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlVYf2DcGBg/qBukD65C0NvqJmfPCkM9wWSuSB3p5vs/Q4KwSyruS7ELIh1nbwPKuvy4HZ1nSm7kdK//+a3Dv96LW33DE/4uwX6x5oBVGbtVhU7LKWK0TW5Q36hu95D7RzYrm2Y/iyzisGY/Ng5AXAXniqGLaLlOJjYWqbOzhJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiYEv8eB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42c5347b2f7so6039575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725539619; x=1726144419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94GbVFnsicioIdyF3xHn7JXRu2g3C+MwaoqJeRd73vg=;
        b=eiYEv8eBMRqzu0gpx+h5JvIxlOkfkEHXO2n/wxXFZrS9wXSwxSxF055nCQYXcQ/DpL
         kRZXCE9WW9TG8X42VLFbYAAjNCQwCMI1g2PB6CHqo93Vrl0WD6zyy0j5cwz51vTCKaIs
         mJKwkGC9NUIL4n+5lNj8uljkWZDr0NVs+bAuxJWEAfodtK1k3m0Qe/zSB2ME4UhtdmP8
         zoffWUDldqPYPL0hz6wXw1w5HMM340+Ee1hhVX4pxdPOdF33ch0mUSE+82CzhffxXtm0
         MK3lbWWz4McOExhZatmr4EBX6FaTqgOHB9ZpY7VdvGtky7iNcAdTv2QkgygpwUm4zWWy
         NYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539619; x=1726144419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94GbVFnsicioIdyF3xHn7JXRu2g3C+MwaoqJeRd73vg=;
        b=OghMsaugYiVWrRyTYxWn9+aWsvkJJ9ySrxoA3bcK+DaMj4hgdn89iEovU6BPUK4Kln
         kZVbSw5Z5Mb7xIJ+YzXGuX4IPM9sjO/D4r2LWE/Mmon01uKHDF/dnkwWxzZlESscxixC
         ewEFL5CetlsKOHTMYOR+dcgoZeRU7JZdM9mfEroS/8cQQ0177LOh8T9EB6eDhFUbUIV4
         r22Ksu3S33wH3uUuHcS/nLG8bWpX+xrY7JUhv4EffavE4zYC1oeicW96+17380JrCyW8
         e58X7Vlv5NitOwui0/eNsFH3hiad4t7AcC82Zug3fYMiXNPPwk+FF1ZAyNKeqpX+NAi8
         9Kqg==
X-Forwarded-Encrypted: i=1; AJvYcCXwHeULNA+2BgJ88KW58phT3YAErzjTzDxutQy1RRrZtx2kSMVJ9GAJ32tqCUXPTf+MW+NS0PuhAIEh2yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKU0a0kEJqnYC2rI7GBLgHIQDqWuuP2y2s3HTqbxDOfCimxXvV
	RVC/KyV624wEkVbh+QtQroAWtGlRFf7yaUkKZ49+PLMjg5nfPJ32
X-Google-Smtp-Source: AGHT+IGOJib7VqLZnZxrvUPVjTeAxyAAiwaW7QM0nUABaG4TCuPov69LrUP3Bp8P8DmkUM+Su7TsEQ==
X-Received: by 2002:a05:600c:310b:b0:426:627d:5542 with SMTP id 5b1f17b1804b1-42bb01e6c05mr173939965e9.28.1725539619461;
        Thu, 05 Sep 2024 05:33:39 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c23d6a38sm13542443f8f.38.2024.09.05.05.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:33:39 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	arthurgrillo@riseup.net,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	jeremie.dautheribes@bootlin.com,
	jose.exposito89@gmail.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	melissa.srw@gmail.com,
	miquel.raynal@bootlin.com,
	mripard@kernel.org,
	nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com,
	seanpaul@google.com,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
Subject: [PATCH RFC 03/15] drm/vkms: Extract vkms_config header
Date: Thu,  5 Sep 2024 14:33:36 +0200
Message-ID: <20240905123338.3061-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-3-6e179abf9fd4@bootlin.com>
References: <20240814-google-remove-crtc-index-from-parameter-v1-3-6e179abf9fd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Creating a new vkms_config structure will be more complex once we
> start adding more options.
> 
> Extract the vkms_config structure to its own header and source files
> and add functions to create and delete a vkms_config and to initialize
> debugfs.
> 
> Refactor, no functional changes.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> [Changes: Cherry picked and conflict solve]
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/gpu/drm/vkms/Makefile      |  3 ++-
>  drivers/gpu/drm/vkms/vkms_config.c | 45 ++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_config.h | 32 +++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_drv.c    | 41 ++++++++++------------------------
>  drivers/gpu/drm/vkms/vkms_drv.h    | 15 +------------
>  5 files changed, 91 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
> index 8d3e46dde635..2b6db5870b97 100644
> --- a/drivers/gpu/drm/vkms/Makefile
> +++ b/drivers/gpu/drm/vkms/Makefile
> @@ -6,7 +6,8 @@ vkms-y := \
>  	vkms_formats.o \
>  	vkms_crtc.o \
>  	vkms_composer.o \
> -	vkms_writeback.o
> +	vkms_writeback.o \
> +	vkms_config.o
>  
>  obj-$(CONFIG_DRM_VKMS) += vkms.o
>  obj-$(CONFIG_DRM_VKMS_KUNIT_TESTS) += tests/
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> new file mode 100644
> index 000000000000..ad5d814e6e83
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <drm/drm_debugfs.h>
> +
> +#include "vkms_config.h"
> +#include "vkms_drv.h"

I believe there are some missing includes. In the patch of my
configfs series equivalent to this one I have:


#include <linux/slab.h>

#include <drm/drm_print.h>
#include <drm/drm_debugfs.h>

#include "vkms_config.h"
#include "vkms_drv.h"

> +
> +struct vkms_config *vkms_config_create(void)
> +{
> +	struct vkms_config *config;
> +
> +	config = kzalloc(sizeof(*config), GFP_KERNEL);
> +	if (!config)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return config;
> +}
> +
> +void vkms_config_destroy(struct vkms_config *config)
> +{
> +	kfree(config);
> +}
> +
> +static int vkms_config_show(struct seq_file *m, void *data)
> +{
> +	struct drm_debugfs_entry *entry = m->private;
> +	struct drm_device *dev = entry->dev;
> +	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
> +
> +	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
> +	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
> +	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
> +
> +	return 0;
> +}
> +
> +static const struct drm_debugfs_info vkms_config_debugfs_list[] = {
> +	{ "vkms_config", vkms_config_show, 0 },
> +};
> +
> +void vkms_config_register_debugfs(struct vkms_device *vkms_device)
> +{
> +	drm_debugfs_add_files(&vkms_device->drm, vkms_config_debugfs_list,
> +			      ARRAY_SIZE(vkms_config_debugfs_list));
> +}
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> new file mode 100644
> index 000000000000..b28483173874
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _VKMS_CONFIG_H
> +#define _VKMS_CONFIG_H

#ifndef _VKMS_CONFIG_H_
#define _VKMS_CONFIG_H_

> +
> +#include <linux/types.h>
> +#include "vkms_drv.h"

You can avoid this import by forward declaring "vkms_device":

struct vkms_device;

> +
> +/**
> + * struct vkms_config - General configuration for VKMS driver
> + *
> + * @writeback: If true, a writeback buffer can be attached to the CRTC
> + * @cursor: If true, a cursor plane is created in the VKMS device
> + * @overlay: If true, NUM_OVERLAY_PLANES will be created for the VKMS device
> + * @dev: Used to store the current vkms device. Only set when the device is instancied.
> + */
> +struct vkms_config {
> +	bool writeback;
> +	bool cursor;
> +	bool overlay;
> +	struct vkms_device *dev;
> +};
> +
> +/**
> + * vkms_config_register_debugfs() - Register the debugfs file to display current configuration
> + */
> +void vkms_config_register_debugfs(struct vkms_device *vkms_device);
> +
> +struct vkms_config *vkms_config_create(void);
> +void vkms_config_destroy(struct vkms_config *config);
> +
> +#endif //_VKMS_CONFIG_H

#endif /* _VKMS_CONFIG_H_ */

> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index e71b45fcb9b8..dbdb1f565a8f 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -28,6 +28,7 @@
>  
>  #include "vkms_drv.h"
>  #include "vkms_crtc.h"
> +#include "vkms_config.h"
>  
>  #include <drm/drm_print.h>
>  #include <drm/drm_debugfs.h>

And here you can drop:

#include <drm/drm_print.h>
#include <drm/drm_debugfs.h>

> @@ -85,22 +86,6 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
>  	drm_atomic_helper_cleanup_planes(dev, old_state);
>  }
>  
> -static int vkms_config_show(struct seq_file *m, void *data)
> -{
> -	struct drm_debugfs_entry *entry = m->private;
> -	struct drm_device *dev = entry->dev;
> -	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
> -
> -	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
> -	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
> -	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
> -
> -	return 0;
> -}
> -
> -static const struct drm_debugfs_info vkms_config_debugfs_list[] = {
> -	{ "vkms_config", vkms_config_show, 0 },
> -};
>  
>  static const struct drm_driver vkms_driver = {
>  	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
> @@ -325,8 +310,7 @@ static int vkms_create(struct vkms_config *config)
>  	if (ret)
>  		goto out_unregister;
>  
> -	drm_debugfs_add_files(&vkms_device->drm, vkms_config_debugfs_list,
> -			      ARRAY_SIZE(vkms_config_debugfs_list));
> +	vkms_config_register_debugfs(vkms_device);
>  
>  	ret = drm_dev_register(&vkms_device->drm, 0);
>  	if (ret)
> @@ -344,21 +328,18 @@ static int vkms_create(struct vkms_config *config)
>  static int __init vkms_init(void)
>  {
>  	int ret;
> -	struct vkms_config *config;
> -
> -	config = kmalloc(sizeof(*config), GFP_KERNEL);
> -	if (!config)
> -		return -ENOMEM;
>  
> -	default_config = config;
> +	default_config = vkms_config_create();
> +	if (IS_ERR(default_config))
> +		return PTR_ERR(default_config);
>  
> -	config->cursor = enable_cursor;
> -	config->writeback = enable_writeback;
> -	config->overlay = enable_overlay;
> +	default_config->cursor = enable_cursor;
> +	default_config->writeback = enable_writeback;
> +	default_config->overlay = enable_overlay;
>  
> -	ret = vkms_create(config);
> +	ret = vkms_create(default_config);
>  	if (ret)
> -		kfree(config);
> +		vkms_config_destroy(default_config);
>  
>  	return ret;
>  }
> @@ -386,7 +367,7 @@ static void __exit vkms_exit(void)
>  	if (default_config->dev)
>  		vkms_destroy(default_config);
>  
> -	kfree(default_config);
> +	vkms_config_destroy(default_config);
>  }
>  
>  module_init(vkms_init);
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 08d0ef106e37..64574695f655 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -25,20 +25,7 @@
>  
>  #define VKMS_LUT_SIZE 256
>  
> -/**
> - * struct vkms_config - General configuration for VKMS driver
> - *
> - * @writeback: If true, a writeback buffer can be attached to the CRTC
> - * @cursor: If true, a cursor plane is created in the VKMS device
> - * @overlay: If true, NUM_OVERLAY_PLANES will be created for the VKMS device
> - * @dev: Used to store the current vkms device. Only set when the device is instancied.
> - */
> -struct vkms_config {
> -	bool writeback;
> -	bool cursor;
> -	bool overlay;
> -	struct vkms_device *dev;
> -};
> +struct vkms_config;
>  
>  /**
>   * struct vkms_device - Description of a vkms device
> 

