Return-Path: <linux-kernel+bounces-516668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72204A37591
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7383AC91C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F08819E97A;
	Sun, 16 Feb 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsQrPb5w"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48119D07A;
	Sun, 16 Feb 2025 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722377; cv=none; b=s2+wrrjvcRYT2MnTBjdzaRiKPiCko1uJ3pnJEeCvEUBTeCxIu+4bSuvEIdnnOgwsiLSGbvDh1JgoL72JVXsz+pwBG8PEDt6vRTc3y2MaEYoGVj/jIZhpDBNp2SPRMGaKpNNeOTSPssNl6atD3qJ2eRIa4RfcsWsGMlfpvpNFTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722377; c=relaxed/simple;
	bh=bLlKBR/fpwcRFHbKSMGsIt7sEUfozoFN+TKaviTKp0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i4X+qUPZA1TCiSngRGdg5F36XhlpRTEAtGSrhWZ7zsq2sy951n625BLlt8pzLKn7WcIsSGQmzu17okGR3pUxdPg2nhZGtughgiIO5Z9rQHKevcevEkySctDn4gNwaKkyLSlzEpBDih9DcC8zyFx5poeWbN/IhyyhKpugkPC7ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsQrPb5w; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaec61d0f65so752956766b.1;
        Sun, 16 Feb 2025 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739722374; x=1740327174; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/R5shfvi4g7oMPn8cw9ImYbr1L1mAF4Luh9InPtUqg=;
        b=IsQrPb5wG0ZTc9JPqNCcu0zXcu6iqVMSP0u3BhgLWao/FdB5rB6egYg4uG87+WCbc5
         cTipWCq+mGMM4fmFPU1sIIz8pIG6y1uAZFTVotF8hfXN27+ThnpGeayFBcA2JfQrxuqU
         Hz6XPkmacffmEzl+EILFDEDmThs1l0HEhI4gdNfyjvBi2W6A9sXP/l1W6JBpD1r6nOS5
         vLgVJfU0m6KZGugAuw3E7agkiZohaghPAx5V1SQkQUBeImDn0k/yqAGifv6/O/L0parv
         7/TwpwJhV+h8uDgq9OXZ/vX90M5lPobBQ5L9B50BAOtDWGeJBVst0CdpNSXovJmkOwO3
         bGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739722374; x=1740327174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/R5shfvi4g7oMPn8cw9ImYbr1L1mAF4Luh9InPtUqg=;
        b=P0tjJ2fCCUYb3Lt5ksMwrA943EbZCgZ8M5qczQRK3227oswRL/tX/y5lct5trbNh5c
         K+/Ce//u4nQg0q7qG5z88KE8OXgfFTrFfkB5PeNfW3LCjTJcwv6AjwtfFdZ6SHUJPS7k
         NeDhd+8q57ANNTtyyhsgJWBzy/1i5K5eyXmcgyTBqmhVdQDy+a1h65SA7CmQf/GIEa0y
         Ba2dqYCNBnQraX7SaI01fDrc54HR+GBEnz1dzcO64pUBsmk0fHfnx+nURjXyVR1Nyxax
         0TN81i/awnWAwh7q2/sNdjg1JOGTVCqrE/hXkjGX94TKMNCoF4frffMpK5wpD2tzjg0R
         +TmA==
X-Forwarded-Encrypted: i=1; AJvYcCWDDIwusE1CsjZxTwgrpkTOQ+VxetAbA2Fi/Q0uSog3Wq8uzA5qOkoUaUdQLUSUPx6bhQ2fqQftkhnN@vger.kernel.org, AJvYcCWgmACFW8/oTRmjOBoAIdNs+1G3mRFwukpa2uuxukDW/AOoGKgTR/QGnmh+wl8LH5o7iIH2D46ZcPRx@vger.kernel.org, AJvYcCXMUx0SpVtf83Stm/X+JA3NB+4S8t80WsrfwjVRU1hVeQ4sTg7OrJFBvqKNXmnfbMCE2pXmaOYSQ4Xy2A8i@vger.kernel.org
X-Gm-Message-State: AOJu0YwFA/ck67XMa9rsS6pI+82Oa50H8zyrA4DPK+OKQ03mk5hUytHC
	a7sIISOvjPtRtvwXngBPOZQAQKEeFQXk87nt7LpFQWshWrH50rXhVFn74g==
X-Gm-Gg: ASbGncu/hpVOoJ8tpYAgcFnw5Y+1OlP2fxS/eMOpy6MPpC94CjLZcE9lObKFYoeEFLL
	wFAH7OJOF1aneIXQKdCoprCweEtVGPbITSN892ei6ftm7L1x4tm9Omg73zxqpU5SrTYg7xx9r4E
	Os7lXYl3dMGTM7Ry5Dk/5QMInnWcZYiOHiU4VWaFDS8qgYq/5TIYsDyUagNkEKkXQ732pamTY7U
	Dot4z++h2JB+7zC0/OVrXNqlU8RnRIh6kCp0GQeLvD65r2ZqnX7fkt5yKcc7XM2jtEhAn/KefYY
	tyZq69vbcDuUVUiRXG5CvlRfNZX8UwtHW6kIEyARc4Fu3LBXMzZIUwhI2iAbuQ==
X-Google-Smtp-Source: AGHT+IEc4fa9aQqMs6Hkl7wBJhiSx39pgqldlhSZGRQufo5ch84A6G9itwGa0xnnk6M0zRgP1kTguA==
X-Received: by 2002:a17:906:c14c:b0:ab6:da18:9a3 with SMTP id a640c23a62f3a-abb7115ffdamr610635366b.46.1739722373555;
        Sun, 16 Feb 2025 08:12:53 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm148463466b.161.2025.02.16.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:12:53 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Feb 2025 17:12:39 +0100
Subject: [PATCH RFC 4/5] clk: bcm21664: Add matching bus clocks for
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250216-kona-bus-clock-v1-4-e8779d77a6f2@gmail.com>
References: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
In-Reply-To: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739722366; l=7610;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=bLlKBR/fpwcRFHbKSMGsIt7sEUfozoFN+TKaviTKp0A=;
 b=NXULbaNxhoYHUjH/FEMwhve1priRbY5uyMkMvAvEH7yZowcqHn2sp1vQACmDBmkh0qK1Ql7Ju
 LlxwIHIekIkAcuSzpbWZgVqVPcXbSeoBZlJdjIxyePj4XBmA2pn7PMz
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Now that bus clock support has been implemented into the Broadcom Kona
clock driver, add bus clocks corresponding to HUB_TIMER, SDIO, UART and
BSC, as well as the USB OTG bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/clk/bcm/clk-bcm21664.c       | 107 +++++++++++++++++++++++++++++++----
 include/dt-bindings/clock/bcm21664.h |  19 ++++++-
 2 files changed, 111 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm21664.c b/drivers/clk/bcm/clk-bcm21664.c
index 520c3aeb4ea9c4a431512c0909f9545c1761d17a..c9d15bde1d49c345c160880f72c96aea94dd9f55 100644
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
@@ -47,7 +52,9 @@ static struct ccu_data aon_ccu_data = {
 	},
 	.kona_clks	= {
 		[BCM21664_AON_CCU_HUB_TIMER] =
-			KONA_CLK(aon, hub_timer, peri),
+			KONA_CLK_PREREQ(aon, hub_timer, peri, hub_timer_apb),
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
@@ -130,13 +157,13 @@ static struct ccu_data master_ccu_data = {
 	},
 	.kona_clks	= {
 		[BCM21664_MASTER_CCU_SDIO1] =
-			KONA_CLK(master, sdio1, peri),
+			KONA_CLK_PREREQ(master, sdio1, peri, sdio1_ahb),
 		[BCM21664_MASTER_CCU_SDIO2] =
-			KONA_CLK(master, sdio2, peri),
+			KONA_CLK_PREREQ(master, sdio2, peri, sdio2_ahb),
 		[BCM21664_MASTER_CCU_SDIO3] =
-			KONA_CLK(master, sdio3, peri),
+			KONA_CLK_PREREQ(master, sdio3, peri, sdio3_ahb),
 		[BCM21664_MASTER_CCU_SDIO4] =
-			KONA_CLK(master, sdio4, peri),
+			KONA_CLK_PREREQ(master, sdio4, peri, sdio4_ahb),
 		[BCM21664_MASTER_CCU_SDIO1_SLEEP] =
 			KONA_CLK(master, sdio1_sleep, peri),
 		[BCM21664_MASTER_CCU_SDIO2_SLEEP] =
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
@@ -233,19 +302,33 @@ static struct ccu_data slave_ccu_data = {
 	},
 	.kona_clks	= {
 		[BCM21664_SLAVE_CCU_UARTB] =
-			KONA_CLK(slave, uartb, peri),
+			KONA_CLK_PREREQ(slave, uartb, peri, uartb_apb),
 		[BCM21664_SLAVE_CCU_UARTB2] =
-			KONA_CLK(slave, uartb2, peri),
+			KONA_CLK_PREREQ(slave, uartb2, peri, uartb2_apb),
 		[BCM21664_SLAVE_CCU_UARTB3] =
-			KONA_CLK(slave, uartb3, peri),
+			KONA_CLK_PREREQ(slave, uartb3, peri, uartb3_apb),
 		[BCM21664_SLAVE_CCU_BSC1] =
-			KONA_CLK(slave, bsc1, peri),
+			KONA_CLK_PREREQ(slave, bsc1, peri, bsc1_apb),
 		[BCM21664_SLAVE_CCU_BSC2] =
-			KONA_CLK(slave, bsc2, peri),
+			KONA_CLK_PREREQ(slave, bsc2, peri, bsc2_apb),
 		[BCM21664_SLAVE_CCU_BSC3] =
-			KONA_CLK(slave, bsc3, peri),
+			KONA_CLK_PREREQ(slave, bsc3, peri, bsc3_apb),
 		[BCM21664_SLAVE_CCU_BSC4] =
-			KONA_CLK(slave, bsc4, peri),
+			KONA_CLK_PREREQ(slave, bsc4, peri, bsc4_apb),
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
diff --git a/include/dt-bindings/clock/bcm21664.h b/include/dt-bindings/clock/bcm21664.h
index 7c7492742f3d4ca439236f2f352e432989409570..8d3e3796c72b02eace84dfb90d6264dee0297a33 100644
--- a/include/dt-bindings/clock/bcm21664.h
+++ b/include/dt-bindings/clock/bcm21664.h
@@ -26,7 +26,8 @@
 /* aon CCU clock ids */
 
 #define BCM21664_AON_CCU_HUB_TIMER		0
-#define BCM21664_AON_CCU_CLOCK_COUNT		1
+#define BCM21664_AON_CCU_HUB_TIMER_APB		1
+#define BCM21664_AON_CCU_CLOCK_COUNT		2
 
 /* master CCU clock ids */
 
@@ -38,7 +39,12 @@
 #define BCM21664_MASTER_CCU_SDIO2_SLEEP		5
 #define BCM21664_MASTER_CCU_SDIO3_SLEEP		6
 #define BCM21664_MASTER_CCU_SDIO4_SLEEP		7
-#define BCM21664_MASTER_CCU_CLOCK_COUNT		8
+#define BCM21664_MASTER_CCU_SDIO1_AHB		8
+#define BCM21664_MASTER_CCU_SDIO2_AHB		9
+#define BCM21664_MASTER_CCU_SDIO3_AHB		10
+#define BCM21664_MASTER_CCU_SDIO4_AHB		11
+#define BCM21664_MASTER_CCU_USB_OTG_AHB		12
+#define BCM21664_MASTER_CCU_CLOCK_COUNT		13
 
 /* slave CCU clock ids */
 
@@ -49,6 +55,13 @@
 #define BCM21664_SLAVE_CCU_BSC2			4
 #define BCM21664_SLAVE_CCU_BSC3			5
 #define BCM21664_SLAVE_CCU_BSC4			6
-#define BCM21664_SLAVE_CCU_CLOCK_COUNT		7
+#define BCM21664_SLAVE_CCU_BSC1_APB		7
+#define BCM21664_SLAVE_CCU_BSC2_APB		8
+#define BCM21664_SLAVE_CCU_BSC3_APB		9
+#define BCM21664_SLAVE_CCU_BSC4_APB		10
+#define BCM21664_SLAVE_CCU_UARTB_APB		11
+#define BCM21664_SLAVE_CCU_UARTB2_APB		12
+#define BCM21664_SLAVE_CCU_UARTB3_APB		13
+#define BCM21664_SLAVE_CCU_CLOCK_COUNT		14
 
 #endif /* _CLOCK_BCM21664_H */

-- 
2.48.1


