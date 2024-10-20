Return-Path: <linux-kernel+bounces-373402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599B9A564E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0881F223A5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8819B59C;
	Sun, 20 Oct 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/V9JJuR"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C2319AA75;
	Sun, 20 Oct 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453252; cv=none; b=FngoKVeE2wXbHHpm3BiMSA0+I1WRD+BH8e1OgAj8pPfxmXnU9hkZC0oOsjEBWtVfD4WPgvbl4HD4lswhN4w9WgxiQJ3Vaw8irT63dbcsYt9o/XHzQHUVpHf+Q4ynze2g5XctEMtDSusyKt+b1uE6jV8fdwwriVcNs4F3cdUGyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453252; c=relaxed/simple;
	bh=LxKeuuubBdeyS7smSFyKjfRR58SVpqZBgKhy2eKoKkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJyGRdnf3gEVliESlOsrsnbuk4gm1rFTZmwwbrL/e187EaUKVTc4QYoropEUA3sZCI6ozJuaN+ePt3fO9mcEn0smkXMiZ7GQTS2oKuj3L9gWZhX+uYcN/nwblQ9vyGKslxskxfBpMbnN6XIZ9pZ9D1b/ZQpd6nPikPRbyGOmO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/V9JJuR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c940512711so703412a12.1;
        Sun, 20 Oct 2024 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453248; x=1730058048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfSYuXKOV63fz8fGkqZMMmJTLZOt2OeBpdkhvHCPQZA=;
        b=J/V9JJuRTHhLazfOxInBeyXbwRiDKZzKWOb1vCjZ8/j5FW4mS/QX5CMsins3LKfrUG
         DKtYwaZaAM/VfRemUxMu7mnPjL4loWPb6S8SZI6kDgTRLr6tiE5HeH5msb+N94wt6sVq
         mi/M82uPJnpW9PgaU1zDBnD42UrEnp64CTS2REnTU+vOFhVy86HbGJN07iR1Y7kyLSjC
         dXuG+KYJXLDx8K6fizf/5GWle902C7a3+9Ru9TbDp6I57FVR9FREMmpYc2+CQ71OWPbW
         bA9e5rZ53IWneaUHEWxI0A9Jm70Ti+mUTVBLhyXFNc67WR7FmIhSjb4hNxH/MHlbgJYN
         asag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453248; x=1730058048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfSYuXKOV63fz8fGkqZMMmJTLZOt2OeBpdkhvHCPQZA=;
        b=AABTbs0mXfVN1QjeEsY1XX69TlRYy0e1Fe/xf9yfKOdpMHW3Tl9Ly0zoCDpo3HjSqt
         UA8TxUMLKXiGXMPXuBexiV/jpvrzUt2dTYyI1qJ6qCvDbB8ifyeTpnACuOB+43lnfvqF
         CKTv0RgX/pGG858Q/BEc0ziyB3rB7CB8MUAFrnaqoGoVb+MYv9J1VDz08t/aFkTIVxTV
         svLc7BpTPf4tJ35vosT5PmiiwNtojuL1yQEQ2ndQXDMtIKqOf8lRR1PT7GlEouDKDyFl
         YClEEqC/lWwMYhi3ScD4owWENutzt7h7izFpvR312EJ9NfX+Q3PtN67h4r7FXHNCXFG4
         1rbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX0/ORot6TJd9kV38SwHCmdgCVab3FDN1hnhvTBr0pCVh3XadTgBlrdB9s0ZuerndON7AsIAlulylfntEo@vger.kernel.org, AJvYcCXcHePl43sPtUBVGKtd3mGrhgK3qSrKcmH9qQjbGHdmy3UhwMm9Yx3PRIgkgwniPe6VAast/S4QQhJb@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUdZ8EclxhCXfXrL7jvwv8tMEUpQQ5cviSvyOTc929AslSKek
	2e/JMEtmjKMln3+xIl96RrDK71rSyk44xnwRAgSafOvl99oWyJSv
X-Google-Smtp-Source: AGHT+IF4md087S5ok8j/uZls2JeEHQpY1kiuzvt0B4nM4HR296L11vSNyHyTVyvX9HNfwkkAUjFhdg==
X-Received: by 2002:a17:907:e91:b0:a99:8642:4f41 with SMTP id a640c23a62f3a-a9a69ca3744mr403961866b.14.1729453248216;
        Sun, 20 Oct 2024 12:40:48 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:47 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 12/23] ARM: socfpga: dts: add a10 clock binding yaml
Date: Sun, 20 Oct 2024 19:40:17 +0000
Message-Id: <20241020194028.2272371-13-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert content of the altera socfpga.txt to match clock bindings for
the Arria10 SoC devicetrees. Currently all altr,* bindings appear as
error at dtbs_check, since these bindings are only written in .txt
format.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../bindings/clock/altr,socfpga-a10.yaml      | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml

diff --git a/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
new file mode 100644
index 000000000..795826f53
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/altr,socfpga-a10.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Device Tree Clock bindings for Altera's SoCFPGA platform
+
+maintainers:
+  - TODO
+
+description:
+  This binding uses the common clock binding[1].
+
+  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+properties:
+  compatible:
+    description: |
+      shall be one of the following
+        - "altr,socfpga-a10-pll-clock" - for a PLL clock
+        - "altr,socfpga-a10-perip-clk" - The peripheral clock divided from the
+            PLL clock.
+        - "altr,socfpga-a10-gate-clk" - Clocks that directly feed peripherals
+            and can get gated.
+    enum:
+      - altr,socfpga-a10-pll-clock
+      - altr,socfpga-a10-perip-clk
+      - altr,socfpga-a10-gate-clk
+
+  reg:
+    description: |
+      shall be the control register offset from CLOCK_MANAGER's base for the
+      clock.
+    maxItems: 1
+
+  clocks:
+    description: |
+      shall be the input parent clock phandle for the clock. This is either an
+      oscillator or a pll output.
+    minItems: 1
+    maxItems: 5
+
+  '#clock-cells':
+    description: from common clock binding, shall be set to 0.
+    maxItems: 1
+
+  fixed-divider:
+    description: if clocks have a fixed divider value, use this property.
+    minimum: 1
+    maximum: 16
+
+  clk-gate:
+    description: |
+      for "socfpga-a10-gate-clk", clk-gate contains the gating register and the
+      bit index.
+    minItems: 2
+
+  div-reg:
+    description: |
+      for "socfpga-a10-gate-clk" and "socfpga-a10-periph-clk", div-reg contains
+      the divider register, bit shift, and width.
+    minItems: 3
+    maxItems: 3
+
+  clk-phase:
+    description: |
+      for the sdmmc_clk, contains the value of the clock phase that controls
+      the SDMMC CIU clock. The first value is the clk_sample(smpsel), and the
+      second value is the cclk_in_drv(drvsel). The clk-phase is used to enable
+      the correct hold/delay times that is needed for the SD/MMC CIU clock. The
+      values of both can be 0-315 degrees, in 45 degree increments.
+    minItems: 1
+
+required:
+  - compatible
+  - clocks
+  - '#clock-cells'
+
+oneOf:
+  - items:
+      - required:
+          - reg
+      - required:
+          - div-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    main_pll: main_pll@40 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #clock-cells = <0>;
+      compatible = "altr,socfpga-a10-pll-clock";
+      clocks = <&osc1>, <&cb_intosc_ls_clk>,
+           <&f2s_free_clk>;
+      reg = <0x40>;
+
+      main_noc_base_clk: main_noc_base_clk {
+        compatible = "altr,socfpga-a10-perip-clk";
+        div-reg = <0x140 16 11>;
+        clocks = <&periph_pll>;
+        #clock-cells = <0>;
+      };
+    };
+...
-- 
2.25.1


