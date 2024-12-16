Return-Path: <linux-kernel+bounces-446996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45E9F2BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D711F1883B88
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0E1FFC72;
	Mon, 16 Dec 2024 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMTz47f/"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5D1FFC6B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337655; cv=none; b=tVKEbOZ1RyncYCuet3lmM/FIr5r/L9TQ9ScTvPRxfdLzdfwspPK4YP35I0ISuaquqzZU5AeIxinLmFbojTID6bRuDY1jDzUedtFHxboZZ2uaQFh8Tiye/TUpfnUc6HjQ7hxpk32V3BnJFn3QOxEkztF1YVKwwjyqjmsMGZ78wjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337655; c=relaxed/simple;
	bh=GNG1YjeHfuMszqIesSKPUebiuLvhN9Xn/3L3ADbn8DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHLdYI4c+WSlbui/n+6ZSWd27g/+gzDGi3VQUbcjhJklxK1Wt/pFEJELoqIaLYWIVwBVw5VCs+pmKRhZS37wbEUfwrrxGAji+DDl4IJc/fjStiareOikoKrjPjPc7ofsCgFTzGgHGyi5ouL2n2Th0CcKidQ8PkHWtpUdc3eguxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMTz47f/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30037784fceso37721981fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734337651; x=1734942451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1y3zws2OvDJOJvn4EwHQ6T46YmVm0fvbHsUMlmIZnm8=;
        b=wMTz47f/EdFPgso0NgXhPGrddaW2xGVr0gL5w8JRvBujFhlC5XJflkkr/hz1WGSsKJ
         8S1qlUdXG13fj74FfAwY29B0xG/GK9xngKCmSdbI2YLMaK3ErzyoGeXiDsEPFwCCl4wy
         OoxTGIV+eo7eyCdT7Gb/5VT45AA7dmYNqGkvRroEUsP+ALH9ToQatXnQssh22vjgVZMF
         3nO9eUoFi2tJM3TCVKbVtJ8jE8lbLr+iFRouzdCuNuJYNIZ7cxrYItPowEunjHAD5r1G
         56jhb+75NvJ21a7KNLJeJ5dSA2q2LiLzvrgCunIlV32kSP00mf5PWz7r5/plKPHWoRoE
         MAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337651; x=1734942451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1y3zws2OvDJOJvn4EwHQ6T46YmVm0fvbHsUMlmIZnm8=;
        b=BPYJ/gYpQxQgzdX3BuHCzpgO+WeCA+Sm8Hl4C6qCCf+bUik6m47mmJLPbx5rHyRB/Q
         KgqJQAzfHHYzaAt/qHQiTZr3iN+KYiAvTrrLlymKadHv3yZYTgLBGlyDEkg+VTk/nYrT
         SFUFV22eLkE+eqBOlVgAh11IHsPDjMeKWv0aYJX3+0y3PLeLlZhe+e/Z1EHTbpPQpsZ+
         k13gW35ifrrLGDDPK8A/qWoIOLQXSFDdl09QZabbexc9alFzdLAC4U6BEeZ1HIAx/QKJ
         Gx3QN76coNCovM8fFpx0L1Utl42OAm6cuTmACwrFFOHe8632q23cq97a0y+B4OUzXeiy
         xxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMmAHPGYwnEaG4FJtEz5B7Mcz1MoTFOo7UyLJAyWyEygNXzMqxPljXkL9DLw4jUWIrUzGZzk9ngf+Umn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XV7TnZxFJwmW994u/YlF+qampeeyRTLyWkJjM5dOv6A/n/9U
	R86bq98okO01ziGE1abus4g9jnwTgcBqUqfycztNY67f+1aML6Taila1CdswhHg=
X-Gm-Gg: ASbGncuxdSZvY+9exEUxjCXRZBtWGRR3mevzm1A1dFQtgPwdUuz/pesjX6m00TP7/8/
	oIPx3XI9ACZuGzyLwTmLpt7u0jO4Sn45ua5IQZCIXYaFuL7IXI3xwdcaOsfpIHbTzwGiAp6HL2Y
	OybtN8+SvEMmu/HmkowGj1U/WR6mM/ZKZ8Kruv4BPHIagtV8flgMPNqOkY5FFM4jo8ETlXS3ZEC
	lozFhnnFiB2kMX9Z74M5rCqYWbabMRDhW9wxBZit3p8YaC0BPEGuJe/+PRVwHvV
X-Google-Smtp-Source: AGHT+IEzJ0NEoETgA7c8ba6XyTQ/DzGVN/VS5aRCw2hY/b5fwtTAbAtRpZytYulUjtMOAdHNJr0JqA==
X-Received: by 2002:a2e:a989:0:b0:300:2d54:c2ae with SMTP id 38308e7fff4ca-302546115demr45480641fa.27.1734337651302;
        Mon, 16 Dec 2024 00:27:31 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344045342sm8543371fa.33.2024.12.16.00.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:27:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 10:27:23 +0200
Subject: [PATCH 2/8] drm/msm/dpu: link DSPP_2/_3 blocks on SC8180X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-dpu-fix-catalog-v1-2-15bf0807dba1@linaro.org>
References: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
In-Reply-To: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Richard Acayan <mailingradian@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=GNG1YjeHfuMszqIesSKPUebiuLvhN9Xn/3L3ADbn8DU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX+RrE/1t7QKrO1i15J4Z2UkK/SQyKBi/FHqf9
 nl4CVCFJu2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1/kawAKCRCLPIo+Aiko
 1aq/B/9wOMO2d+TGtOtYeWqt92iBk1GzTfpG0xNYpmbvSaiR55N0aFWclXEzgT4g2cc19vzzryv
 c41PGKSpiK5qXbnkhTcLfOqc/UVycrEYNAlzrGUaZW0vL7Yx4UerVgkBozAW5y04OEUYoZpiJYr
 MjMEURWwYOhGMkdOo7Wl5S5plX1JOwXrlZQkJt6NsAJ3lUv98ms/VamgWhKTarJqESXw46g21+F
 /qWNUK+XC6tSfqqjtZks/sIgGxMbfOAIRdPJJnCt43I9wNX9Ng4Kxc9Lc1uG5zTwzw2A6Xl5VEg
 ABGMRPo83JhPnmTajrbbslOPzjGGsAneXND3EH99hJx4QC5G
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Link DSPP_2 to the LM_2 and DSPP_3 to the LM_3 mixer blocks.

Fixes: f5abecfe339e ("drm/msm/dpu: enable DSPP and DSC on sc8180x")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index bab19ddd1d4f97805c1bfba8ba6e117ae77c6c2e..641023b102bf59352546f0782d9264986367de78 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -163,6 +163,7 @@ static const struct dpu_lm_cfg sc8180x_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -170,6 +171,7 @@ static const struct dpu_lm_cfg sc8180x_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,

-- 
2.39.5


