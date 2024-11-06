Return-Path: <linux-kernel+bounces-398291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB459BEF0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E45D285A63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B010335B5;
	Wed,  6 Nov 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jcGKYurY";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Wp3z/iZY"
Received: from a7-32.smtp-out.eu-west-1.amazonses.com (a7-32.smtp-out.eu-west-1.amazonses.com [54.240.7.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F715C138
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899814; cv=none; b=gqHr7Fy+x+wcHRntdcfbydQGHQqtikhegaR2D18CHtXhXZOJ5uqJR8rNqm3WJBKkLmnHdl/Q85I255W+C1jfJPtUcso1U5ju850gNAGjgj5QOkEcEtxv+mR2IA3Eua41AVNEteawjj+WiCLwg9NZpymCVa6XN9zYaWijredQ0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899814; c=relaxed/simple;
	bh=JuJPylewezAPI7wSda7iVtJm+RTVZzYzft96qUfPDBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYmK6FN0iPM8HCBN48jJuGAyz8HqFoeyp4HoIinflEg9YTxnoIWRfi633dQN9C4JGiGhMjFVIyRW6MxNXpEiBnYYZbDt2WM2+ogsh2rTuZBs9gzw24fIR8P+VdQ5Z4j5ymFJKbkYpaGm47lELXWxwEKXUNbUJdIBg7Rq8K4ffN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jcGKYurY; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Wp3z/iZY; arc=none smtp.client-ip=54.240.7.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bc7lryepznv65m6r2ewkpoafjt4fiq42; d=collabora.com; t=1730899811;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=JuJPylewezAPI7wSda7iVtJm+RTVZzYzft96qUfPDBM=;
	b=jcGKYurYf124PKWF4I14ez5MbPaSNFtW/88QhTUfBFr/PWe2G5uEvJ9IAfn+iv+d
	vwGlNH4JABfD7UIbm2MmiyOWsxrh45d1AyEAkBx6p9LOZ3E7AcfBph2inniDsm1EOMF
	hcQeF+s1JQgqnsiqPGEgj/4ckYoksym8izKBnVtTpZmHvuuwcDgEKDP1pMrRLKOoK/w
	gwpKqg84OlLesmdjpGtzIpBdOV+FeRnjKX/RV8TytbLr8eBMA8GFu3hZ0sEEM1eI55R
	hGR1U7cC0rINdAYbqABWjfBcOjBfaUEWGlWWer4A37Og0obt4SxP3CSbpkYtRC4tIZ1
	3qSr1Q6R1w==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1730899811;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=JuJPylewezAPI7wSda7iVtJm+RTVZzYzft96qUfPDBM=;
	b=Wp3z/iZYE/gCiwA7eVXrW4AiKI1lsvJEToaCQFUM9T+J0UG2sPyuGD/cBBJ/fjLz
	ifSQW4M3YluLkb/lNX3OnmtKA2A8E/s477iaVYTBgemy9camlRTraAtr+OYTFYRCB06
	kBL2qPQz9tie7rVgmPqqFeeb//5Vp/SaunZSq228=
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	laurentiu.palcu@nxp.com, aisheng.dong@nxp.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.org, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] drm/fourcc: Add modifier definition for describing Verisilicon video framebuffer
Date: Wed, 6 Nov 2024 13:30:11 +0000
Message-ID: <0102019301ab1b2d-5539e1c7-e026-47bc-8692-b3335f6f7584-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.11.06-54.240.7.32

Verisilicon hardware video decoders can produce tiled (8x4 or 4x4)
and compressed video framebuffers.
It considerably reduces memory bandwidth while writing and reading
frames in memory.

The underlying storage in NV12 (for 8-bit) or NV15 (for 10-bit).

Display controllers, like imx DCSS, could use these modifier definition
as input for overlay planes.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
The original code comes from:
https://github.com/nxp-imx/linux-imx/commit/ab01b7fe82d5a11dfb533cfbd08c4dfa140815de
I have port it and modify DRM_FORMAT_MOD_VENDOR_VSI value.

 include/uapi/drm/drm_fourcc.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 78abd819fd62..31d09a98d0d7 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -421,6 +421,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
 #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
 #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
+#define DRM_FORMAT_MOD_VENDOR_VSI     0x0b
 
 /* add more to the end as needed */
 
@@ -1607,6 +1608,32 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_CLEAR(field) \
 	(~((__u64)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
 
+/* Verisilicon framebuffer modifiers */
+
+/*
+ * Verisilicon 8x4 tiling layout
+ *
+ * This is G1 VPU tiled layout using tiles of 8x4 pixels in a row-major
+ * layout.
+ */
+#define DRM_FORMAT_MOD_VSI_G1_TILED fourcc_mod_code(VSI, 1)
+
+/*
+ * Verisilicon 4x4 tiling layout
+ *
+ * This is G2 VPU tiled layout using tiles of 4x4 pixels in a row-major
+ * layout.
+ */
+#define DRM_FORMAT_MOD_VSI_G2_TILED fourcc_mod_code(VSI, 2)
+
+/*
+ * Verisilicon 4x4 tiling with compression layout
+ *
+ * This is G2 VPU tiled layout using tiles of 4x4 pixels in a row-major
+ * layout with compression.
+ */
+#define DRM_FORMAT_MOD_VSI_G2_TILED_COMPRESSED fourcc_mod_code(VSI, 3)
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.43.0


