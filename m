Return-Path: <linux-kernel+bounces-323164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB95E9738C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F361C24A88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF00192D6D;
	Tue, 10 Sep 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VFfij3TG"
Received: from mail-m49231.qiye.163.com (mail-m49231.qiye.163.com [45.254.49.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD861922F4;
	Tue, 10 Sep 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975487; cv=none; b=AY/iY11j0qYHkqtwHrihw0dw6PqU/I00EEISntSw06uSnJ7oRt31xQ2eGHzU9+evyp4LiK7nuHmB5AZAUd3nsFmHCaygjVxjJGcdpjzWhxil8PKaq9AFWpGcodaLwxd7rMCf78NiSFZybcmZ0M68Pn+559K70Fcu/t8emuPJ4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975487; c=relaxed/simple;
	bh=md8t5r8gdIz40wEhMc2xDmlHmJCtUDk17sdcKwNicV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Te47TSoL+Dyovge/tXQ3cS+5K2YYIkQDTj/AzvtlrgElok0svpEFWnHv22OCekg89c7JURRD5swHgEuWtfzuMxVUpJCliGcYGj1Q0YGvMnPf/5PSEOgfn0fEZlDur6rXKXR3XmtCpVEEU5TtiooahlwQc/OZb6bCsrJml7ibhq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VFfij3TG; arc=none smtp.client-ip=45.254.49.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=VFfij3TGLugganLz/y/qfWk1pUC+6zZWktXLpiI7T8w+msGZXbpkE4RcHmYNd3IJo52poyf/Pn+b9gZ9Jqw5tV/zXrgKqzXPpDr0oux3vuMXxw/6Iw3rRrdWHYVn3bSwvNlaOEeJ0Lh074DaaVl0GqinAnFdIV/pyPSH35tgvT0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=mYQizcJx/MGPhOjacPPnt923D1r3RyCgFm6Psd2WnlI=;
	h=date:mime-version:subject:message-id:from;
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 8875910093F;
	Tue, 10 Sep 2024 20:41:28 +0800 (CST)
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
Subject: [PATCH v2 0/2] Add support for RK3588S Evaluation board
Date: Tue, 10 Sep 2024 20:40:53 +0800
Message-Id: <20240910124055.3981648-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1MS1ZNTU5KTB5KTxodShhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91dbf40af703a7kunm8875910093f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PhQ6Ngw4ITIzFSsjKwMCHApR
	KB8aFDlVSlVKTElOQkxJS0JLSk9NVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTkJKNwY+

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

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 1131 +++++++++++++++++
 3 files changed, 1137 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts

-- 
2.34.1


