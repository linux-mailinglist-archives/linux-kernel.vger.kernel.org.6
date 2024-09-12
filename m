Return-Path: <linux-kernel+bounces-326596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5D976A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C9B28526F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014BF1AD245;
	Thu, 12 Sep 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="h6cjnqat"
Received: from mail-m49230.qiye.163.com (mail-m49230.qiye.163.com [45.254.49.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D41A4E7E;
	Thu, 12 Sep 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147696; cv=none; b=NUKiEIiwTKSU6lEjH7kZS1w9CZtGWOgY51IT/tqEpnZrSBmp4bWvYR4UQjRWiMHWmLf4NyryZ5ohg/jOGGe9FldqIFULeGrt2iskc5RKQVEh6QNWUr4ukh50uP9FCnLXMWVwMnmsrV931V0LQ29Ky7Paj7T3KPRTmG/DUhGmeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147696; c=relaxed/simple;
	bh=GiZDh8vEOlhH/Uf5Flmntow1FXV9+eaekmgO7blLLsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nV3FISNGHoK23frUGVYFZ8dEgB52ZpTLc42wF/hTDPJQO2ASDR4qPIfhztJbiFWdvtcH23NEPSKL7hNavPx1VjCEJ/Cbvhp9ODJVnHfGjQg60fyrPWNqFTqpN8zKv0WLKf/nsIbyXWj5rehr1OCE5WeLdIvlm3hi8ZJpZ4i27Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=h6cjnqat; arc=none smtp.client-ip=45.254.49.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=h6cjnqatK6rgyLNAn6VvaL2/6P9vDMxqGUEcuwDiAHvJAHfolJ+uIbu9Ed119mFBsFhItp9/sTapDeeQRFhR48Y5zeAsnG+ChemMOfBYRmjo+JFmbe33l+53xkHn+yLnMRekwHqqipuAKd2tI4zsO5Tpx5txhQALf1oapdTCxZs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=dHQFFhn3Ml0FVTMmnTTgqqzpKuNt0ErXTmfzGae0Ie0=;
	h=date:mime-version:subject:message-id:from;
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id C7EC11001C9;
	Thu, 12 Sep 2024 16:03:04 +0800 (CST)
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
Subject: [PATCH v4 0/2] Add support for RK3588S Evaluation board
Date: Thu, 12 Sep 2024 16:02:46 +0800
Message-Id: <20240912080248.1133061-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9LQ1ZDGU8eGkJOHRpDT0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91e541e2a403a7kunmc7ec11001c9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ND46MDo4HzI4Kyw6DioBMjBN
	Kw9PCjxVSlVKTElNSklDSkNNTU1DVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ05ONwY+

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

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 1129 +++++++++++++++++
 3 files changed, 1135 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts

-- 
2.34.1


