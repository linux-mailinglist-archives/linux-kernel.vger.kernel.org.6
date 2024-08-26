Return-Path: <linux-kernel+bounces-301171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B8795ED3C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B2A28109C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4146E146593;
	Mon, 26 Aug 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HCrVAxa8"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D0146018;
	Mon, 26 Aug 2024 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664668; cv=none; b=jmOpPTZ1YY8AVQaGciteOHrmdMS6dNKKLxtXH8LXVhOdzLL9mVmSqzNI/zfhixTTud8krUR4F7kdrTiDTtUdxbX+DFdR6U8/eLY++8DdZuTgSDUaEWDx+eJxqJL65nareCUs0xYp7qYSiP/sNpr7zwBLg+Ll246eNxAkRpzvk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664668; c=relaxed/simple;
	bh=QT/m64q0cCNIyz7BZXndaixSJreSGk8FA+TkG6oyLzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMZAFjr5GUm03x9oay6XKDge+th4j3pfiTivmy1DLbPorusCoJ1uNHbG2KeJEZNYKTGNNitBRUcUqLcUb4byJ6ZN6EiRom+qTqAe+EEx5v3OHKse2pNudvcjOWUAUWsUKVkIh/6WHuYCFy0V7Qbygc5cnvJDDFUOgi16hEu5H/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HCrVAxa8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47Q9UtOu079832;
	Mon, 26 Aug 2024 04:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724664655;
	bh=C6jCl5r7nElbSCK6TwJqvKHS9CQ9yMJS6EZQX2Dvo24=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HCrVAxa80MfeLSB/zsGKizLaoHZOti4zLZYpTBTEKFMZsf0dUj2qvE+ZRaP9CQkvk
	 PxRGFQQmhkeDe4dhR6/0yU3W+oOvvq6mWo8FJdNsik4FGEyTo/TI1O053NJZWvv1mx
	 wY07FZESFVHYeJf0AmFpt2xUX0YgjbDTJSLhrLvE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47Q9UtaC055486
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 04:30:55 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 04:30:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 04:30:54 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47Q9UPnG118247;
	Mon, 26 Aug 2024 04:30:51 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <s-anna@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/7] arm64: dts: ti: k3-am69-sk: Switch MAIN R5F clusters to Split-mode
Date: Mon, 26 Aug 2024 15:00:24 +0530
Message-ID: <20240826093024.1183540-8-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826093024.1183540-1-b-padhi@ti.com>
References: <20240826093024.1183540-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The TI AM69 SK board has three R5F clusters in the MAIN domain, and all
of these are configured for LockStep mode at the moment. Switch all of
these R5F clusters to Split mode by default to maximize the number of
R5F cores.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 3f655852244e..ad6570c51a68 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -979,6 +979,18 @@ &mcu_r5fss0_core1 {
 			<&mcu_r5fss0_core1_memory_region>;
 };
 
+&main_r5fss0 {
+	ti,cluster-mode = <0>;
+};
+
+&main_r5fss1 {
+	ti,cluster-mode = <0>;
+};
+
+&main_r5fss2 {
+	ti,cluster-mode = <0>;
+};
+
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-- 
2.34.1


