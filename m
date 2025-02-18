Return-Path: <linux-kernel+bounces-520162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E465FA3A682
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CEF3B83AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C121E5209;
	Tue, 18 Feb 2025 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eBCcKc2M"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A61E5201;
	Tue, 18 Feb 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904915; cv=none; b=VVYOg8Sf/6jcCbTdLPvpp1H1Nx60SU8CxG3GFUUvFg+OBfAwG7rmJiaseiJDXaSLJ/rzkRGRYs8/MeDSifTitb7cphWUN9UlvfoE73HDEfW8dG0lp/oecU/QXBva+bJ7YhKgADnJ0iGunVEmxRb/o9LriohTg824hZp6R3uRjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904915; c=relaxed/simple;
	bh=lpNMHdvmuzzHYEXpcCaam4+YBu+ZIqP0etGoxNjExl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwE4sdayQvdOgGdl7pe0Wc5khBMP5wBT4ZZemmZL1s6uoYJy5jTdEp4gsdGFcVqCOuGOEvb/o44+Th1IAyW/JYyiPZyAJLzrx8s0xcXBNQVCjUN0JscwaO1Ff8sGgZnDWT2Y9kax9r75gaSeVGg8v+T2oepoIk78PIT0+H50pt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eBCcKc2M; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51IIt1cJ1601148
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 12:55:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739904901;
	bh=EYoaQKOG0j2VrFU1cmqPC5t9p1n01H3GC07p2m/mp0Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eBCcKc2MQgD3O9wzLYQLqDp2RHlNaf8SSa6l6pTgiMq91KUI6EuyE47VVakrXZuC0
	 Db/KBV/mcKnamNJDDuv+ANgoTZFK9i6Q4QL2KJUlP6VB+OQa5KEDVeyYJDKg2bnqcr
	 k+PC2j+qOcFzUofvw0rnkFAyJoLLFDtqLeiQKlyY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51IIt1GX021064
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Feb 2025 12:55:01 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 12:55:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 12:55:00 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51IIsrxZ123821;
	Tue, 18 Feb 2025 12:54:57 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <jai.luthra@linux.dev>,
        <y-abhilashchandra@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 1/5] arm64: dts: ti: k3-j722s-main: Add BCDMA CSI overrides
Date: Wed, 19 Feb 2025 00:24:48 +0530
Message-ID: <20250218185452.600797-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218185452.600797-1-vaishnav.a@ti.com>
References: <20250218185452.600797-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

J722S has a dedicated CSI BCDMA instance which is slightly different
from AM62P in TX channel support, add the overrides and additional
properties to support CSI BCDMA on J722S.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 3ac2d45a0558..f8e4424f3bb7 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -204,6 +204,16 @@ c7x_1: dsp@7e200000 {
 	};
 };
 
+&main_bcdma_csi {
+	compatible = "ti,j722s-dmss-bcdma-csi";
+	reg = <0x00 0x4e230000 0x00 0x100>,
+	      <0x00 0x4e180000 0x00 0x20000>,
+	      <0x00 0x4e300000 0x00 0x10000>,
+	      <0x00 0x4e100000 0x00 0x80000>;
+	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+	ti,sci-rm-range-tchan = <0x22>;
+};
+
 /* MCU domain overrides */
 
 &mcu_r5fss0_core0 {
-- 
2.34.1


