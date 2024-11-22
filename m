Return-Path: <linux-kernel+bounces-418453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A209D61D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600F716073D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC91DE8BE;
	Fri, 22 Nov 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TzJ0wrK6"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C41DEFF4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292118; cv=none; b=bFeBsObkv0hq62SMa/zKcMhr/reK6vEXrlaTE1lEsojYySa3ru0CSw+eO0QWLiewWqVCfk/e32f/Gej2Db5lOpiM1i4L4/ECmLQ4YztSiUnBUMSzvEhAA/gza3debIiD6wVemwf5xnZYYxXOj0IBLR7h5sTwr+TsakP6vPImdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292118; c=relaxed/simple;
	bh=5+1bxkH/6jvM+bSYJwMzoEEdlhRHb3TLK4V00AuCHaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJle3nZWVHxQljyoE1IpEOCnhrjYemIrMuXYxSNpm/ogiqV+s2pdfRCvR9Ss0Z7IigtW0cGz/62cQshXoxjIs7/7LS/oMLO9S340Eb+7jUhVdeHbph23n1vy4yaU08rZusVFME5xO4OaeygcmOzcpqHt1PNf32kFTjKZbYDKq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TzJ0wrK6; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 333C61C0003;
	Fri, 22 Nov 2024 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+pwLDbgu9jtYV4f1M50fqXd9jWC2o3HSRBRiNLxp+j4=;
	b=TzJ0wrK6XmrRm3xGQDt9lgl0Yxh/jQfnuNaJCoTBltvu+C0eoKLKGoZx1B+nHR0mxizAri
	yXmwySkLzCPWwzlx492l55Y1A+K/MJlS7QU+oS3Y+ApwtA7V61lyUTNvnNrFKAMYsQfC68
	X1xgxT6fdEhuWv2Ch4Q2+B4h6QDCE1+XgIAZ1suAbiqIpvho81hSyPl73k3LLp2Zefc13E
	kxp/NizTiUp+QXfUUsorIgWSwqGVVbLN/PB6lN61WNmiwgR89fh/wS3jGmVcBOXrROCMje
	P6Ab9CF6rpb4iaY7/T+6AGBp9e/XVtJXczjFVSCPcPHUmy3V4ld20rNR4F3EGQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:15:02 +0100
Subject: [PATCH v14 2/7] drm/vkms: Add range and encoding properties to the
 plane
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-yuv-v14-2-e66d83d28d0c@bootlin.com>
References: <20241122-yuv-v14-0-e66d83d28d0c@bootlin.com>
In-Reply-To: <20241122-yuv-v14-0-e66d83d28d0c@bootlin.com>
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
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=3qxUodTpFhGEQUZhya3OvUZpOZdhecRKqdRQipLiUwM=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQK4HddvcCxD1JVvtGNXQIdg92GB/lL0+bPGxI
 PactfCnFM6JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CuBwAKCRAgrS7GWxAs
 4qi6D/9Pq1Gwe3AULloaYgUUWkL35YnHFCLjXE7TldWGRaM7cbjzFCFnlnlhFOAif6NGstI6wRc
 iKx7kui82YyJmIZzolzXn/3aqqpY0dHnavHa9QsLSRa0Doq80QhzK8NcrTD6O9LyVKtgp9PnO8A
 SdPHrPRz+8kICVkKU9sTAephIO4xiZAGuYpEef6t0WLQnB/dSvc1ee1zLpURSI0ONCAfVNV5G0m
 1w4IvA/1NeWGPd4dBHNjxQU0lmpxFi5rKl+Tpaj2WNCACEVsyNdQvHFEoD3iekmcXrmbCGT/IDK
 uyOVgh1tg04qCi1bd4PL8nWQAvNEPIjlxV+xQjouudVF9C54ESIW1F2o/nQlcip/r/jgWx0nSyH
 HZd2Na25+hPhR9NnEZ7nZ9nmjMMY9nIz4NtSy5Sr56uewe8GpYReVtUEM3YYJ1XbEpj/wrL/JUP
 ooqWvqCq8N/1engWdnkEdnzsK5NXQ9MjUxdGtWACewq4sEtD/q1UnTK3Q6nGEgeXV65I572QIMp
 TOAjbVfyykrcNM5/F90xseeSJt1aSmAbN+/qm7vEV6fFU4ESHKyL5eF1y9gh2ePQz1LhtTrebUk
 52kWX3gbarppOMizNxmIm855y5xXc4cDLldVRxjLqqLitwX0pXYz46dS94sDuTwpGUozDJcYsSg
 RYdTaqwYAOV57lQ==
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
index 10e032e146f093d0fd99a82c7b58d62a0d987fd7..e6ca8f2db32d92068ddba7eed92cfae0d28cd45f 100644
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


