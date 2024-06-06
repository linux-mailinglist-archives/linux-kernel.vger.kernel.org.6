Return-Path: <linux-kernel+bounces-203940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B988FE228
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D99928BF7C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891CC157E6F;
	Thu,  6 Jun 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGUh5aoN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BA157A5B;
	Thu,  6 Jun 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664574; cv=none; b=Mn5UJ3wmhv/ej9WtQuCIqv4uZPUA40NyNLqF5NsbHapNjIWjLp+fRwLZVY5kqP+siHAiIvEgRd/mlg1X8IWQd2VoXkbfeGPKSYSziua6CRjjUHZu8YkP+E+kSCk4B6Debb9bm+LlbxCxIwZD/fh4omSZjW2WJixUAIGIOql3iB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664574; c=relaxed/simple;
	bh=Ac0H5gsqJQqS6HEYwakvjdz1l4aupakPJ75lS4SQt4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNy2G+9Csx4tphPbLTQ9eC7fyX4TGfxoWxPVTXndb/QosVEoI/iqjow9TXTQtlCU4M16vrd+4DTQpDHC1/1F2gIYwXKMDiu2Zr1gGH4uhgjb+LE6MhQbIgekYSh7UbkcCxU9ta96Klj4164DDYVTckObWYV08w+Q0qOk2Z+HBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGUh5aoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438B3C4DE1B;
	Thu,  6 Jun 2024 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664574;
	bh=Ac0H5gsqJQqS6HEYwakvjdz1l4aupakPJ75lS4SQt4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGUh5aoNKysWnsSAw5yxxaGgSYTbQoY9sklA+yczouB+8Px90XMriTbLfohP6z9Sv
	 zR+bnBMPDVT+J4LZpvPhoSY7D1Doo2hrhm8/d0L6N6ny02LXRn5aG2SLuhdfYyz4h9
	 rvHjECWggl37ELVWymoFvxNoSwLIwr6aBVXClfK8CdZVm9KNjaK/aIjVjFS3j1roQe
	 JPjybbfgUnxBUtPHXQXVXGg7fWBExS2F/61JLHzY+PnucXIup/Ij31NaOFYPWGW9Qd
	 PSFzPTXALe9vRjeo3AvHspzCZqW9U1i6OnJBetz59L2Tt9AT1/rr1Ush/QXNqCuchf
	 Xk+73evNI3CdA==
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
Subject: [PATCH v2 10/13] ARM: dts: imx6qdl-kontron-samx6i: fix PCIe reset polarity
Date: Thu,  6 Jun 2024 11:02:03 +0200
Message-Id: <20240606090206.2021237-11-mwalle@kernel.org>
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

The PCIe reset line is active low. Fix it.

Fixes: 2a51f9dae13d ("ARM: dts: imx6qdl-kontron-samx6i: Add iMX6-based Kontron SMARC-sAMX6i module")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 85e5adac6ee9..4c4350d08d47 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -744,7 +744,7 @@ &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	wake-up-gpio = <&gpio6 18 GPIO_ACTIVE_HIGH>;
-	reset-gpio = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	reset-gpio = <&gpio3 13 GPIO_ACTIVE_LOW>;
 };
 
 /* LCD_BKLT_PWM */
-- 
2.39.2


