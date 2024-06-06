Return-Path: <linux-kernel+bounces-203936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A958FE236
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB306B27413
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90D6155A5B;
	Thu,  6 Jun 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlNJxiDR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCF14E2D5;
	Thu,  6 Jun 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664564; cv=none; b=rfeXMxfcIGfUbmmVBmF7hAEtMevpE4dtzkmXWmCzcTcXTxxUVdhMnaXVZRV7Mq3LjpFvY/kTrgDLwnB5Q5sUGZhh0B1yUSwWRUsRzO+rQRe4Di647F10uLZf0qzWjhLXwlqcVlPYwjEDeD5f66noxG77qQFEgJL4eDyH+80j/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664564; c=relaxed/simple;
	bh=bp4RUBBoDBNxBmueQhwpMXLVezAaB2zJTWzVJs7lfD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuL4I9MRiElofIR6TykQmsUQ0NRGkFwUQNwsUaNgladr0lYOZ6zAvg4VipoAI1gR80ftGc1D5tvZdue+sIWKKgjxXfMLlH65gAKTwLGM6Oam4n1sUUvEOD8K5sfiBCzpzHSI75blO/4weYIUJKBPFukYSZZWVVJbhkMVSDYAtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlNJxiDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC427C4AF5F;
	Thu,  6 Jun 2024 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664563;
	bh=bp4RUBBoDBNxBmueQhwpMXLVezAaB2zJTWzVJs7lfD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YlNJxiDRaGHkVH5WhmlcZSrI+sJBY+wep1UQVXW9tnJKzgo6iJBr3IgShNs0hEKuG
	 VjLYoItfd7mfxkfqoJyoKQriCbDlj+xOIdOuK/Ojf5IfN2gZTUtQvKw3LaM6TP4ViE
	 5iFcmqH5KTHDmlLn+E7xHhXCXB6Vv81pr38QBKxTEXz7yeiQWBojZwLH2PdSCYSGXS
	 bDI+vNrVkNaIhqxJl0PIMQURWZsuE+9PSSxId6esWjRWpcSrVj9TXKySykLwl/x0Im
	 OcQErxcTWMbjrhlRV9378yUtR9oc/31mVsuucyBiT9Vv81RVxe45ChLWGoe7l2pO+5
	 DhMvqIUDUZpJQ==
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
Subject: [PATCH v2 07/13] ARM: dts: imx6qdl-kontron-samx6i: always enable eMMC
Date: Thu,  6 Jun 2024 11:02:00 +0200
Message-Id: <20240606090206.2021237-8-mwalle@kernel.org>
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

There are no variants of this module without an eMMC.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 4a6ab7e7908a..4d3cd338a707 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -800,7 +800,6 @@ &usdhc3 {
 
 /* SDMMC */
 &usdhc4 {
-	/* Internal eMMC, optional on some boards */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc4>;
 	bus-width = <8>;
@@ -809,6 +808,7 @@ &usdhc4 {
 	non-removable;
 	vmmc-supply = <&reg_3p3v_s0>;
 	vqmmc-supply = <&reg_1p8v_s0>;
+	status = "okay";
 };
 
 &wdog1 {
-- 
2.39.2


