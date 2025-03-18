Return-Path: <linux-kernel+bounces-565700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3E3A66DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E4816AA90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18871FFC47;
	Tue, 18 Mar 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0F+nqMc"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA111F098D;
	Tue, 18 Mar 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285613; cv=none; b=ktamQ6U8B6m1Mxv78nh45GzxLKFyNgUWmHJXItVQDFJJQ3XB1+4X5PoFJrc+GV5rFoiSooLs5Z7/yg0M2IaK5ovTlLD537r7FWTm7pnVQc+EbdOw4pNDPImTBSWxCIRvE7rPJeZWg7si2Q9PPvaH4Qq0ggkbz/2+4OuyIK4H9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285613; c=relaxed/simple;
	bh=dY3kv0VjiYsPO9+KS4FI1+q2pZjfJCx6WUBgsDn5+/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qq6o0W830SsO93kbLprC7zHmYg/ydoiY5oo/omEnOd/HE2fisrq6j1xNmBveI9Vn6B2ReU5seuDQHQy+07ubVSOKEvjsytAsbK8GGkb3IsMb0FUjnNWOE1HKC5sVeSqNN6540sQmTBiXclBX6RKJgstoCVYY2p8lDPvXX0B0VLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0F+nqMc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so10219855a12.2;
        Tue, 18 Mar 2025 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742285609; x=1742890409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDfD+AA03RBRhqgQNFDrugFW8XcQwp0v+TPUCIjA2Lw=;
        b=g0F+nqMcCHhOZEJU1+QZThmynytXnwtOBMpnGi9hspmLOfj35zv7p8IaYJAyKV5DCo
         raVgPKoS6Afyh3PV2lyrIeCjJCY5XNqtVex7klN7cD+4QF8S4ryq1tGutD9eVxdkl4Sv
         UAyMReU2xiKAquP50GFq01O2K++uVxoQKevrhWSAISeS5DwsUSBXe6OUGPzVqsgXXEGI
         WjOSH1+rRlj+WqefaWTbicH2LEa47mu+xgzvoO9Dhs/S86DGUyZHGIrns8+28JCEEM3v
         U5gY3d5ebVwXwo5iLrqqYetbBfjtR7s0365tHv0wrRitMyu7DIZah8HQ5o4Nz6y03goh
         QtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285609; x=1742890409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDfD+AA03RBRhqgQNFDrugFW8XcQwp0v+TPUCIjA2Lw=;
        b=FTcieowxYLAE6kA0um8aHwoDxy3flsxk9fQPywOcdIfmMsKl86nD8lDPIy4fdq5pgw
         ADB2BWzBm2jfBbHQ/25sA3vrZbb9vOb2vscJZ2RldTBhO5aC38Puaf+8Mj6+gDrFTF73
         5UemTY9VK5pSL4O/RYWQkHYGM/ywoH2Qm8xQ+EB2xvWgzsjFQtkvizcxX3l/SuRozg5I
         /jGlJz/PBYviwPxBnKoPG+9BHS4kp2+PKpM8vfo2PwEyZxTuBwYO9OjInV4Rj7szirA1
         8DlJ8O1238F0xCFKyLMdiKcs8FACqgSPOcoEulNAZHc20Feztm7MS7LY0KquM+3bDNwP
         05JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQIHaMK9pBuZEPRi3nM6cUMZLmIvpL5zZ+psItz1tFEuXVq/4M2yLRQzcg49V4xwCDgXy8ShGDbk/d@vger.kernel.org, AJvYcCXEfuLllaidiTalHwqgRHFKPPhYs2EkydXYZ4YeGTHACUwIvaC3j7RdMHWibT1JcTz6Crbcrqt0RBAq9aU9@vger.kernel.org, AJvYcCXtVNiop383NhrCL1FLa2MY/NrJWRdPEJKNsLcxmfLH42UxOlG4XBn3r7kEXKTFo7O+7Pfc6qMHy74k@vger.kernel.org
X-Gm-Message-State: AOJu0YxAE+d8zLqRsfVKeSQ1aP+Sjs/b/SI3PCQYcvwL+sj8MEaADbf/
	jk28isc0VLDX406Us0oh0bMrv9mEnpAZG4ZxQIaYnJR+uX9+O0sa
X-Gm-Gg: ASbGncuO5ZVN3KjPhyIfI/XTCw0kRsNM1glXEkQNT6AbhZFcWlapzT/LfnXnbmSpGuT
	Eokavb8wx/si/+skGbQ+yOEC8Lb3Sw+GCTvhnfNKQ01xI/MPsvRMM9iKBOwQrxrRU309nukn6RX
	Nf/6/7JosxgsCPjvtSCPZk2Inhym3BgLUltuPBPkg6kDur3fO2WTMbHFRjHjgI+1qn/9Q8Z6TB7
	VQJQmS6xqysg64RVhtTH5w8pLBITdmpXtnFGv9IN3FQyU6gVV+vmZYx2G3MqliS8nb5A1Wfd97l
	ShS0lK1ZpuEbiQEkFG7HgTcFYFHxTqk3v5kuVFIpvdmpLA5LXCErd08V3a105EKisspQZ+v+lRe
	akRLbKRwY2UjsSAB5Fw==
X-Google-Smtp-Source: AGHT+IECuJF9L/8frvIxYItdQyfgk+ujeXwAxNGYFs766pry18H2t3aZn+d5lQQuRfFoJH8GCqGU6Q==
X-Received: by 2002:a05:6402:2554:b0:5eb:1dac:5a20 with SMTP id 4fb4d7f45d1cf-5eb1dfabf84mr2163527a12.31.1742285609245;
        Tue, 18 Mar 2025 01:13:29 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad392csm7176097a12.53.2025.03.18.01.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:13:28 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 18 Mar 2025 09:13:24 +0100
Subject: [PATCH v4 2/8] dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT
 defines from DT headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-kona-bus-clock-v4-2-f54416e8328f@gmail.com>
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
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742285605; l=2774;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=dY3kv0VjiYsPO9+KS4FI1+q2pZjfJCx6WUBgsDn5+/M=;
 b=Z868CUa9XM1vhZTi/O0IY9JIanJs4dTl5Z3FW6Jz0HjavNvotukpbNpXz1ifENAHRgAbANA2N
 4HuHcqaM/uKDxPDHQQ05CneFBFfIvjJAWXgOckSTObi5YgR0/lRgu4c
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The CLOCK_COUNT defines are not used by device trees, only by the clock
driver. Keeping them in the DT binding header is frowned upon.

Since they're being moved to the clock driver directly, drop these defines
from the dt-bindings header and only keep clock IDs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


