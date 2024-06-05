Return-Path: <linux-kernel+bounces-201591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AB88FC089
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D932FB2557C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30B17BC9;
	Wed,  5 Jun 2024 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qpw/eIjl"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3721640B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547069; cv=none; b=AQ2oySkfxWFBpUJvrvcF1rl0dvuaIu+Pt55kJVrkEwN4V90hrBM+GwefzhwX6VJFD2PdqyYqJZoy5TiZXFpFESURS4XQHFvrR/LykLM/TRsTfHpG+PmnO0YRmES/bZ/11wolImO0j8oS8/Zj9g7QeEQHfTwr7wMSd+VuUYosmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547069; c=relaxed/simple;
	bh=fdWEtul+7mN1YfZi2XaYQxAO+/yUXqWWEGCYQxnZA/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPFljWRiIebg8jmSxjmztimBSKehwEMP4uDoGe/qcFFHZRul3rdNDggnAiI6bpL6GOnyyVLbKzQxiIh4Ij4vyWdsdIKuCBfredMHJngnJoVhyQiLXMDkYhSJKBh2o54n6OkyDrbdZrz+HjgDdgN5rsd4Yxs+WY6XdsMlt2RijPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qpw/eIjl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f480624d0fso46312565ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547068; x=1718151868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp09ce6jbG1VuSId6iviX6d1cVtpmqjoxS5RCsh3XVE=;
        b=Qpw/eIjlmBINzficHZKlhp+agMFDh9jBIc6RQsELfV47VgObQvdkcr+OLcafA99j1F
         LtkHaS/ZUDlmYFaLV8CkkktD0Nfpnzc5l/LGKGkY4BUkISSMrc1gAUaldv1YI92a8VUm
         UBekOW5afpyd3yrMDnknX8I9TpfouPDJ0SHos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547068; x=1718151868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zp09ce6jbG1VuSId6iviX6d1cVtpmqjoxS5RCsh3XVE=;
        b=ISD9wew8ZsGOkyIFYq3bbC9VbqX5JEiknE79Tav82OO2tWaaf0DsKUylZt7mMliiFm
         /GwfibDL96Wu/iey5cVypqHgH+BSJ6VgpLmHIqya8hOugFJwRCyfzmpxo3hXlbwx/dIL
         mF/nLVreCmIU2kMr8SvOkA5fnEfkl+FAq7eA4+XAbprYosBeq5ePDFGSqnvR9j7epT2e
         FcZqTjmGqTxHUa7bp3vE5j6CX2i2tsm/Hd4E6VfH30nOtPpc4nY02znEfYgwymQsbTK5
         Q4wwpnxGwh26VjkDZO6yNQjO4T2DAQlP0S7FX0jxmkcc/ER3zxIWO/Jw7E/S4VEqb39o
         mYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1iofisUl1W9Z0bjJhAleGlNQeUhxkd2C29hIpENYEFUOWsaA0qtVJLmeeMNWelxxIdG5bkHVtZcGMnQmWoxLiryjrUFyNfevQetr
X-Gm-Message-State: AOJu0YzDeEILFpN3wdlGAyhoXMpDOMWgUG6xudIwgSPItebyptpqgQ6s
	x5v9yztK+66+CF6B6yMbZKcCa6EhhJmX29RaKc6JgAqIwnnwPhM72SdX7+WUmQ==
X-Google-Smtp-Source: AGHT+IHrG+KMpa5qVMm89loF3lWFCdvOQ3M12nUwP9Qgba8qphs6ItL9jDOQyxs+1t/bccCFAWHjaQ==
X-Received: by 2002:a17:903:1cc:b0:1f4:5a89:39a4 with SMTP id d9443c01a7336-1f6a5a0aebbmr12879035ad.21.1717547067625;
        Tue, 04 Jun 2024 17:24:27 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:26 -0700 (PDT)
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
Subject: [PATCH v3 07/24] drm/panel: osd-osd101t2587-53ts: Stop tracking prepared/enabled
Date: Tue,  4 Jun 2024 17:22:53 -0700
Message-ID: <20240604172305.v3.7.Ic7f6b4ae48027668940a756090cfc454645d3da4@changeid>
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

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../drm/panel/panel-osd-osd101t2587-53ts.c    | 27 +------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index 493e0504f6f7..c0da7d9512e8 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -21,9 +21,6 @@ struct osd101t2587_panel {
 
 	struct regulator *supply;
 
-	bool prepared;
-	bool enabled;
-
 	const struct drm_display_mode *default_mode;
 };
 
@@ -37,13 +34,8 @@ static int osd101t2587_panel_disable(struct drm_panel *panel)
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
 	int ret;
 
-	if (!osd101t2587->enabled)
-		return 0;
-
 	ret = mipi_dsi_shutdown_peripheral(osd101t2587->dsi);
 
-	osd101t2587->enabled = false;
-
 	return ret;
 }
 
@@ -51,11 +43,7 @@ static int osd101t2587_panel_unprepare(struct drm_panel *panel)
 {
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
 
-	if (!osd101t2587->prepared)
-		return 0;
-
 	regulator_disable(osd101t2587->supply);
-	osd101t2587->prepared = false;
 
 	return 0;
 }
@@ -63,16 +51,8 @@ static int osd101t2587_panel_unprepare(struct drm_panel *panel)
 static int osd101t2587_panel_prepare(struct drm_panel *panel)
 {
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
-	int ret;
 
-	if (osd101t2587->prepared)
-		return 0;
-
-	ret = regulator_enable(osd101t2587->supply);
-	if (!ret)
-		osd101t2587->prepared = true;
-
-	return ret;
+	return regulator_enable(osd101t2587->supply);
 }
 
 static int osd101t2587_panel_enable(struct drm_panel *panel)
@@ -80,15 +60,10 @@ static int osd101t2587_panel_enable(struct drm_panel *panel)
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
 	int ret;
 
-	if (osd101t2587->enabled)
-		return 0;
-
 	ret = mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
 	if (ret)
 		return ret;
 
-	osd101t2587->enabled = true;
-
 	return ret;
 }
 
-- 
2.45.1.288.g0e0cd299f1-goog


