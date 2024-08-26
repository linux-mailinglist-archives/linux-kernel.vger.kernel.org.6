Return-Path: <linux-kernel+bounces-301304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B661195EED4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E672B1C21C02
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476A6156222;
	Mon, 26 Aug 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GRLjEj7x"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084D14D703;
	Mon, 26 Aug 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669341; cv=none; b=GpMoStQfF16kSQ7PsuwMJFPa0O78NE4o/NcpqW/DVYS4ddj6cd5xYZ1B47m70hjcbCFLdoUyqOjqvrLjJ6zDix9SG6SDqwx3XZxztTENLZo0RxD5a3FXROK3iWRRZp1ZlVm0UAvQ9nEkNGaIcs91zuZLdUGs/DGaQz22ICEPX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669341; c=relaxed/simple;
	bh=aIL2oWrPrjLaPoiGVzDKDvyuQV1fI2YZfchQpXdKs8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjpuR6ermGMF6vOvluNmfw5EaVS2bJmOlovbUVRwIqXUv9n4FMwqnDjFrKaP6J8autldQ/2qVJcu7Y35ZZ2zrTIApDtKi3b02kBUlC18pVr54sxrtPKpEvsmo5i+yjOIzIPCFz8zEJH7qNCaokoZIWs2ED9MSNcN8AcL83FenE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GRLjEj7x; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAmqaW099105;
	Mon, 26 Aug 2024 05:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724669332;
	bh=O4JwcPxvT35aOuf+4PkLthF7Lh7BixPoJtAmC/Lu3m8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GRLjEj7xoaUh/LZXNaqxBLWrPy/QZ0xosknBDddN1FnKntjkZuTvMLOG0L9ISgW+q
	 eePpjBnOerqKgjebw31sB8+QokItC1pakcuQNu5Ps7o8gw0J7XENOMCYTiXspuHZeH
	 GsRG/eNZmFYflmkOy+9xtm/LuLkFLvPBRnhiJFco=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAmqYp037755
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 05:48:52 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:48:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:48:52 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAmLNp063606;
	Mon, 26 Aug 2024 05:48:48 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/7] arm64: dts: ti: k3-j784s4-evm: Change timer nodes status to reserved
Date: Mon, 26 Aug 2024 16:18:19 +0530
Message-ID: <20240826104821.1516344-7-b-padhi@ti.com>
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

	+===================+=============+
	|  Remoteproc node  | Timer Node  |
	+===================+=============+
	| main_r5fss0_core0 | main_timer4 |
	+-------------------+-------------+
	| main_r5fss0_core1 | main_timer5 |
	+-------------------+-------------+
	| main_r5fss1_core0 | main_timer6 |
	+-------------------+-------------+
	| main_r5fss1_core1 | main_timer7 |
	+-------------------+-------------+
	| main_r5fss2_core0 | main_timer8 |
	+-------------------+-------------+
	| main_r5fss2_core1 | main_timer9 |
	+-------------------+-------------+
	| c71_0             | main_timer0 |
	+-------------------+-------------+
	| c71_1             | main_timer1 |
	+-------------------+-------------+
	| c71_2             | main_timer2 |
	+-------------------+-------------+
	| c71_3             | main_timer3 |
	+-------------------+-------------+

Fixes: 833377cf858b ("arm64: dts: ti: k3-j784s4: Add general purpose timers")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 58d550a1ac17..473cb2833783 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -1166,6 +1166,47 @@ &main_r5fss2 {
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
+
+&main_timer6 {
+	status = "reserved";
+};
+
+&main_timer7 {
+	status = "reserved";
+};
+
+&main_timer8 {
+	status = "reserved";
+};
+
+&main_timer9 {
+	status = "reserved";
+};
+
 &main_r5fss0_core0 {
 	status = "okay";
 	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
-- 
2.34.1


