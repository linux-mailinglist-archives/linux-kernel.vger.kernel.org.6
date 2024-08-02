Return-Path: <linux-kernel+bounces-272814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4494618B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7681F23667
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C123200109;
	Fri,  2 Aug 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dfUD1zFL"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA2166F0A;
	Fri,  2 Aug 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615023; cv=none; b=RGtq2zo4PYoQtVOBZNblOSBELnyPotxmF8X8ew0a6HatAG94vvYRZUvzZo2XrOlx0i/qcpKA7tFHuh9BvxztX4C6GtplPsGb0TVPRDZCsHwsS09lQ01KlmC4FDVv7pFEGEM6gLY3GdKGtjfAGFx1kt7xZrAUILo+mx1XdzBOLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615023; c=relaxed/simple;
	bh=G5C5+e6eHFv/QVAB4jYLixOzCVec4t/0lYgv2kvZHy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6kWx2n4mchPrX/vMSHpO3+Xyp9oi4OIduJ/SdXv3rIx4H1sMpWXI6EKFfZORKXdVaF9GeNjJcgR+os28wjBAVMsAv3nC0sPoapvEE9cxBhy4DP+Pdy3VWb0GoO+QpC4RGB5BeXcvaMQKetIHHFWJWSmkdpZvumCNHKbJ5K6RZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dfUD1zFL; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BDE41C0002;
	Fri,  2 Aug 2024 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722615020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kC6rGUyDBbAOLm93Wq8KTDogWyBbuAcpNFYSnVc73eM=;
	b=dfUD1zFLis+p+xl3XxKSNgkXQsf2czMg+Vvqq18K/Avrw585YDKjvxzWNHyeuWouh6UoG0
	X2/6ouFMElOG5D24fLClrXSKiRkQdOg2cJgaIHt/vuxZBJClbs+xfk2YtZGzyWvLoI0MIs
	Fh2TTGoRTsXemP6TYraSaK2tVmms92SIPhDgyWlhdoYdW9z9CbMO3H1c3ByqlKvVv6Y+j8
	885X/eQZ08e2Xi7R9HpM7YiKc8KDxIuh/yPHmzmUJJQXiTbcYd5JCUmdLm0cKHAYlFdwBh
	cg8Xze7fc3EvU8ofHnChcBDDRaErUvKSnwib2cdwFUGcK3FPY1ZynMJRD1AeLA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 02 Aug 2024 18:09:56 +0200
Subject: [PATCH v9 11/17] drm/vkms: Remove useless drm_rotation_simplify
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-yuv-v9-11-08a706669e16@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=G5C5+e6eHFv/QVAB4jYLixOzCVec4t/0lYgv2kvZHy0=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmrQTb5OBjRUFHQXcY9UveicUxZ2dNKzeFoJjWs
 GpAxUTm+L+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZq0E2wAKCRAgrS7GWxAs
 4t/OEADPNrdS5BqCpLPwpok1vRfMpCTmOxPO+dhu/Xsf72Oa5oh79S/F710jSrgIgg/hA6MHOV9
 tjWRCl2X2SMpjz2XOO32L+4nMI6M69nGLfW6Qcwf9kS0CJuAX6ngqcE0iEwb7HKR2N6Mle3wDfm
 Tfye3ekjPPwgc4JL6IpIlvDDQzxXUiahSUKmoOQ9qlwR5n+m37z3hR2TjQX2eQcHe0yN8Bav86R
 c88Xzv3kn5onerkwe/OKe/IKmnAoK8IHVF2MWobC/86Tql2hHVYir+8MOSXntLvO/OofrtiSVq8
 6RFNgpCRlcVuqeRbOxgEs8o0sPl5GVQHDIb2WM3T8E44hXV+4B35GZ/RpB/G5YUYNwq+V51CEsC
 /4PkWA5vNyk22fwddtf/l8cfhIbIpcVGl5FKX7yOXjD8nJujt0FCpREnKN9gHvWzwYAFXIah1Qk
 wXYUycmBoh4IEvHxgFC3ALZ1dN260JeDfIWasSBURIQXsyrKAeD2HTrGhewc2hznYuIDBSs943t
 Fo4fJ/3K3gQNLAh0ykaQdtmmIMSPlD7JdNj4adby8Ug9tNC3IqpDMQkoObgsaHFBoKUgqcfu8NL
 1kyKVdYh3iw+m92GnWGxz5f1q4ZccocEXvSM9qCnIz+vdGYysMiZ1PKsbeUURuwiCl+OvtDeu8U
 BFT9wHVO0BgLLbg==
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


