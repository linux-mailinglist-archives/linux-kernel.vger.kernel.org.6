Return-Path: <linux-kernel+bounces-281351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8484F94D5D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F254281AF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715C16B3B4;
	Fri,  9 Aug 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pegPyi1X"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957E16132A;
	Fri,  9 Aug 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226115; cv=none; b=opfL96pV3ac+9m+oLPn9zDAL5cqeCAQA58NeN+ZjJ4bFtWMP9F2echfIouaGw7ul/N1HdobJdp7fpODyi5USzi4yWJAfCB/bv+bxTIUBw2FoP4Q2g7p/ExAbOACH/R5nzSyHXhSNedrZAryhcZZfeJFdFCpk5Rz8KR/17gdFx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226115; c=relaxed/simple;
	bh=CmWt7+MSx1bbYURoIV8tsNYf7uiASsJlKHa2TtpIAHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Flmn2LZYFSQmVXMQYczVCo12Iz0+Bw0/+N/IqH568c5LlRbwDRS/z4c2kqDcgfqWL1V01PnsrI3sWCKxG1gPS7btpJIg6dg0LcKLRz4+I/5bcX/RZZ3FAqj39wdCHog3evX2Q490ZsBrL0r0qblLZ020Lo+m+yQ7g/1/cqyyCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pegPyi1X; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABD8EFF802;
	Fri,  9 Aug 2024 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723226111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1N2wKhCx93t2SWK5sURoLWP8YIYqRV+8fF3gnv/nic=;
	b=pegPyi1XrFfwfvrJc9HqcEgkQ7fk6hSfFO7vHZIbDeodexTrGLLnKjdPm+66YnzyJhcHbW
	/37sIskymzyFGamT26z7bDIr3wzWEckttnqizy0KiRAq3P/vY0Of/++OPNVM6DVh9viRRO
	8iTbxyaKcGNCx4nI+ZECTBvmAHMssDcQEOhIhfgEzKbndikIVknmUzmL1QGIvHFzcTuWPP
	gUI94nYXoBAdME3juTR7dMXcgfuiIa+SK1hl+LeUtZ2vCTT85SnYC0iQL72itGuvwKnvTH
	ya+9HAMRVJjUC+jKORZTRGTGJLIVcMNfau4d9SXtcmO/a3rSlMiK9ej/VJcWPg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 09 Aug 2024 19:54:53 +0200
Subject: [PATCH v10 12/16] drm/vkms: Add range and encoding properties to
 the plane
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-yuv-v10-12-1a7c764166f7@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=lX/b6aaWAzynVQwgJ4uAbWlqpIRVGyKzYZlNlczj/Es=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmtlfqXInQ0T7WeY08BqYeex2VR4d1+WX6YCHqk
 JYK2ibYpV+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrZX6gAKCRAgrS7GWxAs
 4uqaD/9YLD8u729GH1VibT8fQeotsBcoLiLAaiiZ3wSrvsqUA+WyiTuiXIu9AWxlRJ3dfGruked
 u/PwhhbnRxFUpn4xxWo7YjBHq3iBVPROxy6DBOTMd5sVA+UDUBYCg1PrjyGS2GqrzA4oAeTd0Gu
 fQaJ3IhBKWOAt5CFp2TyuF+8ILRY20sYA75bcMqRX42jcEa/D563OTYhfDnrVw+j2rJqCrqYbU1
 F3ESeNhIWV3W19n3kCHO8IBvAFcje8c8duA8u+63Epet2jtFHN9FdJyp/pVOzzsqVsaONmyfeHz
 6T3rDh6Q0ALV0ohUw1Z8zqbwiyrhVKTai77yEYTlVdPu0TkeiwagkX9j+cTE8HW6+O/DF7Uenj7
 rQs7F33yIGPuUahAtrborbbvnfZTMd57NSZgJNIDTq1JamR6iAg7grVpB+KBhDhh/6KfaSM+9Uq
 VmrOjD/llXuDnH6mrQt6JBRzOMMMlDZPbAdxtvUWljNs+h4ntpSIExdXeAPF1EJwtv/z+Kd6X5f
 s9vyZKnKobkfItreby9KWpuhs8GEWGfFqHTf6u5BQS8tD1tt4BT1NP/xRS5IvYGexpfpGFwgb5n
 90ttRgPrAeKWqXxuwaBIUOC9VOdN1CuuvLlAQSemndXZoMtiSddtMQDk3GajEgc+kpFQ1xtKIJ9
 N2PLxMTAhBk8w+A==
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


