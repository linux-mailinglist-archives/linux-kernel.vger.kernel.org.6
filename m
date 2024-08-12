Return-Path: <linux-kernel+bounces-283095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC32194ED1C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE91F1C2176E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F8F17B4F6;
	Mon, 12 Aug 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQQomB16"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3D17B4EF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465961; cv=none; b=Cb/hFPU4PXOnw0rGyWWT/Dsa0oj/eXFowZv9/3rhfhph9QHY0RBrZfu8HfYrwxZUeDvInJ34tVYo9dqetsnk4LTkpMLz0Y9lnqaPH6M5pfsQE0j8ApHVMHbHGw67p7FGjX/2sB0C0p6zdO7W/QP4qxT3TJiUwS8muvp2QsCNwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465961; c=relaxed/simple;
	bh=iAUjDOGCLVPOtK8z9aanhCYDYNxJkoXMz76gT9j5DVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ybs6e0t9QYRuR4OTayW9m8HIDufcgcBl12QfPURUhLFqx6CTivFV6GnLI76l0YQuWvNMBZkYMuNe4KSPXTqurkzZyIXqzNY3ziKoF3pjxvPIzvMIMbIu9gfAW2e2TULjkfbFCXQNiXOy+FkkC0gxI+aWMhACGPfd7aXLiwoCV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQQomB16; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723465958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUZ3nUjabnl/rX8HyRVbOo2hPPQM6tVFZxMwxugxRlo=;
	b=JQQomB16I8jSpLMkuUNtuDiS020YDdMvL2YIj/keleGRas4Kw0ygenS13xz6MBcoPQl2wk
	LMMxeDTA/XGAn+rLY5w8ayclrNfrWvGYzfRa/z0d6FUBsPaLG/MDQhdCP+YywjleennkmK
	Kv5FNfwROvA2HgiU1fPYWjp4DTu2XoI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-o1fZJu2cNw-9mtXO46GTNQ-1; Mon,
 12 Aug 2024 08:32:35 -0400
X-MC-Unique: o1fZJu2cNw-9mtXO46GTNQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51A8618F49B0;
	Mon, 12 Aug 2024 12:32:33 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CC1530001A1;
	Mon, 12 Aug 2024 12:32:27 +0000 (UTC)
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
Subject: [PATCH v6 2/4] drm/rect: Add drm_rect_overlap()
Date: Mon, 12 Aug 2024 14:24:19 +0200
Message-ID: <20240812123147.81356-3-jfalempe@redhat.com>
In-Reply-To: <20240812123147.81356-1-jfalempe@redhat.com>
References: <20240812123147.81356-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Check if two rectangles overlap.
It's a bit similar to drm_rect_intersect() but this won't modify
the rectangle.
Simplifies a bit drm_panic.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
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
index 73fcb899a01da..7bafde747d560 100644
--- a/include/drm/drm_rect.h
+++ b/include/drm/drm_rect.h
@@ -238,6 +238,21 @@ static inline void drm_rect_fp_to_int(struct drm_rect *dst,
 		      drm_rect_height(src) >> 16);
 }
 
+/**
+ * drm_rect_overlap - Check if two rectangles overlap
+ * @r1: first rectangle
+ * @r2: second rectangle
+ *
+ * RETURNS:
+ * %true if the rectangles overlap, %false otherwise.
+ */
+static inline bool drm_rect_overlap(const struct drm_rect *r1,
+				    const struct drm_rect *r2)
+{
+	return (r1->x2 > r2->x1 && r2->x2 > r1->x1 &&
+		r1->y2 > r2->y1 && r2->y2 > r1->y1);
+}
+
 bool drm_rect_intersect(struct drm_rect *r, const struct drm_rect *clip);
 bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
 			  const struct drm_rect *clip);
-- 
2.46.0


