Return-Path: <linux-kernel+bounces-178534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE08C4F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE203B20978
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0413A898;
	Tue, 14 May 2024 09:53:28 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60513A863;
	Tue, 14 May 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680408; cv=none; b=JVYFHXpruBcYZEpw1rQw1z4ZuvEVzLSGR4YG2eC0F6he8bo9jJkNBEK2WNdGUZRLA3/7cKEQWCff77lKMY9ORRrzvSQcu8Bo0rn/S3Yba9aqLAh084ZgNRMzfG2CBSsubpOfGujOsDngw1WgpBQsvuvMMsMUe0lfVDmMJrttmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680408; c=relaxed/simple;
	bh=ctka+yZVd8DwpplQfnow4oPq+/CyZFMffSHpY+xP8VA=;
	h=From:To:Subject:Date:Message-Id; b=C3XXZ924GMputXyjROgiZT35a2u9+srExaMMOQW3NHWCqMDItf9o/LznON+xL32I0WVGPNCLgPDq96IlFGzrGsE3SmMKHoD86r9WNT+rzPfY5dNJZxONdYcgXv4vDztqjFvqkID3OUwHzYobdqYRd4S/RgPDMCRH58JJ9xBPMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 80D0D1A15C6;
	Tue, 14 May 2024 11:52:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 399351A0C0A;
	Tue, 14 May 2024 11:52:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DBE1B180222C;
	Tue, 14 May 2024 17:52:52 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	shengjiu.wang@gmail.com
Subject: [PATCH v3 0/6] clk: imx: clk-audiomix: Improvement for audiomix
Date: Tue, 14 May 2024 17:33:24 +0800
Message-Id: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Some improvement for audiomix driver:
Add reset controller for EARC function
Add CLK_SET_RATE_PARENT flags for clocks
Corrent parent clock for earc_phy and audpll clocks.

changes in v3:
- separate reset driver to driver/reset/
- add binding doc for reset driver.
- modify imx8mp.dtsi accordingly

changes in v2:
- add more info in commit messages.

Shengjiu Wang (6):
  dt-bindings: reset: fsl,imx8mp-audiomix-reset: add bindings
  reset: imx8mp-audiomix: Add AudioMix Block Control reset driver
  dt-bindings: clock: imx8mp: Add reset-controller sub-node
  clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
  clk: imx: clk-audiomix: Corrent parent clock for earc_phy and audpll
  arm64: dts: imx8mp: Add reset-controller sub node for audio_blk_ctrl

 .../bindings/clock/imx8mp-audiomix.yaml       |  17 ++-
 .../reset/fsl,imx8mp-audiomix-reset.yaml      |  37 ++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   7 +-
 drivers/clk/imx/clk-imx8mp-audiomix.c         |  23 +++-
 drivers/reset/Kconfig                         |   8 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-imx8mp-audiomix.c         | 117 ++++++++++++++++++
 7 files changed, 201 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx8mp-audiomix-reset.yaml
 create mode 100644 drivers/reset/reset-imx8mp-audiomix.c

-- 
2.34.1


