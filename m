Return-Path: <linux-kernel+bounces-360999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141BF99A237
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3DB1F25591
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480F4213EC6;
	Fri, 11 Oct 2024 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GdztFdD9"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D014293;
	Fri, 11 Oct 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644541; cv=none; b=DZETgZQLPmCOrazKs9WZP18notMNL7QGqCwPrgZN8pikpGTQ9O2jgzyFlT1IrYCIeX6TqfyuU83qh+gkfLRxtgfht9GabhCfZdyu+GRMrpgaYZA9UcsNBN/7jlU61hg+Is9iX2pJqfQROOqy0lAhu0iTL1twPsPvJum6RE/mPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644541; c=relaxed/simple;
	bh=4TA5iWp28rU7dsx2qosdjaM2a6HNpkJaKgZKMzcQIdU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HsLR4Mtb82JdU/B6vwg8TnFXkUOyJVlElxx2hOq96/gMueUwqoQJhNT32rUepAsClRgKiFA9scyCASpj2YWSwLZ+/Z5uP46i7Nn2XI3F187+bwKMLRuer5Jksf+so2/HZxnXEKt7ufE0JIdUUKggkYMq/B/jblmUeC/rh6N5Fw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GdztFdD9; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BB29Od034061;
	Fri, 11 Oct 2024 06:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728644529;
	bh=lveVADprlH2tGE8x9sJ7xZSsBIMARgxyzXlVmZ0tj8o=;
	h=From:To:CC:Subject:Date;
	b=GdztFdD9/u5sU76EPDJZywBOz6yvKmvm5Jk6Z9IBAQLUQgzVun0nZrK26Ozn+Ep5D
	 FbUTaOuDkjqT2nFPQXsD9Pp2ALvkOEnjuOgu3+Lgtf8WJvhtqMqaq5q9aQBi5o4aEZ
	 SwTpvtBCGyePDdtgUL2eqrNnHpZfuywEdcm3cEDQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49BB29qh092346
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 06:02:09 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 06:02:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 06:02:09 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BB28Km028934;
	Fri, 11 Oct 2024 06:02:09 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>
CC: <c-vankar@ti.com>, <s-vadapalli@ti.com>, <srk@ti.com>,
        <danishanwar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all property in cpsw_mac_syscon node
Date: Fri, 11 Oct 2024 16:32:07 +0530
Message-ID: <20241011110207.600678-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add bootph-all property in CPSW MAC's eFuse node cpsw_mac_syscon.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on linux-next tagged next-20241011.

 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 44ff67b6bf1e..82d34dfb91ed 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -303,6 +303,10 @@ AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0) /* (C5/C6) WKUP_UART0_TXD */
 	};
 };
 
+&cpsw_mac_syscon {
+	bootph-all;
+};
+
 &wkup_uart0 {
 	/* WKUP UART0 is used by DM firmware */
 	bootph-pre-ram;
-- 
2.34.1


