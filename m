Return-Path: <linux-kernel+bounces-514687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D718EA35A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D837A33A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A177242908;
	Fri, 14 Feb 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2ONchEi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4C241660
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525201; cv=none; b=pV33FDB2vluMB7Coe6wCcCheLs3dqb09RIWq4BfTlRs8qVaMC/FC9wzzfAwHrrYlxXYRb088yjJkNc1bH9cxaLfjoWKmMxHqeTRSW8rCOEDywetoGuu/BFz7sJQhCkpnIjfHZdyTA6dX4gCmC8oRnJNJdbHmdjUKVto6Rm7mq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525201; c=relaxed/simple;
	bh=O9aIt+EK+lv5gwR5kIEdGtBpEmMZKeUsyfBupez9/jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1FddIZO+II5oF/wyobBqhO0soglc/rZorVma1+OKCSj3y532fXSBwt0nkiegtA/Cptl0AFRWHvdfcfttnNMZXLeuljnTk/QaMbhjd6CsCYUW1uSt1zk0CvQhNNEIrXzoLcJLuqbDnPFHCUOEO9UppMkQEjBKW0DmAnGWxJxtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2ONchEi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739525198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfKE1kNNaqYoc1NBMaOS+ggx5uGIG296IykfzUyaXYE=;
	b=U2ONchEiegNBrMquXwXXx5GAYX3awwt7R26uAFz88T7Z4jzjGtL07gXuKOT7P7DR5TnZw0
	gKpQpe2iMAtianuGyOoLI8npb8PCnwx+X8UXQPM5dTle4/H6jszUB4WUNFgr5IGE2JwvUx
	SS4iulkidNcOMim1kP27idn/l1d7Okg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-HVKhkX9COyOcrUJJuCl4gA-1; Fri,
 14 Feb 2025 04:26:36 -0500
X-MC-Unique: HVKhkX9COyOcrUJJuCl4gA-1
X-Mimecast-MFC-AGG-ID: HVKhkX9COyOcrUJJuCl4gA_1739525195
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11E8519373D9;
	Fri, 14 Feb 2025 09:26:35 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B0B0180035E;
	Fri, 14 Feb 2025 09:26:31 +0000 (UTC)
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
Subject: [PATCH v5 3/8] drm/i915/display: Add a disable_tiling() for skl planes
Date: Fri, 14 Feb 2025 10:21:38 +0100
Message-ID: <20250214092608.2555218-4-jfalempe@redhat.com>
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
 .../drm/i915/display/skl_universal_plane.c    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index eb85d3d6cdc3c..3eef0f9f4241b 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -2703,6 +2703,25 @@ static u8 tgl_plane_caps(struct intel_display *display,
 	return caps;
 }
 
+static void skl_disable_tiling(struct intel_plane *plane)
+{
+	struct intel_plane_state *state = to_intel_plane_state(plane->base.state);
+	struct intel_display *display = to_intel_display(plane);
+	u32 stride = state->view.color_plane[0].scanout_stride / 64;
+	u32 plane_ctl;
+
+	plane_ctl = intel_de_read(display, PLANE_CTL(plane->pipe, plane->id));
+	plane_ctl &= ~PLANE_CTL_TILED_MASK;
+
+	intel_de_write_fw(display, PLANE_STRIDE(plane->pipe, plane->id),
+			  PLANE_STRIDE_(stride));
+
+	intel_de_write_fw(display, PLANE_CTL(plane->pipe, plane->id), plane_ctl);
+
+	intel_de_write_fw(display, PLANE_SURF(plane->pipe, plane->id),
+			  skl_plane_surf(state, 0));
+}
+
 struct intel_plane *
 skl_universal_plane_create(struct intel_display *display,
 			   enum pipe pipe, enum plane_id plane_id)
@@ -2749,6 +2768,7 @@ skl_universal_plane_create(struct intel_display *display,
 		plane->max_height = skl_plane_max_height;
 		plane->min_cdclk = skl_plane_min_cdclk;
 	}
+	plane->disable_tiling = skl_disable_tiling;
 
 	if (DISPLAY_VER(display) >= 13)
 		plane->max_stride = adl_plane_max_stride;
-- 
2.47.1


