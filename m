Return-Path: <linux-kernel+bounces-311316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D0968776
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004C41F2256B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E876C19C560;
	Mon,  2 Sep 2024 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WSa1HvBl"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A65185B6B;
	Mon,  2 Sep 2024 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280037; cv=none; b=IVR6DzXo5htrr0aGcW1qkGthOQzVXRkuRwxvxmfYiBYuIxMIDWPr/qKeRLdhyGR3y4nz7QJz50SfGO5aX+kccB57ZgHhJpasrnj3bdsVAsyJT3v08sIdnkb58Z3S1Yn7PkTNvXmFTDaJjS3g2JyJul2QwVJm38CuaMqAd/stl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280037; c=relaxed/simple;
	bh=4WftC8hv69+qtzdyshUfjUmPEF7vOdi0BEHrqZWIL08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Mf9zeG23fLpcJ5DwXOAJyJ3fxyi81g6q/yO7xZKQ8i4IF/Awp0GazCm1wMRF1OJZXjbOcTe3bKaYKe11pHBkeH3YP3txMCblrMOO6FlEXzqdFExqyBxDMPCkge5UNsq4KtcyR8ETu3IQgvApHAXiMjLW/eE3KgC1MyR9WFdEHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WSa1HvBl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 482CR9h2099645;
	Mon, 2 Sep 2024 07:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725280029;
	bh=jUG8LRWAqq4w/NuCY/4RwjcD3YU0lZjiRfWtfj7R6HI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=WSa1HvBlM0EdumzPax4ZCMgA8zwbCt2BK40eDq+RNtfSWuP8MXa5ciYZ7dbRioNuU
	 +ztS/ZPh0DCax25qc+OOcNP8cHogcu0TzmLkhyFSdyWD7T2BykdQZKaiZb0DNmYDBn
	 E2K7QaNKhA3ZdDgEI8BohIxPKwA4gEkNfD8msg1Q=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 482CR9HN016636;
	Mon, 2 Sep 2024 07:27:09 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 07:27:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 07:27:08 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 482CQpGH023644;
	Mon, 2 Sep 2024 07:27:04 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 2 Sep 2024 17:56:51 +0530
Subject: [PATCH v6 3/5] dt-bindings: arm: ti: Add bindings for J742S2 SoCs
 and Boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240902-b4-upstream-j742s2-v6-3-6a7aa2736797@ti.com>
References: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
In-Reply-To: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
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
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Manorit Chawdhry
	<m-chawdhry@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725280011; l=948;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=4WftC8hv69+qtzdyshUfjUmPEF7vOdi0BEHrqZWIL08=;
 b=GO3eDuuu6E7kv0wq0ADNtP7PRIDATEeKznBGVts8uaZ4C4OlYGFBegv7+n9LmLuQ52IrjvSZb
 6XOXsMsb5w6CYClFse6Cv1TUq8j4JYQGuGmbwxKNbDaW3HW3BHgty2x
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add devicetree bindings for J742S2 family of devices.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    v6: No change

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 5df99e361c21..b0be02f9d125 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -144,6 +144,12 @@ properties:
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


