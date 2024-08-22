Return-Path: <linux-kernel+bounces-296813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93D795AF72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CA81C20E41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51CB16D9C2;
	Thu, 22 Aug 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKLuVNma"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34F153565
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312369; cv=none; b=ZZ8PV0dZvy8Yfh/N/MsochWqUQwuwRzBUHZMfuo/dRF+o2wzMNixrVR5PYL0dqZqzlf4Ndx919KR1+4glox3EETRQJ8nNjMg67Eglrs0YqxToG/XDFKH3KGUYKyBBd78E6rWbnVmwY6bgTUbgCauUwesYnObp5cALh6n6G20Fec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312369; c=relaxed/simple;
	bh=X3iTK5fA4f/LA/TFObzyf1YXxbIuXsALmAYdTrFPXg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAAn5yMdlXbC51LhnXQVkbhXPXGLWne36lw9D6U9zJuG1paByAn8G5wnN8eU7RaaowNttxVVga0wVouPTil2SACWBuE4j0wh1vcYsA/t2XGybNMtVG7kpOW2VmEvS5ObnmvYf91dGRgPfLTJb0bRt3dRp6rGXqV0eyWc6+u6Npk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKLuVNma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724312367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV7SFTv3ZaAzA1GjAkJltDZEiBviWPGwtIblWYQf/2c=;
	b=WKLuVNmarCa83EW6EjbByPg4lMM88gik2UUn89IXZf3wNKWvB4o0iMLKaQ+T2N+YVs+3JO
	4D9QvNsSIF9xNTocaB+hNgdNypmbkaZr0ChccjEZhNlojJXu/giw+0zi3PM0FZj2x7rDMl
	AHywP2qajqabR4CIdSegvmusKdMTzB4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-TB91Meq9Pe2nVNoeX1VFLw-1; Thu,
 22 Aug 2024 03:39:23 -0400
X-MC-Unique: TB91Meq9Pe2nVNoeX1VFLw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4FAB1954B1F;
	Thu, 22 Aug 2024 07:39:20 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C6E01955DD8;
	Thu, 22 Aug 2024 07:39:15 +0000 (UTC)
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
Subject: [PATCH v7 2/4] drm/rect: Add drm_rect_overlap()
Date: Thu, 22 Aug 2024 09:33:55 +0200
Message-ID: <20240822073852.562286-3-jfalempe@redhat.com>
In-Reply-To: <20240822073852.562286-1-jfalempe@redhat.com>
References: <20240822073852.562286-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Check if two rectangles overlap.
It's a bit similar to drm_rect_intersect() but this won't modify
the rectangle.
Simplifies a bit drm_panic.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v7:
 * rename r1/r2 to a/b in drm_rect_overlap() (Jani Nikula)

 drivers/gpu/drm/drm_panic.c |  3 +--
 include/drm/drm_rect.h      | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 0a047152f88b8..59fba23e5fd7a 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -529,8 +529,7 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
 	/* Fill with the background color, and draw text on top */
 	drm_panic_fill(sb, &r_screen, bg_color);
 
-	if ((r_msg.x1 >= logo_width || r_msg.y1 >= logo_height) &&
-	    logo_width <= sb->width && logo_height <= sb->height) {
+	if (!drm_rect_overlap(&r_logo, &r_msg)) {
 		if (logo_mono)
 			drm_panic_blit(sb, &r_logo, logo_mono->data, DIV_ROUND_UP(logo_width, 8),
 				       fg_color);
diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
index 73fcb899a01da..46f09cf68458c 100644
--- a/include/drm/drm_rect.h
+++ b/include/drm/drm_rect.h
@@ -238,6 +238,21 @@ static inline void drm_rect_fp_to_int(struct drm_rect *dst,
 		      drm_rect_height(src) >> 16);
 }
 
+/**
+ * drm_rect_overlap - Check if two rectangles overlap
+ * @a: first rectangle
+ * @b: second rectangle
+ *
+ * RETURNS:
+ * %true if the rectangles overlap, %false otherwise.
+ */
+static inline bool drm_rect_overlap(const struct drm_rect *a,
+				    const struct drm_rect *b)
+{
+	return (a->x2 > b->x1 && b->x2 > a->x1 &&
+		a->y2 > b->y1 && b->y2 > a->y1);
+}
+
 bool drm_rect_intersect(struct drm_rect *r, const struct drm_rect *clip);
 bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
 			  const struct drm_rect *clip);
-- 
2.46.0


