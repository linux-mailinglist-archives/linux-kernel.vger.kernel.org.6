Return-Path: <linux-kernel+bounces-552361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA146A57908
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D643B0166
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474E81B415F;
	Sat,  8 Mar 2025 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzoRwCfR"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C01B0F0A;
	Sat,  8 Mar 2025 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420259; cv=none; b=K9jXwRBhRn4B5YJTznHWfO6EGogezqPMU8dF8DNhmr+j0bJeCeKhy5v4Fej3/68wRTpp5TaqVGw/PGkn3XZ+wAf4Qs/Hgg8NZKwTfyJNkFglCNZnY9341NkKWwe60h4JXB2X5jNISI648Sqq7EvFZINjWHDQEqWz3oobU/XAr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420259; c=relaxed/simple;
	bh=1bmo74LYFV3BLr/JFDmpiVjZNBn9CNtCOQIjtQp+4KA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQYvacgulBlg3Y4GURqbUGL9GtqofI2Vk73wTvMEGnOqN7J4F1JhSkiwjyqFQDvHE1nVNf9Em8cNZ1TUMomUZL55ttGoRSl8zECypidCjo1NO58dRSCLU/0s78BA1fyc3frhxy8uAHGQYSpTC35131SeRixMo4VaM9uml+8vsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzoRwCfR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaec61d0f65so527680666b.1;
        Fri, 07 Mar 2025 23:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741420256; x=1742025056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26jrt9FbETYpD3wi70/ZRCle0q9dVFnBerSgADHzQfo=;
        b=NzoRwCfRx8h1fUe9X/UpzXGNVFfvYEaft5oSqebai+jSnNnbUvpwCoCoSXr0xfl7oY
         GpK/W+QfwoVfuGjj5Wnxo6nd3vy8CLXByeFQEpWCIeIQ12TEsQL79E3/mKvNVT/PXRxU
         O2ScLM1nvWKcqOS2vbPhdYTjndW0oapG/R/SUncQ9sBKXajjO/apL3N0d4RdfkDf2QGM
         VbDHTiGoFjLTm3/DUf9kX7kT9tQa/WA6EEq9N+FSXVqA4CoJtUFab01zQUV1Ea5ecS7D
         AC0kd9F8t9k5+RfhLUNtwcS9dHGZlF4WF7NGCyffx73Q2I4vqA5napwJiBxFtE20dCzy
         pGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741420256; x=1742025056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26jrt9FbETYpD3wi70/ZRCle0q9dVFnBerSgADHzQfo=;
        b=CwQ+LMSolL/74WaVWbnUGC9V2kJ97x4UGUDTX1JNpYhG9qnkR1Mq9YVGlJeUt6X2h8
         mxTJCpubvn65ydug0yUZLXN2FMLqOxQsDkrZWYZDId9uWFPnm9kb2vdUrYjcexVF+ZW2
         q6Kkh6yLzBVx6rdxX1qxuMYmArfdZmKWEcKfQdVjUcpRHA9PPqNA3u6bUOjeVEjRpDke
         wnGtzf/Bb0N65Q2e/XS+ZIu4sJMTbkseQ7YCzoaHY0+VB2M1SfCopRAw1KRxlNwDk4X1
         iN/oHJyE4R15fMEVCkiNK6L0TEwqXWN/iEAQU+ljQCrl6qybYXIozLtqwcEoQEOUTbt5
         Q+6g==
X-Forwarded-Encrypted: i=1; AJvYcCUHmthJ34UTRdtEUQNq/qSEmyy2UhI99Vdrkx6127/UJ5l4GyZUi1zrRpqjMM2V+IGUWfi2OahZw2vN@vger.kernel.org, AJvYcCVcW5ZaJx0d81jN51SEH0xyb/Sd4Q4yXkVkiHzMJ4X6NZoWK8WgvlyaO+vUUz78fMIRelnJLol6lgBrPQXo@vger.kernel.org, AJvYcCXwbT7Hui2alengb43DCwNA0Y5kEBULcxenyqAz97S89DllI5E6FirbgCggMeZXY1DjcmNQiraXtNDu@vger.kernel.org
X-Gm-Message-State: AOJu0YwitRM3eLzzsjs6KPlDTX1LW0nxaY5LPjzP8rWc/l7W3ThQtlXU
	6h1T5BM8DDMdyEg1eDQXySX328Gco3woHDbdxWdFI8CuwO4FINmvDvyuzQ==
X-Gm-Gg: ASbGncukCauGsXHix5q8JuU7QSOQybtsLEYyHjOnOnd+JeqChcNwHRZPfDwHkjYipk1
	blaL/EsWhMWZI/2b2DZGZ0xXkZifJgzdIgkY5G9vedjBDToyLa59e5/h0L2bEIt0pki08uZx8HO
	JyjgRBVq93RASvXv1oAG/JfXnExI5qAAiX60Q7OUxCLH5mvUJ6yic9BC6k8nJqbhd3DL/uNbrPa
	oSZ+dN5ahmdw5AivlA8T/XKPqaxfcmBpMaIYknYjEeFkzonMc3T/fKJtrKjSPA0prsOJ/UePE3r
	6Fz2c0cypi6Oekb1gbWqCsSJxz4lRhMLcMhZfrasDo5DwA0GG6qNXboJQF4COEU5KpVqyz5mSdP
	gn1k7qPgn3RBmUSCEQ4774xXins1i
X-Google-Smtp-Source: AGHT+IEswka8EI0Z7I5ebf0ySJB+YwQMqLhK9yhs5A0/8DGfavMRgl33T3xpn9dvoBMnSlI7Y1I5Ug==
X-Received: by 2002:a17:906:f59c:b0:abf:fb7b:8d09 with SMTP id a640c23a62f3a-ac252ed8b2cmr804483966b.51.1741420255692;
        Fri, 07 Mar 2025 23:50:55 -0800 (PST)
Received: from hex.my.domain (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm213104766b.106.2025.03.07.23.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:50:54 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 08 Mar 2025 08:50:45 +0100
Subject: [PATCH v3 7/9] clk: bcm281xx: Add corresponding bus clocks for
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-kona-bus-clock-v3-7-d6fb5bfc3b67@gmail.com>
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
In-Reply-To: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741420241; l=5954;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=1bmo74LYFV3BLr/JFDmpiVjZNBn9CNtCOQIjtQp+4KA=;
 b=m5ABRBf8xLYVcHQyf4aikZp1uMSPzFMzJooKfmwYDbAh2HOSf9Kx5jVAEo+vuWBOu5+ceNX+G
 gFQg6fyeYzRDT8yWX2LBxQgyIMgPKefLEcXi2dzY4ySrUEJBC4AHRT+
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add bus clocks corresponding to peripheral clocks currently supported
by the BCM281xx clock driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Adapt to CLOCK_COUNT defines being moved

Changes in v2:
- Add this patch (BCM281xx bus clocks)
---
 drivers/clk/bcm/clk-bcm281xx.c | 127 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm281xx.c b/drivers/clk/bcm/clk-bcm281xx.c
index 7589ad9db99767485d73e91ed8db4d2842cd6e32..b3f6c86adc7ea142b882b6971031411392c689ab 100644
--- a/drivers/clk/bcm/clk-bcm281xx.c
+++ b/drivers/clk/bcm/clk-bcm281xx.c
@@ -59,7 +59,17 @@ static struct peri_clk_data pmu_bsc_var_data = {
 	.trig		= TRIGGER(0x0a40, 2),
 };
 
-#define BCM281XX_AON_CCU_CLOCK_COUNT	(BCM281XX_AON_CCU_PMU_BSC_VAR + 1)
+static struct bus_clk_data hub_timer_apb_data = {
+	.gate		= HW_SW_GATE(0x0414, 18, 3, 2),
+	.hyst		= HYST(0x0414, 10, 11),
+};
+
+static struct bus_clk_data pmu_bsc_apb_data = {
+	.gate		= HW_SW_GATE(0x0418, 18, 3, 2),
+	.hyst		= HYST(0x0418, 10, 11),
+};
+
+#define BCM281XX_AON_CCU_CLOCK_COUNT	(BCM281XX_AON_CCU_PMU_BSC_APB + 1)
 
 static struct ccu_data aon_ccu_data = {
 	BCM281XX_CCU_COMMON(aon, AON),
@@ -70,6 +80,10 @@ static struct ccu_data aon_ccu_data = {
 			KONA_CLK(aon, pmu_bsc, peri),
 		[BCM281XX_AON_CCU_PMU_BSC_VAR] =
 			KONA_CLK(aon, pmu_bsc_var, peri),
+		[BCM281XX_AON_CCU_HUB_TIMER_APB] =
+			KONA_CLK(aon, hub_timer_apb, bus),
+		[BCM281XX_AON_CCU_PMU_BSC_APB] =
+			KONA_CLK(aon, pmu_bsc_apb, bus),
 		[BCM281XX_AON_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -178,7 +192,36 @@ static struct peri_clk_data hsic2_12m_data = {
 	.trig		= TRIGGER(0x0afc, 5),
 };
 
-#define BCM281XX_MASTER_CCU_CLOCK_COUNT	(BCM281XX_MASTER_CCU_HSIC2_12M + 1)
+static struct bus_clk_data sdio1_ahb_data = {
+	.gate		= HW_SW_GATE(0x0358, 16, 1, 0),
+};
+
+static struct bus_clk_data sdio2_ahb_data = {
+	.gate		= HW_SW_GATE(0x035c, 16, 1, 0),
+};
+
+static struct bus_clk_data sdio3_ahb_data = {
+	.gate		= HW_SW_GATE(0x0364, 16, 1, 0),
+};
+
+static struct bus_clk_data sdio4_ahb_data = {
+	.gate		= HW_SW_GATE(0x0360, 16, 1, 0),
+};
+
+static struct bus_clk_data usb_ic_ahb_data = {
+	.gate		= HW_SW_GATE(0x0354, 16, 1, 0),
+};
+
+/* also called usbh_ahb */
+static struct bus_clk_data hsic2_ahb_data = {
+	.gate		= HW_SW_GATE(0x0370, 16, 1, 0),
+};
+
+static struct bus_clk_data usb_otg_ahb_data = {
+	.gate		= HW_SW_GATE(0x0348, 16, 1, 0),
+};
+
+#define BCM281XX_MASTER_CCU_CLOCK_COUNT	(BCM281XX_MASTER_CCU_USB_OTG_AHB + 1)
 
 static struct ccu_data master_ccu_data = {
 	BCM281XX_CCU_COMMON(master, MASTER),
@@ -197,6 +240,20 @@ static struct ccu_data master_ccu_data = {
 			KONA_CLK(master, hsic2_48m, peri),
 		[BCM281XX_MASTER_CCU_HSIC2_12M] =
 			KONA_CLK(master, hsic2_12m, peri),
+		[BCM281XX_MASTER_CCU_SDIO1_AHB] =
+			KONA_CLK(master, sdio1_ahb, bus),
+		[BCM281XX_MASTER_CCU_SDIO2_AHB] =
+			KONA_CLK(master, sdio2_ahb, bus),
+		[BCM281XX_MASTER_CCU_SDIO3_AHB] =
+			KONA_CLK(master, sdio3_ahb, bus),
+		[BCM281XX_MASTER_CCU_SDIO4_AHB] =
+			KONA_CLK(master, sdio4_ahb, bus),
+		[BCM281XX_MASTER_CCU_USB_IC_AHB] =
+			KONA_CLK(master, usb_ic_ahb, bus),
+		[BCM281XX_MASTER_CCU_HSIC2_AHB] =
+			KONA_CLK(master, hsic2_ahb, bus),
+		[BCM281XX_MASTER_CCU_USB_OTG_AHB] =
+			KONA_CLK(master, usb_otg_ahb, bus),
 		[BCM281XX_MASTER_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -309,7 +366,51 @@ static struct peri_clk_data pwm_data = {
 	.trig		= TRIGGER(0x0afc, 15),
 };
 
-#define BCM281XX_SLAVE_CCU_CLOCK_COUNT	(BCM281XX_SLAVE_CCU_PWM + 1)
+static struct bus_clk_data uartb_apb_data = {
+	.gate		= HW_SW_GATE(0x0400, 16, 1, 0),
+};
+
+static struct bus_clk_data uartb2_apb_data = {
+	.gate		= HW_SW_GATE(0x0404, 16, 1, 0),
+};
+
+static struct bus_clk_data uartb3_apb_data = {
+	.gate		= HW_SW_GATE(0x0408, 16, 1, 0),
+};
+
+static struct bus_clk_data uartb4_apb_data = {
+	.gate		= HW_SW_GATE(0x040c, 16, 1, 0),
+};
+
+static struct bus_clk_data ssp0_apb_data = {
+	.gate		= HW_SW_GATE(0x0410, 16, 1, 0),
+};
+
+static struct bus_clk_data ssp2_apb_data = {
+	.gate		= HW_SW_GATE(0x0418, 16, 1, 0),
+};
+
+static struct bus_clk_data bsc1_apb_data = {
+	.gate		= HW_SW_GATE(0x0458, 16, 1, 0),
+	.hyst		= HYST(0x0458, 8, 9),
+};
+
+static struct bus_clk_data bsc2_apb_data = {
+	.gate		= HW_SW_GATE(0x045c, 16, 1, 0),
+	.hyst		= HYST(0x045c, 8, 9),
+};
+
+static struct bus_clk_data bsc3_apb_data = {
+	.gate		= HW_SW_GATE(0x0484, 16, 1, 0),
+	.hyst		= HYST(0x0484, 8, 9),
+};
+
+static struct bus_clk_data pwm_apb_data = {
+	.gate		= HW_SW_GATE(0x0468, 16, 1, 0),
+	.hyst		= HYST(0x0468, 8, 9),
+};
+
+#define BCM281XX_SLAVE_CCU_CLOCK_COUNT	(BCM281XX_SLAVE_CCU_PWM_APB + 1)
 
 static struct ccu_data slave_ccu_data = {
 	BCM281XX_CCU_COMMON(slave, SLAVE),
@@ -334,6 +435,26 @@ static struct ccu_data slave_ccu_data = {
 			KONA_CLK(slave, bsc3, peri),
 		[BCM281XX_SLAVE_CCU_PWM] =
 			KONA_CLK(slave, pwm, peri),
+		[BCM281XX_SLAVE_CCU_UARTB_APB] =
+			KONA_CLK(slave, uartb_apb, bus),
+		[BCM281XX_SLAVE_CCU_UARTB2_APB] =
+			KONA_CLK(slave, uartb2_apb, bus),
+		[BCM281XX_SLAVE_CCU_UARTB3_APB] =
+			KONA_CLK(slave, uartb3_apb, bus),
+		[BCM281XX_SLAVE_CCU_UARTB4_APB] =
+			KONA_CLK(slave, uartb4_apb, bus),
+		[BCM281XX_SLAVE_CCU_SSP0_APB] =
+			KONA_CLK(slave, ssp0_apb, bus),
+		[BCM281XX_SLAVE_CCU_SSP2_APB] =
+			KONA_CLK(slave, ssp2_apb, bus),
+		[BCM281XX_SLAVE_CCU_BSC1_APB] =
+			KONA_CLK(slave, bsc1_apb, bus),
+		[BCM281XX_SLAVE_CCU_BSC2_APB] =
+			KONA_CLK(slave, bsc2_apb, bus),
+		[BCM281XX_SLAVE_CCU_BSC3_APB] =
+			KONA_CLK(slave, bsc3_apb, bus),
+		[BCM281XX_SLAVE_CCU_PWM_APB] =
+			KONA_CLK(slave, pwm_apb, bus),
 		[BCM281XX_SLAVE_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
 	},
 };

-- 
2.48.1


