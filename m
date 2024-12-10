Return-Path: <linux-kernel+bounces-439233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8739EAC94
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D912931E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801392153C8;
	Tue, 10 Dec 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0HAlAF0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CC226187
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823402; cv=none; b=SvH5bHwjk4JI+HaLhxKoZ28E8QvAtEoA/k/kgJk2VKshgaV+xyvTDbQX1xW60/GqHv3ZSGDNfI1g1JTLlVriRwXlQdWIkYXy5Yi/aiJ/p+Zgf87xILHs5lE+IYtrJo3FLBaMxOVj1pBJkk00oJKan8pf7+oCB+OIaac6e/aoJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823402; c=relaxed/simple;
	bh=VbadVLs847riKOPtPZOOzLVpGiQTZz6DcW4e6MXix6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGcXawQvJRXZ7HGqqswa5sOoxcCozKlccO8pMjxnk5iyQ+k3zmy6XDCdWzp+/dHkLodQ5rnrpX8KUtitAFKHMcrgOXlJG36eojp5yLdkkUIRrXK9tXeX/+EfehBGyROwaT9DeBZDTsqwZr6FKMCHnNS+1rZJq7LNKncHL1JUDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0HAlAF0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733823400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWTb3hoUCwegak53chUf+LNZzlAZcUL2Dp00ardPGKc=;
	b=N0HAlAF0jkgSk9tkv02mOv1LJiA4Ea4nLXHCCXIvSzGl7JMYt08fKh0jRnnO2Z2L30ITTR
	A7H3zgQzVtvEAZPbyE6CEQA9TEnBBvSP7ccSiOBjfrIeiAOUZlcpiLhU/qRkDGW7MF6zvO
	6dhN2aWlax1uSdLWRY5FX4dAwjSdBoI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-dy3X_BvfMaqKjhMJ3vfAcA-1; Tue,
 10 Dec 2024 04:36:37 -0500
X-MC-Unique: dy3X_BvfMaqKjhMJ3vfAcA-1
X-Mimecast-MFC-AGG-ID: dy3X_BvfMaqKjhMJ3vfAcA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB0371955D53;
	Tue, 10 Dec 2024 09:36:35 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6AD041956089;
	Tue, 10 Dec 2024 09:36:32 +0000 (UTC)
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
Subject: [PATCH v3 3/6] drm/i915/display: Add a disable_tiling() for skl planes
Date: Tue, 10 Dec 2024 10:28:43 +0100
Message-ID: <20241210093505.589893-4-jfalempe@redhat.com>
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
 .../drm/i915/display/skl_universal_plane.c    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 038ca2ec5d7a6..e2a54547a29d5 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -2575,6 +2575,25 @@ static u8 skl_get_plane_caps(struct drm_i915_private *i915,
 	return caps;
 }
 
+static void skl_disable_tiling(struct intel_plane *plane)
+{
+	u32 plane_ctl;
+	struct intel_plane_state *state = to_intel_plane_state(plane->base.state);
+	struct drm_i915_private *dev_priv = to_i915(plane->base.dev);
+	u32 stride = state->view.color_plane[0].scanout_stride / 64;
+
+	plane_ctl = intel_de_read(dev_priv, PLANE_CTL(plane->pipe, plane->id));
+	plane_ctl &= ~PLANE_CTL_TILED_MASK;
+
+	intel_de_write_fw(dev_priv, PLANE_STRIDE(plane->pipe, plane->id),
+			  PLANE_STRIDE_(stride));
+
+	intel_de_write_fw(dev_priv, PLANE_CTL(plane->pipe, plane->id), plane_ctl);
+
+	intel_de_write_fw(dev_priv, PLANE_SURF(plane->pipe, plane->id),
+			  skl_plane_surf(state, 0));
+}
+
 struct intel_plane *
 skl_universal_plane_create(struct drm_i915_private *dev_priv,
 			   enum pipe pipe, enum plane_id plane_id)
@@ -2620,6 +2639,7 @@ skl_universal_plane_create(struct drm_i915_private *dev_priv,
 		plane->max_height = skl_plane_max_height;
 		plane->min_cdclk = skl_plane_min_cdclk;
 	}
+	plane->disable_tiling = skl_disable_tiling;
 
 	if (DISPLAY_VER(dev_priv) >= 13)
 		plane->max_stride = adl_plane_max_stride;
-- 
2.47.1


