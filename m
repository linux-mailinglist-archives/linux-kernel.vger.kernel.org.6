Return-Path: <linux-kernel+bounces-342406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E351C988E8B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA54282657
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C167E19F126;
	Sat, 28 Sep 2024 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KcutP+KY"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648B19EEC0
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727512699; cv=none; b=I98atFHY3OsmEv25rB3G6ohettPh1EIMItvNjQ4pK7t+Poun5z6fV44kxmMxeiMZdhaSqgwLgwA1tz90jFZm1nX/8VG1JChiJrCTTKDZ/7neu5Olk4BNQ3//U5Mx7M2QTxBoOo5OaltWth9rrZztc/gwibc2UCTbm3QrpvaOs2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727512699; c=relaxed/simple;
	bh=Lja37Vxknt4vNnaSkdJb0D6DbUgmwOpWSwtN5vUK9Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaw70+T0esVJunHnrqXKSM/wTJ2D0FvU9TbxbDCSsGC6GsU/9PtcTX51XWd9lsz+5TDh9rWQnt4Q+z9WusQzClhAZVtYrw1Uzn7cIGDFn8Zmkba5zV1BG4K+l3si5EJG3nzz55qbp+X0+yi4rehoeQC6mCjc5A5DSH0vhL0NufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KcutP+KY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so370850466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727512696; x=1728117496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgBA2YgBzcVdnVEoc6s2KOvaf1NpbuG7MmZKT5HNBsQ=;
        b=KcutP+KYLBaaKxVBaMldgqD2POa0Pfx85E4rx5uo/bx0+6T1pw+rViVss5DJr8lKgY
         u1NHsUSEDDWH2D9n+ambUVGmBG8NhzS+In3x6tpqUxmTbCjnILly3+cx5XqTvvYbu+qP
         3WX4i/+zKzdKYuAt1wyESSeCc8yKo9CtebYOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727512696; x=1728117496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgBA2YgBzcVdnVEoc6s2KOvaf1NpbuG7MmZKT5HNBsQ=;
        b=pptcUUI5dYp9R5Cs4EejYvFe1qNr7W2ID7AKbGkXobMm8PRzTDqgPEuHpDfLqMH7M7
         X/vgHzOO/Q5Pb+un+TLfVcu/633xymyyiaotMObTn/fEJJfDfEX/vX2blgOo/GynFnYi
         CEvMJ8z+ukrU9Z7c6ofYVVFxuMQRtlYGDXCE4ZfCR7owFnCPk8yuOT3yI0oV4azF4VsK
         v2oLtYJ+f0+IZP1E3W9bF+o20q7AAO8fxt1/3LkszZMn/zj9fGrz7e07eKFMvuaZkeM1
         sNRSLgkMPoZbgxhd2/FRX9qq81NctRgmcCszobhrVTPCZ/qiyiIvqE69FsfbWcL77a1H
         mryg==
X-Gm-Message-State: AOJu0YxPfZT9FPQF6r9eKb1pUjkxR9S+kSYJ1ia6Zv4QHLfrxx3VNFXw
	QlqmHey+veza8HAst8oOnH2wEAji5YB4wMIEAE0yShcV8lVLTTxTkBKIvPKWfSDaGJmd5N3NCVZ
	/Qbw=
X-Google-Smtp-Source: AGHT+IHW+mNjedKWSVNhjRyLls2JlxbznPHja/LY2bWHOSPBdNL3yKePDnTYBIPjvZtBQUPB/9/APQ==
X-Received: by 2002:a17:907:1c19:b0:a80:bf95:7743 with SMTP id a640c23a62f3a-a93c48f8a9emr546855266b.13.1727512695646;
        Sat, 28 Sep 2024 01:38:15 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-102-102.retail.telecomitalia.it. [79.54.102.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947a48sm223679466b.118.2024.09.28.01.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 01:38:15 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: clock: imx8m-anatop: support spread spectrum clocking
Date: Sat, 28 Sep 2024 10:37:49 +0200
Message-ID: <20240928083804.1073942-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240928083804.1073942-1-dario.binacchi@amarulasolutions.com>
References: <20240928083804.1073942-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch adds the DT bindings for enabling and tuning spread spectrum
clocking generation.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../bindings/clock/fsl,imx8m-anatop.yaml      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
index bbd22e95b319..c91eb4229ed3 100644
--- a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
@@ -32,6 +32,47 @@ properties:
 
   '#clock-cells':
     const: 1
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,imx8mm-anatop
+
+then:
+  properties:
+    fsl,ssc-clocks:
+      $ref: /schemas/types.yaml#/definitions/phandle-array
+      description:
+        The phandles to the PLLs with spread spectrum clock generation
+        hardware capability.
+      maxItems: 4
+
+    fsl,ssc-modfreq-hz:
+      $ref: /schemas/types.yaml#/definitions/uint32-array
+      description:
+        The values of modulation frequency (Hz unit) of spread spectrum
+        clocking for each PLL.
+      maxItems: 4
+
+    fsl,ssc-modrate-percent:
+      $ref: /schemas/types.yaml#/definitions/uint32-array
+      description:
+        The percentage values of modulation rate of spread spectrum
+        clocking for each PLL.
+      maxItems: 4
+
+    fsl,ssc-modmethod:
+      $ref: /schemas/types.yaml#/definitions/string-array
+      description:
+        The modulation techniques of spread spectrum clocking for
+        each PLL.
+      oneOf:
+        - enum:
+            - down-spread
+            - up-spread
+            - center-spread
+      maxItems: 4
 
 required:
   - compatible
-- 
2.43.0


