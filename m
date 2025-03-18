Return-Path: <linux-kernel+bounces-565703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35405A66DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4448C1894163
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A21205E15;
	Tue, 18 Mar 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYUm95bM"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58EF204F65;
	Tue, 18 Mar 2025 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285616; cv=none; b=dsLoEDiSlb240v1ZbrcFMh07SBGS35KIjJYSMdY2iD8M0pPT/+PnFO5rlnxmt7cEaLxYtYjOVQcbpHiFFdd0Ki/vKUfPIuaAQ0aFubvT6AmFnPOBisLT/rfdaDvruxN1yhyR2fhULCANkmHCSeMheaF5EWUNQT/U861ylutEYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285616; c=relaxed/simple;
	bh=jO9yj4JdRvUHJD48dysafY3oqOFcvgf3S97G+AoKBvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZpT5l43IMYhBeLCE7ygLdVpN+EKghQ4Ps8iWIFTLIvYIjO0/DgC9xai+d4/I9RDyHRL1vIEpV/0t3CEcmEeAn8Xv1LgOqi4ChSNiEGIW7YcfeQco3qcfZhl9MtqN3M9Hn46i5VcCjRoQdMk6c9wGQGQFaYZ0FYuThzF4ybxdaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYUm95bM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so627852a12.0;
        Tue, 18 Mar 2025 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742285613; x=1742890413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/vNqSTjvJUXMbbkSLuN6N5IpjUTnGZf9pVtdHyq3+s=;
        b=bYUm95bMre8dz7zvUKw+aye8hxRU63Z2S9SjAd0ugfpcIuDR8hgjezwxlzJrQ/hpLb
         IOCKsmMIJJVnAhi8n3lUJJ3QZYQHs+C2qH1jXz65ivpFv1b+Bw5bWzzUSqaAD6cfX4dP
         hqGOJDTUKPW1BfllvPVB+tKr8JQxIShUZq5v40QxPXnf86vK5pTpTFlZQGykkKi+g0W8
         Q5BTFZXgARXPwm6j5T1dTB2zaVB2w46EVVG3HTpSzV9DOQ2q39iAIfbff4tdtvMxd38V
         KulMZuFEuu9r9u3TqBnHw58buJKLQSiCtH88rdJW9q8fHofcqEi3L3bj90KD0IA0u2S8
         qX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285613; x=1742890413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/vNqSTjvJUXMbbkSLuN6N5IpjUTnGZf9pVtdHyq3+s=;
        b=lAchvH6tIQWc/o9YWoDPi9eCfiVU+xlFqpaSXlHcebpvrhbrLGwAKx184Z5WsrqpMz
         ax8Jj7cP+5EQ5KERiZo4RZlg70BhQAiQbBHmroI17ylQtzgNYvwmMNYpPC0OCJoFZ3G1
         mQLgBpBxHMOlNso/mecHwO/tFnRsYNH3gV5ufAnZ9+eunXyOKwJvL68Xn5sGwGdFKSz5
         4xQWpmT04Dm0jduEy9sm3MkwgOZxjc56u1yjLScGgEadGwNBcffVEryclsBhIM9n720h
         9Spj9YYSRRBrNCnY9M+O6zMcQXRLXqQuVh/Om8u5w6/bMbZvA5NwJnIMyM7+8hvN2Cn+
         K5QA==
X-Forwarded-Encrypted: i=1; AJvYcCUtF3Cqo+F/r+Puzc884Hq8zdOLJnYyBqrkHGjtcOjy3FV2W1tCaSGaMcebjTrlrlyGHPETsSK0nd1r@vger.kernel.org, AJvYcCWvTEVBanP5SebSR9qXvu732nDofQxjC7kfcs0Hl/HIM0SGw9iVFs+BcQ2mfyj/s7iHKZLKyS8HZosDmcJ2@vger.kernel.org, AJvYcCXzJkUnuOaWri6VNx4PRQppSzli8zuO/VELjm+O/Bn1W4vASXPBVFM2Jxx/nY47pZTk57PcQ5atBPeP@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFUYonsT+2YoDNzsNlMN4FwMbMczZ1zV2/OtUzZg2bWqt7BnF
	fmgB99QJDXnrnOrBBC8+Dk50j2rqTBcX+dwQkBbplZCgkz0B4rf8
X-Gm-Gg: ASbGncsWOwy3P+4ApKNklQKdtWT3NqUoqRagjpMQsjaiaFvSHE0YhTDt+2haFv4CP6Z
	ifYK51SA8WHtyjhFH7j8paHSsYWNDMe8nH6pVVBdDEQZk0ZV7/A1rcsTes6zUMw0chEh66nO0/S
	ur0h47QXcHexvBqSpJTuoVFeovtIHtUR+ygbTk2C63UX6Clc2RrWPmmfO4+nGzVE4PyV559VXeZ
	F9vKgCgppfEOuTGo7k/GXA864K2BHGQrqkpjfMMmefr7bh/gIAZBc3cNHwrGij8l2wwlpFfPHVG
	7BevqV1N3kNbL1FW5SarR39tWiP6Hts2Ori91BKSbzspJfUpXNPWK+U4xH/liOCMkRbQmnSRZII
	I4pIzKoVqrTNblHjAVg==
X-Google-Smtp-Source: AGHT+IH153oj2Wa5DvE2ucE8RWRnoITAXzB0tQKCKsJWV4NeJbW5lPk4zAJXXhSnFkwRyy28AqG2Rw==
X-Received: by 2002:a05:6402:84f:b0:5e7:dcab:1df8 with SMTP id 4fb4d7f45d1cf-5e8a0426a94mr12941324a12.26.1742285612929;
        Tue, 18 Mar 2025 01:13:32 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad392csm7176097a12.53.2025.03.18.01.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:13:32 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 18 Mar 2025 09:13:27 +0100
Subject: [PATCH v4 5/8] clk: bcm21664: Add corresponding bus clocks for
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-kona-bus-clock-v4-5-f54416e8328f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742285605; l=5067;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=jO9yj4JdRvUHJD48dysafY3oqOFcvgf3S97G+AoKBvI=;
 b=I9dYYczZ68d/6DWw8zgksZaoYUB+PhC3Gut7zDeW4gsslma5Rdl/2uspI7h7J5PQVwtTKwIBr
 Qrm3VebE2a1CQg42gvt53FprjsaG90tXM1dXUPF6TYGoffGIxPdOw5w
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Now that bus clock support has been implemented into the Broadcom Kona
clock driver, add bus clocks corresponding to HUB_TIMER, SDIO, UART and
BSC, as well as the USB OTG bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Adapt to CLOCK_COUNT -> CLK_COUNT rename
- Change commit summary to match equivalent BCM281xx commit

Changes in v3:
- Adapt to CLOCK_COUNT defines being moved

Changes in v2:
- Adapt to dropped prereq clocks
---
 drivers/clk/bcm/clk-bcm21664.c | 89 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm21664.c b/drivers/clk/bcm/clk-bcm21664.c
index 14b7db824704824b4a6bfcce79308afa44e092c6..4223ac1c35a258bd30ba2bd4b240da6b1e88fa06 100644
--- a/drivers/clk/bcm/clk-bcm21664.c
+++ b/drivers/clk/bcm/clk-bcm21664.c
@@ -41,7 +41,12 @@ static struct peri_clk_data hub_timer_data = {
 	.trig		= TRIGGER(0x0a40, 4),
 };
 
-#define BCM21664_AON_CCU_CLK_COUNT	(BCM21664_AON_CCU_HUB_TIMER + 1)
+static struct bus_clk_data hub_timer_apb_data = {
+	.gate		= HW_SW_GATE(0x0414, 18, 3, 2),
+	.hyst		= HYST(0x0414, 10, 11),
+};
+
+#define BCM21664_AON_CCU_CLK_COUNT	(BCM21664_AON_CCU_HUB_TIMER_APB + 1)
 
 static struct ccu_data aon_ccu_data = {
 	BCM21664_CCU_COMMON(aon, AON),
@@ -52,6 +57,8 @@ static struct ccu_data aon_ccu_data = {
 	.kona_clks	= {
 		[BCM21664_AON_CCU_HUB_TIMER] =
 			KONA_CLK(aon, hub_timer, peri),
+		[BCM21664_AON_CCU_HUB_TIMER_APB] =
+			KONA_CLK(aon, hub_timer_apb, bus),
 		[BCM21664_AON_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -126,7 +133,27 @@ static struct peri_clk_data sdio4_sleep_data = {
 	.gate		= HW_SW_GATE(0x0360, 18, 2, 3),
 };
 
-#define BCM21664_MASTER_CCU_CLK_COUNT	(BCM21664_MASTER_CCU_SDIO4_SLEEP + 1)
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
+#define BCM21664_MASTER_CCU_CLK_COUNT	(BCM21664_MASTER_CCU_USB_OTG_AHB + 1)
 
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
 		[BCM21664_MASTER_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };
@@ -231,7 +268,39 @@ static struct peri_clk_data bsc4_data = {
 	.trig		= TRIGGER(0x0afc, 19),
 };
 
-#define BCM21664_SLAVE_CCU_CLK_COUNT	(BCM21664_SLAVE_CCU_BSC4 + 1)
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
+#define BCM21664_SLAVE_CCU_CLK_COUNT	(BCM21664_SLAVE_CCU_BSC4_APB + 1)
 
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
 		[BCM21664_SLAVE_CCU_CLK_COUNT] = LAST_KONA_CLK,
 	},
 };

-- 
2.48.1


