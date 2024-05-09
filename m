Return-Path: <linux-kernel+bounces-175042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF78C197E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742581F22CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20413048F;
	Thu,  9 May 2024 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2KeVncB"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90091129E75
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294262; cv=none; b=YTc0AUgwvzxkFy8/tDJjgmONQKbcwLLeOo2WlrY0/KtL+KeNAR/iQGip0eoZIL6jm22iMjrxvF/VnnOx07m75clsRg5/PhBtN1bdTJLoigz3ri5TObzKo6WTMDybtfgmET0fmORXpvt47bUq995vyKnNEYEtlQ/Nh9th/in8L/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294262; c=relaxed/simple;
	bh=/ICGqi9rxo6d+dzzW1CgRoe58bcq3pT7pDZm1a8aL8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IC1acvT9WzKmAPqAU9ifYwaatWQ5QYf6enZyRsSOGa4ujFaAl50EJ1DtwvvTnupDhGi4EgTo0H3a5TWYodUvBl2oSN8MRA8zgn4zDItn/P/HO9nR9l0a3Lly2XuLlbwJseH3jBZ0GVTYcRqsAMuXjIEJs9WmuLuyUtAG2XO3sAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2KeVncB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so1511140e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715294259; x=1715899059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPxTEl/rjN+bSOjCHxAgRV15YEB3RII6eshoI73E95Q=;
        b=X2KeVncBnVBLj3kn5H4eNM5welccjNpHiilra53EapqDzvRpNL+b/R+EUmTtE7MmAo
         6cHE5Pgzeoe48YACgzs3tF5MMnsyuyxhXO/eDo0mY4d2mZex6orVm4Q9hgVxcTK8hkq1
         O9LWnjtx4RNZHSmKZp/EkXTgUm+1VB0w/hYpmzwQhYJeXbEexj5HC/JiFf5kvb/wOhai
         6cjsUx0tVRS1ewgz1uk5/APzCIxPuQ0p1ErzmWLOPdH+yanlo5lmTV2ja3VKYZlPg2NU
         eWzHdeEYc+08xTaIu56ioF1fNEJC8qfar9AMdJXl5WGLUfGiTGicFznDS/fSJyjysVJl
         vukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715294259; x=1715899059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPxTEl/rjN+bSOjCHxAgRV15YEB3RII6eshoI73E95Q=;
        b=u2qnfAJdwe5d8TdY1smRZdhJ/90BJ8IpCTXkmhOryurq6F+Id13PFSavbp3NZUomhg
         HSOb3+DBuHwVRX9GUYhDyJPblA7EFqOspBqnunVcE+RNqyx+BhNNjccXp1WDjJe1xH0r
         qxUVzQPS6phSy39ed7wsE1FLSd28BDWuYbxm19R9ahJhTT7RalRu9RsIdhOg7H9NdsqO
         I485p4Y4SHAEoBlumhLQo+84vR80N3m307DDvg0/M6uDJogyxNOMzXX/g95Ky4+5Vo05
         wJ0LUHpvtIkus8a0tLv8AkjCA7L4qyNBsRm3TPDWy/T1UAKzYoZl3fSzWVmy1sOPCG1L
         pbjg==
X-Forwarded-Encrypted: i=1; AJvYcCVFkx5x9ZmsVGSMaxARzVRHoQcAduXIZ6r/TmF8CpKHdglndOAj9fHpaN81J7U2hsdLnjC+VcStKnn0nQXHMCbvvtwnttP98M23QzH2
X-Gm-Message-State: AOJu0Yz1g+rGWwZu+EmrAAjOWffol8qGWuFvWoeYPH5vi+N+3aSrvYpH
	bmbRiSvYDVw2l9nnYz9j6XxKZXG4X/mpsK6nWn7ObrkYsR7Z9ho61lvpN2Fkpt0=
X-Google-Smtp-Source: AGHT+IF3NNf3KZ9S9uBPtp2LgTHFubboDS0GgeBWPRxg1SvUZQS//fedQ5j2Q+2Ujoyni9I7AiK27g==
X-Received: by 2002:a05:6512:4012:b0:51a:b933:b297 with SMTP id 2adb3069b0e04-5220fb6983emr569030e87.2.1715294258864;
        Thu, 09 May 2024 15:37:38 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d32f1sm457974e87.181.2024.05.09.15.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 15:37:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 10 May 2024 01:37:37 +0300
Subject: [PATCH RFC 4/7] drm/panel: innolux-p079zca: use
 mipi_dsi_dcs_nop_multi()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-dsi-panels-upd-api-v1-4-317c78a0dcc8@linaro.org>
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=/ICGqi9rxo6d+dzzW1CgRoe58bcq3pT7pDZm1a8aL8Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmPVAv+hJcCRRz/1N4z/5nZnoSCFPmnaflwApji
 eYhLOpmvgCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj1QLwAKCRCLPIo+Aiko
 1QBmB/kBfZNnW8LsfL5YALIrGr1vlDsGY/TMulRiyB3ma/rYpTdqKUWu2IcP/mVYN5f8PoptNqR
 zmmQx3yamiNeQSO2YVPk8YA99zhDUhm+NFbaDQXYLqgjLyVesZZxyGO4/jB9oWLwMQ97S+WV+SI
 SNKHeE1Bry/mghLEjJE+r76Br3C019t5P57GDJ5aNZoREBMDi5WpR/4D9TS4ToMTsql0/nLAWMN
 OtX894c98lOz+uz6VHWIkaDRywhOKJUBIVDyMxSiYkxQOmr3n2aTrGV9/cnbbzUJVprWsCc0aKP
 LO3pRkNP3pg/29EV/4A+hsP44tCYINaYPPKK0K5vOEemn9NP
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Remove conditional code and use mipi_dsi_dcs_nop_multi() wrapper to
simplify driver code.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index ade8bf7491ee..0691a27a0daa 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -224,21 +224,14 @@ static const struct drm_display_mode innolux_p097pfg_mode = {
 static void innolux_panel_write_multi(struct mipi_dsi_multi_context *ctx,
 				      const void *payload, size_t size)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-
 	mipi_dsi_generic_write_multi(ctx, payload, size);
-	if (ctx->accum_err)
-		return;
 
 	/*
 	 * Included by random guessing, because without this
 	 * (or at least, some delay), the panel sometimes
 	 * didn't appear to pick up the command sequence.
 	 */
-	ctx->accum_err = mipi_dsi_dcs_nop(ctx->dsi);
-	if (ctx->accum_err)
-		dev_err(dev, "failed to send DCS nop: %d\n", ctx->accum_err);
+	mipi_dsi_dcs_nop_multi(ctx);
 }
 
 #define innolux_panel_init_cmd_multi(ctx, seq...)                 \

-- 
2.39.2


