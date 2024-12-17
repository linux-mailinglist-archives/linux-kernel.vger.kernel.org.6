Return-Path: <linux-kernel+bounces-448933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D751C9F475D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0FA189277D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E91F3D3B;
	Tue, 17 Dec 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="kK/sYAt9"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96FF1DF745;
	Tue, 17 Dec 2024 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427126; cv=none; b=qgxaUSGburPFldKIhOpuW+mVzZPWpZd8OaCOxTORJS3ZSYyyzDBOjTgQJTAzanzox8I+HZHvG4iyAuKxhvwauOphtpZdDb9/cVLRZluC+xxrmbj6xmnt+2pTJJDcrmT2GvGWcTQ2UNtm07AGm95G1ddeYcSFB7kg4RK6dxFBRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427126; c=relaxed/simple;
	bh=x/GxERwdVAEe1lvmOH/CrLeBwrQyaQW1dyBt9ifgMYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6Gny/T2JtRBe1yM1Ho5BL17yZ4Zkc37d3CH5bvM67UbkDek6xCHYmpep58M++R+IbhJx2z4hHu0w8jlh3hc5oxXxNqeNgo1DqGETg48hF6HjSOC/xhbDFr6XLqG9WEN72FaBbuaPcSrYt4qANaDmR0ZAD1APpvhXdij5ovkGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=kK/sYAt9; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout2.routing.net (Postfix) with ESMTP id F18AF6025C;
	Tue, 17 Dec 2024 09:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C9RBnRSti7f7SgIlq7qr6tqFDDd/TA3hM/2DzBsoiDc=;
	b=kK/sYAt9QaMOQk/Kh8q9ds7yTLape+FyzYhjlfI5KX0vdxLYhW6/110fiEZd9KWnk/ifh6
	uUhIj3Ctro4c/8XE8OI+Kf8r4h1/Wn/9WeX1dAEIXdS7T3wYt6ZrvUtw7zXtlm4isfYm7i
	yC5fzGGauZFBt3poeCe1rLro+Zjm1n8=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 2765E1004DD;
	Tue, 17 Dec 2024 09:12:50 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 00/22] continue mt7988 devicetree work
Date: Tue, 17 Dec 2024 10:12:14 +0100
Message-ID: <20241217091238.16032-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 06ab4296-b2cd-4af8-a756-3c2e5162f988

From: Frank Wunderlich <frank-w@public-files.de>

This series adds some missing labels and new nodes to mt7988 DTS.

based on pinctrl-series
https://patchwork.kernel.org/project/linux-mediatek/list/?series=918572

changes:
v3:
- reorder
- small fixes
- add some new patches (t-phy, pcie, mmc overlays)
- dropped pmic and proc-supply for now because we found a mismatch compared with schematic

v2:
- reorder and squash label-commits to where they are used
- add some more nodes
- add changes to bananapi-r4 board
- moving some nodes from SoC dtsi to board dts

Frank Wunderlich (22):
  arm64: dts: mediatek: mt7988: Add reserved memory
  arm64: dts: mediatek: mt7988: Add mmc support
  arm64: dts: mediatek: mt7988: Add lvts node
  arm64: dts: mediatek: mt7988: Add thermal-zone
  arm64: dts: mediatek: mt7988: Add missing clock-div property for i2c
  arm64: dts: mediatek: mt7988: Add mcu-sys node for cpu
  arm64: dts: mediatek: mt7988: Add CPU OPP table for clock scaling
  arm64: dts: mediatek: mt7988: Disable usb controllers by default
  arm64: dts: mediatek: mt7988: Add t-phy for ssusb1
  arm64: dts: mediatek: mt7988: Add pcie nodes
  arm64: dts: mediatek: mt7988a-bpi-r4: Enable watchdog
  arm64: dts: mediatek: mt7988a-bpi-r4: Add fixed regulators for 1v8 and
    3v3
  arm64: dts: mediatek: mt7988a-bpi-r4: Add dt overlays for sd + emmc
  arm64: dts: mediatek: mt7988a-bpi-r4: Add thermal configuration
  arm64: dts: mediatek: mt7988a-bpi-r4: Enable serial0 debug uart
  arm64: dts: mediatek: mt7988a-bpi-r4: Add default UART stdout
  arm64: dts: mediatek: mt7988a-bpi-r4: Enable I2C controllers
  arm64: dts: mediatek: mt7988a-bpi-r4: Add PCA9545 I2C Mux
  arm64: dts: mediatek: mt7988a-bpi-r4: Enable t-phy for ssusb1
  arm64: dts: mediatek: mt7988a-bpi-r4: Enable ssusb1 on bpi-r4
  arm64: dts: mediatek: mt7988a-bpi-r4: Enable pwm
  arm64: dts: mediatek: mt7988a-bpi-r4: Enable pcie

 arch/arm64/boot/dts/mediatek/Makefile         |   3 +
 .../mt7988a-bananapi-bpi-r4-emmc.dtso         |  33 ++
 .../mediatek/mt7988a-bananapi-bpi-r4-sd.dtso  |  31 ++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 143 +++++++++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 303 +++++++++++++++++-
 5 files changed, 506 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc.dtso
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-sd.dtso

-- 
2.43.0


