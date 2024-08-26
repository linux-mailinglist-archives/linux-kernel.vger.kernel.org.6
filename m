Return-Path: <linux-kernel+bounces-301301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508CC95EECE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E901F23230
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7F01547E0;
	Mon, 26 Aug 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UT6U9X4P"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66772153BF0;
	Mon, 26 Aug 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669329; cv=none; b=FBtKhSmwk8ojMADzZx7nCBtkmEfVJY6iU/VS8fmtQVjSyYIfFDeHbwW15GBovq6TtiLYVdklX6CgYcAaBOV8+qyS+msw6M9+GqCyLhrSMGugTxSOGRWgHZpwLES9ymSweGtAkBFyLes+k2L5zn8yfTrbhp6yuU+4jD2p/WXl7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669329; c=relaxed/simple;
	bh=NSc2DnV6+zDi0I+e5dU05x6FApqXMb1S5zEQ2LnuYdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaZyd0dW2eEHO7GJVareLSDemU5qBmxdUK+bXZy+DSsPwyaZ0MfPhFLcnFBhMKImqljPStV9/qLY4fo2oEIv1zA6jLrM820B3jqQhg7k609IVxpdSWm1P0aSG+EzO5fFoq6ME1sm5yWbegp9yaFN91IPt5/S9S7Iw9UjPCLwd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UT6U9X4P; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAmdQw099071;
	Mon, 26 Aug 2024 05:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724669319;
	bh=g8aPuBFQ3LtP1TgWrn+5LzqHHpaz5j5eFoHeipb3eLk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UT6U9X4P+UXWN6uRUgt2NUulykGjDhUuMupodYi/0hQfC0EhJNo7zUtCCD70lHRkW
	 2yM4d6kow1G1M+Iix98oxTWMXWdl0hEHphm321oMVFDNgy614w6s3iRw4/SbU5k1M2
	 bHH3eU/ns0FbSKdxanJatZSY6QE00Fszj242jZFk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAmded096927
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 05:48:39 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:48:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:48:39 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAmLNm063606;
	Mon, 26 Aug 2024 05:48:35 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/7] arm64: dts: ti: k3-j721e-sk: Change timer nodes status to reserved
Date: Mon, 26 Aug 2024 16:18:16 +0530
Message-ID: <20240826104821.1516344-4-b-padhi@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 1896218fe038..046267044e68 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -1319,6 +1319,35 @@ &main_r5fss1 {
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


