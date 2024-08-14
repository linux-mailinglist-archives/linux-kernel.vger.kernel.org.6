Return-Path: <linux-kernel+bounces-286652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAF1951D65
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDAB1C237E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C31BD515;
	Wed, 14 Aug 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N8hkJupm"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8C1B4C5F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646205; cv=none; b=GVF8IBJS/SbC3MbX97gODVTgZlxFZiTh8+uJXEyqzHu/P9dy2GTmNFeueUKpbp2V8/RT8ZpGtUGJbFxKg/fdgfUrGoeecu4wi3K+1mpJ8DVLGjVxgojkPeiVYeEOFEuDuF2oy+4p57LRZAVweziDqvAzYZPv6HW9ty7f+GhLyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646205; c=relaxed/simple;
	bh=eoc3G8Sjl8nrWI19alC5LCkl998LvHQCHg6UVKRKeXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PXlNgH2H88v9uWLmrtX24dLRcGFS5xsrTxgm3tUidn5D5etskfgesaE9JtJHWkTv+8+AUMI/wQE6JRTO7Atk61wVwB5KvWtbGZpFZ0jVkMQlhzmMrd1Q8de7NB32POqArYmFiygrksKyTVBhRtSl1MDdohx+jSRnDFQREzAUr58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N8hkJupm; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABA961C0009;
	Wed, 14 Aug 2024 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723646194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gGkNGJMzZViUMrQFxHqtTa4PKI8hM4Nr9e+8KnU9Ck=;
	b=N8hkJupmXvzURO5c1YBNRAT+vUTz60dVFana44g3+2uN5ecaWhul6r9+/I0C6LD8tAIWKi
	WmUAanFFOznSw0c7bS0J+Po9lv+FZS85BNs+Nm1SLCcXnB88eP1INqsyR6RbQ9Yl2jDcs1
	QlW2rpJOEY7CajS8U4XqSJItLOOh04agxxPnBG0qa0VIAWetSDebR/xa9Si6NVMbmXRuC8
	bTQyOKnroPJtE05+flkPeQdAajDZKfv6wJJI/yAndvTQ17RF1M9xJowqOl+aP0NbupMq7Q
	CpCyLmIzKzrOckHXyhvdWy2kg3UpRwhPgvcJPzN695aaKhfUDb/D6AiNgQtZNA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 16:36:27 +0200
Subject: [PATCH RFC 05/15] drm/vkms: Move default_config creation to its
 own function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240814-google-remove-crtc-index-from-parameter-v1-5-6e179abf9fd4@bootlin.com>
References: <20240814-google-remove-crtc-index-from-parameter-v1-0-6e179abf9fd4@bootlin.com>
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-0-6e179abf9fd4@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2836;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=eoc3G8Sjl8nrWI19alC5LCkl998LvHQCHg6UVKRKeXA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvMDq8uWzI7dOx+vw/of7Iu7jWUg6t9LR0ieff
 obWSDZUJaCJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrzA6gAKCRAgrS7GWxAs
 4sjED/43s19ysPK+BTYVWwULWU0Bz3OWjgm/5+urxVXoSBaUZdT3lhF6S1tH1DkV0xe7ftKpJbO
 9t/XAXd62UAls5k4NTCWan5coh2tsV+MwiYmmzYVAGiBdzN9HUyRUlpyssjQM+iQKZlvStrSwRL
 E04uZRVDVIY8j801rG3KjKA+LSWUNbuPI0dXhXXCTneJjld3VSLexZVaq2+wqKlXc16jqUVADiI
 RkO+Yg9wn54Nzd0Q46TIglgIne/quzxGJ8LCp2KpVYKGxTuEsYa62ixaEQ1GhsE/U5KAL2a72Cz
 z5Ih8EzVnX2qEDKFyrzWjkOs4O6jFiiZcRjjVkZTGhM23fYjiInxnlHuAplf14WcxFNvPABI9OT
 YPjGPA4GmNCTLIiEEI8FD1VjIcDOFJJGpetVVVCaPZpvx8wuuQSsY1GlgHMAPAagWWDJZ0CVK+3
 83Qe9DRoJd5v5LQ8dO+RRlggLx8TDi4Si+9qqEAj39DD3645s9hrdRsNHIm77ZJgcZg7deXv+me
 ovJhTqUnnWZKxAsqPpJBQcOUg2nEFb7zqgY/X3J3xU9IU1w/Qq24emrqUffhg2Apv4C5muGqmCO
 /tVgsQckX/KuUkzacCYAsRoWuDM2K47E4c5vSl0Ug4wALL3mu2SGX/6ykF1j8m83SG0ys1dlEoM
 01wEvqHZRlXOdcQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Extract the initialization of the default configuration to a function.
Refactor, no functional changes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
[Changes: Cherry pick and solve conflicts]
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 16 ++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h |  9 +++++++++
 drivers/gpu/drm/vkms/vkms_drv.c    |  7 +------
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index d8348af9587e..27b49a2ad9c8 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -16,6 +16,22 @@ struct vkms_config *vkms_config_create(void)
 	return config;
 }
 
+struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable_overlay,
+					      bool enable_cursor)
+{
+	struct vkms_config *vkms_config = vkms_config_create();
+
+	if (IS_ERR(vkms_config))
+		return vkms_config;
+
+	vkms_config->writeback = enable_writeback;
+	vkms_config->overlay = enable_overlay;
+	vkms_config->cursor = enable_cursor;
+
+	return vkms_config;
+}
+
+
 void vkms_config_destroy(struct vkms_config *config)
 {
 	kfree(config);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 363f5bc8f64b..50c3b021a66b 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -43,4 +43,13 @@ void vkms_config_destroy(struct vkms_config *config);
 bool vkms_config_is_valid(struct vkms_config *vkms_config);
 
 
+/**
+ * vkms_config_alloc_default() - Allocate the configuration for the default device
+ * @enable_writeback: Enable the writeback connector for this configuration
+ * @enable_overlay: Create some overlay planes
+ * @enable_cursor:  Create a cursor plane
+ */
+struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable_overlay,
+					      bool enable_cursor);
+
 #endif //_VKMS_CONFIG_H
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index dbdb1f565a8f..af237daa3c5c 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -328,15 +328,10 @@ static int vkms_create(struct vkms_config *config)
 static int __init vkms_init(void)
 {
 	int ret;
-
-	default_config = vkms_config_create();
+	default_config = vkms_config_alloc_default(enable_writeback, enable_overlay, enable_cursor);
 	if (IS_ERR(default_config))
 		return PTR_ERR(default_config);
 
-	default_config->cursor = enable_cursor;
-	default_config->writeback = enable_writeback;
-	default_config->overlay = enable_overlay;
-
 	ret = vkms_create(default_config);
 	if (ret)
 		vkms_config_destroy(default_config);

-- 
2.44.2


