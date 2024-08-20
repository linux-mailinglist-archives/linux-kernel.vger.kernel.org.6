Return-Path: <linux-kernel+bounces-294257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CDF958B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC8B24079
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD18190473;
	Tue, 20 Aug 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzGfVl2C"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66319190664
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167740; cv=none; b=fP9H3+ynILOcJobFgx5bosr38HDP7KMTsu7a91oDZ/jwMV0wi/daLQKqYEKJc4MemgICLMaQQrGoaVC3brvkSXKAJs40lp3H8q0+XKCGJtpvJ5Z/huk0wtTDpZGsT/Ux2Bx7PENCqSuMmx82N9QN57JXv8tP7p1XJD/MyjxTwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167740; c=relaxed/simple;
	bh=+Chvz1zItwb24Gu+IYgi/O/RrmyI09cy3QIecgGnO3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sckzm2ClM+Z90ft52qBLQHeFh6FFgSVsijHWWWfmIeZJUwU9JYIHqjd3Zg7DN7+qVoK9cWNl1CfXWVGW9mSgoFBodwPxzYul0h4wkjgAXeoylFwMMzLadZt/NJ4oBsKFArXt++KkyAFD6eBjYGIZ7/9U7wInj3TBod6UiPF/IYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzGfVl2C; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso62229255e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724167737; x=1724772537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ8nwipYzQ9k/1PPzTLrMyjUCKSjsTZBYLAPEH6Cyy0=;
        b=QzGfVl2C0hJfFB/EewNdv1glWH16tx1uoL3ceu+PZVCtBINM+vDyPdksY7yO6F2Cop
         WiC0eORQ5kfh+vk1X2+S3QuxjBzr1jiVAtUNSukaz5hjOJkvWNgmPf1VlndA8Sxquht8
         Esf6+cZQ56S00onieR8oaFPBs5OMA6v0d04r5n65pmpsYZB+w4hAoULL2PcKEkFDJJpn
         89ADpSTNOWRWA2jUkWzr3d1LJB8QzWA26fptFM1K8uQw/wDpYNuL0j5MSJdP/YsSWnf7
         h6NP7yE/OjoXHnGbUwg9GFrBe5j9bVFrCT254oaHGvREVhxH09u1KYpl3RzXC5QSLhL4
         Hk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167737; x=1724772537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ8nwipYzQ9k/1PPzTLrMyjUCKSjsTZBYLAPEH6Cyy0=;
        b=NEbsoMXHK/L9weMG1gRFvHJ+aD/yeHlYGgbKpu5IhlJ7+N2kbIZb2gwHNq/CzXZJvf
         qkScH1QOjUcDm+0dvwO7M6BFh3xUJMWLqQ14fgpWTMjjYETKvW7y51RHwzLanYt1C6/N
         W0eVb2onLXPGBCvUajWwSMtu6s2eKd4we1PC1A0l3I+TLDjpW+YBrcw+WfXn+6tbYcLr
         pWKEuCHSI7Yy6xnYNHOY6X0+nHYzzxtT5ZJ241XYACY3qENnEikXoMsj/ULBK2blDwzw
         PKliioG53C5S/cqZrO7YSgFG5u5bUL9Nsi/Hh7vGOVd+Wd//1UGb9ENBSOA3ECVfjH7t
         bymQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkftuvuZeT4YpToIhI4CR4PwtfFTnm/VihYgPF1CyothcNn215W6i/+WGsEtr31Gb7VgpRG8XHcO2B7EGLYWXinzo8HtXSWHkvzQGp
X-Gm-Message-State: AOJu0YxHhB7PLOEE/dOR1GOsdA35pyylqcpRNYFSWffNWZGQ2qxWxp55
	zIavMxp1aSKncdYYHTcTeZlj3uCN3z13U2XxsqlSAenVOrPD7dbP
X-Google-Smtp-Source: AGHT+IFgY4oeQnI696QoVkI47ToEkzlQOvxgC4s/31CTEsFThLvQ454i3v0haJ2fZh8PapXdAPNreQ==
X-Received: by 2002:a05:600c:4506:b0:426:5c81:2538 with SMTP id 5b1f17b1804b1-429ed7955e5mr126993645e9.14.1724167736366;
        Tue, 20 Aug 2024 08:28:56 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985ae26sm13368343f8f.55.2024.08.20.08.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:28:56 -0700 (PDT)
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
Subject: [PATCH RFC 3/6] drm/vkms: Extract vkms_plane header
Date: Tue, 20 Aug 2024 17:28:50 +0200
Message-ID: <20240820152852.2843-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-split-headers-v1-3-51712f088f5d@bootlin.com>
References: <20240814-google-split-headers-v1-3-51712f088f5d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> In order to properly split vkms_output function, extract all
> its function to its own header.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c      |  2 ++
>  drivers/gpu/drm/vkms/vkms_drv.h       | 56 ------------------------------
>  drivers/gpu/drm/vkms/vkms_formats.c   |  3 +-
>  drivers/gpu/drm/vkms/vkms_output.c    |  2 +-
>  drivers/gpu/drm/vkms/vkms_plane.c     |  3 ++
>  drivers/gpu/drm/vkms/vkms_plane.h     | 65 +++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_writeback.c |  1 -
>  drivers/gpu/drm/vkms/vkms_writeback.h |  1 +
>  8 files changed, 74 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 06e28305d660..6a4de8f7a678 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -6,8 +6,10 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
> +#include <drm/drm_print.h>

Seems unrelated to this change? Anyway, it'd be nice to place it after
drm_probe_helper.h.

>  
>  #include "vkms_drv.h"
> +#include "vkms_plane.h"
>  
>  static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
>  {
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 46daa2fab6e8..ea73f01fcc74 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -27,48 +27,6 @@
>  
>  #define VKMS_LUT_SIZE 256
>  
> -/**
> - * struct vkms_frame_info - Structure to store the state of a frame
> - *
> - * @fb: backing drm framebuffer
> - * @src: source rectangle of this frame in the source framebuffer, stored in 16.16 fixed-point form
> - * @dst: destination rectangle in the crtc buffer, stored in whole pixel units
> - * @map: see drm_shadow_plane_state@data
> - * @rotation: rotation applied to the source.
> - *
> - * @src and @dst should have the same size modulo the rotation.
> - */
> -struct vkms_frame_info {
> -	struct drm_framebuffer *fb;
> -	struct drm_rect src, dst;
> -	struct iosys_map map[DRM_FORMAT_MAX_PLANES];
> -	unsigned int rotation;
> -};
> -
> -
> -struct vkms_plane_state;

I guess this forward declaration was added by a previous patch in a different
series, but it is not required. Mentioning just in case you'd like to fix it in
the correct patch.

> -
> -
> -
> -/**
> - * struct vkms_plane_state - Driver specific plane state
> - * @base: base plane state
> - * @frame_info: data required for composing computation
> - * @pixel_read_line: function to read a pixel line in this plane. The creator of a
> - *		     struct vkms_plane_state must ensure that this pointer is valid
> - * @conversion_matrix: matrix used for yuv formats to convert to rgb
> - */
> -struct vkms_plane_state {
> -	struct drm_shadow_plane_state base;
> -	struct vkms_frame_info *frame_info;
> -	pixel_read_line_t pixel_read_line;
> -	struct conversion_matrix conversion_matrix;
> -};
> -
> -struct vkms_plane {
> -	struct drm_plane base;
> -};
> -
>  /**
>   * struct vkms_crtc_state - Driver specific CRTC state
>   *
> @@ -174,9 +132,6 @@ struct vkms_device {
>  #define to_vkms_crtc_state(target)\
>  	container_of(target, struct vkms_crtc_state, base)
>  
> -#define to_vkms_plane_state(target)\
> -	container_of(target, struct vkms_plane_state, base.base)
> -
>  /**
>   * vkms_crtc_init() - Initialize a crtc for vkms
>   * @dev: drm_device associated with the vkms buffer
> @@ -196,17 +151,6 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
>  
>  int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index);
>  
> -/**
> - * vkms_plane_init() - Initialize a plane
> - *
> - * @vkmsdev: vkms device containing the plane
> - * @type: type of plane to initialize
> - * @possible_crtc_index: Crtc which can be attached to the plane. The caller must ensure that
> - * possible_crtc_index is positive and less or equals to 31.
> - */
> -struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				   enum drm_plane_type type, int possible_crtc_index);
> -
>  /* CRC Support */
>  const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
>  					size_t *count);
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index cbfa7943e948..4e8494d4ade4 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -11,8 +11,9 @@
>  
>  #include <kunit/visibility.h>
>  
> -#include "vkms_writeback.h"
> +#include "vkms_plane.h"
>  #include "vkms_formats.h"
> +#include "vkms_writeback.h"

The #include "vkms_writeback.h" was added by the previous patch. We can avoid
moving it here by adding it at the bottom. plane.h should go after formats.h.

>  
>  /**
>   * packed_pixels_offset() - Get the offset of the block containing the pixel at coordinates x/y
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 0c55682337a4..09fcf242ecf7 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -1,11 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  
> -#include "vkms_drv.h"
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_probe_helper.h>
>  
>  #include "vkms_writeback.h"
> +#include "vkms_plane.h"

#include "vkms_plane.h"
#include "vkms_writeback.h"

>  
>  static const struct drm_connector_funcs vkms_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 9d85464ee0e9..de2c83e1b02c 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -8,9 +8,12 @@
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_gem_atomic_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_print.h>

 #include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_print.h>

>  
>  #include "vkms_drv.h"
>  #include "vkms_formats.h"
> +#include "vkms_plane.h"
> 
>  static const u32 vkms_formats[] = {
>  	DRM_FORMAT_ARGB8888,
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.h b/drivers/gpu/drm/vkms/vkms_plane.h
> new file mode 100644
> index 000000000000..161b44da0240
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/vkms_plane.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _VKMS_PLANE_H
> +#define _VKMS_PLANE_H

#ifndef _VKMS_PLANE_H_
#define _VKMS_PLANE_H_

> +
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <linux/iosys-map.h>
> +
> +#include "vkms_drv.h"
> +#include "vkms_formats.h"

While including "vkms_drv.h" from other headers should be fine
> +
> +struct vkms_plane {
> +	struct drm_plane base;
> +};
> +
> +/**
> + * struct vkms_plane_state - Driver specific plane state
> + * @base: base plane state
> + * @frame_info: data required for composing computation
> + * @pixel_read_line: function to read a pixel line in this plane. The creator of a vkms_plane_state
> + * must ensure that this pointer is valid
> + * @conversion_matrix: matrix used for yuv formats to convert to rgb
> + */
> +struct vkms_plane_state {
> +	struct drm_shadow_plane_state base;
> +	struct vkms_frame_info *frame_info;
> +	pixel_read_line_t pixel_read_line;
> +	struct conversion_matrix conversion_matrix;
> +};
> +
> +/**
> + * struct vkms_frame_info - structure to store the state of a frame
> + *
> + * @fb: backing drm framebuffer
> + * @src: source rectangle of this frame in the source framebuffer, stored in 16.16 fixed-point form
> + * @dst: destination rectangle in the crtc buffer, stored in whole pixel units
> + * @map: see drm_shadow_plane_state@data
> + * @rotation: rotation applied to the source.
> + *
> + * @src and @dst should have the same size modulo the rotation.
> + */
> +struct vkms_frame_info {
> +	struct drm_framebuffer *fb;
> +	struct drm_rect src, dst;
> +	struct iosys_map map[DRM_FORMAT_MAX_PLANES];
> +	unsigned int rotation;
> +};
> +
> +/**
> + * vkms_plane_init() - Initialize a plane
> + *
> + * @vkmsdev: vkms device containing the plane
> + * @type: type of plane to initialize
> + * @possible_crtc_index: Crtc which can be attached to the plane. The caller must ensure that
> + * possible_crtc_index is positive and less or equals to 31.
> + */
> +struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> +				   enum drm_plane_type type, int possible_crtc_index);
> +
> +#define to_vkms_plane_state(target)\
> +	container_of(target, struct vkms_plane_state, base.base)
> +
> +#endif //_VKMS_PLANE_H

#endif /* _VKMS_PLANE_H_ */

> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 4a830a4c4d64..740d9e2f3d71 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -12,7 +12,6 @@
>  #include <drm/drm_gem_shmem_helper.h>
>  #include <drm/drm_framebuffer.h>
>  
> -#include "vkms_drv.h"
>  #include "vkms_writeback.h"
>  #include "vkms_formats.h"
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.h b/drivers/gpu/drm/vkms/vkms_writeback.h
> index 70f0c4c26c23..44dff15faff6 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.h
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.h
> @@ -5,6 +5,7 @@
>  
>  #include "vkms_drv.h"
>  #include "vkms_formats.h"
> +#include "vkms_plane.h"
>  
>  struct vkms_crtc;
>  
> 

