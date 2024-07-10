Return-Path: <linux-kernel+bounces-247726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D57192D3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6C71C22123
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599011946A5;
	Wed, 10 Jul 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TB34UJLy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B519415D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620099; cv=none; b=ZnNaYIfHw7tplZFvnwGpsFp/tmcJavDNNgWYfNR2XZrjLdf+RQwzaJXezr/kruNyyisEwiyqcL0VPwtjtjYT+oI0pHn/LtS3C7c8dS+/FciRboitI14Fy0wecezoes/07nKHUFiiVL8vFRDoQBBQ1Vlixvg7wJf4Ud3JaqzJNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620099; c=relaxed/simple;
	bh=VBvLqEGBIvEv99f+bhnkh8O5f6TCLuzBtISsk6Wf4y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDPsgvujhdsAt/Jji+AL1vSykej/frVA+XL0gYydzYkLiVPqy/TP3EGMya8uXEfbA2iBhzYw1aWiZ5AAB8w/6rR5njM0iPMaYZDP9z6Glg/cQrwtdf/PTfV+wFfUSl/K7iHBKoRhilgzCaiZxslLq5elugIce8s5kSK/YWx27nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TB34UJLy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720620097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2UhJ+/dL68eXFc1L/V817rFXISwVJkxtfTwSS6+i2A=;
	b=TB34UJLySVtXJ9heYZeEBXmQsd/FzzOdYAfs6zLbfWE4sYpxkmiOSTyaCPAKd59n8OjrVt
	05PiUEXRpVjfuY5ayHBPyTCM7WpwJe4qptWiDhRX3Menqktlhn+YsYvLb0HTxIQaVrzXsh
	Y/q6aG3YOL070oE1NW7aE9Ruwqr3HDs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-0azbsJ1QO86txY7lbmO3dg-1; Wed,
 10 Jul 2024 10:01:34 -0400
X-MC-Unique: 0azbsJ1QO86txY7lbmO3dg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FE3A1944B36;
	Wed, 10 Jul 2024 14:01:31 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.246])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AED8E19560AE;
	Wed, 10 Jul 2024 14:01:26 +0000 (UTC)
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
Subject: [PATCH v3 3/4] drm/panic: Simplify logo handling
Date: Wed, 10 Jul 2024 15:59:29 +0200
Message-ID: <20240710140057.347384-4-jfalempe@redhat.com>
In-Reply-To: <20240710140057.347384-1-jfalempe@redhat.com>
References: <20240710140057.347384-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Move logo rectangle initialisation, and logo drawing in separate
functions, so they can be re-used by different panic screens.
It prepares the introduction of the QR code panic screen.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 57 +++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 9e06609e1799..450585374ca9 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -80,6 +80,7 @@ static struct drm_panic_line panic_msg[] = {
 	PANIC_LINE(""),
 	PANIC_LINE("Please reboot your computer."),
 };
+static const int panic_msg_lines = ARRAY_SIZE(panic_msg);
 
 static const struct drm_panic_line logo_ascii[] = {
 	PANIC_LINE("     .--.        _"),
@@ -90,6 +91,7 @@ static const struct drm_panic_line logo_ascii[] = {
 	PANIC_LINE(" /'\\_   _/`\\    (_)"),
 	PANIC_LINE(" \\___)=(___/"),
 };
+static const int logo_ascii_lines = ARRAY_SIZE(logo_ascii);
 
 #if defined(CONFIG_LOGO) && !defined(MODULE)
 static const struct linux_logo *logo_mono;
@@ -488,33 +490,45 @@ static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
 	}
 }
 
+static void drm_panic_logo_rect(struct drm_rect *rect, const struct font_desc *font)
+{
+	if (logo_mono)
+		drm_rect_init(rect, 0, 0, logo_mono->width, logo_mono->height);
+	else {
+		int logo_width = get_max_line_len(logo_ascii, logo_ascii_lines) * font->width;
+
+		drm_rect_init(rect, 0, 0, logo_width, logo_ascii_lines * font->height);
+	}
+}
+
+static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *rect,
+				const struct font_desc *font, u32 fg_color)
+{
+	if (logo_mono)
+		drm_panic_blit(sb, rect, logo_mono->data,
+			       DIV_ROUND_UP(drm_rect_width(rect), 8), 1, fg_color);
+	else
+		draw_txt_rectangle(sb, font, logo_ascii, logo_ascii_lines, false, rect,
+				   fg_color);
+}
+
 static void draw_panic_static_user(struct drm_scanout_buffer *sb)
 {
-	size_t msg_lines = ARRAY_SIZE(panic_msg);
-	size_t logo_ascii_lines = ARRAY_SIZE(logo_ascii);
 	u32 fg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR, sb->format->format);
 	u32 bg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR, sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg;
-	unsigned int logo_width, logo_height;
+	unsigned int panic_msg_width;
 
 	if (!font)
 		return;
 
 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
-
-	if (logo_mono) {
-		logo_width = logo_mono->width;
-		logo_height = logo_mono->height;
-	} else {
-		logo_width = get_max_line_len(logo_ascii, logo_ascii_lines) * font->width;
-		logo_height = logo_ascii_lines * font->height;
-	}
-
-	r_logo = DRM_RECT_INIT(0, 0, logo_width, logo_height);
+	drm_panic_logo_rect(&r_logo, font);
+	panic_msg_width = get_max_line_len(panic_msg, panic_msg_lines) * font->width;
 	r_msg = DRM_RECT_INIT(0, 0,
-			      min(get_max_line_len(panic_msg, msg_lines) * font->width, sb->width),
-			      min(msg_lines * font->height, sb->height));
+			      min(panic_msg_width, sb->width),
+			      min(panic_msg_lines * font->height, sb->height));
 
 	/* Center the panic message */
 	drm_rect_translate(&r_msg, (sb->width - r_msg.x2) / 2, (sb->height - r_msg.y2) / 2);
@@ -522,15 +536,10 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
 	/* Fill with the background color, and draw text on top */
 	drm_panic_fill(sb, &r_screen, bg_color);
 
-	if (!drm_rect_overlap(&r_logo, &r_msg)) {
-		if (logo_mono)
-			drm_panic_blit(sb, &r_logo, logo_mono->data, DIV_ROUND_UP(logo_width, 8),
-				       fg_color);
-		else
-			draw_txt_rectangle(sb, font, logo_ascii, logo_ascii_lines, false, &r_logo,
-					   fg_color);
-	}
-	draw_txt_rectangle(sb, font, panic_msg, msg_lines, true, &r_msg, fg_color);
+	if (!drm_rect_overlap(&r_logo, &r_msg))
+		drm_panic_logo_draw(sb, &r_logo, font, fg_color);
+
+	draw_txt_rectangle(sb, font, panic_msg, panic_msg_lines, true, &r_msg, fg_color);
 }
 
 /*
-- 
2.45.2


