Return-Path: <linux-kernel+bounces-304689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0E962392
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE491B23C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538A31649CC;
	Wed, 28 Aug 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XO3DcIHj"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836F15B97E;
	Wed, 28 Aug 2024 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837738; cv=none; b=SB8OfFU3C8bNlzYvMvcY2frczIZpaDIzoYLsBxqanOeI+rEyrMRdqCKR5YftNvkwUpKGMfn5zVFUlMlv9WTbvr4P7W+qJ8wk+93M/sUIAJFrtt79v7888o4mWjPxfNyIgo4fIWEql487S0zCKK4UW/Zg8FWNwzgVVXAge+tDaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837738; c=relaxed/simple;
	bh=TuYJ7HQYFcklR7CYn1WP5U78cXFz1I0nS5aUo81wmWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UoKlkUZcSs3TbVA5xTSHrT8pRMdYNNKWy+nmsO+PLQ86zNzJszOVXBRkUsi23NAQLCGCoq5nAOq9KoZK4I5Ma+QYVO2kjOPtG1iLTIvDHkBTFBau7OZt8OP0+BIbqF5Ac/N5MHVbLLYyJmgN6Bu8XZ2VSwukRk2hh5RWoD0K5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XO3DcIHj; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 475B288381;
	Wed, 28 Aug 2024 11:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724837735;
	bh=E6eBuHOeJnF75Hlc+Ja8cChUeuJyaigJdVV+4PMo/ws=;
	h=From:To:Cc:Subject:Date:From;
	b=XO3DcIHj3CYqW5VtBeCsdfRQz3jBK2s1YWdLSissbI/u/Rh4VhISLyy99mnsQfv/q
	 DgIh0pNUtdkPAZOL4n40+G73WUEBstZtgDhcX5qJa+/7m0BC4s3Emjrg5l//flWPuw
	 n7MrkjoxMZ/kqQUc5g+3HiGM/rqbHW7I9zVEFO/d56HYVIFMVyuT39perd5U7qZPlE
	 m1gi1IK98i0ExzvTKn64KQUn3szNpqCJMvsc8uxupzOTK2W0S4h4Ux+nkHRcRuR27F
	 vyS3r35+bBUnisYFnLW1fBLqFjAlCDCd1jhJyGZkPC1qGHCRiu6V3HrGIoXkr3/sCh
	 SW2V87KENSHfw==
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
Subject: [PATCH] arm: dts: mxs: Remove not used "fsl,imx2[38]-icoll' compatibles
Date: Wed, 28 Aug 2024 11:35:18 +0200
Message-Id: <20240828093518.2628817-1-lukma@denx.de>
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

The 'fsl,imx23-icoll' and 'fsl,imx28-icoll' are not used at any place
in the Linux kernel - instead for imx2[38] the 'fsl,icoll' is used.

Hence, it is possible to remove them.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/nxp/mxs/imx23.dtsi | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx23.dtsi b/arch/arm/boot/dts/nxp/mxs/imx23.dtsi
index 0309592af1e1..914cb6b9cf5a 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx23.dtsi
@@ -53,7 +53,7 @@ apbh@80000000 {
 			ranges;
 
 			icoll: interrupt-controller@80000000 {
-				compatible = "fsl,imx23-icoll", "fsl,icoll";
+				compatible = "fsl,icoll";
 				interrupt-controller;
 				#interrupt-cells = <1>;
 				reg = <0x80000000 0x2000>;
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index 73ca903b8723..656260c2ae88 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -64,7 +64,7 @@ apbh@80000000 {
 			ranges;
 
 			icoll: interrupt-controller@80000000 {
-				compatible = "fsl,imx28-icoll", "fsl,icoll";
+				compatible = "fsl,icoll";
 				interrupt-controller;
 				#interrupt-cells = <1>;
 				reg = <0x80000000 0x2000>;
-- 
2.39.2


