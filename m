Return-Path: <linux-kernel+bounces-360832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49A99A052
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F31B21B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81C320FA86;
	Fri, 11 Oct 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sdSaya12"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278BE804;
	Fri, 11 Oct 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640111; cv=none; b=XbUXK6ZzHFnyz4nyZuHGY0Lg99kHl+4kVUnKygUms76ueTS8aJza7Ov5BMatLqcl+p0xwdJ2FzpAy70n0BLXdrSij3iYh8/kee+uUpLAYcmCr2UVRfmpB4bGGoQuJiJAbHNYyHpefBErTfgCgbx5N/xgFAbFYlcU5QvQQ40TtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640111; c=relaxed/simple;
	bh=zlBgSajFQirMH/aVjsR0uuwfjHOra4SzmJ4OoGJ2skk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r3THt6Bw9TfAOD22ejs1lRO6qGsVJDnxOzjYROPhuFtcsbw1BA2/9+X/nYRQJFZiLxGMFnfD6NDsKs5WhxutW1cZYgobqDvExWNRlYXuibXPNKzdh4LwnMLwRSwcmTLQ1MhRnC0eDdbHR/c3j9VrGSu6Ibcnb/yWEzMjLeXd5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sdSaya12; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49B9mIoF077310;
	Fri, 11 Oct 2024 04:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728640099;
	bh=euBZcmIhDImMUSMYVcbihSsPyTui8rH0oCGn65zJ/f4=;
	h=From:To:CC:Subject:Date;
	b=sdSaya12GFZCKkWfrUMfkLcUg9vfF3BR+X+53gF0wHsjLCtK58Ii8bWSkgC2jITfm
	 sahj1SLXtqh5Mzxps1wFeKY0Jfm0gbNoqvL4BQclWi90OcznxN7Gzu6S42DRA7sHnt
	 NlkFbAkncttQGocP9ExVLDZ0qa7CghTOnYC1M71g=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49B9mI8R018368
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 04:48:18 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 04:48:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 04:48:18 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49B9mHBv084150;
	Fri, 11 Oct 2024 04:48:18 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>
CC: <s-vadapalli@ti.com>, <srk@ti.com>, <danishanwar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all property in cpsw_mac_syscon node
Date: Fri, 11 Oct 2024 15:18:14 +0530
Message-ID: <20241011094814.64447-1-c-vankar@ti.com>
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
index 44ff67b6bf1e..912425f28052 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -303,6 +303,10 @@ AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0) /* (C5/C6) WKUP_UART0_TXD */
 	};
 };
 
+&cpsw_mac_syscon {
+	bootph-all;
+}
+
 &wkup_uart0 {
 	/* WKUP UART0 is used by DM firmware */
 	bootph-pre-ram;
-- 
2.34.1


