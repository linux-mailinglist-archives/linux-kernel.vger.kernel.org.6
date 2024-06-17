Return-Path: <linux-kernel+bounces-216977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB590A99C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A609B2C031
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACD6191481;
	Mon, 17 Jun 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcJo24vd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821C1946C2;
	Mon, 17 Jun 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615645; cv=none; b=RRxf9G/qPcoWwgcvKV0DfVxG7yQ59O0ouu3iDgLE7JoAt297qe03n/7hc45Y/c92ePava8BEuBEvYaFWf+ayZnZ7O2Zo63K0Sk9kvx4Rh08QTAHGsEwA7TZMibbb9ipQeEDHggpuoaFHbZPsI9eWfn9BsuhWgZG3NNHz8nFmBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615645; c=relaxed/simple;
	bh=pyCuKjBDzEztSGL5VPV6DvGUsY4tB58LJ6wtMtXdCKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtF2SYC6qQ1bsGwI7MhzdOOWM9eoWQu2a1Jpnz1k0eoMCfDnnsDHT0rMLsOG7ILT9I6uvm2lIUv9tVwBXkguB+LCMYv9KbkA6Qza21cjwTs46+ij7vkVjE6bjdnNNN7m3EmcNb+RxnKIhxIm2fOrj9cSZwa55cLfBCsci5XEPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcJo24vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E61BC3277B;
	Mon, 17 Jun 2024 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615645;
	bh=pyCuKjBDzEztSGL5VPV6DvGUsY4tB58LJ6wtMtXdCKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcJo24vdaFOmcSX4qgULmhUDw9ZyAmfnQojhcYEHB4/oz9kulowztUaKTp8ahoG7S
	 D46WoR2fBKmXN3mqU1zyQwEslixqAO7jplXOlUNmWmDvsKYBPn/EC4FqNn/bspo+Y4
	 ku5GNoUkMCyJKLAMhlBtidYiZgItTUBZup5xiSbXy+Os7BDpk9lE2nf0eNNPbBrt1K
	 Slkoe72fyFSmGHO8CPLOvrOF8+GIK/ZcwMFsQVNJEaBJUn8PQEnjjqJ0zzdnsKnx73
	 yHQNz0TZVkvcVmFIO/BOHw880IDXkJiBAHNgFv5PJ0cpatvIsD2uGwS21gPtGQkRp5
	 oLK74dCyrDa8A==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Li Yang <leoyang.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v3 04/13] ARM: dts: imx6qdl-kontron-samx6i: cleanup the PMIC node
Date: Mon, 17 Jun 2024 11:13:32 +0200
Message-Id: <20240617091341.2375325-5-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617091341.2375325-1-mwalle@kernel.org>
References: <20240617091341.2375325-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the comment, remove the unused phandle name for the
VGEN5 output. VGEN5 is not used at all.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 700780bf64f5..8c7f21f986e1 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -356,10 +356,6 @@ reg_vrefddr: vrefddr {
 				regulator-always-on;
 			};
 
-			/*
-			 * Per schematics, of all VGEN's, only VGEN5 has some
-			 * usage ... but even that - over DNI resistor
-			 */
 			vgen1 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1550000>;
@@ -380,8 +376,7 @@ vgen4 {
 				regulator-max-microvolt = <3300000>;
 			};
 
-			reg_2p5v_s0: vgen5 {
-				regulator-name = "V_2V5_S0";
+			vgen5 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 			};
-- 
2.39.2


