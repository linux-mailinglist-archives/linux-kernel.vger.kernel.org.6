Return-Path: <linux-kernel+bounces-318140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D08496E8E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2D9281BCE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2A12C52E;
	Fri,  6 Sep 2024 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="nQxTkp/1"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD5341760;
	Fri,  6 Sep 2024 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598668; cv=none; b=nPHnjHXLuhA3ztuamALcmC38jGoprSyAyXlVWAoKhkg/Umos3ns+x6GHIPlazi3Ie85Bi1yPjLi/cZc6uSMBLCQJJU459sGk3WrC30YGv0BIRXGk1PaYMgsnOObuS0mP5zvJG6bRTzNgJMU4Vydn5QUlZ/8ImEsCB8y0kj8wTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598668; c=relaxed/simple;
	bh=2b1g3ArCqL3wxJro2Whm+S8jc5aHuS1BKtu+nfODvC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxuGPrXxwYaU++Q/MR2jxCVtg1jtP58Ys9nBQz8EEAbLuYDY2ULtvRC/hGmgPBAvGng3Emd6yCjorfrlP1B03mm73TX/hqVI6p8brnJreX5YEylU5WDk1/cVIjkmUPUlMJEMXHA7BdH6/dsRG8wvvKvZyBlfjbCyOskU3np/LZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=nQxTkp/1; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.35])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 1841C789F6;
	Fri,  6 Sep 2024 12:57:43 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 1841C789F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725598663;
	bh=Ylm/vYy9oFTGiVbD3MWz59t8wBM08Yee8yxtQQpH2yQ=;
	h=From:To:Cc:Subject:Date:From;
	b=nQxTkp/1cJfvlv6YWLVc1JTJpGTV4CU/TjfsqJELIXvmM9mxB0+t3pVNkr1tCXjgd
	 OrShyE8LQ03hxvXWc7Y2dbFNX+XVcLmaJ/81bA9WZTR9uPpfGJTiEQzVjxDni44Loj
	 nkXyXd4tKOXfUOuw30UYg5ALyfsQNEURKP7QCqK8=
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
Subject: [PATCH v2 0/3] Add support for Ariaboard Photonicat RK3568
Date: Fri,  6 Sep 2024 12:57:03 +0800
Message-ID: <20240906045706.1004813-1-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
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

Junhao Xie (3):
  dt-bindings: vendor-prefixes: Add Shanghai Novotech Ariaboard
  dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
  arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-photonicat.dts   | 595 ++++++++++++++++++
 4 files changed, 603 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts

-- 
2.46.0


