Return-Path: <linux-kernel+bounces-304847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D989625B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EBA1C20D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43C16D4C4;
	Wed, 28 Aug 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dz8W0L2t"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312715D5BB;
	Wed, 28 Aug 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843728; cv=none; b=pLsQBIoRPF1xvW8CkVcB/VBLfo9uVbW2KvPvEiyVCPC+w7DeBpxbH2elH6CXFVaQ7+4Uihc6GAj9DZ6Oiq1I39q3HmxkX13BMvyfm6B9b0ZljDFk0Fn08+Xvt4VMEFBmsO1qO2bClgGPrv1OG7bpH7vtRi1jnM0olLGuQ71ckK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843728; c=relaxed/simple;
	bh=0j89wBAI4Pmk8/+fqTPpNXqC3nyCPW266Wtvrp9BU60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DQeQKbVcaVMAhwRrZ6isKTjhZXerbXn9Sb3jMX5lNszhLWVB+0843GPLIbRErma+8ozslBh6s1X/yDe152YA3Masc7tKWM+LVc2wdg39G/V7/LbZkFyQ69A70Ywusvw03kEzC9SCL2r58ReKsgcbf6Ixjq5hedHTcdOPAPujMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dz8W0L2t; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SBFJdh016180;
	Wed, 28 Aug 2024 06:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724843719;
	bh=3Cgu0tyd4ZrGR+iFkP4eYj1DHsmzwqLInte2b5mLOxE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=Dz8W0L2tdKUGpRPRUXe5rWDHroFUxacipMfEY5q/HlbWWjPl1xVTfaDg/xmCqBXlU
	 kW0q/JF2Je0YyhDdSpEmOm6kmLghhqXu9qV3sA/3PkKvZ6xQDM0KhRDnSmNxzhpFKp
	 pepKMA22HiRJtDMV4IVvhh+b9tHcoFoJqEfmcZrA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SBFJ4q000880
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 06:15:19 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 06:15:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 06:15:18 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SBF10A122618;
	Wed, 28 Aug 2024 06:15:14 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 28 Aug 2024 16:45:01 +0530
Subject: [PATCH v5 3/5] dt-bindings: arm: ti: Add bindings for J742S2 SoCs
 and Boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240828-b4-upstream-j742s2-v5-3-9aaa02a0faee@ti.com>
References: <20240828-b4-upstream-j742s2-v5-0-9aaa02a0faee@ti.com>
In-Reply-To: <20240828-b4-upstream-j742s2-v5-0-9aaa02a0faee@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724843701; l=917;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=0j89wBAI4Pmk8/+fqTPpNXqC3nyCPW266Wtvrp9BU60=;
 b=1ExrkUEzhDyqRIQbOL+2aTAREKaLzIHBoTfpPwG+e+PmRHvNRr1orMLEgWW8ruAYVoXmbpBys
 arOKV+wJBOJCzla5wMp0y7YONG93SZ61Av23XMED6I8F1lMLkwpAjfa
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add devicetree bindings for J742S2 family of devices.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 4d9c5fbb4c26..074d6dc6092f 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -143,6 +143,12 @@ properties:
               - ti,j722s-evm
           - const: ti,j722s
 
+      - description: K3 J742S2 SoC
+        items:
+          - enum:
+              - ti,j742s2-evm
+          - const: ti,j742s2
+
       - description: K3 J784s4 SoC
         items:
           - enum:

-- 
2.46.0


