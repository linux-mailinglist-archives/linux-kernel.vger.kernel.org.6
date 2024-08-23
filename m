Return-Path: <linux-kernel+bounces-299691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAC895D8BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778A6283A20
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432641C86E7;
	Fri, 23 Aug 2024 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SrT0Ae7t"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721E191F8F;
	Fri, 23 Aug 2024 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450091; cv=none; b=sHjbL3DyYcvlcMNqw5C53VVLO4BY7fz84yJVNIx2gx/RZSMosCzepIPH3S2hJgiTJngQcSuAK3Qabop7KWUFITkqlQaFOYjhtfcoZhBpwGwcKi5iVxVVAisns6Faq1Zvyt2XvDOepfTt/pRpiZhi8cEKHMC6uQ7zOgy7KKzFijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450091; c=relaxed/simple;
	bh=Pl9OXYAK1LBcKVqUghKt18XrUqJPjyCzc7kXzcTPd1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B4urqoeYdVjiIn5H7OyFqIZsex7Mkd/Ruws1ByaFMJyEAoUg230kAdMtpR357Pb1HM1ST7mIr8TI73d7PYLBrN4FbnzrDSe7P4koU3sr8HBgeB+6swmRb3dYQw9Xsab6XexTCvPbtw9lICtwmyBt5ydxVat1Hg7uwC206GdrABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SrT0Ae7t; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47NLsa9B036079;
	Fri, 23 Aug 2024 16:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724450076;
	bh=arpxxihKVUcAGfTOh8obCEy4dkkRpYlvJltGKpb0chw=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=SrT0Ae7tc4k3EhLrG/LXGMj7/GyYbD0w4KEIJcBxqBl7GWM7OO3reFtfOAnG0wolb
	 G5B/R1+cQFcUg/bZ5y6gw9KYCzf++oq5bS+xJlGy2Uv2JDos+Z2lIG7kI76Ew5KXvC
	 HRmk/M/bge+esRrt+C4GUQ2lcAJX1AOz0Z3yVXiQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47NLsagt058876
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Aug 2024 16:54:36 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Aug 2024 16:54:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Aug 2024 16:54:36 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47NLsa7U112986;
	Fri, 23 Aug 2024 16:54:36 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 23 Aug 2024 16:54:29 -0500
Subject: [PATCH v2 2/4] arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240823-opp-v2-2-e2f67b37c299@ti.com>
References: <20240823-opp-v2-0-e2f67b37c299@ti.com>
In-Reply-To: <20240823-opp-v2-0-e2f67b37c299@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=bb@ti.com;
 h=from:subject:message-id; bh=Pl9OXYAK1LBcKVqUghKt18XrUqJPjyCzc7kXzcTPd1Q=;
 b=owNCWmg5MUFZJlNZc7dMTgAAb3/////5/6X7HTf2tbyw1f//+y/n3n9fGEJv9/4N9953rW6wA
 RsZo4JoDI0GmmTQAGho0aaGCAMmgBoA0ADQ00aAZBiGgxMJkDQPSbSMRkaaeUQaND1PUaBoaaNG
 hoNGmgAaPUANNANANMmg0aAPSBkaaaA0B6m1GgBo0/VD9U09QaANDtQ9TTJ6TRkYjE0GmgNNGgw
 jCANDQBoZAMhoaMTQMmQDQDRo0yaNNAaAD1GJoBBJXoyvEq4iOCXj5+lZGIrlEYZSYOhjSI4Rfy
 1ZQPAG2rx59vUcCKclXs6OlEqnzC62yIkGNlErEJctsmjr4BP8QaY5SsR2rFzbqgXO3xVtxQi+Q
 fxtPpSswGIzG71ypeJKnStLNI9uRkI4jEZQxoVLhfYUjezFsbvlXqOybHJa8M7TEJ1Odr4ZZ9XZ
 FXUMMdotEZ59OXMOSJqGhGiuWMNm7gnmBrDzCOpDq2sflh8YBkrihgWIDljAAc8GdKNPZQ3bO29
 pgGv3YP61PpzeSByfUshdQAXFvXhkQP4RKonAwIS/hd5GEjYIww36xcrOk94g6Vi06f4fPgXbxJ
 pcVAT+RB0hRWD0XBEpcdhkJhm+BWmLjFgdHNTRh0MKNsJCEBanIKBFjU5EHvRh4jpOUfwAlZs3s
 AecK6/e6D0RIQU1GXgf+LuSKcKEg526YnA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The AM62Ax reference board is capable of supplying 0v85 to the VDD_CORE
which allows the Cortex-A53s to operate at 1.4GHz according to chapter
7.5 of the SoC's data sheet[0]. Append the 1.4Ghz entry to the OPP table
to enable this OPP

[0] https://www.ti.com/lit/ds/symlink/am62a3.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 67faf46d7a35a..a6f0d87a50d8a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -68,6 +68,15 @@ wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
 		};
 	};
 
+	opp-table {
+		/* Requires VDD_CORE at 0v85 */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
 	vmain_pd: regulator-0 {
 		/* TPS25750 PD CONTROLLER OUTPUT */
 		compatible = "regulator-fixed";

-- 
2.45.2


