Return-Path: <linux-kernel+bounces-552360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E95A57905
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A8E171B69
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD91B218A;
	Sat,  8 Mar 2025 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy+RqV1l"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BCE1AF0C9;
	Sat,  8 Mar 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420257; cv=none; b=UFGlgy1PtCHGmLq1b6hk2Ji4zjW/TX7PRsvFf4eAdjWYkKwj7HomixM6ey3M7LC1Yk2boZ9MOMxJIwq6pJ1Nto7T39S8jgjS3dwUizSZKeT3YSSXPNUMJKgLos00Gcb96FT0kuMhdJ9XN6r4sZCQIcqpAWoPoJ19klHBy6rfacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420257; c=relaxed/simple;
	bh=oquOoPMtK5XsMhLVUCejF4XDRVd+flbgwR9aw0XPHXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZY8srW8r/dw8o22/S4dT+C0/S2fdLF4I8OFCKtKslpdXmRsCkJpHMp0G3m9AfjLIn1mgPNc3w+VIT3SQn2uPGL+IDMxk/USGpiCZRuxheKkqw9xTW65lP760W4v6lf7CqrbD1xhaVW+lnV5HMVLkZe5FhOxGjFmMiDAtZzVmiaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy+RqV1l; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab78e6edb99so399285966b.2;
        Fri, 07 Mar 2025 23:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741420254; x=1742025054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdeDfCYMxss24IkGa3/+mOupuqDO6lvalt+F3bCiLCY=;
        b=Zy+RqV1lRiCXLo5n13ytcRssadVcSo2C71vSX1tzS1S8mTOkrcnc4L5JtsWXMsaR2K
         EdHbRsmxFCfBQpyWbpx+Zaq6j4oFdPs1qPlbV3/tnkhUDOq/2D65A1boQnHpFruZ5aoB
         o+5n4DKqXbgmVSRsawaLM5ooI1yQSSJErqHpTQmRZugdHFfwoLONnFKJYz7JQZILwQ00
         khSH/+P54/hXysMbxCXOmFJ44PwxLash7aA91T5Mue60Xri02i8sp1lAItd7sZqfks39
         ZgfKXPiefgWOhJeb8L4o7YBU5/M5ruXq69bsEwwl/rkwAAgouJDHjC20uR/4K1r9QltE
         gRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741420254; x=1742025054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdeDfCYMxss24IkGa3/+mOupuqDO6lvalt+F3bCiLCY=;
        b=Hy38Fas9//+47+v9oqqNXHYV60up68R/N1OiAamdQdvpU/Wb0Hx3fnM7D8xInWXIo7
         IF3+2gV+h3XCo1h+ughiVHpZ+ONaLQKTjH1vnxelrg/7TT56dsRrRe4fOCyD2n+oRtkl
         SJTSDunpGcQqX3sLmMzA0Q8RiBkwJf8s4HbC9+iKZHqLOruiUDtPxLs9Ocwt9Nbi6SbN
         jlxeKCmGBvDvdsMLYitHjOdeEnFEUErVcgH/utQABnUEdFkuCmzYSLO71ttcutruOThQ
         5Ll9Jx2br/hoR3pGlHtPld9BVcchDzZel/X7cD1r9fKWeewHCGJK56TJGc2Cm8pK7MU5
         Pr5w==
X-Forwarded-Encrypted: i=1; AJvYcCUr8vf1zt7fRyK7HIjh9lWmnPmkM5G/chZxpPqvshdwdzL3VBL+aybMyGKwIWK/fhqgZU6WMKlSIxUF@vger.kernel.org, AJvYcCWGob6LDymq/VyXFfqGJaKPSN/5moW7fnf6RVEy1AaOidAt+CarZwpvFqclGbzBlPyDR7ZbkZBbSWvZ@vger.kernel.org, AJvYcCXF5+CNaCflzLyxj9edpEWOG8pBjShHnqTZ0OvexSmpCD01wO/sDUx1zvMvkh/tu5lbmtjcZGH/mM8hHVO6@vger.kernel.org
X-Gm-Message-State: AOJu0YyvaC5ADdOgxGIrveQ074/TzkMZj6rLHKclpA11pQPC8iqkMMLe
	GY7/Z1iNrBXOUS6/jL1O5i1GBb2EzYJt+Gn+p8UBEYwlhRR7GhNtFCi/Mg==
X-Gm-Gg: ASbGncs7iu3WLDfjkjn8mDJihuIXlHN+YoB3u9hNIRw0yXThYJbJXsirIw8v61rpDEK
	jSv9uly7tK0QwpZJ+2VD4IuR2B9v/raY+EdnNZqQpH6W6NFjDPc/bu2i8f6yz06AvB6uepA8DAr
	0ZCLRnABpF99w5oMaxWQon29wKTbpo796BYpm6XAqjYKouK0n4rE/sggRQz165DB1+TvyWkXoSc
	evW6gh+ddniykqiUZMUvPTtmsROKfUSfwJ6+aohosV/CiZj/YUE9ls2pNHnzm4OEM4EyL/p8th1
	uKmG/khAZmCvF262Q576V66SVavJCdcsnZ/vs5w3JNzoNEkRRDCX5hzYsVD/xFGLks5walDlaZL
	nZTdNgHdCWpfOKJ3USGih5/ykcQT3
X-Google-Smtp-Source: AGHT+IGdU2JSLdzlGLjqFZfiAiE+xv1mq1kXGmFDhFiz8ZEqjFwXgteMwDJuGokH7cVlZvkZazBmxA==
X-Received: by 2002:a17:907:1c97:b0:ac1:f7a6:fba9 with SMTP id a640c23a62f3a-ac253028efamr757694566b.53.1741420253716;
        Fri, 07 Mar 2025 23:50:53 -0800 (PST)
Received: from hex.my.domain (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm213104766b.106.2025.03.07.23.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:50:52 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 08 Mar 2025 08:50:44 +0100
Subject: [PATCH v3 6/9] clk: bcm21664: Add matching bus clocks for
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-kona-bus-clock-v3-6-d6fb5bfc3b67@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741420241; l=4962;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=oquOoPMtK5XsMhLVUCejF4XDRVd+flbgwR9aw0XPHXc=;
 b=ZId+ES/3D+3LQyHOLlbBz3j3NcrC26QMWeXN5hJAb6Uil7SJvrN51sFxyVVvQJQvuBAEOe4eO
 tS9b5+53a9pAq2Ra8I8n/JyvMpiL1tMzp3dwrk3hqoF6ingJB92HRCo
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Now that bus clock support has been implemented into the Broadcom Kona
clock driver, add bus clocks corresponding to HUB_TIMER, SDIO, UART and
BSC, as well as the USB OTG bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Adapt to CLOCK_COUNT defines being moved

Changes in v2:
- Adapt to dropped prereq clocks
---
 drivers/clk/bcm/clk-bcm21664.c | 89 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm21664.c b/drivers/clk/bcm/clk-bcm21664.c
index fa6e1649d6f5f459b63026109caea9e2f72e22dd..53fd46d97b6514ebe228a874c63cd2cccb8a0f55 100644
--- a/drivers/clk/bcm/clk-bcm21664.c
+++ b/drivers/clk/bcm/clk-bcm21664.c
@@ -41,7 +41,12 @@ static struct peri_clk_data hub_timer_data = {
 	.trig		= TRIGGER(0x0a40, 4),
 };
 
-#define BCM21664_AON_CCU_CLOCK_COUNT	(BCM21664_AON_CCU_HUB_TIMER + 1)
+static struct bus_clk_data hub_timer_apb_data = {
+	.gate		= HW_SW_GATE(0x0414, 18, 3, 2),
+	.hyst		= HYST(0x0414, 10, 11),
+};
+
+#define BCM21664_AON_CCU_CLOCK_COUNT	(BCM21664_AON_CCU_HUB_TIMER_APB + 1)
 
 static struct ccu_data aon_ccu_data = {
 	BCM21664_CCU_COMMON(aon, AON),
@@ -52,6 +57,8 @@ static struct ccu_data aon_ccu_data = {
 	.kona_clks	= {
 		[BCM21664_AON_CCU_HUB_TIMER] =
 			KONA_CLK(aon, hub_timer, peri),
+		[BCM21664_AON_CCU_HUB_TIMER_APB] =
+			KONA_CLK(aon, hub_timer_apb, bus),
 		[BCM21664_AON_CCU_CLOCK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -126,7 +133,27 @@ static struct peri_clk_data sdio4_sleep_data = {
 	.gate		= HW_SW_GATE(0x0360, 18, 2, 3),
 };
 
-#define BCM21664_MASTER_CCU_CLOCK_COUNT	(BCM21664_MASTER_CCU_SDIO4_SLEEP + 1)
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
+#define BCM21664_MASTER_CCU_CLOCK_COUNT	(BCM21664_MASTER_CCU_USB_OTG_AHB + 1)
 
 static struct ccu_data master_ccu_data = {
 	BCM21664_CCU_COMMON(master, MASTER),
@@ -151,6 +178,16 @@ static struct ccu_data master_ccu_data = {
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
@@ -231,7 +268,39 @@ static struct peri_clk_data bsc4_data = {
 	.trig		= TRIGGER(0x0afc, 19),
 };
 
-#define BCM21664_SLAVE_CCU_CLOCK_COUNT	(BCM21664_SLAVE_CCU_BSC4 + 1)
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
+#define BCM21664_SLAVE_CCU_CLOCK_COUNT	(BCM21664_SLAVE_CCU_BSC4_APB + 1)
 
 static struct ccu_data slave_ccu_data = {
 	BCM21664_CCU_COMMON(slave, SLAVE),
@@ -254,6 +323,20 @@ static struct ccu_data slave_ccu_data = {
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


