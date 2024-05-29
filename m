Return-Path: <linux-kernel+bounces-194772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F738D41C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D90286F84
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A320011D;
	Wed, 29 May 2024 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhI+I0wf"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705DB1CB32A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024353; cv=none; b=NbLrs5Tf9PE1p1uqYdNmx0CWwAxEW6ZcxaW1EeQ0HVSfbSjkAuF1NeL6PZ5hhHWpoLYtSbiGcNcpoPNJTtEedfdeUvjMJZ5QhiBCNx1pjadYg3WqbwlGVcfxDF034S8nLLQydSo1t3lgMTdAvSK1eQBCcApX+U4gUjd5Hda4Km8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024353; c=relaxed/simple;
	bh=tsP9tTDeCAxEsLOY742IzVP85XDz5wvrZItLRYft3O8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnyPEON7+olIsj1f+kphSum8/w7/VsDlsbxtR0ORoOT5ey71aUjG/x3mkDr1Rnkefeo5y13klMAxJYlJCqQzrJJXZgmYEU1mI1hVwnfFZZs8Vj6SKQ+spGZd1cnoFkfTDmeZuCYcVc522rL0oy/wJmSUiJ/HMvyhcohOelsLHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FhI+I0wf; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so2760021fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717024349; x=1717629149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSZZkKIdPjs/3pbTSieRssyY+6F3HyNGApLO69pzaQo=;
        b=FhI+I0wfltXZ06i0GVrehbLR522sUWHoObOGr9UesSj3EiuTgeTUfA2Nb70BRqg1JN
         GrAbvn0x/By1H86uWSrEXLxu8VxAGifF6NJ7h6icXW5CDDJygNOLRAA8470HT6KTEtre
         5xC6artdqeDxKTMMmhYBpNtM/+jv715WvHfWVDtn4R4AgoLEC/X/b0ZDKy3rVGNln6+R
         Oq5F213M6MNh0GAhBbqABGOHcjR67d3IBrgbIW9mbs2dtdxlrO583SWj6x2fU3HbyiqF
         +xvm1yiowOA3lY7BMQJBQtoNfI9/d5/2wgZrbXyBUHGGA72m1dXiYnV5nRxlDShKwg5H
         75PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717024349; x=1717629149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSZZkKIdPjs/3pbTSieRssyY+6F3HyNGApLO69pzaQo=;
        b=PHYH8Jpo3Zz5Ejb/1KiK2cyCUxC8NxcKC5Srm2eEPCPrjEbsR7Za6wBYt3FQz5KoHP
         3qxT1T4k454EPmDGYDKkIujPJ41G4SZOUHGG+XbsXnCflVCM2czitAN+AhyfKZAHMy4y
         EKhl1MI2EJTt2eij5acR1QHQlws/MRPrbLkx84Ym2+V6Z2cC1/XnvgNQFPV5MkghB2oW
         u9166+f8B9jfgiaY53nUrupmo0y5w4ByN3XVCyrtCBRQzPO5p/qsozLsfnLe8FQYCle+
         7Weew1dgSumPV+VX7U548QaPSMY72IU+rh4Wkgqa3XoyAUC44Yf6JZ7tuuZxHXXlO1Dn
         yisA==
X-Forwarded-Encrypted: i=1; AJvYcCXTXCA9QzlLAW2pUOS9KRfw+LgHO8iwJBc3YWvUCrKC5yvC9Y/KEp74+IqODGhQC51EHq9yH+pWP6tiqteW49cbUlcIdHgonQAIj2ns
X-Gm-Message-State: AOJu0YzBiQVZdEFFYGN/hWiZVl/zyVHFqzgadBzPlGmUC9QtkEYWPeaI
	qbHPCXE3L2P7vo49LAlvg1lQG9PJxcJ+6QCLteunUkiXL66sfK0WSX0j97kDiHo=
X-Google-Smtp-Source: AGHT+IHdUiG+DnvSt0qnuwMbT7cQeaKDEpajLmaXOv5WknZU0NyT9BVVqAh79+PYfLzQZdq2zxMdlQ==
X-Received: by 2002:ac2:523c:0:b0:51f:5d0a:d71a with SMTP id 2adb3069b0e04-52b7d418dbemr278746e87.10.1717024349656;
        Wed, 29 May 2024 16:12:29 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529acea1ea8sm1015998e87.276.2024.05.29.16.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 16:12:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 30 May 2024 02:12:25 +0300
Subject: [PATCH v3 2/7] drm/bridge-connector: switch to using drmm
 allocations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-bridge-hdmi-connector-v3-2-a1d184d68fe3@linaro.org>
References: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
In-Reply-To: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=tsP9tTDeCAxEsLOY742IzVP85XDz5wvrZItLRYft3O8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmV7ZasP81Hpao/5n4EYES8nIOWWg/gr7QS2AUm
 8cTtD+IRrCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZle2WgAKCRCLPIo+Aiko
 1R3MB/9S4LVRBbtll6+h9QWEz5yMUbV4NHe5Si+KYeQBc6Deeau8a0I5gE6NMyZhX8/JVnemsp0
 3oN+WuONb8GN7MXAuFmLKC7vABq5bhEmsVBevmbUbsN+HaeMcPL6myXLoHWINkvRsQNL6aDdHkO
 yKd9atzEHFBrKmdXLvavoHYA7un/xQFOqyUyPCA80UM+pj9ADO8jKTnlS6VFBHWpN3kP+mwio1y
 jqqbcH+GYZTvcJ0SAenLuEoVs4yOEN1+WIx3Qo/mjlLKOlyqWrdq4l/jrU6f9AhYbgTcw0PytT/
 yVToaD/CsmmfEmM4MXGQX+JA6AmidNVgELG8S4eg24GKEsOB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Turn drm_bridge_connector to using drmm_kzalloc() and
drmm_connector_init() and drop the custom destroy function. The
drm_connector_unregister() and fwnode_handle_put() are already handled
by the drm_connector_cleanup() and so are safe to be dropped.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_bridge_connector.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 982552c9f92c..e093fc8928dc 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -15,6 +15,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_probe_helper.h>
 
@@ -193,19 +194,6 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 	return status;
 }
 
-static void drm_bridge_connector_destroy(struct drm_connector *connector)
-{
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
-
-	drm_connector_unregister(connector);
-	drm_connector_cleanup(connector);
-
-	fwnode_handle_put(connector->fwnode);
-
-	kfree(bridge_connector);
-}
-
 static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
 					      struct dentry *root)
 {
@@ -224,7 +212,6 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.detect = drm_bridge_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_bridge_connector_destroy,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.debugfs_init = drm_bridge_connector_debugfs_init,
@@ -328,7 +315,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	int connector_type;
 	int ret;
 
-	bridge_connector = kzalloc(sizeof(*bridge_connector), GFP_KERNEL);
+	bridge_connector = drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_KERNEL);
 	if (!bridge_connector)
 		return ERR_PTR(-ENOMEM);
 
@@ -383,9 +370,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		return ERR_PTR(-EINVAL);
 	}
 
-	ret = drm_connector_init_with_ddc(drm, connector,
-					  &drm_bridge_connector_funcs,
-					  connector_type, ddc);
+	ret = drmm_connector_init(drm, connector,
+				  &drm_bridge_connector_funcs,
+				  connector_type, ddc);
 	if (ret) {
 		kfree(bridge_connector);
 		return ERR_PTR(ret);

-- 
2.39.2


