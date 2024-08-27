Return-Path: <linux-kernel+bounces-303610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34AF9610F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0452281179
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9D1C86F0;
	Tue, 27 Aug 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VUVb0ail"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14C1C57B3;
	Tue, 27 Aug 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771657; cv=none; b=DKN9Ae5u57BrbHEiHgzzMdqLHTQVdfWr3fLvMel2bVR/wg3uinrP5G2ymdvLcFCPY1vV8ftAFMawfZq4KCUV3Eb2RXo62YVzy8TrZa7ZgAHKPxHBZTlUStItu1Rvrzp6biHCQCg6ZTg0FYBm8O2TO/9nvs/+d8sb0iAH9z9MfKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771657; c=relaxed/simple;
	bh=7naeyFDCYUIUdrBeUVuwZz8XN8BfbrcPIJlzd4TgalY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mASJFiE72JCxmlIiOBqyUN+K1kXkkJo2Vj/9fmIBEQ8mPEwDln4qC9TosJB9c2Yg+XFbTfI2QEiOcy3ALvaOg6Uxdtj4vGA8+CJy2luVqni15+NDgNc0D9QSM6dHdXjSOAK1s3BnJsw2UXyDRu9lYXY41XYdPKQeG9N5q/Cgu2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VUVb0ail; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BDC6888928;
	Tue, 27 Aug 2024 17:14:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724771654;
	bh=a/TLeEbVMTOZInnIGycDv93Q7uSfdCZgR1IPJ+US87Y=;
	h=From:To:Cc:Subject:Date:From;
	b=VUVb0ailvoen447c05VKjlkrw1s3OVx4qZirmhRP+DAGNNJU6GNwDK1K8IYyyU0UE
	 MwLl1pjve/d5O8XmRzWG3zmP2AW3qoign/5z7UVXIr4+w4vjmhW92XEIy/7Na5XKjm
	 3JXYsUXvV+7pSF94dvD2yAizjH8s8ar9KEVMUNW64lMm7kOkN7Hd++jYiAoWvGGPNW
	 7o1LfKhHUjNEXgoTa7ZaK4m/KlDAqa+1TZt3fJanLEDq0xEZMXenn8YGtWQ2QWa1ca
	 GOeO1i3GV0OrE6zUVsU1X2aQheQb5ENrJYbG+nmotmse1VVroU7iz2NVV9ft5xBLBh
	 v47zrehZQmrsA==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] arm: dts: mxs: Fix dt-schema warning for nand-controller (imx28)
Date: Tue, 27 Aug 2024 17:14:01 +0200
Message-Id: <20240827151402.2255708-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This change fixes following error:
nand-controller@8000c000: #size-cells:0:0: 0 was expected

When dt-schema is checked:
CROSS_COMPILE="arm-none-linux-gnueabihf-" ARCH=arm make -j4 dtbs_check W=1

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index 4817fba2d938..9655403b7f90 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -99,7 +99,7 @@ perfmon: perfmon@80006000 {
 			gpmi: nand-controller@8000c000 {
 				compatible = "fsl,imx28-gpmi-nand";
 				#address-cells = <1>;
-				#size-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x8000c000 0x2000>, <0x8000a000 0x2000>;
 				reg-names = "gpmi-nand", "bch";
 				interrupts = <41>;
-- 
2.39.2


