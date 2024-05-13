Return-Path: <linux-kernel+bounces-177298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A16A8C3C90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AD8284055
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA85148FF6;
	Mon, 13 May 2024 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nAt27+4x"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8E1146D65
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586655; cv=none; b=tKgt7Sq0wq48ssyoeqrUoIpFeMKHV5FWkNAnLlNuH0UFQT5Ab0sy7UaLJaidZo7tpGF23NVtYX2rDbt9RsM+GmiRMOWnD/7kHesJ47kn3uQwbJv+vq3P0ywjIe8y8zD7styOXJjWNE5GlfG8y63uFMJYeIt0e8b2Lwb5/uj0knY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586655; c=relaxed/simple;
	bh=wUSBUJCSOtsms0zYAayKwF/xjzoMjd+l5I3zX1xUo2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WETd12n/GJR4bQgr2kUs5WAktbmlz1SXZmq4bda2oxAnf8D5zdQTwHzSc39a4U1UAOxs2HNlBWg4NjA62hLatd+kFTh60d0FOG8nuknOTvUmPnwtJiDiFs6gtctSc9JOFPL7bKT1U/BnxcrvvqP3jKyKxrZIZiKeQTJ7DpaSQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nAt27+4x; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F6AF20016;
	Mon, 13 May 2024 07:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715586652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6QJBejRB4UIVVBulKVlIb1TBeEN2xAQAhfhefcDJuU=;
	b=nAt27+4xF6kS9qKcoRQG30arhbc5tvm4lADaWLU0HXkgVy2Vwa0gZOFbh1N4i2QnAL3Qt+
	RJ2m3VoBfbeRWjJbHSUMpgaIp0jg9uq4wu/9y4hiOrokYL7DaypDCQpmmWueOcy5CfYiYz
	0SAM2Hf+Fqr1rRqXSRkOyb2CwIYrNcnDw6L8zoSjovjcHo5BqaJXntY59Cw//IFCZiPQKQ
	gx3iPHhuwQvjb3aAZzAScsWYty22Bu6hWlKZMlxBHZKbrKhjbivmm31aVwIoqEm0m2ArwC
	0+nKO8qGxr5v3Q9rOEELMrO9iIx4/OJzZReUN/CQ+041N3de/qHgyUqnm9Mqkw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 13 May 2024 09:50:32 +0200
Subject: [PATCH v7 11/17] drm/vkms: Remove useless drm_rotation_simplify
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-yuv-v7-11-380e9ffec502@bootlin.com>
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
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=wUSBUJCSOtsms0zYAayKwF/xjzoMjd+l5I3zX1xUo2g=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmQcZD+LHWXLuD8UC/V2SidZJGkv8n0aUZiZbIL
 RxqTEZBxoqJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkHGQwAKCRAgrS7GWxAs
 4oDgEADY87bjjEV2efg9Fo/rPkHxgg+fydezcZIl6O+9mBqI4g4dme4e0GynlaOiORH7N+0Xn+T
 zNRSK3w9Rms/z3w2Mf+P/dx+/ciq+gSpiZxWZlm1D3VBT3cJgwVoFmz8Z88yXUeSjR7QkFXMk3z
 DJahJ4dAPqtOOai9QBjWPHqhHuT7ivrvnJYOsQV/cJd5xnJ6UYNo2vJx9V6Ab0uveKMHSwK7ukr
 KE8xlfirD7aLbtae7Xi41WP5AICtfCUTSTjzdUJ3pqLqQPGOQe8DUdlpUluBeCDyj3kxa7snpGO
 P+zNIhBmzJQm3ELeWrxjYU6mcUb4Q4QRxJi5eXmRGuQUMp3nYJfjWJKYYICUsSMLdDrZB90E9DO
 Im8XsDFdoF4us9if+YonM065rthmG/7pLsC1MA9yLKdume1bH9GNcDiN5kPRFqo83LxJJSUapNq
 dB2bsyJD//LFlxgELcWY5WlKYLCpeHCwtt/hRKsF8hw/yDH5X+AuZL3pZUqIfyxpEOCq1vynF3i
 cBOe4p5zmUP5Gqh7sg/UA0rcwJwl2Hf/TAJq/ASAYypHMVoFBTsBh4q/TshRfGBXrW+YbBDvAaR
 VJoV9BqntwSlkeqefJ2gD9ulm6ThAIO+CS3mD6XneiHXYSbLnNJ+m6j1onwmSQT3teb6wjC2y7h
 VFc5RzrKPlfi1FA==
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
2.43.2


