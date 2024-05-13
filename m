Return-Path: <linux-kernel+bounces-177292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A618C3C87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D888282BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D9147C7C;
	Mon, 13 May 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RN2oZoUe"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740431474D1
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586645; cv=none; b=leLQEtc9o+ACa0i0PsDDuTtLLcLyvlCbKPf4C3+UaaPpWo8nIicPD9hQjrZ0PJBIF9duC0skrCX+tRP0MhtTybiHoXXPIMNK9RYGgNDUTOq3gWNV6+VUcMFPCyDEz8V9OpauMhAUqBGE8G6fWM4HeeZ8p3tC5Sf5Q98oE6nCaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586645; c=relaxed/simple;
	bh=tkeF0pjGaCP8jQhPd6GYefneGTbz1FI3LYKKF0MTLKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=av/KRWI83Or4bAPMqBZU1X4HkOSEVnKWnNhb/GqV/qi2zHevHgpmEw1HicpQKct85Mselgyu+8evqbbCdlkvDkimtX5HTuPCzX0cr79kANAWQJxgsbmcge1gRuJSxYNtkvqGE6+zH26hREnskRbgy42Un31e2NXsTHIEd/zMoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RN2oZoUe; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DBBC2000E;
	Mon, 13 May 2024 07:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715586642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EU3ZyzvaLTmHpkvEEPcJRnaJvOGiAcMYcCExeDdlxX4=;
	b=RN2oZoUe4K9Znng1skr3pgqWvyC6wWSGC/ymY7agSqTDnFTH6vYkAFkiIYPYesMy0Jd4M0
	WKtPnaRr7Zn/MJi2Cn9+M1aa5QN4u5KNzyVluFws+IoG5FpZHepluUxRSog5mzMv/IBUmM
	+4Pd73OiGbyqbcfsOx8T/OlY4m91PJu6R3C3LPSxelg3QGj9KpB9iD8wZ96C5X6Z11qdt5
	jbLwu/D/1Wq21v7bK3vZhQ61SATeB4bwuhLlMXF1J9XbJCvX2AILhACxI92cwOm1zFTR9h
	aeCANdKfXtjLnm6Js4jdDTOMNWsr9Cg+DmyxSPGdfhEbDlOtd8aJi2Ke07TKgg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 13 May 2024 09:50:26 +0200
Subject: [PATCH v7 05/17] drm/vkms: Add dummy pixel_read/pixel_write
 callbacks to avoid NULL pointers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-yuv-v7-5-380e9ffec502@bootlin.com>
References: <20240513-yuv-v7-0-380e9ffec502@bootlin.com>
In-Reply-To: <20240513-yuv-v7-0-380e9ffec502@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4683;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=tkeF0pjGaCP8jQhPd6GYefneGTbz1FI3LYKKF0MTLKA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmQcZCr5f+bl1S1O2ZWbBLZfw0y6PIGn65vuTdK
 aQ0meEYdo2JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkHGQgAKCRAgrS7GWxAs
 4li3D/99w64zsfOPagK10ROzEEAddeYT7EUteLyf5MRClyUvuCtTewyBGQD5ggaUgNkZs6PdR75
 4/sNAhpeAIUnZqbhX87x4nVjqeU0NBII7qERV5BNbvH7iyB7LbcnpWMDMwLkvobBE03tDq936px
 2xHTxzo+l5Y3UUhF3X8D3lbJsh3SRX7yILCh9TpE3X3P/KzQEzt9Tqvpy+M3qneliJr0fUyoLGq
 +pXQ6Io2OTnnrctpR41wQj7YX5vXXUkjmGxwb82riZnMZBmG+FBXTjnSs8Yxpe3aKezIWU1BiVd
 fx5wznOZ3Hb3cjHZovkzWuOPda4Ikhcuvw2VgDEh7MSU6clWnXkyAoBVuwuVsfsOMEcZRNn9l0/
 GNDqck8IfouKZ+jqePMEtr9PfnsPo6gzlvVFtBaH/rFE3BWFIWmV7llASh/hJDZcI3kUP9KZeMf
 hPygIvp+p8wwA9MiuIRrppYReU6d5sFDQy/MC9egOi7Rc6LH/Y1k5GFgAn4kVdZ7DXUyup7IKU3
 yD4+EQFdze/QhgV1gJmOu1uEObi3C1ftdVZ6xC/zUCmPH4yOHaqOerHcYa09QOM9IlHeP90iqhb
 57E216zvHgUG4bmbK0bYFQUqSYeC0pCHBi+mmB5VfFe78/Q+gj49A0YmLDO4QOVwkvTC9Zevctj
 siwRxmXBEmuh19w==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Introduce two callbacks which does nothing. They are used in replacement
of NULL and it avoid kernel OOPS if this NULL is called.

If those callback are used, it means that there is a mismatch between
what formats are announced by atomic_check and what is realy supported by
atomic_update.

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 45 ++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 6b3e17374b19..c28c32b00e39 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -135,6 +135,21 @@ static void RGB565_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 	out_pixel->b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
 }
 
+/**
+ * magenta_to_argb_u16() - pixel_read callback which always read magenta
+ *
+ * This callback is used when an invalid format is requested for plane reading.
+ * It is used to avoid null pointer to be used as a function. In theory, this function should
+ * never be called, except if you found a bug in the driver/DRM core.
+ */
+static void magenta_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
+{
+	out_pixel->a = (u16)0xFFFF;
+	out_pixel->r = (u16)0xFFFF;
+	out_pixel->g = 0;
+	out_pixel->b = (u16)0xFFFF;
+}
+
 /**
  * vkms_compose_row - compose a single row of a plane
  * @stage_buffer: output line with the composed pixels
@@ -237,6 +252,16 @@ static void argb_u16_to_RGB565(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
+/**
+ * argb_u16_to_nothing() - pixel_write callback with no effect
+ *
+ * This callback is used when an invalid format is requested for writeback.
+ * It is used to avoid null pointer to be used as a function. In theory, this should never
+ * happen, except if there is a bug in the driver
+ */
+static void argb_u16_to_nothing(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+{}
+
 /**
  * vkms_writeback_row() - Generic loop for all supported writeback format. It is executed just
  * after the blending to write a line in the writeback buffer.
@@ -260,8 +285,10 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 
 /**
  * get_pixel_conversion_function() - Retrieve the correct read_pixel function for a specific
- * format. The returned pointer is NULL for unsupported pixel formats. The caller must ensure that
- * the pointer is valid before using it in a vkms_plane_state.
+ * format.
+ *
+ * If the format is not supported by VKMS a warning is emitted and a dummy "always read magenta"
+ * function is returned.
  *
  * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
  */
@@ -284,18 +311,21 @@ pixel_read_t get_pixel_read_function(u32 format)
 		 * format must:
 		 * - Be listed in vkms_formats in vkms_plane.c
 		 * - Have a pixel_read callback defined here
+		 *
+		 * To avoid kernel crash, a dummy "always read magenta" function is used. It means
+		 * that during the composition, this plane will always be magenta.
 		 */
 		WARN(true,
 		     "Pixel format %p4cc is not supported by VKMS planes. This is a kernel bug, atomic check must forbid this configuration.\n",
 		     &format);
-		return (pixel_read_t)NULL;
+		return &magenta_to_argb_u16;
 	}
 }
 
 /**
  * get_pixel_write_function() - Retrieve the correct write_pixel function for a specific format.
- * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
- * pointer is valid before using it in a vkms_writeback_job.
+ * If the format is not supported by VKMS a warning is emitted and a dummy "don't do anything"
+ * function is returned.
  *
  * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
  */
@@ -318,10 +348,13 @@ pixel_write_t get_pixel_write_function(u32 format)
 		 * format must:
 		 * - Be listed in vkms_wb_formats in vkms_writeback.c
 		 * - Have a pixel_write callback defined here
+		 *
+		 * To avoid kernel crash, a dummy "don't do anything" function is used. It means
+		 * that the resulting writeback buffer is not composed and can contains any values.
 		 */
 		WARN(true,
 		     "Pixel format %p4cc is not supported by VKMS writeback. This is a kernel bug, atomic check must forbid this configuration.\n",
 		     &format);
-		return (pixel_write_t)NULL;
+		return &argb_u16_to_nothing;
 	}
 }

-- 
2.43.2


