Return-Path: <linux-kernel+bounces-324886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF3A975221
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7702814C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A0618E36E;
	Wed, 11 Sep 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="Svz5UkDh"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F7751C4A;
	Wed, 11 Sep 2024 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057730; cv=none; b=RdABEJL5Io0/3ZxIGvzqJ/bq+Kw4ainl1hownhrul/vUyXpYwesunRxGqh/1wNgY2ryRZZw2mNI6nU4N6cRf3fnv26lni0Q2fEItEKk+uvhql/t9AT6gi3PMalvFPfMtNqbQ2h7RPYq+fiZvB/5r4Eu9EV9OZb+C6goklH+2H2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057730; c=relaxed/simple;
	bh=5Jr/ZMMR4Lqqr8IqNaSbYFH3ltNNkjiFdDGhsaK2DoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMhlcOcV6WT4H7KsBVUGUJfPPoXUZ9kNeabGw9xdPqppmNqdNeeaXG4UCUvFu6RqaB2aVo+jfpPWyRBmJVASVS0NTQ2aryrqdlj0wC4vyJrJPkGCXysorrr4dkn+EsgppyxW91HE+EHgmgQidls50CQ7LmSof+n+ZAvrPIPSdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=Svz5UkDh; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.173])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id D806678906;
	Wed, 11 Sep 2024 20:28:37 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn D806678906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1726057722;
	bh=84RhzK7ckLC2VZH9E5EktRcm76BXvzf4lS+tQumGGhY=;
	h=From:To:Cc:Subject:Date:From;
	b=Svz5UkDhInjSesuI1QpGpTdb90UvxkZhY9KLpoL1u4PyeroG1IfbVM/wX2sJnO+0F
	 vPTK6mQqo4OpBrbalaF1aP/3bvRqsmXrcmNxCsCXXE5afLGXwFo4+DrWdZy40adLlb
	 DVwA9sVmVzieEr1Zh4w5H5MAmuU4KSrzvB/yQraw=
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
Subject: [PATCH v3 0/3] Add support for Ariaboard Photonicat RK3568
Date: Wed, 11 Sep 2024 20:28:07 +0800
Message-ID: <20240911122809.1789778-2-bigfoot@classfun.cn>
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

Changed from v2:
- remove unused headers
- corrected some regulator to be closer to schematics
- remove usb_host1_ohci, usb_host1_ehci, usb2phy1_host that have no connection
https://lore.kernel.org/lkml/20240906045706.1004813-1-bigfoot@classfun.cn/

Junhao Xie (3):
  dt-bindings: vendor-prefixes: Add prefix for Ariaboard
  dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
  arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-photonicat.dts   | 586 ++++++++++++++++++
 4 files changed, 594 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts

-- 
2.46.0


