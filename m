Return-Path: <linux-kernel+bounces-203800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054138FE09D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D8028322B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FB613D2A9;
	Thu,  6 Jun 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FuOTVXl6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507613C3F4;
	Thu,  6 Jun 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661367; cv=none; b=Qfy07zbGvKtfpy4Vimhb44YJrrjL5RDDtN4htmwvfcOVqKrv4QAdjpRFqgTNjEW65MB5snAGgDGmMI5RV1pDb+ZVC7MA0kogfdc3MT+rrXdc+dzAmD6XozbmDHFpp+Xd6RgDnz9O/Yb7/sy2wDgG4RJaPbyueJf3Rg1YlHQenM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661367; c=relaxed/simple;
	bh=DpedhYCstvkyO9TAyQ7jGh7lAbaU/9WchZqX+SgKWFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RdP3Wjb6+7bQOs2O9aKPoK0aePvlvFfVd8LImtqbQbQIVULdQZxEoOuU/x//jnI6Art2liZh4AcQmkVHDkPTjODnzUDr9pNi1WoR0G5j0AYh3IoafwoHFXfYLWiC2izr+i/4vnqciLIpl4rq+x4stN9pqK9caLvZdlYohSKR99A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FuOTVXl6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45689IOh051718;
	Thu, 6 Jun 2024 03:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717661358;
	bh=1zVh1JtW2keqRypLUXPWUsd8cZwczK0FTHZ1SJWcaGo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=FuOTVXl6vaHtSHUXDKcguj++hhNhvsmD9E9oonGgUr7NulJ/MqRjA6UVcAl/Nl72j
	 iIECMGIsJi0opkmTIfH9f8HAVl8A2pk/BGqUioNxrsTV7kzggEl4dju2lWGz/NcAgs
	 JYgYokrvOFnpNldRzv9jfB9sGbQBga0huG8x+APk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45689IkP016105
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 03:09:18 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 03:09:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 03:09:18 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45689HXx072740;
	Thu, 6 Jun 2024 03:09:17 -0500
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 6 Jun 2024 13:37:44 +0530
Subject: [PATCH v2 5/7] arm64: dts: ti: k3-am62-verdin: Drop McASP AFIFOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-mcasp_fifo_drop-v2-5-8c317dabdd0a@ti.com>
References: <20240606-mcasp_fifo_drop-v2-0-8c317dabdd0a@ti.com>
In-Reply-To: <20240606-mcasp_fifo_drop-v2-0-8c317dabdd0a@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh
 Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
on the DMA IP. Drop these for better audio latency.

Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 2038c5e04639..359f53f3e019 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1364,8 +1364,6 @@ &mcasp0 {
 	       0 0 0 0
 	>;
 	tdm-slots = <2>;
-	rx-num-evt = <32>;
-	tx-num-evt = <32>;
 	#sound-dai-cells = <0>;
 	status = "disabled";
 };
@@ -1382,8 +1380,6 @@ &mcasp1 {
 	       0 0 0 0
 	>;
 	tdm-slots = <2>;
-	rx-num-evt = <32>;
-	tx-num-evt = <32>;
 	#sound-dai-cells = <0>;
 	status = "disabled";
 };

-- 
2.43.0


