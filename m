Return-Path: <linux-kernel+bounces-534033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7741CA461D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D1116F535
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B35822157D;
	Wed, 26 Feb 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="pnBAVSED"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28829217F5D;
	Wed, 26 Feb 2025 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579002; cv=none; b=YGyVt1hvAuhCp51mkWiWCVMTznKCub9sPgkDEL6uh/8DQH1hmGiX0Kl4iu8WGvu7jbSG3eaMhh7vyB0luAqV4HmmWzwSIYqs4DlQBi4bl/gVMxPkYfgSSfq1Zj6AU1gZr3PVuGhtkfPMkQFZ0Iy4vB6Ej5x5s9Cv/2VddeBONrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579002; c=relaxed/simple;
	bh=rfj3dWpKPfxALjdMnbtO76AYHg6+XWF+0+e1sVBDhVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n59aLJCM5ocKQ65sFDwmomIYzQhGWBexW25vUnbbqnjBeYvm5gwZ+hGxl5TybzMfP9vxIXcb0tcX5VXcoalLfe8+wI8khIi95aZQDd0gjdvDxhlSzI7PKcBM5b/NwNW/0Y7ANxAkQVr8CYgJvEPgLWQ1Ll/EeVXsSFRFFosDOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=pnBAVSED; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NrrAahS7bAG/932u+TcE7E528I9KC3f3lzOfCirWNaM=; b=pnBAVSEDSzEMElEtScfsFC/55k
	D/TOiSf3GMdySfss1K2a1FHUo8e2EotucbNlIDOBGi3MDK42Hmt5NjpGyy2y7J1WUJQdzYdzqbWFF
	T4kBSH4MmYpfE2VtlnfM0TS9zndb7xw/9BGVY4LHxmcAM23Zs4mCBVXBpO590Tok/STtE09FothpL
	PpG/oxQfdFltGVbe1pqZ+ADiVWLfRZrCDlscFTFauuxV3HwFiPLxzSB/F5YaqFYunuSERWygPAvs7
	F45oFD3trJ3cWwwYhs9i6iqgb13Gd7tz+V4SiDmPYAD7fTjY/w9muLNDONmDCQpmib5M7gYN/+RW0
	ONui82iQ==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnI6o-0000V2-6w; Wed, 26 Feb 2025 15:09:58 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dse@thaumatec.com
Subject: [PATCH v3 0/3] arm64: dts: rockchip: add and enable DSI2 on rk3588
Date: Wed, 26 Feb 2025 15:09:39 +0100
Message-ID: <20250226140942.3825223-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the dcphy and dsi2 controller nodes and adds an overlay
for the Tiger-Haikou Video-Demo adapter that provides a DSI display.

changes in v3:
- rebase on newly added overlay-test-infrastructure
- add reset-gpio to gpio expander

changes in v2:
- adapt to changed dcphy binding (phy-cells = 1)
- tiger-overlay changes (Quentin):
  - drop forgotten hdmi-connector node
  - improve description
  - fix node sorting
  - drop unnecessary pwm-pinctrl (set in tiger.dtsi)

Heiko Stuebner (3):
  arm64: dts: rockchip: add mipi dcphy nodes to rk3588
  arm64: dts: rockchip: add dsi controller nodes on rk3588
  arm64: dts: rockchip: add overlay for tiger-haikou video-demo adapter

 arch/arm64/boot/dts/rockchip/Makefile         |   5 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  99 ++++++++++++
 .../rk3588-tiger-haikou-video-demo.dtso       | 153 ++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso

-- 
2.47.2


