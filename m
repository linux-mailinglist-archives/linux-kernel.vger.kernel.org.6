Return-Path: <linux-kernel+bounces-294255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C13958B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3260A1F22268
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59A19E7F5;
	Tue, 20 Aug 2024 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdbVdOaY"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C419599C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167715; cv=none; b=FjKYKw60xafaJO+kjJrSyRmPCa3/VQA7L63ClACh0PMm7vf0EzDehYxEUdk0W6lahbqUUQtYfX64cpaQ68f2uTb3PU+NPGTzgkzNyEFZHOVRJkk1pAvjQ/WbZBXkdVtcgfDWFTqsPkvsc5rMRSfhfMsdZj6fyqc9USJgSR9FDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167715; c=relaxed/simple;
	bh=9L6gWacdguIrHq4z9RfaKMaPlPWDG1RDwhNfkl3aRbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+/nXkzXVFZxfVLWEgZlgP1IYgCstC1NnMKdlKKKOMkw1vGGUvt9eSSeNN1fVhuHK5sdfSUm7NFupiuPY4bmvZRRIdGUhydj5x781Vo1ectZtMZXxTqh3nYpT/ppy8LpJ1EGyxO9bp/0xpYX432E79EAGfKp5vYPkbJwl3XnFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdbVdOaY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42808071810so45712105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724167712; x=1724772512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIrlCuLTaxo8WrD54SgqcX7G7Cr01d8R61u5rpHn5/c=;
        b=OdbVdOaYIYMPANRcJLn+PjWOSAVXBjBUkUtPiUasdZycISZb+cQEGfBwH/MJ6c/M/9
         Qe3f7A40TAjn/Y8j5dpQ3B5QbsLB9IVYeAko75qANBpERq2dKbZzAyE6Xu9YPHkUWqNY
         rTgtTPyImjuEEhxzfVY82NidXw9NHV/Ae+HnRHg481KZutkYlnQA3kEZqIVIGZ3vjQP9
         oZIPCQA++gs3V9+9jj5CqGaiKC3p02b0JoS0i0LO9tl8qb0BmrliqdSAO2gCGbc8We5R
         VCt+zq7DfCPUnp5UKyY/L0h+EL+vpCOpwmmHTZ3PwfCwEbBa5uZcLpv/or1lCC69C7mg
         qG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167712; x=1724772512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIrlCuLTaxo8WrD54SgqcX7G7Cr01d8R61u5rpHn5/c=;
        b=kzjnN98on6mlIfiYZKgvMAebZzqv/b1Ju4PAmfI2XRB+UqRdGKen6zqA73YWmI08Ra
         XcsdFFmmrq/J3Lor7y+fXjNqD5VzveAT5lux3nZqWoejn2Crn3I4IY2wlrC9L3A0q8sR
         RBvA6Zv39Mjsy+YZrp3hu3+SFLcLY/Aenw+Y+oAIgIH1bX8xR0o0YvmUy0y2ekdvds+S
         YI/vUjQ5g/+EXGM1JMg7buzuwGsVRX8/dzGwUKcJgc0itTKurAHYTrr/Ilw05Lm36CfI
         tHJZPBcm1WuN7ihTiHiegLBheICEEFD9mkK+YsvBQnEU4WYpesX9SbKin1s62t9QB+k5
         CMBA==
X-Forwarded-Encrypted: i=1; AJvYcCWKr4uD9cMFUwbqHTTx4VuoOmglZIZHNrikkqTRBHBHB2jgX4JZ8EGMfKpAu6Vtv65S3M35Nc/gORWLQJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsu5f6rn7I1Ah4oMrtwUDqaFCkfzIu0Ml2sR+5TWGRxgz0jIxd
	KjwkjgLqYHqX7D4ZZ9CPb4ZJ3VpNjoJzmyDpnLDfejTj8ptZarQS
X-Google-Smtp-Source: AGHT+IHO4jvxhy4/S0vM6+zR2P6ICxauJ/zzVFcxMqcuJAHZx/AE4Tk5M9bdXHdy1ayBxRFeUsewqg==
X-Received: by 2002:a05:600c:4fc8:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-429ed7d1f39mr102340175e9.26.1724167711953;
        Tue, 20 Aug 2024 08:28:31 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35744sm199720365e9.23.2024.08.20.08.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:28:31 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	arthurgrillo@riseup.net,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	jeremie.dautheribes@bootlin.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	marcheu@google.com,
	melissa.srw@gmail.com,
	miquel.raynal@bootlin.com,
	mripard@kernel.org,
	nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com,
	seanpaul@google.com,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RFC 2/6] drm/vkms: Extract vkms_writeback header
Date: Tue, 20 Aug 2024 17:28:28 +0200
Message-ID: <20240820152829.2825-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-split-headers-v1-2-51712f088f5d@bootlin.com>
References: <20240814-google-split-headers-v1-2-51712f088f5d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> The vkms writeback functions are defined in a different .c, so
> make the same thing for the function declaration in the headers and create
> vkms_writeback.h.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_composer.c  |  1 +
>  drivers/gpu/drm/vkms/vkms_drv.h       | 10 ----------
>  drivers/gpu/drm/vkms/vkms_formats.c   |  2 +-
>  drivers/gpu/drm/vkms/vkms_output.c    |  2 ++
>  drivers/gpu/drm/vkms/vkms_writeback.c |  2 ++
>  drivers/gpu/drm/vkms/vkms_writeback.h | 20 ++++++++++++++++++++
>  6 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index f0cae142ac22..825011f696ee 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -12,6 +12,7 @@
>  #include <linux/minmax.h>
>  
>  #include "vkms_drv.h"
> +#include "vkms_writeback.h"
>  
>  static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
>  {
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 0db443924a15..46daa2fab6e8 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -46,13 +46,6 @@ struct vkms_frame_info {
>  };
>  
>  
> -struct vkms_writeback_job {
> -	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
> -	struct vkms_frame_info wb_frame_info;
> -	pixel_write_line_t pixel_write;
> -};
> -
> -
>  struct vkms_plane_state;
>  
>  
> @@ -225,7 +218,4 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
>  void vkms_composer_worker(struct work_struct *work);
>  void vkms_set_composer(struct vkms_output *out, bool enabled);
>  
> -/* Writeback */
> -int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
> -
>  #endif /* _VKMS_DRV_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 5ab84801d8da..cbfa7943e948 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -11,7 +11,7 @@
>  
>  #include <kunit/visibility.h>
>  
> -#include "vkms_drv.h"
> +#include "vkms_writeback.h"
>  #include "vkms_formats.h"

Nit: Keep sorted alphabetically

>  /**
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 36db2c8923cb..0c55682337a4 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -5,6 +5,8 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_probe_helper.h>
>  
> +#include "vkms_writeback.h"
> +
>  static const struct drm_connector_funcs vkms_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 7e0302c0830c..4a830a4c4d64 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -10,8 +10,10 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_framebuffer.h>
>  
>  #include "vkms_drv.h"
> +#include "vkms_writeback.h"
>  #include "vkms_formats.h"

The same here

>  static const u32 vkms_wb_formats[] = {
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.h b/drivers/gpu/drm/vkms/vkms_writeback.h
> new file mode 100644
> index 000000000000..70f0c4c26c23
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _VKMS_WRITEBACK_H
> +#define _VKMS_WRITEBACK_H

The style for guards used in the other files is:

#ifndef _VKMS_WRITEBACK_H_
#define _VKMS_WRITEBACK_H_

> +
> +#include "vkms_drv.h"
> +#include "vkms_formats.h"
> +
> +struct vkms_crtc;
> +
> +struct vkms_writeback_job {
> +	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
> +	struct vkms_frame_info wb_frame_info;
> +	pixel_write_line_t pixel_write;
> +};
> +
> +/* Writeback */
> +int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
> +
> +#endif //_VKMS_WRITEBACK_H

And here a /* */ comment is used:

#endif /* _VKMS_WRITEBACK_H_ */

Best wishes,
Jose

