Return-Path: <linux-kernel+bounces-286651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C80951D64
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455121C256D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539551BD01A;
	Wed, 14 Aug 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nU09Wv9Z"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9FE1B4C5E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646203; cv=none; b=Z3QlCwA1/LkgLtRqlx2nchy14/3H63lTolZqZyIB5bUQncTO59TWRho6D5/mtjQj4PEcdv48JdPuar+lUokjDZLghvjTfq3B1fK27/IyJZc076vHmEqtzMYGQvYJ6l4Cdunqlj6VGWzT9SS5GZLDGsAFjXNOaYeTe4fA3LJRV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646203; c=relaxed/simple;
	bh=6odxYTXA8ortXBUomxRjgorI0mo39N/O6CGAuFuXVcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGdd6tyx2zXVZa+MxYDgdvqNNH3TmhL0Ma8p7pHYvS+5yHtt5ibjzVQJT4HHTIvEWcvEwxLZP1OKMiCQHoWDGEbnLFsJ2WW5BVaSwxQ9YYGHjXvHqW8Lu3N57YBTZBrgm+ZtA0fYKsmLx8co3Czvi8TzVUwD8VK23mfGzwf+FMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nU09Wv9Z; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 853BB1C0014;
	Wed, 14 Aug 2024 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723646200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mejIIXPURaek6mjtWd5mqBmpe3HOEF3GsOx95SQDqq4=;
	b=nU09Wv9Zj0DTXtTaKtchzwscuZiS12inNG2Jw/2EjbLRSnYDxmMJuhvZ69PZXxDWgTZl80
	oC+o4sENhLpu3pgb5ErwlMD5QYSCfE8YjQM4B4ia0PiTSnOz09nVBm7VFn2mqjE0aEzAO5
	zaFwULtCAVdfTU8qZM7+kFBhckWjZBAAw4AfmAxfJK3/YARrZUVCHyN2ahmPAF2CyB18I1
	LJqUfUugFkkNpzPNLjOx1JarMnPSZMYV4ilUFQ0LKFHq20DBW5p4oYBq1mlwWAPH1zqTo0
	jXsHLxDGb3kpCY4KkCYfRpFCKjEy09+M6z1JPjONbyyvleWJXPNlmXpo9rMOng==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 16:36:33 +0200
Subject: [PATCH RFC 11/15] drm: writeback: Add drm_writeback_connector
 cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-remove-crtc-index-from-parameter-v1-11-6e179abf9fd4@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2853;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=6odxYTXA8ortXBUomxRjgorI0mo39N/O6CGAuFuXVcs=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvMDrBA7inbkZtwi0MgSJNciMd8SobTqox5trU
 XlkRcpuF1SJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrzA6wAKCRAgrS7GWxAs
 4lhFEACNrxekua9mWX20TEWhv9sE/GhKeSR4A5A6U8B8kWrddIESqC0zODhuxosYvKduF51Vh2m
 bAn67DXGORWvAtTTziGKbBmRz0pDtnPsxBeIR9ntA63xQQLVwT1n6chdF0L2vjy19tVSfZY0aYn
 aAfiBxqDwRJbi/blbhg4Q3g8wxYtz1Bzk0gN2JqFWxb8cAXki2/k6mdSKW0+pZSxIhWksGT0kjd
 Lag4w9yl+/iuHh93rcoWSesYP3FNknZ+KQgXuIZfGZ5/VLCyU2IM+VdqKb85FaTKJbYNBg8u6I0
 OzZlWcjPwnmGd1/pBxXZh7inWMv1+FkysIB9oZTdvfxlg4KCxmIfS19t+0r84ScUxYWyHuvyoRe
 lk4szoFyE7syRWqscQbhRKUMu00Y2vAc/uBcEk582giDv0CgV6jkbwaIDsXh4KJ2GbQaaYQh4sP
 pAM4RbLJZljJRQoa/zRurzXI6/flDTQ+rXzHg6i+FveoXLe+3EfwKzrEpqlU10O+614cUkHuBVx
 bTNsuOPeK9HmERQaH9HUCAPkaUlsjCX62h9u3KViMRy7APkVgbOA3H1BqGi3hbaD55rv9SzfcjM
 Rn49P7munhIk7iW6RANw6WGSFGhT8v9Jb9wXGoJ69/1g3Re5eyPIoAGhLayjrIeapWLtskREFFj
 fbJN+lwKox6s1ag==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Currently drm_writeback_connector are created by
drm_writeback_connector_init or drm_writeback_connector_init_with_encoder.
Both of the function uses drm_connector_init and drm_encoder_init, but
there is no way to properly clean those structure from outside.

This patch introduce the new function drm_writeback_connector_cleanup to
allow a proper cleanup.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_writeback.c | 10 ++++++++++
 include/drm/drm_writeback.h     | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index a031c335bdb9..505a4eb40f93 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -184,6 +184,7 @@ int drm_writeback_connector_init(struct drm_device *dev,
 	drm_encoder_helper_add(&wb_connector->encoder, enc_helper_funcs);
 
 	wb_connector->encoder.possible_crtcs = possible_crtcs;
+	wb_connector->managed_encoder = true;
 
 	ret = drm_encoder_init(dev, &wb_connector->encoder,
 			       &drm_writeback_encoder_funcs,
@@ -290,6 +291,15 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
 
+void drm_writeback_connector_cleanup(struct drm_writeback_connector *wb_connector)
+{
+	drm_connector_cleanup(&wb_connector->base);
+	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
+	if (wb_connector->managed_encoder)
+		drm_encoder_cleanup(&wb_connector->encoder);
+}
+EXPORT_SYMBOL(drm_writeback_connector_cleanup);
+
 int drm_writeback_set_fb(struct drm_connector_state *conn_state,
 			 struct drm_framebuffer *fb)
 {
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 17e576c80169..e651c0c0c84c 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -35,6 +35,15 @@ struct drm_writeback_connector {
 	 */
 	struct drm_encoder encoder;
 
+	/**
+	 * @managed_encoder: Sets to true if @encoder was created by drm_writeback_connector_init()
+	 *
+	 * If the user used drm_writeback_connector_init_with_encoder() to create the connector,
+	 * @encoder is not valid and not managed by drm_writeback_connector. This fields allows
+	 * the drm_writeback_cleanup() function to properly destroy the encoder if needed.
+	 */
+	bool managed_encoder;
+
 	/**
 	 * @pixel_formats_blob_ptr:
 	 *
@@ -161,6 +170,8 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 				const struct drm_connector_funcs *con_funcs, const u32 *formats,
 				int n_formats);
 
+void drm_writeback_connector_cleanup(struct drm_writeback_connector *wb_connector);
+
 int drm_writeback_set_fb(struct drm_connector_state *conn_state,
 			 struct drm_framebuffer *fb);
 

-- 
2.44.2


