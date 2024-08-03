Return-Path: <linux-kernel+bounces-273437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3B94693E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D33B2160D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3500F1509BD;
	Sat,  3 Aug 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="CLLYDoMV"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A30214D71A
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682705; cv=none; b=oSlyCO8xmZEWat9zoHFIO99zYEjR/gT9d8dNwKogJJa5mI/kq6/i3x+IoUPSkMlzN4Gfd/FddkNQ27Syziqq7YP/iO4suKWDA2qvUjezpchiitZ6EIb12yBNFPsz86AOtJ+iA6LGopoHPEY3/hZkLVhTUgyjGRPa6cu4kn4hrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682705; c=relaxed/simple;
	bh=yHdo1T9SuZ+oYQAhZBz8Mjq2CUJJ2pBPOaEJLtJrgzk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuZepiulokeYCXhXfi+jb3/V5Qs268uyF71HG18soCnz6ngKjuwJoAKMQIrEvCj4vLbkP+f+I5L3WHCBDlOcNDlv3SzEDSpcMl3/2mzGngzqSTHS3SEOqfZepl1ot9SRKxTQcna58Q7UMOZqjPyBQd/ZhMW1/b/B5FpDCs6AilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=CLLYDoMV; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722682702; x=1722941902;
	bh=8SUDarAKq4d9hQZ9wreu4NLDZENLtufrGVGAJEsJUYQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CLLYDoMVIiQOnA2BcAvKjreA6fluldSGnx4JcXluGbKVKIYJciM0iRYgEeVh+d+ZR
	 lsldEukuSq5UgFGJqSd0xbR4tKB4KGR4WbqcTdPheUFPP+0pmWymVeVZgAHZ7wad50
	 r0/ScEcKdcrq4sFcj2v2/9vtwUfvij9MQIfIvhaa+adqCwnGRZ/wtkZoDGXohY21SO
	 42qbpBAPCjOqXn2lwuOdlfg6wgBjt7RjvNhfUzod1YIAKwKBMkgmpouaE41/zn9k8g
	 LA2EGPEQ96yPJA8bBq+8O5naLyVe65VLIgmuSzflxOqJQfMKSRTd3guh91MhT0O12h
	 0wztS3oNwGEFQ==
Date: Sat, 03 Aug 2024 10:58:18 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v2 5/9] dt-bindings: clock: xilinx: add description of user monitor interrupt
Message-ID: <20240803105702.9621-6-hpausten@protonmail.com>
In-Reply-To: <20240803105702.9621-1-hpausten@protonmail.com>
References: <20240803105702.9621-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: cc6f1df396aa2ef7de7db5590f55ebc7042936a5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This Xilinx clocking wizard IP core outputs this interrupt signal to
indicate when one of the four optional user clock inputs is either
stopped, overruns, underruns or glitches.

This functionality was only added from version 6.0 onwards, so restrict
it to particular compatible strings.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
v1 -> v2: Fix binding errors by moving interrupts up front, restrict later

 .../bindings/clock/xlnx,clocking-wizard.yaml  | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.y=
aml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
index 9d5324dc1027a..9e5078cef2962 100644
--- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -39,6 +39,14 @@ properties:
       - const: clk_in1
       - const: s_axi_aclk
=20
+  interrupts:
+    items:
+      - description: user clock monitor interrupt
+
+  interrupt-names:
+    items:
+      - const: monitor
+
=20
   xlnx,speed-grade:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -62,17 +70,32 @@ required:
   - xlnx,speed-grade
   - xlnx,nr-outputs
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - xlnx,clocking-wizard
+            - xlnx,clocking-wizard-v5.2
+    then:
+      properties:
+        interrupts: false
+        interrupt-names: false
+
 additionalProperties: false
=20
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     clock-controller@b0000000  {
-        compatible =3D "xlnx,clocking-wizard";
+        compatible =3D "xlnx,clocking-wizard-v6.0";
         reg =3D <0xb0000000 0x10000>;
         #clock-cells =3D <1>;
         xlnx,speed-grade =3D <1>;
         xlnx,nr-outputs =3D <6>;
         clock-names =3D "clk_in1", "s_axi_aclk";
         clocks =3D <&clkc 15>, <&clkc 15>;
+        interrupts-extended =3D <&intc 52 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names =3D "monitor";
     };
 ...
--=20
2.46.0



