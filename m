Return-Path: <linux-kernel+bounces-552356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B0A578F9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E293C7A7FBA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192CA1A9B2A;
	Sat,  8 Mar 2025 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgxg/3wJ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53D19EEBD;
	Sat,  8 Mar 2025 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420250; cv=none; b=NHpVY/c1d7LbbUkuTBYEFD+xgY8o1kfdUTe4+qi9oaD6azVt38dj7L74f8YZ4rkSPdFbLr44B8FkqWfOdrHsRVpDxxC90phJSDnAfgmPv2hUVdQImckE9raAsT8s4aM3tkaKD2Dk1H43qm1PHIIPc81DtqvjZsg2daMtrMe/srk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420250; c=relaxed/simple;
	bh=fgvu2deeJuwI81T2zFOPfO7hmnLXlSGvvGOOEjq7FpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pr7+kFLRYi69ZueSb23auQ4j163C8vRR9ODYa8P3i8II74lcEiNKMh8k+100nsclprTp7oeXXIS9jKfDXwuw5nLV3ncsy8bI6pbHgXlXdsCZF9rEBX1LBsxGltLS9Du/WS1/FGfEPWnQvpk0efvPXIo7ZrSLg7qDtJSb4nPfHwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgxg/3wJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so3973631a12.0;
        Fri, 07 Mar 2025 23:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741420247; x=1742025047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAipTRa9RXZxzsB1g/YtbjZ4CAa1LY6KTbUogve7tZ4=;
        b=Tgxg/3wJiiHZBqKcs8joXQmAKTP5ad87nQ/YoNOlIsAxsFumo48WUPxcpcMYOo6v6d
         +X546aiQrkszn8jCgvtucQeYgTaLgoUk3PIhzKp5rRVOZoESpQx1aLbGS2j30jZ+a3vw
         BTsTu8nT2Q6/vh9pkap5dZX2GwyS+Ikqa9zcz2+GELdf9l5sK7EN+k+QigqeAawdymNR
         cpWMsxYT3Szqpo7uD4V4SDLGjOBG8iA5NzedOi9SqhOju+Kb5ZwbO7cxfqMDXO2p69E6
         2+A0h0f0rB2d+CUwfAqHAAACxxQ8pTOF5JMZlJhhgAblxr8hy/n7jed7dwIFE3Zl9fhP
         2big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741420247; x=1742025047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAipTRa9RXZxzsB1g/YtbjZ4CAa1LY6KTbUogve7tZ4=;
        b=FAPImy2mHztDnqwXGRtiBDCq7UdkUW2rz7SPfUJC8QTTSi4L6qHmZ3lkgO6kd60RD8
         aitBvg3CcMFI2bZzL/vUA0zDMpDpOzmxOqLnCrgzyrtPDWLIrBFmQbAtZp4jegizasSy
         JcIuhgbonwTIF5li1riPzdXw0/bG7tUOVlS6r7W1Vfg9M4SOMS0feUimUj9ra05APKV0
         fB817bmesZ6v3rXDRunBAx/zPPV/FyPNGvGy5A+z4hJOWZ7O2m9JBubN4HrcSd4FeGAE
         bhQXfZSBKaOlQKI4mOgRnX/UL3Fu2jMADaaWOLDg4VZJlTn0LkKMzVxFhsdTZpik7nXY
         DJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc46rKXIvPjCivpOWvvPTImXER/7T7bfkAXbUeOGTnXEbKmLf312WIIcHRhaot+M7J6lF6K3MK3eEx@vger.kernel.org, AJvYcCV7yIlT4T9bcOlW57bg0rnDyC+PQz1nZqRJ0xY5nSS9hGw7PISFtw51L6EXD4+YpTddKCSQfLtp9qx9@vger.kernel.org, AJvYcCVN7dl3TBZpuQ0IvR1kqiDYxsb8CFQDRtoqJzCRntzp0Y+FakmW8OybSsLm5m/5KP6lydKhlM9WU/NcceUj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nBOk9EsDD3XHJyjsNXYHMCtshDlT/GAwV7O5Fx4k1Pg7DtqY
	knJsOVa4GrfZyPYBuOyVFw2VYFT//0rVz8ceogcIaZBcRLTBQLKM
X-Gm-Gg: ASbGncuAUiOZhf+M6QEiIc5vTj0AedHZFnjDNzumBwnPItQGiZ4zj9K0KLbKdyA6lEv
	xFLsVPh2EhS8iPYY3afbDGb6O+OWvqOKRyEViUZvXPR6151q9dI+OOgc+fC+aHwIzZjD/tv56yB
	7pBTibkGt35g8bTZklsmLlySKkdpo0v54l1h+xmrUYAIR1QB4uEaNYXaUIgTNK2YJjgZl586mXK
	+mYfyAOw83GCesCk/hIl3OXuC653Mjndo1CNeh5w9dJceLPQUjKXRqyzc4MH8JPjT9S1KRIaFBf
	tkHe/kMVWDVUObI8Gm+Jo+l0edWe1PrXRwKVzQBAqB4UJJTL54OdztdiCymeUwyTxdXAjuj/kI5
	8xeKscy5gUh3NhGX1UA==
X-Google-Smtp-Source: AGHT+IGJzpiDEk20O7oHM44ogEg+CIsiF9+uZDAJ8qmmHtsc5Y+WsQMzyH0Ik4Jy2FI2XuTR3J2KPA==
X-Received: by 2002:a17:907:9956:b0:ac2:758f:9814 with SMTP id a640c23a62f3a-ac2758fab64mr108080466b.23.1741420246748;
        Fri, 07 Mar 2025 23:50:46 -0800 (PST)
Received: from hex.my.domain (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm213104766b.106.2025.03.07.23.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:50:45 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 08 Mar 2025 08:50:40 +0100
Subject: [PATCH v3 2/9] dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT
 defines from DT headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-kona-bus-clock-v3-2-d6fb5bfc3b67@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741420241; l=2707;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=fgvu2deeJuwI81T2zFOPfO7hmnLXlSGvvGOOEjq7FpE=;
 b=Pbpkyv6c9EaCevjAbNNRgmb3bdp6jG9/QUDVquOqr4RuBXzx0HFHY5NuhIg5rlrY9h0RZW8f3
 LEXZkd0ZRRKAgzM6ndKV5QfKmESi4IgN0xFPw3C1GIkwMn7Jy0RCLKj
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The CLOCK_COUNT defines are not used by device trees, only by the clock
driver. Keeping them in the DT binding header is frowned upon.

Since they're being moved to the clock driver directly, drop these defines
from the dt-bindings header and only keep clock IDs.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Add this commit
---
 include/dt-bindings/clock/bcm21664.h | 4 ----
 include/dt-bindings/clock/bcm281xx.h | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/include/dt-bindings/clock/bcm21664.h b/include/dt-bindings/clock/bcm21664.h
index 7c7492742f3d4ca439236f2f352e432989409570..7a380a51848ce100cbf94f9da2b997dbe3a65230 100644
--- a/include/dt-bindings/clock/bcm21664.h
+++ b/include/dt-bindings/clock/bcm21664.h
@@ -21,12 +21,10 @@
 /* root CCU clock ids */
 
 #define BCM21664_ROOT_CCU_FRAC_1M		0
-#define BCM21664_ROOT_CCU_CLOCK_COUNT		1
 
 /* aon CCU clock ids */
 
 #define BCM21664_AON_CCU_HUB_TIMER		0
-#define BCM21664_AON_CCU_CLOCK_COUNT		1
 
 /* master CCU clock ids */
 
@@ -38,7 +36,6 @@
 #define BCM21664_MASTER_CCU_SDIO2_SLEEP		5
 #define BCM21664_MASTER_CCU_SDIO3_SLEEP		6
 #define BCM21664_MASTER_CCU_SDIO4_SLEEP		7
-#define BCM21664_MASTER_CCU_CLOCK_COUNT		8
 
 /* slave CCU clock ids */
 
@@ -49,6 +46,5 @@
 #define BCM21664_SLAVE_CCU_BSC2			4
 #define BCM21664_SLAVE_CCU_BSC3			5
 #define BCM21664_SLAVE_CCU_BSC4			6
-#define BCM21664_SLAVE_CCU_CLOCK_COUNT		7
 
 #endif /* _CLOCK_BCM21664_H */
diff --git a/include/dt-bindings/clock/bcm281xx.h b/include/dt-bindings/clock/bcm281xx.h
index d74ca42112e79746c513f6861a89628ee03f0f79..0c7a7e10cb425ddb597392939cb218545a48bf22 100644
--- a/include/dt-bindings/clock/bcm281xx.h
+++ b/include/dt-bindings/clock/bcm281xx.h
@@ -27,19 +27,16 @@
 /* root CCU clock ids */
 
 #define BCM281XX_ROOT_CCU_FRAC_1M		0
-#define BCM281XX_ROOT_CCU_CLOCK_COUNT		1
 
 /* aon CCU clock ids */
 
 #define BCM281XX_AON_CCU_HUB_TIMER		0
 #define BCM281XX_AON_CCU_PMU_BSC		1
 #define BCM281XX_AON_CCU_PMU_BSC_VAR		2
-#define BCM281XX_AON_CCU_CLOCK_COUNT		3
 
 /* hub CCU clock ids */
 
 #define BCM281XX_HUB_CCU_TMON_1M		0
-#define BCM281XX_HUB_CCU_CLOCK_COUNT		1
 
 /* master CCU clock ids */
 
@@ -50,7 +47,6 @@
 #define BCM281XX_MASTER_CCU_USB_IC		4
 #define BCM281XX_MASTER_CCU_HSIC2_48M		5
 #define BCM281XX_MASTER_CCU_HSIC2_12M		6
-#define BCM281XX_MASTER_CCU_CLOCK_COUNT		7
 
 /* slave CCU clock ids */
 
@@ -64,6 +60,5 @@
 #define BCM281XX_SLAVE_CCU_BSC2			7
 #define BCM281XX_SLAVE_CCU_BSC3			8
 #define BCM281XX_SLAVE_CCU_PWM			9
-#define BCM281XX_SLAVE_CCU_CLOCK_COUNT		10
 
 #endif /* _CLOCK_BCM281XX_H */

-- 
2.48.1


