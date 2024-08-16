Return-Path: <linux-kernel+bounces-289691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA74954A84
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE028B22995
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20441BB6BC;
	Fri, 16 Aug 2024 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc0sE8VX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1421BB6B0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813027; cv=none; b=DfRfCdHXt0ujcPJ0fHnit2sL7jwmClLclzq8MxksdLemURxmUNtWoGnBcpkXOvqJfXSKO3d/qUBgYEPwpyy1AqXPBIOd/EFqmEf364IQQnm/R5/KbPgnpFXRtML96Ka1P8/4QsaWX0SG9cg3IzD17H7wRdsuHwlZWhQoMNMeKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813027; c=relaxed/simple;
	bh=MaAocIMzW+3OSfeE050UhdEmBD0s86OQ4OMKhWdAhM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHkDbi9Gv3OT8QVthDZxUBMzOfNtVh06k13y0tRBRoNMVsrCQ384hYEyJ0vVI2ajaZaKIUcVaDyTZ+tPIO1y/Lwnv3OoKP+fAbrAVU6zQUJkAzOlbMs+DSIRRSwPGkW7qJWPkzDQOTNqTpe5/CPKk5dozDWNUiXCZt8H/Ypdl58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bc0sE8VX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723813024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=looOAfiU4DDTvwoOvVmVttRGSbYiAApbPeTzZkmFOJc=;
	b=bc0sE8VXZajRLDBdVWyx1GOf92BGL3dPxPGBhoPN4+y59ZiGOj/WemtxGYopp27vkSj5Wb
	maEOgfqkHCm3dgGLxNUYAQib0MXGZxQoj0H7+CyRqfKO1PjAQQwW8RvTG2Zi7gVH1Fgz5F
	3vb3keAZODxu4Prk/Rfl4Yv6XD3ljmU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-612EfI8lOYiiz7cLYw_KvA-1; Fri,
 16 Aug 2024 08:57:00 -0400
X-MC-Unique: 612EfI8lOYiiz7cLYw_KvA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E08F619560B4;
	Fri, 16 Aug 2024 12:56:57 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55F7F19560A3;
	Fri, 16 Aug 2024 12:56:53 +0000 (UTC)
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
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v2 5/5] drm/log: Color the timestamp, to improve readability
Date: Fri, 16 Aug 2024 14:52:37 +0200
Message-ID: <20240816125612.1003295-6-jfalempe@redhat.com>
In-Reply-To: <20240816125612.1003295-1-jfalempe@redhat.com>
References: <20240816125612.1003295-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Color the timesamp prefix, similar to dmesg.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_log.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_log.c b/drivers/gpu/drm/drm_log.c
index b94ce3ea48a0..effdf6ee20b1 100644
--- a/drivers/gpu/drm/drm_log.c
+++ b/drivers/gpu/drm/drm_log.c
@@ -45,6 +45,7 @@ struct drm_log_scanout {
 	u32 format;
 	u32 px_width;
 	u32 front_color;
+	u32 prefix_color;
 };
 
 struct drm_log_client {
@@ -186,7 +187,7 @@ static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line)
 }
 
 static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
-			      unsigned int len)
+			      unsigned int len, unsigned int prefix_len)
 {
 	struct drm_framebuffer *fb = scanout->buffer->fb;
 	struct iosys_map map;
@@ -203,9 +204,10 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
 
 	iosys_map_incr(&map, r.y1 * fb->pitches[0]);
 	for (i = 0; i < len && i < scanout->columns; i++) {
+		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
 		src = drm_draw_get_char_bitmap(font, s[i], font_pitch);
 		drm_log_blit(&map, fb->pitches[0], src, font_pitch, font->height, font->width,
-			     1, px_width, scanout->front_color);
+			     1, px_width, color);
 		iosys_map_incr(&map, font->width * px_width);
 	}
 
@@ -217,7 +219,7 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
 }
 
 static void drm_log_draw_new_line(struct drm_log_scanout *scanout,
-				  const char *s, unsigned int len)
+				  const char *s, unsigned int len, unsigned int prefix_len)
 {
 	if (scanout->line == 0) {
 		drm_log_clear_line(scanout, 0);
@@ -226,20 +228,31 @@ static void drm_log_draw_new_line(struct drm_log_scanout *scanout,
 	} else if (scanout->line + 2 < scanout->rows)
 		drm_log_clear_line(scanout, scanout->line + 2);
 
-	drm_log_draw_line(scanout, s, len);
+	drm_log_draw_line(scanout, s, len, prefix_len);
 }
 
+/*
+ * Depends on print_time() in printk.c
+ * Timestamp is written with "[%5lu.%06lu]"
+ */
+#define TS_PREFIX_LEN 13
+
 static void drm_log_draw_kmsg_record(struct drm_log_scanout *scanout,
 				     const char *s, unsigned int len)
 {
+	u32 prefix_len = 0;
+
+	if (len > TS_PREFIX_LEN && s[0] == '[' && s[6] == '.' && s[TS_PREFIX_LEN] == ']')
+		prefix_len = TS_PREFIX_LEN + 1;
 
 	while (len > scanout->columns) {
-		drm_log_draw_new_line(scanout, s, scanout->columns);
+		drm_log_draw_new_line(scanout, s, scanout->columns, prefix_len);
 		s += scanout->columns;
 		len -= scanout->columns;
+		prefix_len = 0;
 	}
 	if (len)
-		drm_log_draw_new_line(scanout, s, len);
+		drm_log_draw_new_line(scanout, s, len, prefix_len);
 }
 
 static u32 drm_log_find_usable_format(struct drm_plane *plane)
@@ -279,6 +292,7 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
 	scanout->rows = height / scanout->font->height;
 	scanout->columns = width / scanout->font->width;
 	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);
+	scanout->prefix_color = drm_draw_color_from_xrgb8888(0x4e9a06, format);
 	return 0;
 }
 
-- 
2.46.0


