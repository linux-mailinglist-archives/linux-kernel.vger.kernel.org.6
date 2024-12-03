Return-Path: <linux-kernel+bounces-429942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 712CB9E2BC2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595C8B834A1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA171FC0E0;
	Tue,  3 Dec 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Awy81HGm"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014351F76CE;
	Tue,  3 Dec 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247095; cv=none; b=Gbg/3Cj3EqdnTTU2XjbmR2PCtXcydoUveyquzMYKUwp5tbZj2C/1ivRW+R6jh+puUzGiAJSJDIlpuf+KtFAvSmkTpmu36F+TGN9Jh4Ib6Cc7aa+q1qrVPJtvNr7FIOR4onuXtgMRmRjdqTXCiqkDRrX5wgUg1OZTwDeVZlC/Ya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247095; c=relaxed/simple;
	bh=VY9I6tMbaOwGkEA2CtUAkkPXFn6L7t6Pb5btMZx6Hto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAUitbDQHTckopO5ak+qTRF8dJ8oYrjCWVRArnz6xreNFzDtawCO2Mndb00Ik86mc3+vJIt1CP4lTaEB4hfJ9u8R4yMRAh+gujtuSa/37en/kFiiJZScZPbkkhx5XmW6HYD4RVnY0BKaSEKMjnsVXirzUoeKCLALZeDI+ACtu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Awy81HGm; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B3HVGdI1647618
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Dec 2024 11:31:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733247076;
	bh=WoSIkmjhrUW5VXd30Zk6NMiGMJuD5DYNGl/XI2VX+WU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Awy81HGmKbsNRb3m02NIiV8LsZIwBGEc5QkPmGAcNTzP9BUeTnTZah0dNvfD4wLPU
	 ma+0Fk6Z2T3V0oh54FPUger0PnpBfRAU3/oG2TGJJv15C4Hu/OorZj9ssnW6hHEqn0
	 uuVkdJDFRlDfI3dsEgch+86aSAEfb23PoUAUX3j0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3HVGlK069942;
	Tue, 3 Dec 2024 11:31:16 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 11:31:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 11:31:16 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3HVEpR094200;
	Tue, 3 Dec 2024 11:31:15 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 4/4] dt-bindings: soc: ti: ti,j721e-system-controller: Add MAC efuse property
Date: Tue, 3 Dec 2024 11:31:13 -0600
Message-ID: <20241203173113.90009-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203173113.90009-1-afd@ti.com>
References: <20241203173113.90009-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add a pattern property for MAC efuse which can be part of this controller.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../bindings/soc/ti/ti,j721e-system-controller.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
index ead0679b30e3f..fbaae3d1bef60 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
@@ -80,6 +80,12 @@ patternProperties:
     description:
       This is the PCIe control region.
 
+  "^ethernet-mac-syscon@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/mfd/syscon.yaml#
+    description:
+      This is the Ethernet MAC efuse region.
+
 required:
   - compatible
   - reg
-- 
2.39.2


