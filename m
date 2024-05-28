Return-Path: <linux-kernel+bounces-192951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB07D8D24D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10031C2705C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46776176FA5;
	Tue, 28 May 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7vk3fRU"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C74172BDB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925164; cv=none; b=WWlFCqVoloxxTQlz9l4dVgBix65E4wTPZc3sMwkJHN1enRDXb8pmPUOKEuNA5RuM9Ey+2FvdZro9mQ1Z/A9mdzoA82PLit3tS4+fgdZwT6At4pFiZFVuKjTrfckIeGoTtZi2rU2IJf3jXOZrXUm+3OKjXKp5/po6/XlnAiBQB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925164; c=relaxed/simple;
	bh=JpBownv2A/v5s9u+r2T7bmswrFK7bcF3CJY4XHaV/rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=As4cBl0ToDZTrNt7GA0JAmqUn2JVyJUoReFEN6/GZGZABB5IUElNrQmdvhBAsUIDPFTCDXbmHY7DGZm7Uhap0wkq/8TzGs4Dr6lF3sTQoC98Aklfb0yONeZvORlL046U+5cL8bsvFdfCq5C8jqqpPaeKcIXL53w9a5PWOmBF7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n7vk3fRU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52a54d664e3so72927e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716925161; x=1717529961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMzDrUPXBetRBxhwNhxvFwAUk90y+ybpda/UwhIo+Wg=;
        b=n7vk3fRUxPu7g9bW9fCzevvKqsReTNA35k9QvFKUV5eu3KCw7uGGLvVPbuWACT3Gn+
         z+fDGep77RNN0f6tK7CgOfX59YEPTvpnCzshidvQtOh5o+eXXdJTvtPxNaxZ9iduGXNT
         uaz9JnRZLm+Uwij+I0PWdlVtZPJ7j/Co7bcp6tnkB7ySUBD3Dyf9I1pr7yn7XDA1aSeb
         GUfyHnLruXqSEIhE1pau/VRqK9XuZLhSwlgGaNEF/Jn8RRe+S54FVJhMTvtUw1+H6cR/
         HyWkU62KyUlGS/84gxAjP4KGZjPBusrd8hXix4iyNPWBYyw/PTclqvj59fd0PxhpfaRe
         Tm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716925161; x=1717529961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMzDrUPXBetRBxhwNhxvFwAUk90y+ybpda/UwhIo+Wg=;
        b=TlKcHtzoueVvU1/nvGYMZSr/JMeHy8pno9PSh9KhHn1kQO24yhgTSln28nC84rA1zE
         /XcdooAtslI4qI4kKlR62PC7iWrO1u9YH5fb0FismykDkYh+XsdlsMEwoV+Hexg9Bo9G
         28YOmkTHCuKNhr8Sq1AwIDbvReN1ZzLTX64CG9tgy1Cz/8mzJTXR1hItEm6/O/8dOOOd
         Lxu7brCsFSneVE9eRjtXQg5pqxtvdMIkIVrBiLPq2z2lr+i61i6F1t7tTMncjMqf5PTr
         KAZOmijVPsGeEE9k1oyNGifZqeILPOAyREG4I0hBLWFK1JUXR2YzjpAZ4YayKgu1eN+3
         6yvA==
X-Forwarded-Encrypted: i=1; AJvYcCUPeABwMLV1Gc093v2WTWhrkr/UnT8QT0UgDiJdej9tKVJr1Y3ovwtVYLvzF4ZefV5Jfjv8FwG9axrQfWj72UicHsto6xmG/Y+I1iQm
X-Gm-Message-State: AOJu0Yyb+tvhDgsDXyp8V2+I4mO65MjvGAJT1G+z4BkA88hTtThaM7r6
	F2WL8hjJWAAHuOmS7gWLKu+5PKiHfBPH20ZTmFinKsnKo0kOO7pvu4rAzPD6PP4=
X-Google-Smtp-Source: AGHT+IErWuce9aRTgzYsOItaSivJAYEUeHJGEILEAjjDTx4aWbFd8+75S49CKu4CNqVt+Ys3JPc30Q==
X-Received: by 2002:ac2:561c:0:b0:523:88aa:237 with SMTP id 2adb3069b0e04-52964caab7cmr7869500e87.33.1716925161160;
        Tue, 28 May 2024 12:39:21 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711f96c9sm1045234e87.245.2024.05.28.12.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:39:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 22:39:18 +0300
Subject: [PATCH v4 1/3] drm/panel/lg-sw43408: select
 CONFIG_DRM_DISPLAY_DP_HELPER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-panel-sw43408-fix-v4-1-330b42445bcc@linaro.org>
References: <20240528-panel-sw43408-fix-v4-0-330b42445bcc@linaro.org>
In-Reply-To: <20240528-panel-sw43408-fix-v4-0-330b42445bcc@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>, Caleb Connolly <caleb@connolly.tech>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=JpBownv2A/v5s9u+r2T7bmswrFK7bcF3CJY4XHaV/rs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVjLm9PT4rgSufs1N1DQ9nR+ydH1+hIK4hVb0O
 UFdMizG9E6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlYy5gAKCRCLPIo+Aiko
 1WTGB/9oJhsxnoP8SaNvbslvwO4vwB8P5YM1pgHeTK4f5awBy1BrzWHcn24PItaIkNG3cJQ9C6G
 Aq5N0gZ+eFpDMlgog7O6er+IxajzglH+FexACjtnCGhtaLUCCEXIYcxfO759My0X2E7HlKY3Ytb
 S7Ba3tcWJMb1w0kWduqhEKFVogO0HzdB8tpoLvGVdtS2tkTnGFy5sHGgFZbGfdABLI8ifeddA9D
 SuArUCPBtWwPNypPH9qgK2zNjOase6dyf2pswXwVuUbrIUPZ5frqzOQSGmqcizEZS7GbM32Z8DN
 it0a1IQmiGb7yAC3rakxmf03wLnnLWjvrp3WUKIoeZs+0Tra
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

This panel driver uses DSC PPS functions and as such depends on the
DRM_DISPLAY_DP_HELPER. Select this symbol to make required functions
available to the driver.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404200800.kYsRYyli-lkp@intel.com/
Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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


