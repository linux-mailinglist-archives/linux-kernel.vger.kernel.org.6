Return-Path: <linux-kernel+bounces-187321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635468CD029
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAA81C217FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6710413E3EC;
	Thu, 23 May 2024 10:20:11 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12813D29C;
	Thu, 23 May 2024 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459611; cv=none; b=SunA31CbV2zIKO3Zq9A48zXXhXHIeeY1uk0czFOcc6ImTSxu1tRH/1bkgzW5zqf5hlt/AGompAppUiR/M8DKaWuoqeZWQHLDvTOpnWwenKIK4d2YIbtdvyJIcfA/OO3Os/kiVh5dv8pxR6sIAsa0udC8pMVCDb3L6LYXdCbOAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459611; c=relaxed/simple;
	bh=mQZX0GpupK3bkgiwgabR7cVdsnZ41kVjsv3/XEPRAGs=;
	h=From:To:Subject:Date:Message-Id; b=K+qpMqgQZ9/IiOm6/f4jeCxAsQ8/6e09MN8h3IxFr+ra1h/DHWd/uEcpnb46pSUGYOH6w7Gn1Mjly0c71I70LsxhX6pLye2FpkgGrrIP8IS53vRGM0v7jOmNLswSkdBVFB/deBUtgiOAgICpB/sza5kQfkq/sKKKuRsmLVFDNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F903201F88;
	Thu, 23 May 2024 12:20:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D6F5201F81;
	Thu, 23 May 2024 12:20:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AB88C180222C;
	Thu, 23 May 2024 18:19:59 +0800 (+08)
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
Subject: [PATCH v5 0/5] clk: imx: clk-audiomix: Improvement for audiomix
Date: Thu, 23 May 2024 17:59:45 +0800
Message-Id: <1716458390-20120-1-git-send-email-shengjiu.wang@nxp.com>
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

changes in v5:
- fix miss header issue reported by kernel test robot
- use scoped free

changes in v4:
- use auxiliary device framework for reset controller driver.
- drop syscon and simple-mfd related changes in v3

changes in v3:
- separate reset driver to driver/reset/
- add binding doc for reset driver.
- modify imx8mp.dtsi accordingly

changes in v2:
- add more info in commit messages

Shengjiu Wang (5):
  dt-bindings: clock: imx8mp: Add #reset-cells property
  clk: imx: clk-audiomix: Add reset controller
  reset: imx-aux: Add i.MX auxiliary reset driver
  clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
  clk: imx: clk-audiomix: Corrent parent clock for earc_phy and audpll

 .../bindings/clock/imx8mp-audiomix.yaml       |   3 +
 drivers/clk/imx/Kconfig                       |   1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c         |  83 ++++++-
 drivers/reset/Kconfig                         |   8 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-imx-aux.c                 | 217 ++++++++++++++++++
 6 files changed, 307 insertions(+), 6 deletions(-)
 create mode 100644 drivers/reset/reset-imx-aux.c

-- 
2.34.1


