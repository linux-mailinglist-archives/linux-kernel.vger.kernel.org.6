Return-Path: <linux-kernel+bounces-230489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A07917D90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309701C2119C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D632176AD3;
	Wed, 26 Jun 2024 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ok2AXpCD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9017C21B;
	Wed, 26 Jun 2024 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396950; cv=none; b=f7UwpDOADuvyGaQ4FUTY+9Wg/0sjQkVXSzU14efRmbrAdtADIwpr99hw7PFO1jd69Iq8ykAIwKVzqUuuz3B7y3gRo3heXoGw9zbBUclPamZ+4W/kr7cDn2KU5UEO6pittlXw4OeOGJ6bTIJH05yeMDs+ltSeEkUY4i8qdnUBhD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396950; c=relaxed/simple;
	bh=AgDVhgILAvQMimvjxKmLKt6jg1wvfEYWN7QdlmBb6OQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5URo++4ejcp3KgW5xNa7JpMs7ohPosA0of35h6gvKQxBfyP0hVAGqsMByjtZq7XrCh1DKyDsBsivz2iuxxy2LWeRvZPo7ODtn4Tt/LudXFgttO2dbPeqEb8dZSjwuJa4QiPLqpDPMU07X4C65grpWax5Ah5qymFCeFA2ywXOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ok2AXpCD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45QAFh5F102661;
	Wed, 26 Jun 2024 05:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719396943;
	bh=6Bvy8KIl5AdX7NQR1rPBA3pvF17ql30TAszzHjX2eO0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ok2AXpCDHlb5GHL5OQN/PsgaLN5gbMDkoLFGl6tfG+gvFjotY8b7I6dYeGJwzh4fO
	 vt3KldtgdRifVrFqhIClyUxjQPv5V13EBW1590BmVlrkthRy4goohXYubQsJlK1rVP
	 JFQ5CUtGYWtP4yvvPsHtTCeWIZer73azaXKKyD3A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45QAFhkJ012115
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 05:15:43 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 05:15:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 05:15:42 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45QAFRVG091997;
	Wed, 26 Jun 2024 05:15:40 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Andrew
 Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>,
        Dhruva Gole
	<d-gole@ti.com>
Subject: [RFT][PATCH 1/2] arm64: dts: ti: k3-am62p5-sk: fix graph_child_address warnings
Date: Wed, 26 Jun 2024 15:45:19 +0530
Message-ID: <20240626101520.1782320-2-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626101520.1782320-1-d-gole@ti.com>
References: <20240626101520.1782320-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix the following warnings that are thrown when building dtbs with W=1:

../arch/arm64/boot/dts/ti/k3-am62p5-sk.dts:367.10-376.6: Warning (graph_child_address): /bus@f0000/i2c@20000000/usb-power-controller@3f/connector/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
../arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi:647.22-657.5: Warning (graph_child_address): /bus@f0000/usb@f900000/usb@31000000: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
  also defined at ../arch/arm64/boot/dts/ti/k3-am62p5-sk.dts:517.7-528.3

Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index fb980d46e304..ff65955551a3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -364,14 +364,9 @@ connector {
 			self-powered;
 			data-role = "dual";
 			power-role = "sink";
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				port@0 {
-					reg = <0>;
-					usb_con_hs: endpoint {
-						remote-endpoint = <&usb0_hs_ep>;
-					};
+			port {
+				usb_con_hs: endpoint {
+				remote-endpoint = <&usb0_hs_ep>;
 				};
 			};
 		};
@@ -516,11 +511,8 @@ &usbss1 {
 
 &usb0 {
 	usb-role-switch;
-	#address-cells = <1>;
-	#size-cells = <0>;
 
-	port@0 {
-		reg = <0>;
+	port {
 		usb0_hs_ep: endpoint {
 			remote-endpoint = <&usb_con_hs>;
 		};
-- 
2.34.1


