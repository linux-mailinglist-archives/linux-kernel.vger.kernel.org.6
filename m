Return-Path: <linux-kernel+bounces-247724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F292D3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC73B26ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6349C19309A;
	Wed, 10 Jul 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMelTthF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B08193469
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620093; cv=none; b=YeXzhy4qKrht6jgXagj4m8uXbazROXvGFO7D0aDoNB+xdgnoRWCPw7DfFeGB7S6PIRIJ+rcKV4lAFb5mWgwasvxZAsbY01GJJvA/WLEU5CRTSqHgmUUA+/XibAXa0TO1KEn9Afnicu11lIpPYSxLfeTia9fgMK2jr3vpMl6zKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620093; c=relaxed/simple;
	bh=D+Ma0qaFK7l8xKrUMdTCCNtv+nT7BjIA0QA3zjbGE+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jv8KOc7x0plPtx8cUrRiH0Fs3bQwCMSB/+Y7YyFaTO+54XUZVQ9ohaAGsUYUF2pA4samkrui80rUSRcuADKBlrzuEC2JZvCGmA4f/6/MKLltjwIUNcnKLzGaqaIhR0Teouo6I/6+Md/NfnfnDhhhXv9PpgrgQg5TuIQNokUZe48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMelTthF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720620091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0frVolVqICIByf5Si0QYc0zMajNKduQXQ0wYd9/EsUE=;
	b=XMelTthFcPnkqDexCPrsmuxGKQb2IPqa+L11b0ABEM2HtexSRxq+3+n9EiO30bp9N8lmMt
	Nn4c0M6yRAmF9KMCyoWS3VF/NrQm7e7uvYHF9nCUrFu4tAVxUPh0qQSeVva1mac5G0fcyk
	DnKz07oQPr9ffrHo0EsGZQ4z3+/Y6Zg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-H2zq4EbkNz-rKh9-R4-7IQ-1; Wed,
 10 Jul 2024 10:01:29 -0400
X-MC-Unique: H2zq4EbkNz-rKh9-R4-7IQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F2E31956064;
	Wed, 10 Jul 2024 14:01:26 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.246])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A07ED1956046;
	Wed, 10 Jul 2024 14:01:21 +0000 (UTC)
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
Subject: [PATCH v3 2/4] drm/rect: Add drm_rect_overlap()
Date: Wed, 10 Jul 2024 15:59:28 +0200
Message-ID: <20240710140057.347384-3-jfalempe@redhat.com>
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
index fb8c823b7c00..9e06609e1799 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -522,8 +522,7 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
 	/* Fill with the background color, and draw text on top */
 	drm_panic_fill(sb, &r_screen, bg_color);
 
-	if ((r_msg.x1 >= logo_width || r_msg.y1 >= logo_height) &&
-	    logo_width <= sb->width && logo_height <= sb->height) {
+	if (!drm_rect_overlap(&r_logo, &r_msg)) {
 		if (logo_mono)
 			drm_panic_blit(sb, &r_logo, logo_mono->data, DIV_ROUND_UP(logo_width, 8),
 				       fg_color);
diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
index 73fcb899a01d..7bafde747d56 100644
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
2.45.2


