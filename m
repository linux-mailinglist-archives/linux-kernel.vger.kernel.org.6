Return-Path: <linux-kernel+bounces-281349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C9A94D5D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA31C20A83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B41167DB8;
	Fri,  9 Aug 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jf2guA8F"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9E15CD75;
	Fri,  9 Aug 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226112; cv=none; b=W39s/6dogVs78oEZdmUEkSF/6BFw2YT7c+ogjROmP4WhZzcaX8tJyc/iitNX6f3ahNy331BO8kPCC0K/QvyPQWXXO+XDHg/9RN0zu7P08TaCrV24sXl75pL21zQ5BJ2LfUGQEoSL7T26BUM+//ydCeZ7q/5SBhql59me4rUxGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226112; c=relaxed/simple;
	bh=G5C5+e6eHFv/QVAB4jYLixOzCVec4t/0lYgv2kvZHy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hyuFgqJsTGRSTuCBRjCk7hJwcrAmywvOiQxt3yB5gmLojmqTGTSHVi3SEE4+gusRzJ5zXqaGBCXmzlouajP7OWhzVvtN5Mxh8Vp8jJ7ngt+nN1181C5nkmtiXBmah1a1XpViaiWCYInbfDRJmVN7/KxWLM23Psfgm0P5vozuyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jf2guA8F; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43102FF80D;
	Fri,  9 Aug 2024 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723226109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kC6rGUyDBbAOLm93Wq8KTDogWyBbuAcpNFYSnVc73eM=;
	b=Jf2guA8FDgbssf6lYwFXIMIh+BHPrsd4rgH4QrDBQr2WspixH34h1oI4/zQNSLu2S2wge6
	QWT2RNwnOdpApSfOz+wpoKoC81TpmBCJbiR7E9+l0oXtLKm6aXzlRKA1rTwLrqU8ZpFf1L
	OPiDTWRPxg274zmgjeEtaSUHRaY20wFzNnHUNTILe63PLygB1SsiFK+n8DD1kyV6KAHk8O
	MLttoge32V4cOBHo33qQ3EiSLZ/k4YX4w2omUwWlp9dHc4hLieDjN5LrRHkZKD4egbpy7n
	GeuubGfKOCKzBL+ZxbFUdT05iFyPy9XpoiHL+rflfR//RMoBa2yXPi01AJnNrg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 09 Aug 2024 19:54:51 +0200
Subject: [PATCH v10 10/16] drm/vkms: Remove useless drm_rotation_simplify
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-yuv-v10-10-1a7c764166f7@bootlin.com>
References: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
In-Reply-To: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=G5C5+e6eHFv/QVAB4jYLixOzCVec4t/0lYgv2kvZHy0=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmtlfqizrjMxpSRtXyNh2xtLWP9MWtToZjnv4ib
 vKjgG8oOrmJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrZX6gAKCRAgrS7GWxAs
 4jNnEADUJO6bty7F6GCzVH0LFYjteuiw/FAMF7E3JYpqUmYJ5uXFzUsGKtPvquz/mhzefhUAOwI
 Da0ZpfXMpnYSzhRmgZqeW86uuSPHFJXtjJBfN1KmIYronuv4W73RFHRhgu1Uaz06ypRZJT8kR4x
 m+zHrRUlCBvB3zcgynk/ET9wN8mS8F4pigQg3hjfRHJcuGsGsdEa5uKJo5t9AVFLO7AQ6WdJ2DF
 U+ya7ZTOW1fzEpj/dRTUdoaW7eYa7WzhinPA8no9e1ycT7ejOBAOZXCJvy2P0n1+Ln5HzTl8str
 ikKg3kKONOTaW7WpCtpXnzmZ67lRT7dD5jbRJ25n3qB0u9iKu5CKaYSMuE3qDD3455Ux40T5ZJ9
 U4u2/m/M1HyvI5MVkCiB6Yzs0ik76l0EePT99Z2erwUgikc4eIIdzNggixLFHr8dvZRTvHAD+Ab
 lJyz8Et68AVlhcd05+5mzbw2+VPEFeTZrKvqDEIpKkfOd4fBgCbxRgiihkFeSEnWHiSdhylFMAv
 MAl3g/XAD63MRq8W4IIAloM69QUBXFO1NRm6niBWCdPFaYWkxmLhClM4MvC3n6ME1AaQU4ocgso
 7KOP0niw+c/Xm5OtBYw/9YijXgNAlMW7tL+ZuumKZg41gvQhjjD/OCFG/g+tHUPJyl2md9+DKPy
 4/vte6+bd4iecNg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As all the rotation are now supported by VKMS, this simplification does
not make sense anymore, so remove it.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8875bed76410..5a028ee96c91 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	frame_info->fb = fb;
 	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
 	drm_framebuffer_get(frame_info->fb);
-	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
-									  DRM_MODE_ROTATE_90 |
-									  DRM_MODE_ROTATE_270 |
-									  DRM_MODE_REFLECT_X |
-									  DRM_MODE_REFLECT_Y);
-
+	frame_info->rotation = new_state->rotation;
 
 	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
 }

-- 
2.44.2


