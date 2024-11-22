Return-Path: <linux-kernel+bounces-417999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8749A9D5BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D582CB2490F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E571DFD9B;
	Fri, 22 Nov 2024 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="al/GsPKL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7F1DE4EB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266811; cv=none; b=PodxregtNA//dfB5qUz1gWbQegGOBJHCvhuaWhDCucG2nXKB5ZJScviRHXnZgzlQpsbkRKytsBDFSlFf3jBehc11oTPk142hjvTIDOGWocWfT40RCIqsvAMBNaY2XIBGJpWA+RghV4K8oHpDV56RSH3ks5pVOuwNOM/xEfrAXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266811; c=relaxed/simple;
	bh=V6uHu+T4+xW+xwMuVx/apScXj6PwN9KdCvTiBY/zzqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAfwrgmdKN9+JSETfPAlf4o5IMZPYiBHSOkdWjPAMBhuJuzRFnhOde/9DtfPC56Wf++JiXhbqx5KWhvcYS0otytcPegFKa+K9bbYpZDbj/R1PMA84af1siZwa7zn0wDh68PAKnAN+8q+JHiUJBc980enljC4+vz+1cJExDdzy+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=al/GsPKL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dd9246d21so113941e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732266807; x=1732871607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bi+JDxO7zFRVUVNShSHXAVY8nfszGwV4/oGBGiyAqww=;
        b=al/GsPKLLzMYIW7zkWlglZUBSRkJ5BNInDgg0LgCq6Lubl6BfwOHDrR4Y4zXlASobC
         3SHVk5WhWqfsWpHHI8ao3hXr2AydUk9LnMEpceTdBoOks3XGYVaQ/wUOuVkXGZII9EZl
         tzHptbOwOLiDAyYBW/zVDHafSX/UIVcyDDokWE8t2yZUpc76WpMpvI/Ap6dA1pMMA3lb
         4eqha1V5oUDtW55Da0m3OuAcIq6HRop52ytOtthzgUWYBGVfpyx5JftUq5yNFUDHXkvr
         jMLfkKWgTxZI+amGidwUnBp330umqOy/NF2pn9QK7NeujOm2p4qSUKFfONDrm3gEg+mC
         5Sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266807; x=1732871607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bi+JDxO7zFRVUVNShSHXAVY8nfszGwV4/oGBGiyAqww=;
        b=B0Njx8KCEjZHxdchLoCg/KOVKLgI7QS5sF5XUkJA3oF55wseFKzQ56KA7GP6tHGotn
         qLv2zNrOzUe/IVnp7jpA+VnS7fmNf53bRWdhMkHhENlDtKmKzmRd9A/X3bRo83VdM51G
         af0p2fNauJN1iyCRq+mYumPCcw78NJiC/f0nmifeoDVBfJYzzlmIhjfJCKOF8osRjbS+
         FVr0oaP5DbReU3h8ya/PDm85D1Fye+eQLSYDGMcASLNbvzHWphcEG4vL4S7co4xXgRxZ
         1Ktxkn7F4R62P8HHXlcyxh6kzFkdcc+SfawFPB7rmxNSKRsiyqRc2sG0pqMnGTRE8XOW
         8MXw==
X-Forwarded-Encrypted: i=1; AJvYcCXt4rYL856LzJxSRInDtVeXLkaCr3JlRUw00S0if8a4ypXHoPCOepxUvXoICNTqpB3nuUW22VCKgRNdO6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YynWmBZQ2c+gnognbFqiS/jRYSJhisNp7FLLQ+Wf9XwhA5v6Ksx
	dG1qb7nr7CwVcU+NAPhjz/7yfVwCYvAzNuU1GsT02JJSXokJX+dVQ41SAkphIZ1TL60I+/JZEzI
	o
X-Gm-Gg: ASbGncsFlp7ZffkImK0RQg1xUJqJ/AYHSFNQ+M8Ug6Q2AdItInVySzIK38y69wGNJZr
	LtS4czjj6Rtp7jRvE4X881/fsTq9jdn7ckrh4DQALtf+oTKJiJAzfJtLiiObEAdIQzo6jhmZyhB
	GVnZKABj6wINEUNrBoM7Vap039Q+Sgb+q2WiZA8Ulk3C+F3fVHoUP1UKSnlURmRYdPMc9HVk8Y1
	nkOyrsWsNqdSR0S4UkU922a4X36KgAWnafNhB+NVKo8sbryw2DyZRkKMw==
X-Google-Smtp-Source: AGHT+IGP0twniqH2U7ywDpdM5USOAfTTfwclZMuf64h3sSsbdQOKH5VgJsG4NoD2/EPGUBvock6QuA==
X-Received: by 2002:a05:6512:3c96:b0:53d:a27a:2106 with SMTP id 2adb3069b0e04-53dd3ab0eebmr902104e87.55.1732266806968;
        Fri, 22 Nov 2024 01:13:26 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451386sm299530e87.77.2024.11.22.01.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:13:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Nov 2024 11:13:03 +0200
Subject: [PATCH v4 07/10] drm/display: bridge_connector: use
 drm_bridge_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-hdmi-mode-valid-v4-7-2fee4a83ab79@linaro.org>
References: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
In-Reply-To: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=V6uHu+T4+xW+xwMuVx/apScXj6PwN9KdCvTiBY/zzqA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnQEsipUZxr2L4H1CSYJPqrSWitJVJYT8cvGGNx
 VzJVBpVLQiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0BLIgAKCRCLPIo+Aiko
 1Wg8CACUh+Qp1wI3QCkqrRc4xvtyhadjSchb8neePNvcL0EeS3MTH3BWZCvgSLpKslneK9k6yVL
 9DTKhgzCmZL0UPCkBx9as8mvdKQBUN1m/r3gplfEUsQe2bFoVBzI24JWS3ZAVJbe0RlQe5A+N4X
 EOOFCw+LkSv89UJBKWSvUvCm4ez0JYCuuQEDWX2MivOuHLjIzOHKXnubiYcFK9u3+KsRADnp1mi
 RBNUHr/fnJw+uvGlqRKuh3Z3pa9ig+V2gAlc7T2X4/0rhodFgbNr3XmxnOOKnL3E4DJ7eP9ejOS
 8KSZ5CU2TIorVoGQxGUAz2vtTDQ5bGJWekzxiEE6bqzE6v0O
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_bridge_connector_mode_valid() helper if there is a HDMI
bridge in the bridge chain. This removes the need to perform TMDS char
rate check manually in the bridge driver.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 320c297008aaa8b6ef5b1f4c71928849b202e8ac..512ced87ea18c74e182a558a686ddd83de891814 100644
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


