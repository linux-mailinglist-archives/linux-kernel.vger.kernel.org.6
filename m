Return-Path: <linux-kernel+bounces-391479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C5D9B87AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C61F21BDD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DCD55C29;
	Fri,  1 Nov 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVLSpjtb"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB42B9A9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420726; cv=none; b=CQ/1vsZQWqmFz3mTGkam57zZ79GI/9YAONUiL9eNp5wbuVv4qDD84oSxb/v54u8pmFvAk+KBd7IaX4wlqaVWoTPCc2UpLN3GR6s8OV/s92H0YmIHdp63Yir+FQRLQeLsqbCS2392ZRmDuJslkPKXejIzUtV9FLAwoWSkbjjBSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420726; c=relaxed/simple;
	bh=Q9ji/NbRYwF1TNZj9n1TpgdHLjl20UItRRGWWpdDvcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAtPYNcS+XV1qijQNiSNPLIUy3aUxQXCROegRJdNH5BKNjD1jxgnqf8hXouYOAecV7h/nSAXjG+jtL2QeuL7wFT2DqlmuRwb9nituKzsZrOfCrJmKrGWMOb7nG/M9npqNxWV30dxk7zMuntAJTeePcMq+wXYOJv+HDeGkNit6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVLSpjtb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so1369900e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730420719; x=1731025519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn3LhrswAJ6uldcqCvizMSK2GK9rmkw5c0L7tOFDyzA=;
        b=QVLSpjtb4P2exgAPsj6bbKab/S4C3FjmgtY1yi+aOipfPe4RPQ0FBKmWgrnDeuOAnP
         PBbA4D0JmdT9BNjv5PIMn0E1jDzDsi79tAYRCh9d8GZH4MXoaRwvCYwXldghiUAst9hm
         7WQj/O15oNYgneAEH8lQHO8leF7uHjHVcC7A74QvrYwlhNzITYsf+7mnccCBs9teDwXI
         0wg+tPpVPEtSI2CETwsv9lR+raYw3+qTX/PynvnqwfQj2+3KBPmfpazcU2/aEcUFgzZ/
         HNcjm4q6apFjn/PUbfKpJUps/MgxiC8ffT/i2EBeeEnhSbHCN0VDRloS8vejiUHM6Z/1
         9xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730420719; x=1731025519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fn3LhrswAJ6uldcqCvizMSK2GK9rmkw5c0L7tOFDyzA=;
        b=hUEjWk+DZqRYdJkWgzCKVOtFE2fkVJAx0Vf5Ok3qFPv6QQsbf96BIkrdGd8Bb/nz7Z
         sv923pPkYiY8Nyt1yPVRw0yCwtVDBJ2ixMxifOM8zCwroC7f177BOFo6T+WMc/Fvb01p
         upEy32BS51GQ/b/BSAo9crdJrg/WpOjK+2qX6i2u0ZocBgut5mus6ntiP81ERl3g+vAT
         Qv/ljgrIn4EYeST2nXrq7XpA6BATk7PMeLFPBOY0lSmEPZxzK9hk8iCjXycA3FeuQLRd
         1WkrqPoqgwbe9xwKb1r0I56JsxlUUuIjkBD5tODt42hcqYqNTQrtiJ7BtCz1hw7qeewp
         yO3A==
X-Forwarded-Encrypted: i=1; AJvYcCUwdDqsWnDeS4lDxbqo65OdUCsI3Efn/YY6Xk2bJp0PE5k4UepGAGtNNDNVep2IEMcU6+iKhAUnp4zXLm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq8q0C7oitnFMMp1qvVxVAyolIYvo4txaGPQf0AwhH5p1B5UIx
	HalqBErSitMOwPpuRnJ/5BQWebyv/FlazBAtNvFhjWlIJUdoF4fK1uc59W2J1zE=
X-Google-Smtp-Source: AGHT+IFLGk370oJX7M/fOs9yssB9UroX/yB5UrOBpoOmI1k9rBV3Tjw44Gv6j6p0t2YpMLg9rxw7rw==
X-Received: by 2002:a05:6512:33d1:b0:539:e873:6e6 with SMTP id 2adb3069b0e04-53b34a1953amr11874626e87.43.1730420718759;
        Thu, 31 Oct 2024 17:25:18 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce489sm371153e87.127.2024.10.31.17.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:25:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 01 Nov 2024 02:25:07 +0200
Subject: [PATCH v2 4/6] drm/display: bridge_connector: use
 drm_bridge_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-hdmi-mode-valid-v2-4-a6478fd20fa6@linaro.org>
References: <20241101-hdmi-mode-valid-v2-0-a6478fd20fa6@linaro.org>
In-Reply-To: <20241101-hdmi-mode-valid-v2-0-a6478fd20fa6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Q9ji/NbRYwF1TNZj9n1TpgdHLjl20UItRRGWWpdDvcQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnJB/hTl+xfDm56PcvCfyLR4ruPHvUICtQpdeUo
 JnDXQfGiVGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZyQf4QAKCRCLPIo+Aiko
 1UGsB/0ZWiyvOHwonVjOKqiPjNjrJWmuBjMDfQVw3/uHD8NPKzxvZ9Hr3iL0YRRXMuK3C+IGqcZ
 1xDNk2AzPqJOGZgbbGmpLSH/Vfq6va9o3zKRASXyCKqCYVPLYrHwhfxwJJ+TqXvMYWQrGm35SKi
 jUViyUXSxon0WYJwpk/vcmqyB+DineqeodUGO0o6BRHs0eKeAqqkT/GiDQapFvbC7uizl6AHCjB
 i6jc11/scL3bkp27MSP3HSuKmIMjtfX9dg/uyl7UEyOEM5tMkpbonBX96LPrwSzUbsRnAefU8O2
 LLRA4GeogLOARJb31LmT0HUrWNwo2OHAqrb3GA19J0T6xiHS
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_bridge_connector_mode_valid() helper if there is a HDMI
bridge in the bridge chain. This removes the need to perform TMDS char
rate check manually in the bridge driver.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
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


