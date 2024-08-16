Return-Path: <linux-kernel+bounces-289198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01489954309
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D050B28ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985B4136E21;
	Fri, 16 Aug 2024 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IkwP3QMT"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBD1386A7;
	Fri, 16 Aug 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793975; cv=none; b=t5/ogU0zDCIBGlakVPK8gOBtEUosq9oeSPuZoIysYgthtboA74PUpNjO0/1CMxFPhUECKGvlVgeRFnQWu9Vx/KTmlZ5kN6B5p6KdzaMZyAcb6w/0Ow19zqSQKvgUd/xyCLjP+kF5el/rIb1txGIHvnoIkVKKAlBmz2P1i1W85Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793975; c=relaxed/simple;
	bh=lHMZdc+KRx/0LQTVbRFd4EOO3LoY1ixV0zK4UI/FQC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pt+ecQrLNPp0CZxSBCIGciSqPzSmrSUv9O1qIo0/qSs+lIDOKOAgeyaFmEqv62p2k09efIS1p6+SracrRbcWGvxp7RP8sj8LznVm310zCqkBEGHmKu90vf/ALyQNZFN4H8jOeQwm7/Hqxaigzy77fRAUtaBGpOBz6WypTY3AhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IkwP3QMT; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47G7dQDn088240;
	Fri, 16 Aug 2024 02:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723793966;
	bh=AY1qGY5Nf63AJeh+DQ4CjAAoAH79JC8Jd1G+MwEZny8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=IkwP3QMTCQdlvsQu3JXwCkwHIWI8DDBtsMoH9m0HZjme9iqE354l+TNaXLw1LI6Lp
	 phnySYlMaTtpe4eMSoz6IbSPbzGQ9XoZPR1pOfeIOHySyygKmcfzoLM2nE5SgFqCdL
	 fjQLO1ogzdZ51cY4lwIVHwCZzJJT0c5l4YYwMFHk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47G7dQeG094465
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Aug 2024 02:39:26 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Aug 2024 02:39:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Aug 2024 02:39:26 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47G7d9Ts084976;
	Fri, 16 Aug 2024 02:39:22 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/5] arm64: dts: ti: k3-j721s2: Change timer nodes status to reserved
Date: Fri, 16 Aug 2024 13:09:06 +0530
Message-ID: <20240816073908.2343650-4-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816073908.2343650-1-b-padhi@ti.com>
References: <20240816073908.2343650-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
use timers. Therefore, change the status of the timer nodes to
"reserved" to avoid any clash. Usage is described as below:

	+===================+=============+
	|  Remoteproc node  | Timer Node  |
	+===================+=============+
	| main_r5fss0_core0 | main_timer2 |
	+-------------------+-------------+
	| main_r5fss0_core1 | main_timer3 |
	+-------------------+-------------+
	| main_r5fss1_core0 | main_timer4 |
	+-------------------+-------------+
	| main_r5fss1_core1 | main_timer5 |
	+-------------------+-------------+
	| c71_0             | main_timer0 |
	+-------------------+-------------+
	| c71_1             | main_timer1 |
	+-------------------+-------------+

Fixes: 835d04422f9d ("arm64: dts: ti: k3-j721s2: Add general purpose timers")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index c5a0b7cbb14f..2903e15b8d3b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -525,3 +525,28 @@ &main_mcan5 {
 	pinctrl-0 = <&main_mcan5_pins_default>;
 	phys = <&transceiver4>;
 };
+
+/* Timers are used by Remoteproc firmware */
+&main_timer0 {
+	status = "reserved";
+};
+
+&main_timer1 {
+	status = "reserved";
+};
+
+&main_timer2 {
+	status = "reserved";
+};
+
+&main_timer3 {
+	status = "reserved";
+};
+
+&main_timer4 {
+	status = "reserved";
+};
+
+&main_timer5 {
+	status = "reserved";
+};
-- 
2.34.1


