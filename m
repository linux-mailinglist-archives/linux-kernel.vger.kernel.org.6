Return-Path: <linux-kernel+bounces-294261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25045958B57
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E406B2246D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA051ABEAD;
	Tue, 20 Aug 2024 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do3etp91"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016C19408D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167808; cv=none; b=cvunf4opm8KWKX9KYjeArh+ToEvToLBPT9ROlI4RvK+Xi6QNYTbwqr+rLzzkgQ6FAun5Lr2uNPNEetb5rP+LgrPA/n0a1bBa634Biy6EfWvaVSoUXEJHWZyHRRB7l5bf9FYISUyAYCRkOlt/X37nM3jFoKSAInOtF2TqKVPYbgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167808; c=relaxed/simple;
	bh=IGooR9EsHv5en/61/k+Nu2NQzFQVcY/4tMr129dDOao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsVbL0UsbiEGTOah/jVOS2VwXMy9WIQ8qCROgQBycTpWmdcBm1JrOS3qhieV4c70BiPIXHkpogaGehc6MTa6gSv1yoHH5J4qV2U/SmjeziXUY0NfiSFKOZKceWK0bDAito+ioCGF3bsgQc0GAMrCcYhsS5MZZaI8z7Q6GFIczWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do3etp91; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42816ca797fso46650845e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724167805; x=1724772605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEq7NMppy1gt4NfpoToKq8O2NR/NFez+l+dfZydtA2U=;
        b=do3etp91Op0ESOKS/4ob+PjOZqe+8mTLesgOw0Go1NEphk2lfUP8rc95RHoUgeaEt/
         AqhamefZ44R4L8JWQMeYittTD/5ibEBoxftVJA25gwlOlcuw0cGBF3PI7+Bq3kQBAma0
         qhSe2XQKu+lHTpqk9zlz+T+/YqhtuZf02L12KGaMy5mIdjz4YGhlNa8nwcZuOuroCDfW
         aHMg+/VPwcTtFfDGAsIRLtgBc3wnk5OgLBWBYDTNKy5dG8lhxyeRhwhlJyfh1nuRRcTN
         l9N3W5iZn31lHGiSzTpYAKcWNZ/SaeKyQcNF+HrIGfv1Wlz/iWB4d0349cAwyo5I5u/e
         4qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167805; x=1724772605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEq7NMppy1gt4NfpoToKq8O2NR/NFez+l+dfZydtA2U=;
        b=oC5j21Xeiemz2VV1rjUp4OpVsDdcTYRcPV44gtHVlwxbIPa6GL5L0jCiaRXx/gisEI
         xVn5OWfkRZcJ4thTc+NcNyLlrpKD/Wrm2Gqs/t87MkaWSXbObL9wrG+6C4rSU0kd8QZl
         EWyHaGwOqMNJoW2pXyriBfGxrG0Z786Lmz9GGPb7rAKZliE+Aa/mm+8DuRXnM1RfdgN3
         5mwP0FntKXVL1G+W0hpKslOszFZRIXJzkyokYbYw0riaMuFlYqC+XpoVYqUH2OtMw0HI
         u8fQndmpzgZk7sWErXRWzhK7ApoK+mE4QT1gIx0lWN4QhSW9WChaA6Nj1kPlbpZu4azl
         qyBg==
X-Forwarded-Encrypted: i=1; AJvYcCV5w61fIwefpDUBc7xHL/95haug4jObaG5rokpuVSVYI6lZEq6i1QuSAFTPP07t22XB1YZAyEYe1LglQ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTYTyu+tY7GOQt67dK0Rsm8ot0r2D406SBEX7sB3Rc2PTupWUw
	jV0CZ0qvQt8FFmYdXpjt79ymgsWurjF3+1GUDCywL+nBXOY939IS
X-Google-Smtp-Source: AGHT+IH5v6j/VMUOZmSJJRpKuoVYPkrfm7/W88if2ic7Mu0gZz/aOczMza3ZgepMjX3o/JrPTJ/1Yw==
X-Received: by 2002:a05:600c:450b:b0:428:640:c1b1 with SMTP id 5b1f17b1804b1-429ed7c0944mr96908305e9.17.1724167804728;
        Tue, 20 Aug 2024 08:30:04 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5a9sm198247505e9.43.2024.08.20.08.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:30:03 -0700 (PDT)
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
Subject: [PATCH RFC 6/6] drm/vkms: Extract vkms_composer header
Date: Tue, 20 Aug 2024 17:30:00 +0200
Message-ID: <20240820153001.2899-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-split-headers-v1-6-51712f088f5d@bootlin.com>
References: <20240814-google-split-headers-v1-6-51712f088f5d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> The vkms composer functions are defined in a different .c, so make the
> same thing for the function declaration in the headers and create
> vkms_composer.h.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_composer.c  |  2 ++
>  drivers/gpu/drm/vkms/vkms_composer.h  | 18 ++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_crtc.c      |  1 +
>  drivers/gpu/drm/vkms/vkms_drv.h       | 11 -----------
>  drivers/gpu/drm/vkms/vkms_writeback.c |  1 +
>  5 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 139d249454c4..15ef07ed304e 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -10,7 +10,9 @@
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_vblank.h>
>  #include <linux/minmax.h>
> +#include <drm/drm_print.h>
>  
> +#include "vkms_composer.h"
>  #include "vkms_crtc.h"
>  #include "vkms_writeback.h"
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.h b/drivers/gpu/drm/vkms/vkms_composer.h
> new file mode 100644
> index 000000000000..91b33af1e013
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/vkms_composer.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _VKMS_COMPOSER_H
> +#define _VKMS_COMPOSER_H

#ifndef _VKMS_COMPOSER_H_
#define _VKMS_COMPOSER_H_

> +#include "vkms_drv.h"
> +#include "vkms_crtc.h"
> +
> +void vkms_composer_worker(struct work_struct *work);
> +void vkms_set_composer(struct vkms_output *out, bool enabled);
> +
> +/* CRC Support */
> +const char *const *vkms_get_crc_sources(struct drm_crtc *crtc, size_t *count);
> +int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name);
> +int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
> +			   size_t *values_cnt);
> +
> +#endif //_VKMS_COMPOSER_H

#endif /* _VKMS_COMPOSER_H_ */

> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index cb6e49a86745..6fae43932b60 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -9,6 +9,7 @@
>  #include <drm/drm_print.h>
>  
>  #include "vkms_crtc.h"
> +#include "vkms_composer.h"
>  #include "vkms_plane.h"

+#include "vkms_composer.h"
 #include "vkms_crtc.h"
 #include "vkms_plane.h"

>  static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 943ad55e0172..f74a5c2045f9 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -106,15 +106,4 @@ struct vkms_device {
>  
>  int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index);
>  
> -/* CRC Support */
> -const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
> -					size_t *count);
> -int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name);
> -int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
> -			   size_t *values_cnt);
> -
> -/* Composer Support */
> -void vkms_composer_worker(struct work_struct *work);
> -void vkms_set_composer(struct vkms_output *out, bool enabled);
> -
>  #endif /* _VKMS_DRV_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 48f3f7f2e2a4..5e75880a5845 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -15,6 +15,7 @@
>  #include "vkms_writeback.h"
>  #include "vkms_crtc.h"
>  #include "vkms_formats.h"
> +#include "vkms_composer.h"

 #include "vkms_crtc.h"
 +#include "vkms_composer.h"
 #include "vkms_formats.h"

>  static const u32 vkms_wb_formats[] = {
>  	DRM_FORMAT_ARGB8888,
> 

