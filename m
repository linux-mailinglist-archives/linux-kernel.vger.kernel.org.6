Return-Path: <linux-kernel+bounces-511315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A5A3294E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23105164D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF522116FF;
	Wed, 12 Feb 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d4NVGWRF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C96721147C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372219; cv=none; b=vFp/0GkUs2M/IGSPyOeJyvs4oaSierYHUUV1SSLv/0NG9KFblDfk8RSIuzRdAzZzKc66WODfcn0yIiUo8GwTFOeRCuIIHEDt7Nixgm4vMRYjOCrz4KwIeooWAJXSZBXS967zt2ILjpffBVSye9fYHAdwgpUrE8mDXf9N62z2vAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372219; c=relaxed/simple;
	bh=g4sDY099yYwC2vYw8J7DR8aRN/YzbUWG4i/WZTnG8NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2PG6X5ocx2poI6fvroRSpm/SydkfM6QL3bToHT39hdGDRezC0TutdoPNcQbVwmnSRD2iCx49XuCUNNzulKIeUBclPmbjV/t4x1io0MAuBqhxS79PbadMGpPacdoHK1f4qUL25wJR+H4CW3vRRn6bwVf+fFif1i5N8FgpiB2fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=d4NVGWRF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E1083189B;
	Wed, 12 Feb 2025 15:55:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739372130;
	bh=g4sDY099yYwC2vYw8J7DR8aRN/YzbUWG4i/WZTnG8NU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d4NVGWRFLbSTrfGsr/MsK8+qqD9swm9BetnicRcWEM01Dldo2xBu/YTUI+GGTDl/y
	 UaCXf8ZCRiu5z9P+IrLl+zaqzWPzdGCXtv+tCeCRepl14hcCR2wFlYbET7++frXRX3
	 WT36evzFDaS244N9aPefVGPj2d1+8P2IJjeX1rEM=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 12 Feb 2025 16:56:07 +0200
Subject: [PATCH v3 03/11] drm/fourcc: Add DRM_FORMAT_Y8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-xilinx-formats-v3-3-90d0fe106995@ideasonboard.com>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
In-Reply-To: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=g4sDY099yYwC2vYw8J7DR8aRN/YzbUWG4i/WZTnG8NU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnrLapqklb9snATVqBJ6qxuu9OvjBvyo/6dic/V
 kFyILyCmXeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ6y2qQAKCRD6PaqMvJYe
 9fnGD/9CXn9zwgk5uhHviktspJwIP7dZQh5Dm/E3/FaswYeY+aGqRsUEQESARI6kDz10CYSm7nk
 R9BNyzcYDIlwa1SGI+M7g8iHbhW6pZz3lhj8aw43W5mYjlb/XyyGdbfrzja8LmKRbCkr81QrFDs
 zSDAckWYfkmi0J1cDyXY1eoNRBKL7g/G+t1rBrJk91tC0md/i8UnTdi8Gd89G4KKn9vm6zslaHW
 xiWVusBhxaY97du7nuLpPQzAEONrQLvHWI6sXTdlGPvMbMaMYeqB1Dflts0I7PWucNS48Te+cue
 N8WxRaRXwG9neEFVy4MXPlW+VCqFY60DNmY1Mk+yVZXBDWG7sT7hDwkUheic1sbCekiwtFlwL9U
 bnRnDmIj6Kf9Y9BlfNSb8m6mDetPgnjWAYlN50wZaFbBE/zrZo8gpv55n2IBcgYwR4yxMM6aZpf
 0jGpCcoNzVRKVEPI7qLRfXfPFYp57iSo8kOrLnBa9ywAdxzPXEKNMaCnebpnEIhZpINtO+g8fT6
 FnPqG4BplxmKWzWZ/fbGU4xVwZI05VHRP7y+HSykXZwIQ7rYYQuiPSHQSjkHYpV8DKupRv0s9BR
 yH4X6n45JT1/vfUobRlNJIGkQDDqUY4wkApKVP3aCXciyyHJdDrZcf0ljz79jMaqcwdrzCPxjtE
 UxkHjO9Wjba4LNQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add greyscale Y8 format.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 1 +
 include/uapi/drm/drm_fourcc.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index bb0a2294573b..c8c6dd8a8d4a 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -267,6 +267,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_YVU422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_YUV444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_YVU444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_Y8,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV12,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV21,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV16,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index ead756a71825..2778cea9c861 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -405,6 +405,9 @@ extern "C" {
 #define DRM_FORMAT_YUV444	fourcc_code('Y', 'U', '2', '4') /* non-subsampled Cb (1) and Cr (2) planes */
 #define DRM_FORMAT_YVU444	fourcc_code('Y', 'V', '2', '4') /* non-subsampled Cr (1) and Cb (2) planes */
 
+/* Greyscale formats */
+
+#define DRM_FORMAT_Y8		fourcc_code('G', 'R', 'E', 'Y')  /* 8-bit Y-only */
 
 /*
  * Format Modifiers:

-- 
2.43.0


