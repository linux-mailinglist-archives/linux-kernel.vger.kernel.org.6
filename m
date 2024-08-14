Return-Path: <linux-kernel+bounces-286290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AEC95192B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906631F259C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19D51AE87F;
	Wed, 14 Aug 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HD7fxiN4"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DF481A7;
	Wed, 14 Aug 2024 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632142; cv=none; b=gz1p86t2P5l1MfZUouVgCfeg9dF51yXL8hTbhKxxQv3VHQYgj2hVA4iJKzdUkkaOjB6R4VS4v/oihLvN8pHjMIDrN3CbfgBTTMuN/hF4YjgtIcqlqzfM3O0bUIC6op53n5x0ZbLmQIbI+uAo+CoVbTbW33lTIcs+MJWkltdPz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632142; c=relaxed/simple;
	bh=S3Nko8u1oVou+S8QPM7X2ps6cSH+ssQo0YQ9Z+dUCs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CItPyQf3eyYpis8TcWKV9UdLpbgFT5/QYfSozLrWSMg/W7ZHOyzMv9WRt33SkR/YeTaVwHkWPEaq4nAMlHi+PvwjUgN+4FkC4ePvlxvVGBK2sfKFRu1E1i/eFNmmp/oJXWvg7H+pp2Pq2LdEhipk13rUmHLAWdo5NkQTmt7dIyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HD7fxiN4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EAg4VV084416;
	Wed, 14 Aug 2024 05:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723632124;
	bh=PhLUo6CQlo8ZU4OKtc3VsIn8fbXsb/I6cHY9nikdreU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HD7fxiN48No49s4DM6RM9nXryw9NK8BH+sp8tfaBsx15LqtDVy/X3oqcb0J+wR0Rp
	 62idEmHJVOdOB8u9oe9bAuiEA0fDr+3528mMkfj75b81Ogko2DHDrLg3HHD7EXGI+1
	 6mokKZ+nh3iYlc6GZ/mhiH27GKBle7Gq2nnrFavw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EAg47p089931
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 05:42:04 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 05:42:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 05:42:03 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EAfpSh068615;
	Wed, 14 Aug 2024 05:42:00 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <g-vlaev@ti.com>, <afd@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] arm64: dts: ti: k3-j721e: Change timer nodes status to reserved
Date: Wed, 14 Aug 2024 16:11:48 +0530
Message-ID: <20240814104151.2038457-3-b-padhi@ti.com>
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

This change is already incorporated for timer nodes in the MCU voltage
domain.

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


