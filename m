Return-Path: <linux-kernel+bounces-353794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4029932CC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706EA1C238F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730AE1DC1B5;
	Mon,  7 Oct 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SWkhdD1N"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043F1DC066;
	Mon,  7 Oct 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317460; cv=none; b=UGzcqojaBS3LoArSEh+UMxtXjtiKP8HncbizXLgrVWFm1X17yY/MWzFHsZB7HGwm8b5SziKAwMsdR7pDPMW2ZfJChzsSTEAXgel9zthDnXkju/BO2cIaXE059PCfxEn6KeGGpz0Prm8S0e50LAbsn3CDZz3+hiACE6fF05j22A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317460; c=relaxed/simple;
	bh=PFGhswxeEmLZHlnqofeGdDJ2SDZWzjkoeeHK9t5I21Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dBOMxEnzk57RMhLmXU8htaMTYztOnQ8cFZC3alhriwGPKFIpxwC8YcmRJircdiAE0Xd5oBUYm4By8iGw5rauADxYpBFTLi6LwwZ0g3wZ1CVIwfgSSPabWd72B1QLs1oRhV1VFAHTmhrvPFsUl/tyTi4FXXDUxHRfQ/728NSGgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SWkhdD1N; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DCAA4000F;
	Mon,  7 Oct 2024 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728317457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BsU4INOE1CHTascqSt5xwkugSRCgOxTbOYvghbcOx8=;
	b=SWkhdD1Noq/TnMpLyGIYwkE1taZTzB1IUEVHF8zOxIMRzch7B17FKcMLoL0FmFGoQEagt4
	L84gFLk/Jbu8PjkK3yINXgOkwXu0es9rOMZhvmvfPic9AzPT6ZONdtd/LtKKebJXB+SM4B
	Dp5v2wBj7h1CrH8n5EIdxZrJB2X4bienUSJ2eKO6L48kmy266umfaxAboP/YCLNAfc4VCG
	scyGf7BQYJeDuiFcIjSvBYJ2hx6C8LgFZNj/5633c6pfEuaCrQ+bdi05J9b2ox6HvQ36Ym
	ZQAmU9RKoy/uU+Ohs4x3UfHacciC5iyf9zeCBZL98dCxDZZtcKYAtI5/UfAwjg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:10:43 +0200
Subject: [PATCH v12 09/15] drm/vkms: Remove useless drm_rotation_simplify
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-yuv-v12-9-01c1ada6fec8@bootlin.com>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
In-Reply-To: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=PFGhswxeEmLZHlnqofeGdDJ2SDZWzjkoeeHK9t5I21Y=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBAgC3LnWqr3zY/IDAl7m5lcqwe0RZYXrq/YdS
 TAmMeF+QBOJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQIAgAKCRAgrS7GWxAs
 4ujjD/0RwacmovX0q32XNvaQZ5P5o1CyOaB8ZeyB6TjnnrpD/zUhrWK6ptEmeRgDgiSz4ochFsO
 8cyh5k0zscYUIQL0mrU7XR9HfGYjqC/1V1AR+giimaH+MgnplyYwtB9a6ahRcyMc000HxZddbIZ
 TzXC7Krrpshe4PndqOewj/m8H+wXay70uFXdhKuAu4//eMHeAUnNNY+hVKsYGtn9kgGGFloGWRi
 EKDMhGd43x/nmeHdJLE33fklHC5lf6iWu9uFbKgIhB3pVCd7FbnNjMbK6cogSzaJoJSeCfrrpvA
 O5utSjeyBJBl6o9vHNqLhurgZ3lhpFgbVK92xAPzGjEay+CjFVfUNL2kp9ZjBMjF8B6Pow/Ig8Q
 uP4Le8zdp8On9REU0I3r9R8kr7zkML/J6naibbnRss39rz93xiklY0d5hSndivToKY9Zm7UWQoe
 NWe5IJBG7BT5Rhs5APBxbfyasFtP+TlGUTVqW3c71on1mZldEMVu6fG5etMS3aq6iuMJmk8YSqZ
 V0USovd/QMzPphNuy/8+U/dxseVKhMxAHNW7xe3yHTkZijo9hPQIucDaB6MU/RwczkK/3LHlFa9
 a7U9zuXwggVv7Ey/m1TnizuVwLZ0H/IPVxwXJfqRygiYITC27zKu7Faf32RnceVCFVU89GEvkEK
 pX00Uwsg54uB+oA==
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
2.46.2


