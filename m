Return-Path: <linux-kernel+bounces-542707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A0A4CCB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156C11737C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE3E2356B2;
	Mon,  3 Mar 2025 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWdCmuYm"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2884237702;
	Mon,  3 Mar 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033682; cv=none; b=Sv/RH48T3zSWnrGDOj656a1f7mcLXqONGEuOfX9Z4QnCQ0r7GaT7Ooh9Ssju8glybbjcFk031LRUuOZSxpYJECcstIZXLqB+CjlOMYTruz0lLZSSMtIGXidVExCLVGwnUOY47BS/j4dTyRpBHynZCqVHWCEEaq8PRg4tkpICbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033682; c=relaxed/simple;
	bh=ZxAskxejw3DV+cuq9u58OlHjwsx94z/3GL/VUKOK1JE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uv7TGTnNlCb0iXEfzh3QcPMWXWaxj6SiB3Hggs7oP+BOUFSLAE7+g7wEHu+YmXZ+jL10QbARKDXQx42dCMa8hTAZzHZCIeOTi8iIkRBWQrqMphOJd5GtQX52I2hDHCWvZJANqWi2mfrpwJKnw60yCQOamoTkObDKEHdlr0oBMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWdCmuYm; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf615d5f31so386485566b.2;
        Mon, 03 Mar 2025 12:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033679; x=1741638479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLnjj04sKOekF1xfg88O5QtKFzSPcppqfI5eqmeu8FM=;
        b=KWdCmuYm+ymZ0aNv1Rfmiwmo/SOhkXqk0J83ZIxHbRn2H+fsCQDqwW9nzuq6Uec0To
         u5qel7SydMHxaH96J7AuyynkoJ1mOi/fRo+B/FMsKVMSywHGuIQ93XKLjKkpbZtbj68y
         q9qwsar68mNgteozcK3QzvXDplDEJg/L6In9lKjXhyePEbkn4c/LxrCs/La/Bdi28v0/
         XsUTHxkX4CsSCUlBqmxcGuAdFPodDfZuPzGDO1xMzBhMprC0VUWQaOyIXBeMJO86ZL2d
         dhM+YBKW2fbrN+zn8H/F8JL+RLeN4v+Wt8N+ZeGFSzc3Ejj5Ajlrn1TolgvqzsfB0AGs
         qOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033679; x=1741638479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLnjj04sKOekF1xfg88O5QtKFzSPcppqfI5eqmeu8FM=;
        b=Huw/fTNYTnSWPaj4lpeG1hHqyCa4yBq0O7ZzZsZn/XczG5Nstb9/sptHynJuvX8B0G
         7648kk+AilFF8Yg1odgt7Het1A93qyFwsD6+T6uUyyDkzUWSbox4sHmUmPKPciueV9Ib
         8AYSLE50huS2NPbLmoZyIAEo1fbUErgEjtjowSyjrR82MkHgXR5ZsvaFo67155TRFtST
         jSya1XCM6AVDdqOcRNIP8Tt54ut0Er3ujPxi7n6KIRU/wAnST++xXWnqEMB47uo3aPRf
         C58B97cM7E0v2GFZD+HFHXe3aNG/w5lzuC7znFWFXGcchKnm7/FcHdnWfzuhaKVhPjhr
         ZjTA==
X-Forwarded-Encrypted: i=1; AJvYcCV7paZdaUbeZoVx7CUqxK0nKIXyjMnzSLtSp12bDsu+fEXQcb9rskf9SqTIulWytyePyfRflD1q6fmoDC8S@vger.kernel.org, AJvYcCVxHmiqJFbzd7qtDWWFAces7J2DhIPV/5zsUbYdGJWWfGOZl6gmCggOfSIVglDF0woOrvz33uOJPkpW@vger.kernel.org, AJvYcCXw+GSKOKYxRj2c52WzNHU0TlfLqxCGqM/efFq/l0m9gTTpmRUcpVRWaGg+pc0xt48LTH/8wJ2vonv8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0aGgZIrtuqIOCcN2DHlLPL56l1d6xwcYWefFPv9wKQ21c5p9Y
	cIUdPm4z+JzSSkkjT0SarTbmUJmWPVDXMGIjhkCXrfxeYBq/rRKL
X-Gm-Gg: ASbGncsHDPfcHJFClmU51GFQ/Pj89OuBTSuUkYFCZeDnskReFcjZZ41Uk1jhrzrJIKu
	49sREDYc/K46yBZH9mPsAeISXKavv/VdxRLBwr8oRmr34blCzSxEeZt40i4cvYPNH788y1M/dVg
	gcTewmGPBhxkLhAq4pdX04T3OV6NrCYyjWQUd6TadWqnjOYgnImWJC/r20mRCZ5JaKTL03Zw1Uv
	5rTszzvMw5FW3IODG11+QJ+DibKO71gBpHDu2+29ZlclyBk8PML8v5N8K/SCdyHjt+4E8ZhpeCS
	x23/9HQJvshUTwCOGr9A1QoR20sYCTXsqqNLDcjQGa+VXuDPU62tmKKoicULjsT0tIUO6OZQZRc
	9gce1UVi78pMTL5g=
X-Google-Smtp-Source: AGHT+IFFhcQp3KY2NUSUn+6QJWa+866X3ekpgsl+QRwbE/c1yJnpQL9miiamdcfFo8Cm9gfK/apNgg==
X-Received: by 2002:a17:907:c297:b0:abf:6f87:670e with SMTP id a640c23a62f3a-abf6f8768f2mr660219566b.22.1741033678880;
        Mon, 03 Mar 2025 12:27:58 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf64dd565dsm389222166b.101.2025.03.03.12.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:27:57 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 03 Mar 2025 21:27:52 +0100
Subject: [PATCH v2 4/7] clk: bcm21664: Add matching bus clocks for
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kona-bus-clock-v2-4-a363c6a6b798@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741033670; l=4475;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=ZxAskxejw3DV+cuq9u58OlHjwsx94z/3GL/VUKOK1JE=;
 b=WqFr+hpE24EXJ6+urZaYsw8IP1iqT8G3E9xSPZHOkMh5pzIvLP68b5+YrxZsluHpKGj2GOZDR
 u8HdIRLq/3DDAsZ5VwsUvVT59QnOLOMxcjoKy+qxQDgoQ1LoQyDd9ta
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Now that bus clock support has been implemented into the Broadcom Kona
clock driver, add bus clocks corresponding to HUB_TIMER, SDIO, UART and
BSC, as well as the USB OTG bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Adapt to dropped prereq clocks
---
 drivers/clk/bcm/clk-bcm21664.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm21664.c b/drivers/clk/bcm/clk-bcm21664.c
index 520c3aeb4ea9c4a431512c0909f9545c1761d17a..171fbf46ff3b32cf77116d003708643de76fff70 100644
--- a/drivers/clk/bcm/clk-bcm21664.c
+++ b/drivers/clk/bcm/clk-bcm21664.c
@@ -39,6 +39,11 @@ static struct peri_clk_data hub_timer_data = {
 	.trig		= TRIGGER(0x0a40, 4),
 };
 
+static struct bus_clk_data hub_timer_apb_data = {
+	.gate		= HW_SW_GATE(0x0414, 18, 3, 2),
+	.hyst		= HYST(0x0414, 10, 11),
+};
+
 static struct ccu_data aon_ccu_data = {
 	BCM21664_CCU_COMMON(aon, AON),
 	.policy		= {
@@ -48,6 +53,8 @@ static struct ccu_data aon_ccu_data = {
 	.kona_clks	= {
 		[BCM21664_AON_CCU_HUB_TIMER] =
 			KONA_CLK(aon, hub_timer, peri),
+		[BCM21664_AON_CCU_HUB_TIMER_APB] =
+			KONA_CLK(aon, hub_timer_apb, bus),
 		[BCM21664_AON_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -122,6 +129,26 @@ static struct peri_clk_data sdio4_sleep_data = {
 	.gate		= HW_SW_GATE(0x0360, 18, 2, 3),
 };
 
+static struct bus_clk_data sdio1_ahb_data = {
+	.gate		= HW_SW_GATE(0x0358, 16, 0, 1),
+};
+
+static struct bus_clk_data sdio2_ahb_data = {
+	.gate		= HW_SW_GATE(0x035c, 16, 0, 1),
+};
+
+static struct bus_clk_data sdio3_ahb_data = {
+	.gate		= HW_SW_GATE(0x0364, 16, 0, 1),
+};
+
+static struct bus_clk_data sdio4_ahb_data = {
+	.gate		= HW_SW_GATE(0x0360, 16, 0, 1),
+};
+
+static struct bus_clk_data usb_otg_ahb_data = {
+	.gate		= HW_SW_GATE(0x0348, 16, 0, 1),
+};
+
 static struct ccu_data master_ccu_data = {
 	BCM21664_CCU_COMMON(master, MASTER),
 	.policy		= {
@@ -145,6 +172,16 @@ static struct ccu_data master_ccu_data = {
 			KONA_CLK(master, sdio3_sleep, peri),
 		[BCM21664_MASTER_CCU_SDIO4_SLEEP] =
 			KONA_CLK(master, sdio4_sleep, peri),
+		[BCM21664_MASTER_CCU_SDIO1_AHB] =
+			KONA_CLK(master, sdio1_ahb, bus),
+		[BCM21664_MASTER_CCU_SDIO2_AHB] =
+			KONA_CLK(master, sdio2_ahb, bus),
+		[BCM21664_MASTER_CCU_SDIO3_AHB] =
+			KONA_CLK(master, sdio3_ahb, bus),
+		[BCM21664_MASTER_CCU_SDIO4_AHB] =
+			KONA_CLK(master, sdio4_ahb, bus),
+		[BCM21664_MASTER_CCU_USB_OTG_AHB] =
+			KONA_CLK(master, usb_otg_ahb, bus),
 		[BCM21664_MASTER_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -225,6 +262,38 @@ static struct peri_clk_data bsc4_data = {
 	.trig		= TRIGGER(0x0afc, 19),
 };
 
+static struct bus_clk_data uartb_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0400, 16, 0, 1),
+};
+
+static struct bus_clk_data uartb2_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0404, 16, 0, 1),
+};
+
+static struct bus_clk_data uartb3_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0408, 16, 0, 1),
+};
+
+static struct bus_clk_data bsc1_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0458, 16, 0, 1),
+	.hyst		= HYST(0x0458, 8, 9),
+};
+
+static struct bus_clk_data bsc2_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x045c, 16, 0, 1),
+	.hyst		= HYST(0x045c, 8, 9),
+};
+
+static struct bus_clk_data bsc3_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0470, 16, 0, 1),
+	.hyst		= HYST(0x0470, 8, 9),
+};
+
+static struct bus_clk_data bsc4_apb_data = {
+	.gate		= HW_SW_GATE_AUTO(0x0474, 16, 0, 1),
+	.hyst		= HYST(0x0474, 8, 9),
+};
+
 static struct ccu_data slave_ccu_data = {
 	BCM21664_CCU_COMMON(slave, SLAVE),
        .policy		= {
@@ -246,6 +315,20 @@ static struct ccu_data slave_ccu_data = {
 			KONA_CLK(slave, bsc3, peri),
 		[BCM21664_SLAVE_CCU_BSC4] =
 			KONA_CLK(slave, bsc4, peri),
+		[BCM21664_SLAVE_CCU_UARTB_APB] =
+			KONA_CLK(slave, uartb_apb, bus),
+		[BCM21664_SLAVE_CCU_UARTB2_APB] =
+			KONA_CLK(slave, uartb2_apb, bus),
+		[BCM21664_SLAVE_CCU_UARTB3_APB] =
+			KONA_CLK(slave, uartb3_apb, bus),
+		[BCM21664_SLAVE_CCU_BSC1_APB] =
+			KONA_CLK(slave, bsc1_apb, bus),
+		[BCM21664_SLAVE_CCU_BSC2_APB] =
+			KONA_CLK(slave, bsc2_apb, bus),
+		[BCM21664_SLAVE_CCU_BSC3_APB] =
+			KONA_CLK(slave, bsc3_apb, bus),
+		[BCM21664_SLAVE_CCU_BSC4_APB] =
+			KONA_CLK(slave, bsc4_apb, bus),
 		[BCM21664_SLAVE_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
 	},
 };

-- 
2.48.1


