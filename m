Return-Path: <linux-kernel+bounces-200766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D78FB4DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78B3B2D0E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E2413D249;
	Tue,  4 Jun 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGsGogX1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91717BA5;
	Tue,  4 Jun 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509603; cv=none; b=c0z74dO6dyFL1v4OF55q5ywqXP8X5TLA1zKz7O/18jUxVXpL+WuTAU/Zgf+LsfO1PXp7q1BAxPgZDGjjnyy/11J+E1g9Qlut09FeB59ht796MsFjVFxZpiZy6JYUsadOmryu7bf5xfxRr55TjuIkhOulqSRA2pmSBFwPiXHZuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509603; c=relaxed/simple;
	bh=pyCuKjBDzEztSGL5VPV6DvGUsY4tB58LJ6wtMtXdCKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mCTWS9p4zKk0NvUyfdgJjJvlvwMtDn+jqDxfHAPpu1a/jVwxHtg1MTunASiyeyDvMjO72UgcMe3EUxFnb8pE80DtK1ZPN8mEnu3GWy+CrAK0g8h1lV6UtqVghuasXoK3Vzre74UYmf2n9q2O/1qBoy8iuCSQMShR6li2uCWnAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGsGogX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBB2C4AF08;
	Tue,  4 Jun 2024 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509602;
	bh=pyCuKjBDzEztSGL5VPV6DvGUsY4tB58LJ6wtMtXdCKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGsGogX1Rff5OZP/fg8dZcaHUX296tarnWi8+y5fqmKcVPyoxViU8VehFvUhCclSS
	 H7rxF0Atv120NqCRniYpcHvxZUj7mNCMqsXROm/hhUiazarxz+XUARZt4JgVzt3M2O
	 ALdAPEniThHo6zDvjfj+q59AXXYMT0tXVK9kUaWVM32fFGqRF0jsdfmvPMWBIUr6Bo
	 p7iBK29Zo/xlueS6gO/uPQ3k5ir0mFqCmwYlEoXtALuONkKlNoif5CJbdO6oZ07tPA
	 gMqfT8siKnXneH3f9xBafqlPcCJqWe0TdAmJ3tT4i+m+27JZouOkZfBtMZoz03BORd
	 hRqI665E5QGcQ==
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
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 04/10] ARM: dts: imx6qdl-kontron-samx6i: cleanup the PMIC node
Date: Tue,  4 Jun 2024 15:59:28 +0200
Message-Id: <20240604135934.1951189-5-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604135934.1951189-1-mwalle@kernel.org>
References: <20240604135934.1951189-1-mwalle@kernel.org>
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


