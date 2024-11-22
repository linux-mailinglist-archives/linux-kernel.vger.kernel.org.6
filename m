Return-Path: <linux-kernel+bounces-418494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047D9D6235
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4033E283E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4353B1DF96E;
	Fri, 22 Nov 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pg/9AsI3"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B621DEFFD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292717; cv=none; b=VgWWAA+b6ndhMet3UFOE62wVx0ZBP7t3DgzfFHQZ3hLW1wC4/G/xmksAM4dpXyiiMIqFNzoHfk+hbhbr1RVhGwmNHSNNVo7a0es//kKY0k6J1UU5ZJI29JBAWH4OUNU2kBFJaytZvLZzNM8ktq9vJcCdWIIYshzAAVkNr1XzVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292717; c=relaxed/simple;
	bh=UoxOHiMTNSZuKXnSQuqgBjDi8qYlisedSJdTUWJ8t7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAoy/9AyAG6azSqJmpMJkUG5PZvR6ffCpzVsl+Kl0Ki2W0cXisHcdCxbwaI5aBMNShdI6jlnl1mV+En0UiemFhT5fmIoh0nre516clVizfkMfdAUxvA8HsO/Od0ytktq8ZplQ83Bqg0fzUYKAi8FM80WvCaP+IbDGG82W3rZhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pg/9AsI3; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C611E0008;
	Fri, 22 Nov 2024 16:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+cxTF9KCJO78YUV+0ZHhBWyFhLzGz4nnDy5LMx5b6s=;
	b=Pg/9AsI3WIp0tF98BPvN4L7upd3O+X7DoubntwCwOmpcDVM3clHX2iM4mZd/DUSAPcbV34
	3jmgilU3DnEyabD4NGHdcS1BMxXb/nikqLpRtC69J7HoDO8wt3OWlj6YOD4vV6cd/Kx7Ne
	R9Hnvbht5CvLs6vbz5OUBYSBz5IF+Gt2Y67nCnvgOuiXmKF4teevHVNkdqAGejflxiByM0
	LMuBeaJLOGluwEuDpEi+Nb8d29Nf6EPKxp+m0rIwy/m3hsFxe9TkLlEowaRwt0KMQ7SDWm
	4FMbvWHgPYV6WNUnvEaWpow6O5JskjqNRUjo2w9ssMdQFVwpSSFftwDujindLg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:25:02 +0100
Subject: [PATCH v3 3/3] drm/vkms: Add support for XRGB2101010
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-writeback_line_by_line-v3-3-085d5810f6e3@bootlin.com>
References: <20241122-writeback_line_by_line-v3-0-085d5810f6e3@bootlin.com>
In-Reply-To: <20241122-writeback_line_by_line-v3-0-085d5810f6e3@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=UoxOHiMTNSZuKXnSQuqgBjDi8qYlisedSJdTUWJ8t7k=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLBeEgU50nN/Jsq9saN6JiwszSPcxZECtubdO
 WvEhQD9nfWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CwXgAKCRAgrS7GWxAs
 4jn3EAC/ztIduKbgnP6ONI9LAQmfqHBsju5aJlvQ5lZpWSIt764Ky2t9qSDaKRi541wJ3axPjux
 zYIeQ7oTx3cRLg30YK6IkaauV7RBlwzcp4ybJKk+1Z/GUVkV4RfL58NdEuDw0cQc4arRl0nQd3R
 wJPt6S78SnJsnJE95IZuzCQMmcI/zY83bIzmr2HUcb4+dFRczy6DVmh1VFMmj1RkaFsyyQ6UQID
 Vsy8RC79MorPCdClpC6GM3j6Yz4DFTNBtNWI5dngrQwpIkv7tOCqcrFanR/NpPVqCHIVVZhVvRn
 9+LyBDVcUIBpjb6LgXbCYfNZNve1QM9o1QkKPzD3NqFIE50j/IdHrOEs8gQvwQMHhBf+6WD0CCt
 9f4cmNUwknKKiaM4oBE9kXu+6CYloMZo/X/yiyqEZ/LCZ29JUSlrBl7dkeyeQyZtXgAiVvI7R0t
 Strpq15GjTATAMIZPYEZV1W9oTayNVmi8/uxYMDRXHTid2XJR/5w4DCGM7/voUl4/F2PPJlDFK3
 /QcDsGvgNoFYnuVjrAtrkwXdS1JJCpzGgOWRpvai8hJbHU0z4PXGN7C+FASJZTyTXuOVRE/zp7R
 iieQ6YFAwAjSSU2mtGJRbW3OmMB1zKMBhsKo5psIABS598mMVtgSAoZ655gT5iftTnY0giuViGu
 c1+RREemk3A5m2Q==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Thanks to the WRITE_LINE macro, adding the format XRGB210101010 is trivial.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c   | 12 ++++++++++++
 drivers/gpu/drm/vkms/vkms_writeback.c |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 6a50a86291e50edab2058cf7d40c7efc8fcb4c12..2177310580ae19382d5fc2f095d6b49984033b61 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -656,6 +656,14 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
 	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
+static void argb_u16_to_XRGB2101010(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
+{
+	out_pixel[0] = (u8)(in_pixel->b & 0xFF);
+	out_pixel[1] = (u8)((in_pixel->b >> 8) & 0x03) | (u8)((in_pixel->g << 2) & 0xFC);
+	out_pixel[2] = (u8)((in_pixel->g >> 6) & 0x0F) | (u8)((in_pixel->r << 4) & 0xF0);
+	out_pixel[3] = (u8)((in_pixel->r >> 4) & 0x3F);
+}
+
 /**
  * WRITE_LINE() - Generic generator for write_line functions
  *
@@ -700,6 +708,8 @@ WRITE_LINE(XRGB16161616_write_line, argb_u16_to_XRGB16161616)
 
 WRITE_LINE(RGB565_write_line, argb_u16_to_RGB565)
 
+WRITE_LINE(XRGB2101010_write_line, argb_u16_to_XRGB2101010)
+
 /**
  * get_pixel_read_line_function() - Retrieve the correct read_line function for a specific
  * format. The returned pointer is NULL for unsupported pixel formats. The caller must ensure that
@@ -980,6 +990,8 @@ pixel_write_line_t get_pixel_write_line_function(u32 format)
 		return &XRGB16161616_write_line;
 	case DRM_FORMAT_RGB565:
 		return &RGB565_write_line;
+	case DRM_FORMAT_XRGB2101010:
+		return &XRGB2101010_write_line;
 	default:
 		/*
 		 * This is a bug in vkms_writeback_atomic_check. All the supported
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 0b31628e1b532367cc79cd7432aa070661f41a57..f25468bf4cd7b9253528869576111e7a3745a42f 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -19,7 +19,8 @@ static const u32 vkms_wb_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_XRGB16161616,
 	DRM_FORMAT_ARGB16161616,
-	DRM_FORMAT_RGB565
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB2101010,
 };
 
 static const struct drm_connector_funcs vkms_wb_connector_funcs = {

-- 
2.47.0


