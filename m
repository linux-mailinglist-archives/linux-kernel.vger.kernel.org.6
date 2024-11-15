Return-Path: <linux-kernel+bounces-410752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A39CE090
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D614C28D20E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6A1D5CE8;
	Fri, 15 Nov 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="b7Rq+2dY"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6F1D5AA3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678265; cv=none; b=hhrN3g3+H2evvy+QVxPQgBsMOZPVSegI0AnyJRTJ6flmFgUStz4POCQsZSvsfaNrS1t2gYrD37plD9FGGzDYdVwJCgObZNBzDNMc8MbIflFfTSFPUR3SID5E4fdrrYVtTF7+q2rsejmJU6z7n04ZQkStNmuDDgRjRdJvrTQF00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678265; c=relaxed/simple;
	bh=Xtn+xwaeKveSonyK8lBZ6c8vNKNq9XLdJom9rIVpKvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6yceA0PQe858DpjvK4x1sZcwWLTOYp1prVQb8wW/6iWBljW9ncxzSzL5/yjH9h4Dz9Tv4KI1xW8hmPt3qObvevYCvIQjstgnOMu9mnYshgnuIBJssXVSFKIM4y12L8xsGY9ouWy5chms9GYdjuUaIV4hRMg4EJ3K/4ANUQia8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=b7Rq+2dY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382171e1a83so1190137f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731678262; x=1732283062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4xNd4f74QqAVC9njr69AMtf06zExOqC5etPPxBTDYw=;
        b=b7Rq+2dYIsTK2+nZ2PGWa5XENygMi2GUiD9ot4B+9USdiFlRqs3AXJNZFmqdL6IZDf
         +rAlb+LUAXnMp0FWyVILx3LCf3fAzZn1kuqv1y8lE6+nYZPfRCmarFf3NJvaJxCQ0f1c
         dKk3JwHffFSOFD/NO5c6p9sqpCG8PKt53dGNbXx4hKPR/McEZhuz8h9u9REFUUHB9SU6
         4BEEh/HFg2QHjRq+OJhGTLxRF/NKboU59rXISlW8fTMOt5mey5K8Phzl4JNbilNXNkmB
         r5ruun2oRk7f3vD4TYeMV5K6k58NMDZxGi1SDNFJ0OXFwmZqenkaIewONAQPg8n/Y0Cf
         8bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678262; x=1732283062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4xNd4f74QqAVC9njr69AMtf06zExOqC5etPPxBTDYw=;
        b=vtd1DqjQc6HC4INqQ173TIrUg1NiF5ArF450mwhdlHyvaZoYHOmqgzAmuIhHVCSjuT
         9II5NTw88LppoRc1nYv187lPz7jxBP9Rlq63tvlpzLbrAyY/92TsQN9oIhBij1tACRkw
         pb5LHc0q1ygp8JBQfMmuEbe2F/kNT/fz0m8s3d5ObnUdtM8LkiVNRdUXCe5WoxV+q+5x
         gM3QVIbofh/hZRLbRAjirQaR0oMgmlH8xIZd13GnrIw0t1UjT77F4zGGEthYmYAHRXTp
         esiayG2P9/PyLD+2gpf6ruPdGjgjN0SfYfsD0YX07w2WVrwon3Frvub8YdH5ugz/87vC
         I+1A==
X-Forwarded-Encrypted: i=1; AJvYcCVEwRyB3tzqM8t4IVI3qIG7gSa5BHjLHbaQfrsYBysa4VaQU7gNHjpYmbBO3vMupp2iYyiDqdinR7w6bpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw87B2bzKIR1juVIvhl/bXl7kwuVPGYq3JtUJxFJ0Nf31Am20Wy
	0xTqUzE5miUSX6LknePs4isu804Cwd6Ejz1CvdJsiPbl4ARX6HeFvXRIsG73sM4=
X-Google-Smtp-Source: AGHT+IFpdfXow+B7b6EL5Q+UHupxWlc8uJA00Bm2tvNTNHdeGCMghy0mOzWdHSJP0G2ozqaVunSxsw==
X-Received: by 2002:a05:6000:4027:b0:374:b6e4:16a7 with SMTP id ffacd0b85a97d-38213fff9cbmr6846079f8f.8.1731678262470;
        Fri, 15 Nov 2024 05:44:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3fc9sm4378016f8f.20.2024.11.15.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:44:21 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 6/8] arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe different switches
Date: Fri, 15 Nov 2024 15:43:59 +0200
Message-Id: <20241115134401.3893008-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

There are different switches available on both the RZ/G3S SMARC Module and
RZ SMARC Carrier II boards. These switches are used to route different SoC
signals to different parts available on board.

These switches are described in device trees through macros. These macros
are set accordingly such that the resulted compiled dtb to describe the
on-board switches states.

Based on the SW_CONFIG3 switch state (populated on the module board), the
SCIF3 SoC interface is routed or not to an U(S)ART pin header available on
the carrier board. As the SCIF3 is accessible through the carrier board,
the device tree enables it in the carrier DTS. To be able to cope with
these type of configurations, add a header file where all the on-board
switches can be described and shared accordingly between module and carrier
board.

Commit prepares the code to enable SCIF3 on the RZ/G3S carrier device
tree.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- none

 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 20 +-----------
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 55c72c8a0735..5c88e130c89e 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -9,25 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
-/*
- * On-board switches' states:
- * @SW_OFF: switch's state is OFF
- * @SW_ON:  switch's state is ON
- */
-#define SW_OFF		0
-#define SW_ON		1
-
-/*
- * SW_CONFIG[x] switches' states:
- * @SW_CONFIG2:
- *	SW_OFF - SD0 is connected to eMMC
- *	SW_ON  - SD0 is connected to uSD0 card
- * @SW_CONFIG3:
- *	SW_OFF - SD2 is connected to SoC
- *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
- */
-#define SW_CONFIG2	SW_OFF
-#define SW_CONFIG3	SW_ON
+#include "rzg3s-smarc-switches.h"
 
 / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
new file mode 100644
index 000000000000..e2d9b953f627
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * On-board switches for the Renesas RZ/G3S SMARC Module and RZ SMARC Carrier II
+ * boards.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#ifndef __RZG3S_SMARC_SWITCHES__
+#define __RZG3S_SMARC_SWITCHES__
+
+/*
+ * On-board switches' states:
+ * @SW_OFF: switch's state is OFF
+ * @SW_ON:  switch's state is ON
+ */
+#define SW_OFF		0
+#define SW_ON		1
+
+/*
+ * SW_CONFIG[x] switches' states:
+ * @SW_CONFIG2:
+ *	SW_OFF - SD0 is connected to eMMC
+ *	SW_ON  - SD0 is connected to uSD0 card
+ * @SW_CONFIG3:
+ *	SW_OFF - SD2 is connected to SoC
+ *	SW_ON  - SCIF3, SSI3, IRQ0, IRQ1 connected to SoC
+ */
+#define SW_CONFIG2	SW_OFF
+#define SW_CONFIG3	SW_ON
+
+#endif /* __RZG3S_SMARC_SWITCHES__ */
-- 
2.39.2


