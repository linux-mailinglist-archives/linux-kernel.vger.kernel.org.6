Return-Path: <linux-kernel+bounces-571726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A1EA6C146
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B75189D324
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A1F22DF97;
	Fri, 21 Mar 2025 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNBkCbi3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975F22DF90;
	Fri, 21 Mar 2025 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577800; cv=none; b=OCDYKav1JtG06W/rSLE2bEaljyd1Cbn4GVv83SmLymBAhMt2Jkk8fQKYUSsCTJ1uimSNtlQnIF2GRszDKgp5+X0DJqhRW1gY2uMQeI/iNf5nC4mjeQ20bC/mSAcoBOvnz9hvsJ6sm+98A1ATKwMT0fiqXMqQwoVdUfb4+Z9nnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577800; c=relaxed/simple;
	bh=LYsuh6h6MKs2bYL6Ik4MtGijuf6qYfmqyUCfFQAT9lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVTOMKuRJsDHNXEhLE6FNAQgaAB6x1xg/l+H1jpQH0ggFtaFKexQCKJcAvgC4kE4Pe6RSYO+prxburKNlqDB64wE5P746xS/ZSOd53jPwNzg37D20J/ntBN6cpCYINOyUVO7v+qhOv6wAldtrtji6kAkTz3wPm00S03XhGaEGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNBkCbi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DF1C4CEE3;
	Fri, 21 Mar 2025 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577799;
	bh=LYsuh6h6MKs2bYL6Ik4MtGijuf6qYfmqyUCfFQAT9lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNBkCbi3rmj8Ik9usR1nN2zbx78AxCtQmNX4OO9jgLDbHiCh+EC/t6bCP/EBtJNdy
	 eUPzkfLirhvtQwXMBYjSrtkyVBAfceRbYQKgSZeQFwB1HFUEKJJtnC0/II2AbW5dCa
	 QczBm3Q1ZRXz8Teb7OnIiNubJfhzk6JXAaIerOFgw7bClmuNtDosO/5pJFav6G42kv
	 tOUk6IGn1Zq6EwkTXnwjqq7jAv4CTyre66CpVwex7cVWu2wn0lnTyJawFeYUUcFUSd
	 MTG7sC7KaTHS0Y/HoA1S+0GAbfdwqcef/q4blZw9gtomSaE+dxeDGp76hSJrQOCBfX
	 7vjakcqG0++JQ==
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/9] dt-bindings: soc: microchip: document the simple-mfd syscon on PolarFire SoC
Date: Fri, 21 Mar 2025 17:22:35 +0000
Message-ID: <20250321-ramrod-scabby-a1869f9979b6@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2845; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=r58KwXBw2VJrPTwLpzODk+nAUK1ZM82ldY4Q5EjMyzY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl3F0RWC4kus/Lk5OxT9V5xK6M8suf/N86WvC4Z/yKTQ z3M3f86SlkYxDgYZMUUWRJv97VIrf/jssO55y3MHFYmkCEMXJwCMJE57xkZHkkuLbRale6ffXff xBQhN9180Z3e74OyX4pYHDVo2ruxkeG/Z5lF6d2FiXe2/7R7wjhHSjsu/unntSeMNJluOuw8/Xc 6KwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

"mss-top-sysreg" contains clocks, pinctrl, resets, an interrupt controller
and more. At this point, only the reset controller child is described as
that's all that is described by the existing bindings.
The clock controller already has a dedicated node, and will retain it as
there are other clock regions, so like the mailbox, a compatible-based
lookup of the syscon is sufficient to keep the clock driver working as
before, so no child is needed. There's also an interrupt multiplexing
service provided by this syscon, for which there is work in progress at
[1].

Link: https://lore.kernel.org/linux-gpio/20240723-uncouple-enforcer-7c48e4a4fefe@wendy/ [1]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2:
- clean up various minor comments from Rob on mpfs-mss-top-sysreg
- remove mpfs-control-scb from this patch
---
 .../microchip,mpfs-mss-top-sysreg.yaml        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml

diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
new file mode 100644
index 000000000000..4794e4c6fc1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PolarFire SoC Microprocessor Subsystem (MSS) sysreg register region
+
+maintainers:
+  - Conor Dooley <conor.dooley@microchip.com>
+
+description:
+  An wide assortment of registers that control elements of the MSS on PolarFire
+  SoC, including pinmuxing, resets and clocks among others.
+
+properties:
+  compatible:
+    items:
+      - const: microchip,mpfs-mss-top-sysreg
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    description:
+      The AHB/AXI peripherals on the PolarFire SoC have reset support, so
+      from CLK_ENVM to CLK_CFM. The reset consumer should specify the
+      desired peripheral via the clock ID in its "resets" phandle cell.
+      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list
+      of PolarFire clock/reset IDs.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@20002000 {
+      compatible = "microchip,mpfs-mss-top-sysreg", "syscon", "simple-mfd";
+      reg = <0x20002000 0x1000>;
+      #reset-cells = <1>;
+    };
+
-- 
2.45.2


