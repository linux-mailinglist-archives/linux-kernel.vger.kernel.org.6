Return-Path: <linux-kernel+bounces-308583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D5C965F23
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F602288050
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F27188CBC;
	Fri, 30 Aug 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EgYiu1u1"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56B17B4FE;
	Fri, 30 Aug 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013639; cv=none; b=iral3qtZoIt9jVEj4YtZL0SX7UA4xBJPiJK9IcW38rQX/XYoNwStZHodfgG8sCl/LgGfRMfdR2QGkdC4RSs3xVraiid7a8qj6blPJXVpnKhLX/W90cu0lM4NvUMhByKAmntzVBrZ1fOA9+w/Eo+x1R2JHOQ4OXZE17lplt483UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013639; c=relaxed/simple;
	bh=n5x96yz0plQXi0jNRmIFh/xZ8EZ6kyjM+6+zAuiZYPs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k8vYOPHvyG3gpjrg+OezuPjMz/MTdfZ2QWe0G3YpPAQCBzmS++OEp+JT/0UBAVP1ezsBVPwbfRroQmbniBkePkR5egNI+TlKuWVMsvFnKJRw/yrly4bcn/W15anH4tB3QYAwHWIiG7Bj27hmA3OLMOG7AiFW1705KQdu5DK6KGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EgYiu1u1; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UARAb1059403;
	Fri, 30 Aug 2024 05:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725013630;
	bh=SWIJULiquba5lxHob3BxH9YjKU7LdekAg30JvEMazqM=;
	h=From:To:CC:Subject:Date;
	b=EgYiu1u13UiA3sdBymMUKPXi1IixCWce0ZCt98bPQWK8ZcOofpOt/iGmZDggPpAhI
	 hFSvaTRCq0jD1CI7DvvLtDQDsvCQRjhORQajSiQk2w6Siq06FLOR3gCG3skSPtXK1u
	 6B3BLpRA7fJlRllmlDT4Yk7Ha4yVUe5eOxOSRXXM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UARA1D125739;
	Fri, 30 Aug 2024 05:27:10 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 05:27:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 05:27:10 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UARAXX120457;
	Fri, 30 Aug 2024 05:27:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Roger
 Quadros <rogerq@kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am642-evm-nand: Rename pinctrl node and gpio-hog names
Date: Fri, 30 Aug 2024 05:27:09 -0500
Message-ID: <20240830102709.3970209-1-nm@ti.com>
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

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Cc: Roger Quadros <rogerq@kernel.org>

This is a trivial fix, so applying Fixes seemed over-board.

 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
index f08c0e272b53..f91589818e32 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
@@ -12,7 +12,7 @@
 #include "k3-pinctrl.h"
 
 &main_pmx0 {
-	gpmc0_pins_default: gpmc0-pins-default {
+	gpmc0_pins_default: gpmc0-default-pins {
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

base-commit: d2bafcf224f3911b183113b2fcb536c9e90684a3
prerequisite-patch-id: a9c45d98345ca492c945cd5050191ad605de242b
-- 
2.46.0


