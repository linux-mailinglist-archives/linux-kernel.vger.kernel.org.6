Return-Path: <linux-kernel+bounces-558032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214BCA5E0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7511E162611
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1429254854;
	Wed, 12 Mar 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="BRfUfdKv"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F4D24CEFD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794085; cv=none; b=iI6ssSPEbvF+JKiayT4IpHkXsNdsKw8QVFoZdlj3PMGZT1B5ahntXMa/JioIXYr0vOQ2FAu+PyYrwaPaSWHnc1TxNFzJenSQmNWioI9hjgyTPqcSxTR/D/8wvxoINIucjtTewnuKsWCXgHdy1Okh7yCqc7BrErXrYrS1trTrQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794085; c=relaxed/simple;
	bh=RV7JCVzm/AfoAjT5DhfbtePEbPy/JDqJU74geh2PGhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sW8Jqi0vqxInZsRoVU73Q2WkoXNTbGaL2YJsYhb34a6oRDZs2W0ZPo4hwH9onh1vruIa8UoKNRCtLcz7U8HKcsgduFQiGU1t3p6UhaPmp07OSO0ys2mv9AZFAeqLE1qhquusCJyJtFQKKFlc1TqhrRB1FFRn2cQPAL47CL+PTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=BRfUfdKv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso719557f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1741794081; x=1742398881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gb46eQM7+CVkQmzVbS3/lfDcFEqWkPNQKqTN3kDSSdM=;
        b=BRfUfdKvVMNOcksvzh5Om3BPBtgXnvSgnW9i7rJj9coODSPOAqpbh5E08ZmK9GFgb6
         Nj2UwmW1nr/O2q9i3+Z5iXKWzWwBatFGi66d3Prd43Hz/EgJRmRHuYsOThQUBoHCDHej
         1SJyz4xEAFktaLSOQoHAxFn9nvJT2CqR4rZVemS/jAxlEZZe7gxUsYW2rKf5khZCGeU7
         u5auZ49B8YNveyYi4rQdPIPKDjP8lvndy5DG/9kVMKJLQJiwZKPBAnHOzAhVSIcbhkBM
         2/IJszCNXOGRIAuKbu2WcWNS7AHPKM88xHxUnpKfc+Y9Ve7Mh5nq0ZSU1umANl9puACO
         dPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794081; x=1742398881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb46eQM7+CVkQmzVbS3/lfDcFEqWkPNQKqTN3kDSSdM=;
        b=cYZ/47hysbyn/Jr0mJy2zop0+2wE0VaAfJtZuXsmyrfjcod+TlyWTX40mMJAC+lh+f
         h+HaAHHnEn2idU2Rxy+OHjvvYWzBLljIZWxv9m7vXRnpV0SWZ6q4pNTBiLmF13mCUruO
         semJb17a/svVCt5Z4CgjZ/LlRoRHO/3k1TunUDBvP/hI6yc9upPCakfUGlSxy1PEtshN
         3upzy5bpZyh0vBShma6TvqOre50+6DT/ADrNZqlkDp732Bc0SWqIcvoEz4ddUe81dMgq
         D+CgX2g1cgxN0yDi5R2yFMTjwLZ90znvDFHDWy7DyLvVceSFQMvBua+yIQpRrtKmbh0H
         G5dg==
X-Forwarded-Encrypted: i=1; AJvYcCXdkwUD5XmUJxBUUTmJ6Aauoaxckc71+yi4hmWLdVUvKqo1Uy4IE9q2FjAC6kpil71N/EVS3fIPCOdDHWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJ4VnKzppkTlfEnQFVLYAYfDl31iG82U9iZartKfTBH5Y4Bfx
	Pi0XqeZ6kF9b4dSymL1XYtOFrB/FPJznPHmaOyCNxPu/5CBDdh8LIHuppstT4riCf1iYGcL358O
	6700=
X-Gm-Gg: ASbGncuKl767H6hQLQgZ4K6v4I2aTdlX9VHRDTEOtxCF0y5Vsj0ofl7MWocST2kXsfw
	F1okJ+anEKLgnF/yXsQ5Y48tesZDe9KLq87aIB6+JtXkcbgcOnO5XFDsY9Z0AiHWznEkoU36mP1
	CW1fmwyFNEfgoq/P5okMYPJ1ToQ03av9FegjHYTD+ZimcD/UxfCF11FD/1eQR0TOokborxajAQo
	UIskV4b2gUBZVmw+NptrRd5xjqMPw+Z1Wv0Cff5yivHghMFulgeR/GiTCgWbw3/hWKXtyzQeP/D
	LV01mJKKnLR6LZKb9gVIiYlVvrpI5Fcozw==
X-Google-Smtp-Source: AGHT+IHO2xtqa0eKA3kIWpS01nWKqjAWxmL8m4XDQ+natRRteVkEJfnmAkGJbqtsK8K6YGcTWKcKdw==
X-Received: by 2002:a05:6000:186b:b0:391:2884:9dfa with SMTP id ffacd0b85a97d-395677a841dmr101808f8f.13.1741794081200;
        Wed, 12 Mar 2025 08:41:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a78bdbfsm24374915e9.25.2025.03.12.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:41:20 -0700 (PDT)
From: David Turner <david.turner@raspberrypi.com>
Date: Wed, 12 Mar 2025 15:40:55 +0000
Subject: [PATCH v3 1/2] drm/vc4: hdmi: Call HDMI hotplug helper on
 disconnect
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-vc4_hotplug-v3-1-d75878677de8@raspberrypi.com>
References: <20250312-vc4_hotplug-v3-0-d75878677de8@raspberrypi.com>
In-Reply-To: <20250312-vc4_hotplug-v3-0-d75878677de8@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 David Turner <david.turner@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>
X-Mailer: b4 0.14.2

From: Stefan Wahren <wahrenst@gmx.net>

drm_atomic_helper_connector_hdmi_hotplug() must be called
regardless of the connection status, otherwise the HDMI audio
disconnect event won't be notified.  Also update the comment on
drm_atomic_helper_connector_hdmi_hotplug() to explain that this is
necessary.

Fixes: 2ea9ec5d2c20 ("drm/vc4: hdmi: use drm_atomic_helper_connector_hdmi_hotplug()")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: David Turner <david.turner@raspberrypi.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.c                  | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index c205f37da1e12b11c384670db83e43613e031340..d26d51902ba1a73175b23eec71562a30ceda1082 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -816,7 +816,8 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
  * @status: Connection status
  *
  * This function should be called as a part of the .detect() / .detect_ctx()
- * callbacks, updating the HDMI-specific connector's data.
+ * callbacks, updating the HDMI-specific connector's data. It also needs to be
+ * called for disconnects to notify audio users of the unplug.
  */
 void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 					      enum drm_connector_status status)
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 37238a12baa58a06a5d6f40d1ab64abc7fac60d7..37a7d45695f236d3ab281d9a8676921fd434955c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -372,13 +372,13 @@ static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
 	 * the lock for now.
 	 */
 
+	drm_atomic_helper_connector_hdmi_hotplug(connector, status);
+
 	if (status == connector_status_disconnected) {
 		cec_phys_addr_invalidate(vc4_hdmi->cec_adap);
 		return;
 	}
 
-	drm_atomic_helper_connector_hdmi_hotplug(connector, status);
-
 	cec_s_phys_addr(vc4_hdmi->cec_adap,
 			connector->display_info.source_physical_address, false);
 

-- 
2.34.1


