Return-Path: <linux-kernel+bounces-530809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E680AA438AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7143B917B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD3266B54;
	Tue, 25 Feb 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU3iaigC"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7391266570;
	Tue, 25 Feb 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474058; cv=none; b=rGHSlhIZSUKorXondF73/3NxmjFAn9j8tcwO/2hn4QXwK/UjGPbW4XBJxDiqqlOKxYVaNU+NleEc8PT2CZOmRrglLnw0QtOwMNWHuXSrZrMu7R9Iq8Qt1SLFel0GH39kjBQkm5ITjHgKTBsKI8HPD9E5wG0km8a9WYluum7DVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474058; c=relaxed/simple;
	bh=iZlL0v8sJ2M1Sgjt7ABFG6G01BsRNv1XByk1kPOAizE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCdd7/rDwt+Ee7uc/c2vxtzhJYv7RmJkEee3BiVe0aPZGfhwfGBWScI2Caw2fXuR9ES4A2wF1f7eo1NostcP15vhz06j3j7iVNuO+rGWtCXbPiNYcLDIXYn47p8AUSmQV6WnOmixW9zR5gqAm0JMy+uFdQuONWnj97cJXT0S67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU3iaigC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e0516e7a77so8208301a12.1;
        Tue, 25 Feb 2025 01:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740474055; x=1741078855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVPl+goU4HOiK9lu2rD5pgIT5rCWskc2GofQkeFl9Y8=;
        b=MU3iaigC4lXXvuXGcKGnWGLrdTnneUrRcCd5q2f3gLDuaeCqqh/GrYtDCAqOFFA3Zp
         RQITDE1eNTlfYu/ggCV3TRjUWmvv6C2aSjD+6j1YBOO1/FZA9ZHeTroN2cyFjNZtyvUM
         EKfS8ziWiRWgFwu02dHMHqV+u7lpUzwQ22u+dvRWlWZ+X8FjonaOnE7fsDoEgJzBvY4W
         c3M75bUEUxPO7wHU+EPdjVAhp/hnDXlMLguE6WZtZeenqKNXp8FaOj8u9nQ51LAUYkEw
         NFUIlMt7kEq4hzEGcT3MQ0UaizDK0AApiTn6ze77QCsC0xJiP+c7SA6A+K1asMsHdGs7
         zTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474055; x=1741078855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVPl+goU4HOiK9lu2rD5pgIT5rCWskc2GofQkeFl9Y8=;
        b=H6anAMHXc6YkfVu57Bg7tUy59GxjPcuL4JQlPBmBC4l4cY1Cjy05tkJjvgOIZ2jC94
         803vOtxd/C0Ib4j6IGd946qPzTgO1bECbvo21kBqlxtwOaIicSPRBLmBWeZCtgbbaGxx
         bl4Ne/UtNq0r4ZXBZs3JcWq4FcEzJ/KRdzCZbxy22ksiYbgOYdZplnYnORq2nROyKxol
         gcgdA1dP+S+Z6uimgW9OidCzvgawCHO9DbTpsFwOEx0ZhCkHquuRoWKq56ApOQkYqzHi
         Ghmv1VmXPQ06OjFLT80mDk2FF+mIM5bj7mkPLNGyzIedbTiaVxcJbZ5WtjejIFAEK++8
         b1OA==
X-Forwarded-Encrypted: i=1; AJvYcCUEuEz0ynV8MvHOGm+41neYPYRFgs6hR3vs7RV1uQPlvZFES96PLnezpvjfFdZ52XTVZtu8gfh3OVRH@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRakECBAtz9xFf3cNrIPn0LFe2zHGUSXt7rZMoWA1QXtlJbO3
	VZcGxawAFcWp3QiOSmcobzFLFmwv/Sc5p4Yx0rejV+1jTZwZMpDf
X-Gm-Gg: ASbGncs84bS0FlHRWe/dq78f31h2M/NZRUW+D5zCgo6HjKG+RP7ZEj3dXrsPCKe46BS
	Qbi546+TFtFcO0tGTlO7CSGPZ4S2EcFY6h30KyOe/LUCDlNfjtE5AI+m5R31Xw2rpgomrUmpCwR
	b8t/OHI0VktPfUm0c1Iv6SwVaUibtrUTgxWcoP47BC+3dlb97T01bBdfmaC7onPOCYykWifiN7V
	USPM8GsfboA0tLa5o8lgj3OFLVx0x5BY6OHUFZ5TQN9XCtN60f0gJ80l7FEBZiNJ112G920cv7J
	1unBhYEMPDbhidwC+Q==
X-Google-Smtp-Source: AGHT+IE4kxnk4mwYCDD/brzpioKVmjVOxUkZTZ2zRFd28y5Gr/bEDhA1UOdp3A6BQ4FXS8N54A2x0A==
X-Received: by 2002:a05:6402:27cc:b0:5dc:1289:7f1c with SMTP id 4fb4d7f45d1cf-5e0b72546e9mr15717805a12.29.1740474054595;
        Tue, 25 Feb 2025 01:00:54 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45bdc6fcasm911881a12.48.2025.02.25.01.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:00:54 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: extcon: Document Maxim MAX14526 MUIC
Date: Tue, 25 Feb 2025 11:00:13 +0200
Message-ID: <20250225090014.59067-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225090014.59067-1-clamor95@gmail.com>
References: <20250225090014.59067-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Maxim MAX14526 MicroUSB Integrated Circuit.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/extcon/maxim,max14526.yaml       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max14526.yaml

diff --git a/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml b/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
new file mode 100644
index 000000000000..7eb5918df1c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/maxim,max14526.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX14526 MicroUSB Integrated Circuit (MUIC)
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    const: maxim,max14526
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - connector
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        muic@44 {
+            compatible = "maxim,max14526";
+            reg = <0x44>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <72 IRQ_TYPE_EDGE_FALLING>;
+
+            connector {
+                compatible = "usb-b-connector";
+                label = "micro-USB";
+                type = "micro";
+            };
+
+            port {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                muic_to_charger: endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&charger_input>;
+                };
+
+                muic_to_usb: endpoint@1 {
+                    reg = <1>;
+                    remote-endpoint = <&usb_input>;
+                };
+
+                muic_to_mhl: endpoint@2 {
+                    reg = <2>;
+                    remote-endpoint = <&mhl_input>;
+                };
+            };
+        };
+    };
+...
-- 
2.43.0


