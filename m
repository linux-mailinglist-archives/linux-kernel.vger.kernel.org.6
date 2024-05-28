Return-Path: <linux-kernel+bounces-191723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCDE8D1323
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE301F233DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E136D1B969;
	Tue, 28 May 2024 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ljUu90ff"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995391804F;
	Tue, 28 May 2024 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868946; cv=none; b=bYN8C9irGahnLdJ+z4JY4ZCheAlp6fJeigMLzw2hZUzDVAN5QzUDn/gD0CqqqHAxpVCj9fsjsMpM/EuTzoipZQKwIxGVrOITkPGT9UMxSTePX5GoAXgxNmjJpdj3KGoe+KUTjtz83YtA0hLWw9ycYcsAEXeqRQENcrXYaPWbf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868946; c=relaxed/simple;
	bh=dTh7PkGFUhhXxB8Q91LepcCd78XPCd45CjUORC1OPYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYtKJjTN3uXhor5sNklakOhaz8C2vIjscXFnKKTX0qq62UozPQgvAgkKBYIblFFXCEg19DdruNt5HOHNrZXDRPHGrbCFxpkkYiPxoUzXgrq5PvkGeGcibiU6X2QAk6VDEePCY3W8V4Hb/rviwqxrKNXn+TqfXIifPfb6w2v/cDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ljUu90ff; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S42DKs085024;
	Mon, 27 May 2024 23:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716868933;
	bh=C1Xk+jO9FYXcKhLuOO2Y0TWXo9NLF7vDHYl0AY+n0JE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ljUu90ff9ku84+ywuM5XektWmDlM31gsfhUgCG8pqKSNMhPtA/UBbAVFYdTsTqyEu
	 1t6xF16mlnj3oJz4mCHD/gLvC3la76BYYKjTQtkteIZN3uriYGkz2lMETkWrWx5Ftk
	 N7nxuwcKxIrA+oztbmAYJYR2+5ITjH+hxhVw75MU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S42DMK093113
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 23:02:13 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 23:02:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 23:02:13 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S420P1028431;
	Mon, 27 May 2024 23:02:09 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v3 2/3] arm64: dts: ti: k3-am69-sk: Add TPS62873 node
Date: Tue, 28 May 2024 09:31:58 +0530
Message-ID: <20240528040159.3919652-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528040159.3919652-1-n-francis@ti.com>
References: <20240528040159.3919652-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add DTS node for two TPS6287x high current buck convertors.

The two TPS6287x supply power to the MAIN domain for AVS and other core
supplies.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index d88651c297a2..4703e2c0528b 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -814,6 +814,27 @@ ldoa4: ldo4 {
 			};
 		};
 	};
+
+	tps62873a: regulator@40 {
+		compatible = "ti,tps62873";
+		reg = <0x40>;
+		bootph-pre-ram;
+		regulator-name = "VDD_CPU_AVS";
+		regulator-min-microvolt = <600000>;
+		regulator-max-microvolt = <900000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	tps62873b: regulator@43 {
+		compatible = "ti,tps62873";
+		reg = <0x43>;
+		regulator-name = "VDD_CORE_0V8";
+		regulator-min-microvolt = <760000>;
+		regulator-max-microvolt = <840000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &wkup_gpio0 {
-- 
2.34.1


