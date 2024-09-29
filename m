Return-Path: <linux-kernel+bounces-343078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E607989689
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA604B23340
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01F38DD6;
	Sun, 29 Sep 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BvSAKI2j"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DF2746B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630871; cv=none; b=MGtV5FJW/88xln8RwDBj1vYVwGl6xQBscOZf/05O7j9QIm5ZTJ+u+mZYO1i44qs9+L93RT00A2BDXUAL+tzQLagzn+nmWmyE0eYF/B6daQG/iNBhhn+F7c38HihvJBexGiXruadmkcJ72A011pVo6NDwwOfsMvX9JuSer/Y1Ga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630871; c=relaxed/simple;
	bh=uvG2ZBBvlONgFb6ld/20Z5sUyTEIwR4mml2r/1eTS0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhrHii+t53XwqtiWeudarEVSkEw04bZc6NlrhbQpCu5ZF3VvQVamqTyfc2iRtmUuq8JZDgN4vb7qvSdemb4FeM0tlJcl8AkeAoOidDfgKm411EcrwPaJRGVw/VKHogXZ3UBeUiT98RLvk+GG0XNSF5y+hUA1ua9CIHaORmCHowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=BvSAKI2j; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d4093722bso555734666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727630868; x=1728235668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsgh0kyD9U5ZxoRxA8QRLb2QSbsWIvPPTG1CIfNu7Us=;
        b=BvSAKI2jmHIwip2Gm1EwxGgDYXK5QOo6YOmqsK55xjp4geggKiLEVhz5Z4P2S0SZMs
         67UTvIebprLPCasWNLj7I+334ZdGm3efwF1he7byN7UZHQfgS/zRFkIcDBIXwMukrjJk
         Iwq8hlVdpy1LjTNQH8t8fKcilzoOUVKcS9Xyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727630868; x=1728235668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsgh0kyD9U5ZxoRxA8QRLb2QSbsWIvPPTG1CIfNu7Us=;
        b=lJNFd84SOhcp4NJwfx+chYbpq3EhVdrSarhyPqEXKG1OL4J2UO0FLQa9lXThXR+omm
         1eQ55ucG8Qnh25oaK+bEDtWK4WzMrUhhWlItO71rKHqR/UrpOvOyw3cBfAkKEOXJEEu6
         NIooPlcjrKG4xFzjKOcUTdR0YNlkZaMcN12YW4f1HGDRhklHXxVUA1DyMm1QPAqUqg1t
         YFhTTUNhbS6tCaDP8vYfY2meKI2mUhva4P5Du+3Iyi00gcBmUmJSkML8JmKPXNEPjGVO
         3FvKEZqpiYLMZDJqPsJfA9CgPWAuJZnNwF+SWs3LUnWMro1KsGsN6JFJJjeoqkubdg5p
         HTdg==
X-Gm-Message-State: AOJu0YzSXDCCaP7G9JQLlajcNY+IGoaPVBB3FTIfUdyTUEm+01MCEj3R
	kfaEDFMse+JHjD1I2GRd9zrjYgcOznAsbggbW1I+tqqPsyEQvNshJLOYGV44wH3EJTwxIZ0oMTh
	4qEA=
X-Google-Smtp-Source: AGHT+IH0U0CFGTyBm5aWi0+/zzNcuCbHRfOuBcATCnCKjGvCfFUbitCFY9qFU4g74wA0OIxwoHN6QQ==
X-Received: by 2002:a17:907:3182:b0:a7a:a892:8e05 with SMTP id a640c23a62f3a-a93c492a4eemr1095867166b.33.1727630867626;
        Sun, 29 Sep 2024 10:27:47 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-102-102.retail.telecomitalia.it. [79.54.102.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776a1sm403176866b.8.2024.09.29.10.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:27:47 -0700 (PDT)
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
Subject: [PATCH v2 1/6] dt-bindings: clock: imx8m-anatop: support spread spectrum clocking
Date: Sun, 29 Sep 2024 19:27:11 +0200
Message-ID: <20240929172743.1758292-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240929172743.1758292-1-dario.binacchi@amarulasolutions.com>
References: <20240929172743.1758292-1-dario.binacchi@amarulasolutions.com>
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

Changes in v2:
- Add "allOf:" and place it after "required:" block, like in the
  example schema.
- Move the properties definition to the top-level.
- Drop unit types as requested by the "make dt_binding_check" command.

 .../bindings/clock/fsl,imx8m-anatop.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
index bbd22e95b319..a142c04fef00 100644
--- a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
@@ -33,11 +33,56 @@ properties:
   '#clock-cells':
     const: 1
 
+  fsl,ssc-clocks:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      List of phandle and clock specifier pairs of PLLs with spread
+      spectrum generation hardware capability.
+    maxItems: 4
+
+  fsl,ssc-modfreq-hz:
+    description:
+      The values of modulation frequency (Hz unit) of spread spectrum
+      clocking for each PLL.
+    maxItems: 4
+
+  fsl,ssc-modrate-percent:
+    description:
+      The percentage values of modulation rate of spread spectrum
+      clocking for each PLL.
+    maxItems: 4
+
+  fsl,ssc-modmethod:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      The modulation techniques of spread spectrum clocking for
+      each PLL.
+    oneOf:
+      - enum:
+          - down-spread
+          - up-spread
+          - center-spread
+    maxItems: 4
+
 required:
   - compatible
   - reg
   - '#clock-cells'
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: fsl,imx8mm-anatop
+    then:
+      properties:
+        fsl,ssc-clocks: false
+        fsl,ssc-modfreq-hz: false
+        fsl,ssc-modrate-percent: false
+        fsl,ssc-modmethod: false
+
 additionalProperties: false
 
 examples:
-- 
2.43.0


