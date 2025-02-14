Return-Path: <linux-kernel+bounces-514169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB84DA3537C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAE616DD33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F7D39FD9;
	Fri, 14 Feb 2025 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="aneva66j"
Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDEA28E0F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495217; cv=none; b=lAALl+bJ6rT8DWXwPNRMy/LYVsDl94JI5HI3EHEBrxHxEK5Ow1K2oIcbW3OTSzhXe6o6EErhpjqIy9LDgeBr4NHRJVnj6BAhdpQMFyWLaGgw+MKBAq0BlXO++W9mNkjYTzmtib8ZbGjNOpXeQa8z5RzaE3xr8rPdF5nSYqisCI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495217; c=relaxed/simple;
	bh=oZ8NyCjs7z+25+3ZAPDoEXaqLtn+ZFW9ddncRWyxRQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6n++gEXpcjKBVWWH+pnWeh6q85M9Fj7CePQTrvH2qMfhRKs0CysIXm1p1mRjW1InIBuHK5/TWwGR8brl9ssYzn4ewm+A87ddsCnBdCNyGf9lmeF9/KWcJWkn3uQiW/jUfx9pbVMu1+LJ6phWkBEVVGoVIH6Q9O4ZXJnK7VQ9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=aneva66j; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Received: by sdore.me (Postfix, from userid 1000)
	id 07ED8EE8796B7; Fri, 14 Feb 2025 04:06:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1739495206; bh=oZ8NyCjs7z+25+3ZAPDoEXaqLtn+ZFW9ddncRWyxRQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aneva66j9xj4E1eEGIqoEZzyLw1Ylx0+fVPECiK/hqyJ9EHvVJSkzjRXRbn4rT8Vp
	 R0/qcHitIWllWMtFbb4C0Sq+Wdmmd1wDTkA3V7//INUPKZXuLdypPDbw6sXX+OiDcD
	 OTX/b73AJIzDDeFks5irfVt9KU7oJaOSmBDdwieU=
From: Egor Vorontsov <sdoregor@sdore.me>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Egor Vorontsov <sdoregor@sdore.me>
Subject: [PATCH v2 2/2] drm/edid: Refactor DisplayID timing block structs
Date: Fri, 14 Feb 2025 04:05:45 +0300
Message-ID: <20250214010545.3793736-1-sdoregor@sdore.me>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <7cab8349bc8bb6fa08d2a7127a724efea155f154.camel@sdore.me>
References: <7cab8349bc8bb6fa08d2a7127a724efea155f154.camel@sdore.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using le16 instead of u8[2].
Replaced an error with a printed warning as well.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Egor Vorontsov <sdoregor@sdore.me>
---
 drivers/gpu/drm/drm_displayid_internal.h | 22 ++++++++--------
 drivers/gpu/drm/drm_edid.c               | 32 ++++++++++++------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index 88220c107822..957dd0619f5c 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -115,25 +115,25 @@ struct displayid_tiled_block {
 struct displayid_detailed_timings_1 {
 	u8 pixel_clock[3];
 	u8 flags;
-	u8 hactive[2];
-	u8 hblank[2];
-	u8 hsync[2];
-	u8 hsw[2];
-	u8 vactive[2];
-	u8 vblank[2];
-	u8 vsync[2];
-	u8 vsw[2];
+	__le16 hactive;
+	__le16 hblank;
+	__le16 hsync;
+	__le16 hsw;
+	__le16 vactive;
+	__le16 vblank;
+	__le16 vsync;
+	__le16 vsw;
 } __packed;
 
 struct displayid_detailed_timing_block {
 	struct displayid_block base;
 	struct displayid_detailed_timings_1 timings[];
-};
+} __packed;
 
 struct displayid_formula_timings_9 {
 	u8 flags;
-	__be16 hactive;
-	__be16 vactive;
+	__le16 hactive;
+	__le16 vactive;
 	u8 vrefresh;
 } __packed;
 
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 9c363df5af9a..54122a12a24f 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6764,19 +6764,19 @@ static struct drm_display_mode *drm_mode_displayid_detailed(struct drm_device *d
 							    bool type_7)
 {
 	struct drm_display_mode *mode;
-	unsigned pixel_clock = (timings->pixel_clock[0] |
-				(timings->pixel_clock[1] << 8) |
-				(timings->pixel_clock[2] << 16)) + 1;
-	unsigned hactive = (timings->hactive[0] | timings->hactive[1] << 8) + 1;
-	unsigned hblank = (timings->hblank[0] | timings->hblank[1] << 8) + 1;
-	unsigned hsync = (timings->hsync[0] | (timings->hsync[1] & 0x7f) << 8) + 1;
-	unsigned hsync_width = (timings->hsw[0] | timings->hsw[1] << 8) + 1;
-	unsigned vactive = (timings->vactive[0] | timings->vactive[1] << 8) + 1;
-	unsigned vblank = (timings->vblank[0] | timings->vblank[1] << 8) + 1;
-	unsigned vsync = (timings->vsync[0] | (timings->vsync[1] & 0x7f) << 8) + 1;
-	unsigned vsync_width = (timings->vsw[0] | timings->vsw[1] << 8) + 1;
-	bool hsync_positive = (timings->hsync[1] >> 7) & 0x1;
-	bool vsync_positive = (timings->vsync[1] >> 7) & 0x1;
+	unsigned int pixel_clock = (timings->pixel_clock[0] |
+				    (timings->pixel_clock[1] << 8) |
+				    (timings->pixel_clock[2] << 16)) + 1;
+	unsigned int hactive = le16_to_cpu(timings->hactive) + 1;
+	unsigned int hblank = le16_to_cpu(timings->hblank) + 1;
+	unsigned int hsync = (le16_to_cpu(timings->hsync) & 0x7fff) + 1;
+	unsigned int hsync_width = le16_to_cpu(timings->hsw) + 1;
+	unsigned int vactive = le16_to_cpu(timings->vactive) + 1;
+	unsigned int vblank = le16_to_cpu(timings->vblank) + 1;
+	unsigned int vsync = (le16_to_cpu(timings->vsync) & 0x7fff) + 1;
+	unsigned int vsync_width = le16_to_cpu(timings->vsw) + 1;
+	bool hsync_positive = le16_to_cpu(timings->hsync) & (1 << 15);
+	bool vsync_positive = le16_to_cpu(timings->vsync) & (1 << 15);
 
 	mode = drm_mode_create(dev);
 	if (!mode)
@@ -6838,8 +6838,8 @@ static struct drm_display_mode *drm_mode_displayid_formula(struct drm_device *de
 							   bool type_10)
 {
 	struct drm_display_mode *mode;
-	u16 hactive = be16_to_cpu(timings->hactive) + 1;
-	u16 vactive = be16_to_cpu(timings->vactive) + 1;
+	u16 hactive = le16_to_cpu(timings->hactive) + 1;
+	u16 vactive = le16_to_cpu(timings->vactive) + 1;
 	u8 timing_formula = timings->flags & 0x7;
 
 	/* TODO: support RB-v2 & RB-v3 */
@@ -6848,7 +6848,7 @@ static struct drm_display_mode *drm_mode_displayid_formula(struct drm_device *de
 
 	/* TODO: support video-optimized refresh rate */
 	if (timings->flags & (1 << 4))
-		return NULL;
+		drm_dbg_kms(dev, "Fractional vrefresh is not implemented, proceeding with non-video-optimized refresh rate");
 
 	mode = drm_cvt_mode(dev, hactive, vactive, timings->vrefresh + 1, timing_formula == 1, false, false);
 	if (!mode)
-- 
2.48.0


