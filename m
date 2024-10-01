Return-Path: <linux-kernel+bounces-346668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC45198C74D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E5F286853
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60081CF7CA;
	Tue,  1 Oct 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ENQUaJK2"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC741CEE9E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816710; cv=none; b=A+K/bcuNvpR7bTQMJBcprWBwOo6VVMZZ95e+Cbd6dHrZ+3PliL9TOrLARPERYs1eiZ4ULNWg197P1s0Ah4CutQVabNocbPAIRYBDWClgNBaX8PnBqs5YqxCTuZs8lZjOsY7DN0XtiHsG7SSOBEGU6AUY321iHo3Ctfurp7NEDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816710; c=relaxed/simple;
	bh=HAwSJAkhQOJK1rk2QRun2YrBl73ivVtFfoE82HPTcIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/OG21UUtIdE2cROzauqvrzGSJYeBhqZkmrG/kP1CjKhHgszQPKDcUqqM9jjycS7X8Qdj9iqELvrlvU7pmM9N/IXhCl5ruochUdM6+aS4q59HB1ZhiiY1F3bCZy3fGuIuGf9jMd+KPxlmDpP1NJbHVJqKDKVb1y/fNijJ83D2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ENQUaJK2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D4AA323E0F;
	Tue,  1 Oct 2024 23:05:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ziYS9nTLoAaO; Tue,  1 Oct 2024 23:05:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727816704; bh=HAwSJAkhQOJK1rk2QRun2YrBl73ivVtFfoE82HPTcIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ENQUaJK20Ycm4+nhz++zB+m2+1CHFuuBkIDhDICX1NUy94GtKJAMd+0zvWZuAxbl8
	 IXABzda6AeUl/DY2dKpFg6cZcX0eTvlIBb1nxxVb8WqEgNuuaR7LP+N34f+qm0lLTP
	 1s1Z0RKXQ76ZML6yYQaij9O1DI7VKa+0Rr2M8vOVkCY2WYCtyX4H7Og/pw4fk8n8Y4
	 1eD/7IHszDsa0UPdeAhL6XYFF7+/csjWn7+s3H22rwJZwa4sghcrpMDusHp5KqNTZB
	 qE5/i4Jdx2/Z6/jyRw4g3njsHRYfzQalAr6L9EyK6A85aILjqOEK0TF562gV6VwXQu
	 0GBmwbMSjcElw==
From: Yao Zi <ziyao@disroot.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [RFC PATCH 1/1] drm/meson: Support drm_panic
Date: Tue,  1 Oct 2024 21:04:04 +0000
Message-ID: <20241001210403.43535-3-ziyao@disroot.org>
In-Reply-To: <20241001210403.43535-2-ziyao@disroot.org>
References: <20241001210403.43535-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements drm_plane_helper_funcs.get_scanout_buffer for
primary plane, enabling meson-drm to work with drm_panic.

This implementation tries to use current framebuffer as scanout buffer.
In case of AFBC enabled, we disable the decoder path and adjust OSD1
parameters in get_scanout_buffer to make the buffer linear.

Tested on TTY and Wayland session (Sway).

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/gpu/drm/meson/meson_plane.c | 47 +++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index b43ac61201f3..b2def784c00d 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -20,6 +20,8 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_panic.h>
 
 #include "meson_plane.h"
 #include "meson_registers.h"
@@ -419,10 +421,49 @@ static void meson_plane_atomic_disable(struct drm_plane *plane,
 	priv->viu.osd1_enabled = false;
 }
 
+static int meson_plane_get_scanout_buffer(struct drm_plane *plane,
+					  struct drm_scanout_buffer *sb)
+{
+	struct meson_plane *meson_plane = to_meson_plane(plane);
+	struct meson_drm *priv = meson_plane->priv;
+	struct drm_framebuffer *fb;
+
+	if (!meson_plane->enabled)
+		return -ENODEV;
+
+	if (priv->viu.osd1_afbcd) {
+		if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM)) {
+			writel_relaxed(0, priv->io_base +
+					  _REG(VIU_OSD1_BLK1_CFG_W4));
+			writel_relaxed(0, priv->io_base +
+					  _REG(VIU_OSD1_BLK2_CFG_W4));
+			writel_bits_relaxed(OSD_ENDIANNESS_LE, OSD_ENDIANNESS_LE,
+					    priv->io_base +
+					    _REG(VIU_OSD1_BLK0_CFG_W0));
+			meson_viu_g12a_disable_osd1_afbc(priv);
+		} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
+			writel_bits_relaxed(OSD_DPATH_MALI_AFBCD, 0,
+					    priv->io_base +
+					    _REG(VIU_OSD1_CTRL_STAT2));
+			meson_viu_gxm_disable_osd1_afbc(priv);
+		}
+	}
+
+	fb = plane->state->fb;
+	sb->format	= fb->format;
+	sb->width	= fb->width;
+	sb->height	= fb->height;
+	sb->pitch[0]	= fb->pitches[0];
+	drm_gem_fb_vmap(fb, sb->map, NULL);
+
+	return 0;
+}
+
 static const struct drm_plane_helper_funcs meson_plane_helper_funcs = {
-	.atomic_check	= meson_plane_atomic_check,
-	.atomic_disable	= meson_plane_atomic_disable,
-	.atomic_update	= meson_plane_atomic_update,
+	.atomic_check		= meson_plane_atomic_check,
+	.atomic_disable		= meson_plane_atomic_disable,
+	.atomic_update		= meson_plane_atomic_update,
+	.get_scanout_buffer	= meson_plane_get_scanout_buffer,
 };
 
 static bool meson_plane_format_mod_supported(struct drm_plane *plane,
-- 
2.46.0


