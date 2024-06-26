Return-Path: <linux-kernel+bounces-230490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7736917D92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D79A1F23FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD60179658;
	Wed, 26 Jun 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JjXtKRq+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B151779B7;
	Wed, 26 Jun 2024 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396969; cv=none; b=nN+ly/BjMY/A9ibZsc97P+XLFUvbyr3jBpPW3A6TQFAj9i1ma6z5jtabigARrA9ICUOZwqEMkcw4VDsf0kU7wdnw38O4FZ6nIYzyOHhAc0BpdzP5PMD7wvdSLV3JxXqp3uiV9JqrDlpV7ZJ2W9JsViXRnquN1tkK1bIi5D0lRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396969; c=relaxed/simple;
	bh=FlJBMKh6pYOgBkI3JanFh1HtuN0ra91QyvCdfw8LFlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEtmZ+6vIuz4osQvEMLCHdYmTzSla2Ryyr/rPIiXUSP48JbauI9NcjlXJ90JAcnZN+/49KpkgvQ779Odi4rSl4Vo0uuQqmM5h6nrEqZYKPKw494VzdpgygHxxMhHgg7WVrZplMlg3EPCDGFPv/vICOhE/OQn8/C49tEer8LJHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JjXtKRq+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45QAFoum102072;
	Wed, 26 Jun 2024 05:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719396950;
	bh=YmMi7eqXgj2Ayl0xxOQqOV1H5iE1uA0DZcl9PqL50IU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JjXtKRq+f1iilEjQurR8RXX30QhtEIq4twQLqfaSG2SJnqPoYEbPVAxSqM+EKlEwY
	 +ax7eMFjev6O1XQlITugvmu8O1zUkjPrF4trdvKXUchuPFN3u1AtEd2RttqIHE/r12
	 BJibhJ/WJFoqWoZkvnZTgyBePDc1KhrZu/M7LLFI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45QAFodL017583
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 05:15:50 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 05:15:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 05:15:49 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45QAFRVH091997;
	Wed, 26 Jun 2024 05:15:47 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Andrew
 Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>,
        Dhruva Gole
	<d-gole@ti.com>
Subject: [RFT][PATCH 2/2] arm64: dts: ti: k3-am62x-sk-common: Fix graph_child_address warns
Date: Wed, 26 Jun 2024 15:45:20 +0530
Message-ID: <20240626101520.1782320-3-d-gole@ti.com>
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

Fix the following warnings when compiling dtbs with W=1:

../arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi:343.10-353.6: Warning (graph_child_address): /bus@f0000/i2c@20000000/tps6598x@3f/connector/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
../arch/arm64/boot/dts/ti/k3-am62-main.dtsi:633.22-643.5: Warning (graph_child_address): /bus@f0000/dwc3-usb@f900000/usb@31000000: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index ce7ab338f468..465743d6cc21 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -340,15 +340,9 @@ connector {
 			self-powered;
 			data-role = "dual";
 			power-role = "sink";
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					usb_con_hs: endpoint {
-						remote-endpoint = <&usb0_hs_ep>;
-					};
+			port {
+				usb_con_hs: endpoint {
+					remote-endpoint = <&usb0_hs_ep>;
 				};
 			};
 		};
@@ -475,12 +469,9 @@ &usbss1 {
 
 &usb0 {
 	bootph-all;
-	#address-cells = <1>;
-	#size-cells = <0>;
 	usb-role-switch;
 
-	port@0 {
-		reg = <0>;
+	port {
 		usb0_hs_ep: endpoint {
 		    remote-endpoint = <&usb_con_hs>;
 	       };
-- 
2.34.1


