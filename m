Return-Path: <linux-kernel+bounces-542704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49432A4CCAA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D617A87C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0D236425;
	Mon,  3 Mar 2025 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLI8F04I"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68D230BF4;
	Mon,  3 Mar 2025 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033677; cv=none; b=Uy507Y4BLRRt0SJume5ye2c/gLfk2NHtlf8yCSobKq2ZYhXhcIP8z6hxAr6hXa2WgQY5IMbH4tifjEPCuVjK0Dbe5KXbub+D/JCvM0CeO1lONFlPtAUf3tJtwGObUPfjWIviDkV09r89/iDvDySEGF3qd+t7kofBoIlZoegjhR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033677; c=relaxed/simple;
	bh=+1NQgL2nKvBCPiU2nmmHUiXn5bmc6OZXYhfS37+RPTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJlKqz75GMWdL46Zo1hqBwCcXi11J4F5/cJzmav+tQVAI2b2e6zvg8vhSTV9P9MVZDXXaoR0TPyjlBnDeeKRKIdrRW3cduUQrT4qkOBXl0I5LDL8llIlu9sjGg9rH4oq/vDp2HlrqJlyPxVXjQ9ok0tjzjyRWwgi0Z8y+vff2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLI8F04I; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so5557551a12.3;
        Mon, 03 Mar 2025 12:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033674; x=1741638474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ptFxDPzgcOCh3UJGfp4f6HXuiEkVzN5ocExDfIA7xc=;
        b=mLI8F04IzdOOW+JD/BZo+MtK4TlsulSYz7JjHX+5A1zobE0UJf45HVgf6sRyrtwO3p
         WDkQnbzWHUNBMvtP9oZiPU28nKYEJtkapASEkgv+r7yoWVwhLQf7DYnJsT1Q6x+hedRl
         SpERBJKc+KEJDoJsoCBpokLNivoC44/zI1pvg3tBf5TYh/nVcwsLiBtn2oweGUMBBxaJ
         xfuKKgelygDWvH8lfFYeuvBmlPRY9lC+bZT7skHSoUQUx5o04k945Sg1iXVol5iGO0H0
         cvcz4vFFO+tM2QCT3czBwTciit4u7ZW5Sx9k7wWRmTphhTJCKM2S4vFds+Cxjwp3OMgS
         Bzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033674; x=1741638474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ptFxDPzgcOCh3UJGfp4f6HXuiEkVzN5ocExDfIA7xc=;
        b=ptTqXu4VALzfpMSe9ujyO1iH7FeYVr87aYUgVD1eLj7FW0mNjSQ9/ZPZ4Xgo3iOoBw
         8H5/xMnfeg8Dy9Lh4bYJhogB5xZzlzVmFQGmOHEAem5y8oPXDOMdAPc78NDsiior8tjL
         KuodfuN4zZ1sLaEdagdJTpjqcfj9m08qobpQdON0yOXlJshS84214gFCNsBHCTZKF0VK
         XRQqSK55gqwKqwnbKXiHq+YasTa57pNkpdn5fmjz+tyfm8otXZasZVfxn600k8vEqfg1
         DpBlpsVbSoq7vYsEbVW8k9ab1DgrHEImn6qJepwTWrrd5wPuWRQqPgd0hO/koF17HRVQ
         C7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7t2r4T2wFj3RzhOGobxNeTnWXwRQuhRZ/84BcqG+LyFeM9DiH7qU3ghyinGNA7QHbmCK9KLiyzEF@vger.kernel.org, AJvYcCW1zF+P6oeIn8JYhndpThP7LDqxBTlon/Vu0ndfzgPqdZS5HS91rxu82AZZ/T5smSh77pwmALd0bu48AmQK@vger.kernel.org, AJvYcCWDWHUozZmMsfmCxTqy/K97KNBVtOfM0ooDn+LwtdWMhXT7fDbIRXDwW5OAynU39kBEtmPipMAsfvhg@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsWGF8gb9vtmmmNa/rIENzMFlq61RC/K566ns98oSJbvtfKCm
	G8ns4VgjZ32c7WT3gGcU3Z0dwEDeDIfVpgAquUm9lB+piQB/dwzmZLRiNQ==
X-Gm-Gg: ASbGncvTiwCWIDgV9+jnLKrcEXEBeC4MWNAmvKf4FOXS1nrHJw2yr0i3aseqXmy+alU
	iciuKRXjOumdVK3hRy0L4b097iKNDk0d9LNkHWVwVbm0Uwc4RPLRXxpiBdtztlJJpkM2rLFBK0x
	Klw8apSnsdRVGTpIz4Zbz/eHizEyWQcOFjrneyf5b2RVjW83Z8V76BMHVYAE1+CCgHG+YES2KzR
	36Nc+JV7j/2eMBp/N6M1vqOF/V82ReBg4ydkdh2aSFnXzwaDEcmfcb0SZbQ0LSIBw2rYOhqUPDJ
	hm0bvNtBkbGlfP7u3l4PuReGb6XVYdZNQ3GRrP5b316f8wlNxwDaVcFWIiCvN/4UofZBMqckai1
	tIirUOCsjp2XV7DY=
X-Google-Smtp-Source: AGHT+IF9bLgJA6ivadxRofeZD12YX8BslE3IjcnQ2ZwFvqD4TjsdIfsGgsXxyqFPCiQIVLuL5VdXZA==
X-Received: by 2002:a05:6402:1ecf:b0:5e4:ce6e:388b with SMTP id 4fb4d7f45d1cf-5e4d6ac54a7mr41302571a12.6.1741033674000;
        Mon, 03 Mar 2025 12:27:54 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf64dd565dsm389222166b.101.2025.03.03.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:27:53 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 03 Mar 2025 21:27:49 +0100
Subject: [PATCH v2 1/7] dt-bindings: clock: brcm,kona-ccu: Add BCM21664 bus
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kona-bus-clock-v2-1-a363c6a6b798@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741033670; l=3646;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=+1NQgL2nKvBCPiU2nmmHUiXn5bmc6OZXYhfS37+RPTE=;
 b=OJKrwv3v/Mvd3+6ep0bihGDsdSkJo3RxScAtuURRrtp5FGSklcIUhFwWoUCC38nuKy5dcOcim
 NdRSQsIO8RfC9NnNeX0AKARxlvIrbIz/gIhtFj5QQekv1V3JCgy8ZhD
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add bus clocks for hub_timer, sdio, bsc, uart and usb_otg_ahb to the
allowed clock output names for BCM21664 CCUs and add the relevant
clock IDs to the clock/bcm21664.h dt-bindings header.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Move clock ID dt-bindings header changes into this commit
---
 .../devicetree/bindings/clock/brcm,kona-ccu.yaml      | 18 ++++++++++++++++--
 include/dt-bindings/clock/bcm21664.h                  | 19 ++++++++++++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
index e5656950b3bd0ad44ba47f0ada84b558e71df590..dff04e24e92829b890bf7cd336f0e083bdb30fa6 100644
--- a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
@@ -40,7 +40,7 @@ properties:
 
   clock-output-names:
     minItems: 1
-    maxItems: 10
+    maxItems: 14
 
 required:
   - compatible
@@ -124,7 +124,9 @@ allOf:
     then:
       properties:
         clock-output-names:
-          const: hub_timer
+          items:
+            - const: hub_timer
+            - const: hub_timer_apb
   - if:
       properties:
         compatible:
@@ -142,6 +144,11 @@ allOf:
             - const: sdio2_sleep
             - const: sdio3_sleep
             - const: sdio4_sleep
+            - const: sdio1_ahb
+            - const: sdio2_ahb
+            - const: sdio3_ahb
+            - const: sdio4_ahb
+            - const: usb_otg_ahb
   - if:
       properties:
         compatible:
@@ -158,6 +165,13 @@ allOf:
             - const: bsc2
             - const: bsc3
             - const: bsc4
+            - const: uartb_apb
+            - const: uartb2_apb
+            - const: uartb3_apb
+            - const: bsc1_apb
+            - const: bsc2_apb
+            - const: bsc3_apb
+            - const: bsc4_apb
 
 additionalProperties: false
 
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


