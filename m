Return-Path: <linux-kernel+bounces-289196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5303954303
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF20B28A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5000312E1CD;
	Fri, 16 Aug 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JGsk3JhS"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A712C80F;
	Fri, 16 Aug 2024 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793968; cv=none; b=JwcheM+Jp2D9+WjaZS86U8Rv626MEpG4EciqI1cC741Q1P9pA7NMtE4PwW229YftpRx6qc71nojIqzINbiofJKfwXRNp246iEroyv94b2jyLJeFo7S3tDyQpYz1g5IWOiKXckXz6aq28GIoTaWC8JAfiQo3VT0APU3gAsTsXLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793968; c=relaxed/simple;
	bh=oWqkbK/8xwVOUYMKMbTNvgOMx/svcAmfwC8nZIS9OPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqGxgMHLNB6cI9DV6O/BB5tR1+b99ESaVsIpsOAJh71WyrbjSbCpm2OZaRj0tOtXJs1wIJDEqesedCFM8OKbBbU/dlBmK/xpVHepEkrL8w//HPHDkCbGbtuLvFe1j3/6bATN0qWvyJ1RNjIdIeHS9ZM7xJu7r7TwmBcNO4uesCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JGsk3JhS; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47G7dIhM088205;
	Fri, 16 Aug 2024 02:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723793958;
	bh=rBZue0gLGBBh9GeTPnZgvEPBeabFtabEimcgv5F3PBE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JGsk3JhSWsB/a85l9/OHN5F426SgDZJR6/T+yf5RRJFAGAyc28Pw7jEUBGRAQh1fC
	 Isz6sIlbXzlTsZpDs5muJnJP0OsLhPL2RRLh4Lr1yxoB8dwNJxVyN29twuuJEDjz2l
	 Y1OKdKPEgmwaoMUv1CleDiLAVvYiAprf6unMHj2c=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47G7dH5L024166
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Aug 2024 02:39:17 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Aug 2024 02:39:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Aug 2024 02:39:17 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47G7d9Tq084976;
	Fri, 16 Aug 2024 02:39:13 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/5] arm64: dts: ti: k3-j7200: Change timer nodes status to reserved
Date: Fri, 16 Aug 2024 13:09:04 +0530
Message-ID: <20240816073908.2343650-2-b-padhi@ti.com>
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

The remoteproc firmware of R5F in the MAIN voltage domain use timers.
Therefore, change the status of the timer nodes to "reserved" to avoid
any clash. Usage is described as below:

	+===================+==========================+
	|  Remoteproc node  |        Timer Node        |
	+===================+==========================+
	| main_r5fss0_core0 | main_timer0, main_timer2 |
	+-------------------+--------------------------+
	| main_r5fss0_core1 | main_timer1              |
	+-------------------+--------------------------+

Fixes: c8a28ed4837c ("arm64: dts: ti: k3-j7200: Add general purpose timers")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 .../boot/dts/ti/k3-j7200-common-proc-board.dts      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 6593c5da82c0..a65066bd7f09 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -471,3 +471,16 @@ &main_mcan3 {
 	pinctrl-0 = <&main_mcan3_pins_default>;
 	phys = <&transceiver3>;
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
-- 
2.34.1


