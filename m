Return-Path: <linux-kernel+bounces-363399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F1199C1D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD8C28189C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D814E2CD;
	Mon, 14 Oct 2024 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r0WFoRZ0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315914B946;
	Mon, 14 Oct 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891951; cv=none; b=gJnkK7USmFkg/4I+L2gAEXNckrI7k9rBNx1xn5V/fOc6C7ATpVs1elGc44ewnbq3nHtFwYstx28PHAYA5JZIEuhRmRRnVnwBB8836a5Gi9s29zbJRM8NmCmG2aQHFEWQTiSU5WYnHck6pZbLic+gSukQyjy8nEFXtzKLE5zkg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891951; c=relaxed/simple;
	bh=hyxinxMXFh5dYNzfcLySUJEFNAqmURdUkYPbXXezyOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0/mlNgCmGRTmKjGFdlqktXuI0Ug/ImKtNvkZDpIoAU6CeS4CJzTvzrLwb04bCySKe0q/JhvOIdU80gr2AAybtufvHOqSpRCWJjRv11uDjCQ7otqHeetpB2zEMXbxDHS9v6da6pdPOoHFSZGFyGumbsmm2GcpJiFPQHmqkSx4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r0WFoRZ0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jcct062777;
	Mon, 14 Oct 2024 02:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728891938;
	bh=TX0pT7Yiay+cHg+D5Yb7R+y34ZzlQnZ9SVNpIG9Ky+o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=r0WFoRZ0cbtiF6Ip4+OY3QwCCpfSZpx46RqKdHbNANh7ZC2r7a0IgU/adoza9nAfb
	 e9pPAbzq5sLVUYx/2g7gOpEv/iUFBirzq9w3v3u/N5iw9GFFfJ9yiB5LRC9Da8OrQ2
	 U3lH/lUqzPA1px7MIFeKbXrgyCi1IJZKjBLMrLck=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E7jcv3017513
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 02:45:38 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 02:45:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 02:45:38 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jc1Y071262;
	Mon, 14 Oct 2024 02:45:38 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 49E7jb17025342;
	Mon, 14 Oct 2024 02:45:38 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-am64-main: Add ti,pruss-pa-st node
Date: Mon, 14 Oct 2024 13:15:26 +0530
Message-ID: <20241014074527.1121613-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014074527.1121613-1-danishanwar@ti.com>
References: <20241014074527.1121613-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add pa-stats nodes to k3-am64-main.dtsi for all ICSSG instances.
This is needed to dump IET related statistics for ICSSG Driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 7eae18399caa..82cd910e06b8 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1261,6 +1261,11 @@ icssg0_mii_g_rt: mii-g-rt@33000 {
 			reg = <0x33000 0x1000>;
 		};
 
+		icssg0_pa_stats: pa-stats@2c000 {
+			compatible = "ti,pruss-pa-st", "syscon";
+			reg = <0x2c000 0x1000>;
+		};
+
 		icssg0_intc: interrupt-controller@20000 {
 			compatible = "ti,icssg-intc";
 			reg = <0x20000 0x2000>;
@@ -1426,6 +1431,11 @@ icssg1_mii_g_rt: mii-g-rt@33000 {
 			reg = <0x33000 0x1000>;
 		};
 
+		icssg1_pa_stats: pa-stats@2c000 {
+			compatible = "ti,pruss-pa-st", "syscon";
+			reg = <0x2c000 0x1000>;
+		};
+
 		icssg1_intc: interrupt-controller@20000 {
 			compatible = "ti,icssg-intc";
 			reg = <0x20000 0x2000>;
-- 
2.34.1


