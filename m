Return-Path: <linux-kernel+bounces-203933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C186E8FE21C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7741C25212
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF7213D8BE;
	Thu,  6 Jun 2024 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFUno7hn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7829155337;
	Thu,  6 Jun 2024 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664554; cv=none; b=plxpoMxxhvkDsMOhhSXTYaZqYaU6Ffq6LolWVBklYFcMUG48LFMmLktwHGLzQmUAnSav3+VAEMXWP5t4DnWerCRvwsKjEAKdeQ1YsrHo0TsA+l+qh19GwTlIGgrzGA+0ZPE0GgXy2BTGOYCmRJN0YNfnuZ45+16lO7NAF2XkERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664554; c=relaxed/simple;
	bh=pyCuKjBDzEztSGL5VPV6DvGUsY4tB58LJ6wtMtXdCKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYR8r1DQe+qLMn3zpeWgD4jmFgHnD63HiIO8lm7CXHBkNIUPeHsqs/R8Ok2P+vTqNdYEsdJ4HOmSmzGE2JW+V2vUYtJyrWMvFUL7s8cpTu/1T/ZzIh4s/7I/33L++0LDG0E2ih3Qh4OiM/eGnTv1zD1ivhfuo/xDZtHGrDCUXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFUno7hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DD5C4AF65;
	Thu,  6 Jun 2024 09:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664553;
	bh=pyCuKjBDzEztSGL5VPV6DvGUsY4tB58LJ6wtMtXdCKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFUno7hnMWnn11NK3ljLrMOmwnTfoUXDXBb/qiUqpfDm7g8JFJVSJAzO7a4S7y0Pd
	 Lgb/Bi+lY2w00kSDWpMuKI18ZMAa/mLzW8+okT4wHvRsqW3EQurqrSfS0h4ZF61hCg
	 pfE3IChzlf6Vbq8P/O0w0Yjzj1ebvZEaACKOM6fIldVSbnzLwIpy9hv/T7ymJRNt2G
	 PNpZ7qgeMzcuBUGVs5GZSAk7K94oI0CCXHix/xJWet3iIgjR42Wtzjalm8yjEVx4O6
	 oFLwxp6glnxOC8x8/Q/stlX9kw0vV00nm09IYV2SAQZpvb2f+JzaNeuAA2dF3TV/EZ
	 +zKYNefXgZzEA==
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
Subject: [PATCH v2 04/13] ARM: dts: imx6qdl-kontron-samx6i: cleanup the PMIC node
Date: Thu,  6 Jun 2024 11:01:57 +0200
Message-Id: <20240606090206.2021237-5-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606090206.2021237-1-mwalle@kernel.org>
References: <20240606090206.2021237-1-mwalle@kernel.org>
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


