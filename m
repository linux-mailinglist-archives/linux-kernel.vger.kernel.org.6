Return-Path: <linux-kernel+bounces-574439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011A1A6E535
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0117A9861
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D51F153C;
	Mon, 24 Mar 2025 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b="gjQCKM5R"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDC1E0DD8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850666; cv=none; b=cGEO2btWGOanrdZ9AWQQdTaSu1bl8k1JTcaf8SuMpr8N3Odd15m9mDP9CBUK5CZUzWaEjyZL4+MLeozLZoG0MIgodQbh5D7UN6CQs19RUjOug3Pg1dJpqsVru3V+1CZ0pQapa5+mYsdqUrHHLKTOlFWdXBvWzkCwJnouMhaXrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850666; c=relaxed/simple;
	bh=4RQgTHTB8Ct6Xa+I+6KGuh64DGDd4HkaTwvKvZHrn6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jY1cir4cr3/vMXEe+OYuvqHUVpTc23DeUtxIDRmKsziUrEjibVFPdwfF3FRHPBOxsiYGYNjMxn5zpzfop29O5yD8Ky/9nyRz/KLq1LVv2JhVVe34gyLuebMtevtIuWNr/SquOkGE3sohcqwmqJSSWHow5xjPCcwBouy2p73vQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl; spf=pass smtp.mailfrom=conclusive.pl; dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b=gjQCKM5R; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conclusive.pl
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so8673740a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conclusive.pl; s=google; t=1742850663; x=1743455463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JyTyzWQzsPLSAvCjZH0qopjCEpB8Oh/jlTrjLbGKY8=;
        b=gjQCKM5RhsXU2FWx+QAPyuLE2aSr0a0JeiIi+vVJDwd4MD8VQkbt/lID5z3nRJQttL
         ggPBddmJKb/27PJTK6ALT+a9M7BneiWBlvgh2poG2Sr7IkFJLXU4ERY4yXrUI1Y4ueF6
         KEsprez5pihAZS4LLthy1dy3DAdm3ZjEAUEfX3KFXrNZXsIaNHd0gDEA/eCyEPnKESH5
         i/rBsKltbv3KJ3hlZwd8TxWedSTV9miXPuUpyrysvdtKuXTSKBB6LvXJLbom44yYbhhn
         uWNo1lwvPZIE+jKcRiXx136UDnG//cCUiPpQpRTYg9IoMzBbgmrQehHrkz2O91U1VQoh
         4byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742850663; x=1743455463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JyTyzWQzsPLSAvCjZH0qopjCEpB8Oh/jlTrjLbGKY8=;
        b=r/Wc7ZYyUTHWSKTMT9a9PF3bu1Q80+oGag4nbNpPAYMNbz41zgZzdAqEyxkNihrluc
         IQQbpwyeRz7GcsKgESav/8aZmeurvPcfcK7LwaGBued73t+N3uQn6zXEJIyaq6jKe4E4
         ZRLgUICE/CNsAoNNSnr4vMo04ciBLvaOrgI8QQEOspC0AmNwimxuyXHDUT0CwCTJbOgj
         3jI+/oZb+Hs63sLsExFHZAq6hTzS+tcnD8OgCi9uOWGtmHbh8YyIYOGmrkvQhjAlPYq9
         K8LuBWfvGjE1X0UgpluEYPrX6kI6Ev0o63wPn5rOV8Fng6BKQaOXIdsky8+BpTR5XGsJ
         8c3g==
X-Forwarded-Encrypted: i=1; AJvYcCX9tdWaRnACesLAGaaaV0yVgHiqYViTc6d0LP92MFX0WmYn2AM3VUd4A1Ejl7FAey9vRDTMA+7VGTHXqI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtlIw+7rVah/IITPVpCv29zEH+zIKlnJU8RCvyiSYaDyembC6M
	Zpe2xc/c25PeAf2Sy3y20WOEtbo3bj8/ZmVCmmW8+HOakAqIxEMJX8/Os82zPlYjbc8FUe4fqlU
	JjlU=
X-Gm-Gg: ASbGncsA9qHTzz0cNy3isY0NcLp1JCnndEcxO7d09NIHImF+dfBmGO4aJEdy6sNPPFt
	Y8s1BupwmXq99MA2fN6VTjX4KjBwOfMg/Hd79pS5YuMtKkvx8CtFNSUmAAgR8S+HoWVRsbQty9U
	q/PW11UPWlwa6cXSlSpWv6VSBrzp2vi/5PlRw//Ton5C10W617/F56/OCAOxu/2EAgaYu6KZZja
	O1N/B43cMMZhz1M7/KSmillJvgpXFQKNIdlWt4vZ3SL/VtK/e95jPtc6II7LIkJ221xMjDIIcX0
	JYTqt9X3YV0RysqNn7fXlHFqCJdX4NP4BPfhfJq9HpXHXewb4oT+FtFWVRPeuwMm6ZJedUTLPOV
	GxfgoNXOwxSo3
X-Google-Smtp-Source: AGHT+IHQu1Ep08TqCw8sMIrAIIK3Br1RIklS9BeCUwXWKUSLGw/dsImCMrXCZ7IuFKP4fu+js5jeqA==
X-Received: by 2002:a05:6402:2708:b0:5ec:fb3d:f51f with SMTP id 4fb4d7f45d1cf-5ecfb3df8bfmr1335127a12.10.1742850663062;
        Mon, 24 Mar 2025 14:11:03 -0700 (PDT)
Received: from wiesia.conclusive.pl (host-89.25.128.123.static.3s.pl. [89.25.128.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0e0cb6sm6537097a12.79.2025.03.24.14.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:11:02 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Klama <jakub@conclusive.pl>,
	Wojciech Kloska <wojciech@conclusive.pl>,
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>,
	Artur Rojek <artur@conclusive.pl>
Subject: [RFC PATCH 2/2] dt-bindings: wireless: Document Nordic nRF70 bindings
Date: Mon, 24 Mar 2025 22:10:45 +0100
Message-ID: <20250324211045.3508952-3-artur@conclusive.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324211045.3508952-1-artur@conclusive.pl>
References: <20250324211045.3508952-1-artur@conclusive.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a documentation file to describe the Device Tree bindings for the
Nordic Semiconductor nRF70 series wireless companion IC.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---
 .../bindings/net/wireless/nordic,nrf70.yaml   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml b/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
new file mode 100644
index 000000000000..1c61f7bdbf8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/nordic,nrf70.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nordic Semiconductor nRF70 series wireless companion IC
+
+maintainers:
+  - Artur Rojek <artur@conclusive.tech>
+
+properties:
+  compatible:
+    const: nordic,nrf70
+
+    req:
+      maxItems: 1
+
+  irq-gpios:
+    maxItems: 1
+    description: HOST_IRQ line, used for host processor interrupt requests.
+
+  bucken-gpios:
+    maxItems: 1
+    description: BUCKEN line, used for I/O voltage control.
+
+  iovdd-gpios:
+    maxItems: 1
+    description: External, GPIO-driven switch, found in some nRF70 based board
+      designs, and used together with BUCKEN for I/O voltage control. Optional.
+
+required:
+  - compatible
+  - reg
+  - irq-gpios
+  - bucken-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nrf7002@0 {
+            compatible = "nordic,nrf70";
+            reg = <0>;
+            spi-max-frequency = <32000000>;
+            voltage-ranges = <1800 1800>;
+            bucken-gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>;
+            irq-gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+            spi-rx-bus-width = <4>;
+            spi-tx-bus-width = <4>;
+        };
+    };
-- 
2.49.0


