Return-Path: <linux-kernel+bounces-171551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B28C8BE5A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162CD2863D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A816F271;
	Tue,  7 May 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Su+zFz2l"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF316F0CE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091290; cv=none; b=XGfrUWPprL0zBgPW5iOJYQ3pMOFpGcepDHyPatbHyayCXQ3cq7PXtifdqGfrJ5EliUGBUOPBGoSSWZjnbMGKTNarEkI5egzHIny6JriV/iAzTTtiVX1JN1t6jlNhLFREelNkH7k+rZvlazmVzK3AFYMnkFru6ze6dJX22uH1cMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091290; c=relaxed/simple;
	bh=QcH+btRFNoWS4TjpLpt+GQ3sskfBxn9Nd4Jm3dRcxGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7o6Cm36lTmW0TX7FIe1HVmJDnYfS/Lg/NZDO6XkKvsNTZwcjVYTRKZn2QwLwvpsJTAFKx6hBaTfMSsv59eOVLLuZJrw8zx123Rl+8VpBbTp6m6G8aJVZ0i9ofybljtfjSiaA4yBOMpECfNZPI/ZacVNzVd9AEZExzempObkZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Su+zFz2l; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59b81d087aso682767766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715091287; x=1715696087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzqUO+Y4mCEkRzT42mutSa2giiTX1rn5tTLc65YmNFs=;
        b=Su+zFz2l86wwrdbf0v7o+iWoFsQtWSKhymbdA37Ly2uXEBA5aN2mixB9NtWUCeSiVL
         Y6nvLQkqfpl10wrc/kXZXRXiROeCoQK8HT6vBxeQYHlurgekC2UuLv2sM8ZJDSvk6/85
         EsjoV9Lv/bKl5b/LfGVgr0W0ocO2VjXfqviqjPD2P4U4Dy227ILEoduVobkPudvbMhOK
         snCTIT3da2qNIQqvR9gmVOHW8DkvTbI71WCD/8qg/vPSY8ng8r7mGjAB6bhBGUW+3ZVw
         TPWiRSsZfG85f6736ReoktKFHp9RCx+uvuy9l0rhqK9ENECmA+p0Wv/vJcxTgRDmU1WT
         Uasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091287; x=1715696087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzqUO+Y4mCEkRzT42mutSa2giiTX1rn5tTLc65YmNFs=;
        b=M6gPAQ6uyHWTwQvN9LWIIhNEa9XwTMyzzdcykw7OW62vC4RaxqJK7ZEboys8pNGlJS
         w1mZ/hf1GLGhhOBLY2XLjnhaja2cmylUuqN94TPW3t6wxinwUVPRrZJBV0HpDLySH99N
         +IVCjVlzS7Q1HmAi1NzSBi2cdT+ymK1BVezVKHwhf+m4d02nokfvz6V0/s7HWECTjcSx
         VQKWgPKoTYn+JxN0PK656y6o+N4xKoMCItgE9nf9E0Au5WRAkXvLNTYb0jt9Xdn6OXrw
         9+2iWTbcCNkE56ProbuD+OZQetwe3NVBwCWl7oxiFsEj+epviqlXMLJr2YV0aPjSB0LB
         V3pg==
X-Forwarded-Encrypted: i=1; AJvYcCXO2LzpRSjOac1rGYIsMQfHi7gH5p6tI/VExPys9Re0w1d6vd7lBp+3aPGOM4dtnJmSD+W9Bh+RekDZO62BN1OvLZdOzJaSvzcRmndE
X-Gm-Message-State: AOJu0YwO8vMkaS4CoXHnFZdZhItWclmk56c3o2Uh1pgzlABWRD7b9UBA
	x/Zfpz2mZom+k69L6EdqlmUQ2+oF1kh9QoUNlBhQJlxusLr8LCx6Hwd4JesZoLE=
X-Google-Smtp-Source: AGHT+IFLbaE7KL4bM9NZleowwf/9bWz6QW+2cO4ZQn/n47PzlsG520bpJ6V/v0rjjw6rNMHBVt1ovw==
X-Received: by 2002:a50:c319:0:b0:56f:e7b9:e67d with SMTP id a25-20020a50c319000000b0056fe7b9e67dmr13463276edb.12.1715091287117;
        Tue, 07 May 2024 07:14:47 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id x2-20020a056402414200b00572cf08369asm5621928eda.23.2024.05.07.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:14:46 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 07 May 2024 15:14:46 +0100
Subject: [PATCH 3/5] phy: exynos5-usbdrd: make phy_isol() take a bool for
 clarity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240507-samsung-usb-phy-fixes-v1-3-4ccba5afa7cc@linaro.org>
References: <20240507-samsung-usb-phy-fixes-v1-0-4ccba5afa7cc@linaro.org>
In-Reply-To: <20240507-samsung-usb-phy-fixes-v1-0-4ccba5afa7cc@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

on / not on is just a boolean flag and is a bit misleading as currently
on==1 means to turn off the power, and on==0 to turn power on.

Rename the flag and make it a bool to avoid confusion of future readers
of this code. No functional change.

While at it, fix a whitespace issue in nearby comment.

No functional change.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 1b209ab7a268..ed4898741c99 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -173,7 +173,7 @@ struct exynos5_usbdrd_phy;
 
 struct exynos5_usbdrd_phy_config {
 	u32 id;
-	void (*phy_isol)(struct phy_usb_instance *inst, u32 on);
+	void (*phy_isol)(struct phy_usb_instance *inst, bool isolate);
 	void (*phy_init)(struct exynos5_usbdrd_phy *phy_drd);
 	unsigned int (*set_refclk)(struct phy_usb_instance *inst);
 };
@@ -273,14 +273,14 @@ static unsigned int exynos5_rate_to_clk(unsigned long rate, u32 *reg)
 }
 
 static void exynos5_usbdrd_phy_isol(struct phy_usb_instance *inst,
-						unsigned int on)
+				    bool isolate)
 {
 	unsigned int val;
 
 	if (!inst->reg_pmu)
 		return;
 
-	val = on ? 0 : EXYNOS4_PHY_ENABLE;
+	val = isolate ? 0 : EXYNOS4_PHY_ENABLE;
 
 	regmap_update_bits(inst->reg_pmu, inst->pmu_offset,
 			   EXYNOS4_PHY_ENABLE, val);
@@ -525,8 +525,8 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
 		}
 	}
 
-	/* Power-on PHY*/
-	inst->phy_cfg->phy_isol(inst, 0);
+	/* Power-on PHY */
+	inst->phy_cfg->phy_isol(inst, false);
 
 	return 0;
 
@@ -553,7 +553,7 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
 	dev_dbg(phy_drd->dev, "Request to power_off usbdrd_phy phy\n");
 
 	/* Power-off the PHY */
-	inst->phy_cfg->phy_isol(inst, 1);
+	inst->phy_cfg->phy_isol(inst, true);
 
 	/* Disable VBUS supply */
 	if (phy_drd->vbus)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


