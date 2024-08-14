Return-Path: <linux-kernel+bounces-286295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C8D951933
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9063C28202F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257C11B1409;
	Wed, 14 Aug 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vdTHWu7s"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30F31B0113;
	Wed, 14 Aug 2024 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632153; cv=none; b=q5BV+s0oJRqdBSqtqcLX+Xy6Ndd4G49q1qXS6wQbNcliLsh5+hfkGmsgzzYeDLrLpQ4Vq17t9WkqtctqXqTJFzew7ml/zk5aunHc4ckmkPoNeeTtHNhZIfikVf+3UGuJMjTQ6itdyvB9lL4sEEg+g8egVlAgigKC3a11Njte8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632153; c=relaxed/simple;
	bh=HjPj8YCRxaxQhbChCDJdmeWIKiHWvQKESzHzMj1QdmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t17T02dl86dix3dlstpSQKPEpLZ5mUlyvjzhPgGDUqApWfEFZ0Pj2C8zl9BguPQnethL+eYfx6FlLXQAio6k+5iHiF903g7V5SwcpBNqjO8Lo1psGCy0BJveeE5WL0T9sHnI73i4kKgFOHiOExGafoDzzI/ADzBfNMWuJwd86no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vdTHWu7s; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EAgGcs084442;
	Wed, 14 Aug 2024 05:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723632136;
	bh=ZmjD6JhqEPWWPGIj4iq5QUYeTTfT/9ZZb04Uxz50v3A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vdTHWu7sE3T87OcXomxQIKOOuKKkt0DLBgeditsm8J+lHU+L16VJw1nLB6wyLhVV3
	 JkwGR1NFCIYRBDur+EPXALH5EY7hOWomTuoduSGVOPIkLRSRGTxcGgEYO+ooBD8Yh8
	 mqVwfBtv79sZuy/aiKCkRzccl0RWtHjiTpOAQN2o=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EAgGpw089981
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 05:42:16 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 05:42:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 05:42:15 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EAfpSk068615;
	Wed, 14 Aug 2024 05:42:12 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <g-vlaev@ti.com>, <afd@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] arm64: dts: ti: k3-j722s: Change timer nodes status to reserved
Date: Wed, 14 Aug 2024 16:11:51 +0530
Message-ID: <20240814104151.2038457-6-b-padhi@ti.com>
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
	|  Remoteproc Node  | Timer Node  |
	+===================+=============+
	| main_r5fss0_core0 | main_timer0 |
	+-------------------+-------------+
	| c7x_0             | main_timer1 |
	+-------------------+-------------+
	| c7x_1             | main_timer2 |
	+-------------------+-------------+

This change is already incorporated for timer nodes in the MCU voltage
domain.

Fixes: 3308a31c507c ("arm64: dts: ti: k3-am62: Add general purpose timers for am62")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index dd3b5f7039d7..e03beb0b5aad 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -566,3 +566,16 @@ &mcasp1 {
 	       0 0 0 0
 	>;
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


