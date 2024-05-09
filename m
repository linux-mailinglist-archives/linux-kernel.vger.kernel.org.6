Return-Path: <linux-kernel+bounces-174985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FFE8C184D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BCD2862EA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A298C12C46A;
	Thu,  9 May 2024 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H89PWR2k"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AED129E76
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289643; cv=none; b=HQ72Dsq0H7q2cy92q+wOPUDnbKJkp57eFr3EkEpGw2cqydVrzc8M3ChKsDao1Q5TI3JOZewyakgVU1cTGSQDLWdByVgdSq4vTJonmXjKyR4w1VRqsFm/5tBAHa47mIhgrSixXzDgB/A12BnxubA+4QeqAzxhAc5z1zUMH9nNKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289643; c=relaxed/simple;
	bh=fJ1rFBZvq/u/ibZlYytLuo1NfFspyuxEibTUJ2GQ7b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hARI/7J1ZMxDOoFVIDy04KnsFmnPniyZJPzTt4PVGCixtJPzLaWWJsLwdW2xPfhGV/hVYocB+eePuuD16l37ilMDRit3Vrp7Pkso27C0aZxr18W7EBNDazwCS5KStX2hot6THb5vnSVRmGfB5b+8EPLMM4PefnixLzLUvQBtxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H89PWR2k; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e3e1ad0b19so17286001fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715289626; x=1715894426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0AjYQgc/Kg6ymj2SYvFJcHrf+33vNVWmj+ECCE5Uk4=;
        b=H89PWR2kuZ4iNCBQ2/uCxKaluAXGjZTaD7JxfhggbBLOS49pHEZAAtGryw3Cl2OmAK
         WQ3v+ZuEJq//LpoEbZn9sVmJks7k73/+nXh0Yxn+ZKoH9+/7HNb5iyXqPdDKacQC6PaB
         6tO00eSL66bDtQWoopTGMOKT3xVMrsuj5/8EjyKBzyr1caRH/ol1IvxM/TB5kj1b36z0
         vRnP+mBdqHmtR9Keu0KgDbieC0G4OQXn09p2JCHyHXMFXFIJNvZvwFqnlm+egsaGQo3D
         fIX1zjXBnZuD+K7Ad/Z+EFSMna+pgRIx1seOjyqdD0gqOrgmxCuEZWCvpoXe2blwfVjP
         RJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289626; x=1715894426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0AjYQgc/Kg6ymj2SYvFJcHrf+33vNVWmj+ECCE5Uk4=;
        b=oWpC2Tw6KGSquhtKRftF1RPQHhXs5iniBHAqZ6iF2j3fByV1kz13DneKCa6c5CL9Dh
         R+JL1Y8B/4wf+HLDHn36yRntQMhkRGly+4oK66WvQTUCa71fAy+RQPUW8qEGPvvBQKcp
         BmY/jPme+Quy10WxIja5s4MlM4rPrl9cKvuT6C/CTzdQ8rs+nn70RlGE8c3lq8yq71iE
         RZSqYCeWY4KSCpX5Zhdb5gtmZYNkqP5K1FcgSAtcYMuyLGqP1nG/Sz9MeUbOqpuyMOwy
         K79Y723PZEYcUWI364jajyN3YE6jrXnYohp0pqIibu2QSuItQjMAff16nVWqfo/G0PgY
         8A9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVELmUwgWYqmguJH/xjoWuReub6ecnsZCIObOosNcO+3ww1HbHBPhBP3C7KLq8Uu5RXOWHEGuxDc6f+dqhM4JXy03rdAHmPsoiodvvn
X-Gm-Message-State: AOJu0Yy3R16V4+eGlzmjm2nQjM8fGl7zBNYe5EH2z0Hz75bINzQALpbP
	l0vFiW4qceKZ1iyO9jIJErcuQS6Uo4oF/Ju5yXKNhqvW7wcserz5iwcyJD6MQ5Q=
X-Google-Smtp-Source: AGHT+IGfXvgqsYlqWJKvA6gGWvMK2v5HC+TuvvP8p2JkYzfRGHQykildj77IYhfD/mCd8xaKabV6kA==
X-Received: by 2002:a05:6512:3701:b0:51d:3f07:c93c with SMTP id 2adb3069b0e04-5220ff71d70mr332140e87.3.1715289625967;
        Thu, 09 May 2024 14:20:25 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d898fsm438832e87.208.2024.05.09.14.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 14:20:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 10 May 2024 00:20:21 +0300
Subject: [PATCH v2 1/2] drm/panel/lg-sw43408: select
 CONFIG_DRM_DISPLAY_DP_HELPER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-panel-sw43408-fix-v2-1-d1ef91ee1b7d@linaro.org>
References: <20240510-panel-sw43408-fix-v2-0-d1ef91ee1b7d@linaro.org>
In-Reply-To: <20240510-panel-sw43408-fix-v2-0-d1ef91ee1b7d@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=986;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=fJ1rFBZvq/u/ibZlYytLuo1NfFspyuxEibTUJ2GQ7b0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmPT4Xu19gIrEOfaCn3Nv8snYLMWWpmEo6Uppfa
 ZIvO2lCIK2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj0+FwAKCRCLPIo+Aiko
 1RSUB/9l96pY63NZpv3fzBCzZg3JjmqmQPyhZEoLIB0v1Epgo3eUl0eV+aUDC2NlkhHqksrZqGo
 jQmiwSwh8ZKgIOjXQFDekgIhL8x1fhjXj0c9g03H1UqXd7nsovDm2r00E9EhonIEQFGb6Ro1Fhz
 8H/3gIa8JYIgDWosbN07hW8phuVPDf7YGXjrSvEDh07x1BVv1yrqTT1yhXwRE3VZ6czzD/bKDLo
 ljztotW1xDNh474V4GU8RJvJe3buA4M9edYtybFBw3GHpCfxxG00eMHM6t96HhtSV51indajJ0Y
 9AtfJrktTVzNoGfO4y909b5KqWYWI0P6huGVDiEqAcLifedq
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

This panel driver uses DSC PPS functions and as such depends on the
DRM_DISPLAY_DP_HELPER. Select this symbol to make required functions
available to the driver.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404200800.kYsRYyli-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 982324ef5a41..2ae0eb0638f3 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -340,6 +340,8 @@ config DRM_PANEL_LG_SW43408
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for LG sw43408 panel.
 	  The panel has a 1080x2160@60Hz resolution and uses 24 bit RGB per

-- 
2.39.2


