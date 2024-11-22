Return-Path: <linux-kernel+bounces-418499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7EA9D624B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33BCEB25025
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722FC1DEFC8;
	Fri, 22 Nov 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WjntKrN/"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5981AD2F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292891; cv=none; b=cpgWViaV08zB6J+3hJbZvtf6BuxmtXqZYtm+JL01/QumaiVhyTYuY6/MwnYrOIWlsc6ZfDjjC3D7tRm8kt8deLBn1glpBkUrk5GJyFi8gFwxvYTlSUGIG88OBN/QVleGVyYJoDoI3P5wsTGryZDl+Y7HVV3Kt3mg2k5WszMuK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292891; c=relaxed/simple;
	bh=XEV4zTuerxCLsNqXQw8FHPfNTwP3QX1/G4BM5KyG/Z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SX0CcGaGgu2g2hAbZWdv4thQwIUoFm6GImLMcxojdXDtLoIdIjnmD27oaU3AbiWjnBjcPuyz/Y/f66ffn/FZ/UydUh+01ibTx68lZr7ZuKYDlfzBnOg8hmjkNzVKWuQ2XAUjhKB4ZFTAl25ozybYfXwsDCsK7rwLkC6xHNnTCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WjntKrN/; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 780AFFF80B;
	Fri, 22 Nov 2024 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5vSVpQoMOulPKDsFOnk9t8Cvw8EsHMM8U344JSWPgE=;
	b=WjntKrN/YT45dRxmRpCG151kujEg8R4bTgk8H70L+oJFPkIJCfXtQp6KeyuRxkE8lJNQ/H
	VBgkqlxyFM/REK6cM9RUVAaHc8RcQ9rzhxDzYZY5fTbKLWsiw06S9+Pwo93hP44l8dPPM/
	3TLZGbkGEpXWM8WKH/iVwy9iFjJBKCoSmyiHbF1b1GN3fNWSIl706HQUB6M58Jx0ZmgwVJ
	SdOflr59xAWZTL1CcQ+xLpxQxpunoN6fyAOLfoWNaAGmMj8jf7Vinb2Ykmxtz1byZx+YCQ
	850+bK7PhEAnjqI/pz58mscjH9eRU4HHIiILMX8ycqkTFBGU/ZEHQrau8H0w2w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:27:56 +0100
Subject: [PATCH v5 1/5] drm/vkms: Switch to managed for connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-vkms-managed-v5-1-1ab60403e960@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=XEV4zTuerxCLsNqXQw8FHPfNTwP3QX1/G4BM5KyG/Z0=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLENDxCYDnRNQxVjqY0cagMP2IrqHuOO4Rrh4
 VyQ43LWIbeJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CxDQAKCRAgrS7GWxAs
 4iXGD/9919p9KmYVzlK3US5TZHb0DtHSWsXD91LpsFjLyALL7k4DOQONGO2kJktJYGAaaqpw5g+
 GmORa3CUjzfMXDR9YQwW2gnlSb97JYLsU+5yyULWBOWQBNQFHrN2s/Hou3xoTb3r4Ezcke1wfPj
 xB3rw4QddrxgTfucEU2k2PSCAecO84dgtRdNLYWXH2CpoidZy914AXWHwUaUTjzk2lrPAclAWIY
 5hotOodaz60iYa2Z5o7BgZxQfU/VSuxa5Y1TKnD5HwEmmxbJ7ExkeKtQbUZDrISEhCcQaY6akKs
 lYxQg5SK3B8JlKP6q4qz+79h6OPvBjHnZTItuwwGbgL+Ugrajd+z6L4TYNteE8ORaDYDRqETN1N
 K53aG6uu1Ezd9BTyXlEKpnmjYeZDb97n5tzckvHGvJb+qa1rdnPXS/Uo9DAU+giBn8404/Arpph
 G467DBB+FgyhEqpD9Kljya/4Xb+sgaGBvKmmPvPX3T9SafWQdsfB6eqDKZ2UEuGumphVVL/Xt/w
 ub+g105ozdgCK2ic0TRYFT3RXWwdYLWDuFaVF9NURVsXmMaJMlwXBRBoaslNtMov9aDWV8OKa1t
 T5d0Ja7mF8x+ewb5XZDVAayX1jvVHhI3qTJqmGvAOQvcGlsO7ySfFomy/qBeG8jfa86UFHpHPSL
 t/Z1+pDci/AKfcw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current VKMS driver uses non-managed function to create connectors. It
is not an issue yet, but in order to support multiple devices easily,
convert this code to use drm and device managed helpers.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_output.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 8f4bd5aef087b459d37d0cbbf90fe0145090917a..570823ecb28f589e6323036590ec05a2f633bc9b 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -3,11 +3,11 @@
 #include "vkms_drv.h"
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 
 static const struct drm_connector_funcs vkms_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -75,8 +75,8 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
-	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
-				 DRM_MODE_CONNECTOR_VIRTUAL);
+	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
+				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init connector\n");
 		return ret;
@@ -88,7 +88,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
-		goto err_encoder;
+		return ret;
 	}
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
 
@@ -110,9 +110,5 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 err_attach:
 	drm_encoder_cleanup(encoder);
-
-err_encoder:
-	drm_connector_cleanup(connector);
-
 	return ret;
 }

-- 
2.47.0


