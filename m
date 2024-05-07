Return-Path: <linux-kernel+bounces-171550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691568BE5A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A13B1C21D45
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852716F0D2;
	Tue,  7 May 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/zUVdyn"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A716F0CA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091290; cv=none; b=bdfGHkyjiIo+re9u0LqN2OGKeamMXsOvLDdgB+KoKH6lfIxjh2TvbSMDKS7GjA2UkfnUqK0/kHKyTj343Q74gJZW+cd0pP9o7UoO97STwZCcfF6FkzbrM0RfalKr1SvsLQVHyo643VFSjDZ/LPOZYxMiNoTvAy9F/FJIEsW6cz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091290; c=relaxed/simple;
	bh=ffJbZVGjXwXnNEjgm1xAfng7yUEkFKHbk0/EPzlyDd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgBWr5ykPm4C3J54hHeZ2Ii+UxINqldmKVBTvwD/LRli0WmIcPQNURiyjewLW23STozW5+fI4ZK1hvnGftdWUu2PcCl3GDDgHQ0JJxPI4VdLiglVGNLlfCrv0Xaz4JGwyV9slwljYB7ejDVeG6pmKwjTnYsQ0vmi/hLltbwRceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k/zUVdyn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso729567166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715091287; x=1715696087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eNwp1KeR6q1csnKLq9DFYvN46m+YqLkkQLc199nW5E=;
        b=k/zUVdynRJLasnVkzrGxA+03vDugTnmQhIer5FYjOAsfjitSqQy0hUdVx3cgk46Rkg
         jZGDzfM1nApnMsigN65EglUX8I1zxB3VJblav0+IUK6hYtmmX6RCvEdoAkmb2dKtgOC0
         npr+3QAucy7e2AIwuX7qONZM9Fvd15LAY7cf04QZTX76ng4WKdnrcmvMTrjxg5Xh1TTM
         CmQvEKd7Mf8PrIMwAsKu7E8/YIyWwcWXV8a5PjeJCAYkYpVP2xvK/WKU+sGKfHph2DoO
         9+sY00Kpw8CiqMZe4XVxYdG063glwo27pCdRFGzIEzxRR/+Cd5Fl8jO4GwOZ9u5El8AV
         CiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091287; x=1715696087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eNwp1KeR6q1csnKLq9DFYvN46m+YqLkkQLc199nW5E=;
        b=DoBUpB5/z/xAL5ihyUgUX1d90/LtHnMOWqp5NwJjWvKZRiGwXWu38vJ9KBD22fs4OK
         yjr0xF3KuU29fdOQkh/R+kRo6zmXXkmGJfHGA2zj5FfkVzikvJ2qvG+U6glmkGY2/cik
         fEKaBp0JEzmzJbYktiqBYHXHRDUaIrANC4MBkWF9ot2WtUiFcVB+a/BHCRPGbOs3a1yO
         QF5SB13KIBIQIZQAJ8c3bAZFptKPBo30brgETGp/D4x7LS9loZrjhZUwjwgLNxohwzMx
         b6Th1fwMwvDO+wJe9MoCFQYw6opyHDpPGJ/qk5gJlngnV9HIXctA74gbT7dJmv79AlRi
         NL5g==
X-Forwarded-Encrypted: i=1; AJvYcCWbPxbOlcZIRqeAwGDyDO75aLVH3H7cxL2gcItNYNFQULcVS019kK7BWwW2TYx6NX5UXsGoYKkIPjYew0XZ+Oz8oyEQa57aRZvkkqIE
X-Gm-Message-State: AOJu0Yz2aKZmZQXWYEH8Uuy/uAaGAoFNRGVaklQTC15CY3RBqh7D4DwI
	eSxTR+I5jdh80ZSCxRxro6bxT6KRZC2aQgYB8diin9w19HGT58iq3blXEZ+SmxQ=
X-Google-Smtp-Source: AGHT+IFlhgpaj8s7Ylef1U/lb5hV3d+hj+0ADsOWoK2vF6wUkDdpIOR9A24GskIxbkz+a/2MUnIIDg==
X-Received: by 2002:a50:8d16:0:b0:572:6ab0:6afc with SMTP id s22-20020a508d16000000b005726ab06afcmr9113193eds.33.1715091286727;
        Tue, 07 May 2024 07:14:46 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id x2-20020a056402414200b00572cf08369asm5621928eda.23.2024.05.07.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:14:46 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 07 May 2024 15:14:45 +0100
Subject: [PATCH 2/5] phy: exynos5-usbdrd: convert udelay() to fsleep()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240507-samsung-usb-phy-fixes-v1-2-4ccba5afa7cc@linaro.org>
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

The timers-howto recommends using usleep_range() and friends anytime
waiting for >= ~10us is required. Doing so can help the timer subsystem
a lot to coalesce wakeups.

Additionally, fsleep() exists as a convenient wrapper so we do not have
to think about which exact sleeping function is required in which case.

Convert all udelay() calls in this driver to use fsleep() to follow the
recommendataion.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 2af192c15d78..1b209ab7a268 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -448,7 +448,7 @@ static int exynos5_usbdrd_phy_init(struct phy *phy)
 
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYCLKRST);
 
-	udelay(10);
+	fsleep(10);
 
 	reg &= ~PHYCLKRST_PORTRESET;
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYCLKRST);
@@ -779,11 +779,11 @@ static void exynos850_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
 	writel(reg, regs_base + EXYNOS850_DRD_HSP_TEST);
 
 	/* Finish PHY reset (POR=low) */
-	udelay(10); /* required before doing POR=low */
+	fsleep(10); /* required before doing POR=low */
 	reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
 	reg &= ~(CLKRST_PHY_SW_RST | CLKRST_PORT_RST);
 	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
-	udelay(75); /* required after POR=low for guaranteed PHY clock */
+	fsleep(75); /* required after POR=low for guaranteed PHY clock */
 
 	/* Disable single ended signal out */
 	reg = readl(regs_base + EXYNOS850_DRD_HSP);
@@ -836,7 +836,7 @@ static int exynos850_usbdrd_phy_exit(struct phy *phy)
 	reg = readl(regs_base + EXYNOS850_DRD_CLKRST);
 	reg |= CLKRST_LINK_SW_RST;
 	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
-	udelay(10); /* required before doing POR=low */
+	fsleep(10); /* required before doing POR=low */
 	reg &= ~CLKRST_LINK_SW_RST;
 	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
 

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


