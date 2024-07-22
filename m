Return-Path: <linux-kernel+bounces-258888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34CB938DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109921C2119B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5716CD11;
	Mon, 22 Jul 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cphgk2Sn"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5316A94F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645876; cv=none; b=NfrXJTApFXddQW7AMXuMV1hr63HWOdRzesDZwITTTGd2yXQVTItROSLYj1HpK4tqxP69h9Zpft0LuahrFKRhhz5iwbQHwNAzvb7KXEKw8AcQI0VFwwioDKbE7R4HalpaxkULvnAdhDjM0qmBV+RaO4sZieEvF/6gZ4RI5D8l9jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645876; c=relaxed/simple;
	bh=OI9ivS0KG2RvRIz9Kdlx0Ag7Wy1NAEIIjtXE0CRf7TE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GDNrRVbmpoM2pUPOvKURKWOn8Jf+LtUfYmSQnyXJ+CD6edRGrYdme8MG41syIC9OP9GVCY+HbsbSLMLLYFmN21+nQoXaeWE5+M8J69VaQdJLJfUQ4BXikc7Xg3jCm8QnSrI8YVS65cEwMwpArEevWSl+kpLjFEzCds2gEGHWdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cphgk2Sn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so455287a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721645873; x=1722250673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlyfwInqQ9SWjZNJvK5iqTVzQocr8JHKV8CHQ/SRg5g=;
        b=cphgk2Sn8FgSirVCSUkbTISzl778IHcWbKE2JBMnLzeFontkbCOzxGE9hcPHzsWZTx
         2iHZP2Zc4WOkcodyvtzuj3CSYi2fV+49SE/rNqxPG0VpbqZbAvNyECeueF6cbT9Ozn+F
         V7eBy67avkyhinp3+iR6nOaLD+1+5uFpQMedKvDpZ4puwiN+6ZBiy1yzBpdjv+1H45Ae
         Jt9opuzvuEcoLlwtgJZ49A5d1OMck/OO2YsxJ2z3CvBTiTtawZ0/tEWw2X/3ltTByeXH
         pxFTFENjeVUE3TVE6QEUOz9O4uaacoRz1Iyu1sHEnRf9nqnhRZ8byIJy7Wi10NMk5k6t
         L2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721645873; x=1722250673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlyfwInqQ9SWjZNJvK5iqTVzQocr8JHKV8CHQ/SRg5g=;
        b=hMvxz4J4ykIu1Q/nmnZCnwiXLgIcomtGuflt3WlxBxlZXI2yyOMRbd18yEH0FGpjIE
         QZ2nNx5uMaqzT+jw2uew1bOrQtL0TLbuDNi92T9FB6pEUm93rUB3NaR2dzel3p3JMSXg
         qStlGl0ofSRC04+u9hi+Bz7X2FzotCYNjbaxXinv6mFYht+MGEIIjtweEKxp9gcM+XQ/
         i2NBjkHjkfr/Oc3LIm9q4PSbJ+mUv+u+s7FxbDWpfCi8rjF5JCRFegickVlLqB9O6wEW
         2w7HESDwGxU6u8ThBPlZbWJGyMjICNMW8biE6Ji3di6MtUlLpNVO2AN17WGfd2hutOig
         /FeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXtZAPPqtO6bSgvJ/lw4Ya3Y2EyTxJxP36j4P4pUJUDalcIlOeAwjLDBVJs1vu4VJT++eVKTbHLOMxXUVFNxm0ss04MG1KN8XRjSe5
X-Gm-Message-State: AOJu0YyZEwKkRhcvPaAZxJ5D47FIWoaZ/UUNgITPEPRVdHzAdvS3BxzU
	q3qtyrZ5Syt8Ht2aiYevPt8lqgVUplXQRlcPxEPmcCTzPOZQ5koiP+F+j+3D0g==
X-Google-Smtp-Source: AGHT+IGzSZ/AeiRRay9oWlzAsexbnmsYckOBqmIpeLDEUB9QOhiN/310nuLGsNRvsdmRD1v3mLFznw==
X-Received: by 2002:a05:6a21:670d:b0:1c2:8d2f:65f4 with SMTP id adf61e73a8af0-1c4229a42fbmr5153409637.44.1721645873135;
        Mon, 22 Jul 2024 03:57:53 -0700 (PDT)
Received: from localhost.localdomain ([120.60.138.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf808f050sm6683862a91.45.2024.07.22.03.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:57:52 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-sm8450: Do not turn off PCIe GDSCs during gdsc_disable()
Date: Mon, 22 Jul 2024 16:27:33 +0530
Message-Id: <20240722105733.13040-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
can happen during scenarios such as system suspend and breaks the resume
of PCIe controllers from suspend.

So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
during gdsc_disable() and allow the hardware to transition the GDSCs to
retention when the parent domain enters low power state during system
suspend.

Cc: stable@vger.kernel.org # 5.17
Fixes: db0c944ee92b ("clk: qcom: Add clock driver for SM8450")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/qcom/gcc-sm8450.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 639a9a955914..c445c271678a 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -2974,7 +2974,7 @@ static struct gdsc pcie_0_gdsc = {
 	.pd = {
 		.name = "pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc pcie_1_gdsc = {
@@ -2982,7 +2982,7 @@ static struct gdsc pcie_1_gdsc = {
 	.pd = {
 		.name = "pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc ufs_phy_gdsc = {
-- 
2.25.1


