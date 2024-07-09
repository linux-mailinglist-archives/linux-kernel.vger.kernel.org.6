Return-Path: <linux-kernel+bounces-245435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6669D92B27E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EB51C2238A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914B154434;
	Tue,  9 Jul 2024 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiX2y3Sj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDD12C481
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514744; cv=none; b=QpYKB86sCDs9xIaI4RbTCQzSzAta3dKuG9iwGuPTJUxcfMPrJ4Bb0mLxUX4U/brdVbxm05rBI4VfR4i6NOc1U/fFM3WR21HFAfzZgb/mx1R9Z/7BH3lG3M/lMOvZ2BeGLnOs983m9GIOrRV43fJ/UjL/X/d5jJ1yKjo2L7uFkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514744; c=relaxed/simple;
	bh=yovYUYErH9q7BHtmNyP2+FCtPHg+ph6+nKC5ao7XQh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iffpZeeDR7vTXTdxJdcMt6qrOFB/nHc4GW88VaMNHeX83oJdLLP01PkoCDvGp4ZzIsshR0IuVyu7pUWMhVEkRcKwaVvg0MSqrN+ZVbRNk7GC5FyDszIm6a4/NYRfmukaUzN98iIl1Qqa0JWTtrCwsfprq7ewiGVrnStAXipLIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiX2y3Sj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720514741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IVzlhCLkw6n++DhGKwdOiEwHv8VAzNkrEzDQPW430E=;
	b=UiX2y3SjiKFrJVgmTimWckceKdI0n0FWlsGgiZ+R6vGXf8abYRvctxKFHVcL7dfO80W+0x
	CvYLB2uPGpc8LFM4BwZWxw+lz5H2O/iiwXNPI17Iv5N2YsS1QyrCpKnrM3tG5LFSIgbpYr
	dUqSHZ3l27pvstOE1adpzYAFL4tYvUQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-_gMuP15_NAaDeZAC01WDCg-1; Tue,
 09 Jul 2024 04:45:31 -0400
X-MC-Unique: _gMuP15_NAaDeZAC01WDCg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C36161955F66;
	Tue,  9 Jul 2024 08:45:27 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.246])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DFCE19560AA;
	Tue,  9 Jul 2024 08:45:22 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	"Bjorn Roy Baron" <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v2 1/4] drm/panic: Add integer scaling to blit()
Date: Tue,  9 Jul 2024 10:40:07 +0200
Message-ID: <20240709084458.158659-2-jfalempe@redhat.com>
In-Reply-To: <20240709084458.158659-1-jfalempe@redhat.com>
References: <20240709084458.158659-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add a parameter to the blit function, to upscale the image.
This is necessary to draw QR-code, otherwise, the pixels are usually
too small to be readable by most QR-code reader.
It can also be used later for drawing fonts on high-DPI display.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 948aed00595e..fb8c823b7c00 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -249,20 +249,20 @@ static bool drm_panic_is_pixel_fg(const u8 *sbuf8, unsigned int spitch, int x, i
 static void drm_panic_blit16(struct iosys_map *dmap, unsigned int dpitch,
 			     const u8 *sbuf8, unsigned int spitch,
 			     unsigned int height, unsigned int width,
-			     u16 fg16)
+			     unsigned int scale, u16 fg16)
 {
 	unsigned int y, x;
 
 	for (y = 0; y < height; y++)
 		for (x = 0; x < width; x++)
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x, y))
+			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
 				iosys_map_wr(dmap, y * dpitch + x * sizeof(u16), u16, fg16);
 }
 
 static void drm_panic_blit24(struct iosys_map *dmap, unsigned int dpitch,
 			     const u8 *sbuf8, unsigned int spitch,
 			     unsigned int height, unsigned int width,
-			     u32 fg32)
+			     unsigned int scale, u32 fg32)
 {
 	unsigned int y, x;
 
@@ -270,7 +270,7 @@ static void drm_panic_blit24(struct iosys_map *dmap, unsigned int dpitch,
 		for (x = 0; x < width; x++) {
 			u32 off = y * dpitch + x * 3;
 
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x, y)) {
+			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale)) {
 				/* write blue-green-red to output in little endianness */
 				iosys_map_wr(dmap, off, u8, (fg32 & 0x000000FF) >> 0);
 				iosys_map_wr(dmap, off + 1, u8, (fg32 & 0x0000FF00) >> 8);
@@ -283,24 +283,25 @@ static void drm_panic_blit24(struct iosys_map *dmap, unsigned int dpitch,
 static void drm_panic_blit32(struct iosys_map *dmap, unsigned int dpitch,
 			     const u8 *sbuf8, unsigned int spitch,
 			     unsigned int height, unsigned int width,
-			     u32 fg32)
+			     unsigned int scale, u32 fg32)
 {
 	unsigned int y, x;
 
 	for (y = 0; y < height; y++)
 		for (x = 0; x < width; x++)
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x, y))
+			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
 				iosys_map_wr(dmap, y * dpitch + x * sizeof(u32), u32, fg32);
 }
 
 static void drm_panic_blit_pixel(struct drm_scanout_buffer *sb, struct drm_rect *clip,
-				 const u8 *sbuf8, unsigned int spitch, u32 fg_color)
+				 const u8 *sbuf8, unsigned int spitch, unsigned int scale,
+				 u32 fg_color)
 {
 	unsigned int y, x;
 
 	for (y = 0; y < drm_rect_height(clip); y++)
 		for (x = 0; x < drm_rect_width(clip); x++)
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x, y))
+			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
 				sb->set_pixel(sb, clip->x1 + x, clip->y1 + y, fg_color);
 }
 
@@ -310,18 +311,22 @@ static void drm_panic_blit_pixel(struct drm_scanout_buffer *sb, struct drm_rect
  * @clip: destination rectangle
  * @sbuf8: source buffer, in monochrome format, 8 pixels per byte.
  * @spitch: source pitch in bytes
+ * @scale: integer scale, source buffer is scale time smaller than destination
+ *         rectangle
  * @fg_color: foreground color, in destination format
  *
  * This can be used to draw a font character, which is a monochrome image, to a
  * framebuffer in other supported format.
  */
 static void drm_panic_blit(struct drm_scanout_buffer *sb, struct drm_rect *clip,
-			   const u8 *sbuf8, unsigned int spitch, u32 fg_color)
+			   const u8 *sbuf8, unsigned int spitch,
+			   unsigned int scale, u32 fg_color)
+
 {
 	struct iosys_map map;
 
 	if (sb->set_pixel)
-		return drm_panic_blit_pixel(sb, clip, sbuf8, spitch, fg_color);
+		return drm_panic_blit_pixel(sb, clip, sbuf8, spitch, scale, fg_color);
 
 	map = sb->map[0];
 	iosys_map_incr(&map, clip->y1 * sb->pitch[0] + clip->x1 * sb->format->cpp[0]);
@@ -329,15 +334,15 @@ static void drm_panic_blit(struct drm_scanout_buffer *sb, struct drm_rect *clip,
 	switch (sb->format->cpp[0]) {
 	case 2:
 		drm_panic_blit16(&map, sb->pitch[0], sbuf8, spitch,
-				 drm_rect_height(clip), drm_rect_width(clip), fg_color);
+				 drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
 	break;
 	case 3:
 		drm_panic_blit24(&map, sb->pitch[0], sbuf8, spitch,
-				 drm_rect_height(clip), drm_rect_width(clip), fg_color);
+				 drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
 	break;
 	case 4:
 		drm_panic_blit32(&map, sb->pitch[0], sbuf8, spitch,
-				 drm_rect_height(clip), drm_rect_width(clip), fg_color);
+				 drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
 	break;
 	default:
 		WARN_ONCE(1, "Can't blit with pixel width %d\n", sb->format->cpp[0]);
@@ -477,7 +482,7 @@ static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
 		for (j = 0; j < line_len; j++) {
 			src = get_char_bitmap(font, msg[i].txt[j], font_pitch);
 			rec.x2 = rec.x1 + font->width;
-			drm_panic_blit(sb, &rec, src, font_pitch, color);
+			drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
 			rec.x1 += font->width;
 		}
 	}
-- 
2.45.2


