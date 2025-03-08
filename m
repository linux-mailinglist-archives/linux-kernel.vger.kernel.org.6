Return-Path: <linux-kernel+bounces-552358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B532A578FF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563FB1898850
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462621AF0C1;
	Sat,  8 Mar 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnNffTx7"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2AA1AB528;
	Sat,  8 Mar 2025 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420254; cv=none; b=SGvxMjE76YgxWjPtSiFB5TKCxXZUOeY7qnzlgOmKcZHItEBVy5T1ptbU0NdgMoBri/CYG1fnTzIzyEHBX4SSTzYvOcXvVT4bAk5DJMlzCERSvrN/SxL1sStpXRHimzzXwLlCBKpOWDxxZXmcIhaQnUe6J27vwKeSPM2JlG0fwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420254; c=relaxed/simple;
	bh=KwnPacKC6sWDvjHgOSmanHuUb/zLQ7+jh/3FbyRmuek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPYkrC2tXK3kpCf/661PjpMe82d9wWP7xaTYZRtlP/MjL9dy+rllj3cZgNtFrnomTbOVbKjgMUCOpYvggQQclNp/eTSWhAOD1x5ujfnDFquXfI07XtQDHpBOR1h2ckUpAUjV8TmaaX096kvYUKvuCb9hWwo5U3rTFAheo6+aGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnNffTx7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbb12bea54so496618266b.0;
        Fri, 07 Mar 2025 23:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741420251; x=1742025051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LA7xsvJ0m2dD01Y8sMOZnylXEmlfqAhKGTnpOReuMHE=;
        b=UnNffTx7xIdoo3zdzmr/H/AQ2VavDYXfxGJCCR7wVK9CxdJVIp8EWW86jxdwC8wvU5
         WnDVqRwovM/3wy/8hqfmSmNibkh5RC5FcnCdzarYMAiFGKP9Lwmijg6m57Y1QEMuQ+7b
         2LjnIa+kclZSgbxSktQlhxtb/5hsCv1CtjP67S8eZcNaTXd2NETl5G9zJfQ9ft9l2Ht/
         +1Cr/W9k/+hxCgQ4vWkzZA27SSBeXFHzH9Ru2FKbs/YwadnUZi90BflEClUwD6CR10zo
         30gU2O+7gOOgGevorm5MilO0/q3eUCJtfpuYmnI4qp9Nf0lJUe9/rU8csIoIwFWEXgik
         YF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741420251; x=1742025051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA7xsvJ0m2dD01Y8sMOZnylXEmlfqAhKGTnpOReuMHE=;
        b=Zoc9PVGMJD46B72jqK8rmkrXettbjIsxtgv7KwWIvHaPK7JhESmx3Q37QlMhqOZDXj
         WaWVZYHiC/V9a6042EWFjOQcrit5hZFQhzKxYiBwSyMdUVMtIRuZLuiY5dnxelUeB9y9
         Qe81djgZaVne2Vlz8IRx8POqcIPMET45WKD5zraDRj6O1Xie1DvjgfNg18hwvx7lqQDT
         jngTbfnuTGZ9lu5dEtdB2r+/BbRhgSVIEoYB0XW9njvbZYSnp2+0+6wobNAhTuSN39q/
         Dlg43xulXXvhuukRfRmvKeX/m3+WKdDOehRlQ9n3JZcy1yAowVpmQt0XBiWJ+5p5YYN+
         BTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAx/vcNHOYnZ4i3MW6jALG1oIsajTBUnEBbSUCpL8YbOJ5u15FPV+QRtQ0BCUTMOmFjzTqt+SAGwff@vger.kernel.org, AJvYcCWNCCKDm2uYdQ24bUUkzKfgF9UMGivBpdNYW7JBTkzAamYXgFV8cAMCXMmb5xusETMJsyIlWu3Ote/zmiIB@vger.kernel.org, AJvYcCWVXQ5WlUKlpkP0RnRf3POBWvR5dGGnWsQanA7qTwo2tisbOk96l5Xw+k/SrVdim0toaC3kzBdt7XNc@vger.kernel.org
X-Gm-Message-State: AOJu0YxADdCnteUM8E3e2BYlgjxF3Qf9o+AgPrMPet1P6fOlREc1cmCv
	v1NIOlhy8GLqkiGk0QFpLbyVTC31d2VCxgwmppjZ6E6PUfHk5L0r
X-Gm-Gg: ASbGnctjWqy4BVuaCzOprXiFxRFmIPPpHh722ABdQEYYw/BCEZbaiVrOOLZUzfU7dXJ
	Bkp+fmX26aJpJww7JeA1qCKQHgoIY0Y8bNK4uImZVksjPmNbkfek8uRJcJUNTo42Ovv40pvRyGh
	jMad3nI+Aq9W5WdpA9tNqWlIGYd5Nv5ILWZ+LvVa+fxxBbyCFuTUuyrvgz1e7Lc6r+2JCo3pLeH
	+dRTgImrtB0qBnrEDJ04SblStCgCxX11SzSFQLoIlEiwtz4DrKSwyx5lu87VGNSOR+v74Zio403
	fgXEXC8sM2KeegOARZhAifrElDLoSb+85ULdu7lXGjo8Z4C5ByCo1VZ/Wr0noiYEUKVqqB31Zv0
	lE30SnTiIEpD7011X5Q==
X-Google-Smtp-Source: AGHT+IGQjSgdMA5MmzqjcW9VvIs8K4gyTJ48YAIPs4DQ92Z7rJP5J+6Say4oe24J/aZ/rAgUEtsMFw==
X-Received: by 2002:a17:907:3f2a:b0:abf:76d1:f0fd with SMTP id a640c23a62f3a-ac2525f9ae1mr647282566b.19.1741420250684;
        Fri, 07 Mar 2025 23:50:50 -0800 (PST)
Received: from hex.my.domain (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm213104766b.106.2025.03.07.23.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:50:49 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 08 Mar 2025 08:50:42 +0100
Subject: [PATCH v3 4/9] dt-bindings: clock: brcm,kona-ccu: Add BCM281xx bus
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-kona-bus-clock-v3-4-d6fb5bfc3b67@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741420241; l=4555;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=KwnPacKC6sWDvjHgOSmanHuUb/zLQ7+jh/3FbyRmuek=;
 b=pdaBNr+Psc2iIbdwdhvwFirksVMOyVKYYmX+sWBBJBotxVmZOMY11gXf9223kP0v3QGeVSzU6
 JnsoQkwNfo2BUWTAZvCtQghejW5JDX0Uo9aEKbDE9yaQKzLGFeIwvnc
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add bus clocks corresponding to peripheral clocks currently supported
by the BCM281xx clock driver and add the relevant clock IDs to the
clock/bcm281xx.h dt-bindings header.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Add more clock output names to example
- Drop CLOCK_COUNT defines from the DT binding header

Changes in v2:
- Add this commit (BCM281xx bus clocks)
---
 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   | 33 ++++++++++++++++++++--
 include/dt-bindings/clock/bcm281xx.h               | 19 +++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
index dff04e24e92829b890bf7cd336f0e083bdb30fa6..d00dcf916b45904177614c6f19a5df02abdf42f7 100644
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
@@ -190,6 +209,16 @@ examples:
                            "bsc1",
                            "bsc2",
                            "bsc3",
-                           "pwm";
+                           "pwm",
+                           "uartb_apb",
+                           "uartb2_apb",
+                           "uartb3_apb",
+                           "uartb4_apb",
+                           "ssp0_apb",
+                           "ssp2_apb",
+                           "bsc1_apb",
+                           "bsc2_apb",
+                           "bsc3_apb",
+                           "pwm_apb";
     };
 ...
diff --git a/include/dt-bindings/clock/bcm281xx.h b/include/dt-bindings/clock/bcm281xx.h
index 0c7a7e10cb425ddb597392939cb218545a48bf22..8e3ac4ab3e16fb33a82259ccb82287fdfbb749bc 100644
--- a/include/dt-bindings/clock/bcm281xx.h
+++ b/include/dt-bindings/clock/bcm281xx.h
@@ -33,6 +33,8 @@
 #define BCM281XX_AON_CCU_HUB_TIMER		0
 #define BCM281XX_AON_CCU_PMU_BSC		1
 #define BCM281XX_AON_CCU_PMU_BSC_VAR		2
+#define BCM281XX_AON_CCU_HUB_TIMER_APB		3
+#define BCM281XX_AON_CCU_PMU_BSC_APB		4
 
 /* hub CCU clock ids */
 
@@ -47,6 +49,13 @@
 #define BCM281XX_MASTER_CCU_USB_IC		4
 #define BCM281XX_MASTER_CCU_HSIC2_48M		5
 #define BCM281XX_MASTER_CCU_HSIC2_12M		6
+#define BCM281XX_MASTER_CCU_SDIO1_AHB		7
+#define BCM281XX_MASTER_CCU_SDIO2_AHB		8
+#define BCM281XX_MASTER_CCU_SDIO3_AHB		9
+#define BCM281XX_MASTER_CCU_SDIO4_AHB		10
+#define BCM281XX_MASTER_CCU_USB_IC_AHB		11
+#define BCM281XX_MASTER_CCU_HSIC2_AHB		12
+#define BCM281XX_MASTER_CCU_USB_OTG_AHB		13
 
 /* slave CCU clock ids */
 
@@ -60,5 +69,15 @@
 #define BCM281XX_SLAVE_CCU_BSC2			7
 #define BCM281XX_SLAVE_CCU_BSC3			8
 #define BCM281XX_SLAVE_CCU_PWM			9
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
 
 #endif /* _CLOCK_BCM281XX_H */

-- 
2.48.1


