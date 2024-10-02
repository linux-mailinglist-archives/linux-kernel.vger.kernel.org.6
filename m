Return-Path: <linux-kernel+bounces-348201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3BB98E408
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0635B1F2436C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CE1217324;
	Wed,  2 Oct 2024 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1Lx0fic"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B5216A26
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900178; cv=none; b=McsK2noq0jAzyUwAJtSJV2i4SaGmGhMoROSQxarcJFQGJ2dGj2xz6qR6SXrHFZlSiar02lTgnlJbSaAZXlBifdTRFOFuYLON00ZOUTzOuOgH2MlHWDeIytMzYYE2cmB9PEiUVOdwdn16DsdwYzpMouybLQbQSuPZhr903UcQ698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900178; c=relaxed/simple;
	bh=dXlbjZd+8YKtogCZ/dJtTJwwBRivMwtGgcmgRCO2fgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4TV5d52WSqK9IKl4jyID+Zk5kESfJbdt9oKmvO2J2VBgz8qqgPEb7ob5l7GxSik4WpQxPEF6Al8vFajsqXpJGlHqu0il0eGDmgbo+6Vm4W/VfiXCNAcuUfzY/IohBFrHHIMPO4Y3v9hP0h3HvDozLiVMeI+mEV59UlQUYEkgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t1Lx0fic; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so1206425e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727900175; x=1728504975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grqdGWxVlr6gg9Igkyge2iFlQEJRxUTK9OOJod+O8as=;
        b=t1Lx0ficGeXmAdfHUPa07dgNpJpmUOmPRNKv4huJcXPclo3o7yyplnZB+iquFqfkwq
         7B6CVzaaDKlBUpYGwx1uFz8dvcYFO0kkxQ0DWxqyfShthodktnlVjHxLDQusgnok3dkr
         MEOJ+lTtzt0N+QXll6Mj27FciBcqqj4d3tWVbo0Z/o5gcaJR3r2C+EI6KhrydDtNNK1H
         a6Qq3ouuQl7QYOm2K1b+CAgY6/wE8oWFlGnb1075uF60KtBFezgyLGuawjXZrElp2vjM
         iRuYiGHmuKRKK0h5ypM3LaupDBfF/AsVzsLmk23RSkKuJ6XL3ptRNPLXs/6LLLKlksBb
         zUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727900175; x=1728504975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grqdGWxVlr6gg9Igkyge2iFlQEJRxUTK9OOJod+O8as=;
        b=vYunYA8MwaWIwYiH1Fuml4SmtSZRUlBdAR10eGitqDScPh8u1x7Fs35xD5ZlTUnuRG
         c8ncFpgxtEVdnVxGXh4fKybnq8N8oQ6uEkkaUHdDbHGZv+eLIohixTxwuh2DoK3/i9m+
         bzc8ZjZRYL5lyQSOvE7I+rpz0l6NO2aVAxRmZgMnxofCeJbL9Sf3utOGHnEre/usF7DO
         jh0sAi+bay2AjXFmzUtbwH6afhvWLEJq4i9avsuiEeLEDMpXJ5kAryknJfFkODqCt9Sw
         g6ehOxpqQPZzvBTtioMZlUzdSa4Q0MQEXeiImJqwNAxcpA5p46s9673jIpqtDkIWroH9
         sL4g==
X-Forwarded-Encrypted: i=1; AJvYcCV9vViMK9swkKKXc0cLHO7z5EFxyrzXrx2Cb6Q+EhRmPFqoipZ5HA1RBMZ574HIqlySPhBWeNQMsKGPLcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXHDf2tu2dkRf7X9GXvFieT/nfOnxWDi0xudPFiQX/o8+yUhe
	Pr/vTsllhIZuMpp48lFJX3/cIFC3IaInu39vJThFxEGOGH7vMcVGEa0sylyIYC0=
X-Google-Smtp-Source: AGHT+IEQc2WmlGwouFQBkWQzt6fGr5tg/HyKqMkIdRZTfK8Hcv4Eq8Fi6eRvtniBCRuj83IQhPoGdQ==
X-Received: by 2002:adf:f285:0:b0:368:37ac:3f95 with SMTP id ffacd0b85a97d-37cfb9d32d9mr2626016f8f.31.1727900175454;
        Wed, 02 Oct 2024 13:16:15 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.66.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d2e8sm14850600f8f.18.2024.10.02.13.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 13:16:15 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: vkoul@kernel.org,
	kishon@kernel.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com
Cc: tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 2/3] phy: samsung-ufs: add support for HIBERN8_ENTER and HIBERN8_EXIT
Date: Wed,  2 Oct 2024 21:15:54 +0100
Message-ID: <20241002201555.3332138-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241002201555.3332138-1-peter.griffin@linaro.org>
References: <20241002201555.3332138-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new states CFG_POST_HIBERN8_ENTER and CFG_PRE_HIBERN8_EXIT to
the phy driver which map to the new PHY_MODE_UFS_HIBERN8_ENTER
and PHY_MODE_UFS_HIBERN8_EXIT modes.

These are used to program phy specific calibration values when entering
and exiting hibern8. When exiting from hibern8 state we also update the
logic to wait for cdr lock.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/samsung/phy-samsung-ufs.c | 18 ++++++++++++++++--
 drivers/phy/samsung/phy-samsung-ufs.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 6c5d41552649..7162ae5c7bc8 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -87,6 +87,12 @@ static int samsung_ufs_phy_calibrate(struct phy *phy)
 		return -EINVAL;
 	}
 
+	if (ufs_phy->mode == PHY_MODE_UFS_HIBERN8_ENTER)
+		ufs_phy->ufs_phy_state = CFG_POST_HIBERN8_ENTER;
+
+	if (ufs_phy->mode == PHY_MODE_UFS_HIBERN8_EXIT)
+		ufs_phy->ufs_phy_state = CFG_PRE_HIBERN8_EXIT;
+
 	cfg = cfgs[ufs_phy->ufs_phy_state];
 	if (!cfg)
 		goto out;
@@ -105,8 +111,9 @@ static int samsung_ufs_phy_calibrate(struct phy *phy)
 				goto out;
 		}
 
-		if (ufs_phy->ufs_phy_state == CFG_POST_PWR_HS &&
-		    ufs_phy->drvdata->wait_for_cdr) {
+		if ((ufs_phy->ufs_phy_state == CFG_POST_PWR_HS ||
+		     ufs_phy->ufs_phy_state == CFG_PRE_HIBERN8_EXIT) &&
+		     ufs_phy->drvdata->wait_for_cdr) {
 			err = ufs_phy->drvdata->wait_for_cdr(phy, i);
 			if (err)
 				goto out;
@@ -137,6 +144,13 @@ static int samsung_ufs_phy_calibrate(struct phy *phy)
 		/* Change back to INIT state */
 		ufs_phy->ufs_phy_state = CFG_PRE_INIT;
 		break;
+	case CFG_POST_HIBERN8_ENTER:
+		ufs_phy->ufs_phy_state = CFG_PRE_HIBERN8_EXIT;
+		break;
+	case CFG_PRE_HIBERN8_EXIT:
+		/* Change back to INIT state */
+		ufs_phy->ufs_phy_state = CFG_PRE_INIT;
+		break;
 	default:
 		dev_err(ufs_phy->dev, "wrong state for phy calibration\n");
 	}
diff --git a/drivers/phy/samsung/phy-samsung-ufs.h b/drivers/phy/samsung/phy-samsung-ufs.h
index 9b7deef6e10f..b42ed586aba8 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.h
+++ b/drivers/phy/samsung/phy-samsung-ufs.h
@@ -89,6 +89,8 @@ enum {
 	CFG_POST_INIT,
 	CFG_PRE_PWR_HS,
 	CFG_POST_PWR_HS,
+	CFG_POST_HIBERN8_ENTER,
+	CFG_PRE_HIBERN8_EXIT,
 	CFG_TAG_MAX,
 };
 
-- 
2.46.1.824.gd892dcdcdd-goog


