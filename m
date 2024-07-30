Return-Path: <linux-kernel+bounces-267660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470E941411
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958511C23265
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901621A0B1A;
	Tue, 30 Jul 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNmGpiH7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3CF193080;
	Tue, 30 Jul 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348856; cv=none; b=WvJmSFsGbtBeLxhWBMGb6QJjK2oDynAo7Gv+MrgGqA+BWHSmp1U4k3lx1+PcAAWkVnZ+WZhb/tWjy1sCEIJFnEFJ0HbjL7gnkkjF7P2OEwIvjH3Qyb0tbG6eH7I456qZVNr+3binP4y6nWjif94M98UqAAgxtOgcWBr3nPurlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348856; c=relaxed/simple;
	bh=2B9faLX+S8lBby/cfiK8W+KbIKMy4XeN7GFqrp09SGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0iAEXdJz4aDxgPgIMi71xan94hBIgfIvkbuIP7gJQVSYXNs86HlWSD+Rxb5w0s2J1dCH2Cg3jLtQ3xgvQg2NDGWDg40z4NUqQmH/aZt3La7QRLMXofjW4nCOw+k6IUlQYcLdJpDKzTWv9B2/uM/S/HbTzEocCGzF/SSfpC6iCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNmGpiH7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc52394c92so37916135ad.1;
        Tue, 30 Jul 2024 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722348854; x=1722953654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJ1W777DTxzVK3kLsp7gjF2RIvle9V5zMG9vfW7qFnU=;
        b=GNmGpiH7khf5BRgPK4prvE5FvM6rTLCsCV3ZK2mCvspOFI4dm+HY8j4bSgyjRPT6OQ
         Eb3yN+Iv98NG16wnZWTK8v9XzJ34ni47PCrhJq2M6B//8CrhaY6bAAFlzeVd5QoOfgKS
         3QXMMq4hoOi0o6styiQIrKZiNJphMxxqCnXV9qeeEieSw9ZZ4pJHLLNcran11CwxosiR
         XqCh6SO1yVcO+QdE8dqvcSvDuJEt4++vdsGnr2nadPRaT3+h7s1cJmwm9kJftt8Ru4sY
         GkpnxMmqY6RGAmYo54qew+NtVzDsZopsreDPZNhaPlMgiSKnzqwg8DQD43+Fm4TgqrGG
         wwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722348854; x=1722953654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJ1W777DTxzVK3kLsp7gjF2RIvle9V5zMG9vfW7qFnU=;
        b=MuCLEFZVcqWreZsg681v6EjX71k8pAueEtyyvwAr53Zc79nvZo4hgKp55rbz2Tm+Ex
         Si8S7s24wdixLfCjO1o69Nucc4Ol19P66Av71NRuQ45MTLxSNUye88bP75JLn2wPz220
         LznVSMue72UC9wHpSL2RKyRDNGh8ILPkJr11D9n0zqzpDM3Lvl6ole/uEU6TO6IyFHlP
         v4aoKJoKvqXoo/TQzQA0Q6ck3RWAG/zv6YjemKz9qUKSqj6q45qbgLaaCOckOYb80dE3
         uXgQmut0P2mVBszRTA/8a2cHS+dQmCN7PEPukMYpHDV0JpgrZJhuaN4jPGuOZIY1G08R
         NHVA==
X-Forwarded-Encrypted: i=1; AJvYcCWkye/jFvPS445naimDNPNKQREPQtTKPT/ggtKMdqCMU8t69nxhk9TySw96A1F0lPh7IX9kteiwhL7CcJDXH7UH4ZhfF5Pq748MTQrz4EH8eEd7J0hUwHz6nHUvG47ZtGnG5IA5Q3qbMtBNJNl9TfFO4wNlJdB0jmKDlSvh0xH5f6EJ/w==
X-Gm-Message-State: AOJu0YzrVzR0ao5UDDTAyG/PZXwL1zYhTlXMi6mwysZBIfFyZNrKawk/
	Cnj/sWrEhWmmfNLMbeViJPfi1jnqCxDe1QPuM+kLlXTpbOwlfCE/
X-Google-Smtp-Source: AGHT+IFO7/zddJrxhL05A/FDyPSP/TsGQ24jQ/BI1iOoCpZYq54PTgQgTkxVf5nzfrf4I5W1708yHQ==
X-Received: by 2002:a17:902:d2c2:b0:1fd:74ac:e6b6 with SMTP id d9443c01a7336-1ff0482adc3mr135215625ad.24.1722348854263;
        Tue, 30 Jul 2024 07:14:14 -0700 (PDT)
Received: from localhost.localdomain ([115.240.194.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9f43csm102176275ad.257.2024.07.30.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 07:14:13 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: nxp,lpc3220-usb-clk: Convert bindings to dtschema
Date: Tue, 30 Jul 2024 19:43:34 +0530
Message-ID: <20240730141338.46234-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the NXP LPC32xx USB Clock Controller bindings to yaml format.

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../bindings/clock/nxp,lpc3220-usb-clk.txt    | 22 ------------
 .../bindings/clock/nxp,lpc3220-usb-clk.yaml   | 35 +++++++++++++++++++
 2 files changed, 35 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt b/Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt
deleted file mode 100644
index 0aa249409b51..000000000000
--- a/Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-NXP LPC32xx USB Clock Controller
-
-Required properties:
-- compatible: should be "nxp,lpc3220-usb-clk"
-- reg:  should contain clock controller registers location and length
-- #clock-cells: must be 1, the cell holds id of a clock provided by the
-  USB clock controller
-
-Examples:
-
-	usb {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		ranges = <0x0 0x31020000 0x00001000>;
-
-		usbclk: clock-controller@f00 {
-			compatible = "nxp,lpc3220-usb-clk";
-			reg = <0xf00 0x100>;
-			#clock-cells = <1>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.yaml b/Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.yaml
new file mode 100644
index 000000000000..10361d2292fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nxp,lpc3220-usb-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32xx USB Clock Controller
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    const: nxp,lpc3220-usb-clk
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@f00 {
+        compatible = "nxp,lpc3220-usb-clk";
+        reg = <0xf00 0x100>;
+        #clock-cells = <1>;
+    };
-- 
2.45.2


