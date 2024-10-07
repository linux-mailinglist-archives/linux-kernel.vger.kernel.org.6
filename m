Return-Path: <linux-kernel+bounces-353797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9100F9932D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FA41C23586
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BD71DC757;
	Mon,  7 Oct 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R9/EeZDD"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A81DC1AC;
	Mon,  7 Oct 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317463; cv=none; b=tLfuZ06OXeclgy7jbHDpdE5+kyDmx5ZPd1DI8nNgOVUd3a/89pfYlVDDkS3qjwvvakeDhylEj+0IRG33H6ymj6B6NQZGxYIzh39sk7Pkks4nrSFqyU1J9yMjNqRBgnLSjqH4hQ7No8pIe4yS28InYIEnznsvmG5W9/8DFhi9BuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317463; c=relaxed/simple;
	bh=gkogr80zC9IT6ygCMxlP62nYp/y4G1vFYorCtQOD8gE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hiS2lFpeLrlbnA6zEw5qkIKn48eccMRa/eApMTZS9vpsp4bq2KkZMMvd9vPMY0sqYnxVznxy39I+bROtvSAVwYSe7qHr9X3NmUZyiFwLnK948BeBkGLYXQQXtfLthchhUocGwBeBXHVkEUrj60thG9hX30uBecCyBVuP8fKuq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R9/EeZDD; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E87A40011;
	Mon,  7 Oct 2024 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728317459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZZXCAOt96HKPNadssGl+s0w7QDIgwJlOE/lg2YiDu4=;
	b=R9/EeZDDkukVZkkpMvN4WzCA52L3uu5TosmVs2Hq9zDio6+YkZ9D3dLXzwas+C7jBLX9vc
	OI0sApd/5ipfXGRb5L1BKGHeobr5B9VFT5Rgj9cRh5q5WPaFfQPvwBuGnynj8ZOxDA8Ck5
	FOgfa9peAVbUzFLcvSRJpij3elKqNMxw6jQ7pqqCyOGe+HzyqbiHkcPgJ+VQVb1UphfhnO
	fdIEZrzRHMD9MFhMhBjFhZQ5ZTic9tY/yOZXvtVql+j9IPQQ4VK8gAjh/YkwsgAbfmyG6S
	C+Hz9l0Al2Fyw8vqNZbSwnsiwdnhUwo6jBmltCcKTViR0iuO3j5pkH6xVNfr/g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:10:45 +0200
Subject: [PATCH v12 11/15] drm/vkms: Add range and encoding properties to
 the plane
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-yuv-v12-11-01c1ada6fec8@bootlin.com>
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
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=VB/TChUFVIfTCJz1NYTIIebS+nzvAngxAg3Yry+8p1o=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBAgDePR8EiFnnXUpBJ1MaJbk136pHLXy63awa
 mjQm8LrWmWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQIAwAKCRAgrS7GWxAs
 4lOtEADXdMkwzFU6SwIvoYVYrwUpCX5m0QEmypLUJsQNrR/XY1gYIpylS/4ofI2CoaGkFVYJyP6
 CMOfZDNBh3xvvECoxYFyctUKoDLj9lYqNMUvjCVuqV6Da0HbRUzHEuDyqZlv2PJXBeaf3GT797c
 efML4RfFA/7QqXDtbpBHlqrAx1oXWUSxmZUwTkJhlvtP3tLdmA+RogpNVG8Bf5q61218dJ+H5KK
 bEQgOaOzijWSbSvddUwj9SECa6z6wLmxF8lUQa5NHsK93GFYMJGYD+5IAcXnyuAiPXCO9b6EQ5n
 H0M7nmsiGeEkuu5PHIC0Z69PEWih7HOrEjDWO6g0NdxMfxWYMh/P2BU1PJXbHKbG6/vv8YK70bb
 bmxLGLJjhPhrsjCLeQb+FI/lguNSsVEfe11p9jy913dmbnduzejB2j5v1TF+BT3XRfCpA9SEJ+W
 h+pojaMbh8LbkghWAOGoBYexVBi5YNAgRYX3Xo2VWxK+iEvLz3CtnVMRtLmboptm6FbT1jaOELQ
 myXs4cHA5Wu7RDESpkCMAUW3IoIXWojzf/gGvI8xXDkQHNl0/bHNaaqm7B19p+hn6gzmUQHdUoX
 QohiOFSfeywZrBpyQ5xe77+UkSPBIoDP9CcXz2iG15DnfipoSFzFTWnIk6RbWsd9yshOfJzQ6jc
 y0vwTh7cfj35xPg==
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


