Return-Path: <linux-kernel+bounces-308824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36296623F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87536285ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B81A2869;
	Fri, 30 Aug 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RmBgP+v8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF661A7AC7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022958; cv=none; b=pplE2DtR3vl649B5dz/MG3+sAhNqmn9B6LWKKO2lFeLAw0ZEOZ1ebJ+gvUAuFUWbpXJFqzC3J5Rs1BhVMFpV8tHd22epvovqlKpKsFzGIkYm9Ph7OSf7mGsN6rKkh+hg35HsulVn1FG3ToO7vXN6//EhauOpZ6kwbEzzs9ada5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022958; c=relaxed/simple;
	bh=ztQUR7g1nFtGfo3ZWO1RYiC+vn0VSyCOgeN9uwLc4Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cE+uHcIAjtFd/2Kv7KLe22O/5YKJKmT84Vln5azMSGk8U/1I46rOMsfIr54H9hcV98fGvaZvS+OiQuXVY8NHrjWJJ4OtwOH7J+NdKVy1FBX7Y/7FbyADOS1tok8TpQdVM2Luu1N+kn8+VtxCMCHkXkJq3FKetMhPNwQDf7MivuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RmBgP+v8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bbd0a40faso4477455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725022955; x=1725627755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4cKF8EHnw7ozuhAiETk6JACXIX9wuY1t5hqCiMxxVQ=;
        b=RmBgP+v8Ft2QiqN6pok1Il++bEf8Fu21ZLFGUaoJsPIFSDKVm1JzOBldZ+UBG+rmPY
         d4nYXcla5aIaxXCJnRnMlpB4Yo4h1jXcrBa+D9gDfn6YYqKcFnm0M7snAeNjFeeeyEpz
         tIaAiQMKCbFtqDOKfMlQGzqNzprOaQaOfWlRP9DBj1odu+S0h1Vm51goClM6hf+s4jJj
         N/TsmzxokSGDFHnRKDhEMnEVTxD4X9TGfOLtxjpyuN8TEAMw6CeRGfQsBPZV921xLeTM
         aYbPoKb+uHZH4qASco4hBOX6J4ZRIPfBBZSriCY7bY5titBGWEKJs62iViV0xvjcIq/S
         1LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022955; x=1725627755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4cKF8EHnw7ozuhAiETk6JACXIX9wuY1t5hqCiMxxVQ=;
        b=OpaRb6eRnHiPxpXUOCsUijDbKL5qVd0UFi6VQbpgFWj2l5d7BIPKULbJBrD9ckLwZq
         I0qheG2YxmlRSIGHuE8vT1BrC4eqASFAwFX2VGGoWQluQDYIvwF3UWMtEfnbfvnirDYp
         ZoGoQBzG19z/4sDMidhRUnu+2pHy0lXKU42wxaBHlpc0ajQtGCv1u+bu7WaPV3ks3mvQ
         K7fJhFxxWHMh0m9VqPv2QeZJTnSyDmaJ3PDI0y4XO5Em4tDlDSHcdgW8WDqghw4YIZpu
         RabsIVgWGMbW+AIIeBQAIE0x5L/LbVoT5E0tpnXsvZhRYH/kUDglCEQimHwNQaVU+eyD
         hmZA==
X-Forwarded-Encrypted: i=1; AJvYcCUfPnuY/nsXzWHVHFPoiWFZTw804uTeFuNhgYW5CLtYv8/jrt4D5YeU462QCJoIYp0L2n8iOGBgcwUVW3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOTcFhe2UAtzJCwWaos6JGphgeIwEsNf2uIRx1QEnlUZxG+45X
	/w0ZfRX+w/mclf2D4M+U3En0+y/cRKHhXIHYom3Nu7qBIiYVQ65vO9HqJx4dbE4=
X-Google-Smtp-Source: AGHT+IHY4ZU8GIEWhH/eJKahz8/5zLuBrFu0wzb09xgJDwo495hKXLFy1Xg9RJNV3C4Xc2gSj0XwHA==
X-Received: by 2002:a05:600c:434a:b0:426:63b8:2cce with SMTP id 5b1f17b1804b1-42bb2a1abb9mr50943975e9.7.1725022954457;
        Fri, 30 Aug 2024 06:02:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba642594dsm80361785e9.47.2024.08.30.06.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:02:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.belloni@bootlin.com,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 02/12] dt-bindings: clock: r9a08g045-vbattb: Add clock IDs for the VBATTB controller
Date: Fri, 30 Aug 2024 16:02:08 +0300
Message-Id: <20240830130218.3377060-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830130218.3377060-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240830130218.3377060-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The VBATTB controllers controls the clock for the RTC on the Renesas
RZ/G3S. The HW block diagram for the clock logic is as follows:

           +----------+ XC   `\
RTXIN  --->|          |----->| \       +----+  VBATTCLK
           | 32K clock|      |  |----->|gate|----------->
	   | osc      | XBYP |  |      +----+
RTXOUT --->|          |----->| /
           +----------+      ,/

One could connect as input to this HW block either a crystal oscillator or
an external clock device.

After discussions w/ Stephen Boyd the clock tree associated with this
hardware block was exported in Linux as:

input-xtal
  xbyp
  xc
     mux
        vbattclk

where:
- input-xtal is the input clock (connected to RTXIN, RTXOUT pins)
- xc, xbyp are mux inputs
- mux is the internal mux
- vbattclk is the gate clock that feeds in the end the RTC

to allow selecting the input of the MUX though assigned-clock DT
properties, using the already existing clock drivers and avoid adding
other DT properties.

This allows select the input of the mux based on the type of the
connected input clock:
- if the 32768 crystal oscillator is connected as input for the VBATTB,
  the input of the mux should be xc
- if an external clock device is connected as input for the VBATTB the
  input of the mux should be xbyp

Add clock IDs for the VBATTB controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none; this patch is new

 include/dt-bindings/clock/r9a08g045-vbattb.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 include/dt-bindings/clock/r9a08g045-vbattb.h

diff --git a/include/dt-bindings/clock/r9a08g045-vbattb.h b/include/dt-bindings/clock/r9a08g045-vbattb.h
new file mode 100644
index 000000000000..67774eafad06
--- /dev/null
+++ b/include/dt-bindings/clock/r9a08g045-vbattb.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__
+#define __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__
+
+#define VBATTB_XC		0
+#define VBATTB_XBYP		1
+#define VBATTB_MUX		2
+#define VBATTB_VBATTCLK		3
+
+#endif /* __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__ */
-- 
2.39.2


