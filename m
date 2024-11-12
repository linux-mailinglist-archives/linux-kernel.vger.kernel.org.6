Return-Path: <linux-kernel+bounces-406743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE9D9C6321
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D17283B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED90E21A4B4;
	Tue, 12 Nov 2024 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cqVJz9Sp"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B92215018;
	Tue, 12 Nov 2024 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731445985; cv=none; b=iufw+OHWQ+0IJlsdAaQH60dxxzZeawciYVSm4FnF7Dt5qOJf4lmFC6GHlqPcUAbEiNm+sWC0Bgkx/vpQs1ULoNL3ZPoHpe9f6riLfgJNk+lhnNlbeJYlyJHt3l30k12BoNzlVlcXmRML7LanpTAnW0T+4+Df2s0E2eFXhYXAnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731445985; c=relaxed/simple;
	bh=CICNCBgnyRhQK5xuFr8zp2dBym62Bvb2VTXd/tkk8CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkleim5ote4s1h7uCtpuWtr9CurEejHpx45+w3T9lGKElzm8JW3782ovJDuFVQiTW+UQ4tnHHwjhn+dTT/tMrPJeEoSGv/g4v9/nRWPOHHS7tGLxMjH9GyCFnn4hGjOKisPiZErH9nqHQFtrK6dNXQ8QsYMv48s5Vt3Tn+YFot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cqVJz9Sp; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id AyButuY9CdVBsAyButCxb1; Tue, 12 Nov 2024 22:12:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731445974;
	bh=fvwwuU9U+8o+dVu3obevxV4lHk/tNdRynX56ecSAero=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cqVJz9Sp9DGwouxtEcsJJTmeeeT19GrxbYPm7ogocl53riTJ0t3ojDFj3SXfH0gOD
	 tis/wel3G91VmJLN/hiQDkDCiED65Z52x5HaTM2sq+diQ2PPANzp8wHywrdXmiPYTT
	 FvPNkSRURwePIPz7KzvFXHi5yZ0WoJNHaj1KPfANzne77w5MJwlpsrmkQv+PbLEoHK
	 6zYxf7IciIRQtO0Zc2GGUfPk5dMQOweRH7xyjqS2R+j+PMRaFaZiQ3E0G/lTa+jHBb
	 shmQ8FMbTjb5GDgCJedJsg2MuXERL2MivVugFhYJkXRxBETSVC24lIfnlFSA1alzQv
	 AazrXt6mmvgvw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Nov 2024 22:12:54 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: Constify struct i2c_device_id
Date: Tue, 12 Nov 2024 22:12:25 +0100
Message-ID: <bdba1f49b4b48e22628482b49ce81f8e1f0d97b1.1731445901.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct i2c_device_id' is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  15566	    987	     32	  16585	   40c9	drivers/gpu/drm/bridge/chipone-icn6211.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  15630	    923	     32	  16585	   40c9	drivers/gpu/drm/bridge/chipone-icn6211.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/gpu/drm/bridge/chipone-icn6211.c   | 2 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c    | 2 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c    | 2 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c      | 2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c      | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 9eecac457dcf..d47703559b0d 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -785,7 +785,7 @@ static struct mipi_dsi_driver chipone_dsi_driver = {
 	},
 };
 
-static struct i2c_device_id chipone_i2c_id[] = {
+static const struct i2c_device_id chipone_i2c_id[] = {
 	{ "chipone,icn6211" },
 	{},
 };
diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index c8881796fba4..999ddebb832d 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -773,7 +773,7 @@ static void lt9211_remove(struct i2c_client *client)
 	drm_bridge_remove(&ctx->bridge);
 }
 
-static struct i2c_device_id lt9211_id[] = {
+static const struct i2c_device_id lt9211_id[] = {
 	{ "lontium,lt9211" },
 	{},
 };
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 1b31fdebe164..8f25b338a8d8 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1235,7 +1235,7 @@ static void lt9611_remove(struct i2c_client *client)
 	of_node_put(lt9611->dsi0_node);
 }
 
-static struct i2c_device_id lt9611_id[] = {
+static const struct i2c_device_id lt9611_id[] = {
 	{ "lontium,lt9611", 0 },
 	{}
 };
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 4d1d40e1f1b4..f89af8203c9d 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -913,7 +913,7 @@ static void lt9611uxc_remove(struct i2c_client *client)
 	of_node_put(lt9611uxc->dsi0_node);
 }
 
-static struct i2c_device_id lt9611uxc_id[] = {
+static const struct i2c_device_id lt9611uxc_id[] = {
 	{ "lontium,lt9611uxc", 0 },
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 57a7ed13f996..00d3bfa645f5 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -732,7 +732,7 @@ static void sn65dsi83_remove(struct i2c_client *client)
 	drm_bridge_remove(&ctx->bridge);
 }
 
-static struct i2c_device_id sn65dsi83_id[] = {
+static const struct i2c_device_id sn65dsi83_id[] = {
 	{ "ti,sn65dsi83", MODEL_SN65DSI83 },
 	{ "ti,sn65dsi84", MODEL_SN65DSI84 },
 	{},
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 9e31f750fd88..ce4c026b064f 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1970,7 +1970,7 @@ static int ti_sn65dsi86_probe(struct i2c_client *client)
 	return ti_sn65dsi86_add_aux_device(pdata, &pdata->aux_aux, "aux");
 }
 
-static struct i2c_device_id ti_sn65dsi86_id[] = {
+static const struct i2c_device_id ti_sn65dsi86_id[] = {
 	{ "ti,sn65dsi86", 0},
 	{},
 };
-- 
2.47.0


