Return-Path: <linux-kernel+bounces-565704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D9FA66DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5333D3BF6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A82063E7;
	Tue, 18 Mar 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IImbgS8U"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF6205514;
	Tue, 18 Mar 2025 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285618; cv=none; b=ZSiZMgKGmrmlXlOa0wI3K7rdwJr1d6HwYnBKw8Zdv0WxsHsmIoNe6pbZIhW+llhFjlcKMeKbZ/hKH7abh5KVDHm5lFps1pVS1byE0MyFQRp72cWw1jiJu9k0MPfuP7aj3vbtmO6lbh3xjKqM0GmuXAGs+TzKyxEUKapuLiUdVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285618; c=relaxed/simple;
	bh=bLBbUDqqNTwOJgLkQRCFNZz1sWpEBh/lPPGrTuBFI28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Npok3O13/CGV+zdZt0Z8BF4sr2/4IPpxopL241/dFwvK0xyJvZmddhzHhLVdlRwmKAIiy0wZySp/huThr1Pijnvs8oJEpd9bkvnTSrqqgNk6F21tcnqr+X+3xSCPNAw4CjHW2tNdgsJu/Y7HyApaBK0AKmhuLRUsSVe4Hg7rxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IImbgS8U; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so606656a12.1;
        Tue, 18 Mar 2025 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742285614; x=1742890414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3+rnobJfi7WnNz9JTOuNxhCv/ZoIzUl+jD65O4j55E=;
        b=IImbgS8UuTPR6IYzVs4UETF8FtyBfT888uwMoZzKCI5x7TipiXWU7kNJDP4VVHbIFo
         rLSdBF3xiDdJk1X49eTL1iW+TiFF3931dtHjX/xUJ9z9xJLnIM+WTjnuU6LxCVTbEoum
         8PzfH8W30N+UNP/9ctSma1ul4UBbyoJ+YOzttgT4PFTeZTx8GbcBbC2nx8OpZR3/F+Zd
         QCNwbVqeUchWwmvpFsFCFJEjAB+nqfiyBBO+WXppUMbGKFja07a9J1QsYBhLiUJBDWNr
         KLLRUxwCO+HKuZEm3EbbvqkyRDnr7evOSLP+FU+pIPAAJNBwjEs3dGs41U1Rv34PEH35
         h/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285614; x=1742890414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3+rnobJfi7WnNz9JTOuNxhCv/ZoIzUl+jD65O4j55E=;
        b=jNKCWaYmQv91EZcsozkA7OZmgeI9PdjZJPentnE3cPBslrc3NkXy8rzmGFsxrX5ujb
         2EKWIS9456tzBXioJD0enczXWZePFgT/0PpikHDNVrW0W5kqiNImlgw+We7OBRl9bvOq
         hOiUtF8QqsXAIGQSemJwBDnKN8lAtR0OsD5nGOTnrW/Jw34x31TLWLy0sIz4U4HKVSA0
         r4ZeYrtn5sB5u3N1UI8AMLOz7GDzEl6HR3+5Qvvu1JmYo02U6kTMEP56H4UxChGj35m2
         KpEzFJfG64ZPxlo8KGp1FVz/vuQphtZZlcej5DMSv88Z4CRc43s9/S6ZCeS32GWNuzjo
         BqEg==
X-Forwarded-Encrypted: i=1; AJvYcCWfim7/aGGSBAs10jyHIGv05/gLp49V44s6T/HDNSDMLbEjVJpYJ19vBxMxKOIHXKnqbB8ydgTNyzOI@vger.kernel.org, AJvYcCWjPxZRba3zGyVcK6widrKE0tuLeoB1WIwlZ2UL0GjSbCQDT1nEjj7s0HLqKpXJ6W4LPncAuiMS+gtb0B3q@vger.kernel.org, AJvYcCX/Y+JRv3HwTERbML1HolzpWL6CHpqrLnHiDAOlJ/2TRYDsV9n9j0exY7yK10jFiLBc00PrlDAG3zzr@vger.kernel.org
X-Gm-Message-State: AOJu0YxToQABsyQ7k7dqG0tIoOYtBafuDw/Kh42JbtGkrhZTsPrzon5t
	JOQt1o7P7z5LFbrgDPBkBknP4xu/EUT1iwPxQAiDcX/dRXcbhC7Z
X-Gm-Gg: ASbGnct/1sX0cpWzndapeSUBrNU44CSfrBwcxSCKfT/8mRJkXLF/qiqeU79g/Si2LuQ
	BS6pJAcODFw/Ek2X09lWu2qbM7dni69TzOdep17fqStSgZf/W22vkdh4oXjT3ySoLnZ6fMwPa5H
	JTfBal+32N5WeP+FBk0J0gsPIrQ/qSt+JEqNQYSozzsoXngkD7uYlI2/LDTYKuaiVtWHQ8NyR3c
	ZIt8FaojqGVykLK1xBypIT2JOl6Dzi7TPf6qQCSFFCCu4qhqPtgnuQsbaaJVKSdLuwzbcOgA7Fi
	jc/PBOlsSLPEF6PF9yvSM1SDqMfHoB0eHMI7dHwe9xkDxuv92sM0JcxD8nCR8k3CZBtiYW9xnPa
	YgMSCLCeoqd2iDA7NQ/t+Xy8vn+bZ
X-Google-Smtp-Source: AGHT+IH+wuQJmaUOWiPGY+xjkMI5zm5lJkB2n0dMzUqIIyRKGGgFYIRAd0v2NNubG8i/3EKTvpgjGw==
X-Received: by 2002:a05:6402:2813:b0:5dc:94ce:42a6 with SMTP id 4fb4d7f45d1cf-5e8a04269dcmr13499584a12.22.1742285614157;
        Tue, 18 Mar 2025 01:13:34 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad392csm7176097a12.53.2025.03.18.01.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:13:33 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 18 Mar 2025 09:13:28 +0100
Subject: [PATCH v4 6/8] clk: bcm281xx: Add corresponding bus clocks for
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-kona-bus-clock-v4-6-f54416e8328f@gmail.com>
References: <20250318-kona-bus-clock-v4-0-f54416e8328f@gmail.com>
In-Reply-To: <20250318-kona-bus-clock-v4-0-f54416e8328f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742285605; l=5998;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=bLBbUDqqNTwOJgLkQRCFNZz1sWpEBh/lPPGrTuBFI28=;
 b=KWyMsu8JfPJWBA6zaiDy3QULAOfBgF+2u3q6+7meIsuvUYJbUJDXve+KfOV66N8xONL+weLf/
 V8htzTi+LY4Cj6ZmuNXKktZ9Q+1IdfthG9mzxAF0Gc3HYEvtfKLs50v
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add bus clocks corresponding to peripheral clocks currently supported
by the BCM281xx clock driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Adapt to CLOCK_COUNT -> CLK_COUNT rename

Changes in v3:
- Adapt to CLOCK_COUNT defines being moved

Changes in v2:
- Add this patch (BCM281xx bus clocks)
---
 drivers/clk/bcm/clk-bcm281xx.c | 127 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm281xx.c b/drivers/clk/bcm/clk-bcm281xx.c
index 62c3bf4656259261ae4f7d81dae48c90ab26c04e..13fd8a5ea8fa07bf6f3cca83b6b18e59a8de63df 100644
--- a/drivers/clk/bcm/clk-bcm281xx.c
+++ b/drivers/clk/bcm/clk-bcm281xx.c
@@ -59,7 +59,17 @@ static struct peri_clk_data pmu_bsc_var_data = {
 	.trig		= TRIGGER(0x0a40, 2),
 };
 
-#define BCM281XX_AON_CCU_CLK_COUNT	(BCM281XX_AON_CCU_PMU_BSC_VAR + 1)
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
+#define BCM281XX_AON_CCU_CLK_COUNT	(BCM281XX_AON_CCU_PMU_BSC_APB + 1)
 
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
 		[BCM281XX_AON_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -178,7 +192,36 @@ static struct peri_clk_data hsic2_12m_data = {
 	.trig		= TRIGGER(0x0afc, 5),
 };
 
-#define BCM281XX_MASTER_CCU_CLK_COUNT	(BCM281XX_MASTER_CCU_HSIC2_12M + 1)
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
+#define BCM281XX_MASTER_CCU_CLK_COUNT	(BCM281XX_MASTER_CCU_USB_OTG_AHB + 1)
 
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
 		[BCM281XX_MASTER_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -309,7 +366,51 @@ static struct peri_clk_data pwm_data = {
 	.trig		= TRIGGER(0x0afc, 15),
 };
 
-#define BCM281XX_SLAVE_CCU_CLK_COUNT	(BCM281XX_SLAVE_CCU_PWM + 1)
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
+#define BCM281XX_SLAVE_CCU_CLK_COUNT	(BCM281XX_SLAVE_CCU_PWM_APB + 1)
 
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
 		[BCM281XX_SLAVE_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };

-- 
2.48.1


