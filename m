Return-Path: <linux-kernel+bounces-519810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C0DA3A231
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD1C1884949
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2F026E164;
	Tue, 18 Feb 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ul3mvmdN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369DB16C850;
	Tue, 18 Feb 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894846; cv=none; b=F2aOTwITTrthQ2z7c6FhHdu6zTDT0Hr+bJdzuHeUpCnOdlT8n0EQKjuEzPoDea41s3tPKsVMHyNOwE2DKyg9vNN860PGHGH6BLMKQTlfkqPSVx5/jrhf67lx+ryUOjfQdvZZzgAkg2I3jTrocdwqDHwcAaeYRUEiHuhlD3/X5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894846; c=relaxed/simple;
	bh=0K73ZkcdRvK5i5bBvBQT3dcTZxfeYnrTBCghlFqDUdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1dgu13KO6rviPAVxLLwxQB9qB9sDVAJ8uDvMRvfu6y/o0AvpcrfGl8VvOoR2IQmeGa9CZt3UF6/SprEC/l1KDoMEpOyympdbaGG9iNMk3xhSyK/S5Xfj+NjtXdch+g2AKgExVkz7oUdBeCeUl9wkTZEkZP05kZKIkzAoqAjfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ul3mvmdN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739894842;
	bh=0K73ZkcdRvK5i5bBvBQT3dcTZxfeYnrTBCghlFqDUdc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ul3mvmdNt3c5yp0JAGjna3WGQZXhVrj5Y0+b5XYRj4dSziyBL3CyuyVV5cXkoaTHo
	 EGfH7cLak7T88MqCU7YJhe+GoNUl/D50CZ/8iWgPZmqPeZn2ChAn834w58E4QkEObc
	 agx9FkxpCiNMMVWRDTum4SyNy9PNg2NV2+n7bZ/6zHP8U3OZ+dcjpN532mNeialcfv
	 xhFa44LJ17VBNzWt+vt+Ej1BHwDfXeBB8Gb9+XcO0qlkz796T2INGPTaZxqFdxKiIN
	 +3k1C7YuyXC/mTt0qBUkBK2qexUtu8qJVrz09XSrpWSffWv6OHENdqAETRX0WVnsYk
	 ugUP9XeUHm5gw==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF89C17E1247;
	Tue, 18 Feb 2025 17:07:19 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chris Morgan <macromorgan@hotmail.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Tim Lunn <tim@feathertop.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Stephen Chen <stephen@radxa.com>,
	Elon Zhang <zhangzj@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v5 0/2] Add Radxa Rock 4D support
Date: Tue, 18 Feb 2025 11:04:17 -0500
Message-ID: <20250218160714.140709-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the basic support for the board. (Not officially released yet)
It is based on the Rockchip rk3576 SoC, so I haven't added the
following devices yet:
 - VOP/HDMI
 - UFS
as the support for those has not been merged yet, but are close to be
and I already validated that they work.
It will come with another patch set.

The following devices are supported and working:
 - UART
 - SD Card
 - Ethernet
 - USB
 - RTC

Changes since v4:
 - Add the correct pinctrls when needed
 - Move #clock- and #gpio- props to their corresponding props
 - Add mmc0 alias
 - Rename gpio to gpios
 - Remove unnecessary blank lines

Changes since v3:
 - Reorder nodes alphabetically
 - Add missing cpu supply

Changes since v2:
 - Move and rename snps,reset-* props to the PHY node
 - Rename phy@1 to phy-ethernet@1

Changes since v1:
 - Add missing dt bindings
 - Remove clock-frequency in rtc node
 - Add line break in pmic pinctrls

Detlev Casanova (1):
  dt-bindings: arm: rockchip: Add Radxa ROCK 4D board

Stephen Chen (1):
  arm64: dts: rockchip: Add Radxa ROCK 4D device tree

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 689 ++++++++++++++++++
 3 files changed, 695 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts

-- 
2.48.1


