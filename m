Return-Path: <linux-kernel+bounces-439232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D26A9EAC93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63F9162945
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94975210F58;
	Tue, 10 Dec 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5+XQl+h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23DE2080ED
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823402; cv=none; b=QsNiG9WYYpC6a/Vi3PAcu8uMyTQR760oxigL6DvGr1ocD4EqIc4VvkMfSpEEZnVvefYSMpgv+7yU6f65l8yMA4qplSpmxZRaVmVH5BChEAFZvlL37pSxDIizl91H6mpQzbg4P67NhaOizMRT6ls+BZa/mJZnE1BjxiVdgbYOYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823402; c=relaxed/simple;
	bh=jIM2Nq4f5WnUcnB609WkmMYX+Lj3WU/hNwpGca62GPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0R5qE8tGPnIVcwkO1XkAHsUB0oqz+wrdzt3eBn0cqb3uy5WEUz3KAWTJSYDpYi5OwQ4YU0NFCUpKoDCi/ofL6myGobhwuROGNixU8MvDdYELbS3wlUslqCk63UJRxiz8NNou5nwyIfhKjE9lBszM00c/KeT7WG3DzYyUGkTEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5+XQl+h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733823398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVaggClDk0v6DxqBIr8rSNLckk7O8I9tAhXLRAjBDic=;
	b=i5+XQl+hmkEIIn9xo0OTVLQ8EQGohtXvkIIYhLu1JrBa0VHYLYyHFHdVUyarZTb2kgfFBN
	ij9H8MKDkj+e1dcUhiUh22DuNCRPujPKuzypQ54KFbvrbSx07f5Z0TGr4m80fwTFfo632W
	oGANrPqL4ZEFOAyUq7BjjU+OCURwIZc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-9zsftm08PQumOdxhP8DrZQ-1; Tue,
 10 Dec 2024 04:36:33 -0500
X-MC-Unique: 9zsftm08PQumOdxhP8DrZQ-1
X-Mimecast-MFC-AGG-ID: 9zsftm08PQumOdxhP8DrZQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3AA91955DC1;
	Tue, 10 Dec 2024 09:36:31 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E4BB1956089;
	Tue, 10 Dec 2024 09:36:28 +0000 (UTC)
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
Subject: [PATCH v3 2/6] drm/i915/display/i9xx: Add a disable_tiling() for i9xx planes
Date: Tue, 10 Dec 2024 10:28:42 +0100
Message-ID: <20241210093505.589893-3-jfalempe@redhat.com>
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

drm_panic draws in linear framebuffer, so it's easier to re-use the
current framebuffer, and disable tiling in the panic handler, to show
the panic screen.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/i915/display/i9xx_plane.c     | 23 +++++++++++++++++++
 .../drm/i915/display/intel_display_types.h    |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/i915/display/i9xx_plane.c
index 17a1e3801a85c..671d3914585bf 100644
--- a/drivers/gpu/drm/i915/display/i9xx_plane.c
+++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
@@ -848,6 +848,27 @@ static const struct drm_plane_funcs i8xx_plane_funcs = {
 	.format_mod_supported = i8xx_plane_format_mod_supported,
 };
 
+static void i9xx_disable_tiling(struct intel_plane *plane)
+{
+	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	enum i9xx_plane_id i9xx_plane = plane->i9xx_plane;
+	u32 dspcntr;
+	u32 reg;
+
+	dspcntr = intel_de_read_fw(dev_priv, DSPCNTR(dev_priv, i9xx_plane));
+	dspcntr &= ~DISP_TILED;
+	intel_de_write_fw(dev_priv, DSPCNTR(dev_priv, i9xx_plane), dspcntr);
+
+	if (DISPLAY_VER(dev_priv) >= 4) {
+		reg = intel_de_read_fw(dev_priv, DSPSURF(dev_priv, i9xx_plane));
+		intel_de_write_fw(dev_priv, DSPSURF(dev_priv, i9xx_plane), reg);
+
+	} else {
+		reg = intel_de_read_fw(dev_priv, DSPADDR(dev_priv, i9xx_plane));
+		intel_de_write_fw(dev_priv, DSPADDR(dev_priv, i9xx_plane), reg);
+	}
+}
+
 struct intel_plane *
 intel_primary_plane_create(struct drm_i915_private *dev_priv, enum pipe pipe)
 {
@@ -973,6 +994,8 @@ intel_primary_plane_create(struct drm_i915_private *dev_priv, enum pipe pipe)
 		plane->disable_flip_done = ilk_primary_disable_flip_done;
 	}
 
+	plane->disable_tiling = i9xx_disable_tiling;
+
 	modifiers = intel_fb_plane_get_modifiers(dev_priv, INTEL_PLANE_CAP_TILING_X);
 
 	if (DISPLAY_VER(dev_priv) >= 5 || IS_G4X(dev_priv))
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index ff6eb93337e0a..31804fb99e168 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1482,6 +1482,8 @@ struct intel_plane {
 			   bool async_flip);
 	void (*enable_flip_done)(struct intel_plane *plane);
 	void (*disable_flip_done)(struct intel_plane *plane);
+	/* For drm_panic */
+	void (*disable_tiling)(struct intel_plane *plane);
 };
 
 #define to_intel_atomic_state(x) container_of(x, struct intel_atomic_state, base)
-- 
2.47.1


