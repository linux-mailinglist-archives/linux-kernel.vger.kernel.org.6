Return-Path: <linux-kernel+bounces-201594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 180158FC08C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 977F9B25593
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123FD224D6;
	Wed,  5 Jun 2024 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mi/2kZmk"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED31EB3E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547076; cv=none; b=JengdPq3Ifz+ia4dNEovFpXT0E8WsS8CUjIqn49yygHEKzAPyQojQDaCbSEGgDSOqGTqyKZxm16wIU8su45MN++UQkkdBOgdrfmZM2e122lAvHB3UWi8J52KdbUyy+odcinYVCk96/LeSZ+gOGq7GuDlwISEWkQQ68hqPWDawKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547076; c=relaxed/simple;
	bh=hlsN6BbCFBAzyqApzrrNKww90k8tLfAdA0DdJEqZ4jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtuRnqnvJovZofF8EqBuC4KyORdJWfXl2q+e/I+QZE6hPmz+b+Aj8UBM3wokW0AfEyxFYoW/GyH+1wiSEm6Q0YCbMduwOYV25nPBtC5PckFOaLWnP+wyZIRsG8AWSjfeIYPh9qcRtr8LW4iQve589Vy98xnByaLFiz6CRn29wf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mi/2kZmk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f6262c0a22so2662615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547074; x=1718151874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/przf+caKegl5qEPPn6pOmHyiCkKABnIFCYoELVro4=;
        b=mi/2kZmkbJAaYZduj+N4qpGg1SOxqo9l7DqUwlrtRtNm0Arjx1HiQsuagJIsYz1SND
         y/2fsg3Vbz3I8Bs4yVIsIzPDLRCk0qsS71/MklVykjNQYFwO/bM3Fy+u9rTmlBey8dGE
         WTnT9izkyP3EljIMlpD/Q2QUVEQ0k2eyfow6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547074; x=1718151874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/przf+caKegl5qEPPn6pOmHyiCkKABnIFCYoELVro4=;
        b=mT1IQEkT7JtQ4TGh8aySwrUgrbrXkry8zTC1Rk+MLwGHLsyueO3kCzWVy0Iwv36m3L
         mf+QFtY6Heq/Mc/MDFq6CMq5BAaweWFB6bytMkveidksgDSAeDlSHA8aB2fByyEgWLWI
         nhdau3cRNmqerkMgIxJe/iBMIIL4efe3Vfg8HVY7mL/MWCIIcnBNEgV/rrVxdN7SRKxg
         sHmIwYdxWtq4akEJ+psBZi+YGJb52gjddsm6GMyXWpETVjpYB2lfIFqsd/VUPImWNQHA
         Mrz1tmj5erRBBeuXasiWhb8mYsVcJEJA9sqlrEbc+xWOIPnvMDFBk8itEq0EiZele1WD
         njoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb6bfo73S9tZcRi++M61/zCMKCM/tHF8jpEYocMU8CbWBiUYfU2PHWEKDcdeF6+jHUkylCkYBxR8xMDFtWLylg+oiNtLHFPH3BbyP3
X-Gm-Message-State: AOJu0YwfasG/27Gsw/DAKV5zavPWQEMejD1B81TtDnXvBgO/yDJjWUVD
	ZhYDXY7jQ+KKNlGEP+p6OC0H1mSekW3cjnmmK+JgLu9DmMWjxDc3lLmIm8aCRw==
X-Google-Smtp-Source: AGHT+IHez1cc81IZkcpKLDNVF8QX0H0g1tSdXuUZDgWnWy1002HtkjwedjR37Wwq22lEtJMm9Ht9UQ==
X-Received: by 2002:a17:903:18a:b0:1f6:a582:c276 with SMTP id d9443c01a7336-1f6a5835237mr15902825ad.11.1717547074236;
        Tue, 04 Jun 2024 17:24:34 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:33 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/24] drm/panel: tdo-tl070wsh30: Don't call unprepare+disable at shutdown/remove
Date: Tue,  4 Jun 2024 17:22:56 -0700
Message-ID: <20240604172305.v3.10.I46ff4e28c260bcd8e81205debd0994e76fd8aeac@changeid>
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

Unfortunately, grepping mainline for this panel's compatible string
shows no hits, so we can't be 100% sure if the DRM modeset driver used
with this panel has been fixed. If it is found that the DRM modeset
driver hasn't been fixed then this patch could be temporarily reverted
until it is.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index 36f27c664b69..227f97f9b136 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -208,16 +208,6 @@ static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
 	drm_panel_remove(&tdo_tl070wsh30->base);
-	drm_panel_disable(&tdo_tl070wsh30->base);
-	drm_panel_unprepare(&tdo_tl070wsh30->base);
-}
-
-static void tdo_tl070wsh30_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&tdo_tl070wsh30->base);
-	drm_panel_unprepare(&tdo_tl070wsh30->base);
 }
 
 static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
@@ -227,7 +217,6 @@ static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
 	},
 	.probe = tdo_tl070wsh30_panel_probe,
 	.remove = tdo_tl070wsh30_panel_remove,
-	.shutdown = tdo_tl070wsh30_panel_shutdown,
 };
 module_mipi_dsi_driver(tdo_tl070wsh30_panel_driver);
 
-- 
2.45.1.288.g0e0cd299f1-goog


