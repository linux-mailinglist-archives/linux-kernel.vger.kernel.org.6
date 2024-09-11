Return-Path: <linux-kernel+bounces-325470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADDA975A04
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD92B23325
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BB51B81A5;
	Wed, 11 Sep 2024 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kngk4mkE"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0A1B7917
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078026; cv=none; b=gGgi/qTiKQZgMsmGP2YHI/HhMD0B4p8zmK5oria3K0Anqy5hZeg5xeDGV9XYudpVJRRoM8G+bXsbYrkCFSJFEeTde13yveajM2ZxPP0FgLSOxAYVuAs3sZtA9+OZn6n8SfZXZvcClNRKDVHpC8efb1c+/T9FX/bYO7a6433Oo0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078026; c=relaxed/simple;
	bh=796S0cNdnh8oAQWxAJn+p7s2+6LsALkFJDkxmyN5jTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a31SDGIU5OzFq1l11GGoaDwF3bDummledms1EUDDFxaxsloInhb4VUpfgTAY8qEY0Qnrg+cO8es79klG2VLr/BM8tCGXuILY9v65xKdYgBTqnxY311yO9ys5R8c7kbBROTkSxDIJkdq0HRnGtNhAOLta4/jgtNxIK6Upw0MfteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kngk4mkE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206aee4073cso1582995ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726078024; x=1726682824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e29IJe4OX+PU/C1llRpEcZxaInprrHCDy7EtqfxxcvM=;
        b=kngk4mkEFpeDwZGfdq95C+caF/uxrsjtXYuhkRivXzhnq+E5vA1T+kA6emjs+g6Yev
         3Aj7w9h3l1I9ylpORi70KoVE+A+S5tYwrD5ZuPgM7MhKmmeIGJnvuwgq4bPVLfY2Y+cS
         jUsMjEQVZw4J3NrIub5YuLuz4+VRx7lTUn3CtTE2q7ZcCEt+jjovX2BkJ+HNN97lT08F
         /sHub8Xp27Nu2r9WRDtOeyB2HBz/oqiXcmyFMOaEwKNEUYyV+3wnPZ1mXV9e7Tz7x+xz
         TsFxQt//1mZnH93+RUeS6Zqh3+o15JeMqo9gVKmzZVA8klq4JsvHQyMXGabYZXQeAn0I
         tLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726078024; x=1726682824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e29IJe4OX+PU/C1llRpEcZxaInprrHCDy7EtqfxxcvM=;
        b=iXF2k+FQgDPjx6NDLTmv34rItFDpHdCIlWDIRWgnNu/W9hKwpZSSqS0YtsLOEkVI6D
         1AEXIBLcjh/QYabZUKho9vXdp2AXcTzdsPOKViQ7CqU0RdDNTXvwSQbGQU/eFwy1EkEv
         ZsSDmWRZp4XS5RyO71ceUBNR/5YYmRd4e8Dfv6d/jMHT1MtX2YuD+E6IGeG3RDJQGplW
         x3pfW2L2YE01G836KafbbL5EaW/D4fGY5kmsLTWGvu5tKp+idjRnWUwAD+0WfCWA3xai
         SHQaH08KtjqOogO+t+xbQHjiUox6td4s+FRQL+46bN/F4az6dwTc4wGyq8qBRPkHxBZW
         6+dw==
X-Forwarded-Encrypted: i=1; AJvYcCXZqgHR0uURVJbT6ljXlV7wPSlhgpfR2DWJpEnsRo+9h2ICawRQUuFMezfZMrPrkIii2oRTssIzbkk9x9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhw83e3IqW8/EwbL7TMkduyw+LnH8s0linX/MjmR7EeJ0PwoQ
	hZhTCV+biytCKQJX8N9gtQZ+vGjxa4bNTUz4u6tuXHc6IiYkE5an
X-Google-Smtp-Source: AGHT+IFITG48RrTVtlAYkqFPSN+jaMNopNFWs8XCJNmEJah9MxoHDRjZ/nXArmhftcSKD7KDHO/qJg==
X-Received: by 2002:a17:902:d4c9:b0:202:435b:211a with SMTP id d9443c01a7336-2076e3086damr3184355ad.12.1726078023664;
        Wed, 11 Sep 2024 11:07:03 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9d98sm2326285ad.202.2024.09.11.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 11:07:02 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: Laurent.pinchart@ideasonboard.com,
	patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2] drm/gma500: replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi
Date: Wed, 11 Sep 2024 23:36:50 +0530
Message-ID: <20240911180650.820598-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi since
monitor HDMI information is available after EDID is parsed. Additionally
rewrite the code the code to have fewer indentation levels.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
Changes in v2:
    - Use drm_edid instead of edid

Link to v1: https://lore.kernel.org/all/20240910051856.700210-1-tejasvipin76@gmail.com/
---
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
index 2d95e0471291..701f8bbd5f2b 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
@@ -128,23 +128,25 @@ static enum drm_connector_status cdv_hdmi_detect(
 {
 	struct gma_encoder *gma_encoder = gma_attached_encoder(connector);
 	struct mid_intel_hdmi_priv *hdmi_priv = gma_encoder->dev_priv;
-	struct edid *edid = NULL;
+	const struct drm_edid *drm_edid;
+	int ret;
 	enum drm_connector_status status = connector_status_disconnected;
 
-	edid = drm_get_edid(connector, connector->ddc);
+	drm_edid = drm_edid_read_ddc(connector, connector->ddc);
+	ret = drm_edid_connector_update(connector, drm_edid);
 
 	hdmi_priv->has_hdmi_sink = false;
 	hdmi_priv->has_hdmi_audio = false;
-	if (edid) {
-		if (edid->input & DRM_EDID_INPUT_DIGITAL) {
-			status = connector_status_connected;
-			hdmi_priv->has_hdmi_sink =
-						drm_detect_hdmi_monitor(edid);
-			hdmi_priv->has_hdmi_audio =
-						drm_detect_monitor_audio(edid);
-		}
-		kfree(edid);
+	if (ret)
+		return status;
+
+	if (drm_edid_is_digital(drm_edid)) {
+		status = connector_status_connected;
+		hdmi_priv->has_hdmi_sink = connector->display_info.is_hdmi;
+		hdmi_priv->has_hdmi_audio = connector->display_info.has_audio;
 	}
+	drm_edid_free(drm_edid);
+
 	return status;
 }
 
-- 
2.46.0


