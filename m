Return-Path: <linux-kernel+bounces-237735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39E9923D79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F419285F25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265B815B125;
	Tue,  2 Jul 2024 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtN418T3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4430171AF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922680; cv=none; b=qqiffGi8OgdX3kkI+SzVwmN4vig2gqPEhUzdoaok61yELknwhdTaNpFbl3SQlOX0T3zM4JTAo2W2Sb7S0OiOwIVIacFuwYN1gEXaB9OHVac2IquC7tuUVD9RAMzEFEqW8tGMAir5oEsgAjZKn91vN453Xif3AIQ4M8xebSURL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922680; c=relaxed/simple;
	bh=p16XQDsnyoRa5zH86qxEneX53MPL0IyEPgX2yiy0oBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tutz1Bm3R/Y2t3pEgap8IDrLjHnc9/OEYo1wpxwWZyu6h9PZVHshedWb+5qTNJDF1H80aldXgFZp5xCSeAvMVT+EAZn2X6nZAK8O5+2RaI4xDcsdTssWEea2WhpZKOkqQKnJIDU+Gz6ke5DX2PwIPRmhJnoqn30qnIk47uh1YIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtN418T3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719922677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V6GUg8qJdzfUKFkObYqAigKWCFdCLA/o1qUky7ru9B0=;
	b=KtN418T3qHkKVPJDu8cl723mbsZ5XWOSx6GkLm65qd06EDQwKzuidkR1KWMpBCKbSoNS+F
	jUEuQslNb1UgXo2PgbGiF5PxnyASA0eWq4WIrvfLfsN4VK38mQma38bqW8RTrJXtVAbowA
	n+jHJavS6C9rZnlaMZ9eDQRgvGe8n3Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-lJRGdo3UPRecJTpGrx0DQg-1; Tue,
 02 Jul 2024 08:17:56 -0400
X-MC-Unique: lJRGdo3UPRecJTpGrx0DQg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3B8C1979201;
	Tue,  2 Jul 2024 12:17:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8C0C3000221;
	Tue,  2 Jul 2024 12:17:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] drm/fbdev-dma: Fix framebuffer mode for big endian devices
Date: Tue,  2 Jul 2024 14:17:37 +0200
Message-ID: <20240702121737.522878-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The drm_mode_legacy_fb_format() function only generates formats suitable
for little endian devices. switch to drm_driver_legacy_fb_format() here
instead to take the device endianness into consideration, too.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: Patch has only been compile-tested since I lack an environment
       for testing it. But it's the same fix as I required for the
       drm_mode_legacy_fb_format() in drm_fbdev_generic.c / drm_fbdev_ttm.c
       so I think this should be fine.

 drivers/gpu/drm/drm_fbdev_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index 97ef6300d47e..fdef4a2f883f 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -101,7 +101,8 @@ static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
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


