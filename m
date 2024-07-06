Return-Path: <linux-kernel+bounces-243359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E75929527
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 21:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F1AB219D2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BCF13B798;
	Sat,  6 Jul 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4f0/e3e"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50BE57D;
	Sat,  6 Jul 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720295752; cv=none; b=cSmMI5WyWGIJIzdo/JWlRgLR5ECess/O+2DBKqnYuOG44ILFN44IB2jtCIC3R1rbTCbcHrI70yKNfKi8nvbOhpDXcCxspvdH1AKnc/tqFHnieRtnWrVa9MAoWPz8y9DsjDZgSt2D46iozyee+SvwLwWvvk8hwP4Fjp02nSFoi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720295752; c=relaxed/simple;
	bh=XWYx27UmafWuFbWiTtsE4igQ4zUHPxoYRnZ6WZ8yrE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A0wVNaaA2Sl9hj8U56W5vcgEpnCZ0jdd8vLq0hClZS024qiKTXfxdcutUYvU9XM92Z91bYXDCtyGO9GngAi2WLwpvMaucLU7W6IG1XJTHFUhznTLgeWtZMQmdIEf/emDTN1G0lOTL/otIQ5ZQGk1jDSI0rFenn1cY4sNyVuvKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4f0/e3e; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447e02f3ac9so4410451cf.0;
        Sat, 06 Jul 2024 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720295748; x=1720900548; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wpPiYeL2EwFNXkIhI80dJKwE6Zivlyp3bhXMwUhM+k=;
        b=P4f0/e3evi0OSVCn24rSOBGjV6BZGxZHJg6yEDwqsPqK7wkYVQzfiAg8WMvyMqWWNn
         +IuNDJ18+zcPIlCWl952dNNisJLRLBsTJ4MqrTY6gIHzvLSFhSDqqKGCl0D+ym9Ywwgj
         7ZA6mdy9cSzSS1o3IkshxPkq7NlliqlFjLwJg7umbvyOKNvD2PLGdRx6651rbm8b7VWG
         m+ooEffcM5iZu2gmztFHjRoxx7gw0hAa403Cj6ZnaSVYt8T+EJiJo6i65tMHK09Wb0+S
         XIGE8Qi02+81izKqeKv0nNufmRBWhM3K+34FZ0lrUoc/57VfT83ftA2GRkbQv5SOIFvG
         W5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720295748; x=1720900548;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wpPiYeL2EwFNXkIhI80dJKwE6Zivlyp3bhXMwUhM+k=;
        b=RcJGF0GYdwiLmxlXfvINM9tBDilGhQgLQwrrRcgFs9a+/5YLviBdv0U3PVg6V0zM8U
         noBl7gI5HLanrN4Dt3M212IAce0kp1+e+JKEHe5+J8/2juyiCDsGsre53XfmG3b8TaMY
         1C/bGQYO1KJut0zqpW1MiYsU9XIaJJpaYV1q+HgYapOXK2t2Mf/UNvWBmjMBArotAJxB
         4+qKRzfpnsFhK3hNxt5BDDnFwZL33AwCJSP/vpVKQ0xYjWcfHEeqNyoXTNpPH8PAUJXy
         Wt+JBy4+io5WRvxI052qaObh5UqtZUbqdLFxtXHN4rHWOQkr4WEpPppmI/8zdzXWVP1V
         LzKg==
X-Forwarded-Encrypted: i=1; AJvYcCUr4ucp8e3dJi3axBKfrPIzAhkKPrLfnTuF2Ert8zR79piYPcmIy824v0QEMUxleO2ix0w0l+dmFsrZSf9y+R55jXMW4r+pmCmOpDa2
X-Gm-Message-State: AOJu0YwqZTU5C0YyZg1GKgx1NOnczqZ1gtjBRZRpevJkZHWWDsbFDLAI
	6Wdomja9KRjox7VrvKc3DLi9CEO7ylZ99TTUXGnlC1bCCFWx/dBNq/TUWn9y
X-Google-Smtp-Source: AGHT+IHxLC10/lWipwDQrpOd+s6L8u833oHELTIF9YTOwGVAaBt/xaQRKxWXhEhbe0jx2kQbet9phQ==
X-Received: by 2002:a05:622a:1a8e:b0:446:51f3:1867 with SMTP id d75a77b69052e-447cbf6159dmr89363021cf.47.1720295748309;
        Sat, 06 Jul 2024 12:55:48 -0700 (PDT)
Received: from laptop (drmons0560w-142-163-86-219.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.163.86.219])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465149b28fsm81718091cf.73.2024.07.06.12.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 12:55:47 -0700 (PDT)
Date: Sat, 6 Jul 2024 16:55:49 -0300
From: Mark Watson <markus.c.watson@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: misc: axi-fifo: Add dt documentation for xilinx
 axi-fifo
Message-ID: <ZomhRSs3Y/EQKXNa@laptop>
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


