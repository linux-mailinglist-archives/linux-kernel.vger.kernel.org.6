Return-Path: <linux-kernel+bounces-181073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C508C7730
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB981C2249A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A214B968;
	Thu, 16 May 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o9BQlj8F"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFB1474D1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864725; cv=none; b=n6wSCICx4alx0iVJsO6QJj816ZVx2MxngueYNwhhre+HsQUSZNcs9BhJ3UOsBnx705z/WFOhd1w8N6XynRx7qk+KsZzFfH3+CoiDAzKRUjSXhJbrfxpEgnG0yhnbU1k3eZLVahKSAJDHlIW1UDkGKsFsYuEDmY6tZeR1v/fzL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864725; c=relaxed/simple;
	bh=tkeF0pjGaCP8jQhPd6GYefneGTbz1FI3LYKKF0MTLKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJXA/IpBqfh3ZllnWu+HmnqX2RjC9Y6dpJ+Ye6M/kUK2kdYRxIYEBKmydn+HsC7Ql6+DYsOKE0vOgR+4MqOEm5ScIA8ezBrlF0g3vSZct+PE/6yoPeYQy5RfPkcFmKI02Jlrtg1xnRe6ubBmHlk3N1Q4S/xIaNrUYyeVQG0J8/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o9BQlj8F; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E4B0C0010;
	Thu, 16 May 2024 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715864721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EU3ZyzvaLTmHpkvEEPcJRnaJvOGiAcMYcCExeDdlxX4=;
	b=o9BQlj8FgqedeOb39+pRR5zVFJU1QiyGu2Rpyq+NrlpSDVjm+uDsjsJE1X5S0qY6ZfpBjZ
	ejCq3Z+3C3jr1JXc9Wp7bJ0fxMGTcS42sFl56TDFbjwbRmaR8kgWgxNS3/kVdM+2+yAu3k
	WFT2Sm5MyPkz02xqqYj31L/QgsbUek3XL65FQC4Ihrk+scKgY/gyfScdjMhqTGH08vcxMf
	eVCWznXAXlO1PpoEA3XsTtRqg/ZWzucu6PwQmU3VYH3Hwj2MiJ7cAVq8s6JgClqJgrQpjU
	E/eTIM4/U7Ew0L09GnCgaTUgGB4gzTOH2bb5Bu/zm2bvqZBgcs3GSwIzvymWRA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 16 May 2024 15:04:50 +0200
Subject: [PATCH v8 05/17] drm/vkms: Add dummy pixel_read/pixel_write
 callbacks to avoid NULL pointers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-yuv-v8-5-cf8d6f86430e@bootlin.com>
References: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
In-Reply-To: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
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
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRgSAPajU1p2sRNkAuh+gZrvyou5tgMe9IQiKk
 /F0fCPJ+AiJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYEgAAKCRAgrS7GWxAs
 4o7nEACjRgViv62AzRrnvyIdr24tIbBO338IgOmaKDRoq6dKPf+1JwlIaMdMWr/0E5F3UZCwAYT
 sGQshFxTkYQ4EiubvhkOKfkiiVdjRC+RNT/N2tMK/iGtKfi9aiITm4toibmMSZyiQWUroAB2FNL
 U70ic2pJQyiHjOCROIjAs7tCFzNyne43tfcLJYn3Fh/W0V12ATsvqXADkLmhtyYX6j/z7x2RWdc
 QYl8mUEMJ0SmcwPvtfg95pJK33CBgpLl6AkXF3DkL3He87aa+hZfHfFrlmEQ9iMEz2fvmb6ukOg
 sqLufs3ZQMszljnIG0jwngbUuMw6gkAbfCROQWFZ22aZIuo4ju3ulL6fmBrWLQoW4tjhG6RgGcu
 +YTnFgJLz0fXAsXNUxc0G5bkH2Ol3SncU/MmSmJlT4nZ5QtfM+rHSTOeP2//LA2KXkYcCKSnNH4
 MZ+Bl10UVmxV2EL82oc/lbRNSUaBf7QYUOkzTEaJaNVoPgSpp1CWcBz3nVR/xh5KGB1rxI7T4se
 iz5EMUa9UPW1obFr0+Th6pnVVAmdbbkykp2HiiXQ2V8YEq+HXkTxJyufa91l4KattmOZ7opPFm8
 XSlgKbXMFMkFaaNpU5anjtWnXuKB8CSYjC1c0o6KZFU/tVFCnnd/nQC13LcWlSroIzk5vAw4VRw
 K9O8d+6aUgHPt5w==
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


