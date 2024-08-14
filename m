Return-Path: <linux-kernel+bounces-286292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDA395192E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093EF284D74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C9A1AED4E;
	Wed, 14 Aug 2024 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QxSVyaWC"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F151AE048;
	Wed, 14 Aug 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632149; cv=none; b=TetjAKa5Z11rsUJWoZz/jE3pk52J+x9tTrMuBDg7gMCfPQ3c1xiINc+hkYQQYeFNhpBDq/I9xta4CURxk2lkL2GHOYpFMYygkk3Mq1oF5a0oNEbV6wPRmjOHpZqQi04CbcRmZBFlwcArvxwolGpztXrBU/HZV67DvPR6Fy9EOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632149; c=relaxed/simple;
	bh=C8WnAcz83hFNlBFhkUGz5m34pbX8e39cuLLOBSzcI6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJbaduPKvmGmb3hCY0VD6gFS3mTH2t1JstTJdVTNxNGRn0FDR9AyNE/+OrllH87USOfdD5KPq4yYcAHMVGu9tDyOdJiLfnpfuvktQUQb7/rEUM3VZXoYk+UqFJG7/hwi1BlU6kOmJtkS80sfFxkPyVnSOTkzHrXaYqLPHHR3ntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QxSVyaWC; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EAg8hn128326;
	Wed, 14 Aug 2024 05:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723632128;
	bh=HPDEKyzcF/RnzZd1CjtFNprG+yMkErDcU4W6UoSHQfE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QxSVyaWCf0KKM8OfX04wQ1xVkbC4l/ymhX4L2R9bDXM35msRfoePKLjLDGpOpCe5h
	 UtZ10AxANwSsUak88kF0bbNzoi5Bsn+5hkmqR5ArMTvH0AXorqYs/iuQz2Yvp7kRno
	 QhDPNQdXjKhxN7yZp3fDVyViQNsaokuBpCxe+/Ew=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EAg8vi048706
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 05:42:08 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 05:42:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 05:42:07 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EAfpSi068615;
	Wed, 14 Aug 2024 05:42:04 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <g-vlaev@ti.com>, <afd@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] arm64: dts: ti: k3-j721s2: Change timer nodes status to reserved
Date: Wed, 14 Aug 2024 16:11:49 +0530
Message-ID: <20240814104151.2038457-4-b-padhi@ti.com>
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

This change is already incorporated for timer nodes in the MCU voltage
domain.

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


