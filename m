Return-Path: <linux-kernel+bounces-418603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7079D6368
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F86285510
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA431E1337;
	Fri, 22 Nov 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Usyx0A4v"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919651E04AF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297154; cv=none; b=FFjSzkA88LtZZQu2XLxOJsc8V51pXTKU9IZfGg2o6POtvBqi15XljSCu/19NU/vDL+eBp7xx56fez+pkr9pszqxrJshKjK2LOVNuB1DCqGAoSjMT+hEWX2tT5QdMW0TSq3PFhD/CPGUNWCzVmYNzHi/KluwYzb9y0XqX9SxJcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297154; c=relaxed/simple;
	bh=Ak6KiDGMT+uVa/iGS4P6tHXkjicg6KDsPjq2kkKpBa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbZhOF6sX9JphHmkVDmcw04DdO3fszLfVQBCCIqNO3rvGTLG+O8jztDA7rsf2Yuv/66RlJ30vvudPxZEN64sQ8iz0247fnAi3DsmD2PiDHcr4YYSR56cSTpmQMKgJx6b/NhX8KggXnfH75IYp4R0fRewinVFByOBjhEAN3btHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Usyx0A4v; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31F7EC000D;
	Fri, 22 Nov 2024 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732297151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMqLuA+rZ/4gFP2XNx/8C49wN8GArbQTKi0IJlMNfEQ=;
	b=Usyx0A4v8yBH7Rbu7wIt4EYY8McdMpyBFm7dQKAY2xzEgdv0I0sxEd9vk1e6TXfwJ5UhjG
	Htsdhm7lRiuml5K6mL/ScS/PNiG4FbUXxb9jDQ7262Wj5IdgkPDxwrhT88HVx5gsJl1k57
	hAAZxlV3SWLgVhl49d9pqhEEBrmZs0bQ/H6R14eg5Vailmc0Oe0wumk95g9FaoYlrbs/hP
	hjZGctOPeUI/e+f1mTe4/v98uvm8GhOWKCnSa1xbb/LQZV74+nuUHG2cdtNMPceitLmlxt
	ilBlMAXVKJvMyplYMH1GNecaoIaJ9KXX//vng7HOzWOlVm5exz3M9R0PpumJxg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:38:40 +0100
Subject: [PATCH RFC v2 14/16] drm/vkms: Introduce configfs for connector id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-config-fs-v2-14-4b7e6f183320@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Ak6KiDGMT+uVa/iGS4P6tHXkjicg6KDsPjq2kkKpBa4=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQMGt7sY+29SrtKAQmgKn/H1r5ehthOdZWj8NG
 NQQZHYPI9yJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0DBrQAKCRAgrS7GWxAs
 4jmoD/0Y8xtjPKgTjQtAJGwbywUgY8/P9a7KgjoPkcBXNEl7cg8stwaKxBn5cBjGoMB/W0Ddxo+
 LWjgOMpwhKIp2H2hj+gGiCPPm+qP0HKAqefqe4CuepOC+LwSrLaSKPzJLT2f295clqyjIZlWvVK
 949y9TlvfBkuQVV45X07y2Z+cKqNj6O9JqLsgIbWIpFkXnJi8CRfOgXOARftCmWKWovGm/7Ji+s
 KnN6QaZj5P0E7huvkuWw/8+09RAfwIKPIJ+Zi8HKxU0kkpRqcVKuDnEsCmvGC9AC6bWV3mX5mEJ
 wsbtDlK5fAHxoXBxC6nKgkGQf/d0qqUi+cssWoVklvqcX7NHUzH9v2am7Zw2DkL7c8Gbp2yoCe/
 c1v1WnPcpRQfaXQUuOAY3C0CGixMYx5KE2RIPnKVwko228c5qcMdjsa7Ey9Bf2ZlWlZtBTjtcMZ
 3i076hZCyoIuPCcZ3se6P9MTzbcvr8kDRVpVluDr+evzJUBVMlFTqVwgszAci1NohmOEQKKra7u
 LiqmfecVyS1co65QnV+gh+SV/2y3RPr8j7KL5elyExeVy8ThjVBQxtyGI/vXx3QUDCmqtVcJnFt
 wP5koB+RI+WVNrfPrHfiJ0mfslnc88b5MEdLjLAoAaPapCxFhcQDoAzoV4cAlSvAkj5EUUD/NcI
 1VPRXS9pGLom1kw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 6412a8b7b1066f2d3dca1135ebd7fbaed84027b6..45738707f1f6c11b561e695fe0aef245d946b418 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1024,12 +1024,31 @@ static ssize_t connector_status_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t connector_id_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_device *vkms_configfs =
+		connector_child_item_to_vkms_configfs_device(item);
+	struct vkms_config_connector *connector;
+
+	scoped_guard(mutex, &vkms_configfs->lock)
+	{
+		connector = connector_item_to_vkms_configfs_connector(item)->vkms_config_connector;
+		if (vkms_configfs->enabled)
+			return sprintf(page, "%d\n",
+				       connector->connector->base.id);
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
 CONFIGFS_ATTR(connector_, type);
 CONFIGFS_ATTR(connector_, status);
+CONFIGFS_ATTR_RO(connector_, id);
 
 static struct configfs_attribute *connector_attrs[] = {
 	&connector_attr_type,
 	&connector_attr_status,
+	&connector_attr_id,
 	NULL,
 };
 

-- 
2.47.0


