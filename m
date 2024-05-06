Return-Path: <linux-kernel+bounces-169719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBA8BCC8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4318128609F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F771142E83;
	Mon,  6 May 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V1mHG52b"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AE75815;
	Mon,  6 May 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714993348; cv=none; b=momANhNgpJpuqIAlb/EHMIyr3UhvKEaNX69TwN66GrZAYLHiifgFfH8+3+Ojk+OkPBV3xQRUgc0NSaS8/xEFy4YkppAtjT/9Wc52UbAY1qENGvH7ZQpvYr7HPyR6s37+ufJmecae/WEb/aG7MCrQGwq6ARJy2mBg0F0rX2WdfKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714993348; c=relaxed/simple;
	bh=Oix5djLZmNkTp0exGsZ9laRtRhDbmtuVJV8qzd4CORU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W52KcaDLpmGz/C2xcibQXFidwLXf6ImsI7Zkzu+7hcyjOgVTsXr8VPPnbSXDt99OurTltguJT+dmwP82Yb0t6cg36/UeWoUm2+k0ODnAXsfNBd/GuQADbcWf3R5CzG25LFHcbt9UMzaOeG7pM89VDnVfhgZ/K8cvTr0XYdhungs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V1mHG52b; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 446B28SB111425;
	Mon, 6 May 2024 06:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714993328;
	bh=4nRIQOW4oDA+o2rDMlVOaPir43l7W2KwJJ7J1DUAzFs=;
	h=From:To:CC:Subject:Date;
	b=V1mHG52beUzIolT7kNEtGJsQ94vg24WJnkhEmuw2j6/ZD7QzbKUKS2FTdRziFmwQL
	 /irHoyMx+JrZve3LzP+kTwCclZKkTwS1te/Qr732GvHYk0KqOLXXvj3z3ZhTEcON7e
	 ex+mIpQcxXItT9D8oxP5wvcJbBfEHf5MoYfgMUAs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 446B28mB111809
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 May 2024 06:02:08 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 May 2024 06:02:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 May 2024 06:02:07 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 446B23iM050823;
	Mon, 6 May 2024 06:02:04 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH] arm64: boot: dts: ti: k3-*: Add memory node to bootloader stage
Date: Mon, 6 May 2024 16:32:03 +0530
Message-ID: <20240506110203.3230255-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the bootph-all property to the memory node so that it can be
accessed by FDT functions at bootloader stage.

The bootloader requires the memory node to be able to initialize and set
the size of the DRAM banks. For this purpose, make sure all memory nodes
are present and standardized, and modify them if not.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 1 +
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi     | 5 +++--
 arch/arm64/boot/dts/ti/k3-am69-sk.dts          | 4 ++--
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi    | 5 +++--
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts         | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi    | 1 +
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi   | 5 +++--
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts       | 4 ++--
 8 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index aba0c52b1213..aa7139cc8a92 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -33,6 +33,7 @@ chosen {
 
 	memory@80000000 {
 		device_type = "memory";
+		bootph-all;
 		/* 4G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
 		      <0x00000008 0x80000000 0x00000000 0x80000000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
index 0f4a5da0ebc4..2ebb7daa822f 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -11,9 +11,10 @@
 / {
 	memory@80000000 {
 		device_type = "memory";
+		bootph-all;
 		/* 16 GB RAM */
-		reg = <0x00 0x80000000 0x00 0x80000000>,
-		      <0x08 0x80000000 0x03 0x80000000>;
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000003 0x80000000>;
 	};
 
 	reserved_memory: reserved-memory {
diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 50de2a448a3a..32cda4a08081 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -35,8 +35,8 @@ memory@80000000 {
 		device_type = "memory";
 		bootph-all;
 		/* 32G RAM */
-		reg = <0x00 0x80000000 0x00 0x80000000>,
-		      <0x08 0x80000000 0x07 0x80000000>;
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000007 0x80000000>;
 	};
 
 	reserved_memory: reserved-memory {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index 7e6a584ac6f0..21fe194a5766 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -12,9 +12,10 @@
 / {
 	memory@80000000 {
 		device_type = "memory";
+		bootph-all;
 		/* 4G RAM */
-		reg = <0x00 0x80000000 0x00 0x80000000>,
-		      <0x08 0x80000000 0x00 0x80000000>;
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
 	};
 
 	reserved_memory: reserved-memory {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 0c4575ad8d7c..a027cf2facee 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -31,6 +31,7 @@ chosen {
 
 	memory@80000000 {
 		device_type = "memory";
+		bootph-all;
 		/* 4G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
 		      <0x00000008 0x80000000 0x00000000 0x80000000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index 1fae6495db07..5ba947771b84 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -12,6 +12,7 @@
 / {
 	memory@80000000 {
 		device_type = "memory";
+		bootph-all;
 		/* 4G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
 		      <0x00000008 0x80000000 0x00000000 0x80000000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index 623c8421525d..82aacc01e8fe 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -13,9 +13,10 @@
 / {
 	memory@80000000 {
 		device_type = "memory";
+		bootph-all;
 		/* 16 GB RAM */
-		reg = <0x00 0x80000000 0x00 0x80000000>,
-		      <0x08 0x80000000 0x03 0x80000000>;
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000003 0x80000000>;
 	};
 
 	/* Reserving memory regions still pending */
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 81fd7afac8c5..e9a3b5c2faa4 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -33,8 +33,8 @@ memory@80000000 {
 		device_type = "memory";
 		bootph-all;
 		/* 32G RAM */
-		reg = <0x00 0x80000000 0x00 0x80000000>,
-		      <0x08 0x80000000 0x07 0x80000000>;
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000007 0x80000000>;
 	};
 
 	reserved_memory: reserved-memory {
-- 
2.34.1


