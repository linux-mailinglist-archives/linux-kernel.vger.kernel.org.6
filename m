Return-Path: <linux-kernel+bounces-512816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37CA33E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE36A1699CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078022170E;
	Thu, 13 Feb 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnH/ezxd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A910221700
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446026; cv=none; b=jpjPYkiV77HygfRcoWEwMlRjJeg8qLILKnzUPBlsq8uEFeI3fJec/R/HQN61SLwIBMtUPINfpzWJ8OHwPCOa9GmQTKnZZeDEaqP0aWRZsrCNDPKb5wQ/ZzzYhxppgwNQ6UqaOwspwQ6LaRmoh/bCpMBQTph5ecFDHAMOIquUUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446026; c=relaxed/simple;
	bh=Fqn4i8DSgozkqREW9MBCjVdg7ijHh5pPxvzRerz9Twc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJeDHtBbR79VhS4wRc0R9J03P9EZEKyPruFooY46C720nBUMQlldpPoAaWlBGL8TbGlViXz4YyEfSCt18q7HZgo+HV7m/DiLxNLGxICe4HRP0TceyOqhTBNajVVQPZLb0n3Shug4xgqxz0Id+BSJMnJTtkE/rgmjpAAeKQM1QFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnH/ezxd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739446023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vkuXSpIUHTDHSrs1Umi3GC7kTah6gvJvklDFfkYRyo=;
	b=hnH/ezxdevIzcEu5ghe9JfJW2nC1ldBN0IORy2jICB6n1i0O2CDYxxKINDA3w2CXv4XRT6
	oAKPS2tnziXe30ps8K2Jbx5mEi7wH/C1A2OkmludLFDTZX2FFm2bIryTUOru57WCSXEFb0
	MBpYG0vAL0wNRsFCBAX9dSoAVQWFPdA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-rUm5HQykPkifaSSWYHeioA-1; Thu,
 13 Feb 2025 06:27:00 -0500
X-MC-Unique: rUm5HQykPkifaSSWYHeioA-1
X-Mimecast-MFC-AGG-ID: rUm5HQykPkifaSSWYHeioA_1739446018
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39B0219783BA;
	Thu, 13 Feb 2025 11:26:58 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.79])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B71CF300018D;
	Thu, 13 Feb 2025 11:26:54 +0000 (UTC)
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
Subject: [PATCH v4 6/8] drm/i915/display: Flush the front buffer in panic handler
Date: Thu, 13 Feb 2025 12:19:30 +0100
Message-ID: <20250213112620.1923927-7-jfalempe@redhat.com>
In-Reply-To: <20250213112620.1923927-1-jfalempe@redhat.com>
References: <20250213112620.1923927-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Lunar Lake, if the panic occurs when fbcon is active, the panic
screen is only partially visible on the screen. Adding this
intel_frontbuffer_flush() call solves the issue.
It's probably not safe to do that in the panic handler, but that's
still better than nothing.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_atomic_plane.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index 96697ac0ef69a..ee8cc82af3a8b 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -56,6 +56,7 @@
 #include "intel_fb.h"
 #include "intel_fb_pin.h"
 #include "intel_fbdev.h"
+#include "intel_frontbuffer.h"
 #include "skl_scaler.h"
 #include "skl_watermark.h"
 
@@ -1211,8 +1212,14 @@ static void intel_panic_flush(struct drm_plane *plane)
 	drm_clflush_virt_range(panic_map.vaddr, fb->height * fb->pitches[0]);
 
 	/* Don't disable tiling if it's the fbdev framebuffer.*/
-	if (to_intel_framebuffer(fb) == intel_fbdev_framebuffer(dev_priv->display.fbdev.fbdev))
+	if (to_intel_framebuffer(fb) == intel_fbdev_framebuffer(dev_priv->display.fbdev.fbdev)) {
+		struct intel_frontbuffer *front = to_intel_frontbuffer(fb);
+		struct drm_gem_object *obj = intel_fb_bo(fb);
+
+		intel_bo_flush_if_display(obj);
+		intel_frontbuffer_flush(front, ORIGIN_DIRTYFB);
 		return;
+	}
 
 	if (fb->modifier && iplane->disable_tiling)
 		iplane->disable_tiling(iplane);
-- 
2.47.1


