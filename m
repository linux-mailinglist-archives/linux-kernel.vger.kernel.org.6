Return-Path: <linux-kernel+bounces-519826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993CA3A259
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039433A709C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B2B26F45E;
	Tue, 18 Feb 2025 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="Z/XFcAxu"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5D26E622
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895363; cv=none; b=sQBVo8czFfCS4m6EPJt3lsPs2baD/NPJNm/fZkUGCL8E11w5Zk1dd8nqP1i0UHbKHZdV2Rm46PTze5B7Z1lDBITD5M/eVfXFohDrManHu43P4Jm+6wYl6GwkD5/YTCOBqHFpC/UcAU8twIvrogwb3Xrj5HLVw/f1vjssRQ8M/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895363; c=relaxed/simple;
	bh=SrrHl35kose8Uo9GxNf/Ij5PATQZEPvWJEFn6FxpRko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s/IKzjyrxThFbThcGeCPLncUr6LgkOrxDc/FakDn128xv22HkSAXflZSA8o2MjXl60ehJTScTJ68ErEO/T6E0/GQTqi/FhDJt6fVbDOfrISrkRd5cAFyymqr6c6nFyq2hXw05zf42dvZ+vMNKLNOlj4zttyYTxAo21L22uXjj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=Z/XFcAxu; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739895359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pZ7ABL2SNUiOCskWAI6jo53q67GpeDFRnPk2vd5ITGA=;
	b=Z/XFcAxuyGuvWQEvH3RtQFP9yao9pfJWp8JnTTU7cO9xUyY2vtZ2xuyZFifK2B2Rr03hsY
	cMDG4DQwMcS4f03Yto0FYi1AaIjG7QdYvNDSd79QvpeALNv4WWtOO2hhKjYirCJrGH5+2F
	Oox/AzWSi9Fx/TMMnMWBXpIEnjU6F39q73Yo3gWuciOFn2RKVWNZ4+gINGVGPUyB5pgh/0
	ip8jM1u/57pJuofDGiYpWUItaLg4YfXJj72zlrDM0kDx7paKOFYR7P9CjIWb/etX8NP/Ck
	PHplFuEOGc8K4r7j+eELpM3psfhohfqHzafZq/37MvYYAyu0OtoEg2k2fQKauQ==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 18 Feb 2025 11:15:54 -0500
Subject: [PATCH] drm: add modifiers for Apple twiddled layouts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-twiddled-modifiers-v1-1-8551bab4321f@rosenzweig.io>
X-B4-Tracking: v=1; b=H4sIADmytGcC/x3MywqDMBBG4VeRWTuQpFZKX0VcBOePHfASEtGC+
 O4Gl9/inJMykiLTtzopYdes61Jg64qGn19GsEoxOePextkP+xgn8HaoyATheRUNipQ5CKxvQ/M
 yZqCSx4Sg/2fd9dd1A6GTTK9qAAAA
X-Change-ID: 20250218-apple-twiddled-modifiers-fde1a6f4300c
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=SrrHl35kose8Uo9GxNf/Ij5PATQZEPvWJEFn6FxpRko=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBntLI9x9v5oGkUkxK4VSfK+AsF5c9UiDp6aY/AB
 v5U1QvOm9qJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ7SyPQAKCRD+/lBaCvVY
 DVeJD/9dSefpR/l7B4fG9didQ/l563IPyYlgcVGgklM6f8nlUnDbmH70wu6VgV5tc4ixtG+ze9g
 zU1LSWnge6iSb9QhcOb7Z4NsYq0oqvi7XloUICfwJk8cIwtOM7MhHRVg7rOA7Zxu+wD9gIPFD/I
 UBfXRMFmMYZkorqCGGg85xd0jXi7MsbwVAUfJB/417IC8DD3uawSNUD1nrEgzWCkNNWJ7WXDeEN
 CpE4kmp+WE9FjsrDLs2klHNZ0i4aqGRh7GfTHTElg2h9L2LEiHC6FjFWS1fRyjyAaxJXtUGICBA
 JUq6DOzwecZhX1U6qwLpUg/zRLt6wSWRWCu8YVBr0d+sAOk6Bq/gRTAc4tx0cYEmmZPxfBKHMPk
 6289LKKFbsiFaZR5N56hJuBHzuF88jBFbxdamlhMfpgR86oi85sJYkXSExMO4cHnWKBIPBBXPBq
 5u1wvmCGeFW47e8ONF8ROF8o8nsHMNF2LWksg8Ljo/AWSA1HpL476CEgM27MmQoHJIOWW0KwVV8
 fLkEL8evpFniPxgv91qNz/RK14VDp/vTOFCyR6U6coBfGmhnwSXr+Sf8be8NSQRIz9DpxjhYNj7
 rIRDceyWQxF9eOdffLpsWWbbQhNMRiwGKpkQdFpfWie+cykRba3ZTwy+uniM6QvDGA+6m46ILkc
 l/SU5ZJA+W69aiw==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

Apple supports a few image layouts across the SoC. To begin, add
modifiers for the "twiddled" and "twiddled + compressed" layouts. These
are the two "standard" layouts used on the GPU. Mesa requires these
modifiers to share non-linear buffers across processes, but no other
userspace or kernel support is required/expected.

These layouts are notably not used for interchange across hardware
blocks (e.g. with the display controller). There are other layouts for
those but we don't support them either in userspace or kernelspace yet
(even downstream), so we're not adding them here.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 include/uapi/drm/drm_fourcc.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index e41a3cec6a9ed18760f3b0c88ba437c9aba3dd4f..6c289fc172c099ab32bf539a1698dabb93f9a0d2 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -422,6 +422,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
 #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
 #define DRM_FORMAT_MOD_VENDOR_MTK     0x0b
+#define DRM_FORMAT_MOD_VENDOR_APPLE   0x0c
 
 /* add more to the end as needed */
 
@@ -1494,6 +1495,36 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 /* alias for the most common tiling format */
 #define DRM_FORMAT_MOD_MTK_16L_32S_TILE  DRM_FORMAT_MOD_MTK(MTK_FMT_MOD_TILE_16L32S)
 
+/*
+ * Apple twiddled layout.
+ *
+ * This is the most "general" image layout supported on Apple GPUs.
+ *
+ * Twiddled images are divided into tiles. Tiles are always 16KiB, with
+ * dimensions depending on the base-format. Within a tile, pixels are fully
+ * interleaved (Morton order). Tiles themselves are raster-order.
+ *
+ * Images must be 16-byte aligned.
+ *
+ * For more information see
+ * https://docs.mesa3d.org/drivers/asahi.html#image-layouts
+ */
+#define DRM_FORMAT_MOD_APPLE_TWIDDLED fourcc_mod_code(APPLE, 1)
+
+/*
+ * Apple twiddled and compressed layout.
+ *
+ * This is the main lossless image compression layout supported by Apple GPUs.
+ *
+ * The image is divided into tiles that are internally twiddled.  In addition to
+ * the body, there is also a metadata section containing 8 bytes for each 16x16
+ * compression subtile. By convention, the metadata immediately follows the
+ * body, after padding to 128-bytes.
+ *
+ * Images must be 16-byte aligned.
+ */
+#define DRM_FORMAT_MOD_APPLE_TWIDDLED_COMPRESSED fourcc_mod_code(APPLE, 2)
+
 /*
  * AMD modifiers
  *

---
base-commit: 0ed1356af8f629ae807963b7db4e501e3b580bc2
change-id: 20250218-apple-twiddled-modifiers-fde1a6f4300c

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


