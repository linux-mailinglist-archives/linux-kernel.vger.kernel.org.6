Return-Path: <linux-kernel+bounces-400977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B3A9C1499
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE61F1C2285E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73832194AF9;
	Fri,  8 Nov 2024 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="TcIWlW5w"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB701494D4;
	Fri,  8 Nov 2024 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731036308; cv=none; b=cdrYCCA7ayyJNuZmUS8AHVHNF96e797WdbldUmuMzVk9q1adAG8EPbKtePQoD2fs+DUq5UAtdcRBxmMw2cxPvDlscI5gXbDkF9DgAayVCBnRwYk9MY1REG0YDFWF/WfASatqtGreSmLTN/qwvSpw5gpUKywoF53IyOu5UhIJKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731036308; c=relaxed/simple;
	bh=0sUndmmMbcEl1oliR0PC09lYwEgalj6mW3fOuzC9lf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XnGRPNmsLIAzaDQymsxOLD47kJqOruwkNgHY7VlEJ862Kt0zTqToq6XpW/wkMuObOXP/iF3R1ipevcMmw6DwPwziusw+jjmxFk6JZ/T9/sU+FVwIkCRV4DMnfkbCyq4sKyuEAqlhtTMfAEL87Wsnt+E5X00x8vax81Tavmd+hws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=TcIWlW5w; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.160.23])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 97208787BC;
	Fri,  8 Nov 2024 11:18:57 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 97208787BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1731035940;
	bh=LrwVAJl6tH5AFMtMAyT1pRa6j7wyBr19604m/pE2Xp8=;
	h=From:To:Cc:Subject:Date:From;
	b=TcIWlW5wv/H7dQbsAcRF4cGlEwe0l3Z1PnIOQUjlzgfiLd7MFKykTSeGPracXQCty
	 BrUjirFI+dgmD79k0BlEFwHSc1eLfPjKnFxMVM0MTO77zetRXoQoXkK2PNTLWg0/W2
	 wjMR6VvT19d7kyTTmMk+lGtZnTMG3kvYPWlVibuA=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Add support for Ariaboard Photonicat RK3568
Date: Fri,  8 Nov 2024 11:18:44 +0800
Message-ID: <20241108031847.700606-1-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dts for Ariaboard Photonicat RK3568.

This series bring support for:
* Debug UART
* SDIO QCA9377 WiFi and Bluetooth
* M.2 E-Key PCIe WiFi and Bluetooth
* M.2 B-Key USB Modem WWAN
* Ethernet WAN Port
* MicroSD Card slot
* eMMC
* HDMI Output
* Mali GPU
* USB Type-A

Changed from v1:
- move some general nodes (firmware, ramoops, reboot-mode) to rk356x.dtsi
- gmac1 change to phy-mode rgmii-id
- corrected some regulator to be closer to schematics
- rename rk3568-ariaboard-photonicat.dts to rk3568-photonicat.dts
https://lore.kernel.org/lkml/20240904111456.87089-1-bigfoot@classfun.cn/

Changed from v2:
- remove unused headers
- corrected some regulator to be closer to schematics
- remove usb_host1_ohci, usb_host1_ehci, usb2phy1_host that have no connection
https://lore.kernel.org/lkml/20240906045706.1004813-1-bigfoot@classfun.cn/

Changed from v3:
- corrected some regulator to be closer to schematics
- changed to using clk32k_out1 in xin32k
https://lore.kernel.org/lkml/20240911122809.1789778-2-bigfoot@classfun.cn/

Changed from v4:
- corrected some regulator to be closer to schematics
- corrected some label to match node name
- use resets props in phy node instead deprecated snps,reset-gpio
https://lore.kernel.org/lkml/20240914145549.879936-1-bigfoot@classfun.cn/

Junhao Xie (3):
  dt-bindings: vendor-prefixes: Add prefix for Ariaboard
  dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
  arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-photonicat.dts   | 600 ++++++++++++++++++
 4 files changed, 608 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts

-- 
2.47.0


