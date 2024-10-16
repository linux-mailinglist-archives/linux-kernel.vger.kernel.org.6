Return-Path: <linux-kernel+bounces-368890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A259A162A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2AE1F22F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F911D5175;
	Wed, 16 Oct 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kwETLeIb"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84E161326;
	Wed, 16 Oct 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729121462; cv=none; b=PBoAxJD7TTUAjiJ72Lk1QVWQGX3F2yFqLtpu0Xmsush4n4aLGllONzbnaRd0t9Zf6r7j10FmtbFZ5Y0/WwHUwSxfu5dvdZBTR0IoRNP6yXwrFN2DrSPNTw4SSmUg7JGXgGYpRESsiu8O9nX29iyUS85q1/dGjW+lbkRH3mImw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729121462; c=relaxed/simple;
	bh=yoHj3elEoBQc7qApUDMxTNIZqiijiO+9KRtTLxKfyUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nieeYvAyu3FQmsEmV1gSW5EqJncLqnSQHKmk2RksK/L3rtO/zZqIj+51ELiHLCzRV+Y8Fnvk/Oqxl2mYhTLOgvXO8om4LaI8iPywoEJfan7qfk6jXaS/ZbvRZoIr22OFCEt+xtoOepgTTPyxNjCy59kJc/YNtKtZuR73exLleZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kwETLeIb; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUkOW095566;
	Wed, 16 Oct 2024 18:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729121446;
	bh=VVT5NjucKejzRiT5jUNXrU8R/6dUkvf+IblHz9+7Bmc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kwETLeIbzrxTavbqp+dk4lTCsIk9zyNR/MzLT/n8mHYT1hbGpZ1y276vew32NvMLo
	 Aftm7if1jM4KQeZ/4K3WvarHaP8VADl1LRYLHH4rPrSDL3T7FxGdef09HF5LETGIUr
	 jPAc3jY9iSi/sPRdEYVNx8qLrolAXxx3sEJ8ikDY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49GNUkYI011740
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Oct 2024 18:30:46 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Oct 2024 18:30:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Oct 2024 18:30:46 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUj7i070988;
	Wed, 16 Oct 2024 18:30:45 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/5] dt-bindings: soc: ti: ti,j721e-system-controller: Add PCIe ctrl property
Date: Wed, 16 Oct 2024 18:30:40 -0500
Message-ID: <20241016233044.240699-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241016233044.240699-1-afd@ti.com>
References: <20241016233044.240699-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add a pattern property for pcie-ctrl which can be part of this controller.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../bindings/soc/ti/ti,j721e-system-controller.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
index 378e9cc5fac2a..2a64fc61d1262 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
@@ -68,6 +68,11 @@ patternProperties:
     description:
       The node corresponding to SoC chip identification.
 
+  "^pcie-ctrl@[0-9a-f]+$":
+    type: object
+    description:
+      This is the PCIe control region.
+
 required:
   - compatible
   - reg
-- 
2.39.2


