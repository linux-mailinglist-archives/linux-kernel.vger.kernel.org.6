Return-Path: <linux-kernel+bounces-197121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F6C8D6679
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51395B2A5D6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7A172BA2;
	Fri, 31 May 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g0BEU0Z5"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6114158D9C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172033; cv=none; b=Rn1jfsOfHVPKwVXTTh9hPCZoLzejHvycHCUxDYFV8kF5co3uhZOzsYuW18hnjJbTwOGBfxizjZErn8ePNJKREsAVEOTkBMVOj6+DcCOLVtoENpcMmxw78YbvG0ieJLaOtphcA173M590vVz+rVkwdeap27KYLV3tnPVrSrEimXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172033; c=relaxed/simple;
	bh=EzyIjuJj/J5dssuEwuYMPWZIo1X0zzcFoeRzZ79QhU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5mZ+uRvm8zl7emSSYkuA30GoNBULfEc5pTv4c+BNjskGWchIxPnEyevD0F1s+eKXpz2zx+C7zeZzqZ4NjLYlF54YqOm2YKTXgXo1+lgqUtzNuxpqagyOgmGJ0uFN/Hgbr4MKwPpLmT/FJgY6+tGTP0zBAf4WqhZA+h804rPszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g0BEU0Z5; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717172030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZqpbYK0acYzL/XrtMy6W52K47SmPfVIoW1GfOOCZgI=;
	b=g0BEU0Z5fo+CppAYRK/JgTR3WszFtmSJ9G6hMLCOCNO3acaJebGGoixYy1870PiBsFGFeg
	/VBB6X04H4RjW/ksrKfq/tfWAs+DEVye/TL1ckZZuI5dvg/cPgh8mJIW0lOM/pqNdaF0cb
	FMMmwkT2k712z9wAN9HokGMzc53/UeA=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: markus.elfring@web.de
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: sean.anderson@linux.dev
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: krzysztof.kozlowski+dt@linaro.org
X-Envelope-To: devicetree@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v4 1/7] dt-bindings: pci: xilinx-nwl: Add phys property
Date: Fri, 31 May 2024 12:13:31 -0400
Message-Id: <20240531161337.864994-2-sean.anderson@linux.dev>
In-Reply-To: <20240531161337.864994-1-sean.anderson@linux.dev>
References: <20240531161337.864994-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add phys properties so Linux can power-on/configure the GTR
transceivers (xlnx,zynqmp-psgtr-v1.1).

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---

Changes in v4:
- Clarify commit subject/message

Changes in v3:
- Document phys property

Changes in v2:
- Remove phy-names
- Add an example

 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
index 426f90a47f35..cc50795d170b 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
@@ -61,6 +61,11 @@ properties:
   interrupt-map:
     maxItems: 4
 
+  phys:
+    minItems: 1
+    maxItems: 4
+    description: One phy per logical lane, in order
+
   power-domains:
     maxItems: 1
 
@@ -110,6 +115,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/phy/phy.h>
     #include <dt-bindings/power/xlnx-zynqmp-power.h>
     soc {
         #address-cells = <2>;
@@ -138,6 +144,7 @@ examples:
                             <0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
                             <0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
             msi-parent = <&nwl_pcie>;
+            phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
             power-domains = <&zynqmp_firmware PD_PCIE>;
             iommus = <&smmu 0x4d0>;
             pcie_intc: legacy-interrupt-controller {
-- 
2.35.1.1320.gc452695387.dirty


