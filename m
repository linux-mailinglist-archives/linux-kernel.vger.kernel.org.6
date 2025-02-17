Return-Path: <linux-kernel+bounces-518076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988D1A3898A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4C116AC64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5422253F6;
	Mon, 17 Feb 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bdx70IWt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67D224AFF;
	Mon, 17 Feb 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810423; cv=none; b=G2riKyDHqkrfAfxRmOTkcQvJ6hwNcth1SfOI3SJjJSd8FgxIlrlekrAEqx/Cxgh4wigVI5jp0PZ7piJzqp8KAOo3qxmRq6wnp0JWRZils8eckk2QuLa0q5LjHCE83nB9XeXAOyrSm9cXPjIbM89rcGgUy7cwQMsDjqezHtCPT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810423; c=relaxed/simple;
	bh=XEdmeLzKffShZNKSBGP54NehTb23qsGdyVLr4uesvog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvy2i9moGzhZ4/6hfMvIrluM6vx3PCSbaDaMUGaGhd1DgLocKUntirstOxT3jxu3bw6CFeGQoAd2heL0XDKtT5uTezx21vwpANFHhlTjuu7bdZSwQC7afXPxAHWKP6d6hYGoYEX8VC2kKygEgE5zTSx6P5ySdj03wKDOz87BbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bdx70IWt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739810419;
	bh=XEdmeLzKffShZNKSBGP54NehTb23qsGdyVLr4uesvog=;
	h=From:To:Cc:Subject:Date:From;
	b=bdx70IWtsPSzWk58ZU9BHFu9MuYnTjnCMRWZmU8nf8WhbIXqV09f6Rtq1rXsGEiOu
	 5EqbR5172a36TenFGFZvZw7GUNxSucYTlmxURaamBHD+bTonncihpez+piDS+iYP9/
	 vW6sYC/HoCbS9lrX7+SC2P36fkbnu1sI2i/xGYV2lY/k2cF9y0FhPlHP5o66RQOHdl
	 tbFfSdmEnt9RvrLDFCI6pu0PriYSGHIOwe+bkrgZ3lac37NsVckfB1odVkJuibPBCw
	 HjyJaRTlBRjRzBxNO7wjLv4ddDiRLMqzxS5acnXYH4dpRBjNt1tm5GsR2QiQEGByh4
	 kBrfvrXO/FBig==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 89A0517E154F;
	Mon, 17 Feb 2025 17:40:14 +0100 (CET)
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
Subject: [PATCH v4 0/2] Add Radxa Rock 4D support
Date: Mon, 17 Feb 2025 11:34:29 -0500
Message-ID: <20250217164009.130286-1-detlev.casanova@collabora.com>
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
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 678 ++++++++++++++++++
 3 files changed, 684 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts

-- 
2.48.1


