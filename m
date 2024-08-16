Return-Path: <linux-kernel+bounces-289200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2395430D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C3228A32B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AE413C693;
	Fri, 16 Aug 2024 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CvlQtWYk"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F013AD03;
	Fri, 16 Aug 2024 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793996; cv=none; b=m6wTXjHXdev6uIlnI1FLGFKmu2wG8TyS76fmg7mJRdtTDYMbjE0ESVg79P/2EMauVXW29CzyB/K9i7VfCYyYjOWDwqIONuhF2mgs65IAwjJvQJUZU0khs0aAy8FJH/oVyHzgU2y3VL3TKl7U2AG6PSzM8nshchAUnkgPYrsOaI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793996; c=relaxed/simple;
	bh=O62YUlyRcczdeO+6CopmqatcVro+zAHmWIhiRLs2KzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmCnvijnFS1wVwy+ZqVX4u0EGsRwRBzSFrX0hboMqgamVSR+6ctna4k84qURQm16W9ES+/NLTa7V8x2NNeLI6S2Bx6oIc7BqwRZJUYaTpw9TDt89NQA657jJpAiCScvxQ8iBrc16QUGjc/0kYFqMx9x3WUCV1/Y5ALf2lB88cV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CvlQtWYk; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47G7dUoc017223;
	Fri, 16 Aug 2024 02:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723793971;
	bh=yGOPw6WsAO6f1G8VqYpCEGAQvt0AkeOr88hs62zEVrA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CvlQtWYkSShQJ0TO7LwyqfyUhXSPbAa6loSc4EG22WIwuOG99R5e5Jit3GO8rmsOx
	 kQvqYRlEsWZGKZ432xT7jFGZLcQCPzRvLq6L6JI0scpTiKbI2+AyT5u+hywc5lbQiU
	 QER23ilxY0fK1HZU3KyoKqmPVXU+4A4dVXzEvmPQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47G7dUCM024444
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Aug 2024 02:39:30 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Aug 2024 02:39:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Aug 2024 02:39:30 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47G7d9Tt084976;
	Fri, 16 Aug 2024 02:39:26 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/5] arm64: dts: ti: k3-j784s4: Change timer nodes status to reserved
Date: Fri, 16 Aug 2024 13:09:07 +0530
Message-ID: <20240816073908.2343650-5-b-padhi@ti.com>
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
index ffa38f41679d..5e8bea3a5d82 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -1050,6 +1050,47 @@ &main_cpsw1_port1 {
 	status = "okay";
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
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
-- 
2.34.1


