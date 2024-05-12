Return-Path: <linux-kernel+bounces-176901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD18C36D8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 16:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432151F21DFB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477BE2943F;
	Sun, 12 May 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pmtvGKR2"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73D2D792;
	Sun, 12 May 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715524712; cv=none; b=FPqnGYvMV/n2SXdxWL0a6cyRrHmSZSDIEykHZwNhcN9Wo0Mihi21wrfqhHY+iIVHoTpJLAZpT/S+nW/nwmRqZ4C02ARET/zMVcef+ByXl1smXApfzh7vcftwTsBZ7IYjoacfIpNyG5qvid0MbiZfG7az5I79IycXuqjia16Dv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715524712; c=relaxed/simple;
	bh=AudCllP4j2KERmkzBH7fZqgPHg52zvoWk38UKGar26E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FzLuTstIxJPLETXgdkTtOdmKPNxilkHz0+y5Kfm1pk6q1QVExIcz64iLBuyC4lsj/8w+c1Cf9GQbmGwpEX2C/tpXDQn9pMZ1TzSIu9TRfMDDBJN/JYCQAdZtbku4QCsxDmbBRYlUG5J2X43HKIoyPXz+0eEohufW5GoVCLr2N8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pmtvGKR2; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44CEcQpx092808;
	Sun, 12 May 2024 09:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715524706;
	bh=NZZgOXBnBWttjILJyHHNUk0x7jPRIHmPvJIAiVj0Czk=;
	h=From:To:CC:Subject:Date;
	b=pmtvGKR2c0pa1dUiJ9t9iD4xvE9MDhJ37QqHCHbBvVAzcEr+kyD72wZV4ywBzCiog
	 hP0XjWOss4BRNrP7+nudNDCfXw5pS/4pbKxbV66GOsND13YT5Vw2I612z4M9jId6nQ
	 1qntjZptsBwrnh2baFNOaqpQWw8yTcl+2XDHtAJs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44CEcQBI076983
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 May 2024 09:38:26 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 May 2024 09:38:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 May 2024 09:38:25 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44CEcPxL022997;
	Sun, 12 May 2024 09:38:25 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>, Nishanth Menon
	<nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri
	<praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Devarsh Thakkar
	<devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>,
        Aradhya Bhatia
	<a-bhatia1@ti.com>
Subject: [PATCH] dt-bindings: mfd: syscon: Add ti,am625-dss-oldi-io-ctrl compatible
Date: Sun, 12 May 2024 20:08:24 +0530
Message-ID: <20240512143824.1862290-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add TI DSS OLDI-IO control registers compatible for AM625 DSS. This is a
region of 10 32bit registers found in the TI AM625 CTRL_MMR0 register
space[0]. They are used to control the characteristics of the OLDI
DATA/CLK IO as needed by the OLDI TXes controller node.

[0]: https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 7ed12a938baa..6a5834b11a35 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -88,6 +88,7 @@ properties:
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
               - ti,am62-usb-phy-ctrl
+              - ti,am625-dss-oldi-io-ctrl
               - ti,am62p-cpsw-mac-efuse
               - ti,am654-dss-oldi-io-ctrl
               - ti,am654-serdes-ctrl

base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
-- 
2.34.1


