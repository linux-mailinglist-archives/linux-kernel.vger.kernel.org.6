Return-Path: <linux-kernel+bounces-203941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49938FE22A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F88F28BB73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065A158858;
	Thu,  6 Jun 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXioOAUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AA8157A5B;
	Thu,  6 Jun 2024 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664578; cv=none; b=fYoslkxfhM7cXUeGRwxJZA1zVlNgfBEK7ckuK1ouxizjQMqh2gVA1HYcnsvplhWkUMUK77O+WqMD4ndPnRzelugkPUDPtgy/FT7W0WwQ6G8anWC35I7G6PgkBHyykSfxyAxeyK1J1/qXiGVjOS4CyRoaBY6zY8s7uEAyaGS6Hw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664578; c=relaxed/simple;
	bh=Ayp1GAg5GZOVlDFPj51RZap8aLw49SuJ2rC7zWjR5dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ryw+oaVGhSGFMlr4cpFGFwpgby4iTxuDTLX/rUWXTR15/t+OUpVCkWwEccL07JaMMXw0lYM338A4HFDh6GQpxfQ40lgZ9sstncX9b3yYnWhapaxdf9S8kuTLBc7lQ4uUH16+lmRKtEpg0h9uXFuft0wXasZKj26WP7YOy6iJNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXioOAUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17F3C4AF5F;
	Thu,  6 Jun 2024 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664577;
	bh=Ayp1GAg5GZOVlDFPj51RZap8aLw49SuJ2rC7zWjR5dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXioOAUQRiXWQkqdFGJXpk0HHLYJP2HoNXZik7Emj+iXE3ltVc/dioEQNPFburAxc
	 Pm/u9PVFTzPufOthikw3ptmETR4WZmk/W9Qo+69/dfp1QbK5XIdrzu+s1dYnSu49IO
	 c2Ok2fp9y8NX7hxjm8765yFbDbQRRrKZCy6NJGLNyXWuTKEosIRVa5a23wBvIx0HGQ
	 xvc9zdkCa5YgXxvYKeZzW3y+Kytxozs/96dv3kswr5Ai7j6JpW+rF5gX0QbPKjf8gI
	 7pyVohlMMsC9ujTiUjzls0ivEvQu7Msy392wgHLseJFEqbP4VV7xOHQ/mvzj6nLr9D
	 E5dC3aGWQiFPg==
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
Subject: [PATCH v2 11/13] ARM: dts: imx6qdl-kontron-samx6i: remove wake-up-gpio property
Date: Thu,  6 Jun 2024 11:02:04 +0200
Message-Id: <20240606090206.2021237-12-mwalle@kernel.org>
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

Remove the "wake-up-gpio" property within the PCIe controller node.
There is no such property, thus just remove it. This will also make the
schema validation happy.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 4c4350d08d47..6157fd2817ba 100644
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


