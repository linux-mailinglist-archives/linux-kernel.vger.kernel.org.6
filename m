Return-Path: <linux-kernel+bounces-447027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2689F2C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442DE18833FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77034201004;
	Mon, 16 Dec 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hHDxLc3K"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546541FFC75
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338927; cv=none; b=jX6yB9FoayMJjvwiV3oWvC4xJnY2mHBy5eh66mOyNefBIt8gsIEIZ1kfrgMeiFYElrWCMh5Pfks60GLz8qAxpLRCMqZ5s1L5cagxuxoe1FZG0t8HABB96aQPOvSQ2oDVKTJsL4tAyJbNOmRomMD3nJNMYfeaBINk9uH+NSnIWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338927; c=relaxed/simple;
	bh=UFSwrNE2q4CqRGWxwYODrUgIrnNHkVW1oXV1BV8c6Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHoDpp5v7dowPJW2MllqJw0oA+jDl0lQ8s7ShXe3sV/X42vgbjUzn8DD6pMeV3GuagZqAgd3SeGVY5Wsw00aAl+EY5vJ0XlGul/2fu4oCCbmWKASbYTmInQneTdJAAZwZv7MYz0ehpY3wGTEaRyQjyjJf56WunUPzPlcoFLEfDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hHDxLc3K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166022c5caso28702695ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734338925; x=1734943725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMO3jfuL5hmIGaCvebBRAsGTgzlAeW19tcp/lCnmhhM=;
        b=hHDxLc3KJQJPyca+DNT99fHqutuVgvb/GfTlCnDE+DDKHJnkAGsXwk3sxVo7zM/Qsp
         p0onINnIBXGGC8rhoG+/PIVh4zEQYPDJdKddM+KF13vRyJXk2pNAPpoA9zoJdxrOjSV7
         hrOMwCLpUTa3Z7JL1xs+yLhM98yfNsuG8z5cw/Ijbh8lGOEN/UwaVrdhvsqfIoXdDJJz
         3/itGEMDTHBAuujZP1opx5ytE+B7DQ2OhqkN0los2FZiG1uuNiOeIgVNVmPn678JA1C5
         xhYSl9Hq5xBJG2nNvkKEo98S5gnB//gVH4IRY6A8YILVBrDgi6k1raE8Uky8WxUPEASW
         IG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338925; x=1734943725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMO3jfuL5hmIGaCvebBRAsGTgzlAeW19tcp/lCnmhhM=;
        b=VBKy2UEhVvpRDxmNBQmi+JvnAOhRj5sRndhHwtJGQjgi2beTugvegV9xyvjIuEkaAi
         Z55r3KDNSUrZqNSHYdmJNzjJK88oBN2zSU5zsYIJxnmmFSC3mmOGBNvYgb0c+yyTbgnE
         7jLurSwbsQ/wl49RHSMijXPDc9fU0+uiSIK1ot+Q8t/F5wGpXgtIJMxmxEIB7S+YjS+O
         zZyjEDc18kir2KwWo35OUI4UFF9X7T3mJsO6/flHM1gIzYhQDl8k440kOVNupODVulHK
         EUTN8KT3jRqIceExK8nXaBTGg0MTLqH+5ksZZPMqfYLqGROoRQlS6gpJXASqaNfRZzf1
         aFfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcVD9JqFSTEqBZD7JwGLS+zqC9OdlFAuKRJLkZH3kk0ZLBQkN3JZtpxtp8Z39KM7S2jE9pi5sC0l0xJ3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGxY3yYAebu16FS3bqqMHZzKW22ax2vKlurqanBRuCWmzllVw
	hyWmCZSrJIyui7CskcKvCVntzFFQ/ysHL+JWd/K+pIDeOI1k4ubTErIwPeQp/3A=
X-Gm-Gg: ASbGncvzxn9HzIkHOk41Jx0W2dppIsGUKPx6el5XFFe1iBJhuJTgFIBERJKaRy1c/d/
	GKYJI6tcrhcZS0Y92pm28mGBTfh7WIqXWIqwS4Sa313dnL6Fi2TtQI9f5HO41XW+ZFKjk3LIoBD
	eMJ98o9im5Ox2+SqjxEVhy83s9rWO27nW1+0GAEqPVPc2tj64W3BReYgIixfubyV/UI3JZz6ssY
	7lcwA0Z8/Vax4OrFFBVB04E1mJim5Q+oLOjisW+bPJ+hvq6+C501zUZudXuTY8Nkx1wK4scALCr
	JzSrCe0O9o9y0OA=
X-Google-Smtp-Source: AGHT+IFP0telDvRf+8kDLe8zYK7tj9L0Ym2laW4HDpkbeQU6flKJQAmEPGbnSvej/CfGRJih0n5Yog==
X-Received: by 2002:a17:902:d48b:b0:216:60a5:ebfd with SMTP id d9443c01a7336-21892a8483fmr144631265ad.55.1734338925436;
        Mon, 16 Dec 2024 00:48:45 -0800 (PST)
Received: from localhost.localdomain ([223.185.130.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e501d0sm37711495ad.116.2024.12.16.00.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:48:44 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [RFC PATCH 2/8] dt-bindings: mailbox: Add bindings for RPMI shared memory transport
Date: Mon, 16 Dec 2024 14:18:11 +0530
Message-ID: <20241216084817.373131-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216084817.373131-1-apatel@ventanamicro.com>
References: <20241216084817.373131-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the common RISC-V Platform Management
Interface (RPMI) shared memory transport as a mailbox controller.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../mailbox/riscv,rpmi-shmem-mbox.yaml        | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml b/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
new file mode 100644
index 000000000000..8d713ba7ffc7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Platform Management Interface (RPMI) shared memory mailbox
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a common shared
+  memory based RPMI transport. This RPMI shared memory transport integrates as
+  mailbox controller in the SBI implementation or supervisor software whereas
+  each RPMI service group is mailbox client in the SBI implementation and
+  supervisor software.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+properties:
+  compatible:
+    const: riscv,rpmi-shmem-mbox
+
+  reg:
+    oneOf:
+      - items:
+        - description: A2P request queue base address
+        - description: P2A acknowledgment queue base address
+        - description: P2A request queue base address
+        - description: A2P acknowledgment queue base address
+        - description: A2P doorbell address
+      - items:
+        - description: A2P request queue base address
+        - description: P2A acknowledgment queue base address
+        - description: A2P doorbell address
+
+  reg-names:
+    oneOf:
+      - items:
+        - const: a2p-req
+        - const: p2a-ack
+        - const: p2a-req
+        - const: a2p-ack
+        - const: db-reg
+      - items:
+        - const: a2p-req
+        - const: p2a-ack
+        - const: db-reg
+
+  interrupts:
+    minItems: 1
+    maxItems: 1
+    description:
+      The RPMI shared memory transport supports wired interrupt specified by
+      this property as the P2A doorbell.
+
+  msi-parent:
+    description:
+      The RPMI shared memory transport supports MSI as P2A doorbell and this
+      property specifies the target MSI controller.
+
+  riscv,slot-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 64
+    description:
+      Power-of-2 RPMI slot size of the RPMI shared memory transport.
+
+  riscv,db-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Update only the register bits of doorbell defined by the mask (32 bit).
+      If this property is not present then mask is assumed to be 0xffffffff.
+
+  riscv,db-value:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Value written to the doorbell register bits (32-bit access) specified
+      by the riscv,db-mask property. If this property is not present then
+      value is assumed to be 0x1.
+
+  "#mbox-cells":
+    const: 1
+    description:
+      The first cell specifies RPMI service group ID.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - riscv,slot-size
+  - "#mbox-cells"
+
+anyOf:
+  - required:
+      - interrupts
+  - required:
+      - msi-parent
+
+additionalProperties: false
+
+examples:
+  - |
+    // Example 1 (RPMI shared memory with only 2 queues):
+    mailbox@10080000 {
+        compatible = "riscv,rpmi-shmem-mbox";
+        reg = <0x00 0x10080000 0x00 0x10000>,
+              <0x00 0x10090000 0x00 0x10000>,
+              <0x00 0x100a0000 0x00 0x4>;
+        reg-names = "a2p-req", "p2a-ack", "db-reg";
+        msi-parent = <&imsic_mlevel>;
+        riscv,slot-size = <64>;
+        #mbox-cells = <1>;
+    };
+  - |
+    // Example 2 (RPMI shared memory with only 4 queues):
+    mailbox@10001000 {
+        compatible = "riscv,rpmi-shmem-mbox";
+        reg = <0x00 0x10001000 0x00 0x800>,
+              <0x00 0x10001800 0x00 0x800>,
+              <0x00 0x10002000 0x00 0x800>,
+              <0x00 0x10002800 0x00 0x800>,
+              <0x00 0x10003000 0x00 0x4>;
+        reg-names = "a2p-req", "p2a-ack", "db-reg";
+        msi-parent = <&imsic_mlevel>;
+        riscv,slot-size = <64>;
+        riscv,db-mask = <0x00008000>;
+        riscv,db-value = <0x00008000>;
+        #mbox-cells = <1>;
+    };
-- 
2.43.0


