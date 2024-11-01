Return-Path: <linux-kernel+bounces-391477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B459B87A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8F41F216A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19917BD5;
	Fri,  1 Nov 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+JG7opL"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DDF1B813
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420721; cv=none; b=C5K0/AkVdDxVRQeuwYpP98NW+tLJf0PHd0JwkD8UCVod96Fpl7icIs7WjniHRcIGqA5/ggWlhVZE+vYjXwQ3jcjCX980EjFqi98ytaH8LJXT1OPeJzFH01TYBa1sG0uYLDW+lrl6iLxW7dqNUSdDzaq0xkie0MkksX008mhDWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420721; c=relaxed/simple;
	bh=7WdeDK9PVMnPHS0xN6wrfKPJv4ESCzGwmvZnGPcMZ/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CjhKtGg5OH6KcKrdnuVnYIioiqdIVe6sdXS69RMoA9px+GfhqLBZ9inbA4pzcwthv5Xm1EAwnQfzZU0qBj5x4Xp4XZPP9ETlQqf8JmO4z8SFvrogpmcefK2h1L7kThitHF1zM/GWqzYio2ZIEowbs/fqMVxTcjtFDrVZbCPfGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F+JG7opL; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so2561222e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730420713; x=1731025513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdWiUnW6vTgN40+31xk3R74ZtFvE1HPhsssihDLePE8=;
        b=F+JG7opLhLJm8v04je9kPbCcoctW2FI+JDG/kQu0lNFZxj+7kfdT1k6m56G74ESr++
         3XsM4CbwpbetI+CID0yc5kPDJO39cDiZX0VHespd/l9gxdgCkfRlbG5lhcylpuylnme4
         AFyc3rFKVk3A5nwuEvl4o0q6+wzPgU49879IEYvPm8sy8dIBZxJGxGomea6GoxZTVj25
         rkb9ff7rteMvv2By0MUVNuXh3y5Y2Jc/Q0BGJ0X/MmnMkWn9WxqC/ctTKi5kVudr0LsX
         ws9T5xzYLwR6uG9pIQecxz7hMLNDzM+jHv+XuJnMlZu1bjrGo5W7OFsIi5uQtbV4/8MR
         bL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730420713; x=1731025513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdWiUnW6vTgN40+31xk3R74ZtFvE1HPhsssihDLePE8=;
        b=jQVds5iZrw40vsFnxpLmm4mtlPr4HOhtMRH//Qx3mNWAmdrkV3OYhYEuV8nCxl1ED0
         OQyihXRDGFyyUfsXTxrJwv6oNVnoWHDbBd4WgODQsKEDOWmvVF9h0itNKolnURDMQqX8
         Qt3PMVQsQDn9+6kzmlU4t5wK3Npn5H3lGBwjUkN2hwXmspRytIjCsp5mKRuQFep0MRxL
         29kqym3K7E8+eARSy5cc4ZTQ+9X89e+207asz/YrGF5C6SILftn9OpJIW/omVeOgcIT/
         RVy2ZiMSXYI8lqx1fpt6DBR/l8Q7Ume8+a9low0SJUk/Gey6a9wC29PEUb3yS7ONrHBl
         SC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzNUBj0dCxyANk/eeQ94JgfqkdPUVc3pO1ZS1d8rFGodB+w/WDHh3ZHitQZmoVgKi9Yo2f2KMrzqFXLAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAuqyfCoctD3DvRUSvG65bqJPjtJr4xVj8/laFf5dBRbh+hIym
	lhT3WWdYBWVCPM678BeLzvoTYuunxru4DAEDx8OR/Xx5ez5gKUjwRB6N2CeFJo4=
X-Google-Smtp-Source: AGHT+IGbq8fCpRY1c1bmmg92095C0kqytUrIWwSrZUXkLxY5mzg2koxLARty7zdJQk9WrWqL2+9CxQ==
X-Received: by 2002:a05:6512:ba0:b0:53c:74a7:43de with SMTP id 2adb3069b0e04-53d65df2488mr1464938e87.29.1730420713436;
        Thu, 31 Oct 2024 17:25:13 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce489sm371153e87.127.2024.10.31.17.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:25:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 01 Nov 2024 02:25:05 +0200
Subject: [PATCH v2 2/6] drm/sun4i: use drm_hdmi_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-hdmi-mode-valid-v2-2-a6478fd20fa6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7WdeDK9PVMnPHS0xN6wrfKPJv4ESCzGwmvZnGPcMZ/4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnJB/hVs8ck2mIuOojDf5BsZyDpCAOCNbvDgTjB
 eEdeVyvSe6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZyQf4QAKCRCLPIo+Aiko
 1bLuB/9NYYP+2gWguXV7p7pxvci6OEsal/Vmy8LRfAO4mZDqwSPpZaLvK3tQVnCC2tplz45RV62
 KH7xpFWZe4L9XV8JIyduCPu3BEZe8cdEHSNio4pUw2nXKz8fuaj/73N0DEwpQF87bixbIKyB11p
 EjmlZKOFvHTJ7yeuUgUUiKM6X+RDLGiXX/Qof/VMIgQjhJT0Q4qmUg2B351WDikp1lpmyRxfTpd
 eX0xqtaokT6BLTm64axs7FFb8od8hvVrsfpfiH3FuPtsW6Ca6XVMAIb4t7YNGUs/h7Ob4NcwJJ8
 xbghQayNSZROF+m19E/pCBd8Dbmht0Ig9PpLzYlQ1LJDdDRt
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_hdmi_connector_mode_valid() helper instead of a
module-specific copy.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index b3649449de3026784ae2f3466906403a0b6e3b47..54b72fe220afacc208b3fd48d5160031127ea14a 100644
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


