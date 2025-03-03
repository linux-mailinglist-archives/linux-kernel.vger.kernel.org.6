Return-Path: <linux-kernel+bounces-542705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0A8A4CCAD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B8F7A4840
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2023717F;
	Mon,  3 Mar 2025 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD168CQv"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5822356B1;
	Mon,  3 Mar 2025 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033678; cv=none; b=bTkB9ZosLVQanE19SInQ//2UOHw/7EL8QW00ERvV6N7tVTp6eoq4iB0EqGl92P/A+qJ25go2SXIy4bU7Opc4BfxwqjrQ79hjBIifny+G3Nf9c6kbA0C4E0e/u6MWyZk0Hr4H7J1JGSk92j498gfn5W9bo2P8uWBDyIfnyY8oodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033678; c=relaxed/simple;
	bh=3qMo5aZiPFq1AqGilhGrVZg90T1ltj4KFpUgZtvJ6Us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJJLNfHRkJ38Bw+9eT06MkP+7mOQV0P4xh4C5AdzfvTIlKq7uG4U6BX6flVgq5pbzXJOrrPOI/7v65qZYngnYT3pA1wTWlV7p91XnaTZTv3pfynU1CNx8LC5uEIcbeIsgs6RYBMtHLeD3O7i68TtXiRp5fz1yXO1Gy1j/ddBHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD168CQv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf57138cfaso430634166b.1;
        Mon, 03 Mar 2025 12:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033675; x=1741638475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajgBMCgx3ua0o9zG7DAU7MNDEE+99gCcrWlWJgpzr0g=;
        b=XD168CQvzCcz7EVbDjLD9JzZvVKgBcSAqsAmn8LMuOOUqKPJ3GgAkqIE44KCdxTfos
         XqowZN7hDzjKAPxLFg846KFkrH52XJAXShUGLD++KcTt56KvTdiBF55TgqkXGSu008LN
         1rp5uj+XmyE6MUXWgbWnjESN78RjPnCQSXnE3KxEJUk76Y6wW0kt4hvqI0sjHEsrXi2Q
         WwQde79DBTj6oSLhirDZaDSTIvFCVU4H3JwE2Iwj2AVTiqt5/vknifbNDdwfhL5yzZNo
         t9sAMjHPuqzajBeb+vxFDxItT0DXeq8Zft9Ov3b7Knj0Ia53id10VzripbBcSrJNSMwd
         eZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033675; x=1741638475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajgBMCgx3ua0o9zG7DAU7MNDEE+99gCcrWlWJgpzr0g=;
        b=LYKcJr+Zm2qZOZ1r7ymX+/TWYf9XHLLSGwjDgIzj/Vhh+08C2nofFINyvlRDUCoh7y
         +7hdUfMqHgcfOc+Or/XOo5Mc0Wph1Ofs9aWaetVusM8y9YX5auO2fzEcvrPviuJfUfWK
         H1nz4P2XHLREbEe5Rs7v7f/Uj4ocHtQEhjavRN0oX5CAfd0EAwdKv1brqZhrSVrbAGDE
         J9O79aBUqvrnFIm+CRTFphPjqcc8SL57//9LzPqMbZ/2pHgRad1qtLA6KCro4z1EJojQ
         5dNxZFMBNOfD++tWjBtzlBgTb/Y2+IhVpUuiaXs4FVj6URJU4uhL3A4dwNpx21SPnXug
         SUhA==
X-Forwarded-Encrypted: i=1; AJvYcCUxNoW0DyEcoW8Wg0GHG36J5pfaiuzBgxlTZ90UB2QHVTlQJkx7rtK7Z32H6Ole5ZIgLOC112uq02kn@vger.kernel.org, AJvYcCVS+ZxPYbWdEHy0CQaXkgRjeL2UrwCYYvgIkyySFYwsmcn7aaX0Ad2Mo3G4xzqNIU5+Hf94LAyl9idW4T5x@vger.kernel.org, AJvYcCX6MWslkMWbjzFoJ/TkelX1TRKSDjqgbsxX1/94xB3igv5h2zYxdOFsQBQarwB/m9HTVY8BMvYXasew@vger.kernel.org
X-Gm-Message-State: AOJu0YyyvPUdOdZOsS8rYESFw/Cu6aJtEuZEa5WmOquYxKDyQqlbZdV5
	DUtVoRcL05mEgYK0Gwea70GihrAS+sNrn/A6cvAr82rnzBgPqiqJyIGKrA==
X-Gm-Gg: ASbGncvfnIEr9hkZ3xY/0XxhttkK/HoNZDev9gTmdzskCMS9GoC4+u/gwBgbrC5mvbi
	V3H+vsapujDl8PTqYV+/VF1ahsDs4+rj7FabriKNzg9qA3sTdTyri1SCPilvAMaseWK8LGVNB6f
	tOulJFoC3oH0hSibvc4GPRIA9qpfAI6RJl5uTCceUbCtg3zY4PNlkuaee2w2Cib1/qwUdswWcan
	5E7TWyRbaCfh5q2+UIBRaoYw7CDIM/LeO2+uFrShYa/0959vXBZV1I82+qpz/lOhgCfs7rpHWI5
	NFnTQ3qjs25YXBnJit5nbtkOdWS1JCEEL3luLR3SsNQ/nRsNdptcLy9pI3025P+80HeyW16mwyf
	GP+FQ1J2WGiCU1FE=
X-Google-Smtp-Source: AGHT+IFKexQd4S1Q27FcmeU080YNz80TzZAJa6CzPCnM2J2/lnNHuCnbk5oR/sgvpaVY4zqb1uWXSA==
X-Received: by 2002:a17:906:f588:b0:abf:7a26:c478 with SMTP id a640c23a62f3a-abf7a26c6a0mr510458166b.47.1741033675246;
        Mon, 03 Mar 2025 12:27:55 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf64dd565dsm389222166b.101.2025.03.03.12.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:27:54 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 03 Mar 2025 21:27:50 +0100
Subject: [PATCH v2 2/7] dt-bindings: clock: brcm,kona-ccu: Add BCM281xx bus
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kona-bus-clock-v2-2-a363c6a6b798@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741033670; l=4064;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=3qMo5aZiPFq1AqGilhGrVZg90T1ltj4KFpUgZtvJ6Us=;
 b=3EkDwoPQ+L3HsXPOlMXO2aMhXE99RKHqVrcgSv1PRSj35TWD37ZCJf1+QlhOGldZaYigUWZx5
 02fEZuk7R15AkOoX2OPD1pdu+YwZUXo5gCcqkGtgEVBlVfCpjHdNx0S
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add bus clocks corresponding to peripheral clocks currently supported
by the BCM281xx clock driver and add the relevant clock IDs to the
clock/bcm281xx.h dt-bindings header.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Add this commit (BCM281xx bus clocks)
---
 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   | 21 +++++++++++++++++-
 include/dt-bindings/clock/bcm281xx.h               | 25 +++++++++++++++++++---
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
index dff04e24e92829b890bf7cd336f0e083bdb30fa6..3f7ebaaf3aa7b918c312ab2473bda5ea3b5a1d8e 100644
--- a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
@@ -40,7 +40,7 @@ properties:
 
   clock-output-names:
     minItems: 1
-    maxItems: 14
+    maxItems: 20
 
 required:
   - compatible
@@ -61,6 +61,8 @@ allOf:
             - const: hub_timer
             - const: pmu_bsc
             - const: pmu_bsc_var
+            - const: hub_timer_apb
+            - const: pmu_bsc_apb
   - if:
       properties:
         compatible:
@@ -86,6 +88,13 @@ allOf:
             - const: usb_ic
             - const: hsic2_48m
             - const: hsic2_12m
+            - const: sdio1_ahb
+            - const: sdio2_ahb
+            - const: sdio3_ahb
+            - const: sdio4_ahb
+            - const: usb_ic_ahb
+            - const: hsic2_ahb
+            - const: usb_otg_ahb
   - if:
       properties:
         compatible:
@@ -116,6 +125,16 @@ allOf:
             - const: bsc2
             - const: bsc3
             - const: pwm
+            - const: uartb_apb
+            - const: uartb2_apb
+            - const: uartb3_apb
+            - const: uartb4_apb
+            - const: ssp0_apb
+            - const: ssp2_apb
+            - const: bsc1_apb
+            - const: bsc2_apb
+            - const: bsc3_apb
+            - const: pwm_apb
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/bcm281xx.h b/include/dt-bindings/clock/bcm281xx.h
index d74ca42112e79746c513f6861a89628ee03f0f79..15449f998eb7a5a191fd847b689cfbe60b27c541 100644
--- a/include/dt-bindings/clock/bcm281xx.h
+++ b/include/dt-bindings/clock/bcm281xx.h
@@ -34,7 +34,9 @@
 #define BCM281XX_AON_CCU_HUB_TIMER		0
 #define BCM281XX_AON_CCU_PMU_BSC		1
 #define BCM281XX_AON_CCU_PMU_BSC_VAR		2
-#define BCM281XX_AON_CCU_CLOCK_COUNT		3
+#define BCM281XX_AON_CCU_HUB_TIMER_APB		3
+#define BCM281XX_AON_CCU_PMU_BSC_APB		4
+#define BCM281XX_AON_CCU_CLOCK_COUNT		5
 
 /* hub CCU clock ids */
 
@@ -50,7 +52,14 @@
 #define BCM281XX_MASTER_CCU_USB_IC		4
 #define BCM281XX_MASTER_CCU_HSIC2_48M		5
 #define BCM281XX_MASTER_CCU_HSIC2_12M		6
-#define BCM281XX_MASTER_CCU_CLOCK_COUNT		7
+#define BCM281XX_MASTER_CCU_SDIO1_AHB		7
+#define BCM281XX_MASTER_CCU_SDIO2_AHB		8
+#define BCM281XX_MASTER_CCU_SDIO3_AHB		9
+#define BCM281XX_MASTER_CCU_SDIO4_AHB		10
+#define BCM281XX_MASTER_CCU_USB_IC_AHB		11
+#define BCM281XX_MASTER_CCU_HSIC2_AHB		12
+#define BCM281XX_MASTER_CCU_USB_OTG_AHB		13
+#define BCM281XX_MASTER_CCU_CLOCK_COUNT		14
 
 /* slave CCU clock ids */
 
@@ -64,6 +73,16 @@
 #define BCM281XX_SLAVE_CCU_BSC2			7
 #define BCM281XX_SLAVE_CCU_BSC3			8
 #define BCM281XX_SLAVE_CCU_PWM			9
-#define BCM281XX_SLAVE_CCU_CLOCK_COUNT		10
+#define BCM281XX_SLAVE_CCU_UARTB_APB		10
+#define BCM281XX_SLAVE_CCU_UARTB2_APB		11
+#define BCM281XX_SLAVE_CCU_UARTB3_APB		12
+#define BCM281XX_SLAVE_CCU_UARTB4_APB		13
+#define BCM281XX_SLAVE_CCU_SSP0_APB		14
+#define BCM281XX_SLAVE_CCU_SSP2_APB		15
+#define BCM281XX_SLAVE_CCU_BSC1_APB		16
+#define BCM281XX_SLAVE_CCU_BSC2_APB		17
+#define BCM281XX_SLAVE_CCU_BSC3_APB		18
+#define BCM281XX_SLAVE_CCU_PWM_APB		19
+#define BCM281XX_SLAVE_CCU_CLOCK_COUNT		20
 
 #endif /* _CLOCK_BCM281XX_H */

-- 
2.48.1


