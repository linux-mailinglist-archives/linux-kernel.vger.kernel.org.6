Return-Path: <linux-kernel+bounces-301167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0EE95ED34
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B469A1F21FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A2148307;
	Mon, 26 Aug 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qbDBC12L"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5011474BF;
	Mon, 26 Aug 2024 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664652; cv=none; b=LIVk8uGQgmwrjAG4QvxOygtE4+JwZX5R5TFL2Cz4S0VF5i3D6Ab7uhd6lxhdSdP6QJMcZsJwfkthgy9a86dDC7P3So18NwLTp99OQZCF64HnfYUa7ePuBVfWIaKdi2BNvc2YI13SPdLJewi4bOQQPJfwZqjF/S4BJ4Uvk54aVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664652; c=relaxed/simple;
	bh=ZEznYgnTuJll8S9P/kFDnEZXYtpXzaix0nA2A+5fq2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LB5mDmd2SeLLFGWbyTRd3BniONEaixSa9FtfgzinZhLwAk10fg5FDGHIrpyUWGTfeR0DbATHmq7V/NnV3gsO4Eaud/4Gxguc+K8xlQjNAH4WyvJVaxaRyPlWi2c3kwWwXnfZ005xkedw/XaE63h5mxqM/I1p09Uvv2lkrJCz8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qbDBC12L; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47Q9UWdG119089;
	Mon, 26 Aug 2024 04:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724664632;
	bh=bjy/9/xbq3eq743JRqv9WGWccXskC+U7DR17BZ5lKoY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qbDBC12LfStORl1/oK8x8bWtxt5STXGbyZvCPYSpnjHSi/duHXidrwWrQZJBNtcU6
	 FubufolrWwR/AgOgW7cf4+JAyjHnKOJzBP5dHv0CWKdrv7jiHWpZNgl9vSWXCw4+Iu
	 BcyCVCONJ93Bxw/qnZ65oZDO0FTjAR3Cea07z5Nc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47Q9UWVI015279
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 04:30:32 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 04:30:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 04:30:32 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47Q9UPnA118247;
	Mon, 26 Aug 2024 04:30:29 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <s-anna@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/7] arm64: dts: ti: k3-j7200-som-p0: Switch MAIN R5F cluster to Split-mode
Date: Mon, 26 Aug 2024 15:00:18 +0530
Message-ID: <20240826093024.1183540-2-b-padhi@ti.com>
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

The TI J7200 EVM board has one R5F cluster in the MAIN domain, and it is
configured for LockStep mode at the moment. Switch the MAIN R5F cluster
to Split mode by default to maximize the number of R5F cores.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index 89b68325e4e2..deb380a83ea1 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -262,6 +262,10 @@ &mcu_r5fss0_core1 {
 			<&mcu_r5fss0_core1_memory_region>;
 };
 
+&main_r5fss0 {
+	ti,cluster-mode = <0>;
+};
+
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-- 
2.34.1


