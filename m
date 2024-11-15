Return-Path: <linux-kernel+bounces-410819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0809CE14D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A049A284D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CBA1D516F;
	Fri, 15 Nov 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMIROa4f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ABF1D516D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681049; cv=none; b=cbD6Uv6/c77sIOLxQNgMQeDtKI6eTbNo85xbtnGopahh1o+1EtkwxUuSL95NGE0vQxZB7J/yLLi5tNMCv3ua5Vod7eHI3S5T515o9Teop+2skL5DxhFWzcKR3f0+LpssEamt4vPabRXfaeEiYp2+0hjvY1BizWMTnkNWpYJ8Pe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681049; c=relaxed/simple;
	bh=OU21ApnNbV8Kqt1uorvQvv3ybr2kudyBCw6xHh19yLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX5UMhAvFsDzHLL/kI+TnCDZVxlkD+V9aox1EJsDBWthBqB7x30SElemFAtbHAYjQCDrbDCkbCrkyKZeRp2lZQTGR6GBWPw7BAxmnweUOiOxQ6sEegMi96W7MaLZwK1ieJhJA5AQ3tYBf/mSM0w0cNpd1gHQyuhe9aLn9gNjevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMIROa4f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731681046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DrMYfoorXtk6yqJ/XxMMeM8b1EMvTXjkTKpuBuDzrQ=;
	b=gMIROa4fVo0odnzY4R6gMhaSIdYWV0+e0NJ8SRn2+jfunXzFBzgLiw9ZnN39RonSPRfv/P
	X1NGsU5BkfSslkk7I2xERV65zwCUTH+97iDyj/Cw7vj9Pc39UB80FuIimjT+H3Kas2ivOl
	0G3d6WcmswGloC9LOsUhZypKF7xiFrM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-abLefCklM0WkP_uyB4zeoA-1; Fri,
 15 Nov 2024 09:30:42 -0500
X-MC-Unique: abLefCklM0WkP_uyB4zeoA-1
X-Mimecast-MFC-AGG-ID: abLefCklM0WkP_uyB4zeoA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DE8B19560AE;
	Fri, 15 Nov 2024 14:30:40 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.181])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C54751956089;
	Fri, 15 Nov 2024 14:30:36 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v8 6/6] drm/log: Add integer scaling support
Date: Fri, 15 Nov 2024 14:40:43 +0100
Message-ID: <20241115142950.1758007-7-jfalempe@redhat.com>
In-Reply-To: <20241115142950.1758007-1-jfalempe@redhat.com>
References: <20241115142950.1758007-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add a module parameter, to increase the font size for HiDPI screen.
Even with CONFIG_FONT_TER16x32, it can still be a bit small to read.
In this case, adding drm_log.scale=2 to your kernel command line will
double the character size.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v5:
 * Change scale parameter to unsigned int (Jani Nikula)

 drivers/gpu/drm/clients/drm_log.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 03c59784c829f..f9f8becf7f96a 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -25,6 +25,10 @@ MODULE_AUTHOR("Jocelyn Falempe");
 MODULE_DESCRIPTION("DRM boot logger");
 MODULE_LICENSE("GPL");
 
+static unsigned int scale = 1;
+module_param(scale, uint, 0444);
+MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default is 1");
+
 /**
  * DOC: overview
  *
@@ -38,6 +42,8 @@ struct drm_log_scanout {
 	const struct font_desc *font;
 	u32 rows;
 	u32 columns;
+	u32 scaled_font_h;
+	u32 scaled_font_w;
 	u32 line;
 	u32 format;
 	u32 px_width;
@@ -66,7 +72,7 @@ static struct drm_log *console_to_drm_log(struct console *con)
 
 static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
 			 const u8 *src, unsigned int src_pitch,
-			 u32 height, u32 width, u32 scale, u32 px_width, u32 color)
+			 u32 height, u32 width, u32 px_width, u32 color)
 {
 	switch (px_width) {
 	case 2:
@@ -86,7 +92,7 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
 static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line)
 {
 	struct drm_framebuffer *fb = scanout->buffer->fb;
-	unsigned long height = scanout->font->height;
+	unsigned long height = scanout->scaled_font_h;
 	struct iosys_map map;
 	struct drm_rect r = DRM_RECT_INIT(0, line * height, fb->width, height);
 
@@ -106,8 +112,8 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
 	size_t font_pitch = DIV_ROUND_UP(font->width, 8);
 	const u8 *src;
 	u32 px_width = fb->format->cpp[0];
-	struct drm_rect r = DRM_RECT_INIT(0, scanout->line * font->height,
-					  fb->width, (scanout->line + 1) * font->height);
+	struct drm_rect r = DRM_RECT_INIT(0, scanout->line * scanout->scaled_font_h,
+					  fb->width, (scanout->line + 1) * scanout->scaled_font_h);
 	u32 i;
 
 	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
@@ -117,9 +123,10 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
 	for (i = 0; i < len && i < scanout->columns; i++) {
 		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
 		src = drm_draw_get_char_bitmap(font, s[i], font_pitch);
-		drm_log_blit(&map, fb->pitches[0], src, font_pitch, font->height, font->width,
-			     1, px_width, color);
-		iosys_map_incr(&map, font->width * px_width);
+		drm_log_blit(&map, fb->pitches[0], src, font_pitch,
+			     scanout->scaled_font_h, scanout->scaled_font_w,
+			     px_width, color);
+		iosys_map_incr(&map, scanout->scaled_font_w * px_width);
 	}
 
 	scanout->line++;
@@ -204,8 +211,10 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
 		return -ENOMEM;
 	}
 	mode_set->fb = scanout->buffer->fb;
-	scanout->rows = height / scanout->font->height;
-	scanout->columns = width / scanout->font->width;
+	scanout->scaled_font_h = scanout->font->height * scale;
+	scanout->scaled_font_w = scanout->font->width * scale;
+	scanout->rows = height / scanout->scaled_font_h;
+	scanout->columns = width / scanout->scaled_font_w;
 	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);
 	scanout->prefix_color = drm_draw_color_from_xrgb8888(0x4e9a06, format);
 	return 0;
-- 
2.47.0


