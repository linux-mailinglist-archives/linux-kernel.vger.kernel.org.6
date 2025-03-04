Return-Path: <linux-kernel+bounces-545392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DEBA4EC54
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5017ADDF9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B355724EA9B;
	Tue,  4 Mar 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPC3AxWj"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647820E6E2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113952; cv=none; b=UErpAmH6wItJSKvBQRzrvHCqomJN9xymx1BgiV2ZcekZllcF+3/uRCxc+UDVwb/kP+5q73LkCTKQ8IBf9Dqp9qaq0r2W8fXjBTFmRD9h/u5+h2vm7BKBH1Pe8CX4rGta5aY1gIf6AiDnWgzn1iVae1gBPOvM9nL6JT84YcVHL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113952; c=relaxed/simple;
	bh=eWWEYSKlTmeEjOZIXmtagPOe38Op4PeZ5Hh+2MvjcuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RyRDbtwmMSLnSvLO/3/eytgaPlPHYQ/D7g/4IAxc2yENrRBXwnJbWVPA0u4taxLw/YSPyxZlbRV+zTWXJjWKCY+NW9g0OoDFMbRqo+OV6B2sZhXB9bCdD3INsWiZCGOYWhcfUhpRSXsaEgVudWxzQXhgHfA4goNcUlSXEWf3ydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QPC3AxWj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390e87139d0so353029f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741113949; x=1741718749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/W+a02Ng8N3wLc2mEy5yErM/Qmu6bX5XZtamazyg7U=;
        b=QPC3AxWjeQKOYWW8yCbBsfYpNV3iQE5ZlWvuGzenJccySVRsZkQy4IKXIQ9V6F5jOJ
         6+gWOR0XzSA2KtAtAeRcyAThKGKZmiiyVWFp/Pcedx74Qlq9lSLgucBVXiRg4K7wXUzD
         HYRBxNUWV99VZUNUJbAv8WXrwik4nUwrlbQ866VrTS48sXLSnzws9n11pUbooOu2PHFJ
         DvSp5DfcF/AMjvC+hKugmsc3nKQUGsj6AXB/UfB6EFk7Hsxnd0H/ePFUL53K1i2Eeeys
         DOSW6loIC54Acctpd/5qHKV/SBKYz3CYepLCWzGa8GSDg9GTOxTtituHLttAL2/8Ssjh
         WGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113949; x=1741718749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/W+a02Ng8N3wLc2mEy5yErM/Qmu6bX5XZtamazyg7U=;
        b=ZXhmaOm5Elrq1z5AmaJ13ooVtV3QVUs5fuICKEU3jJ0UN56GQ5c7RuyyUXQS1LUdmH
         Ktovvuwr+GpWC3W2rhnEkoAghpolXZCwPVZFBTIPfhuHFEynYe9F/x/8Rp9bcAGPeA43
         DRPFXqrfPa+RNtGsXKnY/sfm9fwgGT3gEqgtNgkxQVR2HNJ+GIjhdMjAlAxokp8YvBNm
         ggBR3lbOdun9/uKId8gYBG+p2fki3HYluCII6bTAO8m4FlS6ILK3tIPtZnksFjmdLVRK
         hgeumy9kHXtFtt08uuwy7aNdE3Oykc40xk014nIFvoyfQU19gLLg2Asv+9l9qB7BDMkP
         CKlA==
X-Forwarded-Encrypted: i=1; AJvYcCWtgLsJxZYOvJAjdtuvqFEt6RZGKqbPsTGENgDvy3qx8xfCdPMl/dvSIhwsEz0FIf6uVnV8b6Qgd9Yh974=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnE7PYIlYKSGzivzrMXD250Mjmt+Ub7BZjV287OqatuyPByWIh
	CAQBSrqaebHJMfVs68krgLx3WoU8pGt32CfZJ2JPbKYfGlEFeYJcgoUQjEK2VEg=
X-Gm-Gg: ASbGncuVFsU9I/axBJcece2oKt9DnpCLVmhjmWh7K/DN2xBb45h3qHbUPzHA44wqvfj
	l//9KHROTdtslCI0+Vp/B7Fm0Yu0dD6YQ4Vdtf0BpD/CAcBskgnApX3x7U9856PtBidHf6Wb1eq
	jC9sscntINvrImMJsNesUVX0o2l/1mTHEzZp9iPrnNjDTtM0NrZi0KflxaV6kedu8KMlgLdQ2ak
	LHTCyb6XnKMrBiitH5P4me0x3itWnyLYMryqWu97B4aq0HiTV3DA4TXK9TiyU5sSgYSum4RS+ez
	LdZ9qUlas0ECdeSa4OtoRn1yUG0fwE9TpdYdDZL+QknlbF3F/ubrqOO/epsf
X-Google-Smtp-Source: AGHT+IEoWehS/s3ot40GYmRRHJ+bHmxRZpEClYqOKK+AJoENEXE1cy4yQEo+eeeBNO4WSQ64fH6k3Q==
X-Received: by 2002:a05:6000:178b:b0:390:e88c:9449 with SMTP id ffacd0b85a97d-390ecb87357mr5672394f8f.12.1741113948599;
        Tue, 04 Mar 2025 10:45:48 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6ceesm18229985f8f.45.2025.03.04.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:45:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 04 Mar 2025 19:45:32 +0100
Subject: [PATCH 2/2] clk: samsung: Drop unused clk.h and of.h headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-clk-samsung-headers-cleanup-v1-2-81718e38246e@linaro.org>
References: <20250304-clk-samsung-headers-cleanup-v1-0-81718e38246e@linaro.org>
In-Reply-To: <20250304-clk-samsung-headers-cleanup-v1-0-81718e38246e@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9871;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=eWWEYSKlTmeEjOZIXmtagPOe38Op4PeZ5Hh+2MvjcuY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnx0pSTgcgVFqrE3gT2iCJ6i/VaP4HMczSzWyqg
 pmB+9BglquJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ8dKUgAKCRDBN2bmhouD
 1wOAD/9FA8efHNuxVGN2W5bBSciEkd/tR5BbwVaP3B3GL5rx8KZzrAlK6Zt5oSnmcG5+YothvWi
 4uCIB3aLFBtQpsbKxgYN79+sQkZytMTHtmt9++d83Uc3+YjrLy4YHSRPjDiRofOzzaY7TrX+H5/
 a2zMNHZCcwIdIRIaHyWkjwkrzIBvCIlBkMLifS2K5SoNqZUTyRwBbxQBkRQtFYoikem2rZlDZxy
 st4QCfd1lBUnmgw92qWXT19FzGr599Tc6hv4GkLepN/Dh65Iv5uhheZG0N2tDLD24ZvCSQwBcP0
 X8DAAyVdcP1yzN+hj8nKuLNi3rdCcAOQcWLzoMAX9x+Mds6Woef/3Ifw6O5eH2XOI2EtZToixvq
 H7vXWvguqPfYPc3K9lvBFUV9tYDux1UY1uqbB29FVr4PGRc4KLyFj2Bfnz4rfC7BIUV8MM334Ex
 yBRDmcunMYchi/h9Vsj6nEHf53JJS9MKf0DIbWmw7lCrIPvDpBjmmXB46y2UBAZ7IXCuqd/FjlG
 qaK2lRqYvTgX/M4fTLGSDF1CNTJqxN85eVNj7qZHYIQ7aV01UTSLc5kCCUHPBTnL85gyNv4T8wa
 THf+ZHLPJWQoBWIFQrvGVnTIloBXpw6JpTqr5XnHhjdwRSNHmoY2jSNcbOZdC5pqXcpZCJXB5XB
 s0HdkDgMIuS747w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

<clk.h> header is for clock consumers, so drop its include from the
Samsung clock controller drivers which do not use the consumer API
(there are few which do, so leave it there).

Drop including of <of.h> and <of_address.h> headers for all drivers
which do not use anything from generic OF API or of_iomap().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/samsung/clk-exynos3250.c     | 2 --
 drivers/clk/samsung/clk-exynos4.c        | 1 -
 drivers/clk/samsung/clk-exynos4412-isp.c | 1 -
 drivers/clk/samsung/clk-exynos5260.c     | 3 ---
 drivers/clk/samsung/clk-exynos5410.c     | 2 --
 drivers/clk/samsung/clk-exynos5433.c     | 3 ---
 drivers/clk/samsung/clk-exynos7.c        | 1 -
 drivers/clk/samsung/clk-exynos7885.c     | 1 -
 drivers/clk/samsung/clk-exynos850.c      | 1 -
 drivers/clk/samsung/clk-exynos8895.c     | 1 -
 drivers/clk/samsung/clk-exynos990.c      | 1 -
 drivers/clk/samsung/clk-exynosautov9.c   | 1 -
 drivers/clk/samsung/clk-exynosautov920.c | 1 -
 drivers/clk/samsung/clk-fsd.c            | 1 -
 drivers/clk/samsung/clk-gs101.c          | 1 -
 drivers/clk/samsung/clk-s3c64xx.c        | 1 -
 drivers/clk/samsung/clk-s5pv210.c        | 1 -
 drivers/clk/samsung/clk.c                | 1 -
 18 files changed, 24 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 62ae5d845853e6fed2498cecb1151c8cf99bcae4..84564ec4c8ecfa012743d3fa9826daeab4bb0f75 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -8,8 +8,6 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <dt-bindings/clock/exynos3250.h>
 
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 16be0c53903cf43537d6f5496c106a41eae62838..252cd02bc486837eb1d065e443d6304469e4957c 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -9,7 +9,6 @@
 
 #include <dt-bindings/clock/exynos4.h>
 #include <linux/slab.h>
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/of.h>
diff --git a/drivers/clk/samsung/clk-exynos4412-isp.c b/drivers/clk/samsung/clk-exynos4412-isp.c
index a6595b8d918b972208ba0b61d4c0d7f13bccaa3d..fa915057e109e0008ebe0b1b5d1652fd5804e82b 100644
--- a/drivers/clk/samsung/clk-exynos4412-isp.c
+++ b/drivers/clk/samsung/clk-exynos4412-isp.c
@@ -8,7 +8,6 @@
 
 #include <dt-bindings/clock/exynos4.h>
 #include <linux/slab.h>
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
index fd0520d204dc7e993b443fa1811c81f0a2e16a3f..0a59598233704b201ea97e907286f761152f54aa 100644
--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -6,9 +6,6 @@
  * Common Clock Framework support for Exynos5260 SoC.
  */
 
-#include <linux/of.h>
-#include <linux/of_address.h>
-
 #include "clk-exynos5260.h"
 #include "clk.h"
 #include "clk-pll.h"
diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index 99b1bb4539fd0f08da61814887af7a40da06b002..baa9988c7bb717cd87fa3c340062afa784985090 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -9,8 +9,6 @@
 #include <dt-bindings/clock/exynos5410.h>
 
 #include <linux/clk-provider.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/clk.h>
 
 #include "clk.h"
diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 61e7e7ce1f60aba005018054aa2155455dece6bb..4b2a861e7d573213e92666033893c44ae286b78a 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -6,11 +6,8 @@
  * Common Clock Framework support for Exynos5433 SoC.
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index e6c938effa29bc067fa4cf864fe721cce37d9fda..fe0fa5bdbd4bca6921d07403637f93ba5c92208d 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/of.h>
 
 #include "clk.h"
 #include <dt-bindings/clock/exynos7-clk.h>
diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
index 79613affe8ab99d78cc677e688dbb03a2dc7cbb0..ba7cf79bc300112d01cc0f81e1d74f65309707eb 100644
--- a/drivers/clk/samsung/clk-exynos7885.c
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -6,7 +6,6 @@
  * Common Clock Framework support for Exynos7885 SoC.
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index dfbb00312b03eea362f90149bfe36129a0d29285..cf7e08cca78e04e496703b565881bf64dcf979c8 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -6,7 +6,6 @@
  * Common Clock Framework support for Exynos850 SoC.
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
diff --git a/drivers/clk/samsung/clk-exynos8895.c b/drivers/clk/samsung/clk-exynos8895.c
index 66f9b735e3818cc993f1f61acaef4c38bf2a3285..e6980a8f026fc33645e72a3bdfd3b5eb3a64fa84 100644
--- a/drivers/clk/samsung/clk-exynos8895.c
+++ b/drivers/clk/samsung/clk-exynos8895.c
@@ -6,7 +6,6 @@
  * Common Clock Framework support for Exynos8895 SoC.
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
diff --git a/drivers/clk/samsung/clk-exynos990.c b/drivers/clk/samsung/clk-exynos990.c
index 2cb77a7c3e7830163e8337fd035b5fa426480be5..8d3f193d2b4d4c2146d9b8b57d76605b88dc9bbb 100644
--- a/drivers/clk/samsung/clk-exynos990.c
+++ b/drivers/clk/samsung/clk-exynos990.c
@@ -5,7 +5,6 @@
  * Common Clock Framework support for Exynos990.
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
diff --git a/drivers/clk/samsung/clk-exynosautov9.c b/drivers/clk/samsung/clk-exynosautov9.c
index 1834751650df82a4a89a1a50de4c68d985a0cb60..e4d7c7b96aa89be3677890102dd68f514a28aa08 100644
--- a/drivers/clk/samsung/clk-exynosautov9.c
+++ b/drivers/clk/samsung/clk-exynosautov9.c
@@ -6,7 +6,6 @@
  * Common Clock Framework support for ExynosAuto V9 SoC.
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
diff --git a/drivers/clk/samsung/clk-exynosautov920.c b/drivers/clk/samsung/clk-exynosautov920.c
index f9b4e9f09bcd0e77ecf99e72273776454b302f31..dc8d4240f6defc623cc2e075923556747c98a59d 100644
--- a/drivers/clk/samsung/clk-exynosautov920.c
+++ b/drivers/clk/samsung/clk-exynosautov920.c
@@ -6,7 +6,6 @@
  * Common Clock Framework support for ExynosAuto v920 SoC.
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index 079d3f4eda3f7acec84cc866b0ea7623104fa257..594931334574eba949af92095d2408f7a8f56933 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -8,7 +8,6 @@
  * Common Clock Framework support for FSD SoC.
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 97a4ccc103f62199cfd7d0d8d4b38bd2e127bfc3..b58b8e1c272d594c2855a043cedcce5a3f293b84 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -6,7 +6,6 @@
  * Common Clock Framework support for GS101.
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index e2ec8fe32e392844a85c63d837f10d3331d646f4..397a057af5d1e704e7ead7ba04b477fdc28c45bf 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/samsung.h>
-#include <linux/of.h>
 #include <linux/of_address.h>
 
 #include <dt-bindings/clock/samsung,s3c64xx-clock.h>
diff --git a/drivers/clk/samsung/clk-s5pv210.c b/drivers/clk/samsung/clk-s5pv210.c
index cd85342e4ddbe28538d9f30e88c490089adc5e2c..9a4217cc1908aa60ebbe51b2b5c841138cc46ef3 100644
--- a/drivers/clk/samsung/clk-s5pv210.c
+++ b/drivers/clk/samsung/clk-s5pv210.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/of.h>
 #include <linux/of_address.h>
 
 #include "clk.h"
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 8d440cf56bd45970929bd556b739194ed7b80ce3..80a98461184cb25b8d37df89f646239950623f3f 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -10,7 +10,6 @@
 
 #include <linux/slab.h>
 #include <linux/clkdev.h>
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/of_address.h>

-- 
2.43.0


