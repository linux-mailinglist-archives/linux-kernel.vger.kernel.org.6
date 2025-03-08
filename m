Return-Path: <linux-kernel+bounces-552357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C414A578FC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F827A7E6A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CDD1ABEC5;
	Sat,  8 Mar 2025 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbkjdLFH"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE771A8402;
	Sat,  8 Mar 2025 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420252; cv=none; b=TR7jG1dRH6L6CSbviiFxTeB17Pws735aRfVqMVN0tbEebe5fRrOcpFot3HFLhhJj9DrGLPHyHuE+5E3hNik+IORr8KNUPA0fGWueY8Km8S29KgKoB+r1n1JTYKjIkWLdnjR6YGFGi7GRScH7e6Ng9BbF1BfVA0E+3uunr+iUkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420252; c=relaxed/simple;
	bh=VRfyIRPUUTsK/JAOBRpc1FmYS+oVb+MBp+/5a37K6K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5e4nA4zJXBbX6AhWp43PTlMnWQ/6+MbmzSgsQxLjJ/tqSFtQeXPrZaJv+wotYGzmXWxfWBsowXg3M/m+rH1P7z4tMeUPpFjXhIHe2JaACv596hSGq/923gTzdqSvyCQ/amDLPhMHC1qkszBgeTJsluGt6eeMlnOcwFhQDYYT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbkjdLFH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso3275430a12.0;
        Fri, 07 Mar 2025 23:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741420249; x=1742025049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YL6dE/Q7cMIaEpCPvdRavmtB8e55YozIgeA64CVqbMk=;
        b=cbkjdLFH5QOUfwqcQsmGCPIIAjQMf3aCXQ8EgBU5EYqyZ6tLIOYCkuGSvGZoQnG1Yo
         xJG37TTP8QCOYj5p8E+rgH1aziysVgfCIwXcxuuCFUDmv7RAGQZNLrZLkWh6qqfcgEAR
         cXSdtqnX2qbXZ4iRgikLK0hlZw/bEvh5cwCoVkIu5fBrnm++KhB/RwjTwd+W+KsG/0FV
         MbdUYljqzAXxqqFTQKciXYtJfRloQMGTsgqMKrlb9/AnFa8HZAW9qUAzdXuq32tJ2y30
         /B3sRJMm3yMVfAUDkvzKYC96ByFTpTEVRU42VvApWVeBLbtyPYlIkzsmA72uPbEqebnV
         boDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741420249; x=1742025049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YL6dE/Q7cMIaEpCPvdRavmtB8e55YozIgeA64CVqbMk=;
        b=kVViWOPZYCmiUOQdWld+SNesX2isJ6tC9LxEzyDplxng8bqIc+RIikcFNETAimRl1L
         Hw6+ZrDEIBEl80uEdJata0oVtLlV++eAvhxF1DfUB5ovjWcUs6twDRFyL7elvhSaQFiW
         ue0qzEf5FjlygVbD2sRLeH8XgBfBsdd0zADfKUVlMFmF5E+fbUAfBLD4HjPjiP6QUIju
         74wpHNntJgJ5VgBD+OWb60mIZ25wO2xKS1uyJPmmaN8Y+VRmWPR42seNndJoXWdrAMgf
         ug6XhScSwcnmiQV258zq5pSnIsx6obJpifuB8er6yD5R/6mjtiul4RRz3id/WZwaBneM
         ONBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQh6mxr9f9Gio+eEnyKOWRbA5wSF4DSH3UJOzLN2cYMvEFJfQApG01Fcyr6qWYxXIxLCZiMTegPtotCQXb@vger.kernel.org, AJvYcCVVyIWazt5S+1+RYpV8pEoTGjT5Ywmrpo0Hpe9tm6ejKl/udcd5RoXN3kHK//Aa34FRcHa+SGY7YFnq@vger.kernel.org, AJvYcCXr08ze7HyokQrnoNXd0vhbaXmpFkV5yj5y2CLPRLzDZaq7+OyMgpvuOzMY1nit40L4DytQS+zPAPYQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxgBXDmiwlupiNrYtRUWT37I/3/LMqsh+Fd1uy9rxE8fmaw0O8x
	/rWY7RlKH+JTuz9vJSz9gkSrwA/z0T5jbhppsLP7FE5h1/8d7ngD
X-Gm-Gg: ASbGncs7UF3LVZPEaoyt6eHBem0dkGBpWwkOTor5hy+6EKAqik7r6M+he/WV716YzqI
	j9I+i3p1KUGYmEbWwOlu95InHftWesvav3xtaXiqZ8q2vNRCE8F1kZR4mc8By3fLz99roc2NUxq
	xqYc3z4vE+u1Sp+DgRAwp3AkU9QKpEDx/svyyMekIoKJ3hJlH/3/NvY2EQh6QzGbnxH3qcqH7MG
	SlcHwpQ/CGpsSfwiUjwTv+vqHFGZSFRtuR8T2k1U6AhPPAG9eoTHGD6eQgpr4zBpmPCrn8nhu5H
	51Qw03zS/Iz+nuZhYH/4+Kgpf+PV2qz3FFS2EPWGEgdUmXjC3JXXgmg0hKm3Lb7rGTIS7b/pzT+
	kg+5rorn2dgQyOF3Y5A==
X-Google-Smtp-Source: AGHT+IETj/t4dON9ZQPJwnbzA4jnO5MV8KuGH/F1nIbywu57JpRyGgVb7wE2diNvVJlcFVkQD/ts0w==
X-Received: by 2002:a17:907:94c5:b0:ac1:ed46:7bf0 with SMTP id a640c23a62f3a-ac2526e27d2mr687792966b.18.1741420248694;
        Fri, 07 Mar 2025 23:50:48 -0800 (PST)
Received: from hex.my.domain (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm213104766b.106.2025.03.07.23.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:50:47 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 08 Mar 2025 08:50:41 +0100
Subject: [PATCH v3 3/9] dt-bindings: clock: brcm,kona-ccu: Add BCM21664 bus
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-kona-bus-clock-v3-3-d6fb5bfc3b67@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741420241; l=3512;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=VRfyIRPUUTsK/JAOBRpc1FmYS+oVb+MBp+/5a37K6K0=;
 b=3C3jv/6eSHk5YvQ4IPzz+mCLSShMvNbohIkBGEz2UPxRCYLMUKASi43PiVYk4fwF+9zEoegqK
 TAlZOogWN88DcigZUelfQFC4emAhZLRiZDOjvdkOiYIy0JUVP5FSZiO
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add bus clocks for hub_timer, sdio, bsc, uart and usb_otg_ahb to the
allowed clock output names for BCM21664 CCUs and add the relevant
clock IDs to the clock/bcm21664.h dt-bindings header.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Fix UARTBx_APB clocks being out of order in DT binding header
- Drop CLOCK_COUNT defines from DT binding header

Changes in v2:
- Move clock ID dt-bindings header changes into this commit
---
 .../devicetree/bindings/clock/brcm,kona-ccu.yaml       | 18 ++++++++++++++++--
 include/dt-bindings/clock/bcm21664.h                   | 13 +++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

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
index 7a380a51848ce100cbf94f9da2b997dbe3a65230..9f3614eb9036b5ce36b610fd7437338655a9cf97 100644
--- a/include/dt-bindings/clock/bcm21664.h
+++ b/include/dt-bindings/clock/bcm21664.h
@@ -25,6 +25,7 @@
 /* aon CCU clock ids */
 
 #define BCM21664_AON_CCU_HUB_TIMER		0
+#define BCM21664_AON_CCU_HUB_TIMER_APB		1
 
 /* master CCU clock ids */
 
@@ -36,6 +37,11 @@
 #define BCM21664_MASTER_CCU_SDIO2_SLEEP		5
 #define BCM21664_MASTER_CCU_SDIO3_SLEEP		6
 #define BCM21664_MASTER_CCU_SDIO4_SLEEP		7
+#define BCM21664_MASTER_CCU_SDIO1_AHB		8
+#define BCM21664_MASTER_CCU_SDIO2_AHB		9
+#define BCM21664_MASTER_CCU_SDIO3_AHB		10
+#define BCM21664_MASTER_CCU_SDIO4_AHB		11
+#define BCM21664_MASTER_CCU_USB_OTG_AHB		12
 
 /* slave CCU clock ids */
 
@@ -46,5 +52,12 @@
 #define BCM21664_SLAVE_CCU_BSC2			4
 #define BCM21664_SLAVE_CCU_BSC3			5
 #define BCM21664_SLAVE_CCU_BSC4			6
+#define BCM21664_SLAVE_CCU_UARTB_APB		7
+#define BCM21664_SLAVE_CCU_UARTB2_APB		8
+#define BCM21664_SLAVE_CCU_UARTB3_APB		9
+#define BCM21664_SLAVE_CCU_BSC1_APB		10
+#define BCM21664_SLAVE_CCU_BSC2_APB		11
+#define BCM21664_SLAVE_CCU_BSC3_APB		12
+#define BCM21664_SLAVE_CCU_BSC4_APB		13
 
 #endif /* _CLOCK_BCM21664_H */

-- 
2.48.1


