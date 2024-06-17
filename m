Return-Path: <linux-kernel+bounces-216984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4C690A992
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515E4B2D6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429EE195B19;
	Mon, 17 Jun 2024 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4dwVvfc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C72191487;
	Mon, 17 Jun 2024 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615671; cv=none; b=PUfo9NpUA8duGK+UJTBuQIhSQMg+AuC/74n5LapkK/p34S+z+C2c76YCkMaIluwaP4xjm2jdn6aTW8xDLyznrvqtkQujWhU5RBQC4UpBHmv7DvRa5NuwX1Hwk5utkSdYidTQWXiiaTEYs5SebSL/ZDdz+nrs2c1Sv/fZ4H1yhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615671; c=relaxed/simple;
	bh=tpQMAObsPqtgZVeWEe00fFNPhp6LEVK8ndsh5tnhczo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6944jfG2cRWnf+qZvj4tQOR5G4HUdic2q5YHCx9dSckg4EFcxy1YFG4cE3wCNo8WIxCHxKMI9HQyA32L3vQrYOaoTgKyZuQg2ZtYTZsyw2euuiL4sCubtvFUj4tIh3dIQNUoXHPytm09AOzlGVESVXfdda3ms9VgxvDYJS3el0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4dwVvfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC7FC3277B;
	Mon, 17 Jun 2024 09:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615671;
	bh=tpQMAObsPqtgZVeWEe00fFNPhp6LEVK8ndsh5tnhczo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4dwVvfcNTCt1bF/ICsimD35oDx+5E0WVm95gTE5aLrpQFgLRElJpIeb/28XgrWCu
	 6Tm8iWG/hYONPxw5Zcmg/zq1+cC8DZ1RurJobITW3zv7iEqkyAbyPTCwuhgshfCJBj
	 a3yFgJHZOYfhfnJqjxFqRaX/vvremNjmvW8QJo4HuY91SAZNsJKZFnmWoAXK6Wiv7j
	 zH9bbatRhuc7b4AEykVXE1KxaHGPhdI39FC/ucdMrYb5gQZbsCYSa7EzyRd669ZpcP
	 3qLQGdrLhm5xK1fud0Z2ZJTpEk4gX3piEZK0EKGQTSNTeGU8IESPe1mV2DittpiMn0
	 f9nRivLPhF/mg==
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
Subject: [PATCH v3 11/13] ARM: dts: imx6qdl-kontron-samx6i: remove wake-up-gpio property
Date: Mon, 17 Jun 2024 11:13:39 +0200
Message-Id: <20240617091341.2375325-12-mwalle@kernel.org>
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

Remove the "wake-up-gpio" property within the PCIe controller node.
There is no such property, thus just remove it. This will also make the
schema validation happy.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 17abebc006df..99b5e78458aa 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -743,7 +743,6 @@ &mipi_csi {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
-	wake-up-gpio = <&gpio6 18 GPIO_ACTIVE_HIGH>;
 	reset-gpio = <&gpio3 13 GPIO_ACTIVE_LOW>;
 };
 
-- 
2.39.2


