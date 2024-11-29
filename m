Return-Path: <linux-kernel+bounces-425773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ADB9DEAE7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6215163EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56CE19D897;
	Fri, 29 Nov 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ymgv2iZJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F419CD1B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897391; cv=none; b=esfcM4eByWMqsWeJlw32bWW8G/4/gGomk5xGE4GoQcS+txkWLECT0rKHUsREIAJw4v8HLk3EgMo8va4lL40c9tM+7zi924j2EqWdeAhCFzSZxraKy4TRwsNYEUcuXdAxaTE2rYBPuTL8TC9nC+gwSgntEPVlGVaKKVA/vUW8Xao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897391; c=relaxed/simple;
	bh=gw6PH58DzwQp7vNg0mkxHGhlHHyhMP0zCylY0IomNJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUG5OiPlMIT3YDzXDDA7loDuIHQ7WEHwf72dJzem9Ah2C7w5fAgXRU4Z+wrCup+yoEyXgkn4pWJclRT3jSYhLy55Uwzm44QVVfppPbILIFe0h0bI1hmKtVM1O0Yz/R+JaoMSu+lG7eaW9cS9QcEx3vKCoShnSTczlaXdP/MoajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ymgv2iZJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732897388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAvyenYOj358pWA8lHph+Zw+DdMbqz/bnlrW/BlN30Q=;
	b=Ymgv2iZJ8XcxtYXTFHD3a17oRD0ux4V13yc+Qqy9Xpe8lK7FOwsDmqk57wlZa9Qpkt7jcc
	FXKvekLmYSesWlbsBmFJckosne+nunwS9YiT1eLXpQPd9bxa/i8KpYGB1cy7p7AObD1rlO
	PfOfwldSaw41JpuUyq3X8Gubn15fVLA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-5tEP70ZPN7OL8hpVfnJcIQ-1; Fri,
 29 Nov 2024 11:23:04 -0500
X-MC-Unique: 5tEP70ZPN7OL8hpVfnJcIQ-1
X-Mimecast-MFC-AGG-ID: 5tEP70ZPN7OL8hpVfnJcIQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A7F019560AA;
	Fri, 29 Nov 2024 16:23:02 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.192.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 001881955F41;
	Fri, 29 Nov 2024 16:22:58 +0000 (UTC)
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
Subject: [PATCH 3/5] drm/i915/display: Add a disable_tiling() for skl planes
Date: Fri, 29 Nov 2024 17:20:28 +0100
Message-ID: <20241129162232.7594-4-jfalempe@redhat.com>
In-Reply-To: <20241129162232.7594-1-jfalempe@redhat.com>
References: <20241129162232.7594-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
2.47.0


