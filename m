Return-Path: <linux-kernel+bounces-276965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C4949A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14101C21973
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71842173328;
	Tue,  6 Aug 2024 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xV54bJ3o"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60D16A95E;
	Tue,  6 Aug 2024 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980774; cv=none; b=jTGD6Pk95ZKJJvEw4HrvsZK+OlBDHiVpZeuRkDTjFbV6EIx0jFEPkifxXtHFHJU3tF4VlEkE/nOVJTO8qSuVdzIPmey/2J1ig73n2FMOW9oah6T9O+Aa2CIx/m9rjm8u6reH1SP0A8DjqyzcrTkVz4mTyE1Bir3qzGjr6psCwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980774; c=relaxed/simple;
	bh=vZkilVzINRaIjnOXx2y29qnuNmaUzvWwwHDZng40P4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4bSZLw2oWxICFnSeUGxIKbA9UGKmH21SrJ85CCE/heVJpeVofTMjqxMlQijAjATZs/DEFT0s75vPmzmH00wSM1j7wGK7VpoR1yukz18Z+bQRB20fJNfza458XFkGInZUgR9iqBlJTRGQmRHJAehyxdAWqN2NK11HxpqcaFzaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xV54bJ3o; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk54P067926;
	Tue, 6 Aug 2024 16:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722980765;
	bh=VoXJXQcJV7Re4fAExDOATPu6iKn/YKxo8g7m6jRTkaY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xV54bJ3o4YQBypTYWJYle52Hf2d7WCa1RIZ9LtfVli4CAq/SQRfqnrUfZvm1NATHT
	 oZos09+XhWYhIcgPz3lq8FVEQFNCMl9/EVw3EO39J7Zy+IPAUBgb/W9koRd1Y2vUqq
	 u4jaRA3U3e9IjjwGhXGdvf6netg4N9+jKPUfSaAw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476Lk5nM126307
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 16:46:05 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 16:46:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 16:46:05 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5Qt100327;
	Tue, 6 Aug 2024 16:46:05 -0500
From: Judith Mendez <jm@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Santhosh Kumar <s-k6@ti.com>,
        Bryan Brattlof
	<bb@ti.com>
Subject: [PATCH 4/5] arm64: dts: ti: k3-am6*: Add comment for ESM interrupt sources
Date: Tue, 6 Aug 2024 16:46:03 -0500
Message-ID: <20240806214605.3379881-5-jm@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806214605.3379881-1-jm@ti.com>
References: <20240806214605.3379881-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

For all am6* devices, add comment to clarify which interrupt sources
are routed to ESM0.

There is no functional change.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi               | 1 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi              | 1 +
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 328929c740dc0..5b92aef5b284b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -241,6 +241,7 @@ main_esm: esm@420000 {
 		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
+		/* Interrupt sources: rti0, rti1, rti15, wrti0, rti2, rti3 */
 		ti,esm-pins = <160>, <161>, <162>, <163>, <177>, <178>;
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index fb5a3006e20ac..2c04c1cc99c17 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -268,6 +268,7 @@ main_pmx0: pinctrl@f4000 {
 	main_esm: esm@420000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x0 0x420000 0x0 0x1000>;
+		/* Interrupt sources: rti0, rti1, wrti0, rti4, rti2, rti3 */
 		ti,esm-pins = <192>, <193>, <195>, <204>, <209>, <210>;
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index dc401290f13dd..7941aab09cf72 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -260,6 +260,7 @@ main_pmx0: pinctrl@f4000 {
 	main_esm: esm@420000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
+		/* Interrupt sources: rti0, rti1, wrti0 rti2, rti3, rti15 */
 		ti,esm-pins = <224>, <225>, <227>, <241>, <242>, <248>;
 		bootph-pre-ram;
 	};
diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index f8370dd033502..331cb01d80ce2 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -389,6 +389,7 @@ main_esm: esm@420000 {
 		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
+		/* Interrupt sources: rti0, rti1 */
 		ti,esm-pins = <160>, <161>;
 	};
 
-- 
2.45.2


