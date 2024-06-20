Return-Path: <linux-kernel+bounces-221932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1E90FAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9226B21E60
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD83CC2FC;
	Thu, 20 Jun 2024 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdoQK9oW"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A375B66F;
	Thu, 20 Jun 2024 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718845573; cv=none; b=nW0Vuxo74QAkHrULLER8LDa8OkDlcYlu2xH3hQzrqGpLvJolS1qoQRoKvpeTVxMkHrVUxiMV9VckKhFL1Eoz2dzgvpGUwImS6S4bXPI5hHv84HRXItYBZTdoet1f4fQkPf5ifXeOLDTpxo7tnbdXLRrg+lxjua1Nk+gYhK+jdpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718845573; c=relaxed/simple;
	bh=XWYx27UmafWuFbWiTtsE4igQ4zUHPxoYRnZ6WZ8yrE0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pVXVb/2LrOrTW2OF5KNaeSIELY7muZ0chkAjey2AYTIUo0Yute4GbRqWTMNWWdKNa8qkWZh5IfskxOYh8MNmfpWk9zY3m05qDJDRHAz7lNBW/zcAU5uvosVRBStmnwp8iL8bDntPdP4iShNku0H58HoOJugt4CDpr2+/BMujZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdoQK9oW; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-795a4fde8bfso26625685a.2;
        Wed, 19 Jun 2024 18:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718845569; x=1719450369; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wpPiYeL2EwFNXkIhI80dJKwE6Zivlyp3bhXMwUhM+k=;
        b=bdoQK9oWxLIZUOshMY/pQfvzot/HIXi81IHTTNja9wKKIZWcBxxZAIb3Y05wkE686p
         Y5bZzuBbthM+3DAbmCPV9eUKncsgV+mymBD2SJ7nIdT6g4jO/GiBXAoV6bCRLxyCOYlu
         3UTNzF+TOr4x0ANpkuVMnTgyt2v15oMt0gcUD/YEJvOp73scDae4ddNUZW61NHiOIN+j
         ULaE/rF2lnA94iq76VUh6Ylw1ZwUS9QymPRyKdSknVz43tBW54Jm/8lSTeL9baho7shi
         kGO/+vLB878Gogz0WRdN/c6zOnnGZMb736O5P0TJTuwQyi983vzvlQRmxr1FJvpWO9M1
         tc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718845569; x=1719450369;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wpPiYeL2EwFNXkIhI80dJKwE6Zivlyp3bhXMwUhM+k=;
        b=RWFJWiGFD0lbhxkbiD5n98O8X/HKboZhZYgvS2Z+8ANn7HJWTy6uyVy/JtCggQXVLQ
         qC868dZ9sqs38CuhS7NX1cMcKGzvDTW7FGQevACqHYVzuPDodrZ9Q35OYU35oqaD9IfY
         94BxK/p0yKH5Rk9CkK4wg5/dTBe4BdoNBtTUbNBsF+2R+rq0GGbHN4whNs3DW+Sq6c++
         oInuQphOrZ0FD3ESYGaDrPQhybxDewnFoyDbDrHy2dzXxZ99r3ycLVi8414BqUkNn3mV
         +UnOuGrUaCoELB6koj6zmMsJkSyITCHFnrI72hYJ0SF4vbyknYzKYLfmumEysNoV1nGo
         bAcA==
X-Forwarded-Encrypted: i=1; AJvYcCVhpKZOwuaksHgkqDxM13iWtZZmd/PUIzA7OoZwmVayuk32RAsCBLOWB/+4caHH3AniwlPDZpRnrDLUm+FEQaOn//d55DhNmrjOL3AkyxBnc+pUy+uMfFaoS/JE4buExAF4zpXDce6ztQ==
X-Gm-Message-State: AOJu0Yy3+EtAkE1rhuD7cFZyEw2no19FWajM5cN0VG8I54mzjJ12Bzmh
	TWERgMv0nWezFux1Hh5/7yFHZ9UlMPCVdbho0nzGx3xZOwU54EwVS8iwFw==
X-Google-Smtp-Source: AGHT+IHxmI07umFiT7bdwV+BcXkVbeoc1xnI//JAyoBo+kUk0173ojfx7oRmFR4MUPRZhhFv9LGQ+A==
X-Received: by 2002:a05:620a:2552:b0:79a:2613:9b40 with SMTP id af79cd13be357-79bb3ebe6c9mr461671185a.50.1718845569459;
        Wed, 19 Jun 2024 18:06:09 -0700 (PDT)
Received: from laptop (drmons0560w-142-163-86-219.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.163.86.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798ab5b6df9sm649571685a.67.2024.06.19.18.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 18:06:08 -0700 (PDT)
Date: Wed, 19 Jun 2024 22:06:08 -0300
From: Mark Watson <markus.c.watson@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: misc: axi-fifo: Add binding for AXI-Stream FIFO
Message-ID: <ZnOAgM+zacF6u1x7@laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This resolves a checkpatch warning in drivers/staging/axis-fifo
regarding a missing devie-tree binding. The full warning is included
below.

WARNING: DT compatible string "xlnx,axi-fifo-mm-s-4.1" appears
un-documented -- check ./Documentation/devicetree/bindings/
+       { .compatible = "xlnx,axi-fifo-mm-s-4.1", },

Signed-off-by: Mark Watson <markus.c.watson@gmail.com>
---
 .../bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml b/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml
new file mode 100644
index 000000000000..cfb335752054
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml
@@ -0,0 +1,214 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,axi-fifo-mm-s-4.1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx AXI-Stream FIFO v4.1 IP core
+
+description: |
+  The Xilinx AXI-Stream FIFO v4.1 IP core has read and write AXI-Stream FIFOs,
+  the contents of which can be accessed from the AXI4 memory-mapped interface.
+  This is useful for transferring data from a processor into the FPGA fabric.
+  The driver creates a character device that can be read/written to with
+  standard open/read/write/close operations.
+
+  See Xilinx PG080 document for IP details.
+
+  Currently supports only store-forward mode with a 32-bit AXI4-Lite
+  interface.
+
+  DOES NOT support:
+    - cut-through mode
+    - AXI4 (non-lite)
+
+properties:
+  compatible:
+    const: xlnx,axi-fifo-mm-s-4.1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: interrupt
+
+  interrupt-parent:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  xlnx,axi-str-rxd-protocol:
+    const: XIL_AXI_STREAM_ETH_DATA
+
+  xlnx,axi-str-rxd-tdata-width:
+    const: 0x20
+
+  xlnx,axi-str-txc-protocol:
+    const: XIL_AXI_STREAM_ETH_CTRL
+
+  xlnx,axi-str-txc-tdata-width:
+    const: 0x20
+
+  xlnx,axi-str-txd-protocol:
+    const: XIL_AXI_STREAM_ETH_DATA
+
+  xlnx,axi-str-txd-tdata-width:
+    const: 0x20
+
+  xlnx,axis-tdest-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,axis-tid-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,axis-tuser-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,data-interface-type:
+    const: 0x0
+
+  xlnx,has-axis-tdest:
+    const: 0x0
+
+  xlnx,has-axis-tid:
+    const: 0x0
+
+  xlnx,has-axis-tkeep:
+    const: 0x1
+
+  xlnx,has-axis-tstrb:
+    const: 0x0
+
+  xlnx,has-axis-tuser:
+    const: 0x0
+
+  xlnx,rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,rx-fifo-pe-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,rx-fifo-pf-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,s-axi-id-width:
+    const: 0x4
+
+  xlnx,s-axi4-data-width:
+    const: 0x20
+
+  xlnx,select-xpm:
+    const: 0x0
+
+  xlnx,tx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,tx-fifo-pe-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,tx-fifo-pf-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,use-rx-cut-through:
+    const: 0x0
+
+  xlnx,use-rx-data:
+    const: 0x1
+
+  xlnx,use-tx-ctrl:
+    const: 0x0
+
+  xlnx,use-tx-cut-through:
+    const: 0x0
+
+  xlnx,use-tx-data:
+    const: 0x1
+
+  xlnx,tx-max-pkt-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,rx-min-pkt-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - interrupt-parent
+  - xlnx,axi-str-rxd-protocol
+  - xlnx,axi-str-rxd-tdata-width
+  - xlnx,axi-str-txc-protocol
+  - xlnx,axi-str-txc-tdata-width
+  - xlnx,axi-str-txd-protocol
+  - xlnx,axi-str-txd-tdata-width
+  - xlnx,axis-tdest-width
+  - xlnx,axis-tid-width
+  - xlnx,axis-tuser-width
+  - xlnx,data-interface-type
+  - xlnx,has-axis-tdest
+  - xlnx,has-axis-tid
+  - xlnx,has-axis-tkeep
+  - xlnx,has-axis-tstrb
+  - xlnx,has-axis-tuser
+  - xlnx,rx-fifo-depth
+  - xlnx,rx-fifo-pe-threshold
+  - xlnx,rx-fifo-pf-threshold
+  - xlnx,s-axi-id-width
+  - xlnx,s-axi4-data-width
+  - xlnx,select-xpm
+  - xlnx,tx-fifo-depth
+  - xlnx,tx-fifo-pe-threshold
+  - xlnx,tx-fifo-pf-threshold
+  - xlnx,use-rx-cut-through
+  - xlnx,use-rx-data
+  - xlnx,use-tx-ctrl
+  - xlnx,use-tx-cut-through
+  - xlnx,use-tx-data
+  - xlnx,tx-max-pkt-size
+  - xlnx,rx-min-pkt-size
+
+additionalProperties: false
+
+examples:
+  - |
+    axi_fifo_mm_s_0: axi_fifo_mm_s@43c00000 {
+      compatible = "xlnx,axi-fifo-mm-s-4.1";
+      interrupt-names = "interrupt";
+      interrupt-parent = <&intc>;
+      interrupts = <0 29 4>;
+      reg = <0x43c00000 0x10000>;
+      xlnx,axi-str-rxd-protocol = "XIL_AXI_STREAM_ETH_DATA";
+      xlnx,axi-str-rxd-tdata-width = <0x20>;
+      xlnx,axi-str-txc-protocol = "XIL_AXI_STREAM_ETH_CTRL";
+      xlnx,axi-str-txc-tdata-width = <0x20>;
+      xlnx,axi-str-txd-protocol = "XIL_AXI_STREAM_ETH_DATA";
+      xlnx,axi-str-txd-tdata-width = <0x20>;
+      xlnx,axis-tdest-width = <0x4>;
+      xlnx,axis-tid-width = <0x4>;
+      xlnx,axis-tuser-width = <0x4>;
+      xlnx,data-interface-type = <0x0>;
+      xlnx,has-axis-tdest = <0x0>;
+      xlnx,has-axis-tid = <0x0>;
+      xlnx,has-axis-tkeep = <0x1>;
+      xlnx,has-axis-tstrb = <0x0>;
+      xlnx,has-axis-tuser = <0x0>;
+      xlnx,rx-fifo-depth = <0x200>;
+      xlnx,rx-fifo-pe-threshold = <0x2>;
+      xlnx,rx-fifo-pf-threshold = <0x1fb>;
+      xlnx,s-axi-id-width = <0x4>;
+      xlnx,s-axi4-data-width = <0x20>;
+      xlnx,select-xpm = <0x0>;
+      xlnx,tx-fifo-depth = <0x8000>;
+      xlnx,tx-fifo-pe-threshold = <0x200>;
+      xlnx,tx-fifo-pf-threshold = <0x7ffb>;
+      xlnx,use-rx-cut-through = <0x0>;
+      xlnx,use-rx-data = <0x0>;
+      xlnx,use-tx-ctrl = <0x0>;
+      xlnx,use-tx-cut-through = <0x0>;
+      xlnx,use-tx-data = <0x1>;
+      xlnx,tx-max-pkt-size = <257>;
+      xlnx,rx-min-pkt-size = <255>;
+    };
-- 
2.34.1


