Return-Path: <linux-kernel+bounces-272805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6DF946178
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A74B2287F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10A11A34C7;
	Fri,  2 Aug 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vb8lTr/7"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945B31A34B0;
	Fri,  2 Aug 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615016; cv=none; b=BliIFhSOtK+Qgq270RkT20cxi8hL4KoVS2U/F8v+WDXALwWJPF+DElKh1htC8oTXueLWqSF5MAdejJphUc/B3DdWuUwxZsYvJPhYFljoTyRzKSF8bKaT/bHznKorggfszBQTf7Dl1Y5tuD/SK1I/GQX8zynKnZCrkpSZogeC+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615016; c=relaxed/simple;
	bh=k+uLInN7qsM1NXhexBZhD1iHnwe6gGOowqdT/wIvfaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qKWWwGpc+bODaYJXdJNQ2Vl09GJ2/+qa0ovOB6j3fRf7DXepa1a5Dg8vawiE4Mr6Ofg/Vzgvufp0WM3MOphAK4O9EilGPQqTc6SubeJPTWUnyI6kSdUnq5RKxUPlMx/GVnRpHvFKCaSVTz9nrbkdbfLaESen2X/qxC8+8AbX0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vb8lTr/7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01D7A1C000A;
	Fri,  2 Aug 2024 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722615013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lQEWHsz4JhuXNOSe2rk5ZpitLGeYb2fYH6MAsFBiMg=;
	b=Vb8lTr/75XTixUW/7Te8FTnkEb+VZvS7BbyQYy2o/ozz9ZpfDG3lXD7/yskqJTxaQ7MlLR
	HVnUPFyCkgZpSML+mfnQJMMUulIOB+a4fheCPCwDvfrbQ7bQNQ8vFqFXHz5GhnQSLmshOI
	NWdjAkfzLOPUWPWs30yV3bSpC915xPWxpLGvVdw1x5CTCLzMFFzk0/insmXePBwgU8SEUK
	Ra+zsMq6/3AcWEufUdUQqopWDepVw4z8A3PGBPYP0m9kF8eqUeDpTUWdrqF+UUretfTRx/
	eYljeBOcPnSzMsETRONSf6Do0O0Wut711u4p4/CBORxt4PDK93hI59Xo14PYxQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 02 Aug 2024 18:09:50 +0200
Subject: [PATCH v9 05/17] drm/vkms: Add dummy pixel_read/pixel_write
 callbacks to avoid NULL pointers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-yuv-v9-5-08a706669e16@bootlin.com>
References: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
In-Reply-To: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=k+uLInN7qsM1NXhexBZhD1iHnwe6gGOowqdT/wIvfaE=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmrQTatttV0t3PqWO0aJGle1ipp9k7DHRcqO0wK
 x8tWAnSPDyJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZq0E2gAKCRAgrS7GWxAs
 4mykEACr80Ij1yaaN9xfiqJYawDRPWjikZW9jS3gGi44A/WdtHhqNwwUWGi8xMgJZvDLXMtf/B3
 y0llI2PUe1TRoBiwuJTHAqypdzVLUG8eF8Qu6zu7Lu4sHpvMINQbQVNPGtXYegnlMa3WsCNWjSz
 lsZbnalk3nJLxVXUHXbMxFW+XbWiLzk92+HNrQucvAPjxIGmj4wAMRGMFhEIUJOmypQIqvTUZji
 mSfgCXLEj8HNVVRE1i3XTW8254c96J9yVxAFIRhUXeTbt/EuCMWhurXU5sloxOpoSTA8+lu2fCV
 aRa1ul1xHoLmB4Z1+k21HnDG5oVWPA2WaoZtYXg1LOuboiqy9SEf7+nIE9J4kwrzxJEYHDBGo16
 5AhUyyNZl2GkicRCWNa+5Y3Xm9XcWn2b0IvgcDnlI1CwcxGnkQ07OWSECJs0iFxeCdHd+Xm8Bv/
 EoxhaVcGJ81fm2m9CQ9quf3RKzFKnxi1MEfVWGjUYFNQd7QXeCUqkoj+UK8bS40/vAPOzqCIi1F
 GMDEAxt3iPbN5Z0edJoJopZE5GxblYngLbGbR2pW1iyCL//DbYSMGu7iDNMT3V1Q4QRy6PSyYog
 B+DJiJyRToI/gXIQR/5svcfj2GPcrZq2BC3cXoce94bllK+dhONR6sstr8suQoJ4lW1aOpRFzDw
 Td2MKsRFwr8Tflg==
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
 drivers/gpu/drm/vkms/vkms_formats.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 5ebc691656bc..ecbe79f8dfdc 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -135,6 +135,7 @@ static void RGB565_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 	out_pixel->b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
 }
 
+
 /**
  * vkms_compose_row - compose a single row of a plane
  * @stage_buffer: output line with the composed pixels
@@ -260,8 +261,10 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 
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
@@ -293,8 +296,8 @@ pixel_read_t get_pixel_read_function(u32 format)
 
 /**
  * get_pixel_write_function() - Retrieve the correct write_pixel function for a specific format.
- * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
- * pointer is valid before using it in a vkms_writeback_job.
+ * If the format is not supported by VKMS a warning is emitted and a dummy "don't do anything"
+ * function is returned.
  *
  * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
  */

-- 
2.44.2


