Return-Path: <linux-kernel+bounces-254942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E493398A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453B01F229C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BF40BE3;
	Wed, 17 Jul 2024 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aurbL6TI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA173BBCB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206919; cv=none; b=Q3xDeYrjjdnGQdLeDM027GfaxaAmZjSSvt8irmHWY36llAI/WbAKNXVyKeRFVnWz0V4nyBygjeexBc5UxLvhgoInoBIkN6G0IpTgAScsQ44a6PS0Co5tsBsP17F01EzJMfoKyMPtH89yyVDLlVU78i960Z5QFEcdCTB4YEcARhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206919; c=relaxed/simple;
	bh=9NCeiHw/pI0q1akIqoQSlaU7NeHT9SWyjW7WQSdsL3I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwZM+v+YvzLQp/4ZdVWVSzuneYhR+6Bt8POTslDOprKenyGkgUhiqD59wHua41wQC7p5QkXy3JW/hW2i+OcnTRzTpAaY6Asl0hUDidh0Dp0kk4x7wl/8hlYZ5AmQMyYv2lQmuXZ/DI8Hy4OZHBaqdKH1+9trPsAPggF79Npvtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aurbL6TI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721206917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynu5l0dA8yLcoF8+u6imCBMvI85koxu/QAk/w/8RBTM=;
	b=aurbL6TIHUUMixvDpvRTeESC56iKviMW7wYOVNpRFBrXSRcTHKCSQcXvZaAlpBRulDifBX
	5VjjlYZts0LNTm+xqjtC5Fv+ca8NUEffQ9NiH1yQstoiCpf9CF02D1zIfaWRxgul8JguKY
	s6NgqMFNOCm5M549rBB1SX0GbmQUVrI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-CdEsZnMnOkujsJ1i0E8BUg-1; Wed,
 17 Jul 2024 05:01:50 -0400
X-MC-Unique: CdEsZnMnOkujsJ1i0E8BUg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82A3E1955D53;
	Wed, 17 Jul 2024 09:01:48 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CAD81955F40;
	Wed, 17 Jul 2024 09:01:43 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
Date: Wed, 17 Jul 2024 10:48:39 +0200
Message-ID: <20240717090102.968152-2-jfalempe@redhat.com>
In-Reply-To: <20240717090102.968152-1-jfalempe@redhat.com>
References: <20240717090102.968152-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

It allows to check if the drm device supports drm_panic.
Prepare the work to have better integration with fbcon and vtconsole.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
 include/drm/drm_panic.h     |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 948aed00595e..d9a25c2d0a65 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -703,6 +703,26 @@ static void debugfs_register_plane(struct drm_plane *plane, int index)
 static void debugfs_register_plane(struct drm_plane *plane, int index) {}
 #endif /* CONFIG_DRM_PANIC_DEBUG */
 
+/**
+ * drm_panic_is_enabled
+ * @dev: the drm device that may supports drm_panic
+ *
+ * returns true if the drm device supports drm_panic
+ */
+bool drm_panic_is_enabled(struct drm_device *dev)
+{
+	struct drm_plane *plane;
+
+	if (!dev->mode_config.num_total_plane)
+		return false;
+
+	drm_for_each_plane(plane, dev)
+		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
+			return true;
+	return false;
+}
+EXPORT_SYMBOL(drm_panic_is_enabled);
+
 /**
  * drm_panic_register() - Initialize DRM panic for a device
  * @dev: the drm device on which the panic screen will be displayed.
diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
index 73bb3f3d9ed9..c3a358dc3e27 100644
--- a/include/drm/drm_panic.h
+++ b/include/drm/drm_panic.h
@@ -148,11 +148,13 @@ struct drm_scanout_buffer {
 
 #ifdef CONFIG_DRM_PANIC
 
+bool drm_panic_is_enabled(struct drm_device *dev);
 void drm_panic_register(struct drm_device *dev);
 void drm_panic_unregister(struct drm_device *dev);
 
 #else
 
+bool drm_panic_is_enabled(struct drm_device *dev) {return false; }
 static inline void drm_panic_register(struct drm_device *dev) {}
 static inline void drm_panic_unregister(struct drm_device *dev) {}
 
-- 
2.45.2


