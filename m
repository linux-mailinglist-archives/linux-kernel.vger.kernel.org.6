Return-Path: <linux-kernel+bounces-514692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36475A35A54
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047601891A36
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993525A648;
	Fri, 14 Feb 2025 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Neips9eF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34909259487
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525214; cv=none; b=XrOSrIg38rOB47zJqehwFyVLLNzbR9F5zikt5mTlkLVeFv/RAxg7wG5H3PTPY1scx8uCjTn9tiAoCHe5xFetuYOMum6iL58/729LUCWkueU8NA+wyTSdJurU3UnqyyuMgof5H/lyXqEbJ88MfXHgi35e5bOXAwPl+2J/A0uItbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525214; c=relaxed/simple;
	bh=oELZ7cvHr5c0TJ1+4awGQDbtEA2mNVPcdu8tOjIL58I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWReY5dENQ5O60yEm/TPiy1YP/hP4GIhfo94wDSv55t4802qmRPs6gHF6d9zy8aUy8hQE3vI2AxezAiruK0Vx3VwqbSpydVfrpfIUlW2jFVwrhZjBztG17cnJAzLNML9MWTjH25JQxuBZTFRw/I/dI5fm4GqcPumkddkQGCN/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Neips9eF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739525212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FC9Yc2LppzQUKtjEidKSRzv2uh/9B1gDLqI/7/EoskA=;
	b=Neips9eFW/pX7NbKA7OxYt3TbunRPcZLyFEcRajoHUKfqpGgq47IY4LPjbQfAOIq+LnvAV
	ISG35CKEh9hVu6p7ctnEhP5ucAcvSKPrXaNf43Coyb1vB9PLsZsE4gqNx/JPYbv5EldD3a
	SyrCyyaTFdKeXbHBc4ZVD+OV2ZeYi14=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-EkeN1uNOO32SXE4eNsWS6w-1; Fri,
 14 Feb 2025 04:26:48 -0500
X-MC-Unique: EkeN1uNOO32SXE4eNsWS6w-1
X-Mimecast-MFC-AGG-ID: EkeN1uNOO32SXE4eNsWS6w_1739525207
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26BFD180087A;
	Fri, 14 Feb 2025 09:26:47 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7BB8180056F;
	Fri, 14 Feb 2025 09:26:43 +0000 (UTC)
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
Subject: [PATCH v5 6/8] drm/i915/display: Flush the front buffer in panic handler
Date: Fri, 14 Feb 2025 10:21:41 +0100
Message-ID: <20250214092608.2555218-7-jfalempe@redhat.com>
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
index c229c8618b5db..e5dccfba4508d 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -56,6 +56,7 @@
 #include "intel_fb.h"
 #include "intel_fb_pin.h"
 #include "intel_fbdev.h"
+#include "intel_frontbuffer.h"
 #include "skl_scaler.h"
 #include "skl_watermark.h"
 
@@ -1224,8 +1225,14 @@ static void intel_panic_flush(struct drm_plane *plane)
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


