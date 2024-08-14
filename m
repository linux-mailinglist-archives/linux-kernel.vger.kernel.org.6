Return-Path: <linux-kernel+bounces-286102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6A3951680
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695DB285B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C832BB1C;
	Wed, 14 Aug 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d8pyUrR6"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C384140E23
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623595; cv=none; b=EPPw81h9g5gOtxklD+8Q/p4AS49HN/A1FD6gSqI60SHbTFvRdzqMHNbn6Png83QMvEheb5R3a5jadmKYAfcQuOYIapHbIdqirbFdvkZRNmWKn+pTiX2Z9+DbTa55nA8Pe/dkTIZCMs71iD6EedSeUgehasBoYWDoLVyodUFa/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623595; c=relaxed/simple;
	bh=7ArWQ6zmluvsBt86X5iI6qfLzvj8UuOSAivLRhVa7ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UhuNcAgYpTi5LBe7aVjhOKhFFEa0c+Rk++bXiKE9IJBr3mgUgaNpiHThMWnnKd4kAe3P+bzRiFzK4Pi5Q4BMaV2CTEtkpUqtmBE5dbjvnhS6n5b9VN1YCPlXNq2caNKQdp44j96j34bDNaXbNhdRybchILlHObsw8+i/nI7jexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d8pyUrR6; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 573E2C0005;
	Wed, 14 Aug 2024 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723623591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwwNkXRY6lmEOrw+igTtyBvP0kqQ2nuCn+F4aNEGdA0=;
	b=d8pyUrR6PvMudhd//6Tee3KDrZG3EWCRfU/fxIlCsU7dPz1Ac7MgI3a4NreTU+OTdENhXe
	e1O4HREcqIodD1CeGIAwVJ7eGw5qR2MqiVDZ/EJ9l1ghc5j0wpkVUbqHu0jlb2f6WhX3y1
	wEjvsC59RHDU/9WnJs98Io+NuBOJBuNOwxV/ZOtHuEtqO5UyJCqhD0ObuftTVgoQsYlZH4
	HFFRveqU0VERF1qKic2K8NZkCJkUUcvZC7v2Qmijgp6pDzH9fPy709OMwc9fMt1d12NolZ
	TxL8Np1skak2jOTiAAz71xybdyexLAGAfHL2FACvk2VTQRMkVL02Fh4IKu4z5A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 10:19:38 +0200
Subject: [PATCH v2 5/8] drm/vkms: Add support for RGB888 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-new-color-formats-v2-5-8b3499cfe90e@bootlin.com>
References: <20240814-b4-new-color-formats-v2-0-8b3499cfe90e@bootlin.com>
In-Reply-To: <20240814-b4-new-color-formats-v2-0-8b3499cfe90e@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 20240809-yuv-v10-0-1a7c764166f7@bootlin.com
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=7ArWQ6zmluvsBt86X5iI6qfLzvj8UuOSAivLRhVa7ME=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvGifl9B5RmcfASNaIaQhRARs3R1E5LCSYIVw3
 PkLczYF4TOJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrxonwAKCRAgrS7GWxAs
 4o1oD/9rd4sBtqP8VEkWITf/LVIPQw8iSTTL0cEaUm5yoJEq/CF5p7cZXpiry11y1CqQdX653jt
 ht53CLOnESvWSm5K00NuteMEtqQkCxyu/Zr6GXlxBwf01xVIJ/jI7bSL3jkyN5sBQ2DyEgfc/On
 AwvUwGyOHFeElBeVfYj1jTj1tYBXFvnvpxMXuT7GOa1x351S4BzDQg2wYyXqC0KpHGUmRU4uAIb
 mfW69IvEnBtYAXDE5nYTupaYe1JxaopO7ENqhZhS7vQuQW8A1eyuGC1x3+qEw/ZNe5dEEBc/jVz
 W9bZ8AxtDxao5q4hjrHxtD76/sLtEmHHAy+vZ/W9XRiTcgK668XFzTEV5iSoMldPI+WMNjnlH3O
 0I3lf7HzH6XQS2n+OTNnJANqwUBuGvJ33tYIKY3aVL3TzViwblayzIypa8wRGNOxMoWpMWw3EPB
 rs6pZ+5kzYcRvrm8UrB1U1RSPmcrQlZen3M/4VvvNI/7+fSBlZVsd5Kc3/4RXoV+ipAI1tfS14B
 Jrc/Zht6xfNUD70y20DwjgIN5bSEkYuTlhXWKRIIq6ZG3ytmyeUbPsQsZOONq/UEt0+WYjiPI3h
 c5Nm9fWlRV37EHMd9K4HyOWvmxUcO42OIlFC8jIxigsuxBu9Fw7X1YyI3ETXr5RbGO2HSzowDw8
 45GiXmDBcA8fOfA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Add the support for:
- RGB888
- BGR888

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 7 +++++++
 drivers/gpu/drm/vkms/vkms_plane.c   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 76cefd301b4a..b7c378552340 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -459,6 +459,9 @@ READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
 READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
 READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
 
+READ_LINE_ARGB8888(RGB888_read_line, px, 255, px[2], px[1], px[0])
+READ_LINE_ARGB8888(BGR888_read_line, px, 255, px[0], px[1], px[2])
+
 READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0])
 READ_LINE_16161616(ABGR16161616_read_line, px, px[3], px[0], px[1], px[2])
 READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0])
@@ -677,6 +680,10 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 		return &RGBX8888_read_line;
 	case DRM_FORMAT_BGRX8888:
 		return &BGRX8888_read_line;
+	case DRM_FORMAT_RGB888:
+		return RGB888_read_line;
+	case DRM_FORMAT_BGR888:
+		return BGR888_read_line;
 	case DRM_FORMAT_ARGB16161616:
 		return &ARGB16161616_read_line;
 	case DRM_FORMAT_ABGR16161616:
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index a243a706459f..0fa589abc53a 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -21,6 +21,8 @@ static const u32 vkms_formats[] = {
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_RGBX8888,
 	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
 	DRM_FORMAT_XRGB16161616,
 	DRM_FORMAT_XBGR16161616,
 	DRM_FORMAT_ARGB16161616,

-- 
2.44.2


