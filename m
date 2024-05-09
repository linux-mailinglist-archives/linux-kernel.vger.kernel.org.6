Return-Path: <linux-kernel+bounces-174045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 119AB8C0991
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CC51F2248A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FE13C9BD;
	Thu,  9 May 2024 02:03:36 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A810A11;
	Thu,  9 May 2024 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220216; cv=none; b=m0f0mTDMq9mDuDea0RHUS9heishePI0pWG2h83uIefLQ/993T/IjmaHUbkEoBNwK13LBt78ep7M15esX5IxKE6xfuW9DvnUbzBhu1fjkK4GmkYUMitvCD/bdfoEzV2o+297ylHSjfTBiWFD2IuFrydW/INKlk8GB2ek+y8o4/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220216; c=relaxed/simple;
	bh=c6XIgSQ/dc58EUSEJ1tEuyH3zh/U7hLPp2W9pGYTvXA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EE/cDY3m0AlFoXrVK5wAyp8dkJ2Z9xd/C/TMhUuBrk2weos2QT3zZJWBXWNbnqrYqDJOnwINf1OpBtRlca6DFz7yrPOvnofg/mzeaAwX4Uaxy0mfgGU6jd7CsNiy5Shdo7mSwLYRRuUAweW5w8zvZYO/nidTK2qnqJIg4ESA62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ACFE2201857;
	Thu,  9 May 2024 04:03:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 718F0200A78;
	Thu,  9 May 2024 04:03:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5A849181D0FC;
	Thu,  9 May 2024 10:03:24 +0800 (+08)
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
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] clk: imx: clk-audiomix: Improvement for audiomix
Date: Thu,  9 May 2024 09:43:54 +0800
Message-Id: <1715219038-32453-1-git-send-email-shengjiu.wang@nxp.com>
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

changes in v2:
- add more info in commit messages.

Shengjiu Wang (4):
  dt-bindings: clock: imx8mp: Add #reset-cells property
  clk: imx: clk-audiomix: Add reset controller
  clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
  clk: imx: clk-audiomix: Corrent parent clock for earc_phy and audpll

 .../bindings/clock/imx8mp-audiomix.yaml       |   3 +
 drivers/clk/imx/clk-imx8mp-audiomix.c         | 105 +++++++++++++++++-
 2 files changed, 102 insertions(+), 6 deletions(-)

-- 
2.34.1


