Return-Path: <linux-kernel+bounces-418503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A02B9D624E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04769B25353
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A71DFD9B;
	Fri, 22 Nov 2024 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L0R5LLuX"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A11DF73B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292895; cv=none; b=ID9ECzrfPhW0I09x92hmRTb+nB3/ZOsVXvu0+0YYV34SMaeFdGkiXxD31u6HSOtg3OGs28Fpkb4bij+BKvCd0OwPM7NxVZlEfzAsKuObh4J8kmAqxT4SM2sggm9hDY3M5ySFh84IIKnOIaoQ9v9WU7bIh1tAwOqVBT6voQW1V7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292895; c=relaxed/simple;
	bh=xbDbD69KZNScHlgCMisg2HJq8BICvN3NQAqTm8bzP/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJn3NljUyl5TY5rPwR9yxdpCuBXACS/D0PtN7O/Th8ydmGl2V2gjw3xM9bzpztl6cVLkQg3Qb4e7/v83ketJGNNYD09/OHcfZr5vzyufO4zUKpTJi5bBSiDYwp8YUG44STDgc/3n6firM1c3/sT6WNboDgCs3LI78GAIyco3XlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L0R5LLuX; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B9D6FF80C;
	Fri, 22 Nov 2024 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7mrH4nMB6P5AeJ5Mz8Ak1miBGu6SgNHfqh2MFhH/Sk=;
	b=L0R5LLuX33gt5SA18g0DlnbRhP05jPVopQIj9c8WQDAC/jFD7ycEhQNGsXnYZ0ns4uurRb
	vDJzvl+isW0pX9tmJQ7Z3pXDuq6eD48AJFtvrapfR9RJTqKsZAWqiNofNikWzgish73YvB
	jSKHYfpKwOeWEQ1RnVZ44yZcG4iHH6p3GoMcnVZ/jRgWj2+eib1Y9sKWf/KxHSxi1xcMge
	ZG9x+QlBgP018yuR+/xDCx1FZipLzXsgcIZyEyb4YJgE3ayw/DlRslzveiziyUjmis73ry
	EKcr4P8W0Ocm1TntOdPZSVRkA2ZpmyQ3EJdnoQcrc5hgHHEmeNd67Uj4yFhEIQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:28:00 +0100
Subject: [PATCH v5 5/5] drm/vkms: Switch to managed for writeback connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-vkms-managed-v5-5-1ab60403e960@bootlin.com>
References: <20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com>
In-Reply-To: <20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=xbDbD69KZNScHlgCMisg2HJq8BICvN3NQAqTm8bzP/k=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLEPFkspIJns27wzQHp2ZOPEZwLqsuzSD1Zw5
 l0evx6X0wyJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CxDwAKCRAgrS7GWxAs
 4ljQEACMYE8CiMHmW/LFkuycRe9+cFYBWwhAixe0AubRsW5P53/jwu2qWrHkWb60Xb85+uAAwm5
 Ob3U1y0Te1PtYzFxopxxl7Bw0NZzxjZkzyACVodyfDkAvBI6SdVfwLE0gruCaXNd5FigQq3C2DT
 cM9FQdH2LvnoRTW7uI5QTW+5RB5kvitp/TzSWx9umlBsk3ummiNj4lkvdMCuT9+5ucBhWVb8QCa
 9GqqYu0SJGC+jhi5or065XHJ/iKhoyjHMil+XPJYnPhmEKMM5DV/g74jWUXPLNitDjeiylyFAUT
 f8iwL+UILfmK1i+nQe1GWMWAqkr8kDhkjD4JcBW5Op/pj/FF9PdiMLL6mpoVZuqu1GLI1/5zcew
 rW/VPJ4RMzKC0x/1OfRe2juj/eIF/xsnMlyjn6dXuu7jwwEsTQwL7KPaZ+qa9anzGvuDIV84WW/
 G86rgq5FUBDv177fa5WZWsCtUkAs5cX3ljlxttUjG3tycvY107SaGC/IzxXnOOMEfbAVoHDdmds
 q7sVF9C5yNl/PiljOEaGwQ+U/AyjckHHpTPEFESZXDqMdnRri9DZTzCk179RpCW16poFAVqZojH
 oElfpbVz9ZgTqQu6y5p6LtObOhyfbksL/iS88fxdD+a9doNHK7tQVtK2W861oPc1qvyC1iIeI/q
 yFEubUDCBY+XkdA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current VKMS driver uses non-managed function to create
writeback connectors. It is not an issue yet, but in order
to support multiple devices easily, convert this code to
use drm and device managed helpers.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_writeback.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 79918b44fedd7ae2451d1d530fc6d5aabf2d99a3..f12417b2d24803a33e4ff56108cc89704a500faf 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -24,7 +24,6 @@ static const u32 vkms_wb_formats[] = {
 
 static const struct drm_connector_funcs vkms_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -169,10 +168,10 @@ int vkms_enable_writeback_connector(struct vkms_device *vkmsdev)
 
 	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
 
-	return drm_writeback_connector_init(&vkmsdev->drm, wb,
-					    &vkms_wb_connector_funcs,
-					    NULL,
-					    vkms_wb_formats,
-					    ARRAY_SIZE(vkms_wb_formats),
-					    1);
+	return drmm_writeback_connector_init(&vkmsdev->drm, wb,
+					     &vkms_wb_connector_funcs,
+					     NULL, NULL,
+					     vkms_wb_formats,
+					     ARRAY_SIZE(vkms_wb_formats),
+					     1);
 }

-- 
2.47.0


