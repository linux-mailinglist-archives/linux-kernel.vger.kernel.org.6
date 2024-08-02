Return-Path: <linux-kernel+bounces-272817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487FB946191
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044C6285A02
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAA021C199;
	Fri,  2 Aug 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hnm1Kma+"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E851E4842;
	Fri,  2 Aug 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615026; cv=none; b=tlNHWgR9wSVKSKr6zDZm5fj/JPcoaVF6+2/61031DzAxxAJA06juadjQPVW/jXAYcnL7HZBtScF0RN49EeN/rSKGaW7M2BwL5uihK4n96bWx9zycISTsxHiGnA8uoMB3X9xPhAFwuNXo9ap3W/8Ltr7Ws3N7MUZSDJiqb+qLExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615026; c=relaxed/simple;
	bh=CmWt7+MSx1bbYURoIV8tsNYf7uiASsJlKHa2TtpIAHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKyg1ArgWoYEiBAwoYTTC4AEBCDNyVjMfeoOek9sm657v/WQlZUDDbEk3RwaBn672DGjFoEsdhbZn54LwKRs3Uq98k38/JBsC65nj8gWLti1lE5A15PgyrxlYg8IodAo8CwEnOtkdX1ould0UEx08VwvOEKJCPjPSPihFa2BvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hnm1Kma+; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAD861C0011;
	Fri,  2 Aug 2024 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722615022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1N2wKhCx93t2SWK5sURoLWP8YIYqRV+8fF3gnv/nic=;
	b=hnm1Kma+n+xHs9ffDaT0cIAahgY+9OAQRH4Sde5hID4SBNMPAID8Nz911iKt0j2Wq3odWy
	rY0UMNK6Ws8rGQ+6pf1Zux4pzWhesO6k87zdwqfp1pKARrAjoEHtTONXX9HnK0LH8svjjK
	/2tVQsVwDyrGs09o5BwWB8D5xraLBjwdvWC7lNcwq6qb1jjUiM8CgCQDn3FJbXwcYL+Yl9
	R++2ILsSZVM7H4YPAK5KOwNjTwnx5sbfvCTPA1uqEsAH25p5omBwUen/lukSoQz2SYz6pP
	lgizX0qvEjOULWv/o78LrYnxCGqKJu6SPGPCrp/YBsnZ6zR2DayFIBmcojMrNA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 02 Aug 2024 18:09:58 +0200
Subject: [PATCH v9 13/17] drm/vkms: Add range and encoding properties to
 the plane
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-yuv-v9-13-08a706669e16@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=lX/b6aaWAzynVQwgJ4uAbWlqpIRVGyKzYZlNlczj/Es=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmrQTbBw8f7J2ngkcfe8tHUs/QKb87oU2gjhYRw
 ujy6yBguSSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZq0E2wAKCRAgrS7GWxAs
 4h5TEACsxQ50W+O6ti95R+7k4fGkPhRytLq/ji8zlMwoKjORpAZMrhMsQxmy9mNvg6/Dca+z6sj
 GsbWTI9+016xs/NSlXyDWeqbF7yTdzY1sAhFbRGgvA8pH5p4SJybLIN/XcbnwEzNwFZjeBQfDhJ
 qC7fL/e+bSQPzKjtLMfixVHift5fz+6re9XY4KmFBbvTQjQMtO2+0Y2KorJde+zgjAe5TtsYwF9
 N5HaiYdU3MIx0KW5BfVi5bHoQTfGJPH7Rf1vDti9XeQuUoR3hNwsd6J45/kR/N2IYBNnf+x17wz
 FmomV2h2rHMpt90zEN11YhN6aN/b+SLGetZAF4710wM6/g6CWcfTIXHqvqCU16TzEXHsDRUOx6v
 q+8GZeUwscJ2ArFx8+J7SNmZEK7MnvyHlfj/2K24OD7z4Zv2U667yKLQQVj+2qxwwIsNFiqHHVw
 w/BaIBHqNvyxMoBzN9HA8odSbNXTFhz0Di/+5/3hJ7uuuiS2LxCMq12UE6/yPkASdiN7lqXc8F+
 HxE1rWP6C6OJyWE2lsyWdHsPmvZauxWWLLUQhNX/0fLPTxEwDgCgUtfuZLoUVMS+ptIHctkyp+M
 vjZwzO7Q64k2zd46ZD1mTxRn9VBBvhBPGCDdJig1kOu9VUq1B3rgapT+v6QbxVECOd0a8Gwu/ta
 Tx7Ctab0sL74vuA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

Now that the driver internally handles these quantization ranges and YUV
encoding matrices, expose the UAPI for setting them.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
[Louis Chauvet: retained only relevant parts, updated the commit message]
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index d4e375913122..8f764a108b00 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -218,5 +218,14 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
 					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
 
+	drm_plane_create_color_properties(&plane->base,
+					  BIT(DRM_COLOR_YCBCR_BT601) |
+					  BIT(DRM_COLOR_YCBCR_BT709) |
+					  BIT(DRM_COLOR_YCBCR_BT2020),
+					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+					  DRM_COLOR_YCBCR_BT601,
+					  DRM_COLOR_YCBCR_FULL_RANGE);
+
 	return plane;
 }

-- 
2.44.2


