Return-Path: <linux-kernel+bounces-372410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850759A4834
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1173F1F2208F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C341212F04;
	Fri, 18 Oct 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aahDAxfJ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81632208988
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283683; cv=none; b=Q/25Ni+gJ7jagRiWFrBSSq1qFOHe9IR9EVEn63BG1rnPtJ+Vm8qpV56VwfimYEk3NkpAv3cMFI/27q/dBhZXaGkyp7lPZgokrjN6FcdV5odfrK40RxVNIO/hIax9nMCwCFdZCcoaTAN3/o0xtMj92cM7j+TFB5xYpqYkinaXVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283683; c=relaxed/simple;
	bh=N3fpJ8U7Ak99t/Z4rrwzOntZmmVW0UU1b+pAthTP+sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+ypTUJZqaReX+MjPH3VdqUsMe7qhT5bjfun7v0itZi5cCF4Zw7JgC8s/dP5cgXY0YEJW3/yz5bpycg5cRJnj/c9UR4S0Iwft4qyt1w90ksC1pUWZ/pIc2FR6cgn6LWC4A/7wG7AbexvuNY31zbS/4UKMtv8ebDGITHaXBLj0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aahDAxfJ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539eb97f26aso3095634e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729283679; x=1729888479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fjo3xom5hyHJVXQDe/CPNDPIWLjDZtVAaVw4HhlPIfs=;
        b=aahDAxfJ0KaWiScG6nmDpU6lBZWPuxHRkLY/1eqfCWgXiu5yHbnBzpGBKyBdQ7AsXC
         4Cew1LfJq1jCHtolFFPCwXEixTWWTKQ0ruAUYQF/wRdWr7neAbwYl5XgXns60sbj78+x
         U9fjWtQvWm7DVIm9V4Ej0YD5zZNw69eZi6FiBYTVaZkJEU4WQ/VIXA/NdtY55JHOnDSF
         CHcOtIEYfJpOxDYFLPi8L/ERoklt4CjZtRiIaK6BCrJJjPezwYCswFh7ZV//te80+qww
         1Quz2cmut86hkNi2SFCo/13zM9hvHxj4fMXKhob94BTkCbeO9a3R608UCI8DF9qHjM2+
         pahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283679; x=1729888479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjo3xom5hyHJVXQDe/CPNDPIWLjDZtVAaVw4HhlPIfs=;
        b=Tmi1mf9Dy7EQ0wwzrpCzfXWnsslIFuTIX0wMC+jho1S6zIMpDcEPaPVzTuAXST7kPO
         dMSRCF85oXSsYNC76prGcXIdAgFO9d6e0PsAKxWSiZl0CEfMA+vUmyNr0kqC3FzUyD+A
         ZqFTZ7EWzPGPNo/75sJiTIR1dY1KG72FzquHOzmd/TNmSU2SfxojrBa/Vc1MUEMvG0mB
         +xMjuhMORfLbkHkaBn4+Kr5/N2PRT6fZfshMrkbr8iXLRZTx8QAO9pfPGfyMjd8A7EG+
         bPGi5ifTTVLx+kZ+ReZwqR13uP2PRwwrxewOeUlvPOSBLC+YCdEamwCCRQFc6qz4W27A
         Bu6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2qZmZ1SPfWIQESLZ+GGKZ4b5XmM7vwmcrVV5Nb2VRQOChv9dv1s9bnwHDSm9CShr0Z9NBf7xy8JuSnmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpacT9qAalTsaQUP3iJw5WGiMj0S1UM9RHBRZhvtiPbyGnbyi
	tIGsus1k/5+K2l6d68Lan2ta/QSzM9yGGc86RKlEks+J+mar4seJu5S4NEyNJVs=
X-Google-Smtp-Source: AGHT+IF8BVoRIxnX151X/ou3wfgvDZ33vCYdpPGEJRWz11slO0h1dFciQ3fgvHB6ZjPafQuKkOrHTw==
X-Received: by 2002:a05:6512:689:b0:539:93ef:9ed9 with SMTP id 2adb3069b0e04-53a15231e83mr2568387e87.36.1729283679380;
        Fri, 18 Oct 2024 13:34:39 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0e09sm314047e87.146.2024.10.18.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:34:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 23:34:22 +0300
Subject: [PATCH 4/6] drm/display: bridge_connector: use
 drm_bridge_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-hdmi-mode-valid-v1-4-6e49ae4801f7@linaro.org>
References: <20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org>
In-Reply-To: <20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=N3fpJ8U7Ak99t/Z4rrwzOntZmmVW0UU1b+pAthTP+sI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEsZWeps0ACTRHt9hRd/qx7Ya08ePnqAT37CMz
 0SKraccjUKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLGVgAKCRCLPIo+Aiko
 1b6OB/41ftMl6NnJ3cRxPukMLnle7BAxhRv6D5fefVcCKYyvbpYkKmNAYLWRN8s0T2q/f15mZfz
 UE8xxtBlmALOjmUa0S4uLfve0aqalgAsQIAG9gxLSbBNhTtpmLNIv0+RNpJ0DRnrwi1ND4bJIgT
 WPcqL5WpwQq9T4rkiQsEHwcP9QuxeEg/wAqr+K/MAHq/1bLpu6I/kzDaeoVbr6w+bXxy40f3iq/
 EOpk6yliKUDhA4ypEeO3L1mhNldVR7bsYUwVdsTdqxjqcadDhvDyIxCTv/w4AIGengb6jNP7Iei
 mXCwiSlpXwh8my5JY/3Qzks9N7ysEsKjfeZBa2l+7EN8yQqU
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_bridge_connector_mode_valid() helper if there is a HDMI
bridge in the bridge chain. This removes the need to perform TMDS char
rate check manually in the bridge driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 3da5b8bf8259..3304ab0c00f6 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -18,6 +18,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 
 /**
@@ -299,9 +300,22 @@ static int drm_bridge_connector_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
+static enum drm_mode_status
+drm_bridge_connector_mode_valid(struct drm_connector *connector,
+				struct drm_display_mode *mode)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+
+	if (bridge_connector->bridge_hdmi)
+		return drm_hdmi_connector_mode_valid(connector, mode);
+
+	return MODE_OK;
+}
+
 static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs = {
 	.get_modes = drm_bridge_connector_get_modes,
-	/* No need for .mode_valid(), the bridges are checked by the core. */
+	.mode_valid = drm_bridge_connector_mode_valid,
 	.enable_hpd = drm_bridge_connector_enable_hpd,
 	.disable_hpd = drm_bridge_connector_disable_hpd,
 };

-- 
2.39.5


