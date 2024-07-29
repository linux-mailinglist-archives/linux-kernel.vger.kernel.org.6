Return-Path: <linux-kernel+bounces-265140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2448693ED42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFC91F21D83
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012CE84E04;
	Mon, 29 Jul 2024 06:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqybDJqX"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098D84A52;
	Mon, 29 Jul 2024 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233719; cv=none; b=DliUtUIDvocr9YMsKo8Vw7HFILSveYxHIam5FfAf+bvGIR3UoIPqv3VPw8bKkXP8I0RUWSz/tSTR3nLTEiv7Fdqjj4bJC9L+U9pTzNNb2vGUJuHO13ZnprpxDp9703hdIHQ9kAzV2D9XjVuFoduYymHiXNZ+9IVzNdas5XVKwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233719; c=relaxed/simple;
	bh=ysklKRKld8V8uz/lk+r3EsEXyT7mOSONESzx3Jwf7aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSfmhSwZ+1vCyLN3/EgaDhVt8w6yUg789HUD439v/9FAviARe1asCX+6yGfBz/tVeVRwLCMRgp7dt795iWHWFpazbrjBSYxRP91QJzeHlMq9gI4RzG+5QuEel61JL5MJNFIDwP+zXPf2a51kGyvibUV/SjFU/q19BATuEPYZfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqybDJqX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb674b48ccso1614166a91.2;
        Sun, 28 Jul 2024 23:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722233717; x=1722838517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBK81cAG8HB/pM3iLFLgQMMBcwgxSE22Xy44PytBqCY=;
        b=ZqybDJqXXZQJtHuKURGAflJm/czhAWy+S5XZDl8Fl13XRJBri34QK5QNc8UChzj2wk
         yeOtMFfBnsFYyCfcu1w0SEq2dqVgdlvB8dARlyFnJnxTmQtrMvPcHiCTAU5Gc1e5Wnac
         qwfkepKYqAPC+nSZ+Tla4I2VrE+dcMKdrSygC6WV9OB3y6DHX9+IIqAaCcCKOQCz0YcL
         KVpHuKftIOkPzvRpwQrFFGtW/ELd4pr7fPPkWAJhIA71RqjMoVYcr4YevDAubmYj9npQ
         1fhKxaxZKNKqPRL+IMyQD/nkHq6QPIsliCzOKi1CeyMOVOWcr2kgOZrtAD+Uvmb9peRu
         AjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722233717; x=1722838517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBK81cAG8HB/pM3iLFLgQMMBcwgxSE22Xy44PytBqCY=;
        b=BlQb1JvfIsn/WF3ej574VMkQMtZX7+7KaL5SgBBtqzHEVVtj3xOSiWasKVHBfn0tTi
         koEIEjCEWvXie5VEN16uXlnpxg6BH8Wo/Cwd6mwWoF6iUP3L5/nkB7KoaMfRc5xeJ0YE
         lz/ZoPymNzjVaWJw4D05NHRt4TfwVkV8bYrtHhAP/RBVB2otSc2uFda5x2pw0ejLN8ky
         l+gz8SvlpD/s956fNDK5lrs1BIQkJ9hu13EqnPSsskil3xm9lZZBLc1L4F1rtnGtszDq
         mY85GBAdEkVez4B2VuekTU/mJdjc0CqpIEJOQDoINMXOLJbwldLCQowOLF2yC3tHovpp
         6gkg==
X-Forwarded-Encrypted: i=1; AJvYcCXGoCEN8ylSl9rflWcq9Pw28jrJTykDSrOTN4iHgOkyf8TuJg8gNaZAPSqc+Z9XWHGiw54xrbEni169G/l0UNIO9qdJiOsi6ymvl7B7G2ibGREhfyoAHvWcVxlR4XvqZLkim2F8JjaZzA==
X-Gm-Message-State: AOJu0YxC5Bb9GGmnUIsfEZOmNei1h9Yv4j6V+EiP8xTyY1i9U8VE+Nhx
	VnBgPHKx3XHgHbMo8mrOTi1djhcez+SAJTMZ4zzaAOpaQHTbYeow
X-Google-Smtp-Source: AGHT+IHQx/WyBPpe7O2QgyvTuWBNKJNHQWKMLEwREipsDVakaSEfYGnMsLlFDug3m9CyKyidNmYAxw==
X-Received: by 2002:a17:90a:db82:b0:2c2:d813:bffa with SMTP id 98e67ed59e1d1-2cf7e71e504mr3955738a91.43.1722233717110;
        Sun, 28 Jul 2024 23:15:17 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cd8cd2013fsm7951282a91.0.2024.07.28.23.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 23:15:16 -0700 (PDT)
From: hpchen0 <hpchen0nvt@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hpchen0 <hpchen0nvt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: phy: nuvoton,ma35-usb2-phy: add new bindings
Date: Mon, 29 Jul 2024 06:15:08 +0000
Message-Id: <20240729061509.83828-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729061509.83828-1-hpchen0nvt@gmail.com>
References: <20240729061509.83828-1-hpchen0nvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for USB2 PHY found on the Nuvoton MA35 SoC.

Signed-off-by: hpchen0 <hpchen0nvt@gmail.com>
---
 .../bindings/phy/nuvoton,ma35-usb2-phy.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml
new file mode 100644
index 000000000000..415ea2c45975
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/nuvoton,ma35-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35 USB2 phy
+
+maintainers:
+  - hpchen0 <hpchen0nvt@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35-usb2-phy
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+    description: USB PHY clock
+
+  clock-names:
+    const: usbd_gate
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle of the system-management node.
+
+required:
+  - compatible
+  - clocks
+  - nuvoton,sys
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    usb_phy: usb-phy {
+        compatible = "nuvoton,ma35-usb2-phy";
+        clocks = <&clk USBD_GATE>;
+        clock-names = "usbd_gate";
+        nuvoton,sys = <&sys>;
+        #phy-cells = <0>;
+    };
-- 
2.25.1


