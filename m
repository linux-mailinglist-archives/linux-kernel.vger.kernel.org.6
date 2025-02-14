Return-Path: <linux-kernel+bounces-514688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7945BA35A53
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A23F3AF575
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FDF24BBF6;
	Fri, 14 Feb 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tp+9/aRN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A590241660
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525205; cv=none; b=T6ypsO5h+zU9jYCTRhIgQ0EvZI5dfaJVeFhkEMI0mrQCGe8mwQ+TVPxUJZgRntvKHSnzumJmOXZbk6U9GYjoP6nwcqgI/hyu5bvfrSbG+Az8OQyaX6lHeIoFFrbSUaz+IYJUfcwOW+QLHrqK2/OvUGIUC/HS5j/oGAMMIvo32rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525205; c=relaxed/simple;
	bh=x5kMJ4mU0WKHiZVsxuXd5IALFSW1mdQ4Wq66TNlusUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQMw4loG42vYQ3BOLaBqIW1fNHAyz+GReQH5YVpLyvX2ApHcsw9fmfzoFAwXTexsBkQNPXOpi92xj7v56/JQZWhyqz7sCW4xoabZg+ozN2hgMN9hpK6o45UCcfNyHRRnRYAQ7LI2oDBRGesAATPfwhR78NdYiZHjhXlN40hjKOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tp+9/aRN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739525203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JK04INHG5UyOm3qCRe/HTI+C1zqotKR2ndPyjDYxCQQ=;
	b=Tp+9/aRNf0xvtdcl5CSwIc/2z2sMj2VJfSQhqFC8lMysHXXPzaMoTmvyV5Md0MT4vhIdzl
	6zroNV4bIAKNe4oD7nJJFT81LhVtVskrgbELBzsfbw2bm/ZZAM9pG4ZAM3CishVI/lD/WA
	OZf+XcxFteQqYqkyszGYFMD0Ay6hNBE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-_QOfwnhAOJ2q1aR2jhJgAg-1; Fri,
 14 Feb 2025 04:26:34 -0500
X-MC-Unique: _QOfwnhAOJ2q1aR2jhJgAg-1
X-Mimecast-MFC-AGG-ID: _QOfwnhAOJ2q1aR2jhJgAg_1739525191
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E405918EB2CB;
	Fri, 14 Feb 2025 09:26:30 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A13B180035E;
	Fri, 14 Feb 2025 09:26:26 +0000 (UTC)
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
Subject: [PATCH v5 2/8] drm/i915/display/i9xx: Add a disable_tiling() for i9xx planes
Date: Fri, 14 Feb 2025 10:21:37 +0100
Message-ID: <20250214092608.2555218-3-jfalempe@redhat.com>
In-Reply-To: <20250214092608.2555218-1-jfalempe@redhat.com>
References: <20250214092608.2555218-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

drm_panic draws in linear framebuffer, so it's easier to re-use the
current framebuffer, and disable tiling in the panic handler, to show
the panic screen.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/i915/display/i9xx_plane.c     | 23 +++++++++++++++++++
 .../drm/i915/display/intel_display_types.h    |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/i915/display/i9xx_plane.c
index aef8d8b7ea85f..d5538adbb3624 100644
--- a/drivers/gpu/drm/i915/display/i9xx_plane.c
+++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
@@ -866,6 +866,27 @@ static const struct drm_plane_funcs i8xx_plane_funcs = {
 	.format_mod_supported = i8xx_plane_format_mod_supported,
 };
 
+static void i9xx_disable_tiling(struct intel_plane *plane)
+{
+	struct intel_display *display = to_intel_display(plane);
+	enum i9xx_plane_id i9xx_plane = plane->i9xx_plane;
+	u32 dspcntr;
+	u32 reg;
+
+	dspcntr = intel_de_read_fw(display, DSPCNTR(display, i9xx_plane));
+	dspcntr &= ~DISP_TILED;
+	intel_de_write_fw(display, DSPCNTR(display, i9xx_plane), dspcntr);
+
+	if (DISPLAY_VER(display) >= 4) {
+		reg = intel_de_read_fw(display, DSPSURF(display, i9xx_plane));
+		intel_de_write_fw(display, DSPSURF(display, i9xx_plane), reg);
+
+	} else {
+		reg = intel_de_read_fw(display, DSPADDR(display, i9xx_plane));
+		intel_de_write_fw(display, DSPADDR(display, i9xx_plane), reg);
+	}
+}
+
 struct intel_plane *
 intel_primary_plane_create(struct intel_display *display, enum pipe pipe)
 {
@@ -1001,6 +1022,8 @@ intel_primary_plane_create(struct intel_display *display, enum pipe pipe)
 		}
 	}
 
+	plane->disable_tiling = i9xx_disable_tiling;
+
 	modifiers = intel_fb_plane_get_modifiers(display, INTEL_PLANE_CAP_TILING_X);
 
 	if (DISPLAY_VER(display) >= 5 || display->platform.g4x)
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 6a82c6ade549b..38e2108b01ff6 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1507,6 +1507,8 @@ struct intel_plane {
 			   bool async_flip);
 	void (*enable_flip_done)(struct intel_plane *plane);
 	void (*disable_flip_done)(struct intel_plane *plane);
+	/* For drm_panic */
+	void (*disable_tiling)(struct intel_plane *plane);
 };
 
 #define to_intel_atomic_state(x) container_of(x, struct intel_atomic_state, base)
-- 
2.47.1


