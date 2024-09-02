Return-Path: <linux-kernel+bounces-311247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A068596868B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A35D1F2376B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2719F1D6DB6;
	Mon,  2 Sep 2024 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="oD1K7pIx"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72151D6C5F;
	Mon,  2 Sep 2024 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277639; cv=none; b=YQvvtC11UgC5Fe7yopvCzB3SxkrXmMPhZ631qqThNsclD/LqWIJiV54ZKBlhqVfIjl3NBAQc7lCEMBEfcKA0e5ubItjBqjmdnRhD18bIJXp3Ai4Z+wbd4xPxC/x01A8RXEu+SiY7lBVuOt808TRc7VTPO49RjJQHCBqJXRTR75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277639; c=relaxed/simple;
	bh=ph0MXoamEmViMh9DYvXuPU1uK0cgYTDOZbMQjokOiXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H5vV9YuOZuAmJmAZXg9YjwkPBavyPnbcioAW/rKmV9bZb1MGppwQpJUDHypY+zykIRU17ZLSB77SSOD/puDQuCIkho/RNNEPg/ew/picwv2OHcvWKpn95uAiqzwNavIEpKQXFw4YZuftLpOocOqJIK+coQBin6ch9eU7UCGfHIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=oD1K7pIx; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 940A988785;
	Mon,  2 Sep 2024 13:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725277629;
	bh=P4vx2HgIR3izh1J5lW2uPXrQvIDhXOL/Lp6N6ZdGDzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oD1K7pIxexTWCY7Bpg/yDdcKIIYW6UbhmtpLBQw6/13pL7deVunHNSW6wXqVZkmXd
	 vCsSr3XOytu1FotzH78pvrSPcYO2338QaKleWvugJRUjEUvkfJBg7C398EDm01BP3y
	 WlgR1wMpK7Asml0OqWrg7GQw0FhOunjx4IGOeeVgYcMw0Dcho0yO9CQ4tK1y3kmrgW
	 SE9TCf1kcgcvwdeyHWXGkRQfMsO5ybGFipYAoiXTjFkt09NxJc7siaPu2UCeodb23i
	 Iz1LLF0yNkdfhhOMvDFY+n/mwcaf1Ut4vBSqhoLflgWQHn7fKALmAoymhtN2RL5HsS
	 kemOQWfhcwkQQ==
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
Subject: [PATCH] ARM: dts: imx28-lwe: Remove saif[01] definitions
Date: Mon,  2 Sep 2024 13:46:52 +0200
Message-Id: <20240902114652.893272-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240902114652.893272-1-lukma@denx.de>
References: <20240902114652.893272-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The saif[01] nodes are specific to other group of the imx287
based devices, so need to be moved to different devices description file.

Leaving them here causes issues with next revision of XEA device.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
index 0fc74eeac217..410dfe17f8ca 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
@@ -55,23 +55,6 @@ &i2c0 {
 	status = "okay";
 };
 
-&saif0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&saif0_pins_a>;
-	#sound-dai-cells = <0>;
-	assigned-clocks = <&clks 53>;
-	assigned-clock-rates = <12000000>;
-	status = "okay";
-};
-
-&saif1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&saif1_pins_a>;
-	fsl,saif-master = <&saif0>;
-	#sound-dai-cells = <0>;
-	status = "okay";
-};
-
 &spi3_pins_a {
 	fsl,pinmux-ids = <
 		MX28_PAD_AUART2_RX__SSP3_D4
-- 
2.39.2


