Return-Path: <linux-kernel+bounces-429118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4FB9E1798
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31620285788
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E651E0DA9;
	Tue,  3 Dec 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fn8raolU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9B1E0B73
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218154; cv=none; b=JSg6f8qhMTZ/Ba0NWO5FYqVz1PcBVy4coU5IqAvnZEIbgNJ6+cWp9rt1c4r97qtno1bh7a+TjsDQscOna7UavvUW9wTtIwDfQEpeSV3Nt49q1VmaTIgzq0Dhvzy26ea7Pr49ydUtLCQk/5CR93hgwZCtiEkUc4heoU6qQahkZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218154; c=relaxed/simple;
	bh=h5VQd7+c9p8OFCjYvfgwZpXpJjA5ja27cfnz9QR9lxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enae4vNhB/TrLeevx7THPyfdOH/DjLAfQu75A3PfDHeyByHTXDxxXD5uWiSzx4j+boKVpWxoPFU/uI004BX/q7J5COQVprm0CPTexFh4i55FsM/qXJUISssuq+TMHduz0LRnHygo6egHu9K5zrG8jx4XUDeSd/SCf0xJSAFY768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fn8raolU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1SPCidU/nPAyXevm9HpcSlPBA6QeziwCsu4eR1+yCY=;
	b=fn8raolUtfvFvfvEyvK5VpKUJWL6TZi8FRvmZRs4Tsd3fvhx6ncmBme39S8ynrgA2gBQAv
	mVqxHxSVWqgcxNa4PuWmvNldE7RPWFsy9jK9cLzaHQoxUxF96J4bQUBB78YRgzwubYhCLm
	vRguQUpS45Kr5BaLkJdNA8BHtgnBurY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-elp_56-eO4Why43CmkO9LA-1; Tue,
 03 Dec 2024 04:29:08 -0500
X-MC-Unique: elp_56-eO4Why43CmkO9LA-1
X-Mimecast-MFC-AGG-ID: elp_56-eO4Why43CmkO9LA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5228F1954211;
	Tue,  3 Dec 2024 09:29:07 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.255])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6757A1955D47;
	Tue,  3 Dec 2024 09:29:04 +0000 (UTC)
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
Subject: [PATCH v2 3/5] drm/i915/display: Add a disable_tiling() for skl planes
Date: Tue,  3 Dec 2024 09:50:20 +0100
Message-ID: <20241203092836.426422-4-jfalempe@redhat.com>
In-Reply-To: <20241203092836.426422-1-jfalempe@redhat.com>
References: <20241203092836.426422-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

drm_panic draws in linear framebuffer, so it's easier to re-use the
current framebuffer, and disable tiling in the panic handler, to show
the panic screen.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 .../drm/i915/display/skl_universal_plane.c    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index a0a7ed01415a5..62aa40b6e2347 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -2560,6 +2560,25 @@ static u8 skl_get_plane_caps(struct drm_i915_private *i915,
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
@@ -2601,6 +2620,7 @@ skl_universal_plane_create(struct drm_i915_private *dev_priv,
 		plane->max_height = skl_plane_max_height;
 		plane->min_cdclk = skl_plane_min_cdclk;
 	}
+	plane->disable_tiling = skl_disable_tiling;
 
 	if (DISPLAY_VER(dev_priv) >= 13)
 		plane->max_stride = adl_plane_max_stride;
-- 
2.47.1


