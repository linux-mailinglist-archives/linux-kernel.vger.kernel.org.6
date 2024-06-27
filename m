Return-Path: <linux-kernel+bounces-232789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F10791AE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409311C225C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C759119A2BB;
	Thu, 27 Jun 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpXf3VPl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4119A2AD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509746; cv=none; b=ZpzFuKPOaC+/FWGJJE5bi39M+I9QWHZBfzr+MBVJ4MTZOBabfmDCq64LgK/B183+LPvInjxHzy9NVXMQdCKN0bEBT7a0so0Xg24KzgqNZNieJXZ3+KRrVgXarUL6sl5s3Nwr69gJYE8vwfzvJQ8WEsICaHK55yeEpCqSvqXmzH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509746; c=relaxed/simple;
	bh=gc+axrfPkqFuDVU/ebPk/NSkLyQijtDPeUZCQZA4Auo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvkLfjEOJgZEyBoLXBnuc0BkDUAOyMbPr2kc37bwMQ/2w9VFKfz/fMJAEYOEpWRhvu2Cz1B/EGGP4nQZW32M3D0CYJ1J82DVq3mjchD8fZpfJk2k04Mhe3E6k0a85ybUXFg7AJ7ZbsaBZXRVoP+eSM2iU/XwI/TYfoFoX80Rywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpXf3VPl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719509743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=356Lg5UUSnmEm4pXEbf26iOKxmVufXs5pH3pFisEAVQ=;
	b=fpXf3VPldT9AjsZUvdOtjiAjD3eYve80SLzrt+MqbZT38JOcZjEH2OK4J+Dxfoe42ZOhbW
	a2N4kdXUPKIeC15ynXiUDdWfnwnSRHSOYTSpy/BN9kzinYjxSY4LXnl9hMrh/xmvJua0xe
	sK+ctwmRAeMU0443a3OvzrqLg+FIi5w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-ekehw8qOMUmLpp6EyUneIw-1; Thu,
 27 Jun 2024 13:35:39 -0400
X-MC-Unique: ekehw8qOMUmLpp6EyUneIw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 850161956096;
	Thu, 27 Jun 2024 17:35:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.31])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6788A3000603;
	Thu, 27 Jun 2024 17:35:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/fbdev-generic: Fix framebuffer on big endian devices
Date: Thu, 27 Jun 2024 19:35:30 +0200
Message-ID: <20240627173530.460615-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Starting with kernel 6.7, the framebuffer text console is not working
anymore with the virtio-gpu device on s390x hosts. Such big endian fb
devices are usinga different pixel ordering than little endian devices,
e.g. DRM_FORMAT_BGRX8888 instead of DRM_FORMAT_XRGB8888.

This used to work fine as long as drm_client_buffer_addfb() was still
calling drm_mode_addfb() which called drm_driver_legacy_fb_format()
internally to get the right format. But drm_client_buffer_addfb() has
recently been reworked to call drm_mode_addfb2() instead with the
format value that has been passed to it as a parameter (see commit
6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()").

That format parameter is determined in drm_fbdev_generic_helper_fb_probe()
via the drm_mode_legacy_fb_format() function - which only generates
formats suitable for little endian devices. So to fix this issue
switch to drm_driver_legacy_fb_format() here instead to take the
device endianness into consideration.

Fixes: 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()")
Closes: https://issues.redhat.com/browse/RHEL-45158
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 drivers/gpu/drm/drm_fbdev_generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index 97e579c33d84..1e200d815e1a 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -84,7 +84,8 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
 		    sizes->surface_width, sizes->surface_height,
 		    sizes->surface_bpp);
 
-	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_driver_legacy_fb_format(dev, sizes->surface_bpp,
+					     sizes->surface_depth);
 	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
 					       sizes->surface_height, format);
 	if (IS_ERR(buffer))
-- 
2.45.2


