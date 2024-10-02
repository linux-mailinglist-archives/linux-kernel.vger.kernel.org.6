Return-Path: <linux-kernel+bounces-348202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A01898E40A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BD51F24395
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85A72141BF;
	Wed,  2 Oct 2024 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BA9vEDTU"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B221730D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900180; cv=none; b=NjTKoT2x9mL6JQaToGCSWTArnWS8ZugFD7MAq4q2ec9IWhjZG/vgEZDoQJ8WzOZNSSi92STZL4pmlk0OMZDngepu6cTDsn+7DThk/KRiPgZxi5NH21yYz78ZztZV/DmU4w1ERkCWBuZPmWRziPyULghtimGOraU9201CoIK2pyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900180; c=relaxed/simple;
	bh=YFzA4DYtVbMxncovgmTezhmhuyWgqyPknSi8zHi1MWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/FuKkThdAsV6TdG67S/dAiNQ3p7fYB3haCPiZqOneeVvt0qR2uzq5SjL8F6Q4VRbNz2zr/Hi1s4N3nXFm5fdsJhpleYJrQg3MNtgvnlUJlLVaeHneM6ar5DWPoWKdqTscbi8R23Dvr/3Dyjj3m0Dilmqtn1Bf0/hlEH2FwxGaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BA9vEDTU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cfa129074so146791f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727900177; x=1728504977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkN9NRYd/noXKwaQRmVmIrVpTjpJo3NEqWIDvcUXohk=;
        b=BA9vEDTUZxzLYgp6qwopuXK21pJJje7qTq4ha89PVQ6g+SU/91dwLdgq8WcHswxjwV
         +fRqhbvkY7/aoZED+OP5DY0LAe3HrvuhD/MOPNwM6K48HmYaeELMEovKM9t+OWnWEiGx
         1o198/+JkvBQUIP4DgSTmblIp7MtBNFPCmF2G6EyR2j+Sj6S/Xx/QL1nXXoPMXDYzXPh
         wIvWlXQtVA1sVvATfCTuAY9JEm+/8YO3edWLexuM1WZWKs6+BC3moQonaoFp8YfyIRT5
         7ObLTNlUBdh6+IxlrIDlMQ8MNeXyqdF8rt33CIuP6IShdALstGoCdDOx19JQs94HEQss
         Dzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727900177; x=1728504977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkN9NRYd/noXKwaQRmVmIrVpTjpJo3NEqWIDvcUXohk=;
        b=wSiIp48JvwkB1k0EvMZxi7iD5RlMOYxFp6sQxEr6Eq9iDyoFXwiXnmwkSO7DODFUy0
         Y+Dx6hKatXw8rah/4jFE20awUZzCMXaB/UfjZM0/fRlCAIMFKXfgBh4WUW4mfyRT2G5Q
         Zj7c9bK5aP4HcshqG6Ml6V5LJjjfHtklmyxXarHjoFEXQXUiqrJ7lGiTxfYrjCagK4/q
         z4y1QnM2zwxQozaHtQxv6eVgGlQQnNZ3/tgAm+UPjYtxVBJxF1jJx8FLTX74QTP+dvE8
         gOhpF3/mZjSRRIvrLmBpw2CiBBrq2yDWX+4QHtnFnqzhr1YSp5RsUFbD9IcKjOCgnrQr
         IJlw==
X-Forwarded-Encrypted: i=1; AJvYcCWl8DicBXC0jVgomug4KXG+jpUwONabYnkZQM6tQxCeabhAwOyxZ660YSDb34KY1KvKo4MxJGaHL/wB51U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sWhC23jhZ3/83D+hBrG2y0A0+pwRAhFfbWNrPxo7+nABYf8G
	taa28A+b5OY2+kOAWmX6Rmldi1y/ot52ZDEHcSYN7eiyAZuVCurHa5GWv3qEUJk=
X-Google-Smtp-Source: AGHT+IFwyFuXYth7A8vslCHMAnUaIkp4wEUm+Zkv+c4fkaTohWk+qBC9lfK+MVzuhuapcRpBsdVkkA==
X-Received: by 2002:adf:eac9:0:b0:374:b6f3:728d with SMTP id ffacd0b85a97d-37cfba07ac2mr2755315f8f.46.1727900176783;
        Wed, 02 Oct 2024 13:16:16 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.66.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d2e8sm14850600f8f.18.2024.10.02.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 13:16:16 -0700 (PDT)
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
Subject: [PATCH 3/3] phy: samsung: gs101-ufs: Add hibern8 enter and exit specific tuning values
Date: Wed,  2 Oct 2024 21:15:55 +0100
Message-ID: <20241002201555.3332138-4-peter.griffin@linaro.org>
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

Add the gs101 specific phy calibration values that need to be programmed
when entering and exiting hibern8 state.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/samsung/phy-gs101-ufs.c | 31 ++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/samsung/phy-gs101-ufs.c b/drivers/phy/samsung/phy-gs101-ufs.c
index 17b798da5b57..5363d8be6c76 100644
--- a/drivers/phy/samsung/phy-gs101-ufs.c
+++ b/drivers/phy/samsung/phy-gs101-ufs.c
@@ -108,10 +108,35 @@ static const struct samsung_ufs_phy_cfg tensor_gs101_post_pwr_hs_config[] = {
 	END_UFS_PHY_CFG,
 };
 
+static const struct samsung_ufs_phy_cfg tensor_gs101_post_h8_enter[] = {
+	PHY_TRSV_REG_CFG_GS101(0x262, 0x08, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x265, 0x0A, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x1, 0x8,  PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x0, 0x86,  PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x8, 0x60,  PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x222, 0x08, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x246, 0x01, PWR_MODE_HS_ANY),
+	END_UFS_PHY_CFG,
+};
+
+static const struct samsung_ufs_phy_cfg tensor_gs101_pre_h8_exit[] = {
+	PHY_COMN_REG_CFG(0x0, 0xC6,  PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x1, 0x0C,  PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x262, 0x00, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x265, 0x00, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x8, 0xE0,  PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x246, 0x03, PWR_MODE_HS_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x222, 0x18, PWR_MODE_HS_ANY),
+	END_UFS_PHY_CFG,
+};
+
+
 static const struct samsung_ufs_phy_cfg *tensor_gs101_ufs_phy_cfgs[CFG_TAG_MAX] = {
-	[CFG_PRE_INIT]		= tensor_gs101_pre_init_cfg,
-	[CFG_PRE_PWR_HS]	= tensor_gs101_pre_pwr_hs_config,
-	[CFG_POST_PWR_HS]	= tensor_gs101_post_pwr_hs_config,
+	[CFG_PRE_INIT]			= tensor_gs101_pre_init_cfg,
+	[CFG_PRE_PWR_HS]		= tensor_gs101_pre_pwr_hs_config,
+	[CFG_POST_PWR_HS]		= tensor_gs101_post_pwr_hs_config,
+	[CFG_POST_HIBERN8_ENTER]	= tensor_gs101_post_h8_enter,
+	[CFG_PRE_HIBERN8_EXIT]		= tensor_gs101_pre_h8_exit,
 };
 
 static const char * const tensor_gs101_ufs_phy_clks[] = {
-- 
2.46.1.824.gd892dcdcdd-goog


