Return-Path: <linux-kernel+bounces-247100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8E92CB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213A41C224E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501EE7581B;
	Wed, 10 Jul 2024 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRVpibdL"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70D24A08
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593921; cv=none; b=R8d/Edki+A6zYWzC75buXhxckOTS97MB2vZDACJHMFVpVt+PBYco40GbvJ8QE/nQ6omAg0la494KKDxLcs14zkGwVvQHe0r6cqp0NRd0HeW7RZn5p3k6dpXNb21OckfEXVdGgNf+8MgOD48XVgkLxtRJUsZcQ+UU5xJw9CQbrO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593921; c=relaxed/simple;
	bh=b3Wexf/9lut/LUtyb3GEMQrMT5qsMZ/VXrXaUdAmjts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G/V2ikVc5xhx5OfVrjJiS50SAFQJE5EjAL18LaF8mi5/SdLzudDZS7yae+I8/vLRA/uKcYWI9edFKD1gNNg2GlscG5LOGQMTCpl4g2xg5h9cG5ce+LjUQ2wem/o9D9A4t3YwASEypfBHp45Sz6rATNbPiPjOdmpVTot3eUqCaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CRVpibdL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77bf336171so89718666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720593917; x=1721198717; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aZECrEA5tQWlK6pbaSqNy3VIVWi6gzN6CRcwSGtkk8=;
        b=CRVpibdLDvDZbERDK+5NllLdwSsccseZ6HMUn6OjoEV0jKMdaKuzoPqZU4b680tOmx
         K5eZu61aJa7hxLtE1lcYwV0PxdhaNgKAQ0/bXs0tBzqhRs+PuOC0yvXoRu3MUiHEMx6I
         84k7UV7fzdA7NWvz2lRSDQWeAfn+5S4kfv32ZUoy3tgbIczBa3GsskYNVYuLkrH/8Wst
         2pmOF3Eh8vraztUEe1svNlbMb8jHQPS1188RA7nIgsdq8JYOymhsiUq6EifAyFwKFOKv
         XWkanaSDpMkJDUaWrNKQGXOCYjMZqDAxNIgUVbsfCxzSm2kDw6r2xjBsviQcvdHUEItb
         OUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593917; x=1721198717;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aZECrEA5tQWlK6pbaSqNy3VIVWi6gzN6CRcwSGtkk8=;
        b=VFT85shRrjFmoDkKSwIfi5XFBP3Wxtb4A0TOZ5xQgRYw9Dktw121CAr6Rck0J9ctPC
         s48qwnpSLeoOnseWJYWVA2Jb/T/CEgmSrawYuiojn5NBXGbFMwjI6XsycdnjMZxSTDLu
         tP4AE59wjX6p9SJS+FbfbWeIV423aPz9PpcZFwCg0RTyxgaem9xB+rgpNnE4/ARcJGV5
         9WuRhKrqTkuT8uZkkW4cZmy1nB/qXRacAI3D/PVo56+oe6uiBOxTWFDParv2qQ0p71jI
         9D5nPDIKnkBK8hfcZCT4f4f6NW6hL9odIzW3JN1fpTq+X0qc/D/40FO+HnDsfrb2xuu4
         9hKA==
X-Forwarded-Encrypted: i=1; AJvYcCVPuU4IF3JBKrcjVWwr/uigTr+Pff8Dp3MpBG2FMlFPa0FYocy/hZ2T+lHN72mMMPsTMR6L+uIze2eyMLhROFnk2sWwCBQE5V6Fy4su
X-Gm-Message-State: AOJu0YxT0oGE4pOBVo3IRZv7dyjd3WfqPYyv7wWQIzC/EMCwb59xVVbt
	cSjRTv2N3nMSd41n/rth2Zl4BijqALZlA3jj+XDP4ky+HlslWqiRV1So2MpYz50=
X-Google-Smtp-Source: AGHT+IHw00t1Zg30xrx1hACKh7awa0kbStIosk2q3dxs2TJLXa5CTmZFvqt9t2YMS5YHAWLuzCeAww==
X-Received: by 2002:a17:907:60d2:b0:a6f:e0f0:d669 with SMTP id a640c23a62f3a-a780d218c40mr341081266b.12.1720593916943;
        Tue, 09 Jul 2024 23:45:16 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a86f620sm132214766b.209.2024.07.09.23.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:45:16 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 07:45:07 +0100
Subject: [PATCH] phy: exynos5-usbdrd: convert some FIELD_PREP_CONST() to
 FIELD_PREP()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-phy-field-prep-v1-1-2fa3f7dc4fc7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPItjmYC/x2MWwqAIBAArxL73YLay7pK9FG55UKYKEQh3T3pc
 wZmEkQKTBGGIkGgiyOfLoMsC1jt7HZCNplBCVWLTgr09sGN6TDoA3lcqO21MpVWsoEcZbnx/Q/
 H6X0/orbl02AAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Use of FIELD_PREP_CONST() was a thinko - it's meant to be used for
(constant) initialisers, not constant values.

Use FIELD_PREP() where possible. It has better error checking and is
therefore the preferred macro to use in those cases.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index df52b78a120b..0cc5c4249447 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -607,7 +607,7 @@ exynos5_usbdrd_usbdp_g2_v4_ctrl_pma_ready(struct exynos5_usbdrd_phy *phy_drd)
 
 	reg = readl(regs_base + EXYNOS850_DRD_SECPMACTL);
 	reg &= ~SECPMACTL_PMA_REF_FREQ_SEL;
-	reg |= FIELD_PREP_CONST(SECPMACTL_PMA_REF_FREQ_SEL, 1);
+	reg |= FIELD_PREP(SECPMACTL_PMA_REF_FREQ_SEL, 1);
 	/* SFR reset */
 	reg |= (SECPMACTL_PMA_LOW_PWR | SECPMACTL_PMA_APB_SW_RST);
 	reg &= ~(SECPMACTL_PMA_ROPLL_REF_CLK_SEL |
@@ -1123,19 +1123,19 @@ static void exynos850_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
 	reg &= ~SSPPLLCTL_FSEL;
 	switch (phy_drd->extrefclk) {
 	case EXYNOS5_FSEL_50MHZ:
-		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 7);
+		reg |= FIELD_PREP(SSPPLLCTL_FSEL, 7);
 		break;
 	case EXYNOS5_FSEL_26MHZ:
-		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 6);
+		reg |= FIELD_PREP(SSPPLLCTL_FSEL, 6);
 		break;
 	case EXYNOS5_FSEL_24MHZ:
-		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 2);
+		reg |= FIELD_PREP(SSPPLLCTL_FSEL, 2);
 		break;
 	case EXYNOS5_FSEL_20MHZ:
-		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 1);
+		reg |= FIELD_PREP(SSPPLLCTL_FSEL, 1);
 		break;
 	case EXYNOS5_FSEL_19MHZ2:
-		reg |= FIELD_PREP_CONST(SSPPLLCTL_FSEL, 0);
+		reg |= FIELD_PREP(SSPPLLCTL_FSEL, 0);
 		break;
 	default:
 		dev_warn(phy_drd->dev, "unsupported ref clk: %#.2x\n",

---
base-commit: 82d01fe6ee52086035b201cfa1410a3b04384257
change-id: 20240710-phy-field-prep-be6982d38215

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


