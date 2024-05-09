Return-Path: <linux-kernel+bounces-174756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD03F8C148E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39844B2139E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98314770FC;
	Thu,  9 May 2024 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aal0Vrql"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6A2556F
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278460; cv=none; b=bqihNAPyF/tPFPhuospxVuKJeaCPz/WdllacPiZtR/PRePrQFkkFe4XqVA9U5eeGKjMWHXPMN3UFki+V0gPlMTOdY0MLjLdara+QUeZBUznV7zmobKz0cHuAMHsFTslOqgAtbAf5Zzs6+WeOiiTA4Ucpyw3RrioslN+kyvG4jH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278460; c=relaxed/simple;
	bh=u4dvkwzWHVULogOsMWvSG9SUp30Sev0URzMg9QiiN+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CKTApKdoY8EtdnOVLoDNgGuDTjuYpbn8J/hBJUra39leqejnWxgdQnD0B55T4dDxRvWONzhUKmn3PfRjRrfLhwnbUueXJWd7duxW8NY664okPBKY6Rrcp+TCjqtfsd/6aXpee/Q+to8qzdRAaBczaUOW2LoNGJzOd0AGG6kWEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aal0Vrql; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34d7d04808bso819685f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715278457; x=1715883257; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGgT1hFMgp8SCEUMu0ofv/nKd4SmFdvFXao6FIoI+VY=;
        b=Aal0VrqlQkrwJmQwSO0wScYb0g6azd5/Bnd0tockjN4UmkziOxGOB6m+agau7cz+9K
         HG1UGa1P0l7KOhgTRwcSRDli5HvzfWVDlaH0DhFiPBwBHVmcy5r/kpWoedn+8Nfmv4NJ
         Pe4gT5QxrAxfVVE6EMYoXJfbZIjYwyu8plD4GFjDoUJH5yQ8NcFO3N56RH3vy7/LZzXe
         Xt6V9B/VB55MNiraz/U2WicOCEUBrlk94BZRXrtx97NPAr6F+WkYMNlwWF6w4fCa+gdx
         dGydYS+vL+bxFN9FVcZyA/xBtjr0oxsyb68l3/S+oP7oWn/thSdpxleMnIXzg48HCinO
         EeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715278457; x=1715883257;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGgT1hFMgp8SCEUMu0ofv/nKd4SmFdvFXao6FIoI+VY=;
        b=pUdo6DiyNzDQT38i3rAO6V/VIzwrYi0PFYS1iU2ngt1i7/3PuC1I0jThlaeN+72rEj
         RGWxSSgxCMaSH8nbnVFlgzBpoL2mqbsHZqMjaTVhooKxUAJOIm7um62kl9puy5cAsfAZ
         IfhMZM8maOiR7V09yOSolQLU2khECEUL7TxVqj+9zwtyHERPYcXMjbwUETfLuwCbfWOE
         9oz9ajaGmcC+FueN+PlLZWK/aRaVwAZM7p3lbXaf4rqxJ0LXHVpAm383gj95a5mbHxVX
         K3FBuHyWfPJeyz00Iad+nn8h+SiFK7FDiMI8ebBGvb9MxUmVuTVRQh6RiglEzyH34F6r
         OmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsVVdtwi17cm9iL1UqqaEH/GRo9GXu3zXRT9kiSEc5InjLwQAL1KhNPmPwodrWb2iZsU5AvQ0d7Jz0rJD3Kji5OexoB2TdTubbp5Em
X-Gm-Message-State: AOJu0Yw5gHTwZDUn1pb4vEhX3bJyNBzNnPheNGRty+xxc/T+PsLHLiF0
	fngGnB2g7pcZyn/W9mbfMl0lSCZQIAhl4y6QUnP0JGwg9gMVq4G4
X-Google-Smtp-Source: AGHT+IFhoA/vMIw+2oaqHOhFzdJJvOAysP+jydkChqoSdF7SyzB4dG4uXSezRwQdw7c6vf12sQ6TOg==
X-Received: by 2002:adf:e785:0:b0:34a:7a97:caa1 with SMTP id ffacd0b85a97d-3504a61c7bfmr373895f8f.2.1715278457363;
        Thu, 09 May 2024 11:14:17 -0700 (PDT)
Received: from [192.168.1.130] (51B6DCE0.unconfigured.pool.telekom.hu. [81.182.220.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bd40sm2350566f8f.4.2024.05.09.11.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 11:14:16 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Thu, 09 May 2024 20:14:07 +0200
Subject: [PATCH] drm/panel: jdi-fhd-r63452: move DCS off commands to
 disable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240509-jdi-use-disable-v1-1-5c175b2ea1ee@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG4SPWYC/x3MwQpAQBRG4VfRXbs1Jsp4FVkw8+NKaG6k5N1Nl
 t/inIcUUaDUZA9FXKKybwlFnpGf+20CS0gma2xpKuN4CcKngoNoP6xgwDrj6uB8XVCqjohR7v/
 Ydu/7AaqscXRhAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
X-Mailer: b4 0.13.0

Move DCS off commands from .unprepare to .disable so that they
actually reach the DSI host.

Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index 483dc88d16d8..f7222974d6ed 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -169,6 +169,15 @@ static int jdi_fhd_r63452_prepare(struct drm_panel *panel)
 }
 
 static int jdi_fhd_r63452_unprepare(struct drm_panel *panel)
+{
+	struct jdi_fhd_r63452 *ctx = to_jdi_fhd_r63452(panel);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
+	return 0;
+}
+
+static int jdi_fhd_r63452_disable(struct drm_panel *panel)
 {
 	struct jdi_fhd_r63452 *ctx = to_jdi_fhd_r63452(panel);
 	struct device *dev = &ctx->dsi->dev;
@@ -178,8 +187,6 @@ static int jdi_fhd_r63452_unprepare(struct drm_panel *panel)
 	if (ret < 0)
 		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
 
-	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-
 	return 0;
 }
 
@@ -219,6 +226,7 @@ static int jdi_fhd_r63452_get_modes(struct drm_panel *panel,
 static const struct drm_panel_funcs jdi_fhd_r63452_panel_funcs = {
 	.prepare = jdi_fhd_r63452_prepare,
 	.unprepare = jdi_fhd_r63452_unprepare,
+	.disable = jdi_fhd_r63452_disable,
 	.get_modes = jdi_fhd_r63452_get_modes,
 };
 

---
base-commit: 704ba27ac55579704ba1289392448b0c66b56258
change-id: 20240509-jdi-use-disable-ee29098d9c81

Best regards,
-- 
Barnabás Czémán <trabarni@gmail.com>


