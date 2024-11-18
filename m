Return-Path: <linux-kernel+bounces-413376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A059D1855
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA4B282C31
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555631E261F;
	Mon, 18 Nov 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h1+PRsET"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77A11E0DD4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955405; cv=none; b=mmuZ9GmSTk23g775T40CeKzt8A1EX6jPr2TUFDHMAYwZX610Fby+/1CJp03my6ij0ly/usvzEnKbql9BuejCNmIjmMPJVmpLrSyqRNxBlobQqr5tdNGpMGs+B8pBS4aFQTBJaEhRllS6R3mzO/fdGG9ivDgiZpGUrfxsxBSu0z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955405; c=relaxed/simple;
	bh=SIzwzBdacfnajhv0zU7tXJBe/BGe3mcVW0iGDrIB6DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BccscP2l3fsOvhnBhX8rK/bXaiUPOQjJD1oFEwRwZadKsKOqdcNZVpl2xwT0Um0MvZ2/voiHaoyoPO6Q0VxYhT6TtTR68s9F89R6JpO8rRJjrfso6ZKQMUbQQ4AbIY5PQ1YcmsHJiVAcUT0driTzGeWzNuygwfgxzKWoPexEBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h1+PRsET; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13C621BF20A;
	Mon, 18 Nov 2024 18:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731955402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26xs7s9BdIoNGa3cHBS2RvIJ1ygVE50uTBe/c3Hd3WA=;
	b=h1+PRsETwvFhUodug3v0iX7UIgR5N1yB/YZD+ymPGPaXemaGh8y49pm9RGs400hL8tqrIk
	6gpscBHOQF3Dbq5adAUJuOtNKhLBcKWe3IwhhZfUFB9EKgV2kqdQDT+aW4rJDqFf2CrAex
	LQK9l9psdkoJFEFOERmUBlPKsb0bEo1X5jNNHehkLBp0DNfFOxUwsz0HicuolHx/vkUelR
	iGNMhyCinjqnT/MdAYAI1y9qa8YQyNt4Ty5t67D5icXUAFMp3Rv8tq21WtJXPNijpbTjkh
	1JbtfLeDhhdWJ16w3e+V2wVMSjZY0md1Cklh+2jeAyJ+SakCNfb73tF5RfNg4A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 18 Nov 2024 19:43:15 +0100
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
Message-Id: <20241118-yuv-v13-2-ac0dd4129552@bootlin.com>
References: <20241118-yuv-v13-0-ac0dd4129552@bootlin.com>
In-Reply-To: <20241118-yuv-v13-0-ac0dd4129552@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=cgyXWAGOgZ2Vo2Ver9J5RGRcmOcUDNiv6NqXtcOkVuU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnO4rE2iRO7yC5A9ZY4vWRNAinxLDH9hFTtWm5e
 F7XqlzN+BeJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZzuKxAAKCRAgrS7GWxAs
 4iwZEADHG56gzzp7TslM8YZeyWab6zsKe5fdKzqaHBZsrzlspSwPVn/Zy2/S7kbB9ufxR3/Gsiw
 p3R5PTxuAkqAHqnEio0qBaxDbNLQHlqswj3HY5gYr0mw84uwu0g0WYLqJCBgQs2azwl3CwH0A64
 wUQepVedM00Bi5Ul7D3m2Vudl2Bq5bMpuyPlVGTBGYzYqn89m+2/vwUXv3XdZe18uWLh6Z8pVdi
 3yAmtWVHMia7/vREQSWvp3lEXt5Ueem7aeQD5d391czeEUM6+zk6ysjKusgf6aSWvhARUe4Z8LK
 kDfbwf36jEPknQo9ccZTFoM0ZL+nu9yuIFlK+iLCx42gnLCkCp1r2U/WVl1Yq20N1YOUu+iawZ+
 bfgPNE8tRyY7GGKQvraf97snkoTF7gm2i97ArXcdI3f8A4hWRlAFFEVNfw2y3fI8zx0obXNZL+W
 AyTJwanIDJ7mWq1Bp5LYYbK7Z+NjxE4qrCfXz8ZzDSG5xOrWvU9564Qaa0cgbig9cV04Yc3l4mr
 L1hWmphThREvvonSQpeME0jWfZuBV3jUp0cll+wNz7oHOPYetosQMVpubm5vCpoLvqfWMaK5KoJ
 jc29vzsMX9eV8SU74j91luBTKP/QU8lppQgwRHf48c5YrO4VHJwogZRoxRMDICdanpiPhvpVHU9
 lroVH1GbGbncFLQ==
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
index d4e375913122d3eb74d5418bd3b670cad1e62fb0..8f764a108b00a00e06370db1fc8a90163c8532bc 100644
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
2.47.0


