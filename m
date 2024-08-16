Return-Path: <linux-kernel+bounces-289197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E34E954306
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D66B28BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2213790B;
	Fri, 16 Aug 2024 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m/3o96g7"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA79136E21;
	Fri, 16 Aug 2024 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793973; cv=none; b=cvwyka4xw0JT1xChNUCm3RuJVOJ97yZnoMgXQ6wxggy+iNhAGRsBTyqkfmLXSL+vCO1I1UVrle7cgqOVnsawubrANbdstyeLgzjh/W3yOvYlqnQ+DcYsV6VeNbezjK3OTxr3jjv8TtjebanOWOre0GulefkWoCep3/GZtNt8tn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793973; c=relaxed/simple;
	bh=vlLVEFCYrkan9OGIG4GYlGRfdxAs+gK0cozurTMmJH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=famHyOVL02P/Uo3FykpB3mnV0whq9kbksu8DT4hvOBUn7QnUiMzNl+wBDLQ7FedvY64XzTKZfiErMyp/cEH36K6IJWqD0rYgCxruUXaBwDWGwQfbb8c3RkQBCiYjQy0KGMcXGlUruakT/fcbdkaSeVVyqaV6cLoKGygnwnOqR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m/3o96g7; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47G7dMJs088228;
	Fri, 16 Aug 2024 02:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723793962;
	bh=7AgN39oD2b0wFWm/rsGlCvjVfq3NUmttMg8p0ZWK9uc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=m/3o96g7JHq1KoJ+9sN+XF+3olIzUIX2UXdI2swO6BgJVPpNQvBS7bsPA0pPZFLTM
	 VUBz/Jyjs3VzJpe/1eYEQnZ0Rfj5+9VmDlwaQulQHKqCGxMx4CBNz1nvys6hXXEHxO
	 2rjImu3WlNjrklyXOsHVddyeaMELEYoaX47+stgM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47G7dMhL098514
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Aug 2024 02:39:22 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Aug 2024 02:39:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Aug 2024 02:39:21 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47G7d9Tr084976;
	Fri, 16 Aug 2024 02:39:18 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/5] arm64: dts: ti: k3-j721e: Change timer nodes status to reserved
Date: Fri, 16 Aug 2024 13:09:05 +0530
Message-ID: <20240816073908.2343650-3-b-padhi@ti.com>
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
 .../dts/ti/k3-j721e-common-proc-board.dts     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8230d53cd696..d7969122afd8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -974,3 +974,32 @@ &main_mcan2 {
 	pinctrl-0 = <&main_mcan2_pins_default>;
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
-- 
2.34.1


