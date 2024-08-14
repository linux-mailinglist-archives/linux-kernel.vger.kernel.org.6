Return-Path: <linux-kernel+bounces-286289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994CC951929
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55584281AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E421AE863;
	Wed, 14 Aug 2024 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="up4v5HTR"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214311AE843;
	Wed, 14 Aug 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632140; cv=none; b=WZz2+/uFYA3G3VjhTisuGmT/0zb7p1NbcM+vBWchCSJlip90EG0TxP7fkSFNcuwL55+Mirf558F5AitCAr4OZFMmoqBgUM9K6ObDRLyK3YleZ8ryj5P13m6/xq6yU+nSsJdZDXjKyoXw/eBrZ1ct7D3SSpJEzh/fRp9YeADXvdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632140; c=relaxed/simple;
	bh=fl9Q5bu/1MLPVBIHutKPWctrG6Vsh6iY4lcCaDCZczg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mviebSXNlGZ+OydaXz8yv+N2cWfZkxpiPWFxjubL8on9/FRzlvlqC/stSw4LhcJjduQ2nv6Uv3dIP4LuZGVZOo194dhtW+4yPUDra4H0fJQvQBavDcj8ecxgs8+3bj6EMEBZNmD/INbptwH1cP2SDLHmh2q4uFE2DKt4a8nIBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=up4v5HTR; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EAg0FG074553;
	Wed, 14 Aug 2024 05:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723632120;
	bh=1qu3WeKeZTpdm0zyHEtC817Z7ZTFdbNTlpklA+4jdm4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=up4v5HTRoRwPiyqgKcsQGi7wOlZK0ik1Wu1i5S3/O2RlhS+nI+NzpmHdOaMrML/mH
	 BhhJRpLa2G0v/vci+1dI9BReNEeJpYl7eAqu0b7ZmtFgAaC7VWXVB9CZjgo0UuX13O
	 OBdtykEX3tNrHg8eM4F9oCoDVUyZGFJrplFVg4hY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EAg0m6007000
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 05:42:00 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 05:41:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 05:41:59 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EAfpSg068615;
	Wed, 14 Aug 2024 05:41:56 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <g-vlaev@ti.com>, <afd@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] arm64: dts: ti: k3-j7200: Change timer nodes status to reserved
Date: Wed, 14 Aug 2024 16:11:47 +0530
Message-ID: <20240814104151.2038457-2-b-padhi@ti.com>
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

	+===================+==========================+
	|  Remoteproc node  |        Timer Node        |
	+===================+==========================+
	| main_r5fss0_core0 | main_timer0, main_timer2 |
	+-------------------+--------------------------+
	| main_r5fss0_core1 | main_timer1              |
	+-------------------+--------------------------+

This change is already incorporated for timer nodes in the MCU voltage
domain.

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


