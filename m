Return-Path: <linux-kernel+bounces-372408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12649A4832
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82361282773
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAE1212D2A;
	Fri, 18 Oct 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DspD/beY"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578220C039
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283681; cv=none; b=e+zvYhnwk05YQXzRSb/St6hsrfUq5RLM60aysGNSgxRaBcQnlr9x9xbOI4BWBtHXGEaEC2MgYYEjroQUhGBtnd/nFbJS5/Wc9ezgECvW9W5BpeSAyNMCWhWt8vBtMBrZgk+keGOOOhaG5ZQ+AVyKKcNYu6TOcGg5KktJRqiaAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283681; c=relaxed/simple;
	bh=SLiFFY4mHaK2mj2q8xisga/Q9Y4nw81QpArU89KsdC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ejfAkvNXYAKyr0arPcD2TAkNsew/RhSoojIowuzp881CNuqAvoXVvJuSU3zQS+qBqe8btyEfIdq+fT69/kUTPMEvdhwnALBnTQ9T5jw1DNb6KLNrwqoMRTH4r5BteOa27bvbRMyXWphm8JeQtscW3ps5hNa2o7V9x0Gxqe8wjcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DspD/beY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e690479cso2899025e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729283678; x=1729888478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ca1rU5SjfCzQNv/FEym5QKCwQ3XnYE+z1oSBkBKPVBg=;
        b=DspD/beYZx5H/9ow/JknE81DCPDCvKaeMI0G+fx6QBSAtWBpoPBNtTNla3xY8wJKUJ
         o4iuypM6ETezp34++SxFmBxVTRRkRbiOtV9NnB0YYEqz5XI0hF0KyaIGC7iVoZiKKt5N
         polGWGkrGYJbzOwnI0EKxetQ12Xdk/2BWpkeN4wtTJJ9FkkgZHoAi+hAJXrv1JO+w5iV
         F67/44cvtgnSrGQyp4B+wo/RGalqfsQb4Bzw1i5mftLrehiUqODsOju7QgVz61aWLyhW
         Rre3vI+rqPtIPla7EPtdJPMvIRnc/hRaGWcIG0zaO9bI34Q7k2LoaYxbtySmGNovrLBF
         9fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283678; x=1729888478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ca1rU5SjfCzQNv/FEym5QKCwQ3XnYE+z1oSBkBKPVBg=;
        b=FI/05qdIlFkAqxCA/OFjboCVw9U2H8CXLqYpCSIDkqiXOrgDZ85LUz+L6HldmmdYhn
         o8VgvDpMZ5ndswHFuiSvZsm1c4dlXfC3OLjEls1myC1s3mrhXtB/FSX+5+g4G/L+L500
         bY2I/0rt9a6wzFAHNaQQ83z9it8aqGuxT7AghJQY8vwliQ/0hZkewWOb2m2MX8gDfIQE
         2Z8YE6Y3+LIAv+GjxExC770BSpCHGkoPVFXoTVyKRuLbEHGj7jsuNH42RksvK5S0m/Z+
         52wFC2vdzOBvcZ/XvcGgkPQgP9bhZ8jQl22rf1ipDUJqkW69V0fCMcMIKxF2GmvZ032K
         s1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUuZVTpHfgN1cfbwh2DoV4OwTnBueP7ZeUQglD2pdveXXeKQ/+Adffq+TBMOyhvnaaN+aCQGTyFgWDNUus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxccthspP3ayvOY+noswInh8nUyIHi3aO5+QqRF46vgoWJtroZI
	BUHPna/CTtFK42j8SrGvOnQNPGc/HeqtsFlIJura2am9JPEpeWfF10Kv0hKNTG0=
X-Google-Smtp-Source: AGHT+IFTHfkrFtW/rXOHHbEDQkVHYXvE16LJg5mmb3Z1WRleIxcPDhcnmv9BafU4kuhPvZsMxuWfcA==
X-Received: by 2002:a05:6512:118c:b0:539:958a:8fb1 with SMTP id 2adb3069b0e04-53a1551168cmr1519828e87.60.1729283677753;
        Fri, 18 Oct 2024 13:34:37 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0e09sm314047e87.146.2024.10.18.13.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:34:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 23:34:21 +0300
Subject: [PATCH 3/6] drm/vc4: use drm_hdmi_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-hdmi-mode-valid-v1-3-6e49ae4801f7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=SLiFFY4mHaK2mj2q8xisga/Q9Y4nw81QpArU89KsdC0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEsZW5T8Y/qcRfISUNqKDHuO2cK3wsa4ZaEnDU
 L3k4nG0OqyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLGVgAKCRCLPIo+Aiko
 1V3DCACgaS2mX/0MXs81TWTKcZTjZ3KAqTJ3HrXMX6GnlBiCEqicvl7vBA4LM0KdCkTZk29pVaS
 FmoWyRYXnr0PklxZ9FlSqHz1LpsPCgONRG6Iq1szlo/1g4WbnHeracbGaj+Xt5QeFc83wJS1SMP
 PSssSHdZe/VhLGFADVaLuUvCim0834TLcmafqiK43Bx3yjx+XdZNXMc+75uXf3HD434HHhdA/Dz
 i1WWdq7icOPAZsT3xj3cbPCtGWy6ehHrkYS3R8vHwsIPJBVDPweWJxntNcRnQIIjxP2zNrDpo6x
 8G3v4fRMVwQ4wQe48iAB9NxgSl9mMIBEGeqryrzXVBfvHBhK
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_hdmi_connector_mode_valid() helper instead of a
module-specific copy.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 62b82b1eeb36..486e513b898d 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1752,7 +1752,6 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
-	unsigned long long rate;
 
 	if (vc4_hdmi->variant->unsupported_odd_h_timings &&
 	    !(mode->flags & DRM_MODE_FLAG_DBLCLK) &&
@@ -1760,8 +1759,7 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 	     (mode->hsync_end % 2) || (mode->htotal % 2)))
 		return MODE_H_ILLEGAL;
 
-	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
-	return vc4_hdmi_connector_clock_valid(&vc4_hdmi->connector, mode, rate);
+	return drm_hdmi_connector_mode_valid(&vc4_hdmi->connector, mode);
 }
 
 static const struct drm_encoder_helper_funcs vc4_hdmi_encoder_helper_funcs = {

-- 
2.39.5


