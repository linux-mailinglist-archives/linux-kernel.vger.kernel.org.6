Return-Path: <linux-kernel+bounces-363398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD80D99C1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D23B2289D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C653914B07E;
	Mon, 14 Oct 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="siYBvjDP"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472B20328;
	Mon, 14 Oct 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891949; cv=none; b=SnRMzuPn+UDLoLFgKIR+PY++i3QjgPOyou+Sd9H7fuhFY1bVSv+kv3u9aKEEjeTytXhoV6M0H02bfAwQ2TUmu4SANzXI/qh0Yeq4pTJkNhWh2OGlaR4ITBK4FaoqeRqV5z9OwGGBNaP2flR0Tj6O+M67NjwB+OSho+RBx77R+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891949; c=relaxed/simple;
	bh=YCRLSVoir5nCgjFywJCGirqXMiE6ZoTGKM0SCz4eu7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0pVtxg51JSnFJ+cLwDhCsyCG4NwzwWsZOEaJXuGcLQSO0Vip56JHFsq1+a7/rWDeZVzV852tU88QczUCGX50DnmK6oBCAn1gSDv/bugIJosSOymLA2jqsXVEibgwGlQgh1XG1u5y3YRYTTo08r091rYn+CxLtW8RlGAndTnztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=siYBvjDP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jZ4d062765;
	Mon, 14 Oct 2024 02:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728891935;
	bh=WMSpH/KT3Cx378ztB2/fnqsqdxuSGV685fOTRNOrEEs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=siYBvjDPrKZ9TZUeacrZEW5rxB5Nmz6QHcY6FuO46IVpPlB6gz1yW3QAOy2oDG2Sy
	 6wX9CkgSKoJFlvoo0MKTCJuc9f3qqACCDOoKU5QM5BzZiflQdWGTPxWSxiw5Te9I6x
	 7cGQ3VsNKYjMxCVC3vsWUTLquBnk/cbvWqAIHDCA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jZtB020693;
	Mon, 14 Oct 2024 02:45:35 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 02:45:34 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 02:45:34 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jYM3006756;
	Mon, 14 Oct 2024 02:45:34 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 49E7jYpk025331;
	Mon, 14 Oct 2024 02:45:34 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-am65-main: Add ti,pruss-pa-st node
Date: Mon, 14 Oct 2024 13:15:24 +0530
Message-ID: <20241014074527.1121613-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014074527.1121613-1-danishanwar@ti.com>
References: <20241014074527.1121613-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add pa-stats nodes to k3-am65-main.dtsi for all ICSSG instances.
This is needed to dump IET related statistics for ICSSG Driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 1f1af7ea2330..94a812a1355b 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1167,6 +1167,11 @@ icssg0_mii_g_rt: mii-g-rt@33000 {
 			reg = <0x33000 0x1000>;
 		};
 
+		icssg0_pa_stats: pa-stats@2c000 {
+			compatible = "ti,pruss-pa-st", "syscon";
+			reg = <0x2c000 0x1000>;
+		};
+
 		icssg0_intc: interrupt-controller@20000 {
 			compatible = "ti,icssg-intc";
 			reg = <0x20000 0x2000>;
@@ -1333,6 +1338,11 @@ icssg1_mii_g_rt: mii-g-rt@33000 {
 			reg = <0x33000 0x1000>;
 		};
 
+		icssg1_pa_stats: pa-stats@2c000 {
+			compatible = "ti,pruss-pa-st", "syscon";
+			reg = <0x2c000 0x1000>;
+		};
+
 		icssg1_intc: interrupt-controller@20000 {
 			compatible = "ti,icssg-intc";
 			reg = <0x20000 0x2000>;
@@ -1499,6 +1509,11 @@ icssg2_mii_g_rt: mii-g-rt@33000 {
 			reg = <0x33000 0x1000>;
 		};
 
+		icssg2_pa_stats: pa-stats@2c000 {
+			compatible = "ti,pruss-pa-st", "syscon";
+			reg = <0x2c000 0x1000>;
+		};
+
 		icssg2_intc: interrupt-controller@20000 {
 			compatible = "ti,icssg-intc";
 			reg = <0x20000 0x2000>;
-- 
2.34.1


