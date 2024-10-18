Return-Path: <linux-kernel+bounces-372407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B69A4830
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4C11C2240C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470EE20CCF7;
	Fri, 18 Oct 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsAe3yOp"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA72071FB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283679; cv=none; b=gLzZlwO1XjaNwpU5QtEO5qfPgcbAOCsJEnx3UG5uNW6hL1HSaRFVsFahnMg65WFRDWWiYWvZyxRih1JyQ9Q9WY/SSTuHNf3C0cYobzTng9fA5Lplh7h2bSoaQeNRGlmaBcvekts9pxLWc/Y0dVbwgIwGr7O/R8xcw5bRoCVFlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283679; c=relaxed/simple;
	bh=MtW4rEaw3z2JqlmFrdNRTkI3k9zk4GSQZjrxwP7bYGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cdj5Esd5nz9TH6cZm2Gxk6sWiYLK4r9iIQkxcZGzB2U+kGnzABn+sI+RpU0P45xiMeZByc9RsSHwjY+C3ywEvpYO2xIKCMrd1h8eSnhr+yZtM/E1scW+VOEQa03+ohe7Dw4p716BBOm9X4TRCv8Xh/M1S5pojrvhNoGW2zEgntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZsAe3yOp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so3009610e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729283675; x=1729888475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/m0kHi0t1totPQ3PzKzLk6eKNQU+IyYcKKk3sgyVyJI=;
        b=ZsAe3yOpeZYuKXSQl+jJEuGvMtyL5Sf4LwICT+jiHzIh/BYBdzSlewnY5IttIz/nkd
         +QV9r2J2u0MOX3H+pibZdteNExUQ43ranpqORxeW/Faz5fotjCnpnYnLPD9BTu0EWpXI
         KkQf/6X1Ln0MXrpix8MxvdgqXdhc38jvwYo6EihH83bXtpa9AOyW/wUWIxeIMy0t2Pex
         DwD7GTep5gA1jkIq1pCBqKwOnVepJL5rahchO/lMAANUtooTGxM9eZiN2vybsbVg8Pm+
         yQK6oWyNUc2m4SxVg1jmoWtBO3/6HINSnVr2H5zNdk1AWp27O6RwEkOIooqdE9RTkE1v
         NTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283675; x=1729888475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m0kHi0t1totPQ3PzKzLk6eKNQU+IyYcKKk3sgyVyJI=;
        b=hajjQ1kKmZ4XSvhA3F1ic6WeCEw7S6I4DSR017hM7XDDqWrRm9szEZXf3z78Fbv2Ba
         EMOCcu/Swzy7abOg0JBGLNpA4L2td28zopv8mwjxwF4vo+LaiN+WTsbNZNSVCmQSuSZM
         rTLx9lgHwXi4C94iCD+KIZ/HPQbEZ6IVtBzJCdyJiaYQbLuV6tUd1q5/cFHdMpq4mLmF
         8evMSmVMCvHOkYQIXf7EOJVzA2iY0JbcjSKLAOsb4Ju9NK57/O+1F+bRXDY0+UPhpvhu
         bGK7+DWUZT5NHNQB8WzY0fOK1FUqjWGKzvHZA+Wb7ajIhsV7n0uQ06UCuoIl42J1Ta5Q
         ZPqg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Qkgi4BK2D5s2Me1SDCV1fWnZpHUXMoy4RmzmV/U0yZRDA6RzX6vjmnnJtBVIJN0SMTPXOGGUMLlVpb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydueUBtwdFDnqyiJhO8e60I+sysqSR2C74tm4Zd8UCaK78yaKJ
	FiCjXKHTSlOMRJhGGVsPEVa3nIy4xAwbGAHo6E77ylA2xMMUF1lkQKsNpW4PX00=
X-Google-Smtp-Source: AGHT+IE8teJd2ZASdpn1PLVXXJ8Z0lyW9kTdAysHgWEAGJu0SayFj+KAyRByYqJcMZXxWhWyPtS+1Q==
X-Received: by 2002:a05:6512:692:b0:539:8f4d:a7dd with SMTP id 2adb3069b0e04-53a154436dbmr2588171e87.42.1729283675244;
        Fri, 18 Oct 2024 13:34:35 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0e09sm314047e87.146.2024.10.18.13.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:34:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 23:34:20 +0300
Subject: [PATCH 2/6] drm/sun4i: use drm_hdmi_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-hdmi-mode-valid-v1-2-6e49ae4801f7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=MtW4rEaw3z2JqlmFrdNRTkI3k9zk4GSQZjrxwP7bYGo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEsZWS7Xr6vqJfAnZJaxT8pE156T+ugvlMXDE3
 cWVO2I31JaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLGVgAKCRCLPIo+Aiko
 1RStCACcZGiWbJ6rwl1Z7TfhmYAv6dtF23Ul2Ba84Yg6T1vuXwq/cb/4fJJgxp0DdL2C34giGeM
 OX7nDtrcBG8ZwXo0GOsmJqZxtWzIiBAyCVGTmz+yx2Y+tR5Nhnu2zkJeXVuxV0n5G5uT9maCxns
 NKuL0ICAxfeQ+ICDoNDqNkgABXsNpo03+AUcDftdjzQDqqcQeaKnK9f5YiWI/97U/5ABstMbZ+K
 ceX6ul8ImmiIFu67jcbEl347B72uAN/TLXdutztOSkElYtI5UwIj/Sl4fJOiQQwobFAbw1CoNCD
 wN2I8yrwr3Tn99ueCn+aeGGPbo7vTkfjtwCWzxrkVIR9jctY
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_hdmi_connector_mode_valid() helper instead of a
module-specific copy.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index b3649449de30..54b72fe220af 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -205,16 +205,6 @@ static int sun4i_hdmi_connector_atomic_check(struct drm_connector *connector,
 	return 0;
 }
 
-static enum drm_mode_status
-sun4i_hdmi_connector_mode_valid(struct drm_connector *connector,
-				struct drm_display_mode *mode)
-{
-	unsigned long long rate = drm_hdmi_compute_mode_clock(mode, 8,
-							      HDMI_COLORSPACE_RGB);
-
-	return sun4i_hdmi_connector_clock_valid(connector, mode, rate);
-}
-
 static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
@@ -269,7 +259,7 @@ static const struct drm_connector_hdmi_funcs sun4i_hdmi_hdmi_connector_funcs = {
 
 static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
 	.atomic_check	= sun4i_hdmi_connector_atomic_check,
-	.mode_valid	= sun4i_hdmi_connector_mode_valid,
+	.mode_valid	= drm_hdmi_connector_mode_valid,
 	.get_modes	= sun4i_hdmi_get_modes,
 };
 

-- 
2.39.5


