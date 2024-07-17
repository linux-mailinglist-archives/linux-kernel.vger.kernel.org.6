Return-Path: <linux-kernel+bounces-254981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBFD933A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3917C1F22927
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF885589B;
	Wed, 17 Jul 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPVej2gA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11BB5644E;
	Wed, 17 Jul 2024 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209108; cv=none; b=YJDIQEgjfOUngQYDeS4ArtNYm9TPcPVnzLs+aJG3Cbb4bMMWLAyy0ruYtTcwl6/fT4Rg6dFAlkPWn2CtDc7CLGdOH0FrbskcO+QVCj05LOg7wZQqerXAqxu8jhR40bFRa8mn645YXj9yptNJg5Pdmb/zcKmgHqDqib7gMyBOZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209108; c=relaxed/simple;
	bh=zR+H4DU723yvn4u1sKhvZiiUDXT8gBtuFekq4R3cabQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rM93oH+vdraObDYKxVB7fqHiqm4q4FEhrELOISxvJLCo1DT7Fh/SLzO67ml5efqv/hZL6vwKWVgiNd7X7Drb+xCgkxRoAw+S0I6fYAmIOWrxlUkGDbELYY+c/StQIVbTSuqr3fD6bZyIgGltK8lpBLFRqn5au1u2u4cEqdWu5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPVej2gA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA53BC4AF0F;
	Wed, 17 Jul 2024 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721209107;
	bh=zR+H4DU723yvn4u1sKhvZiiUDXT8gBtuFekq4R3cabQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPVej2gA8JptVbJk2M/36dnUy22qkdvXsA6vuh/xH3HzmBBMtZxlZKp51zFG5x2Y0
	 aDfRVSe4UzoEqlj52fpCnYycaOtfU+Lfl51Xe20duHWD7NpkEq2ik2cFhGBFWJYx0A
	 kUYss1al5DLi3Ydn76ByDOGJIBA7ZrsequKKfyE35YEmKY99hGRF+yEkRAT+r1P1LS
	 yCVp70VCBsh15Jx3246fAvfenmhuIrthje3UjrDXOMPjBz1A1+KaiDG5nSCHbx/k0y
	 V5FYSNeVi8sUId1EATJcTaFH89cMEZsLBuNcXUe3EA3qXd7TdgrpHhrji+YMeDSuoG
	 pKHTPUjpGvTww==
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
Subject: [PATCH v1 4/4] ARM: dts: socfpga: remove non-existent DAC from CycloneV devkit
Date: Wed, 17 Jul 2024 10:37:56 +0100
Message-ID: <20240717-partake-antivirus-3347e415fb7d@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717-anvil-ashy-544e80a1317c@spud>
References: <20240717-anvil-ashy-544e80a1317c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=fbDVTS66SQLTObr7U5FvofO+Awu0zrlwHhlO6xFXdHE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnTJ3z6FXZpg0Oi/2bJTNefzN9T18Za57ZcOSb8pn0B6 +rnW902dpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiar8YGd7+3yv0spAt9bSr UPKhx2sbT+WHqFZrnYpfevbvbd+ZX7sY/hkIeviLS6bwMIQqLbT93vanaG7ikSUhTguvHZIwun7 vIisA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

There is no Rohm DAC on the CycloneV devkit according to the online
documentation for it that I could find, and it definitely does not have
a dh2228fv as this device does not actually exist! Remove the DAC node
from the devicetree as it is not acceptable to pretend to have a device
on a board in order to bind the spidev driver in Linux.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_socdk.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_socdk.dts
index d37a982e8571..97622febc44e 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_socdk.dts
@@ -151,12 +151,6 @@ partition@qspi-rootfs {
 
 &spi0 {
 	status = "okay";
-
-	spidev@0 {
-		compatible = "rohm,dh2228fv";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-	};
 };
 
 &usb1 {
-- 
2.43.0


