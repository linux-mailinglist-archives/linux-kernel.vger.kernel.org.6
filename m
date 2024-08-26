Return-Path: <linux-kernel+bounces-301299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0735B95EECA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387D91C21BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A735914EC4B;
	Mon, 26 Aug 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ttaxepsh"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6AFF4EE;
	Mon, 26 Aug 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669325; cv=none; b=CZOm1iHSGs1y27cAYa8MRzZTdY2maWtVBL2TUDcqKxqTmyDHui5tl7wyO9PE5vB4FUT1q1Ey3OC1lbLSTtoDZjp0g71ZV0v+O2y4j7flu13rEH2RUYQffTTJu55lr4EzZZvnTndpxdVpePdYWeaYbmh2/6HJQWa4cUs4WL7BtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669325; c=relaxed/simple;
	bh=GB6eulxez6V5TMN2q2hC3ptKedsrSIY3vn4Ht2RXUug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhBiLIf3pqqOkbDxT8AAaEG6aphUz+PRF+zTtdTJSLND9XVyglX+mzJi1Cz4l5ZO7sWf+iAkdj7DKMAaSk46lhwzOFFBwCzhdbItFZ177SRXBFtHGn9pZzm0dvdaE00+Og5oZQsAmlBY0zgTf1l/mQmopTf5NrVOIDYZil+RZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ttaxepsh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAmZip008315;
	Mon, 26 Aug 2024 05:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724669315;
	bh=Akn53RUNbkj0HL8wC4L6cHyehxL78VUermPc38Z3rac=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TtaxepshoEs/heg+ilbLxDSgDneCYClOdBivWAtP6tr2/uRtPk1Fv+6shi30fwRaC
	 B4jUmNIfGBhXuk8japyT2JlmEHg7uEA3AZOh3baPNbtNlOZRtd39M2dY8Pf3IwUqpw
	 Y9y+UnaHH2xtkyuuPMJXS3oMtkXj9MrogVh59nEE=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAmZr9029591
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 05:48:35 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:48:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:48:34 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAmLNl063606;
	Mon, 26 Aug 2024 05:48:30 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/7] arm64: dts: ti: k3-j721e-som-p0: Change timer nodes status to reserved
Date: Mon, 26 Aug 2024 16:18:15 +0530
Message-ID: <20240826104821.1516344-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826104821.1516344-1-b-padhi@ti.com>
References: <20240826104821.1516344-1-b-padhi@ti.com>
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

	+===================+==============+
	|  Remoteproc node  |  Timer Node  |
	+===================+==============+
	| main_r5fss0_core0 | main_timer12 |
	+-------------------+--------------+
	| main_r5fss0_core1 | main_timer13 |
	+-------------------+--------------+
	| main_r5fss1_core0 | main_timer14 |
	+-------------------+--------------+
	| main_r5fss1_core1 | main_timer15 |
	+-------------------+--------------+
	| c66_0             | main_timer0  |
	+-------------------+--------------+
	| c66_1             | main_timer1  |
	+-------------------+--------------+
	| c71_0             | main_timer2  |
	+-------------------+--------------+

Fixes: 7f209dd1267c ("arm64: dts: ti: k3-j721e: Add general purpose timers")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index cf606846e341..cef47c67493f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -569,6 +569,35 @@ &main_r5fss1 {
 	ti,cluster-mode = <0>;
 };
 
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
+&main_timer12 {
+	status = "reserved";
+};
+
+&main_timer13 {
+	status = "reserved";
+};
+
+&main_timer14 {
+	status = "reserved";
+};
+
+&main_timer15 {
+	status = "reserved";
+};
+
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-- 
2.34.1


