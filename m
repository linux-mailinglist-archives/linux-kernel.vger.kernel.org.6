Return-Path: <linux-kernel+bounces-372406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6328D9A482F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AC8282908
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66815206E85;
	Fri, 18 Oct 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEiMtw19"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED2206E79
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283677; cv=none; b=XSuf0RrdWAshHPLzqSp7kKICqwdxjXANEZFxo9gDA4KRjbnnNgxbDAxb+pTg9q6ir3MKaofLiAdIoOwjzGLqzm/W0aXWQrFwqh0VVBN/JYQ5DjhQdJCH/fvllWlspKlgqOctytQ6QL3AgYoKEoA3sCd5v0D/0Zx4BkBBNeA+nLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283677; c=relaxed/simple;
	bh=05eR0rzcMjCSZr+JFEQ+hv6PM74BY2KccFSMBu6VpEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLfzLKJUZTgGipnWNLrjvuy0OuCd+5KVpTZ9rPLokloRgUOvx9VeW4f4JCEJEvFg839juyCf0Z2R4lw2N/Rj0giwvvZ3AKTXzegldb/BftNDXusLl++RZmZ/Aq7gY9nUkGFXq6rn2XzNJNJv6cm2Nu0sF6IQP0RithZdXy3NZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AEiMtw19; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f1292a9bso3323998e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729283674; x=1729888474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GuU7tWYyoCMELfexr2H69ppcidX40bNWoyi/8R/8OM=;
        b=AEiMtw19OkU0e/kVhSDrD5/fcDtRczf5UEc/IGMuP6aALvlpNSSmD28CfGFGN2QSsU
         63cmcgRNPImCWPuypDhRDaoYkgr5oeSdJiZnEWgWnbTmI4zr8+rbE5vobipg7Rta8Nkm
         jq5SUzuNl1VmylYgr1jK+dmQiWq3FeNbSsC0Ct7RjRVx0AuV8dDvgkP38ZXG4V0LJfNO
         e6Gi2zYSLRzDab44e4XcajmyOPvbClLS26jWAkLjEtRl8DRqdkvMerrfiKPtamHR+tzg
         dEcMl01ofMf1Y6sCRYCff/EoT3KCfEJ7ad3NpwWadPLPLAYwaZKjoFl31Q7OZblLCUVm
         4CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283674; x=1729888474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GuU7tWYyoCMELfexr2H69ppcidX40bNWoyi/8R/8OM=;
        b=TB0YoB9FP1glXThZ0lE5OYp417LcVT2rK1EhurAC+y/mGe5cMG+X34KJOjhRuqXogM
         1DdtoOMcZEeiibwX3KEhDAzCIfN/UbPCN/wcywEOkGm0MNK1602Icu1wAC/7umZZ0DY3
         5V2iP6HFkpUYAEqlblOjzU/w9K3t0/2aHFTHJZOW6cRxt6rCJiZ6/jLh1EkuNwlb+Wv9
         CHyTBCgkgT9wrvCo1VN+ea/B/x5VubZqP7KK9fOjNUgE9/31wmUei56PAlCOLzGEHJH4
         3c9HiulYTk0vYXlh76Eb8b+efcT2MmJFHJcPmqSlNtOxCl6YC1w5cl7XcsVHj1I69Ehu
         eQRw==
X-Forwarded-Encrypted: i=1; AJvYcCXnz5rKJ2fh8oAjp3Qw7E0tjVW7B5f8if2tYK/H+REwa+Du10gDY/0SFw7ngOiwuu/oz6ChcqFT2X3bupA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVgnbcteA4MXEOdzXLN7CkJ+8uy3wv+mhGFmUMJII7mGz3IdM
	n3K5pPWDOKXJZDRZeMdpo//gUH49HbGm0En+KK3vZ7xQIxGFMyYA6vSWILQ1wf8=
X-Google-Smtp-Source: AGHT+IGloZ6wDijqUZKKkUYLuvbutQRKOF6lHGzo2l2n81Zd1WUUiZf9hJGMWBZ06a2NX4wdB4qK8g==
X-Received: by 2002:a05:6512:10c9:b0:539:fc86:ce21 with SMTP id 2adb3069b0e04-53a154d8042mr2295837e87.56.1729283673599;
        Fri, 18 Oct 2024 13:34:33 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0e09sm314047e87.146.2024.10.18.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:34:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 23:34:19 +0300
Subject: [PATCH 1/6] drm/display: hdmi: add generic mode_valid helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-hdmi-mode-valid-v1-1-6e49ae4801f7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2159;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=05eR0rzcMjCSZr+JFEQ+hv6PM74BY2KccFSMBu6VpEs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEsZW3m5IznuxEQtNTc9EWw3cd2bY+FbRHbpPY
 9wot4vemb6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLGVgAKCRCLPIo+Aiko
 1dF9CACWov/QNo6bt82KZcmQvzsADQbKiFLhhwfiZhK1hr3xE441Mf4iqjWBfQz1bZdyHfWCMFI
 tAggG16qjyRzCbqHkzPpuiIRfln/5K81YATrsU3yYi7L3SjUPPs4M0wVfavvW12Ik7wKvNmivj9
 QbRyNQGuDxBtxyCmF2vZLDRlO+fbavhc7nDWytINEAJwoiaL7LIC0eAiWF/T4eT+GqDIFNoQbbK
 1K1IgQZcPkjYG7SvqcX5oQobue+Do6pxmPaaHEnDNkhPc/IWI35+cIpWOtrKJazzxhccgFjDgJl
 9nJTVPbVYR771G0S2xuCXsvfYTuJbNVfnaGTPVEcqpzPPXMn
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add drm_hdmi_connector_mode_valid(), generic helper for HDMI connectors.
It can be either used directly or as a part of the .mode_valid callback.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_hdmi_helper.c | 25 +++++++++++++++++++++++++
 include/drm/display/drm_hdmi_helper.h     |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
index 74dd4d01dd9b..0ac5cb000ee2 100644
--- a/drivers/gpu/drm/display/drm_hdmi_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
@@ -256,3 +256,28 @@ drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
 	return DIV_ROUND_CLOSEST_ULL(clock * bpc, 8);
 }
 EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
+
+/**
+ * drm_hdmi_connector_mode_valid() - Check if mode is valid for HDMI connector
+ * @connector: DRM connector to validate the mode
+ * @mode: Display mode to validate
+ *
+ * Generic .mode_valid implementation for HDMI connectors.
+ */
+enum drm_mode_status
+drm_hdmi_connector_mode_valid(const struct drm_connector *connector,
+			      const struct drm_display_mode *mode)
+{
+	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
+	unsigned long long rate;
+
+	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
+	if (!rate)
+		return MODE_ERROR;
+
+	if (!funcs || !funcs->tmds_char_rate_valid)
+		return MODE_OK;
+
+	return funcs->tmds_char_rate_valid(connector, mode, rate);
+}
+EXPORT_SYMBOL(drm_hdmi_connector_mode_valid);
diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/drm_hdmi_helper.h
index 57e3b18c15ec..e38b62df59f3 100644
--- a/include/drm/display/drm_hdmi_helper.h
+++ b/include/drm/display/drm_hdmi_helper.h
@@ -28,4 +28,8 @@ unsigned long long
 drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
 			    unsigned int bpc, enum hdmi_colorspace fmt);
 
+enum drm_mode_status
+drm_hdmi_connector_mode_valid(const struct drm_connector *connector,
+			      const struct drm_display_mode *mode);
+
 #endif

-- 
2.39.5


