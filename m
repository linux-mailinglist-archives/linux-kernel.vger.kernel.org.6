Return-Path: <linux-kernel+bounces-171549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5DB8BE5E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C767EB2C3FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A1116F0FD;
	Tue,  7 May 2024 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBFSWZu8"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F416EC0F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091289; cv=none; b=CZy01GSFgrQY0qCY4u6d3mV5H+2Rzwy9aGiM8xCUPmYqa20dh1zUOKUZokibql3GMEUZfAuJDkCB1mT2WM0Z73fEjC7d0ZVd4066DXmldTjTOBNGpLDUeiLhLfYoIAYAydCj4X3vFshvRMenLZ4Y61Oga2JE+vHZncJvgF8/vBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091289; c=relaxed/simple;
	bh=6Oq8yHjM77fS6G7Wl/q+/pRkj/j5+EWrA7Fxt21tL/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ipCR++wN3wNcP84P6gNJAhwkItRB8fr6xkZr0SJiwU/2sShWqi0lL5/v3mPPcG380nmVnB5rtdXAWUK2Fsq8q9b+0UOZ0vBhS1YzQ7nER3B5kwGMQ+c+Cf/6qCA08S5PPkvuhpY1nAe9ro2oMQM4D+1ohRJbSEhXXuVW+44Kpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBFSWZu8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5200afe39eso838619866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715091286; x=1715696086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88e0LLt+lrc5lZzN56km9yoOnQ7q4J8j+3agax3Pphk=;
        b=gBFSWZu82+LLbFFE0YDCOaSvIlGvnyArEYMibtjS6hWATmvp/WJsW54oT4jW15ZXjD
         SkLKESfbj4Mwsw89NHDl3/zpkicT5Lf4IZd2dUofAwYRhK7AUsBNz3AzFZaRbv3yCOxE
         i6BffTcrVOJbM02x7Oa+8kNTILcw6UrwOLmFcWX5hiy6mNWWJP6i27Bo4MA2gIm1XB21
         +rJuqz23rsLkah+vGDYy6JLsIQ5B6qAbOuk/te5WOG94ZfQd8jL3faCCKnYWrrbPqcnp
         aNENNIzbiHxepAoITyXNLe05wU8JyfliKKudVvkU4rlGrR4CQpA2jx1EuWVkqPhXVGz9
         VuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091286; x=1715696086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88e0LLt+lrc5lZzN56km9yoOnQ7q4J8j+3agax3Pphk=;
        b=EE8C+KW4dbUWu2EuRpR9uOPOzSYuMsgPtXsjB31G+olkMP1wB1GEWAx58XAxDbmi4o
         S72oco1Ek6KqgTZZFbWx4VUO2iOky45+kyh6bryYyLYxbAikI6+1PisSIWHDyaAbVaX9
         7APshbiAlNecLzGH1jMmGzW33geUTEf1gQpSspcautIvZ/xc7xRERK5F+CDtIwQrt0VE
         iCRZXMs8GIoz6zTxcf72keBLHFbHDKWtQ7yMf1a0sQVK4FtA/TuWXU0xEvZ/noOR60Rh
         yVpKd8WKFV33RPh22fe8s32vDSP/MvjWQ2B4As29gQlsy7cMqG/lyU7zmR0Eazw7gygj
         1gDg==
X-Forwarded-Encrypted: i=1; AJvYcCXF07ExnTMaPZhKbUxWsL09eGip6x+Qp6IjG7WSOgi2RkUjmO/Bf3u2xmb1/3WV6+Z3mslQuop/wbku4HBlNbC2yCFAqsSfiyrajWkV
X-Gm-Message-State: AOJu0Yxkfh9LR31HcCkkySTsiamPUgnOB4hpg5oGh04O3X39tdCtwe2T
	anTAFx2pkezuPvkSUeOd04HRxFwiiMjOMmvGIfZfPAvaM51M/lCNjuX2eHLNvohJjopzYHJq/va
	Wzkpi/w==
X-Google-Smtp-Source: AGHT+IE1P/hHMY3LIT1bpJkBILATQnwiTaFH5rXHwp3HQxVrvpMWG51xBDNGqOT3Uqe8ATRtG5gVQQ==
X-Received: by 2002:a50:cd18:0:b0:572:a748:d46a with SMTP id z24-20020a50cd18000000b00572a748d46amr10471522edi.42.1715091286267;
        Tue, 07 May 2024 07:14:46 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id x2-20020a056402414200b00572cf08369asm5621928eda.23.2024.05.07.07.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:14:45 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 07 May 2024 15:14:44 +0100
Subject: [PATCH 1/5] phy: exynos5-usbdrd: uniform order of register bit
 macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240507-samsung-usb-phy-fixes-v1-1-4ccba5afa7cc@linaro.org>
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

Most of the macros are ordered high -> low, but there are some
outliers.

Order them all uniformly from high to low. This will allow adding
additional register (field) definitions in a consistent way.

While at it, also remove some extra empty lines to group register bit
field definitions together with the relevant register. This makes the
registers easier to distinguish visually.

No functional change.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 44 +++++++++++---------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 04171eed5b16..2af192c15d78 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -35,13 +35,11 @@
 
 /* Exynos5: USB 3.0 DRD PHY registers */
 #define EXYNOS5_DRD_LINKSYSTEM			0x04
-
+#define LINKSYSTEM_XHCI_VERSION_CONTROL		BIT(27)
 #define LINKSYSTEM_FLADJ_MASK			(0x3f << 1)
 #define LINKSYSTEM_FLADJ(_x)			((_x) << 1)
-#define LINKSYSTEM_XHCI_VERSION_CONTROL		BIT(27)
 
 #define EXYNOS5_DRD_PHYUTMI			0x08
-
 #define PHYUTMI_OTGDISABLE			BIT(6)
 #define PHYUTMI_FORCESUSPEND			BIT(1)
 #define PHYUTMI_FORCESLEEP			BIT(0)
@@ -49,40 +47,31 @@
 #define EXYNOS5_DRD_PHYPIPE			0x0c
 
 #define EXYNOS5_DRD_PHYCLKRST			0x10
-
 #define PHYCLKRST_EN_UTMISUSPEND		BIT(31)
-
 #define PHYCLKRST_SSC_REFCLKSEL_MASK		(0xff << 23)
 #define PHYCLKRST_SSC_REFCLKSEL(_x)		((_x) << 23)
-
 #define PHYCLKRST_SSC_RANGE_MASK		(0x03 << 21)
 #define PHYCLKRST_SSC_RANGE(_x)			((_x) << 21)
-
 #define PHYCLKRST_SSC_EN			BIT(20)
 #define PHYCLKRST_REF_SSP_EN			BIT(19)
 #define PHYCLKRST_REF_CLKDIV2			BIT(18)
-
 #define PHYCLKRST_MPLL_MULTIPLIER_MASK		(0x7f << 11)
 #define PHYCLKRST_MPLL_MULTIPLIER_100MHZ_REF	(0x19 << 11)
 #define PHYCLKRST_MPLL_MULTIPLIER_50M_REF	(0x32 << 11)
 #define PHYCLKRST_MPLL_MULTIPLIER_24MHZ_REF	(0x68 << 11)
 #define PHYCLKRST_MPLL_MULTIPLIER_20MHZ_REF	(0x7d << 11)
 #define PHYCLKRST_MPLL_MULTIPLIER_19200KHZ_REF	(0x02 << 11)
-
-#define PHYCLKRST_FSEL_UTMI_MASK		(0x7 << 5)
 #define PHYCLKRST_FSEL_PIPE_MASK		(0x7 << 8)
+#define PHYCLKRST_FSEL_UTMI_MASK		(0x7 << 5)
 #define PHYCLKRST_FSEL(_x)			((_x) << 5)
 #define PHYCLKRST_FSEL_PAD_100MHZ		(0x27 << 5)
 #define PHYCLKRST_FSEL_PAD_24MHZ		(0x2a << 5)
 #define PHYCLKRST_FSEL_PAD_20MHZ		(0x31 << 5)
 #define PHYCLKRST_FSEL_PAD_19_2MHZ		(0x38 << 5)
-
 #define PHYCLKRST_RETENABLEN			BIT(4)
-
 #define PHYCLKRST_REFCLKSEL_MASK		(0x03 << 2)
 #define PHYCLKRST_REFCLKSEL_PAD_REFCLK		(0x2 << 2)
 #define PHYCLKRST_REFCLKSEL_EXT_REFCLK		(0x3 << 2)
-
 #define PHYCLKRST_PORTRESET			BIT(1)
 #define PHYCLKRST_COMMONONN			BIT(0)
 
@@ -100,30 +89,27 @@
 #define PHYREG1_CR_ACK				BIT(0)
 
 #define EXYNOS5_DRD_PHYPARAM0			0x1c
-
 #define PHYPARAM0_REF_USE_PAD			BIT(31)
 #define PHYPARAM0_REF_LOSLEVEL_MASK		(0x1f << 26)
 #define PHYPARAM0_REF_LOSLEVEL			(0x9 << 26)
 
 #define EXYNOS5_DRD_PHYPARAM1			0x20
-
 #define PHYPARAM1_PCS_TXDEEMPH_MASK		(0x1f << 0)
 #define PHYPARAM1_PCS_TXDEEMPH			(0x1c)
 
 #define EXYNOS5_DRD_PHYTERM			0x24
 
 #define EXYNOS5_DRD_PHYTEST			0x28
-
 #define PHYTEST_POWERDOWN_SSP			BIT(3)
 #define PHYTEST_POWERDOWN_HSP			BIT(2)
 
 #define EXYNOS5_DRD_PHYADP			0x2c
 
 #define EXYNOS5_DRD_PHYUTMICLKSEL		0x30
-
 #define PHYUTMICLKSEL_UTMI_CLKSEL		BIT(2)
 
 #define EXYNOS5_DRD_PHYRESUME			0x34
+
 #define EXYNOS5_DRD_LINKPORT			0x44
 
 /* USB 3.0 DRD PHY SS Function Control Reg; accessed by CR_PORT */
@@ -147,28 +133,28 @@
 
 /* Exynos850: USB DRD PHY registers */
 #define EXYNOS850_DRD_LINKCTRL			0x04
-#define LINKCTRL_BUS_FILTER_BYPASS(_x)		((_x) << 4)
 #define LINKCTRL_FORCE_QACT			BIT(8)
+#define LINKCTRL_BUS_FILTER_BYPASS(_x)		((_x) << 4)
 
 #define EXYNOS850_DRD_CLKRST			0x20
-#define CLKRST_LINK_SW_RST			BIT(0)
-#define CLKRST_PORT_RST				BIT(1)
 #define CLKRST_PHY_SW_RST			BIT(3)
+#define CLKRST_PORT_RST				BIT(1)
+#define CLKRST_LINK_SW_RST			BIT(0)
 
 #define EXYNOS850_DRD_UTMI			0x50
-#define UTMI_FORCE_SLEEP			BIT(0)
-#define UTMI_FORCE_SUSPEND			BIT(1)
-#define UTMI_DM_PULLDOWN			BIT(2)
-#define UTMI_DP_PULLDOWN			BIT(3)
-#define UTMI_FORCE_BVALID			BIT(4)
 #define UTMI_FORCE_VBUSVALID			BIT(5)
+#define UTMI_FORCE_BVALID			BIT(4)
+#define UTMI_DP_PULLDOWN			BIT(3)
+#define UTMI_DM_PULLDOWN			BIT(2)
+#define UTMI_FORCE_SUSPEND			BIT(1)
+#define UTMI_FORCE_SLEEP			BIT(0)
 
 #define EXYNOS850_DRD_HSP			0x54
-#define HSP_COMMONONN				BIT(8)
-#define HSP_EN_UTMISUSPEND			BIT(9)
-#define HSP_VBUSVLDEXT				BIT(12)
-#define HSP_VBUSVLDEXTSEL			BIT(13)
 #define HSP_FSV_OUT_EN				BIT(24)
+#define HSP_VBUSVLDEXTSEL			BIT(13)
+#define HSP_VBUSVLDEXT				BIT(12)
+#define HSP_EN_UTMISUSPEND			BIT(9)
+#define HSP_COMMONONN				BIT(8)
 
 #define EXYNOS850_DRD_HSP_TEST			0x5c
 #define HSP_TEST_SIDDQ				BIT(24)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


