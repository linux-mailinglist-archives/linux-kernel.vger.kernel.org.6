Return-Path: <linux-kernel+bounces-181871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4893E8C82A0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F80B2181D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53FC8C11;
	Fri, 17 May 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZv+grV+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF41DDC9;
	Fri, 17 May 2024 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935019; cv=none; b=qRVnpeTUiXeGwzM84bSNsTXiT5Z7Fbs917Y3B9Rg8ha7FtMwRzk4tA3/xIS5gj49S7GhX8RmX5+fmhsdN8pXOyOrf+bqEdROW7gNBJMb1gs06EM+K7Igh7x+pABIWNvqz8ZRZVff5Mb7poYz30HNdL0ezU94RhjnunEqgRsgFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935019; c=relaxed/simple;
	bh=/jxaQ8vLqvY8UNZjqUOZ0SnrmjfJMgE4oN2iNYTKwWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dw0y570jXOTee8FWSmqir4fBtz1APQtdCLo+2M1opJ4FLMMmCO/sqT1O0mmsYsqE4ZA1B82eXvVEpxDdO6lCRfxSe2t2B700wnYxRBsvXwzyHLd8fwTnGpMSJZTJiSr3NMerdvT1WL9J/CujPNXQ0Ot70B+lcdhmV4Ctfu7i1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZv+grV+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f4178aec15so1045457b3a.0;
        Fri, 17 May 2024 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715935016; x=1716539816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMzhjD0vszw7czUjF6cG9OPyULjgr/IpXRMnsfCQ3do=;
        b=eZv+grV+ap3KPKy5mmmYm/8WcKOLy8IhM97APEE7YLGlcRqctU6PtMUKYezBWGmNIa
         2hPyM55OyHkwJpqtvfHMZqeKJmcIoDpGfJwX/iWAFbWdinWo/1bAdT4N6OkuVzwcpNF+
         Fwe8xrHm08mH98gL23NCJup2xj+LNf2B0crqCJ7GPLQxWJGtZpDfuxT6Wpzi90VoOuvL
         TwtOrj7UOo7h0gBk5zbnb21VH2A1OBC2qhgzHOgWEo9JqhoEbnS/rUXQ26+18sErO7FD
         tdz+WZOP138YEEF33mFaNYTwZHq5pDwmJsVwi95h7B0v/vjuCYnBbNJzFN2Ndju4j2cY
         GVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715935016; x=1716539816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMzhjD0vszw7czUjF6cG9OPyULjgr/IpXRMnsfCQ3do=;
        b=E9OS9gqqLwCayOxxIYf1mMgUa9gnAMwqir3fyahLnR+clgxiHoj+PDboZIAt9T3xm9
         TIj+EKAfbsZnAn4fx2JXgiZGlU3H1XBCoiNwMk/jOStW4P6yNakrxh5nMseUqUCHP/Xz
         XrZJAe6q/ZciD9bUcDZUKk65DuE7JNRQMqHYTkOo+jNG2qsvYk/aV/bkD3WzN46gowRq
         bwqLwhilKjF4vtc/78AERS9eAmHKyzxPxAdbi5rzFaZdubdd6ogzqMG90M6wM82jDcTG
         hLFsF4ZoLVjDNWr6UE5+FPyWfFDgsXcioi+sAXos/raazlGuLWkmIiEzm9nLVz/9Jo9o
         h8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU/fsb5g7NYQuOOd5PaquGBWdwCCLhzOB1sZ1VzivjivSFzZqcDHOqPOTEwvaiTnPP8ucz1lclSltcmoGSQygwUEgbQQaMMI3B4bPPLzskF+DqXnctVlPW6umTlM26T4VQsitmS2U+8YoExz2FY77poc87Gi9yBeq/CYGj6xdYyvuY0z8cF
X-Gm-Message-State: AOJu0YyBwg+JOxibvVb6jK8Xtl4WoeboBvGzxC0UameTURbgosfmdlYW
	xF5mot4ZZG2odmOqkA0pWxpgHVgsTwZY2a9Y3Q5wtVT1KyrxUNYy
X-Google-Smtp-Source: AGHT+IFpjSBvT/CF+oyFxdYCYRHFBWlKSN7PvOdZrINbkRp3zvEQ4SUctsA1n/96IQp2lStiw8clfw==
X-Received: by 2002:a05:6a20:1581:b0:1af:cb7c:cc98 with SMTP id adf61e73a8af0-1afde1fb700mr23111165637.55.1715935016404;
        Fri, 17 May 2024 01:36:56 -0700 (PDT)
Received: from localhost.localdomain ([45.64.12.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c035dc3sm151234005ad.197.2024.05.17.01.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 01:36:55 -0700 (PDT)
From: Mighty <bavishimithil@gmail.com>
To: 
Cc: Mithil Bavishi <bavishimithil@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lopez Cruz <misael.lopez@ti.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
Date: Fri, 17 May 2024 14:06:44 +0530
Message-Id: <20240517083644.3920-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mithil Bavishi <bavishimithil@gmail.com>

Convert the OMAP4+ McPDM bindings to DT schema.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
Changelog v4:
- Changed maintainer name
- Use $ref and enum in ti-hwmods property
- Make clocks property only have maxItems, no description
- Add items to clock-names
- Fix address of node in example
- Remove extra line

 .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
 .../bindings/sound/ti,omap4-mcpdm.yaml        | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 30 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
deleted file mode 100644
index ff98a0cb5..000000000
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Texas Instruments OMAP4+ McPDM
-
-Required properties:
-- compatible: "ti,omap4-mcpdm"
-- reg: Register location and size as an array:
-       <MPU access base address, size>,
-       <L3 interconnect address, size>;
-- interrupts: Interrupt number for McPDM
-- ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"
-
-Example:
-
-mcpdm: mcpdm@40132000 {
-	compatible = "ti,omap4-mcpdm";
-	reg = <0x40132000 0x7f>, /* MPU private access */
-	      <0x49032000 0x7f>; /* L3 Interconnect */
-	interrupts = <0 112 0x4>;
-	interrupt-parent = <&gic>;
-	ti,hwmods = "mcpdm";
-};
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-	clocks = <&twl6040>;
-	clock-names = "pdmclk";
-	status = "okay";
-};
diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
new file mode 100644
index 000000000..23e0e9567
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP McPDM
+
+maintainers:
+  - Misael Lopez Cruz <misael.lopez@ti.com>
+
+description:
+  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
+
+properties:
+  compatible:
+    const: ti,omap4-mcpdm
+
+  reg:
+    items:
+      - description: MPU access base address
+      - description: L3 interconnect address
+
+  interrupts:
+    maxItems: 1
+
+  ti,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [mcpdm]
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pdmclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,hwmods
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pdm@40132000 {
+      compatible = "ti,omap4-mcpdm";
+      reg = <0x40132000 0x7f>, /* MPU private access */
+            <0x49032000 0x7f>; /* L3 Interconnect */
+      interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-parent = <&gic>;
+      ti,hwmods = "mcpdm";
+      clocks = <&twl6040>;
+      clock-names = "pdmclk";
+    };
-- 
2.34.1


