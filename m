Return-Path: <linux-kernel+bounces-301481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0422A95F181
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25C21F21BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32EC186E40;
	Mon, 26 Aug 2024 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="B4Aoy6r1"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDD1865E1;
	Mon, 26 Aug 2024 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675917; cv=none; b=q5vr31RBJc1bYVwuZCdydvOC2u+Ey/64NOPkatB4QpL3zZPX/cAZqnt8L1Fi5pmk1leugnmsnQL3zxtETYMuKxRCXM+D/c0F+V27QOqvGIY/+sKS2cQcR4w7YUT5Tgzh/C3fybWLU5L5SoS9CyQ7wciUCXiIsA4XifmXc6+BKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675917; c=relaxed/simple;
	bh=RZrKUCWuPMeEmnF/GjRuZKHAXD/6FzNlDth0Kxefv7Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkcej2tsdK74MhlzKMiCJIKOi4ALgE8QN8PiNt1IJp2BZhzZil4/cKCOrHNT4XfBYP9U2+AqoT30/lsUk2z+arfSEaTeOPpHd8QBUxysQUeTl3gMni4/nPUqHZIJzROINgCQCQINQRwVXABUlZpFo+aRFhQjV6Ihz3mhfalj5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=B4Aoy6r1; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1724675913; x=1724935113;
	bh=4hazs+UIzo4IgYzzXr9eJWZwi9I7AZWl/ecj0zSGZSw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B4Aoy6r1KdMMVkvXVXauQvAUrXot8cBURn5N3FRyS2JOY8H0IJqpFsj2G0C7+HhFi
	 EkpeKfal4NS5+ppblAwy2pVLaYNEAgZbk/t7ZI38UY9ZIdhByRk+O50rfyrSv2AHjP
	 y/CLjx2dW8VB9L43p2/EppmU8tD6A8KTnjqRUp8LTohwXNLrT5JoEUnyF3PMDOzM1X
	 RGAnFsTR0LeWf9/EVBeBJ2xugOW3NfkB9UpADgNN1lhxFQGX5Hyi1eMuU6PniGVTA8
	 zMPYF775YQKUH3u7KzxFlLU6BJYyHB1mrTQwsSzle8CaIbFPo1YmI70iyFx4SslvCT
	 SNPQqJtxgSceg==
Date: Mon, 26 Aug 2024 12:38:28 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 5/9] dt-bindings: clock: xilinx: add description of user monitor interrupt
Message-ID: <20240826123602.1872-6-hpausten@protonmail.com>
In-Reply-To: <20240826123602.1872-1-hpausten@protonmail.com>
References: <20240826123602.1872-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 47cc1d64e01b33782b1046a6e0ff752f94bb98a6
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/xlnx,clocking-wizard.yaml  | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.y=
aml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
index 9d5324dc1027a..2b9903f05ef34 100644
--- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -39,6 +39,13 @@ properties:
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
=20
   xlnx,speed-grade:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -62,17 +69,32 @@ required:
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



