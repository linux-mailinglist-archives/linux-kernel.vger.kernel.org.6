Return-Path: <linux-kernel+bounces-384652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B69B2CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B49282A92
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076221D90D4;
	Mon, 28 Oct 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YR3nHnAM"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE21D88AC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111183; cv=none; b=lF1DOy+WrYuGvI3lqudA5sg14VpQJ5GWXstFm+Fp+rwKnQCAExmPjkgKrOBAtDQxhBPIMCY4sVOqGqBnMJE7AaGQulRv7EjjdMedfN1Ga65fNlPlFXaYnZ/xqdGjIZMom2r+ErIAH+En5p6NBFHtOko4PeiQn/7WnYAvZIkzSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111183; c=relaxed/simple;
	bh=BT8krpIlKdeuoBoa0Me+C2adjJG9azTiV2+Ezvu9nxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2pY+jx1Mo75Y0uDsza1mFQ9C05J2vNE0w5NO3Er2hdzvQjL8KOYqyME3PUvvwyQs5eFFvFX6R3Dj+fNhhk0oQ+Fep84lOip7oznSNaPsO1qWG9bTCe4dmVXCoRFdl1/ZsmR3nLul6mDU67AM6A9RWSx9YaKvJAInSrB7yQKOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=YR3nHnAM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a4031f69fso559618066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730111180; x=1730715980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXDPpN57LGyZzaHcm0JxAGhhGbbwxVltmDt3enjDY8Q=;
        b=YR3nHnAMWGgEX865R23Jj1f+E2GXwWEtbVNdGoU1Rck8ZfPy3A3NKV7ht6QixyqBsq
         YuU468p/fAxPVvRx15sxaQmAtc8DUQWcNK3MiptezZe+tKDemcQWmbXHv1Xjv9QUfEoq
         /LUE1Xau7A4XSKkObZMkVrh9+tlvjacyb2E2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111180; x=1730715980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXDPpN57LGyZzaHcm0JxAGhhGbbwxVltmDt3enjDY8Q=;
        b=jLg0Zq/JAQ5JD7TVrWvgsU6LRQ38IZeanOiCKb0xAzxRsNIkGlsCGikaBzoimKXcdR
         6dB0jVOocaJE4rtihAC+q5onDB1mPAFixdG+UI6LNOmKqkATtJchiwDJBk3BoMSOKQ44
         otC1FpSvJvx6E8jpN1t3IFGlpQwCQTEnrS99FJlvk/lLJyCH9UNfXMcjgDtbe+tbwnwO
         4dJjDZAvEAIdZ2tot8q4nFELRWF3ftsQ0hfveHIY76bXF2Nwe8TPhioZ9XfWREK8yuui
         KIO3eC5JypgobadYILKwDp/q+WKCJrc1BLNCZLLk1hfVsSgkI29yGB4vg0wiSPGW/LhG
         Ggkg==
X-Gm-Message-State: AOJu0YzA/B8DD18NAoz8a5Djo1s7mjUTK+kLHPdNRtlnaV/yR2NkCiDZ
	8Ak23pjbiUAfGbBlGU3fu3mgr/AqafFuoE73OTmVQugB2wN2ROa5sW4wUk0PDk5g8pAF3aT4plm
	CjS0=
X-Google-Smtp-Source: AGHT+IGIIRLGq3ogNM31hjyoqOVoY34pnS1OMJQTrH1F7+5cPe+gR2UOhwfrIkMj1DdEZZ5m3Q3jug==
X-Received: by 2002:a17:907:72c2:b0:a99:f67c:2314 with SMTP id a640c23a62f3a-a9de5ee34d7mr848368866b.35.1730111178897;
        Mon, 28 Oct 2024 03:26:18 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297b04sm363613966b.134.2024.10.28.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:26:18 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 06/10] drm/panel: synaptics-r63353: don't re-activate the panel if already setup
Date: Mon, 28 Oct 2024 11:25:29 +0100
Message-ID: <20241028102559.1451383-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
References: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch does not re-execute the hardware initialization/activation
procedure for the panel if it is already operational.
This feature is crucial when supporting the simple framebuffer, as the
controller has already been initialized by the bootloader.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/panel/panel-synaptics-r63353.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
index 169c629746c7..93e3ed545b34 100644
--- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
+++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
@@ -258,6 +258,8 @@ static int r63353_panel_probe(struct mipi_dsi_device *dsi)
 	int ret = 0;
 	struct device *dev = &dsi->dev;
 	struct r63353_panel *panel;
+	bool initialized;
+	enum gpiod_flags rflags;
 
 	panel = devm_kzalloc(&dsi->dev, sizeof(*panel), GFP_KERNEL);
 	if (!panel)
@@ -282,7 +284,9 @@ static int r63353_panel_probe(struct mipi_dsi_device *dsi)
 	if (IS_ERR(panel->avdd))
 		return PTR_ERR(panel->avdd);
 
-	panel->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	initialized = of_property_read_bool(dev->of_node, "syna,boot-on");
+	rflags = initialized ? GPIOD_ASIS : GPIOD_OUT_LOW;
+	panel->reset_gpio = devm_gpiod_get(dev, "reset", rflags);
 	if (IS_ERR(panel->reset_gpio)) {
 		dev_err(dev, "failed to get RESET GPIO\n");
 		return PTR_ERR(panel->reset_gpio);
@@ -297,6 +301,10 @@ static int r63353_panel_probe(struct mipi_dsi_device *dsi)
 		return ret;
 
 	drm_panel_add(&panel->base);
+	if (initialized) {
+		r63353_panel_power_on(panel);
+		panel->base.prepared = true;
+	}
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
-- 
2.43.0


