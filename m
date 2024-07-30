Return-Path: <linux-kernel+bounces-267696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE0941475
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23112282F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139A1A2C21;
	Tue, 30 Jul 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jlixLmzP"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462571A01A6;
	Tue, 30 Jul 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350043; cv=none; b=AtnpCW18wsxPIqkiqhdW9DHDmuOdKIg77LgNV/TyiG7mdthRekqgFexfR8E6M2Z3x66MFHXcpZjEXXeqO9zx9h/O66+WAhBPsi8GTKRN5vUNVps/RYszbi7LFkjBH+gsDEOLNfYgpdANnwad/Mg58CplY/1n0Yv6u4Lmdm21BCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350043; c=relaxed/simple;
	bh=+nr1GoI3Frwa2RPsqcvt0siBVMwHXphw8PHqGZBiqEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paTMTgJy8MgRcGpDi2KVqJKCDksB/I5OVjuTILHRyTgYoQosOReOPk4+SYTb64aWp2k0w41HBgoPY5eKbLTFmIH1tFiStSEbgjEPC6kquu//zeppi8WI2N7semaGggpEQKl7wH2LDbVrWXXqElGZN44Hxn0jC+pL1SNISfWS194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jlixLmzP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UEXsNB084540;
	Tue, 30 Jul 2024 09:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722350034;
	bh=EMtiORd66vlEJH6ZRaH09TTPb066amp8TYtcY2yIZQE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jlixLmzPxPqDtf+ut+WTB6xPttyFHp/hNZcVsfqqAeMff9pMvuMW7yrxkG6HjBtFJ
	 3L3l6u61fcSgMvfLfRxFi9IvwWxsR1XGBml3BDccjDYHF80fkPaDW3ZdTSmIJM8fIx
	 JMQX+/uDU8NtmDFwY7CMWAXy5IW2VnLc3b4w0yzQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UEXsQU113730
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 09:33:54 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 09:33:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 09:33:53 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46UEXrHe047206;
	Tue, 30 Jul 2024 09:33:53 -0500
From: Jared McArthur <j-mcarthur@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Jared
 McArthur <j-mcarthur@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62p: Fix gpio-range for main_pmx0
Date: Tue, 30 Jul 2024 09:33:23 -0500
Message-ID: <20240730143324.114146-3-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730143324.114146-1-j-mcarthur@ti.com>
References: <20240730143324.114146-1-j-mcarthur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Commit d72d73a44c3c ("arm64: dts: ti: k3-am62p: Add gpio-ranges
properties") introduced pinmux range definition for gpio-ranges,
however missed a hole within gpio-range for main_pmx0. As a result,
automatic mapping of GPIO to pin control for gpios within the
main_pmx0 domain is broken. Fix this by correcting the gpio-range.

Fixes: d72d73a44c3c ("arm64: dts: ti: k3-am62p: Add gpio-ranges properties")
Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 57383bd2eaeb..0ce9721b4176 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -45,7 +45,8 @@ &inta_main_dmss {
 &main_pmx0 {
 	pinctrl-single,gpio-range =
 		<&main_pmx0_range 0 32 PIN_GPIO_RANGE_IOPAD>,
-		<&main_pmx0_range 33 92 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 33 38 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 72 22 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 137 5 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 143 3 PIN_GPIO_RANGE_IOPAD>,
 		<&main_pmx0_range 149 2 PIN_GPIO_RANGE_IOPAD>;
-- 
2.34.1


