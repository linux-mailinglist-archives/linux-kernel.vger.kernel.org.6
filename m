Return-Path: <linux-kernel+bounces-324129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E597483C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97567288229
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18BE2B9BB;
	Wed, 11 Sep 2024 02:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hgIy5hX1"
Received: from mail-m3297.qiye.163.com (mail-m3297.qiye.163.com [220.197.32.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5351E87B;
	Wed, 11 Sep 2024 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726022287; cv=none; b=jmsikcU2HjfkWMrvdx6Et+yao1Qs2VH86a4jt4TUdn2w5O/0uMibvqhODXXHa9GlB50+p2DurGKBa9a/84MEwxRMhi3gar4Br+Flt6+56KKR4EkJwL1by2XaYSy1FYEgr1tLbj32PU9LfDVBTiF26bP9r0iSkyuttDBqf0vW+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726022287; c=relaxed/simple;
	bh=s3cJgyb2nuC1pWJK7e3fIc3jroOCt8bHsilc0UAfW6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NizGh3YeESdpssLbWjXh4iUuc6ODyQklzzIVgPmfzeEoNtH30HwPf3pE3cGDItPyzsC4DkcMawpb/p+fHU4TaUPrEzWlVVS2R9Z3xVLhvo4ypgM+GGf23PsHRPlmWzfAtD7IIq7w3giPGiVqMIHcMfdy24UcwOpGHin8VcF6EnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hgIy5hX1; arc=none smtp.client-ip=220.197.32.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=hgIy5hX1cLaUzpdGFppKGrpJJF3aqJuNw1PpMySyqiHufSVZr447MLbgxHCyd8jSMeZJD4Xl0M9M9g17y/X7LYjKsR7hpvjiRJepzMxclBXFebqojWZl7yJhEFEL9vOZF6OGxdJqk3qvCGdX1anfc2ELAJmXu/I8VsTO7q+x8vE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8drECosThzypqtWFQdJAkNqGx+OpVPS3ibKHmyglYTY=;
	h=date:mime-version:subject:message-id:from;
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id B7F42100271;
	Wed, 11 Sep 2024 10:31:09 +0800 (CST)
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
Subject: [PATCH v3 0/2] 
Date: Wed, 11 Sep 2024 10:29:28 +0800
Message-Id: <20240911022930.4022802-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ08fHlZCGR9JGUJMSElIGk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
	NVSktLVUpCWQY+
X-HM-Tid: 0a91deeba54203a7kunmb7f42100271
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORQ6Sio6FDI3SikUPDUZKy4t
	HzNPCitVSlVKTElNS0lKQ0xKT0xCVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTEtINwY+

Specification:
- Rockchip RK3588S
- RK806-2x2pcs + DiscretePower
- eMMC5.1 + SPI Flash
- Micro SD Card3.0
- 1 x Typec3.0 + 2 x USB2 HOST
- 1 x 1Lane PCIE2.0 Connector(RC Mode)
- Headphone output
- Array Key(MENU/VOL+/VOL-/ESC), Reset, Power on/off Key
- 6 x SARADC

Damon Ding (2):
  dt-bindings: arm: rockchip: Add rk3588s evb1 board
  arm64: dts: rockchip: Add support for rk3588s evb1 board

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

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 1125 +++++++++++++++++
 3 files changed, 1131 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts

-- 
2.34.1


