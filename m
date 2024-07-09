Return-Path: <linux-kernel+bounces-245949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1F492BBBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A5B1F23438
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98DB17FAB9;
	Tue,  9 Jul 2024 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="rFhzhbGG"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8017995B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532908; cv=none; b=fumQ313IO1Z8oH5xJ7E8hrKvPylWwhLZi1JVl38vcw9YZAFaY+tCqWD+ymbQYBi9ZkmGjsBZFFDHzVPDrkV1iAaIcI1TShB3Oo3PdSeswGpaDrYa56bClcm2JKICru+pIvWj3ugFLThO6NGT6yYcd7Hbj2YNPvLxFiCnCsMKnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532908; c=relaxed/simple;
	bh=pYPTNY8X4IxGHrR0aSERyjf84J9xMrNFhAnJJZV75Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aK2cMkemHMRBB+X62M3IIY5evlF3DXiioGmRHUvnAWyYnXuf10f0fpuT/Pj9gRnS0P+/3eW3b1WoxbqvufWSzWuBrwBk5zrf2bTV2G0vyENLZuhgbUq5hIe9dbFAdAutvEmgEQ+BbSLXK/8u/6C4EIfVaUYcDDbtt5S3le9F/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=rFhzhbGG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb64d627b0so14225665ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720532902; x=1721137702; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EcZGfscxWH1cfj2JazAFXoJC02WpocVggpq54m1oHTg=;
        b=rFhzhbGGNorhXYF/A5bwxIO/XkFdwTiqdKRPSUG/Y5uxbEr8UTQ9lQ+UWtBbu0Bjyl
         xlXPVIDN28YM3FtFXdzSQyO2T3+DP0UFFq5Kk7NsEG7e+ZHypP+IwfkxrJAYzQ5/r8bb
         RlVtFBjnFQuniR5qAuxTgvGEx6lqh7IGCgbr7GRarG7DYDK3iR9yKOUo3JPTn2jpQvmy
         lu51t39ktT3utHuC1Kt4/pJAfK8zpnytutSF0yviSJi4OIfdJdDCAfG1AhGzOkim9t2r
         Rl+UlirOf9f+uJWE+sGyLwJ+LIHfw3yBAdTUPRORqv8A4LmeKPpvgJ5OjQJ5iWHNyOrR
         t1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532902; x=1721137702;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcZGfscxWH1cfj2JazAFXoJC02WpocVggpq54m1oHTg=;
        b=wvST9ZzPlVCM+KvZeAkdKlThjM1gN8cQ9TGIOaODQ91mc8Od+PboiFmhsoYTQfFe0b
         Q96yTuFOL5gMOXk8jWIzEz1C3th+fvjnryjnK9FC+/plu006701guMXuVdiGm5ed8tto
         JfjBRq0+kbDEDOu6kY+60LBpDLsE2S6PSZuPQKNicuvoe9vwCNvLPHgw/uZBWtKHOMk2
         pKW4rMRyfxAIkmLTM+z5H0+sfPiwjwaTSYYvffTNF7rj1JsXEdHC0cqSlv9d5cx5Awr7
         5ASPxzBnfIMT15jv8m0dOKAka4/cpfzl4H7e5lfA42ljRqYfgNzGc2snzd5232OpaHZg
         Kj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSxPuBI5nI1HAm/V6JsPxOMMtKjlSbR3gNG+W/sXL2vT5JexK0clnFChGrFL4yTTXTut7JwT9ba+IhCXBYZ+Wf1T6ZspPICVlue7Ol
X-Gm-Message-State: AOJu0YzdnpckejcHRw+oLUNoKiHD2Y/0ixhZlmK/2TftuClzxKcIeJ6Y
	h+hrrRYAlLz3N2ikoZ95e5UfhhtGNK7QsJ236I22FJ03tSd08IX1pyiuWBoyhYs=
X-Google-Smtp-Source: AGHT+IFX21o+X3VwRasdQwyrEqH0PuWe1B+40bbzeOg94dAYx5KftRVmTty5gE2r5cIfdyuv5HR6pw==
X-Received: by 2002:a17:902:d552:b0:1fb:90bd:afc2 with SMTP id d9443c01a7336-1fbb6d2516emr17327055ad.36.1720532901816;
        Tue, 09 Jul 2024 06:48:21 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6b9fsm16211685ad.138.2024.07.09.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:48:21 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v6 2/5] drm/panel: boe-th101mb31ig002: switch to devm_gpiod_get_optional() for reset_gpio
Date: Tue,  9 Jul 2024 21:47:51 +0800
Message-Id: <20240709134754.28013-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Switch the driver to use devm_gpiod_get_optional() on reset_gpio to avoid
driver probe issues when reset line is not specified.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V6 and V5:
-  1. No changes.
v5: https://lore.kernel.org/all/20240704072958.27876-3-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 8f03920e3503..b92082bfc932 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -286,7 +286,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->enable),
 				     "Failed to get enable GPIO\n");
 
-	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_HIGH);
+	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->reset))
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Failed to get reset GPIO\n");
-- 
2.17.1


