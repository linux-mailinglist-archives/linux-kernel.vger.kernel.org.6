Return-Path: <linux-kernel+bounces-515193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9EFA3618C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72CCB7A62DE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8D26659E;
	Fri, 14 Feb 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qEZRfcj0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EAA151999;
	Fri, 14 Feb 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546490; cv=none; b=HNPcI8gmmDf1yl7iJdFO8X7ZkCfJn3CNt/pk6KdZs49CFY/nkCpm/YKdY24cLZ5AMkT5wN5YwYz5dMQRWDjDyQCuMiSRPLj8y5Xmnb7dqvHbKPau5eIBuyRCCViVwrR1rDnWKmVedeS24m5FqdOqBvEHHAR++2fU7LkpAgQnboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546490; c=relaxed/simple;
	bh=5Jn9LvD1kCFvAnBMnLblKW/OjM5Da/usy28KK7+BVD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCh5qYiHm1x7gqlg932V5TnUgoCOs5OcGNQZRYtqVYRLD3kvRe+Uia/J4S9hnVI8N5PIHU25rOlC3JYqC/FF9sUHUPnTHnK9Vn6hnddnFJVor6jMgTCOAzQzsPuSBHsjnClcOATV9c6fO55lET0nkDqRpPSo/wBq4GJc35Yr3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qEZRfcj0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739546487;
	bh=5Jn9LvD1kCFvAnBMnLblKW/OjM5Da/usy28KK7+BVD0=;
	h=From:To:Cc:Subject:Date:From;
	b=qEZRfcj0b/uMY6ekjNtlB8xvLc3qbSsBJx2JeCAukGQRvEY6Qd+VgBnqkT1Fu6FDJ
	 JAlmoWY+mVvDBEJqbOI2K+gDLyzx0RB91mfvqntmyd1Bz9L85ycXA3uKxNaHLF1gPs
	 1gW3gryl8LFmNKo+NxcHjJQxQ5tx4c4WAunHcvvNv2X6HqcAlXURh97duAruZwVSbi
	 yypEgkUwVzACqmlp8KANW9F9U+t8AIQp2meXghRZC4ikjWH2Ttl3HOCjGRWBdkFsUY
	 PoVmUpX+su0o4jdLVRQ3IucYqkVP46wTMjPOfhF5GPm+PpeSpSSK76FOcGAhzcIpTs
	 YgInW+JgstJTw==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB3C417E0E95;
	Fri, 14 Feb 2025 16:21:24 +0100 (CET)
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
	FUKAUMI Naoki <naoki@radxa.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Stephen Chen <stephen@radxa.com>,
	Elon Zhang <zhangzj@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v3 0/2] Add Radxa Rock 4D support
Date: Fri, 14 Feb 2025 10:19:32 -0500
Message-ID: <20250214152119.405803-1-detlev.casanova@collabora.com>
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
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 650 ++++++++++++++++++
 3 files changed, 656 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts

-- 
2.48.1


