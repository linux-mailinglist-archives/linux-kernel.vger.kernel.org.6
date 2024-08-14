Return-Path: <linux-kernel+bounces-286294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5273951931
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D85B22270
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E091B012D;
	Wed, 14 Aug 2024 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qSWCjYNz"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBE1AED5B;
	Wed, 14 Aug 2024 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632152; cv=none; b=H9271bSrK4FRglDV+poZU/Ax+QTgHk+3c8uEZtYWpp0igttVxy3yX4SDfAl0oKQMuNVIhs22uIpnzKkXyijrjwvHpumkNAXTqSs4+cEdpPYBwCEsJuciePieDd5MjpQkXo9wMoWFzyQ4ziqvKUAFyGGG3w5iuSa4QUZ0jl5RUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632152; c=relaxed/simple;
	bh=y3mRYQdG268tb3VRbfYjDdS6miHTpj+jitRVrVym8R4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOPmStfTCYkm/Gf+quOcISxiI1ltUx+mMOgDuS8pnZ9if6QokX9PjEP6NHvuB/p28d3ol/RF5Uq01I4/UPszwTpfRPwUtGgROUbC5KqNkvDqt+PdImEzdyGe4OTw3DXAblHa47BpSi3luVQrjj1MzZzg4O+indVsmagR53YToPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qSWCjYNz; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EAgCtK019279;
	Wed, 14 Aug 2024 05:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723632132;
	bh=+BYpbN8WtiT7058vSDLH1IlCHY7lDsbqZV4X04Bo9Do=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qSWCjYNzHMssNNT1O8GqNEO76jxJ7Kj0KPEyC3vGLCVAND2peXi6DqM0xwkjg4xBJ
	 LhlddfQSlLy7SxcTXSL9ifn45fDErKjcvi6EgynWEhN8WfVO3AG+voNPlgcMPM0Cev
	 fSlf2jobz2qKPMtIJl8IhVPt50vmTayoLkmnuOb8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EAgC2U048732
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 05:42:12 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 05:42:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 05:42:11 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EAfpSj068615;
	Wed, 14 Aug 2024 05:42:08 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <g-vlaev@ti.com>, <afd@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] arm64: dts: ti: k3-j784s4: Change timer nodes status to reserved
Date: Wed, 14 Aug 2024 16:11:50 +0530
Message-ID: <20240814104151.2038457-5-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814104151.2038457-1-b-padhi@ti.com>
References: <20240814104151.2038457-1-b-padhi@ti.com>
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

This change is already incorporated for timer nodes in the MCU voltage
domain.

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


