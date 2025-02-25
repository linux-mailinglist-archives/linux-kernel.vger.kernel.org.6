Return-Path: <linux-kernel+bounces-531934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD681A446C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198857AF17E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400CF19CC28;
	Tue, 25 Feb 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn8DvynC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C291C84BD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501870; cv=none; b=gosig6OWY8dgDyaQyTdvpCv+9MXBuG8Lm66VvbiAyYz1LGTaFPWd+Cs/OFVMhQgk0o5gPGO1jRumYejvQTTEaXy2iDi5FEhhVrFNpYdA7MZ7Sem9U5a0Oe7B6VC5iBo+EVN++EzskTth5p1bkBoAit58AhuurM+nINbnj9aPvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501870; c=relaxed/simple;
	bh=+MJogTu7tOkrTd6NsA3NR9fPOZkh5gM0yVERoNUn1Bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEtk6CUvHgzm3vuD6SVGJEH64qA0kg+ATpjeqqBmBflJjlKJAiKG0PkSfZ7xrAHJ3IwXELBR0cdI+v7JpoBPi0CLc+bdv8vQhnMCaLptBWFDyMg8hkQ8nn0M7btFqlxuhABt1njT0gpfQMJwsNYr1ZZLA3Mx6yGTsMp//1Wo5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rn8DvynC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8430C4CEEC;
	Tue, 25 Feb 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501870;
	bh=+MJogTu7tOkrTd6NsA3NR9fPOZkh5gM0yVERoNUn1Bw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rn8DvynCmkjScjkD2D0JlPtpW0M0oa+IGBRvuwIJN0MYo5Niz8enslJtxDQDqJl7U
	 J9I2+C+gwA4+3r6cYAmIEaM4l/ENZvZhqdxfph0CLCDjLQHDfNkMmaVCvnz+mQgFpg
	 mzRqrpQ5s02OBdUg7TJKXdcPLdS1Iwch9Bqbxn5lxlEodXg4bGuu+uHWcUp9tJ8bzb
	 hmFudCyIt9PMWHexfaEKDy3iG7mpB6CMej68hVqMdqgIa551BOwErWW/OqI5jRZGyU
	 0pzEiRiuszmHdCG6LrGALKwvxabO2uZ6z7BqZkSjZHr+KkJUkyWG9wBy05cf4Xz+J3
	 9CCnK3IPqVmTw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 25 Feb 2025 17:43:57 +0100
Subject: [PATCH v4 09/15] drm/bridge: ti-sn65dsi83: Switch to
 drm_bridge_reset_crtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-bridge-connector-v4-9-7ecb07b09cad@kernel.org>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
In-Reply-To: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+MJogTu7tOkrTd6NsA3NR9fPOZkh5gM0yVERoNUn1Bw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOl7P/stnRFmVDT/7JGXbityHidN3DazLf5P0aRamYnmu
 grbOG5+7ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATMUtibHh57u/FfzalK3zO
 71qsenvygR9v79wImvpkZpOqn8As0f9zix45vL7sMOf7gv+fqzYvddBjrHeK9Sr2u6HQvaJqg8c
 dN6ufsvMDk7vPLD+9d5ZR4g3fOdl9CvdtxI9KmjIc1Zv49XKNLgA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Now that we have a helper for bridge drivers to call to reset the output
pipeline, let's use it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 817ce33968d110799581b3d1f30df16c3ddf0f83..9aca91a4536ec5073c8424f10c092c19be957d99 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -369,11 +369,10 @@ static u8 sn65dsi83_get_dsi_div(struct sn65dsi83 *ctx)
 	return dsi_div - 1;
 }
 
 static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
 {
-	struct drm_device *dev = sn65dsi83->bridge.dev;
 	struct drm_modeset_acquire_ctx ctx;
 	int err;
 
 	/*
 	 * Reset active outputs of the related CRTC.
@@ -384,30 +383,25 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
 	 * bridge.
 	 *
 	 * Keep the lock during the whole operation to be atomic.
 	 */
 
-	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
-
-	if (!sn65dsi83->bridge.encoder->crtc) {
-		/*
-		 * No CRTC attached -> No CRTC active outputs to reset
-		 * This can happen when the SN65DSI83 is reset. Simply do
-		 * nothing without returning any errors.
-		 */
-		err = 0;
-		goto end;
-	}
+	drm_modeset_acquire_init(&ctx, 0);
 
 	dev_warn(sn65dsi83->dev, "reset the pipe\n");
 
-	err = drm_atomic_helper_reset_crtc(sn65dsi83->bridge.encoder->crtc, &ctx);
+retry:
+	err = drm_bridge_reset_crtc(&sn65dsi83->bridge, &ctx);
+	if (err == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry;
+	}
 
-end:
-	DRM_MODESET_LOCK_ALL_END(dev, ctx, err);
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 
-	return err;
+	return 0;
 }
 
 static void sn65dsi83_reset_work(struct work_struct *ws)
 {
 	struct sn65dsi83 *ctx = container_of(ws, struct sn65dsi83, reset_work);

-- 
2.48.1


