Return-Path: <linux-kernel+bounces-329357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97727979057
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2655D1F237F9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21EE1CF2A5;
	Sat, 14 Sep 2024 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="h9EYiYvj"
Received: from mail-m244.xmail.ntesmail.com (mail-m244.xmail.ntesmail.com [45.195.24.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2F87A15A;
	Sat, 14 Sep 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312347; cv=none; b=T2bjW7lGOWRY7CYhMYiW4rW+2XL03rZT9r4ySKIwxga+HU1Cn44EH6n/eOYhStw+l5YcxQaQBNNXox8RvlBWlRjzoua+EIk3PA+CWs4avevfv7E3b+QeX8PNlTsHjWXOO9l/b25BtXIagP3rig4AL4DYQq9V4B8cS2IjwdRPz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312347; c=relaxed/simple;
	bh=i1BHQlcdrYjPhvDtG3EaM9WVgjx+LNsH0GKhxY7atgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aLJ+5I2Ts7pi95qd9cbxaqs24lx6mUHVTdSy+b8l4elpEvuTEUJRCAENzXhGBg/k+1bytXHUh9gXUKSdrVkolkBSHGdxKNYNkwad/T7Q7Fm41HedWo7CM7IPPF4o8q7zHjXXcKH8aatZtrNbBfSYPw/52ldbBa/AbVXzWqLm3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=h9EYiYvj; arc=none smtp.client-ip=45.195.24.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=h9EYiYvjQlBEcxZbofmgksr4onN4akfrGgOyUfModmA+R0b8/NfxofD1ea3mnchH17BYUolbNqijHmUqN/HhRIDK0gEZ41zRCsan22EGXTt35yhMINpUnDGJIud/+eBZNIWqLcb0IVXVezRkeZIfD4nSxp9Y5XIFov1qWbT5Un0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=k0fn5HQWlAuw190BJdywieI88ds+PPabunrOXGTjKe8=;
	h=date:mime-version:subject:message-id:from;
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 25F4D1002F8;
	Sat, 14 Sep 2024 17:55:04 +0800 (CST)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	macromorgan@hotmail.com,
	jonas@kwiboo.se,
	tim@feathertop.org,
	knaerzche@gmail.com,
	efectn@protonmail.com,
	andyshrk@163.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	megi@xff.cz,
	sebastian.reichel@collabora.com,
	alchark@gmail.com,
	boris.brezillon@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v5 0/2] Add support for RK3588S Evaluation board
Date: Sat, 14 Sep 2024 17:54:54 +0800
Message-Id: <20240914095456.2347532-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxkaQ1ZJGk9CGk0YTUxIQkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91eff5214b03a7kunm25f4d1002f8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PiI6ECo6HTI*ThM5SUoiPzZW
	LgswCi5VSlVKTElNSEtMTEtOTElJVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISExLNwY+

RK3588S EVB1 board features:
- Rockchip RK3588S
- PMIC: RK806-2x2pcs+DiscretePower
- RAM: LPDDR4/4x 2pcsx 32bit
- ROM: eMMC5.1+ SPI Falsh

Damon Ding (2):
  dt-bindings: arm: rockchip: Add RK3588S EVB1 board
  arm64: dts: rockchip: Add RK3588S EVB1 board

Changes in v2:
- rename amplifier nodes to amplifier-headphone and amplifier-speaker
- sort audio and backlight nodes by node name
- format names of regulator nodes to regulator-*
- add CPU/memory regulator coupling
- fix "VOP-" to "VOL-" in commit message
- remove bootargs property in chosen node

Changes in v3:
- remove unevaluated properties:
    pcie@fe190000: 'rockchip,skip-scan-in-resume'
    pmic@1: regulators: dcdc-reg*: 'regulator-init-microvolt'
    phy@fed80000: 'svid'

Changes in v4:
- remove unexpected property bootargs which added by mistake in v3
- add cd-gpios property in sdmmc node
- enable combphy2_psu for pcie2x1l1
- improve commit messages
- add proper series title

Changes in v5:
- fix the simple-audio-card,hp-det-gpio to gpio1_d0 in analog-sound node
- replace gpio property with gpios in regulator nodes
- move status property after pinctrl-0 in i2c8 node
- remove status property in usbc0 node
- fix interrupts pin to gpio0_c4 in hym8563 node
- sort properties alphabetically in sdmmc node
- use RK_PA7 instead of 7 in pmic nodes
- move pinctrl-name after pinctrl-0 in pmic@1 node
- add pinctrl-name in uart2 node
- remove dr_mode property in usb_host0_xhci node

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 1128 +++++++++++++++++
 3 files changed, 1134 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts

-- 
2.34.1


