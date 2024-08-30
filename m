Return-Path: <linux-kernel+bounces-308716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6849660CB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B071F29A99
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE3192D90;
	Fri, 30 Aug 2024 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Di4xAqLA"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A417BB0A;
	Fri, 30 Aug 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017507; cv=none; b=lfDtOuKCAPHOzFjGejOpWgoQdPjhER1bMAjjkxEiIYa4U+iwvJ92s2S41Y1+iMe24ihlsPvBrToQEEop+DPGIVaDc6KNz5578QBywHD/xkpfyO1jU5WmNmnMNsaQ4cCu6tr8Ty+v7U6ZG1Aq6iCqvg8ZPkLCNqljjQ3k2Dj67aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017507; c=relaxed/simple;
	bh=YkWpl99ADp00PTbnerWY1taC+nN4P78uHCamb3Y1YCE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FeRDf4n/ZfBqKd/j6Eyncdbd1hthwtcuUx+4y/uSWkzVZflh4y2JtbQaV4vgatDTFe4sXFu5OZFZV8VR7LzvCujafspRVMFAyiorB+etJ2qM63y3yrrj2SWVkZ2oY+v5ZanYEEBGmylXFV1kxZGvdzd/ZE+yVgRF+XbNaYmivug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Di4xAqLA; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UBVdQV070277;
	Fri, 30 Aug 2024 06:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725017499;
	bh=Sw3OmQAxPKmlZz5JNo3EyM7bMOOW0KcfzHrl+gM1ueU=;
	h=From:To:CC:Subject:Date;
	b=Di4xAqLA5SR8ngVHPZDBXgwiefDYLv8zkkA6hEEZZyKGRjggDXJ3UJ4XThEUoh5/H
	 qOc/p9OKL+1JEqq4/m+QotHzSj68wgfcOnOYeYlDI7ZzwuhK24yu4iX3QhwWkQnek2
	 1JnPqKokhtH4c/EK4Ybc/crfKrT2brGNb5FCxsWk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UBVd3W029545;
	Fri, 30 Aug 2024 06:31:39 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 06:31:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 06:31:38 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UBVcrN049020;
	Fri, 30 Aug 2024 06:31:38 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Dhruva
 Gole <d-gole@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH V2] arm64: dts: ti: k3-am642-evm-nand: Rename pinctrl node and gpio-hog names
Date: Fri, 30 Aug 2024 06:31:37 -0500
Message-ID: <20240830113137.3986091-1-nm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Rename the pin mux and gpio-hog node names to match up with binding
rules. This fixes dtbs_check warnings:
'gpmc0-pins-default' does not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'
'gpio0-36' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'

While at it, change the phandle name to be consistent with the pinctrl
naming.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since V1:
* Picked up Reviewed-by
* Updated phandle name to match up with with standard pin naming.

V1: https://lore.kernel.org/linux-arm-kernel/20240830102709.3970209-1-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
index f08c0e272b53..92faf762894c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
@@ -12,7 +12,7 @@
 #include "k3-pinctrl.h"
 
 &main_pmx0 {
-	gpmc0_pins_default: gpmc0-pins-default {
+	gpmc0_default_pins: gpmc0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0094, PIN_INPUT, 7) /* (T19) GPMC0_BE1n.GPIO0_36 */
@@ -50,7 +50,7 @@ AM64X_IOPAD(0x00a4, PIN_OUTPUT, 0) /* (N17) GPMC0_DIR */
 };
 
 &main_gpio0 {
-	gpio0-36 {
+	gpmc0-hog {
 		bootph-all;
 		gpio-hog;
 		gpios = <36 0>;
@@ -67,7 +67,7 @@ &elm0 {
 &gpmc0 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&gpmc0_pins_default>;
+	pinctrl-0 = <&gpmc0_default_pins>;
 	#address-cells = <2>;
 	#size-cells = <1>;
 

base-commit: 20371ba120635d9ab7fc7670497105af8f33eb08
-- 
2.46.0


