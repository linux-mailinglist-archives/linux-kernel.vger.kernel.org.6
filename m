Return-Path: <linux-kernel+bounces-229325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF6D916E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B75E284826
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135FD17556F;
	Tue, 25 Jun 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kP4EZ1PI"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1713B59B;
	Tue, 25 Jun 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333942; cv=none; b=AK1NfC2ebsJN9yh8iK3ft2t0XEWhGbY6e6arJofq/Ottb2RjksRBapt+O1AzG1BAYNy7iFVIgjGdJZCq7OgrQMLJx8kM6pEmjHBH0AyVXrNUM710i0Sjbjlg7ccyRabYjMzJ8pODMP+8WbOlWg7iJcRebzNaDqDryAY253Fe1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333942; c=relaxed/simple;
	bh=6xljIZVHX1BWtoBG5iQPsPX4Li/SNa63XpA04Jo8ZK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+HtBAbIaVd6UBpAbWXc6E1nENCcYpto6agvOyl7Pi5pzMDFbHI41VX9ds2En/dbOVB1usSdWuaI7xdgUoF1fCF6iUTsvKR2Yz/9Y5Dsi6oBWdBHvbxDWlDEcf9YLRp9cJpM9Nx3MsoJnhYMNQlx58M7OnYvXYZeovKoCu309mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kP4EZ1PI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PGjTot100162;
	Tue, 25 Jun 2024 11:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719333929;
	bh=yTxW68HnNWXZew965gTSI2ywCz1BFSCBddJxDmISOTg=;
	h=From:To:CC:Subject:Date;
	b=kP4EZ1PIl1pdNWUlWIH3XDITElopUAfU3eRtmxiYQZqDZM1leFaLSUmhf/3n468i4
	 0Hu6OvfpZnxPLR5mVpdpjvvEMbusLWlMON5ynPbyNZnRiU6JaNgqM1JlOhQpXuRexA
	 qed8Wi+U6TAgwYpaq1b1JNteo67aDHi67PJGXjo4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PGjTid099417
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 11:45:29 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 11:45:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 11:45:29 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PGjTcO048951;
	Tue, 25 Jun 2024 11:45:29 -0500
From: Andrew Davis <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>, Tony Lindgren <tony@atomide.com>,
        Nishanth
 Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 1/2] dt-bindings: soc: ti: am654-serdes-ctrl: Add simple-mfd to compatible items
Date: Tue, 25 Jun 2024 11:45:27 -0500
Message-ID: <20240625164528.183107-1-afd@ti.com>
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
---
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


