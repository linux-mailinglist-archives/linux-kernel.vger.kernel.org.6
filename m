Return-Path: <linux-kernel+bounces-398058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02519BE4C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A6F1F26B99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C81DFDA1;
	Wed,  6 Nov 2024 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kaUmYTxC"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6F1DED76
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890129; cv=none; b=nEJ1t5Y39SvEjN2X2O0sBYQ+m+dwNUTqMbbqPhGQCZSRoa4P/E/BJ2ItXQ69O23midaNI+76O/86qkDo6t6VTAbD/OfPjpT6ojYbDEhsk0Fj/t7aK66w6MH+dLDBuU67sU9eP93o9CzOVTyeHyfGnPS4LwHhvI71XMSmVaR9HiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890129; c=relaxed/simple;
	bh=pudTfM36kFQMq2RWVOPHfAT6VK0+RurGw7EGVRZsQII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mm+FQ/e5ToXtbMl23BnifW3mUNfJCepEj9f38LFAxEDzKfVlsLsfhrUf+uE181AJQxcad7fQNTJjz18W3ceKk/h/cgVPkJnfcknoSXHfl6buoYq4BP9NtjdvsZ3YipQHwgk4WyfBHInWcv9+ic88I1fYn5PRXMzsmOcdiNotX0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kaUmYTxC; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DAC160003;
	Wed,  6 Nov 2024 10:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730890125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWsYONnEgvEeIa9tipWPBTuf84MWmW0KPLgHIvkZDok=;
	b=kaUmYTxCnAY2Yaz8+lF+h/n9rzbIibLHfOtbjYi0RxCWz7kJHEgqIzosrye/v3wAiLSPLW
	gO9t/5T1tl6xNTSs2mPVzehbbookhUgglKSomQsH7cMyi+oTmW7jhhYhmKo8xYKRGsT7vQ
	lM81A82fyV1da9oFru9YDUO9/fIIOVB1h++XisPbFFxHmc9O7c78qxbpzwbYSCYbVD2/kV
	3yUPLJw07eInHnS1s2gLJ8F2QK8kmW01qB5Gwy/2GOIb6wVy9EB0EzHSXbB4/F5kwkSvTO
	rAdLAmsK2Beluk6zyorHqG8v54mwsNjHmEUwfihpS+VpYxgbzWfK5mVI2gC+Tg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 06 Nov 2024 11:48:27 +0100
Subject: [PATCH v2 4/4] drm/connector: warn when cleaning up a refcounted
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-drm-small-improvements-v2-4-f6e2aef86719@bootlin.com>
References: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
In-Reply-To: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
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


