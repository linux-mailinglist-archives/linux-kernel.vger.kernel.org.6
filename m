Return-Path: <linux-kernel+bounces-254979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939D9933A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAAA1F246B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C584D8BC;
	Wed, 17 Jul 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGMPjDAh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEDC4D8B8;
	Wed, 17 Jul 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209097; cv=none; b=ufV0CI/nl90YUVNthImhsGNQnffOJWz3hkncKzSFiqFwqcEAIWRfZQFHf4xQwnsLaKCf2t+Y4zV1Nl7Lxz5cxvL/YODoDFDw+mZs2q3NjOrmUkj4ehmARHonf0t5V1OPWWT0BaBwdssJbdMW9+t6r4Rl9PK7qCEsegahoykEwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209097; c=relaxed/simple;
	bh=msJRc4jOmo8X3ZitZ0CBdwvlEyzT87CXS+Smk6niWEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHMZLbJbAiTvuP09w3Y+nccjCwrksAnjFi/cJ19ymSvTl10bYaPhe0J4jRFDy06j97XMA2+ziIPC7yqUF0Imhnwgt3aitTBTERK+tpuxkmJ9A8FeUgT8f+40Ya41GXVA/zVl+rbS12162mElBQRU0PNIOHSqXq3QMyGmSUBVC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGMPjDAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F781C4AF0F;
	Wed, 17 Jul 2024 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721209097;
	bh=msJRc4jOmo8X3ZitZ0CBdwvlEyzT87CXS+Smk6niWEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGMPjDAhwadBEbuN1mY54jiFyNyTGNOKIcIsivKjlt5jKe9SA6a1p0+7Zk2/uVumK
	 EVVgvo28/usYXekHiR9vBjMe/75Il6heV/pmpGmqHd5dndy/739v0+6NoISlhHufjm
	 gORW0nn4LF6T/VUMvKT8KCbCyxf5BIxqKNDRKWMLl3sHdZB9letDBFzFYLJ8hCePCY
	 gnVBbY1B9SP0cia3yE4fmyXr7JuAsmW4KxconnvDoeVtmQRigkK+og+kqiGdJEkjD9
	 hMWaDBsbIZJQ7OheKC6LMA84FCigkBXGaqiKl4zAzmoBlhUfXKvFpg2D7FiYJT/nDk
	 h3Sk7FSID22KA==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	imx@lists.linux.dev,
	loongarch@lists.linux.dev
Subject: [PATCH v1 2/4] ARM: dts: rockchip: remove unlikly-to-exist DAC from elgin-r1
Date: Wed, 17 Jul 2024 10:37:54 +0100
Message-ID: <20240717-parrot-malt-83cc04bf6b36@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717-anvil-ashy-544e80a1317c@spud>
References: <20240717-anvil-ashy-544e80a1317c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=MSCoCs+nCZ6kB0uJ7jdevDa476eowpEIcz88i8dEKdE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnTJ3ys8n7Utfzn6f1/W+KE5jBkd/BffrFwSfWlrIkLJ 1k8WvmpsaOUhUGMg0FWTJEl8XZfi9T6Py47nHvewsxhZQIZwsDFKQATWSXL8JvVfIPtJKdH0j+r 7Y3ZZmcYrG9kfm1hdPNH/2qL10cnrK5n+F/dwZipV8nuu6Zpppjo6/3fdh4z7etMy41sMco9cdB GnQUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The Rohm dh2228fv (really the bh2228fv, the compatible in the kernel has
a typo) does not support frequencies above 10 MHz, nor per the
datasheet appear to use either CPOL or CPHA. I suspect that this
devicetree is abusing the compatible in order to bind the spidev driver
in Linux. Pretending to have devices on a board for this purpose is not
acceptable, so remove it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I could not find any documentation for this board online, and it does
not blatantly say that the device is a "spidev" like other [ab]users, so
it is possible there's actually a DAC here - but I doubt it is a
bh2228fv given the other incompatibilities.
---
 arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
index 2d9994379eb2..9df1cef406c5 100644
--- a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
@@ -167,14 +167,6 @@ &spi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spim1_clk &spim1_cs0 &spim1_tx &spim1_rx>;
 	status = "okay";
-
-	dh2228fv: dac@0 {
-		compatible = "rohm,dh2228fv";
-		reg = <0>;
-		spi-max-frequency = <24000000>;
-		spi-cpha;
-		spi-cpol;
-	};
 };
 
 &u2phy {
-- 
2.43.0


