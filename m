Return-Path: <linux-kernel+bounces-200769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620628FB4AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9399E1C217A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217314375D;
	Tue,  4 Jun 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZTqIUin"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094E1EB26;
	Tue,  4 Jun 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509613; cv=none; b=AdOt+TeyIFumTogb2TlpI7NZNFj36Ijiv2/WmBH3zMlxzKtbO0wLFHaDSa6c4xFk3LblnzBqF4D2NcwdIfXOh6aBXxs64Dy2mFvwPxQPJDJPKDrMmwCHKg0nhE2QZvTsn5IfKY4MSna3/G3HaKGr/YDGcdk5aRQt1g01wjneFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509613; c=relaxed/simple;
	bh=bp4RUBBoDBNxBmueQhwpMXLVezAaB2zJTWzVJs7lfD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYvZrDiPmy+54DpbvWi1IFa+w/jrO9VC0Smm4nM8M0VNL9t4qJtKMUE8BRJfCjljk4FsSZQpm3ruP584cjEZzgS1vRukfDYv44tP4DhyxZ7jSbqmAamKKeZk2Tjfi80wHuaHaPBxOnnveBEcPB8C9H0XyVxDncI7OPxOfk3Qpno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZTqIUin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278F9C2BBFC;
	Tue,  4 Jun 2024 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509613;
	bh=bp4RUBBoDBNxBmueQhwpMXLVezAaB2zJTWzVJs7lfD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZTqIUin6QMORoeiFVbD804WbJDlgJ7D5GtxruxhrtSHTjJQyYCVzoKPGvLAa4E2j
	 ofSSDd2suDVVfLZ1TlDX4s653lNKNPEHAtJvJQCs64r6q5f75cDDVzhKRI3elI80xC
	 rtQ6eYScDyQItOnoG6srCQee12gBfXHNNhpA2/JkLHhHkkRq/HlwYl39n4mapXGGAJ
	 3qaUii2Zo9ekQtEWPa2ONsDwROdiQpJm1U8QyDeebCg/vuObbHBk47p6Xn0HQlyeSb
	 16CsS7X+YOA181TdABY75YTewaDVcNr3vun2FjarbbDFSoP8NlM21ZzEURBlvxk+OD
	 09/WG9cZUz/pQ==
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
Subject: [PATCH 07/10] ARM: dts: imx6qdl-kontron-samx6i: always enable eMMC
Date: Tue,  4 Jun 2024 15:59:31 +0200
Message-Id: <20240604135934.1951189-8-mwalle@kernel.org>
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


