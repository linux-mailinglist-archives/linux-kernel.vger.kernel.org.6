Return-Path: <linux-kernel+bounces-445374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA459F1536
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C44D188C909
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A411E47D7;
	Fri, 13 Dec 2024 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HJIKD8B/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E01E1A33
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115646; cv=none; b=fgRuD/GhUpW+WEAfI6ZPDfwAd4YkaehVyl2hu6q+9N7il8vYVHUDFJpL8PnGUYVgfZJqbi2isjZsFkqNAcY2bQfXWSJe6V7WgaR9OK9gF52a0sAUf/1VO+9uwWh2+3Xp/XcrwKlaSoTeQQQ5KSaM/MX1UnWuaMdHI9Dag7cUQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115646; c=relaxed/simple;
	bh=2ej6OjppBuybqhCkJa0WSyYDApzYDf5lniXmhKynmQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ja81OhjpTIVCxNCB00cQXjOpdTaD1xmOklst6eT4l6DdxWh7RozhlnJfv6atQKytM8UjWyP9hfmxbCXVHvexMl20rO98DoWgSV5T3T7r+hWRMzNzDIJU3+qT/zCGUdvCmZS5ZIJuGEdNIYtei6EAOFPni6Bj4WgIrdLL6vWimHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HJIKD8B/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734115642;
	bh=2ej6OjppBuybqhCkJa0WSyYDApzYDf5lniXmhKynmQg=;
	h=From:To:Cc:Subject:Date:From;
	b=HJIKD8B/F6CALDgv5zwaAY7n66b6grrT8rC1FA4hBvbLtLJ/3rpkwL74st1yOvrkn
	 ELDRT9Kt0myXod4DhP7Vm5Ur9Ks4p/YqWOfPeLpzAK+Bz1Cuw0FSMil1XtuvwT+3hm
	 V/3KLNpgw+PSFdGwJ7JMw6MxT48oMDiUmIX2aGgjDPWnRGFMK9Gz96uY7p4qt/aXxR
	 BvWkS0AWGZxUFaI3HfeBnkGj1UNlPIC1lra9TLeK40eqZAZhSeG4A2iEfdmFCxpXfm
	 4zFTCXuNWjdyy2GnXbYtphaYwReFwkjeR3eLjp9yNJimVf3+2SG60WboWh5iQNhXsb
	 dcnckRUcVd5ng==
Received: from ericsmith-collabora.localnet (hlfxns017vw-47-55-142-63.dhcp-dynamic.fibreop.ns.bellaliant.net [47.55.142.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ericsmith)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E287E17E37DC;
	Fri, 13 Dec 2024 19:47:20 +0100 (CET)
From: eric.smith@collabora.com
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	"Eric R. Smith" <eric.smith@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: add modifiers for MediaTek tiled formats
Date: Fri, 13 Dec 2024 14:47:05 -0400
Message-Id: <20241213184705.317138-1-eric.smith@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Eric R. Smith" <eric.smith@collabora.com>

MediaTek (MTK) uses some unique tiled memory formats
for video decoding. Add these to the uapi drm_fourcc.h
so that we can use them in Mesa, GStreamer, and other
tools/libraries.

Signed-off-by: Eric R. Smith <eric.smith@collabora.com>
---
 include/uapi/drm/drm_fourcc.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 70f3b00b0681..22a27cdd6484 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -421,6 +421,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
 #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
 #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
+#define DRM_FORMAT_MOD_VENDOR_MTK     0x0b
 
 /* add more to the end as needed */
 
@@ -1453,6 +1454,36 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
  */
 #define AMLOGIC_FBC_OPTION_MEM_SAVING		(1ULL << 0)
 
+/* MediaTek layouts */
+
+/*
+ * MediaTek Tiled Modifier
+ * This is a tiled layout using tiles of 16x32 pixels in a row-major layout.
+ * For chroma planes this becomes 16x16 tiles.
+ */
+#define DRM_FORMAT_MOD_MTK_16L_32S_TILE  fourcc_mod_code(MTK, (1ULL << 0))
+
+/*
+ * MediaTek Compressed Modifier
+ * Indicates the planes are compressed.
+ * Implementation may be platform and base-format specific.
+ */
+#define DRM_FORMAT_MOD_MTK_COMPRESSED  fourcc_mod_code(MTK, (1ULL << 1))
+
+/*
+ * MediaTek 10-bit Modifier
+ * Indicates that the 2 LSBs of the 10 bit pixels are stored
+ * separately and tiled.
+ */
+#define DRM_FORMAT_MOD_MTK_LSBTILED    fourcc_mod_code(MTK, (1ULL << 2))
+
+/*
+ * MediaTek 10-bit Modifier
+ * Indicates that the 2 LSBs of 10 bit pixels are stored
+ * separately in raster order.
+ */
+#define DRM_FORMAT_MOD_MTK_LSBRASTER   fourcc_mod_code(MTK, (1ULL << 3))
+
 /*
  * AMD modifiers
  *

base-commit: 3a8e60188b55f7aff76c1d3707ebcbf98e68cc13
-- 
2.39.5


