Return-Path: <linux-kernel+bounces-514860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671E1A35CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B75166D87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC82638B0;
	Fri, 14 Feb 2025 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="KcWGSNSa"
Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB280221541
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532983; cv=none; b=D/OERfnElrgpb9plnJJZYHvokB6TVV3pUSiXOkgL/LD0XXbfK1jgVBF0axU5t7KHi9gSO2BlRct2OSXD5k6SGfQrrEx2x62pTFcaOxhb1vtnuTod0cl7PMbU7JofGoXVyIELLWT0s/hEZRzKR4iWcibYY3pT8l84geU5Ytj6W90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532983; c=relaxed/simple;
	bh=vooFqMlynklDcHryHXQc2YlfwBSZBFLunnWC36YDAwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dGVd3I8oPWQeTy8mC1vk2sBWOZLZzPs2vDJcjEMZ1QQCqUeTSZAl5V1pPBH87PQJ85u2YLKyueYbhOWfQ3Yx9gbnni6JgdOThNFYH2vW4TEEp+wkJFDzvnnx+DHKOPj82pGymPPgVtrSBycOryjSH1LbdrIJWKX9t+++EMgl93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=KcWGSNSa; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Received: by sdore.me (Postfix, from userid 1000)
	id 16BFCEEA018FB; Fri, 14 Feb 2025 14:36:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1739532977; bh=vooFqMlynklDcHryHXQc2YlfwBSZBFLunnWC36YDAwA=;
	h=From:To:Cc:Subject:Date;
	b=KcWGSNSae+PoERrq6+Suh/STescbEU4osKf/k0JKd1lzjzbGr1mH4BNAvXipy1HgH
	 49lKzJ+Z6NFJqXk0QW1deZFUxdDGX2nLa1MvcdwBnCM4UdvHb/AtBtYtBEghLhHt9L
	 70fWTD7Rhspa1SkclFmm6m2HbDoXKsfWOZj3Yz0Q=
From: Egor Vorontsov <sdoregor@sdore.me>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Egor Vorontsov <sdoregor@sdore.me>,
	=?UTF-8?q?Maximilian=20Bo=C3=9Fe?= <max@bosse.io>
Subject: [PATCH v3 1/2] drm/edid: Implement DisplayID Type IX & X timing blocks parsing
Date: Fri, 14 Feb 2025 14:06:41 +0300
Message-ID: <20250214110643.506740-1-sdoregor@sdore.me>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some newer high refresh rate consumer monitors (including those by Samsung)
make use of DisplayID 2.1 timing blocks in their EDID data, notably for
their highest refresh rate modes. Such modes won't be available as of now.

Implement partial support for such blocks in order to enable native
support of HRR modes of most such monitors for users without having to rely
on EDID patching/override (or need thereof).

Closes: https://gitlab.freedesktop.org/drm/misc/kernel/-/issues/55
Suggested-by: Maximilian Boße <max@bosse.io>
Signed-off-by: Egor Vorontsov <sdoregor@sdore.me>
---
 drivers/gpu/drm/drm_displayid_internal.h | 13 +++++
 drivers/gpu/drm/drm_edid.c               | 63 ++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index aee1b86a73c1..84831ecfdb6e 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -66,6 +66,7 @@ struct drm_edid;
 #define DATA_BLOCK_2_STEREO_DISPLAY_INTERFACE	0x27
 #define DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY	0x28
 #define DATA_BLOCK_2_CONTAINER_ID		0x29
+#define DATA_BLOCK_2_TYPE_10_FORMULA_TIMING	0x2a
 #define DATA_BLOCK_2_VENDOR_SPECIFIC		0x7e
 #define DATA_BLOCK_2_CTA_DISPLAY_ID		0x81
 
@@ -129,6 +130,18 @@ struct displayid_detailed_timing_block {
 	struct displayid_detailed_timings_1 timings[];
 };
 
+struct displayid_formula_timings_9 {
+	u8 flags;
+	__le16 hactive;
+	__le16 vactive;
+	u8 vrefresh;
+} __packed;
+
+struct displayid_formula_timing_block {
+	struct displayid_block base;
+	struct displayid_formula_timings_9 timings[];
+} __packed;
+
 #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
 #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
 
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 13bc4c290b17..03edf0e1598e 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6833,6 +6833,66 @@ static int add_displayid_detailed_1_modes(struct drm_connector *connector,
 	return num_modes;
 }
 
+static struct drm_display_mode *drm_mode_displayid_formula(struct drm_device *dev,
+							   const struct displayid_formula_timings_9 *timings,
+							   bool type_10)
+{
+	struct drm_display_mode *mode;
+	u16 hactive = le16_to_cpu(timings->hactive) + 1;
+	u16 vactive = le16_to_cpu(timings->vactive) + 1;
+	u8 timing_formula = timings->flags & 0x7;
+
+	/* TODO: support RB-v2 & RB-v3 */
+	if (timing_formula > 1)
+		return NULL;
+
+	/* TODO: support video-optimized refresh rate */
+	if (timings->flags & (1 << 4))
+		drm_dbg_kms(dev, "Fractional vrefresh is not implemented, proceeding with non-video-optimized refresh rate");
+
+	mode = drm_cvt_mode(dev, hactive, vactive, timings->vrefresh + 1, timing_formula == 1, false, false);
+	if (!mode)
+		return NULL;
+
+	/* TODO: interpret S3D flags */
+
+	mode->type = DRM_MODE_TYPE_DRIVER;
+	drm_mode_set_name(mode);
+
+	return mode;
+}
+
+static int add_displayid_formula_modes(struct drm_connector *connector,
+				       const struct displayid_block *block)
+{
+	const struct displayid_formula_timing_block *formula_block = (struct displayid_formula_timing_block *)block;
+	int num_timings;
+	struct drm_display_mode *newmode;
+	int num_modes = 0;
+	bool type_10 = block->tag == DATA_BLOCK_2_TYPE_10_FORMULA_TIMING;
+	int timing_size = 6 + ((formula_block->base.rev & 0x70) >> 4);
+
+	/* extended blocks are not supported yet */
+	if (timing_size != 6)
+		return 0;
+
+	if (block->num_bytes % timing_size)
+		return 0;
+
+	num_timings = block->num_bytes / timing_size;
+	for (int i = 0; i < num_timings; i++) {
+		const struct displayid_formula_timings_9 *timings = &formula_block->timings[i];
+
+		newmode = drm_mode_displayid_formula(connector->dev, timings, type_10);
+		if (!newmode)
+			continue;
+
+		drm_mode_probed_add(connector, newmode);
+		num_modes++;
+	}
+	return num_modes;
+}
+
 static int add_displayid_detailed_modes(struct drm_connector *connector,
 					const struct drm_edid *drm_edid)
 {
@@ -6845,6 +6905,9 @@ static int add_displayid_detailed_modes(struct drm_connector *connector,
 		if (block->tag == DATA_BLOCK_TYPE_1_DETAILED_TIMING ||
 		    block->tag == DATA_BLOCK_2_TYPE_7_DETAILED_TIMING)
 			num_modes += add_displayid_detailed_1_modes(connector, block);
+		else if (block->tag == DATA_BLOCK_2_TYPE_9_FORMULA_TIMING ||
+			 block->tag == DATA_BLOCK_2_TYPE_10_FORMULA_TIMING)
+			num_modes += add_displayid_formula_modes(connector, block);
 	}
 	displayid_iter_end(&iter);
 
-- 
2.48.0


