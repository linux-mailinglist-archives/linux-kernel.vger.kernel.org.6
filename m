Return-Path: <linux-kernel+bounces-404050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A31B9C3E88
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113AB1F22380
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26919E82A;
	Mon, 11 Nov 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LDGfpUG3"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052F19CC3C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328592; cv=none; b=FKL9y7kVNEJjvaaxzE1uUQrGAmkQIV7hoOk8vYRU4M8SXFl14ipI8Rf9rvvuGpHUuCeNtvLXeha10n7/mogbM1YkYXivEARiyzcYHZ1YyD/UPO7RKAkbw9OOQXZhRY/SOPfZhsUEfkAyrn3QDfAVTXB5xrRHCrcaAaKDXLtMdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328592; c=relaxed/simple;
	bh=H0MySrUxWDCqvEAcb0pedeQRSOE3Bds2iksJxEoUuwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9iFupOpd8V8vSo+LAwMY7YHxSdb6YK1UA4JG+Gqq3oEotBxzVw/3lDEHZsUsu/g85rTbubKkL1DS9h3jdadMYBAt0+kTlR3gRJf6Y3lQzNTtpybnJve/MelKqZVPPddlLTMql0pPwqpIyQf+Rzs9Tjxy8j7wLyVombPpPu5SBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LDGfpUG3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BBA01BF209;
	Mon, 11 Nov 2024 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731328589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qW3wdr4EeYIZ0MLaRPPuH3cK65j246cHF8/ZPxNc2Bo=;
	b=LDGfpUG3r6SAvyB0iHpIkXFrP9CQ12QOeFNpf5UcYXU+t6/9WL1alKBVgF+NqLVOzt5HkI
	RJGaFAVgeOIrLylJ7JwiznbRhkMNuvvocphw1ONk+1dThmEvpatSqBARiAb25/GwZ4a1GR
	YrfybiCo/WwijUlYAx1GtV9kqRV5SKTESGb8JvTzm0iKsz8DKnl6/1rfwc3+I+zI7XgXfl
	I7Qo4HPnnGUrvbtY96L33pXfpABVFDglcVRP4l1bm7I8061+PnNU4oo6E//UVFw9KhHZpN
	0PwWzNw0s3X0htqCFXO6GvAL7MY/qW08qiShxEX04p93lqO2wA0c1TyWBsKdkg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 11 Nov 2024 13:36:23 +0100
Subject: [PATCH v3 4/4] drm/connector: warn when cleaning up a refcounted
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-drm-small-improvements-v3-4-a9f576111b41@bootlin.com>
References: <20241111-drm-small-improvements-v3-0-a9f576111b41@bootlin.com>
In-Reply-To: <20241111-drm-small-improvements-v3-0-a9f576111b41@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

Calling drm_connector_cleanup() should only be done via the free_cb =>
.destroy path, which cleans up the struct drm_connector only when the
refcount drops to zero.

A cleanup done with a refcount higher than 0 can result from buggy code,
e.g. by doing cleanup directly in the drivers teardown code. Serious
trouble can happen if this happens, so warn about it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_connector.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index fc35f47e2849ed6786d6223ac9c69e1c359fc648..e0bf9c490af43055de4caaee1580a4befbd608c5 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -624,6 +624,12 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	struct drm_device *dev = connector->dev;
 	struct drm_display_mode *mode, *t;
 
+	/*
+	 * Cleanup must happen when the last ref is put, via the
+	 * drm_connector_free() callback.
+	 */
+	WARN_ON(drm_mode_object_read_refcount(&connector->base) != 0);
+
 	/* The connector should have been removed from userspace long before
 	 * it is finally destroyed.
 	 */

-- 
2.34.1


