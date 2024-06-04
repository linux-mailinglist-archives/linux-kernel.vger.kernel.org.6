Return-Path: <linux-kernel+bounces-200765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C19E8FB4A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48CB1F210E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB79136663;
	Tue,  4 Jun 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWjTgzr1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2A132C3B;
	Tue,  4 Jun 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509599; cv=none; b=IsGUx56hJR5+/o9Ohdc2FPvpIjhXB/ucF8e3/tMUp/oeXDgl25V3Qu+JlXDMr1O0Y0XiBgI7Ahls8YKqj3nUg6tTQJq/qypb+mxY2MtxIPVm7gPUoIXSDx7XDcxBo2JUrcKIofYDAIh3Ga7XF0izjNEM4JbjukVUr/bfeaqWD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509599; c=relaxed/simple;
	bh=pmxH+3/T6ldwrIaJrUq9EPud/gdsJYcTk1L1yQXC5Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhEG4GvUnQnKGwD8K6pwI8m2AqsBLdGHPH/7Nd6uf3xizpzsCtyFR/eBlWtYKYoeeOafhYa9sHGkEZGujOuZqaJ8+63MYu8krACugjG8iW/xS/MiwaHPZbiZXk4RTskIH9fvcG0r1lriCSsO2V+x92tPtAGVSHVgq2bGQimA2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWjTgzr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DABEC4AF0A;
	Tue,  4 Jun 2024 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509599;
	bh=pmxH+3/T6ldwrIaJrUq9EPud/gdsJYcTk1L1yQXC5Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWjTgzr1Ptqbqdy5Pd6ic/b9wCn/kdyxwV6JUkUiTOADIQSUrZrXa5I8apEAUYi59
	 oJHPb/1TtSz00s1cWAGiYnYFCNTw4tED1Ssxmu0JWNx4Y2vj9YMMyRPCH166pVcdC5
	 7HILtsZXM2XG6jWixxC36gTrCaewYK5mia98fDZpICQuEqYUov7kaNCFskrxHI4yJj
	 ayVO1R4aongYVCHQwlYgDO40g33/maBd2TgDCsnYhmvvke2pHHcsbis1XIutoY0DNp
	 MlsKwX9cg743IF/0V6AbFzNGZwlg0eJk7U+kqP2NCC853jyXPKt9mJRXdnl1dfp6yF
	 OlcOOx6PanRlQ==
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
Subject: [PATCH 03/10] ARM: dts: imx6qdl-kontron-samx6i: fix board reset
Date: Tue,  4 Jun 2024 15:59:27 +0200
Message-Id: <20240604135934.1951189-4-mwalle@kernel.org>
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

On iMX.6 the board is reset by the watchdog. But in turn to do a
complete board reset, we have to assert the WDOG_B output which is
routed also to the CPLD which then do a complete power-cycle of the
board.

Fixes: 2125212785c9 ("ARM: dts: imx6qdl-kontron-samx6i: add Kontron SMARC SoM Support")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index d6c049b9a9c6..700780bf64f5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -817,5 +817,6 @@ &wdog1 {
 	/* CPLD is feeded by watchdog (hardwired) */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog1>;
+	fsl,ext-reset-output;
 	status = "okay";
 };
-- 
2.39.2


