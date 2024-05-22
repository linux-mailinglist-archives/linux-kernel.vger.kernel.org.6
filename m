Return-Path: <linux-kernel+bounces-185808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CC18CBB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59F1B21B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D67D08F;
	Wed, 22 May 2024 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qm5UBeIh"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41579B8E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359161; cv=none; b=kDiLxU2+FyIwU0vrcTt3+iFYsN4nNQ8ft+9HZ1hPw4LeYY3M92H4q4svXS5dPuZ3RfV/nRlz2Qg5WR/dHkwlNoLnu+DehUvc8CemR0ADNXdXbKV1ET0lTKXAJ+0o4b9rpA9FI+kJKTPwl+jtVx+jRE3cFWBhZg9KxvleeFDRwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359161; c=relaxed/simple;
	bh=0ZNKdxQ3JQtZLj0Gm+s5zrogyXn00ZSW+UEFR2j6wX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQ8u4aEHhhZEF9gPt8WzY9zYn254XaeKcEaYUjHfh/MRxhYd9UDCRXRgAf37/rf824WERy/nzfbNVCFs/Ry0V5Vkicvek2+pG8cq94ONrB/cXowEJtrNEBo6YZ2uwg3sA0IGIVosbnxilpSR2f8Z7+g2c4+MYghldSAcn3fH/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qm5UBeIh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52192578b95so7228129e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716359158; x=1716963958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAWjwCLmat0Pt42wss/KcevTPw7T7NPDEdWBIi4Ib0k=;
        b=qm5UBeIh//DLKixwDirYdjn3niJ+h4eR3ExiYzVcIULaK0XsNJEMywFpDDuPJ1cuoc
         NAENbC5aqz5FbLU4M/Anw7/suVaY+Y0Rpl5EbwxIn40haXFkKx/WDxHXHtZEsmsKrCEO
         zUHM8K6KJTCk7gGM5ukQ0LPHpRju1WKPZVRD/AeclBLJxaWNjvPAKW+5lVfL8H++njYb
         YY6EOtQMrxzRX/l09i0wG6POnrn+pLu2wlT35nGgWALAIFjZiXtrv7CKN5t4lgAnhD4I
         3El095FYyQyuljYoZUdzwI2gxAeEAgoAX5lu+K8N2/JFogdibmDWNU77aKIMvryb9hB6
         au3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716359158; x=1716963958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAWjwCLmat0Pt42wss/KcevTPw7T7NPDEdWBIi4Ib0k=;
        b=Ud8MXSG+LNhm3HxKTR8h3N6jB4z9TrJWWSQQAovb6pw5Su0o2uRi91Ls+xZ3/fLwzK
         BGaHZlfh7b77remYsl13+T5gD1DShjc9rbO2WZurGigrQseODJ3d7bPnxGFx6rBVm9Ed
         Y4E1jNP3z5ZRa0R8l7QtwXW9Y/Pk1mR5X4Lo1DwG3T8zxcjvG+2RzOjeHi8i++jXuuOv
         qB8Vi00AGoZ48hnf2BqKXfA0/vMlcb6OBoUrauQ+EoIs03yHHmoVkSFQ/nIVpPjZTc9g
         qxs91v+tQG36aVPEf+LeeS7en2yRwguxCQNEaYE8usiUhNquWn2o9Tf4EMIvsh7tucQN
         /4iA==
X-Forwarded-Encrypted: i=1; AJvYcCViVSklAxMpVQ3mH7gz5yKSBukb3YMzxjY7zQhzlN9kQB17QNktmg0/hQavJDOp2oxokOU43sQaRDP481/EEkdjdtGHR5eyX3CxrURS
X-Gm-Message-State: AOJu0YwHud758vQ1zbARVuurwyUNI4PDgd8Xf9A7Wsa1eB9UpofaHBnp
	K+SiSzwgS344KBlpgUy+QnjV4x2jc0WYyUmVncclrfQmmL5GVA+T4w3VD/aoX8I=
X-Google-Smtp-Source: AGHT+IEW+S3+sVgdb7Ioh3lWeKabvLfqA+b3mZ7ScIiWLt3n37PheAoJ6ahbaI04M7Q2NlUrqW9u/g==
X-Received: by 2002:ac2:43a4:0:b0:519:5e81:276d with SMTP id 2adb3069b0e04-526bf35cademr539325e87.31.1716359158307;
        Tue, 21 May 2024 23:25:58 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad4d0sm4910023e87.49.2024.05.21.23.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 23:25:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 09:25:55 +0300
Subject: [PATCH v3 3/3] drm/panel/lg-sw43408: mark sw43408_backlight_ops as
 static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-panel-sw43408-fix-v3-3-6902285adcc0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0ZNKdxQ3JQtZLj0Gm+s5zrogyXn00ZSW+UEFR2j6wX0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTY/yjvD9VQu7L2gIRW8vekBVTwOXaxbDR2pMu
 FPr9Zp7kVKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk2P8gAKCRCLPIo+Aiko
 1Q+kB/45cboCZ7/CfpexfH4y1ofxb4sjLn89zKrylAAgkFqw4wtjybX5pUvHhR2h0TJVS3hPsqe
 O4qvHD/4C3vZTPQcnCZUOAx1QEtRPUMCg+vF4aw925FhwDUGrg2vqpJJpbaEYNzEvoncyan8fwv
 m2INUzUrPYiwj7C/kO6GFKMfXOOP62ANl50Aeno+vO0ZlYpzqZdu+dgP8t8zvDt7r8qPgU6+EIa
 2r4WjEeCRcH9ydw6/GabNsTVdbCWo2FlwNwrByNoZEZi5c+GGCPnyEHnvwxMYCBntEuV9eCEHwy
 oQ3vg6J5dglMkju2nNaXnoHtewp2IeYb7vLJVmRWTFjzkuD4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix sparse warning regarding symbol 'sw43408_backlight_ops' not being
declared.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404200739.hbWZvOhR-lkp@intel.com/
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 115f4702d59f..2b3a73696dce 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -182,7 +182,7 @@ static int sw43408_backlight_update_status(struct backlight_device *bl)
 	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
 }
 
-const struct backlight_ops sw43408_backlight_ops = {
+static const struct backlight_ops sw43408_backlight_ops = {
 	.update_status = sw43408_backlight_update_status,
 };
 

-- 
2.39.2


