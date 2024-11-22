Return-Path: <linux-kernel+bounces-418600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0FC9D6365
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62044B24823
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A21E049F;
	Fri, 22 Nov 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E8437X3l"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662611DFE10
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297151; cv=none; b=OV0nBV7YzVkKA6kmMn4YiaCOIUCV1dFuCGGuH5llDNH0QrZF6EtQjdpUD0aokMk0sfhmOhRcAvu2fUJ2ErUDZNA/FOWGSZ3M1M1VhlARagTerwlJoZrctOw6ovdc7TivtWn5rMlRUCJFtW5zOkD/MjmUDfNDobYjas5sowrFqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297151; c=relaxed/simple;
	bh=nyn61gEI5cxIOk33UuCcsn0hzoPdV29oV/sQS13cyvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gx+HoxzM8aTaZm8W4xnsBUyjxDKge//kyeRmHXwZmmPJDxDUYx60NNRWhlYSPQKZhKvZ+thNlA19FaZd+VJ6LiPVJZXbELj+rgnuGX46EnaJyX+t/pNbIf72zQu1u/dR7bUcPu2APszs7nWoZ30S8K/d+9BcDZ6ILfo1BG4EYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E8437X3l; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C40CC0005;
	Fri, 22 Nov 2024 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732297148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K62+SyNAzYsmI5c6NH75SjeRnt+jsy02BCREo3E62AI=;
	b=E8437X3la9DzCtXncDoexxcOl8LIzcMhtBe76IrN7n9mIaF6hCIoYqX4m1iDUtSxJGTpuP
	UWzPzD3aqeaDtgLeZX31zK2XJfLSE1Q8ALG2oul00+ZVZVPZx5A7pbz9kCazS1zWCK2p09
	yCbjEOylzLZGLHNOBVLBOEHBBkFjm/s37m76Y+C+RqqJA/20Z9A8clOZU3oPiNsr39m2zS
	d8YIXWNhc71p2xVRClXAoL5LIVZJEoyO+EKjJ+SxCQXhpedyoFjdD3RXmgHFEhrqvXH7O5
	mz+WqruK0a5xyxuCR4LlQR2B01DTXhi42MmD1cWfbtItQAQqwrxOd0wJ3b7SjA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:38:37 +0100
Subject: [PATCH RFC v2 11/16] drm/vkms: Introduce configfs for plane format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-config-fs-v2-11-4b7e6f183320@bootlin.com>
References: <20241122-google-config-fs-v2-0-4b7e6f183320@bootlin.com>
In-Reply-To: <20241122-google-config-fs-v2-0-4b7e6f183320@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: jose.exposito89@gmail.com, dri-devel@lists.freedesktop.org, 
 arthurgrillo@riseup.net, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3475;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=nyn61gEI5cxIOk33UuCcsn0hzoPdV29oV/sQS13cyvI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQMGs9X5jLX7eybIjcC7XVZ18awx4EhJYJMnWY
 6PdjgkwcQ6JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0DBrAAKCRAgrS7GWxAs
 4hbkD/0U2jCG6Ed34iwiN4ftzEyVwtGeWnJQmV0/BDVHJn3DI3puBiTg6UgxBCJ2lg77X42jQrQ
 GAA8Wlx86qg++zbemn9ADIWJy5zQWF0ZmPlHD+OUU4J6zcBnpQiHL95MTw4AsH4UoC4+kfd+5NJ
 OlhgARcvWzDnrARtwWmX/jclGUe6mJcUzb1ORToQ53bdjD0jnT0rXTxtT8kH0/7eefLY/7ABTqa
 n3YXrf3jxjLGGkMXYe5X7RxZQHj+a9iATWRtzaSsb9lgbnz59P2MizS0nAHY7iNXV8XWxzqJ/X7
 O/cGMrS7ur9uHy8rOkRVBJSdbpE/h0Fy167V83kyaExWQ7h2I0cMlnBWabmj8LQxRuAHnHGkQzB
 wF+m1DBfvOPWTtRXcYBYBxdsvEK0+uV9b1jrb15t+1CYo8Ncvnf84wzIuajc/T9l1NoDi0oBzwI
 QmwXxTxypKmouZnxkwSvS0c93AOqR+W2yXYk7sbAHPRYSYQxIDy78k5Ah/LMP1ekFwYfvksXZMZ
 dyv4h/KNv83bOKWT18wTCUTWQWGJ/8ODOeAXJwRAptc43pSPsJ83O7f6KfkKtQyjDRVxmlAGnKI
 X9LTicWpKeiQFIazCBsHgeLMq9lM+qrpniWeMbX0D9JmCkCTEDf6d9LGle5ZrtlDO4pXn9emC7e
 BbRC6Uj+4H84CIQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index ef9a00c41b7b030d0d60ffe078809f9799539f40..a1ddf25ab6f882ae1857bc82fb4b4a425b6d287d 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -355,6 +355,79 @@ static ssize_t plane_default_color_encoding_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_formats_show(struct config_item *item, char *page)
+{
+	struct vkms_config_plane *plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+
+	page[0] = '\0';
+
+	scoped_guard(mutex, &vkms_configfs->lock)
+	{
+		for (int i = 0; i < plane->supported_formats_count; i++) {
+			char tmp[6] = { 0 };
+			const ssize_t ret = snprintf(tmp, ARRAY_SIZE(tmp), "%.*s\n",
+					       (int)sizeof(plane->supported_formats[i]),
+					       (char *)&plane->supported_formats[i]);
+			if (ret < 0)
+				return ret;
+			/* Limitation of ConfigFS attributes, an attribute can't be bigger than PAGE_SIZE */
+			if (ret + strlen(page) > PAGE_SIZE - 1)
+				return -ENOMEM;
+			strncat(page, tmp, ARRAY_SIZE(tmp));
+		}
+	}
+
+	return strlen(page);
+}
+
+static ssize_t plane_supported_formats_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct vkms_config_plane *plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+	int ret = 0;
+	int ptr = 0;
+
+	scoped_guard(mutex, &vkms_configfs->lock)
+	{
+		while (ptr < count) {
+			if (page[ptr] == '+') {
+				char tmp[4] = { ' ', ' ', ' ', ' ' };
+
+				memcpy(tmp, &page[ptr + 1], min(sizeof(tmp), count - (ptr + 1)));
+				if (tmp[0] == '*') {
+					ret = vkms_config_plane_add_all_formats(plane);
+					if (ret)
+						return ret;
+					ptr += 1;
+				} else {
+					ret = vkms_config_plane_add_format(plane, *(int *)tmp);
+					if (ret)
+						return ret;
+					ptr += 4;
+				}
+			} else if (page[ptr] == '-') {
+				char tmp[4] = { ' ', ' ', ' ', ' ' };
+
+				memcpy(tmp, &page[ptr + 1], min(sizeof(tmp), count - (ptr + 1)));
+				if (tmp[0] == '*') {
+					vkms_config_plane_remove_all_formats(plane);
+					ptr += 1;
+				} else {
+					vkms_config_plane_remove_format(plane, *(int *)tmp);
+
+					ptr += 4;
+				}
+			}
+			/* Skip anything that is not a + or a - */
+			ptr += 1;
+		}
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
@@ -362,6 +435,7 @@ CONFIGFS_ATTR(plane_, color_range);
 CONFIGFS_ATTR(plane_, default_color_range);
 CONFIGFS_ATTR(plane_, supported_color_encoding);
 CONFIGFS_ATTR(plane_, default_color_encoding);
+CONFIGFS_ATTR(plane_, supported_formats);
 
 static struct configfs_attribute *plane_attrs[] = {
 	&plane_attr_type,
@@ -371,6 +445,7 @@ static struct configfs_attribute *plane_attrs[] = {
 	&plane_attr_default_color_range,
 	&plane_attr_supported_color_encoding,
 	&plane_attr_default_color_encoding,
+	&plane_attr_supported_formats,
 	NULL,
 };
 

-- 
2.47.0


