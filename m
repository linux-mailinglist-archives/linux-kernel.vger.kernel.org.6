Return-Path: <linux-kernel+bounces-413279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CF69D16D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34DAB28186
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEF61C1AB4;
	Mon, 18 Nov 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCJDINZJ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6A1C0DD6;
	Mon, 18 Nov 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949851; cv=none; b=dQgV2pHHWKD+LZMAjHdh0TZfU0uI3XxgWNT+o/DFCaENEgdnLiVfdgwepbqv028vPv1JMU9ZKdJ5HAjznBcjTWQOoDycfheGgg1QiSMr2S3tHFCCAKkNRve8TLSVzRhMvozUTiG+C9fXzxMlh8tVMnkMKwv4F8SpCLmXv8RBgBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949851; c=relaxed/simple;
	bh=JfJSjIE8G8QYFV2qClWR+0Dl2UfEu5wcwK1Ta7YaTp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYubviZ/TtLYJnTSH2tb9qoqk2HVbK6oTPMfB0yPUmgoxshCTpiHiucWPp0RDHhtxwTF22LZY6vuXWvjsi+3dmnRl7LtloPnFAIJ1RbhJzBA1hdJNdHkrSYx9RkDoiT/Y/SrOsHlIDmbI6fQhlUbeqaIyK4f9N6I4FYKtEburmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCJDINZJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4319399a411so40968375e9.2;
        Mon, 18 Nov 2024 09:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731949848; x=1732554648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMsBau+RNY/BQ9drs/seXkWHcU6HysTcpfy1mkYz62E=;
        b=GCJDINZJPfDq/Ge/51mU1A4OrDbZwUjjof4lpZ4W6xu3xeBtU2GrMQkLU3a/vu3i33
         Zs/WMzadBRV+OyEkzG1kTs2w5BZeQn5aDxDDHYLBtJenS4zBLK+PiuFfqPuvGRMix5XM
         7rRcgHaxGxD2UBBleqe58M/2EtC4EjAE6Ss/i7I9jZLTuoUwwHuxpWlNJoo3aSR1ByDj
         ApFDj30DUgPRuALtAorRSNN/oyL3xUkpR/SaYMlyuh7WowXK2n/4Uu/cUNdhZ7Nyx4yj
         04XPieIl/K4czDJWSnBYkPBHnv0sUc7jvNZbFcEWlnwXAVoJqeuHFOSFdYnWwZEDe/rI
         pA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949848; x=1732554648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMsBau+RNY/BQ9drs/seXkWHcU6HysTcpfy1mkYz62E=;
        b=xKgea59klHjgUK4IN8XmB8znGJExNw7XjMx0UPvmu2DJU4LHnG7drk+jL4jO6vnfk7
         3Do5pJPnhEY2Omvx9FDBIsN4l5WOq76nuEjQnxzQw6u1dxo0XvzneoMcz3UlIwcX0VCu
         c05Za8uxv+h8PHnRzPcJgx8fwhQgkOjG7jEJTj97uvvEgIEr5pdO6cHbp+BPXJQJ/QLr
         dxv6KjcyGGlWROLkIM/bG4JdUBEJZLaGsD/VyFVVsQDmyZXk+Os4Q+HW/UBEn8PlmHdX
         XLb+aENl2zjQMIK/u9O5SzHzVcqZwr49yfm2aje4X0g89IgenalmWo4iheGDwXildnx2
         9aXA==
X-Forwarded-Encrypted: i=1; AJvYcCUVrz5NVlezBmdGVVc/AAo5HyRWuRJeSjKbLSZBmwtGf1g12NlwbS1qL3w9krUiy7yV3uo3+IKF0i8=@vger.kernel.org, AJvYcCXalTERaiZ/4ttuxabjjzZcEAzM/gcGdtllw8a/mmJph/a2NhoXAv4BryH7ZB6b3CQvyZOugBnC08ofC4cE@vger.kernel.org
X-Gm-Message-State: AOJu0YyPo2C8bEgW2zYkefUvch04+JhD/9brfHvD5Bl1qgAW5XWqXNDZ
	Ztml5TYCehddr+ODbvQvz2++LRrQs5zuooiSL/zbj5m/DvwUSYan
X-Google-Smtp-Source: AGHT+IEmWeRgtUI4XZ0nOVHrQDr2gMtwhcNxdB0d8C+tnMK3cUO1eNocb36D2Hy8oEafoeECFHDjtg==
X-Received: by 2002:a05:600c:1c81:b0:432:a36b:d896 with SMTP id 5b1f17b1804b1-432df78c5a9mr99224175e9.26.1731949848076;
        Mon, 18 Nov 2024 09:10:48 -0800 (PST)
Received: from fedora.. ([213.94.25.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823a0e8f26sm7119834f8f.31.2024.11.18.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 09:10:47 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	arthurgrillo@riseup.net,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	helen.koike@collabora.com,
	jeremie.dautheribes@bootlin.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	marcheu@google.com,
	melissa.srw@gmail.com,
	miquel.raynal@bootlin.com,
	mripard@kernel.org,
	nicolejadeyee@google.com,
	pekka.paalanen@haloniitty.fi,
	rdunlap@infradead.org,
	rodrigosiqueiramelo@gmail.com,
	seanpaul@google.com,
	simona.vetter@ffwll.ch,
	simona@ffwll.ch,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
Subject: [PATCH v13 7/9] drm/vkms: Introduce pixel_read_direction enum
Date: Mon, 18 Nov 2024 18:10:45 +0100
Message-ID: <20241118171046.2861-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031-yuv-v13-7-bd5463126faa@bootlin.com>
References: <20241031-yuv-v13-7-bd5463126faa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> The pixel_read_direction enum is useful to describe the reading direction
> in a plane. It avoids using the rotation property of DRM, which not
> practical to know the direction of reading.
> This patch also introduce two helpers, one to compute the
> pixel_read_direction from the DRM rotation property, and one to compute
> the step, in byte, between two successive pixel in a specific direction.
> 
> Acked-by: Maíra Canal <mairacanal@riseup.net>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 44 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_drv.h      | 11 +++++++++
>  drivers/gpu/drm/vkms/vkms_formats.c  | 32 ++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index ecac0bc858a0..601e33431b45 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -159,6 +159,50 @@ static void apply_lut(const struct vkms_crtc_state *crtc_state, struct line_buff
>  	}
>  }
>  
> +/**
> + * direction_for_rotation() - Get the correct reading direction for a given rotation
> + *
> + * @rotation: Rotation to analyze. It correspond the field @frame_info.rotation.
> + *
> + * This function will use the @rotation setting of a source plane to compute the reading
> + * direction in this plane which correspond to a "left to right writing" in the CRTC.
> + * For example, if the buffer is reflected on X axis, the pixel must be read from right to left
> + * to be written from left to right on the CRTC.
> + */
> +static enum pixel_read_direction direction_for_rotation(unsigned int rotation)
> +{
> +	struct drm_rect tmp_a, tmp_b;
> +	int x, y;
> +
> +	/*
> +	 * Points A and B are depicted as zero-size rectangles on the CRTC.
> +	 * The CRTC writing direction is from A to B. The plane reading direction
> +	 * is discovered by inverse-transforming A and B.
> +	 * The reading direction is computed by rotating the vector AB (top-left to top-right) in a
> +	 * 1x1 square.
> +	 */
> +
> +	tmp_a = DRM_RECT_INIT(0, 0, 0, 0);
> +	tmp_b = DRM_RECT_INIT(1, 0, 0, 0);
> +	drm_rect_rotate_inv(&tmp_a, 1, 1, rotation);
> +	drm_rect_rotate_inv(&tmp_b, 1, 1, rotation);
> +
> +	x = tmp_b.x1 - tmp_a.x1;
> +	y = tmp_b.y1 - tmp_a.y1;
> +
> +	if (x == 1 && y == 0)
> +		return READ_LEFT_TO_RIGHT;
> +	else if (x == -1 && y == 0)
> +		return READ_RIGHT_TO_LEFT;
> +	else if (y == 1 && x == 0)
> +		return READ_TOP_TO_BOTTOM;
> +	else if (y == -1 && x == 0)
> +		return READ_BOTTOM_TO_TOP;
> +
> +	WARN_ONCE(true, "The inverse of the rotation gives an incorrect direction.");
> +	return READ_LEFT_TO_RIGHT;
> +}
> +
>  /**
>   * blend - blend the pixels from all planes and compute crc
>   * @wb: The writeback frame buffer metadata
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 3f45290a0c5d..777b7bd91f27 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -69,6 +69,17 @@ struct vkms_writeback_job {
>  	pixel_write_t pixel_write;
>  };
>  
> +/**
> + * enum pixel_read_direction - Enum used internaly by VKMS to represent a reading direction in a

Minor typo:

s/internaly/internally

Everything else looks great, thanks!

> + * plane.
> + */
> +enum pixel_read_direction {
> +	READ_BOTTOM_TO_TOP,
> +	READ_TOP_TO_BOTTOM,
> +	READ_RIGHT_TO_LEFT,
> +	READ_LEFT_TO_RIGHT
> +};
> +
>  /**
>   * typedef pixel_read_t - These functions are used to read a pixel in the source frame,
>   * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 7f932d42394d..d0e7dfc1f0d3 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -79,6 +79,38 @@ static void packed_pixels_addr(const struct vkms_frame_info *frame_info,
>  	*addr = (u8 *)frame_info->map[0].vaddr + offset;
>  }
>  
> +/**
> + * get_block_step_bytes() - Common helper to compute the correct step value between each pixel block
> + * to read in a certain direction.
> + *
> + * @fb: Framebuffer to iter on
> + * @direction: Direction of the reading
> + * @plane_index: Plane to get the step from
> + *
> + * As the returned count is the number of bytes between two consecutive blocks in a direction,
> + * the caller may have to read multiple pixels before using the next one (for example, to read from
> + * left to right in a DRM_FORMAT_R1 plane, each block contains 8 pixels, so the step must be used
> + * only every 8 pixels).
> + */
> +static int get_block_step_bytes(struct drm_framebuffer *fb, enum pixel_read_direction direction,
> +				int plane_index)
> +{
> +	switch (direction) {
> +	case READ_LEFT_TO_RIGHT:
> +		return fb->format->char_per_block[plane_index];
> +	case READ_RIGHT_TO_LEFT:
> +		return -fb->format->char_per_block[plane_index];
> +	case READ_TOP_TO_BOTTOM:
> +		return (int)fb->pitches[plane_index] * drm_format_info_block_width(fb->format,
> +										   plane_index);
> +	case READ_BOTTOM_TO_TOP:
> +		return -(int)fb->pitches[plane_index] * drm_format_info_block_width(fb->format,
> +										    plane_index);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * packed_pixels_addr_1x1() - Get the pointer to the block containing the pixel at the given
>   * coordinates
> 

