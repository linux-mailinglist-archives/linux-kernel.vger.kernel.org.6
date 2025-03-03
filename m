Return-Path: <linux-kernel+bounces-542708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31E7A4CCB7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CD63AD2CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BB11A0BD0;
	Mon,  3 Mar 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT0PQF+A"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728123908B;
	Mon,  3 Mar 2025 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033684; cv=none; b=hQA4bTImKMm5wc8kK/4m3XIi8lDW8f32OWz4r8+KIst1pg1o6yTpjFvB/nmr39knNFqtxwIlkPTiWJQXF0vUqI/wHqRw5elyIqY/SEd1Y4PVRte+Jw6O1Ib8hGPODqQprRXfK2QDYuv7nuwu+DyInrv40+H6JryK1km14Vj/dWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033684; c=relaxed/simple;
	bh=/7hDem5gMvmNcFXpsTaXvwxSWzYFIYuEBTiUAR7W6tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KuyNBb7Y/keyi5yQ4HLqO/Kq1LqCFcWyOQh44g2/7OBm36RxeH5ON1RAuzzKhfcyG46B5QVyPJheo8Km3GvDdd8j2SW+R7Ipkm8f2jUmQ+YM8ILlT1c7kz/aQdpywbZzhvXXefUWLsuNe1Eng63iHC4VlXUUSpjtDq4k6/ZUzJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YT0PQF+A; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abf4cebb04dso464243766b.0;
        Mon, 03 Mar 2025 12:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033681; x=1741638481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvJSz+FzLx//dtx2kIF8fDH63F6ZXeA3nvfYgLxVLyM=;
        b=YT0PQF+A174LMzJOx9VirCy7xiVPX0ZHDbq3OERMGoFWWF0o8zRONuOBifezkVX3t5
         Z+14vYVcL0ASVQ3yvCuYd803rozery8Vt2yMbQuFhL0LYw37yX2POxSv1lJRdyktHvlB
         OLuii7bHBkwSQ+nFR3zP6EMcMdaCWPzPgdlkqkuBtjuCn2APKhuVIKoYzWaCe5iScmcZ
         4nRm0i0HvsiWW5XyUEKCHncMWNvVnZt+Dcuqwo/hr7qGruZ+sRf47/ifLOIc4xmgsVzY
         V1k6eK+zDS0Fv+xkA83A1BXIqqVxgFVqRKEdUkjhiUKeRQ65WuycUac2g3lFfeXJnltc
         CcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033681; x=1741638481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvJSz+FzLx//dtx2kIF8fDH63F6ZXeA3nvfYgLxVLyM=;
        b=aUMyqlpVRV0gAD4euHL+opp3FJdMhVJUA61qXOQCErkoUt4UwaTgO13s1YatFU+xIT
         WWhlTlkxMC8fvd02RronH6pn02/3lXcEkK92AFe8hNVpAGPEv55wUrAIM7GxyPRY+xCp
         hD0rupcJoXDCKx72B28A6YO6sS8dZbR8uRzTXlki03MvIz3LkEWLkwO18REHAfHNfhd8
         q1/6iv9XPgUqoPwt3ZyZOXV9y3xqyYjhZz4EPaMxPEDpyNpwwzZZcF1P5hKx/6hN7m9/
         wN47ivM0uackq8IboFt2wDib+afNMcxkbf09XNkJU4zw50OFUgvfsx5Dkvf+7hWq/Dcp
         beLw==
X-Forwarded-Encrypted: i=1; AJvYcCU/0IJomVz4mlhVFDgHhXhK9EO0yfSvjp17ESiJxhfxnHZQoDnVlYyuSd7ca8aPvLCpoxrhhniqUzIzTm3/@vger.kernel.org, AJvYcCV8iWC5UPrxMc9izf+44nmbbWXgMjOcOkpjdzaf9MU0lMcUT3CCjT1PR49ZkmauOnGQwHZJy9Wlwkh6@vger.kernel.org, AJvYcCVIHMu1SYO/RrLQDRmzo7xTU6Xyx2egEMHazYg9jcvGHjF35jG4bfBIpvgmn0xbI+kVpIvYMsMRhNve@vger.kernel.org
X-Gm-Message-State: AOJu0YyoPfH7f46OLDyuL5QdAucz5YBld9/SJ0IxBMFS7I6SMTQViN4l
	ruVGhahkGNzNG4EOW9o9+ViJ8rYsT/E+kE1rxGm/B1Vzr5swmr2Z
X-Gm-Gg: ASbGncsL7/lgmvgx843nQHcRFtavMitv6jnNjj5PK5LgKNVwKAM23Uiqe7a0ZPf5zCP
	rw0va2AzyaX1VS2AcIFTzT1rilmnUcn37cqQ92vKOIpW1mbFLUbMXk/wNqf9OBulxuKpDUZ731E
	JF4/udStBN8FqHyGjVO06FFj0+JKJITGS1zvKkjEZCbVHP1g/Ysi+Z9HnrQW42esMmX1rak/av2
	oRWaeSx+YPrMu6GqPKihsD86gUM/Wx9+kRLjKITbKNNzjPESlfPSnyNrmnJiX6JgFEk971hT0SS
	cAXF4t0NBJJkMzX948FWC1bcMQsi7ffjlGKVR5eC/goOK9UOc6+S0avlQpnSufGV+498eQKJkGO
	Ouf8N7zProweqHD0=
X-Google-Smtp-Source: AGHT+IFyRD51nF/I/qXf+OcoO5rwC0dUdKj1/uMtJzI5VODF8q0NqI0FGFjzOedXfIpj0XifopHIyg==
X-Received: by 2002:a17:907:3da3:b0:ac1:edc5:d73b with SMTP id a640c23a62f3a-ac1f0edc8c7mr56378766b.8.1741033680661;
        Mon, 03 Mar 2025 12:28:00 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf64dd565dsm389222166b.101.2025.03.03.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:28:00 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 03 Mar 2025 21:27:53 +0100
Subject: [PATCH v2 5/7] clk: bcm281xx: Add corresponding bus clocks for
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kona-bus-clock-v2-5-a363c6a6b798@gmail.com>
References: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
In-Reply-To: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741033671; l=5471;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=/7hDem5gMvmNcFXpsTaXvwxSWzYFIYuEBTiUAR7W6tY=;
 b=DcSSLUy0S3qEkTnIQIujsM0csZQU+TxT+N8zzF2RRqHEJXoiQDlhVuBVuEioB13qLOD+BioOa
 cT0DwYrtoyCCusc+ZW9G9E8tVwr4inZdqp6tDERbJE0ez6O3YZVk8pk
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add bus clocks corresponding to peripheral clocks currently supported
by the BCM281xx clock driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Add this patch (BCM281xx bus clocks)
---
 drivers/clk/bcm/clk-bcm281xx.c | 121 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm281xx.c b/drivers/clk/bcm/clk-bcm281xx.c
index 823d5dfa31b84f502fcd6ada1eff6d8f4673b3dd..1c53df82ccebdaa2273b416a9395b79e31433e39 100644
--- a/drivers/clk/bcm/clk-bcm281xx.c
+++ b/drivers/clk/bcm/clk-bcm281xx.c
@@ -57,6 +57,16 @@ static struct peri_clk_data pmu_bsc_var_data = {
 	.trig		= TRIGGER(0x0a40, 2),
 };
 
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
 static struct ccu_data aon_ccu_data = {
 	BCM281XX_CCU_COMMON(aon, AON),
 	.kona_clks	= {
@@ -66,6 +76,10 @@ static struct ccu_data aon_ccu_data = {
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
@@ -172,6 +186,35 @@ static struct peri_clk_data hsic2_12m_data = {
 	.trig		= TRIGGER(0x0afc, 5),
 };
 
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
 static struct ccu_data master_ccu_data = {
 	BCM281XX_CCU_COMMON(master, MASTER),
 	.kona_clks	= {
@@ -189,6 +232,20 @@ static struct ccu_data master_ccu_data = {
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
@@ -301,6 +358,50 @@ static struct peri_clk_data pwm_data = {
 	.trig		= TRIGGER(0x0afc, 15),
 };
 
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
 static struct ccu_data slave_ccu_data = {
 	BCM281XX_CCU_COMMON(slave, SLAVE),
 	.kona_clks	= {
@@ -324,6 +425,26 @@ static struct ccu_data slave_ccu_data = {
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


