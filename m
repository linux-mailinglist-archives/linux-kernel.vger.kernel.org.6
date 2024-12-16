Return-Path: <linux-kernel+bounces-447712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7099F364E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D332918805A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22922063CB;
	Mon, 16 Dec 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eyDGFgHV"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8D202C50
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367276; cv=none; b=NQR9PocSG4X/HknBYG81wg996RVuNWklwf2dKRKiiEuPjmdanbbOEOf5q0hwD4Mve4E7F0178/q2GU+Xx+Od+0Y+8tlD6f3KoKFlSO8uqMWg5ImO9xuYwq+468p4VmvSu/xMRZbpvqf7W0sWi8XYSbX2m9sRojnyT2JIU9Hbqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367276; c=relaxed/simple;
	bh=H0MySrUxWDCqvEAcb0pedeQRSOE3Bds2iksJxEoUuwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9p7gk9mYvSrFQQR88WbRGPDDj3haw3dhJnwxRErp9bhv/trcIhMf9Y4fHlAoiB7XGQ3u2U7mucQVbdd11HOMpzwFdh3coF+6kxFclyFhuWrtIErY5POq120qNrTYZaC55A7D/4IiiKZgCGFtx0o7BbdLwL1NmUvnER9b3A6lw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eyDGFgHV; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC324E000F;
	Mon, 16 Dec 2024 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734367272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qW3wdr4EeYIZ0MLaRPPuH3cK65j246cHF8/ZPxNc2Bo=;
	b=eyDGFgHVeEDhExDDMXCSOSgsB8v/VSm2hPy3ubebFzBaHgkY9OCIVc9nnBg43U2bRdhdvW
	ss9r9o+GQbM6f1QKp6acKn032ygY1oWgbk519MEvab2avDyHYqC3LlfOiM2ClxaZiUdHXf
	tZhTbUkPSbyf80lmr4Jd9HImCi3J6kdtpv/tEfVEOHd1mCFH/9Hcu3K3axOY2bSceJ9ujy
	OBFut0yli1R9jA6DDRwLg76sQpgCE7fPL7Zclp3m83/ZQcvhntvDhXmrVxrsA7gkqD/B+Z
	jGkIKakyPXSRc80NEp8IcCix2arnsXdmcdn0p3jEPCRkGE9aJxtSdb6X+KkTjA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 16 Dec 2024 17:40:51 +0100
Subject: [PATCH RESEND v3 4/4] drm/connector: warn when cleaning up a
 refcounted connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-drm-small-improvements-v3-4-78bbc95ac776@bootlin.com>
References: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
In-Reply-To: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
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


