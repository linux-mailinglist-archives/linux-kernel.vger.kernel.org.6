Return-Path: <linux-kernel+bounces-201592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9A88FC08A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E14281811
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE9E1AAA5;
	Wed,  5 Jun 2024 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eSHwlSBk"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215CC17BA9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547071; cv=none; b=hqXwtmlN+UHkogmGe8/bkGf5aEYqz/NLq9jqMwkqsV/9i2Pyr5f7J2e2E8cjENS3VFWKiqHPNqPRR7nL8NIAM/IdlMN9BnqoXnh61JNB7irdspMU4TYO3vG8ddfKy5TxQIQxOoe68PvcqqCj7Ar1C7OwVhyam3cBoGO9tEe0rPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547071; c=relaxed/simple;
	bh=+m5D1UTv109cZhAnIeiR1AabRm2ywn8I3ErzPXOwiOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwR+yHNOQVMWxOqMmcCJbLzmBG/4LNU+geNpvX5LT7HIBmy4EbMm+f18/cPYCfj3pdxfx01v0gg5hwHRtsb95Zoxw8dlEgC78PE9tkTt1lw1CfV6SyymwhfPRlRvXyuvtM18+JbF5E58vW2+ZAiV7kdjXkHoH+1dmjSgGCic5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eSHwlSBk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4c7b022f8so55547715ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547069; x=1718151869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI+lc0Adrp0Lkxnnuy2KCG5ns+CVmv57DIBitlySUAk=;
        b=eSHwlSBkpFAAfiN+W3CZdPbqQMTErl7sgxQ0N279V6ZyCTFvn44xU5kJoTYr84AaJ5
         V2aSLn6EN1PZgE/80pvWOiD5meBcBy8H4P62tg/uAxlQqDR2oVzNNg3sGMPri/ZjztnC
         P4z3rgrWpwzwbB9zUjwNkpRRRIh8ph4ggqnP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547069; x=1718151869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LI+lc0Adrp0Lkxnnuy2KCG5ns+CVmv57DIBitlySUAk=;
        b=BOLZx1B/8KT9V9W8dNZpo9G5LFOOoTaFSIGwB1NjXfJ8pkL4Yn2RNfv6DeSh0xPBdw
         gJ0CcRBsDU9jIzAJMWLrrOaHuVpCuENU41nlpWvro9I0H6KCFYnp/JLxSAI+TEUk91hm
         X1n2CBE2C/VrpWHHXs3eaESmbEjZ8Asc+Z6Y7mahIIvPNorWL91LPtYA0hmX5hGpDJzY
         ycvAx9SeWHiLeKOHzzMamPow3mO/wkTLpa3DDrvqQdBGiFXYcthbp/t3d5/wwGfawkk5
         jM3F2MPoca9TbylK2lQ5V4REXxHcLhn113lAUsakyTSrHqgTcMURxLhqUC+QVFGTdvux
         clFA==
X-Forwarded-Encrypted: i=1; AJvYcCWLqvjoogatsxcF3WTIeoZkbTC2KBtxFPgaDjD5Ec2aMolEl/klq2BJnoGqPmmFmSfF4V8tFwVf09z0RNYLGn0yUUht6n2j5OR7MrXr
X-Gm-Message-State: AOJu0YyOXthKu6dAf6vpelzQi1N1y0P0zk433eH5BfylZdIP5IgkM4Zq
	PJuK4I1iyn8Qm470mUNip6/VeLpbJXQ+73kOpfmxe4GQnDxKwRLHjXS5KtCcjHXlL98klh0c5jA
	=
X-Google-Smtp-Source: AGHT+IEIcFmN1SNDSxhI7aIeArYotTMMLemxG6ifMYpzG4iBHTkZgO0UtesSzI4gZV4gQgOfODxBXA==
X-Received: by 2002:a17:903:31d0:b0:1f6:a51b:87bf with SMTP id d9443c01a7336-1f6a5a6be24mr9937225ad.46.1717547069457;
        Tue, 04 Jun 2024 17:24:29 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:28 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/24] drm/panel: osd-osd101t2587-53ts: Don't call unprepare+disable at shutdown/remove
Date: Tue,  4 Jun 2024 17:22:54 -0700
Message-ID: <20240604172305.v3.8.Ic533ce1323b94230d4155f9364c2b7c1bc47e798@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240605002401.2848541-1-dianders@chromium.org>
References: <20240605002401.2848541-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's the responsibility of a correctly written DRM modeset driver to
call drm_atomic_helper_shutdown() at shutdown time and that should be
disabling / unpreparing the panel if needed. Panel drivers shouldn't
be calling these functions themselves.

A recent effort was made to fix as many DRM modeset drivers as
possible [1] [2] [3] and most drivers are fixed now.

A grep through mainline for compatible strings used by this driver
indicates that it is used by TI OMAP boards. The OMAP driver appears
to be correctly calling drm_atomic_helper_shutdown() so we can remove
the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index c0da7d9512e8..dbea84f51514 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -186,11 +186,6 @@ static void osd101t2587_panel_remove(struct mipi_dsi_device *dsi)
 	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = drm_panel_disable(&osd101t2587->base);
-	if (ret < 0)
-		dev_warn(&dsi->dev, "failed to disable panel: %d\n", ret);
-
-	drm_panel_unprepare(&osd101t2587->base);
 	drm_panel_remove(&osd101t2587->base);
 
 	ret = mipi_dsi_detach(dsi);
@@ -198,14 +193,6 @@ static void osd101t2587_panel_remove(struct mipi_dsi_device *dsi)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
 }
 
-static void osd101t2587_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&osd101t2587->base);
-	drm_panel_unprepare(&osd101t2587->base);
-}
-
 static struct mipi_dsi_driver osd101t2587_panel_driver = {
 	.driver = {
 		.name = "panel-osd-osd101t2587-53ts",
@@ -213,7 +200,6 @@ static struct mipi_dsi_driver osd101t2587_panel_driver = {
 	},
 	.probe = osd101t2587_panel_probe,
 	.remove = osd101t2587_panel_remove,
-	.shutdown = osd101t2587_panel_shutdown,
 };
 module_mipi_dsi_driver(osd101t2587_panel_driver);
 
-- 
2.45.1.288.g0e0cd299f1-goog


