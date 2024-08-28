Return-Path: <linux-kernel+bounces-305434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D568962E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F304C2816DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC421A706C;
	Wed, 28 Aug 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ccv5aoJh"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E61A08DB;
	Wed, 28 Aug 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866209; cv=none; b=BYlv2qr10YvGx8jt2ckKNbckmEMecXZ9HQHEWWi1SxDMBWF4bDzH8icHAAxN/uYj0oVMYyt79Iss+RwaZRN6oP1RsCp+Vwd+xrb4s1QGK43xKg5XTYomj+MUrRwC47zC1IMp2fr7nk8Uc1oEmpOlRWU1DWteN5Ef9VEHkxmJ5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866209; c=relaxed/simple;
	bh=mXSFgFdetCNSTkr8Hwfa39ghoaqApmwSqFhLnii+/OY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrcDWT/HTwV5ktrD+lUGF1VWMNnhdLS0rgr3G1wcQGeWQ8erLBUlEE/87KQ0oymkIBj2huZP94pcn+t3zGibohDNZ2TkUZ8YbDsYtxYUOHtMn+wn3WFcECTVooPB82cVPgKypMS5vFFkIB+rIm1Fgf+4EbuRGnrauPhYfGb42Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ccv5aoJh; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SHTxt8075766;
	Wed, 28 Aug 2024 12:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724866199;
	bh=2zBpFFpUk1B5kt15YhycSEy1WH9Y09VVe83kCww1UBQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ccv5aoJhnq1IubK4jYVvNh6zQwEf62RMhqQ/lIfL+ZRcDfcqJMl3MW0N6/TR+iGXD
	 bgcDDdzgJoSqIXEYybzMlURnX1FnKgnZtIlSHuIiTMg6e5/dD2Mu8dsXWBNN09VYHX
	 naLpoLZ1zjhirCnqr6O71wdjC0mj4LUZEkjlVFoQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SHTxmx011929
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 12:29:59 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 12:29:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 12:29:58 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SHTugC073490;
	Wed, 28 Aug 2024 12:29:58 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Santhosh Kumar K <s-k6@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 3/4] arm64: dts: ti: k3-j721s2: Include entire FSS region in ranges
Date: Wed, 28 Aug 2024 12:29:55 -0500
Message-ID: <20240828172956.26630-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828172956.26630-1-afd@ti.com>
References: <20240828172956.26630-1-afd@ti.com>
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
Reviewed-by: Santhosh Kumar K <s-k6@ti.com>
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
index 568e6a04619d8..ea16f82822ae3 100644
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
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS data region 1 */
+				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS data region 0/3 */
 
 		};
 
-- 
2.39.2


