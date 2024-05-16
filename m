Return-Path: <linux-kernel+bounces-181106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D3B8C777D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F061282107
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3EF14B953;
	Thu, 16 May 2024 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z+ELg8JU"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E472146D51
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865616; cv=none; b=sYBFt+Ow5bImenKNbGZE4lec/XrzaoUMo1WtFAqRKOoJ3tPiNqQjJCvs0hbdDPWoxLCzG6wz5xk/UQEQvTmTZtxZNo5oxOMQmQ4z0n8m+fcEiAv2MU2JQPLhvBgeolvQg+EJxEsZjKknPxHZgQ19yrAN8TY5+/fY3LCIicC+I/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865616; c=relaxed/simple;
	bh=1OJ19Pl47nRtdHCzGqcZtNX9EYkZYfEVLt9EdjsyHOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIFsvXiQ0rN/7cpkTHignjnGl8mvcr1Hs/5Gtjk880xRNlw1G9UiMfur6qtnclugAlsEayhqNT1gkn7maa3mzFWe7zFzF0coPOF6x6pLIzV+SPN/WKJzZHyu0QzoekBkDh+0VWCZWn2vs5mIFxdvJLRRhQdMxNh0DeWLKUyaNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z+ELg8JU; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22C8E1C0003;
	Thu, 16 May 2024 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715865612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gxsky9In9MMh/e1w5QTvAWtdGDRX6UThnRqmblTzJ18=;
	b=Z+ELg8JUhcl0r9jzdSzkiJrO+6Wea7A1CE1GDFSgg6pV0od+aA/OadiO6L16C4M5S4jPcJ
	KeABzRoWSyn0ECqTLayKaVgUXu/MXpgKBtLxapYAJ4z/xS7oWLrPvuKGdHEdJB3KZKOrhy
	lfgOZs8NU8/mUAUGgAbXq6/FU49hUwACV38/tnQM6Qg6q+fd5GmyTNU63fFKSNf8qAzOmL
	NM9CsvR0EQUmfiiFMz17+XiG2wVC8BQH7oenKqa380IgoACucr0noTrjqASU2SOmakL+Ad
	A75Dxlb/C+6xNeBGAU8PDsaa+GyIDZCOP56LUKprrikjq+AxFd2MMhUieZnbZQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 16 May 2024 15:20:07 +0200
Subject: [PATCH 3/3] drm/vkms: Add support for XRGB2101010
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-writeback_line_by_line-v1-3-7b2e3bf9f1c9@bootlin.com>
References: <20240516-writeback_line_by_line-v1-0-7b2e3bf9f1c9@bootlin.com>
In-Reply-To: <20240516-writeback_line_by_line-v1-0-7b2e3bf9f1c9@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2232;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=1OJ19Pl47nRtdHCzGqcZtNX9EYkZYfEVLt9EdjsyHOI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRggHCQK7xwYqKIIeeA0rVmlaVziGdYQOydOcA
 acReLtoUVOJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYIBwAKCRAgrS7GWxAs
 4lhOD/0Z3LDnJlwTF1nleuo7YXbCMUURCN8v3uFz4goGOoWXD40S2ebgWzUMZ/UlG/Z+NQjf/PD
 z2PgAunHRR1YtWBAjYLVe+5y0JG7BvcEzwEwO1IOLfik+yMQ5KSz1uGjGx1xVCG7I6ptYxMeRXU
 YeKoxs7aXkcZaQOWRpA9m/u/4pcF5belsn21W7mtq+KuOADpcPQ7aT58osDJAHSjyJFp7THD6h+
 EVO75UXYPza561UDcN2ZTTO6+Cp4ZF2KaqmQEMbo1AWuxvPkVxTeY0iz9cnGPuVOYjsm8dXC2si
 gjUTcfb8EdtditlCJQWZxVukITRR96SoY464F/NOy0Z7gzksY+5Szn/Zy12HRIW5DVoAhP/K3GK
 t7TW77RkJuWvTnoH6xTO1kUon782rI6da2dd3cKiomR6HVkzRwv59nTwd6AOZjKP8JWImiUp8Hn
 WS8wn/qBFgEKfJNB5RuGD26P9h0CfKmllT//R8Y6QVLLfv2GhZ6EGj8oCFOyhWRAmVZ+jBUq0DI
 Hf+NucgHuEkvxG5NvPhNQE+hwCJhS6yw2ByoUoKJpR9wzviDDzlswJVXwxqEBilnYdWxVoMcGa4
 lEE1LhVyfTzNnIoYH1GkAn0kf/CkAqSyuCRhQXp762rnCYQZSO9FUivTOsf+xiEzz6t6vDc3Y39
 q8KTiL51bBkGPng==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Thanks to the WRITE_LINE macro, adding the format XRGB210101010 is trivial.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c   | 12 ++++++++++++
 drivers/gpu/drm/vkms/vkms_writeback.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 51b1c04e6781..92f1b2f5a8dd 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -642,6 +642,14 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
 	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
+static void argb_u16_to_XRGB2101010(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
+{
+	out_pixel[0] = (u8)(in_pixel->b & 0xFF);
+	out_pixel[1] = (u8)((in_pixel->b >> 8) & 0x03) | (u8)((in_pixel->g << 2) & 0xFC);
+	out_pixel[2] = (u8)((in_pixel->g >> 6) & 0x0F) | (u8)((in_pixel->r << 4) & 0xF0);
+	out_pixel[3] = (u8)((in_pixel->r >> 4) & 0x3F);
+}
+
 /**
  * WRITE_LINE() - Generic generator for write_line functions
  *
@@ -688,6 +696,8 @@ WRITE_LINE(XRGB16161616_write_line, argb_u16_to_XRGB16161616)
 
 WRITE_LINE(RGB565_write_line, argb_u16_to_RGB565)
 
+WRITE_LINE(XRGB2101010_write_line, argb_u16_to_XRGB2101010)
+
 /**
  * argb_u16_to_nothing() - pixel_write callback with no effect
  *
@@ -979,6 +989,8 @@ pixel_write_line_t get_pixel_write_line_function(u32 format)
 		return &XRGB16161616_write_line;
 	case DRM_FORMAT_RGB565:
 		return &RGB565_write_line;
+	case DRM_FORMAT_XRGB2101010:
+		return &XRGB2101010_write_line;
 	default:
 		/*
 		 * This is a bug in vkms_writeback_atomic_check. All the supported
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 53bddcf33eab..c86020ef667a 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -21,7 +21,7 @@ static const u32 vkms_wb_formats[] = {
 	DRM_FORMAT_XRGB16161616,
 	DRM_FORMAT_ARGB16161616,
 	DRM_FORMAT_RGB565,
-	DRM_FORMAT_YUV422
+	DRM_FORMAT_XRGB2101010,
 };
 
 static const struct drm_connector_funcs vkms_wb_connector_funcs = {

-- 
2.43.2


