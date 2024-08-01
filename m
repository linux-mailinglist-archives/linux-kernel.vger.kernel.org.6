Return-Path: <linux-kernel+bounces-271705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B7945243
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E281C22FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F591BC063;
	Thu,  1 Aug 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nr3N4ybj"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8A1BA86A;
	Thu,  1 Aug 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534616; cv=none; b=WjWiWquWFCyVINPUQJ2D6itjpReHnACBVZSwGU1VUN0DmGp7IvO+t9169b9aREQ0GYF1LaSCRfEZNwuXBlXZia9UUqu8j9FaRwpjIDMVXkBc6GnWeE+HxwNkAbGsVuh90Ngzs+iNA96CHbsxcQNxfAS71tu9tEofgVzgm1LiRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534616; c=relaxed/simple;
	bh=Ye8j/s1rc0GEGJEClYnpL7ZKVIMNK7+8E6g5n0jXZQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2z+XXuqJuF+BCWsjF+ODc7YbfiWi6wM3bM3dD/Nsuf9wbJhizUEMLIvP6NYwnQdgg/XNjYiYi2cyTCzFY1/UlwOtkegtGDeTAHkzqP0IQSnnF9iAXrniGNnw5hvJTkFZR7aXPhdgOlq8PRJKWqwy4HqvXsNeYSk64k2R5JtJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nr3N4ybj; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471Hnii4124001;
	Thu, 1 Aug 2024 12:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722534584;
	bh=C73L8KJCcKeh4UbRxeol+8rrc5c5kLplLZs5RAPa8LA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nr3N4ybjE3zoy+T0ClQINJ4jK9g6rTHy4l9wh9oauJfT5lhF/O2jO+4jsNXt4tn5D
	 mno0lHtg6wT/ZdIxL3hZi8Cwzlzc8TZxWSbO1rvGoNrLdtNvpPe+I/Emv0NNsdfZ0x
	 LAtW0JQFbegfq+mQkDYq6uyfitopZW+chupYmpv0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471HniIg036733
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 12:49:44 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 12:49:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 12:49:44 -0500
Received: from localhost.localdomain ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471Hngkj067627;
	Thu, 1 Aug 2024 12:49:43 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jonathan Humphreys <j-humphreys@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-j721s2: Include entire FSS region in ranges
Date: Thu, 1 Aug 2024 12:49:40 -0500
Message-ID: <20240801174941.41002-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240801174941.41002-1-afd@ti.com>
References: <20240801174941.41002-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add FSS regions at 0x50000000, 0x400000000, and 0x600000000. Although
not used currently by the Linux FSS driver, these regions belong to
the FSS and should be included in the ranges mapping.

While here, a couple of these numbers had missing zeros which was
hidden by odd alignments, fix both these issues.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi            | 8 +++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 8feb42c89e476..9d96b19d0e7cf 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -622,8 +622,8 @@ fss: bus@47000000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
-			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
-			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
+			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>;
 
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
index 568e6a04619d8..f09315576462a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
@@ -141,8 +141,7 @@ cbass_main: bus@100000 {
 			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
 			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
 			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
-			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
-			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
+			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>;
 
 		cbass_mcu_wakeup: bus@28380000 {
 			compatible = "simple-bus";
@@ -158,9 +157,8 @@ cbass_mcu_wakeup: bus@28380000 {
 				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
 				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
 				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
-				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 0 */
-				 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS OSPI0 data region 3 */
-				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS Data Region 1 */
+				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS Data Region 0/3 */
 
 		};
 
-- 
2.39.2


