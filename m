Return-Path: <linux-kernel+bounces-295900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8403695A2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74A41C20832
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B73915099B;
	Wed, 21 Aug 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qXgmk/Dp"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9914D70A;
	Wed, 21 Aug 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257432; cv=none; b=tyUw2IqAU17LZL5lNRCwJzXn968FjSbEupAR9QRh13kb56rZXY7MEUhPszntkq0d3Y8aApjxSeR7DO2X/PFCCefsXbMxzvQKXGQKnXEf//Hl2UHpQ7hAkQFwKrevcImkz8ByvLuMnlgiRBFZM5x9XJG13bisUhA/L9TJGz9s+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257432; c=relaxed/simple;
	bh=b/PVytZCnsLVHzLb4Nis76r8bI+f270x4UQ2vJ3VstM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=puJcDmNaXr9MkIzyvWbMgsbkt5cI0G8g8wpzK0kutTDeeYXZCcLhK7f0kQRGaXSNxfjmhBrYX54t8X7Rvgf7fSZFA45122M9MZrmie82fIdl/KsCFsyOkQ6lSs5Ta+9Y5Kfk2/Uubfs9J+6tR92kXk+PJz830+3TUDuzxOq8+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qXgmk/Dp; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LGNdC9043859;
	Wed, 21 Aug 2024 11:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724257419;
	bh=um96tooky60GuF9JA4++mFw/kEM1PfCdo8Pcxn/FCKY=;
	h=From:To:CC:Subject:Date;
	b=qXgmk/DpTJjyY4ilayA1oh3xOPk1oiSK9AEsiVBFyDADZ1jIyvDAch77g3aPqvvx5
	 jp2fbjhFd93AIpJtqUHmnW42u3yF+HW5p0P8i/OlvEa4xxmhaM1nQc0k/a7uLNQLnv
	 uOnx3SIBaijq0N8Vx5ZSPzf3agkT4/X/ix6oZilQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LGNdoh125377
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 11:23:39 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 11:23:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 11:23:38 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LGNcGZ086814;
	Wed, 21 Aug 2024 11:23:38 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: soc: ti: am654-serdes-ctrl: Add simple-mfd to compatible items
Date: Wed, 21 Aug 2024 11:23:36 -0500
Message-ID: <20240821162337.33774-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This node contains a child which is only probed if simple-mfd is in the
compatible list. Add this here.

Signed-off-by: Andrew Davis <afd@ti.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---

Changes for v2:
 - Added tags
 - Rebased on v6.11-rc4

 .../devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
index a10a3b89ae05e..94b36943a50ff 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - const: ti,am654-serdes-ctrl
       - const: syscon
+      - const: simple-mfd
 
   reg:
     maxItems: 1
@@ -31,7 +32,7 @@ additionalProperties: false
 examples:
   - |
     clock@4080 {
-        compatible = "ti,am654-serdes-ctrl", "syscon";
+        compatible = "ti,am654-serdes-ctrl", "syscon", "simple-mfd";
         reg = <0x4080 0x4>;
 
         mux-controller {
-- 
2.39.2


