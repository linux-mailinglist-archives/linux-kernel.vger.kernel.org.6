Return-Path: <linux-kernel+bounces-185807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BAD8CBB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BBFBB20B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9477BB17;
	Wed, 22 May 2024 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6NcclNZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7678C99
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359160; cv=none; b=kNt/8VeEzV0xxRFxe1Qrf1tLAzR87vl5rSvgXzuMbPLTv+JFvR2Ufde72T8vVjnvTW8etrVbXb62grwc0emNRVJu7Q3frctBnD1q8lTpo8ODfJDFk+N2a1Ri4fO4+8IIbMl13yMtKn2NcrjmrHM/dEPjaEp24nqqrlTg9gy4n/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359160; c=relaxed/simple;
	bh=OzVLboiQq6/i7927qpGZm3VA/GBlmQcFYUqcIc2Gbpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BXWQGpi9n0YS6lmEng6x+8/RC6AHEB84tQyfOyiHX/ettjG5ftTNauq3tz0bWKCaYhRpkjjn2rnQxK+Y6mzm1rW73B+xvShnlco95PdyML8BXcEFhKjamu2Yl5HmtaoDipPaLsFPG8bJnEICkFVeRd1vyu8v8bmoA9FH3WqzqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z6NcclNZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f57713684so7601619e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716359157; x=1716963957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ30IMIqS4FxBzVdWL5H8+rA/52Tn4UUr+hikbOiM00=;
        b=z6NcclNZEwCYWjoXg++EMPs2sWrU1l8z06ghllbKhoR+/u6QJcsXCncawLgoCoDeZK
         wPOpRoxDABe1/VypjXtpvq/ji6U/cvsN1pQwk/AnjbFygi+uEQBBG/thzn9cuL4o4Uj/
         iI9zdo4FhM3jVwiYK9A3fPEH+5uSwEbpqFyuxbw/DZSbzE64zuhFo7RZ0ewZoGh6XnDm
         0Sr+ieyOLTw0Ll5IDL+k4wgWtzbbxvulfJK214u23IgjpEdZcbr9wCjklkVYp9YUNs97
         ME0k4lg47joNw8dwK71MmfYqorpn6U+cZQqrvsjE3o1dceT9jnY9Fq0+Lhf8YMoXGRuG
         +VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716359157; x=1716963957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ30IMIqS4FxBzVdWL5H8+rA/52Tn4UUr+hikbOiM00=;
        b=tOGr7uIBc2uo0ZHXH2XYuxf//sJ0VfUUq/WoLvmOZwx/KgwrQ9+D1u+bdx+d630OQh
         MAzwhYPSKNlL6JpxyaQIAeKIvcY/49CYHWWPc3BhRrkdlqNGdLFLUr/IPmyZjN/JqkGA
         x9PIY0u/jzlOuxz4NpjnvO+jgmV9wLCmfNpY1d2897992rO/X+nJvHthNBQabKnkIMVu
         dAbiiTDH2o0hQ6fsooTZ8fMNYrIygU9Ur/R80sp3ODm2huEDP60LrqVS83sw8Q5Es/a1
         jB+EV1RASVVNhqWlo596fgz7ZAbzCFmE8RuOcpnZLQqZyoyToa1ufZudlPEFdNT7s5+C
         UcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhb+uRImKyLpoVx0QFJm5fZxS8NtejpPv6awjF1RCl4JXqkqjo2DXioopfhwddpCiP1gHteyWXIiQoSVl4108JM+s7XHCw8fSWMLb/
X-Gm-Message-State: AOJu0YzdqKl1Gs9rYBK7NMx+fKU70Zu+4VsCiNDx1TlwrNbVUi/k8nvl
	N3y938IJkmmz4mX5mylsGY4K7KjJgi8fACp1uPHq+vlKG/o8CBVPkdX3njOuETw=
X-Google-Smtp-Source: AGHT+IF/7QZ0tGCXiFYJB/x+q86OQI6ANWr9joQ1GchVETZy/vH8FMHjzEY05fxM+S1qk+o81MyouA==
X-Received: by 2002:a19:384e:0:b0:520:98ff:5554 with SMTP id 2adb3069b0e04-526bf35c8c2mr521592e87.30.1716359157191;
        Tue, 21 May 2024 23:25:57 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad4d0sm4910023e87.49.2024.05.21.23.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 23:25:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 09:25:54 +0300
Subject: [PATCH v3 2/3] drm/panel/lg-sw43408: select
 CONFIG_DRM_DISPLAY_DP_HELPER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-panel-sw43408-fix-v3-2-6902285adcc0@linaro.org>
References: <20240522-panel-sw43408-fix-v3-0-6902285adcc0@linaro.org>
In-Reply-To: <20240522-panel-sw43408-fix-v3-0-6902285adcc0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=OzVLboiQq6/i7927qpGZm3VA/GBlmQcFYUqcIc2Gbpg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTY/y3fKq7yHxjaGudmp6EIq0hsmBQi2qIcxkt
 wwyQWrXMseJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk2P8gAKCRCLPIo+Aiko
 1ZOwB/9XTi/5fMAIsZRH09go2mO1GT8qtjrK4eDP42uTvxIB9XnQKdrUOLABIzsGrwK1kZMfn0q
 wfp4/kKHBuQgQthNE7p7+8smtARdS0TIcPNAWbc2QD0dLFgMyIUqYt9AYgrRtcQd95UMy/DdWKC
 nRvvBcugj/sYeyCgRMBXRl4nMWUmpbf55b6fWCygEWmfd/FO5SsrnY0sws9XiRHDiQchsCPDR5l
 Q9/0ALMepT5iKL3nIEmo7t+oyAFyGRg9K6RG9biicPfITKy98PVCGtYTQ5emoDN/zz4RmsyFdlx
 Yv00RFSQrYhIJ9jvkr2r2fT7Fshh/pvnqcW40+ltqqaFwfuF
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

This panel driver uses DSC PPS functions and as such depends on the
DRM_DISPLAY_DP_HELPER. Select this symbol to make required functions
available to the driver.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404200800.kYsRYyli-lkp@intel.com/
Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 4a2f621433ef..3e3f63479544 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -340,6 +340,8 @@ config DRM_PANEL_LG_SW43408
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
+	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for LG sw43408 panel.
 	  The panel has a 1080x2160@60Hz resolution and uses 24 bit RGB per

-- 
2.39.2


