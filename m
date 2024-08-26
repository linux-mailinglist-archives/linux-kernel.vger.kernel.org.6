Return-Path: <linux-kernel+bounces-301170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFF895ED3A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811F11F22326
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99264145B35;
	Mon, 26 Aug 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wDEEqK0j"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFCF149DE8;
	Mon, 26 Aug 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664657; cv=none; b=hDeDsHfKEmMBdXo7zYjHuEUfeUbcnPzMC/DbtOzAGcJLnwUQIa6EP4uMTs00qbMUY5w3gOpVgZQTjD2wlTHcsEWbfTBTLY+FEOuqx9pTOgQDC/SlB1kmJQXs0g5btH5g/VUB1dSdHVE1t7KvmAdbHq1RQ2GP5+hTsTUk077VVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664657; c=relaxed/simple;
	bh=xw8Qzj5HSJS1uoR3sd5l0/SOcRghgjk+lfrxKTrM/Hg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDG2cbY3blf4x+WkJWMJb7+y5qwqPUirnlV89eWwMbYji6ltFs9YX1Uj/Di+4ohKdMlCFRgdp1TPMBgWgU6m41NOl/LdG6kcGM1fMjsZJ/ciokYvRYUBA3EzidFOVhnensDk8DGxJDkRgVIH/jnUSy0JnF1Id8YWq2KPyApwroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wDEEqK0j; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47Q9Up3s119324;
	Mon, 26 Aug 2024 04:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724664651;
	bh=4m6BBkPry7UgXpbgAWQ4aMq9wEfsdNLBPCDJGuaTT7g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wDEEqK0jYZjjX1JesaavJvonHyMQnlE0X0AEcYPHStG6eYhcL1v+MqcbwSBurCVu6
	 UpSA6FxpF9GYV/ZRjm9Ut7NZv43MHawxNBbHfzk459fmtUL+1DUub6qTl55OXHNyQW
	 EU0bZAkXmPi0SoumFopJ8xcUk2vCUFqDoZzceXVc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47Q9UpRJ055460
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 04:30:51 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 04:30:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 04:30:50 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47Q9UPnF118247;
	Mon, 26 Aug 2024 04:30:47 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <s-anna@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/7] arm64: dts: ti: k3-j784s4-evm: Switch MAIN R5F clusters to Split-mode
Date: Mon, 26 Aug 2024 15:00:23 +0530
Message-ID: <20240826093024.1183540-7-b-padhi@ti.com>
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

The TI J784S4 EVM board has three R5F clusters in the MAIN domain, and
all of these are configured for LockStep mode at the moment. Switch
all of these R5F clusters to Split mode by default to maximize the
number of R5F cores.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index ffa38f41679d..58d550a1ac17 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -1154,6 +1154,18 @@ &mcu_r5fss0_core1 {
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
 	status = "okay";
 	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
-- 
2.34.1


