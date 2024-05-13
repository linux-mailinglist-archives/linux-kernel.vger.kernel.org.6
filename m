Return-Path: <linux-kernel+bounces-177300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E2C8C3C96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3265E2844B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C11146D76;
	Mon, 13 May 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hf/aZe5h"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8383A149C5C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586659; cv=none; b=e1jLfnNA5myXyka7D3q1wcXbLsSFmPK2InlInSFfywBvojijwnoF6CRs258ShwlRz55k+tah328ylK4z0ijtHc0ULLKrzkeQsWxiqrU6IkqtpKnaRA0JjSSwVHzCdUNcjTMzMSeMhqQ+QcDubEh9WOz8Bacdbrg4vjFA6n/Q3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586659; c=relaxed/simple;
	bh=00TaNxDFR9SZbLsbWe3QGFAcvyDgRH7e8Np3vbzu6DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ByWOXAO/He6tOza8xdXxhjlvhtCbOuv/eFJ0NMt3hdiI2FssUMAMxuiHwuzyJrEjghX7iZXzXJVnpRzC8Z1wfClA5mgo2r2N6T8+kdPCFz79k0rx9RpzLFsIvv4DB2uXLIm0K7qMK4souWn8Op/hkMJfvkXlHaTaNlgMVti+zoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hf/aZe5h; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CF3D2000B;
	Mon, 13 May 2024 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715586655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Rm+coOfyuVkQO9evbSIShb9ufh/OnsJJk+xovmjQ24=;
	b=Hf/aZe5hL3EQ4+kgN8xM+O0eN7qmURT14NlpMkuOFlzsW7Tl+FnV2zlZsz1EPuGJkEmM1O
	98W7SoRp+S8+7Ixexx4qcyzQKn42bEuM12MfJKfdG0teU0RkAb6qd25/TKVwkVgrLTgJ1O
	m9bwJdEFO97iCpHNr6byubN+liV+KVmVYkmIP7bTZL4Mj7lyKuF0YKDLMr2GQ9pqMyNTuf
	o2J20QL9zGVu9LSX01otlwJanwWG/6+X9mx3DaytLadz2rDeF/9DNpsIuMK84L62cRxUiG
	6sIkBSy+bvFTeAhSafcj9E314CLHo5bdp2h0Y4GqNHGen8QBsBDTH+uVhcVfbg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 13 May 2024 09:50:34 +0200
Subject: [PATCH v7 13/17] drm/vkms: Add range and encoding properties to
 the plane
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-yuv-v7-13-380e9ffec502@bootlin.com>
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
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=5x6LmxTgmFsdwCLT6+4+DnviNaQ8VRiCYQVGWxE2tsU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmQcZEu29XlTjUhTejDx76AyzVimAYORh5Fhh8a
 F5pfj3zxJSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkHGRAAKCRAgrS7GWxAs
 4pajEACV3ZTBEg6tNVSeAgbW0wUJuEHIvejG0md6H6lu2VED4LhfmyW3SQd2qK/7K3T+D6xPH9K
 bBkAo2nebhW03x+9Az6w8ON7wGRyNDZjkPadapJDauOr4hKt+0q8lQyqcCiEGQgUUkZNdGJDckH
 x6WoNNq94dC+SCB80i1cppe8Hqwf5qtsI93Evy8SLA7w3mMmi0nATq3ZhfWswOKvE/FbVnDkZAS
 Bt85vB3BwfQ0WED8FmjkNXd5JdmW7JTMkk3ZQzQX5E51vZr9eAafQAcwdYPKbpZMZmcJBF4mJgX
 u6HmMIhMcQsSAnovkQcDCJ+KOA46NMS3QMzWjCjcOAeCWEk3ommOiiDMGZ1k0aAQfYDinJOKD5X
 BRyAH6Gahjg56vVy5uQTwDz9jXkCLbautxeOCs/e9JYhzVW3Lg8iKtwUQbDphix87P08Pvf+U4C
 h0w2DVD5cCxxQq8+Akbmk792dGb1Q1NBiAIIhb7eUWERnpH8v2+eJNeHy3Fy/SsYB9yS6lQIn4K
 Y2YzjfxAU5T8iVtl/zOIHn8mnY10XLUJ+hpQWMFcQjmSK1hqVwU+59nPNG1TtCCyNNbv63QHUr7
 9/7qZIS59VK9xjocAKGTCtSGQ57hj3xwArMhMoXi0usWGFO7E13VBe/lY5ApNVz95bCQU+2GPWI
 6M41EbUpRp0f+CA==
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
2.43.2


