Return-Path: <linux-kernel+bounces-439236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759E9EAC99
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CE8188C805
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B892343A0;
	Tue, 10 Dec 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzzJZ3pe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF82210F61
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823412; cv=none; b=q60tqTsb3/m9Vprj49DSo7q/Jgr/hE4ijvGpvIZhy8GnU5HqTtoAKhUTa8Yi/z4wuRNeZClz1KAYrtMKzkNlCgW/ChGYJNl5HWOFBJ/90Jo1LhxU24SxwWS9o89C3xyBsi9bWSHYwi8prfPjb2DYkEOlfh1gXZ4zDFhoXj7fbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823412; c=relaxed/simple;
	bh=+aIvRKa1y+nM3aRFrs0jGmNsVid+NxEL4P69d6AN5rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiYh7dkgXkZyOftAQJQqKi0FRWioYc40WmQ/cXm7V5eICIUYEeAD4s1RDSzj87Bdvj2RGd4j9Pf5Dsi02GtM2bPPOHVGKVj7G6s3p6hE5F3o4inzNILeBdUYf6bB95qv4FB497D77fp5azlgNyDx765orXjHKYTHWfv9FkHQZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzzJZ3pe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733823409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uKV5q8ipSveT5v4CsCghLySmLeYGPu3Ntq0jxSCKrk=;
	b=HzzJZ3pe4tXtXX6JyLvE2VN/hhjL5oNzQcy1ZhW11pCfpYkDrauzw4G6Ja7bhhbvfh7/KP
	vpeIrHg5mWJvBPnO6k7CB2Y3JCAY88SlY9uvrfZW3mGEW9lShsdHr/f6RcpiBMs4lr9VYC
	noXqhgaws3ZSxXdTjhSaZzapKquqW20=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-i-BSR-UAO2uk7Hp6W-yqxA-1; Tue,
 10 Dec 2024 04:36:48 -0500
X-MC-Unique: i-BSR-UAO2uk7Hp6W-yqxA-1
X-Mimecast-MFC-AGG-ID: i-BSR-UAO2uk7Hp6W-yqxA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA4271956089;
	Tue, 10 Dec 2024 09:36:46 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A827E1956089;
	Tue, 10 Dec 2024 09:36:43 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v3 6/6] drm/i915: Add drm_panic support for Y-tiling with DPT
Date: Tue, 10 Dec 2024 10:28:46 +0100
Message-ID: <20241210093505.589893-7-jfalempe@redhat.com>
In-Reply-To: <20241210093505.589893-1-jfalempe@redhat.com>
References: <20241210093505.589893-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Alderlake and later, it's not possible to disable tiling when DPT
is enabled.
So this commit implements Y-Tiling support, to still be able to draw
the panic screen. The Tile-4 support found in the latest Intel GPU
will come later.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 .../gpu/drm/i915/display/intel_atomic_plane.c | 70 +++++++++++++++++--
 .../drm/i915/display/skl_universal_plane.c    | 17 +++--
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index bafb1421f3b30..a88f09f6227f5 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -1214,6 +1214,33 @@ intel_cleanup_plane_fb(struct drm_plane *plane,
  */
 static struct iosys_map panic_map;
 
+/* Handle Y-tiling, only if DPT is enabled (otherwise disabling tiling is easier)
+ * All DPT hardware have 128-bytes width tiling, so Y-tile dimension is 32x32
+ * pixels for 32bits pixels.
+ */
+#define YTILE_WIDTH	32
+#define YTILE_HEIGHT	32
+#define YTILE_SIZE (YTILE_WIDTH * YTILE_HEIGHT * 4)
+
+static void intel_ytile_set_pixel(struct drm_scanout_buffer *sb, unsigned int x, unsigned int y,
+				  u32 color)
+{
+	u32 offset;
+	unsigned int swizzle;
+	unsigned int width_in_blocks = DIV_ROUND_UP(sb->width, 32);
+
+	/* Block offset */
+	offset = ((y / YTILE_HEIGHT) * width_in_blocks + (x / YTILE_WIDTH)) * YTILE_SIZE;
+
+	x = x % YTILE_WIDTH;
+	y = y % YTILE_HEIGHT;
+
+	/* bit order inside a block is x4 x3 x2 y4 y3 y2 y1 y0 x1 x0 */
+	swizzle = (x & 3) | ((y & 0x1f) << 2) | ((x & 0x1c) << 5);
+	offset += swizzle * 4;
+	iosys_map_wr(&sb->map[0], offset, u32, color);
+}
+
 static void intel_panic_flush(struct drm_plane *plane)
 {
 	struct intel_plane_state *plane_state = to_intel_plane_state(plane->state);
@@ -1232,6 +1259,34 @@ static void intel_panic_flush(struct drm_plane *plane)
 		iplane->disable_tiling(iplane);
 }
 
+static void (*intel_get_tiling_func(u64 fb_modifier))(struct drm_scanout_buffer *sb, unsigned int x,
+						      unsigned int y, u32 color)
+{
+	switch (fb_modifier) {
+	case I915_FORMAT_MOD_Y_TILED:
+	case I915_FORMAT_MOD_Y_TILED_CCS:
+	case I915_FORMAT_MOD_Y_TILED_GEN12_RC_CCS_CC:
+	case I915_FORMAT_MOD_Y_TILED_GEN12_RC_CCS:
+	case I915_FORMAT_MOD_Y_TILED_GEN12_MC_CCS:
+		return intel_ytile_set_pixel;
+	case I915_FORMAT_MOD_X_TILED:
+	case I915_FORMAT_MOD_4_TILED:
+	case I915_FORMAT_MOD_4_TILED_DG2_RC_CCS:
+	case I915_FORMAT_MOD_4_TILED_DG2_MC_CCS:
+	case I915_FORMAT_MOD_4_TILED_DG2_RC_CCS_CC:
+	case I915_FORMAT_MOD_4_TILED_MTL_RC_CCS:
+	case I915_FORMAT_MOD_4_TILED_MTL_RC_CCS_CC:
+	case I915_FORMAT_MOD_4_TILED_MTL_MC_CCS:
+	case I915_FORMAT_MOD_4_TILED_BMG_CCS:
+	case I915_FORMAT_MOD_4_TILED_LNL_CCS:
+	case I915_FORMAT_MOD_Yf_TILED:
+	case I915_FORMAT_MOD_Yf_TILED_CCS:
+	default:
+	/* Not supported yet */
+		return NULL;
+	}
+}
+
 static int intel_get_scanout_buffer(struct drm_plane *plane,
 				    struct drm_scanout_buffer *sb)
 {
@@ -1254,9 +1309,13 @@ static int intel_get_scanout_buffer(struct drm_plane *plane,
 		ptr = intel_fbdev_get_vaddr(dev_priv->display.fbdev.fbdev);
 	} else {
 		/* Can't disable tiling if DPT is in use */
-		if (intel_fb_uses_dpt(fb))
-			return -EOPNOTSUPP;
-
+		if (intel_fb_uses_dpt(fb)) {
+			if (fb->format->cpp[0] != 4)
+				return -EOPNOTSUPP;
+			sb->set_pixel = intel_get_tiling_func(fb->modifier);
+			if (!sb->set_pixel)
+				return -EOPNOTSUPP;
+		}
 		ptr = intel_bo_panic_map(obj);
 	}
 
@@ -1271,7 +1330,10 @@ static int intel_get_scanout_buffer(struct drm_plane *plane,
 	sb->map[0] = panic_map;
 	sb->width = fb->width;
 	sb->height = fb->height;
-	sb->format = fb->format;
+	/* Use the generic linear format, because tiling, RC, CCS, CC
+	 * will be disabled in disable_tiling()
+	 */
+	sb->format = drm_format_info(fb->format->format);
 	sb->pitch[0] = fb->pitches[0];
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index e2a54547a29d5..71e79b022c9ef 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -2577,17 +2577,24 @@ static u8 skl_get_plane_caps(struct drm_i915_private *i915,
 
 static void skl_disable_tiling(struct intel_plane *plane)
 {
-	u32 plane_ctl;
 	struct intel_plane_state *state = to_intel_plane_state(plane->base.state);
 	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
-	u32 stride = state->view.color_plane[0].scanout_stride / 64;
+	const struct drm_framebuffer *fb = state->hw.fb;
+	u32 plane_ctl;
 
 	plane_ctl = intel_de_read(dev_priv, PLANE_CTL(plane->pipe, plane->id));
-	plane_ctl &= ~PLANE_CTL_TILED_MASK;
 
-	intel_de_write_fw(dev_priv, PLANE_STRIDE(plane->pipe, plane->id),
-			  PLANE_STRIDE_(stride));
+	if (intel_fb_uses_dpt(fb)) {
+		/* if DPT is enabled, keep tiling, but disable compression */
+		plane_ctl &= ~PLANE_CTL_RENDER_DECOMPRESSION_ENABLE;
+	} else {
+		/* if DPT is not supported, disable tiling, and update stride */
+		u32 stride = state->view.color_plane[0].scanout_stride / 64;
 
+		plane_ctl &= ~PLANE_CTL_TILED_MASK;
+		intel_de_write_fw(dev_priv, PLANE_STRIDE(plane->pipe, plane->id),
+				  PLANE_STRIDE_(stride));
+	}
 	intel_de_write_fw(dev_priv, PLANE_CTL(plane->pipe, plane->id), plane_ctl);
 
 	intel_de_write_fw(dev_priv, PLANE_SURF(plane->pipe, plane->id),
-- 
2.47.1


