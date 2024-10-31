Return-Path: <linux-kernel+bounces-391062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 634E79B8235
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B7DB2375E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D431C9B9F;
	Thu, 31 Oct 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jlRIbD0k"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642631BC9FB;
	Thu, 31 Oct 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397981; cv=none; b=SrkMpr9VhQicX1nV3WFO/k0eBpHIKh00NnLhk8khiax1xCKM+rFWGk2sQuYn5vWN2RC4XJodfe7BdrrlIWIBuSAfI6Rmynqlpo9OlPNlXAhGdf3aNT1XYXl10NBBeTtDCqUM0aWHX10MZtuJL6IS5zIHSspKildqBKpdcPX4NhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397981; c=relaxed/simple;
	bh=gkogr80zC9IT6ygCMxlP62nYp/y4G1vFYorCtQOD8gE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+Hkr2CaMXefR4VkvrNt+ZbmvyfFt5ukyeIl63oF6VvrXIS4GRbrDsO4N3F58znemD0f3arkJByRxjSt+7mOXuILd60LCYkk6Q/HdpBbH8MM8Z0IRT8gsZfHVwzKiU+FDeWnCxhiy+COwKBAlh7O/DFwrpaUoHy3uToNHUi4HmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jlRIbD0k; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2FA0220008;
	Thu, 31 Oct 2024 18:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730397972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZZXCAOt96HKPNadssGl+s0w7QDIgwJlOE/lg2YiDu4=;
	b=jlRIbD0kwP6r8oFTiga7Pr8I3OkMIKAE1XLHqvFA+2nnFUPAmrRrcejX0mObsFkWc9xrjZ
	Z1VAGUo9qngDwZq0d2SGfY/PYPe86/UQzeIGdoCRNHp6SYaWa1HlTnINGVSpFmnqF0os9F
	j/TGAkZygsAXr4IQ2dDcJYlDGjWpWgzYO8r8LBjrTetUoephf2C9eElDQ0iR8IiWkcCy90
	4CWmtxVRQaTTsiSy8OtL9y2xSoSJQlGYtps/Z9SHRb1HdEzK5uJ/8Zh3eepgQy06ZrVm8l
	FGcNHGXgDyhbNUzsmh6kkDQxY7o/06TPVghdl2Uurq9ricpCL5BkfJMA5WYigw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 31 Oct 2024 19:06:02 +0100
Subject: [PATCH v13 2/7] drm/vkms: Add range and encoding properties to the
 plane
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-yuv-v13-2-c67a337301ae@bootlin.com>
References: <20241031-yuv-v13-0-c67a337301ae@bootlin.com>
In-Reply-To: <20241031-yuv-v13-0-c67a337301ae@bootlin.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 20241031-yuv-v13-0-bd5463126faa@bootlin.com, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=VB/TChUFVIfTCJz1NYTIIebS+nzvAngxAg3Yry+8p1o=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnI8cNBzYvzdbEW+ukdVx3vI8o0dy2hxpvtBt5b
 acKMa2/GD6JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZyPHDQAKCRAgrS7GWxAs
 4hkpD/47cr62P6N7DyPlN+SqvwNwKOTNrofNbtuz+ngN43gdpj8q6M7zynzIqIXO0GL2DnKLUcW
 q34/iKYIkZ4B+yVVzsMIQw3l/g2CTRGXNgORU9RGxKnZSz+/B8DcPl2NrDVy1wjhb9NIUQ3E3b2
 G7mJBYpqqfR5qgiiu6ca6cZKIuTkMgx9khImtBEtnu+3k8/wRPCk7F3iwfFNSufNDhSz6qq2vNe
 XHPkHBaTv3MtmSOCpQ405klhswJepoK0Avr45uH0dRuOz0tC5NritQJI8tQWMEBVLHDkWIoQsj6
 YNsd4Xd8miAvRU2qkxnrDc5iVIKQ0sftnrAGzqNUzokAQU2fI9H9TxApV9Pz4ypwAiWj/fuege+
 uvEQbOReFlkS+0ZvLj4Q/aO7lFa9BYa+2tsA8PgS2tEh0nG5XBrSBSJ0xTI8ctMTf9YfMAFaxqY
 ZQDDKNCHf+bgtNJhC+Nqff/xABanfbJjO2wTL0Y+Eddzvcpt5/I1qmOnUDx554iwEdOix6oTeeJ
 9OBltfdOlir+6J9dPYE8inlauXjtHCVpAzc9CEbfXDlkiSzVYS8qceoZjjwMtVUsISg6gGdP0zq
 IbnDRo5QfiiyRep7rDk9n37lOafnDlCJ4VVTbA16F5w4BuXJYKB3gYTQRHOtymYi34qf6il5v7o
 Lq0+iUX8jPZ3Rpw==
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
2.46.2


