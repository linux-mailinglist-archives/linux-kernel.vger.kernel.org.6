Return-Path: <linux-kernel+bounces-301305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A4695EED6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29632284802
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870A6158DD9;
	Mon, 26 Aug 2024 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KURvXUEE"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8414F9ED;
	Mon, 26 Aug 2024 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669345; cv=none; b=fWDlnjLhVCDQEiylLdYEOPoSILO78BhOxkFeTtt2ay6tZG1QhlEYiGTViPAvewKzb53jig+YtnXECgDhQfGs6yjhBqHWOYe9zWh1CYC9ebZQW/86Tv6nun4vA/q/u9Dgv0rbjgjl0LrCrRy61aMgMFyIkimbqUGHXizdKuEDAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669345; c=relaxed/simple;
	bh=pLASDbteCh61vsuDWUj0Y1rz3Fw4M3Bxeie0cLF78Fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bi6zzIQgtVqj9xaMXHTesEVveNW8nl/9lIg5tTmNh+r0VLiK2rhNEHYBraKIrCVaLqPuJmGIkZOaghhZSIBmWMLTgdCueMbuVYmEg7LNwtzuUI9NI/ZICbLS5FkW3+QZC1m6Kp0Gxj33orRCiQ3xN9s9bLJYSR85raynulBK0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KURvXUEE; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAmut8099117;
	Mon, 26 Aug 2024 05:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724669336;
	bh=xmYG38GLdDBEl/y1K5ggrS7Wf5mFuoYFS1U4YsOYql4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KURvXUEEGK/9QiPTpZEw/57oQMNDjArS/N7aGFAHovatKh0tPCornW9ozmcnvdrE/
	 UeJ7XPpn0RFL8ECuHXX4oy8x6ADQq8y8Y3Gz4ViOMt6mK0DoU+TNnkTbiFJOm0bALQ
	 ebkbIKJQyyl4mRTY7+yb4JpgdezgO7LKSULp+8vo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAmu6V029757
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 05:48:56 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:48:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:48:56 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAmLNq063606;
	Mon, 26 Aug 2024 05:48:52 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/7] arm64: dts: ti: k3-am69-sk: Change timer nodes status to reserved
Date: Mon, 26 Aug 2024 16:18:20 +0530
Message-ID: <20240826104821.1516344-8-b-padhi@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index ad6570c51a68..1e36965a1403 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -987,6 +987,47 @@ &main_r5fss1 {
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
 &main_r5fss2 {
 	ti,cluster-mode = <0>;
 };
-- 
2.34.1


