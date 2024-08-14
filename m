Return-Path: <linux-kernel+bounces-286118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4289F9516D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5091F2490E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160BD143C41;
	Wed, 14 Aug 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ACs0nFVb"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04421411E9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723624947; cv=none; b=E8wqYmZjs/P8z728exn1sH/bhRkARToT67lz+nOGCL3cqQiLCQ+OPemYkpLvPReF8kQN2E3v8CZ7vW76cLYn2/9V2c8XRs2PMHIM6yD9tTk2ELjzKfSC+an7siv1OaTrIQZBmFUiED+px0iq5U2odcMKVRdumUrAu2qWg3Bq1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723624947; c=relaxed/simple;
	bh=VL3PElzNFwk8Gn9dL4jnPK3FQlb9IyDon6uJcNckt2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZC8yyh1cAmKWnxP5S7yr6+bCmTQp3MVDxVVy3jKvtRX4f2i8ol6MEt5K8IhLHcwDmpLLUhoQWTaT6EU3kE61oBCkkKe/ahioSmVh2aDuACi5rA+42v6ufjkEJdjl3V3r5NX11p5Ur6liLF8LZJKD9bA/vhGeJCIov2tbAuEqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ACs0nFVb; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3624CFF804;
	Wed, 14 Aug 2024 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723624943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4h1OePpoSe/b06Q4qCj2FENjdvmzkAd6B/UqJx2rfc=;
	b=ACs0nFVbJVoxmKOXPWF2kZYGOalu8dSeuQUfHJypZDPUBYr99ogqZ5JlIpgP0KsMzW6o+g
	iSzj1EREzy9nXHKY5k3tSiWAJj/LDMt+czN9I/numBu9okdAW2zwsNY68A5vxcH0pSErnU
	d/CkRsWU0C1o+zyB/IYFgUdBJq/ymceCm4aCILRysToc2g+7RUZTXuwSxlIR9QcbLnW+I1
	HvFbXyNT7iJeIRT7qTtdtD+uO7dwqUq48h4pAcI//Cs7Cn4gSsfMTNM5UZ8aT/Get/aT63
	opooXnYU+XzaKJw44jwxp14pPJRihQecYyayKbFU03rD2oYUNID9YI1KIqV2cg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 10:42:17 +0200
Subject: [PATCH v2 2/3] drm/vkms: Add a macro for write_line functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-writeback_line_by_line-v2-2-36541c717569@bootlin.com>
References: <20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com>
In-Reply-To: <20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4616;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=VL3PElzNFwk8Gn9dL4jnPK3FQlb9IyDon6uJcNckt2Q=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvG3refKIOfoDJxrTTie1VCDfJx1Ty4hsvkNKJ
 NiqQTX9f1yJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrxt6wAKCRAgrS7GWxAs
 4nzAEACr2ciZqP8hCmuCFJ0rqj5NUS/eVurzYak5Xl+q+gmnj2G/hW1JOEveSbho0FMGc4YzNwE
 QLKFMMnRmRvMPkjHVGQo+vPN5qPyC56Jc2nhdN9uCxAwEjYFKk8/BoF+lWkJZhyBzhSm5+5PSUK
 y6qbNMGBxS0rp+nPayT2wto5OM41hRE7C1r306rd1oqXlNDqNqYrt18v0P25R4Y61D57xGlfUc8
 KlIabhsrCE6pKfW8yhyEjDcxtK+8KhlIIyQusFjcttFhLGPI6mR3MvHTas50AruxuvBEUmWWJSr
 Qlk+9dsHT9j/527Weq6G0pq+gAPz41G42XMso89it4jnVV+VcuZDCehr25WHnyyS2uuvetCGwIl
 j6aEQIa58uPZxKC21FYoIrHoOXVfEZ+d7VoNuYbRcZ0YiYORIgLLmZ3rlfCpbE2LwO5yZhO0Qus
 VmNkLEVhuUQBzVvDLQpvOg58hH6qNEs6Va+b5g5CsFLEHIKQSH7UarXK6/wkYciaEX2VBer+3/p
 OxfbIqC46x+A7LaYT4QsSej9tKe+BjkpnMSNAPZqTOlANmsgkNQnevTFRR97j5gAYCL9oXLjYs4
 TG6pkq1QQjKAip44Bpkoa2nWP6AmxGNZYQ+LpoNt2AqLR8jEfqbeme6q9y3tiRO/PS3Y/UKfYSy
 UVza/rAr1ZlydWA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As stated in [2], the write_line functions are very similar and force code
duplication. This patch add a macro to avoid code repetition.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 107 ++++++++++--------------------------
 1 file changed, 30 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index d1309f6d307f..a25cdf656d8a 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -654,6 +654,31 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
 	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
+/**
+ * WRITE_LINE() - Generic generator for write_line functions
+ *
+ * This generator can only be used for format with only one plane and block_w == block_h == 1
+ *
+ * @function_name: Name to use for the generated function
+ * @conversion_function: Fonction to use for the conversion from argb_u16 to the required format.
+ */
+#define WRITE_LINE(function_name, conversion_function)					\
+static void function_name(struct vkms_writeback_job *wb,				\
+			  struct pixel_argb_u16 *src_pixels, int count, int x_start,	\
+			  int y_start)							\
+{											\
+	u8 *dst_pixels;									\
+											\
+	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);	\
+											\
+	while (count) {									\
+		(conversion_function)(dst_pixels, src_pixels);				\
+		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];		\
+		src_pixels += 1;							\
+		count--;								\
+	}										\
+}
+
 /*
  * The following functions are write_line function for each pixel format supported by VKMS.
  *
@@ -667,85 +692,13 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
  * [1]: https://lore.kernel.org/dri-devel/d258c8dc-78e9-4509-9037-a98f7f33b3a3@riseup.net/
  */
 
-static void ARGB8888_write_line(struct vkms_writeback_job *wb,
-				struct pixel_argb_u16 *src_pixels, int count, int x_start,
-				int y_start)
-{
-	u8 *dst_pixels;
+WRITE_LINE(ARGB8888_write_line, argb_u16_to_ARGB8888)
+WRITE_LINE(XRGB8888_write_line, argb_u16_to_XRGB8888)
 
-	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
+WRITE_LINE(ARGB16161616_write_line, argb_u16_to_ARGB16161616)
+WRITE_LINE(XRGB16161616_write_line, argb_u16_to_XRGB16161616)
 
-	while (count) {
-		argb_u16_to_ARGB8888(dst_pixels, src_pixels);
-		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
-		src_pixels += 1;
-		count--;
-	}
-}
-
-static void XRGB8888_write_line(struct vkms_writeback_job *wb,
-				struct pixel_argb_u16 *src_pixels, int count, int x_start,
-				int y_start)
-{
-	u8 *dst_pixels;
-
-	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
-
-	while (count) {
-		argb_u16_to_XRGB8888(dst_pixels, src_pixels);
-		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
-		src_pixels += 1;
-		count--;
-	}
-}
-
-static void ARGB16161616_write_line(struct vkms_writeback_job *wb,
-				    struct pixel_argb_u16 *src_pixels, int count, int x_start,
-				    int y_start)
-{
-	u8 *dst_pixels;
-
-	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
-
-	while (count) {
-		argb_u16_to_ARGB16161616(dst_pixels, src_pixels);
-		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
-		src_pixels += 1;
-		count--;
-	}
-}
-
-static void XRGB16161616_write_line(struct vkms_writeback_job *wb,
-				    struct pixel_argb_u16 *src_pixels, int count, int x_start,
-				    int y_start)
-{
-	u8 *dst_pixels;
-
-	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
-
-	while (count) {
-		argb_u16_to_XRGB16161616(dst_pixels, src_pixels);
-		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
-		src_pixels += 1;
-		count--;
-	}
-}
-
-static void RGB565_write_line(struct vkms_writeback_job *wb,
-			      struct pixel_argb_u16 *src_pixels, int count, int x_start,
-			      int y_start)
-{
-	u8 *dst_pixels;
-
-	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
-
-	while (count) {
-		argb_u16_to_RGB565(dst_pixels, src_pixels);
-		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
-		src_pixels += 1;
-		count--;
-	}
-}
+WRITE_LINE(RGB565_write_line, argb_u16_to_RGB565)
 
 /**
  * get_pixel_read_function() - Retrieve the correct read_line function for a specific

-- 
2.44.2


