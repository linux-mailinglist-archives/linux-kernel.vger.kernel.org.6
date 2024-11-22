Return-Path: <linux-kernel+bounces-418558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507D9D62F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E0AB25700
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7251E0DE5;
	Fri, 22 Nov 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nam5ZBlB"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166BE1DFD96
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296037; cv=none; b=ad9gBMwECa3ujhEbydjqBWUjARSb6M0XY+G0dTVBvEzsgNh9RgiQtWo7Dv+wNMcHEhfgnZQza3QgXwAYcKtm/f+3UmLtARt6FQp7VvrwQliNCTRo7YweLyWx0NsQIqaE4cjVDQ26NJIAlsPyX/LTQhJpFRQQQc8oBwYaN+5B2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296037; c=relaxed/simple;
	bh=4AJ4w6rM+OS5dAB1iXM+yakMJb728HKc9lH7IWGkbyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTzH9O+ZlCczexJhAARs6z39RRpEiJk2B1lHt92wrRFLIg1Aq4534E3saB1LWsOJI198ko4tA8Ip1gBOwOOXpZRYwTZ3fxWDJoRDTih5OGjw15G7GG0ofB5+RgLgwGrl5LvtwMIQ8WvqAB0N6ZKLckDc6GveQemeIj2nlNVV84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nam5ZBlB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D50771C0004;
	Fri, 22 Nov 2024 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732296033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OagiUe3HQkEQnTAKyPtfCFjvpKrwiG5lJesDAbGKips=;
	b=nam5ZBlBu9x6QJVWFD7pv/e3fDvcDmeSGjXbqup52uhxIvAvwtf7Adp7QaYLPhceBb3zyA
	In3rKezJKCf+K2CKHhDJLh/Ov7r8gttdJdou/1kuuH7FoQyTlCq+rxYheZI2AogqYH2Sya
	IuudRhhp8ggvfF3CEUWQN2aid9pJQhBO7hn/Rzlp433K/LGXUhL393CO9AcefGcphF5NmX
	T75AtI/IH7m6bXNf/nn+XzBfij0W5JBT8Rw095Mk3BA6OXUnABwscPBnlvtIeXF+xPKRnH
	ePJvcTT15Xg4SOS6DoZudMrQbmVgQeo+/a/5O3KNg5MpoDrjd5rWZgRv6ROfxg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:20:18 +0100
Subject: [PATCH RFC v2 14/18] drm/vkms: Introduce config for connector type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-remove-crtc-index-from-parameter-v2-14-81540742535a@bootlin.com>
References: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com>
In-Reply-To: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com>
To: =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: arthurgrillo@riseup.net, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=4AJ4w6rM+OS5dAB1iXM+yakMJb728HKc9lH7IWGkbyM=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQL1QrUbvw2eJYu9SVKJZjEJyrfnmhHUtfq/Ni
 UVC+DS86YSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0C9UAAKCRAgrS7GWxAs
 4ow0D/9PQENsHV2apPCplfO5JJtA5o8LYAwa2uy7sRHYkDF+uWDvsEsthJOzq3/r89OIqsYxw5m
 jPzVfuNZNc/K7KQFptV/XWaax7EOtIkO+WNxFdcyNZpjY4aDl6i0jLtPnYLJNwmpZBolGkewEy4
 r4dHuVSaGVxyLKhxn4p4oQZy9h3bIzXkQ3Jjqz2hzSJ7vsPTHdSnJElkM69i+3YniCFNX6geAe2
 TBh9QJ2+ZLfoAtK0PnisvjtXWW6Hc2hyaoF/A3KrjpQJZt3lZy2I6Zf+JuiaG/MsX1op+EOF5Va
 5DWn5f4+iRAZRMHs6HVs3Zx7DrG84qYwOCQD9qTUaLyxoRRvVCnxnDDwFMKZUGUsgTu4NaoBte8
 HnYvCSCoTpF9ktjgTJaNS7oWR5IvSLG/ew8Lu3qvWXriIY4lBD1oS0PqfMJJyKpoxwYN40uQQQa
 y7SBka1TZH2rIaf6pXp9I4dcLKaM8DBzGO8tJ/iwDRt+s/CIJWm0U4BhfShJHU7okgOjwXUrAmB
 uZxpQGIXgh3B8459rAOzQoq1JiJoXUqBZma1/tyZb5EGzxMTZINofd+A6fGtdokCgY0tTTQw9WE
 Ynv4R5l4ILrB6i+nx9ghc0yl4iWJWI3v+fbLfpTjViY2paRfCvoTL+4OzyDrh87Ekud1PmXgy5H
 YAAWU+zEkyb25Zw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

To allow emulation of different kind of connector, make the connector type
configurable.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 1 +
 drivers/gpu/drm/vkms/vkms_config.h | 1 +
 drivers/gpu/drm/vkms/vkms_output.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 998bdc50405116507e9cefd72a7b472c4c17e36d..c3334d3d808e5fc8cd6d855e9e1395f94f157ffb 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -151,6 +151,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *v
 
 	list_add(&vkms_config_connector->link, &vkms_config->connectors);
 	xa_init_flags(&vkms_config_connector->possible_encoders, XA_FLAGS_ALLOC);
+	vkms_config_connector->type = DRM_MODE_CONNECTOR_VIRTUAL;
 
 	return vkms_config_connector;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index d64024e6682d217f7d9265f436ff2e6135860260..c44bcafc3b34e1997f29631fda42af05e1c0c2ba 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -108,6 +108,7 @@ struct vkms_config_connector {
 	struct list_head link;
 
 	struct xarray possible_encoders;
+	int type;
 
 	/* Internal usage */
 	struct drm_connector *connector;
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 90c0fa8eba53bef4ca80c374b40d69b0de155144..aea6366fd9a662483ed5a255d02d5025a30297f7 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -97,7 +97,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		if (!config_connector->connector)
 			return -ENOMEM;
 		ret = drmm_connector_init(&vkmsdev->drm, config_connector->connector,
-					  &vkms_connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL, NULL);
+					  &vkms_connector_funcs, config_connector->type, NULL);
 		if (ret)
 			return ret;
 		drm_connector_helper_add(config_connector->connector, &vkms_conn_helper_funcs);

-- 
2.47.0


