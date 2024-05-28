Return-Path: <linux-kernel+bounces-192953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FCC8D24D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357851F29C98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F04617838A;
	Tue, 28 May 2024 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMFqTRkR"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C57176FB3
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925165; cv=none; b=U6t5hqjtNAAtQKUCcMRILq3nuOBlee72sfxUWeoDcvozeXw9X5zAgb0/1RIa487AQcCm/9OXxtC+hTRWkJPvoAPPh7ckizjFVxEH/K81HPgJRDNu1AcWN+IGzCKUVVmilExySGTi7aJZTnQbO+bqw328f+KgIgstt8wqknCmdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925165; c=relaxed/simple;
	bh=0ZNKdxQ3JQtZLj0Gm+s5zrogyXn00ZSW+UEFR2j6wX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=obpcL+59lnTVKfZ81ak4v6Ip1GmD1/t9s43RB6un81nIBM1jM9xDP0zB/4ie3//SlbmewcAVKJnevaOuHRmPXKYX7zYYgI+MMKduZPaFRBx3JZ3PaljbTgeK0G1W19tPuwU2TY1TdHzWzI166/qunV6kkpzMCh5rFJGUwRWKpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YMFqTRkR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5295c65d3fdso183777e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716925162; x=1717529962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAWjwCLmat0Pt42wss/KcevTPw7T7NPDEdWBIi4Ib0k=;
        b=YMFqTRkRMZ5xDwhYxyMdbxJ/MPz1HkfXEB2tarwH6kxuLeIGudwIZPP5vqYgxmnFkW
         az1MXD1puKJdCQbMuOoYwNoAp4+iqT+/LT264u8P95ZAwjBdnqnVBekB5gzg9abHlZGO
         75QIPzctPG5DvrqdQbNwMxs5In7jH1oVeoaGEgwGOjRtymZwEpAbJWjCEePLr3Ebd+qT
         JYkVX9IaEmpbOM7yZaBcym/tpDGSLWbQ0nOHO2T/TxugsTu1SPesYtVDY7rkx5otWiZN
         e04uNMtrDBp66mI6hjuEfOy6aex9wHwpvvRlv7VL+bGijM3gMQwc1MUee62L/yos79Vt
         WJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716925162; x=1717529962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAWjwCLmat0Pt42wss/KcevTPw7T7NPDEdWBIi4Ib0k=;
        b=bEVJlIGm2k57T6camhNO1HpY9aiSVq7jqe7Nlc/4hI83GfuXpPJYB61rSrPV5HEtWC
         GsjAOUSC+5TQRMg4xgfiaSM6Hi55PRbL+XSOAySL8wEF/qcswtHy87BsJgS1VQi9RkgX
         +X/5q7wylZO4b8+waVI0LsEEYzea5sbMWpwES13zJ927AWzCcWF5VvU560xkwzWWoNr3
         C581ViIDVj1CAzUIJv8jnwJWCvlgo08UPFfQGSTnPcc8AiJn3g7vUjoZ5CmLIGCM2zQt
         ku/qqeDOoCdQSyOULTcmpObHaIqu5MqniAL9sHYC3EVkm0H3kbLimcG9rchZh8PJxWxU
         N3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWPCVzYbwpMKXYurE4x3vpe5Lezew51cmhx2GY9t+Nt+6n++ovPIJ3v9pUJi9cw9/Kqh7oRauHp2ti9P1q/8sKL+fxY+yIkk2PC9Am1
X-Gm-Message-State: AOJu0YycybuJox1G1ASll6g1ozbjeQLSM3NdPrq8DmUlXH8XO2X+2CeS
	p9GIxrap4N29B2CMDdOarbl39/sWHDraHE3RCfAydamxwqlXF+Gs2Z/XwXqtPCE=
X-Google-Smtp-Source: AGHT+IFEcfUebNH9/3F7+tMGSmm6idGFX/etBkGLAL2JYR2M63YeQM1oJ70p2YpisBnpaZawk1xktw==
X-Received: by 2002:ac2:5181:0:b0:51f:9a88:be2a with SMTP id 2adb3069b0e04-52a829140ccmr9443e87.23.1716925161963;
        Tue, 28 May 2024 12:39:21 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711f96c9sm1045234e87.245.2024.05.28.12.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:39:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 22:39:19 +0300
Subject: [PATCH v4 2/3] drm/panel/lg-sw43408: mark sw43408_backlight_ops as
 static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-panel-sw43408-fix-v4-2-330b42445bcc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0ZNKdxQ3JQtZLj0Gm+s5zrogyXn00ZSW+UEFR2j6wX0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVjLng5Aeh5SVikvcmyAnRHw7p/ThlBTJFm122
 2UcNeNowKyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlYy5wAKCRCLPIo+Aiko
 1fYqCACDlxEKTIMf+LG30I/ejey3MLX/dYsOzRn50AnSqjNYVvRap590vVb8JCAO/9+j/KSr+8d
 T4DAgUGFxwq6LDitmxf+/oQ4ADKYaCLCsnn3jAxJI5DYvDiKXYnXY6Rc3IcjzoQ6bz6mL7/t1wC
 mwRLcPAI/PJdLSms2esDsB98guDvQBNqsRnbpkwPHHwHdukZGq1onHOffn+Duuo69584l9r/zoQ
 JwEJltht3UiIiCeKyZ+MiVA1pViV3CcXIq/yBwiGuqewvjMtDg1sMBCatIlpaTAAX4CtHutzAEu
 SGFXB8p+FvwgGpODO05RIYqS5nLSPhZxdGWjx1coXC+42tjK
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


