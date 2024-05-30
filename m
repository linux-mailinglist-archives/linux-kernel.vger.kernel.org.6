Return-Path: <linux-kernel+bounces-194891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83668D43C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 04:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677DDB23AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0F1CA9E;
	Thu, 30 May 2024 02:47:27 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE0FC0C;
	Thu, 30 May 2024 02:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037247; cv=none; b=AJ2ym4S2vH04ehwkiv+SuMzdlBCcSpcSNDsAtnMxFX9ldPLpi6UndaHSIDP+f+ccVmLGYrCB2Rw8fj+wuwK3PM6iEmP7J7ir7/PdLr+bmZFfmh1TTZ87dgQa0CJ7RU/MYZulXnyFRq5eI2JedNgbZ4ESRZxjftE9gTW4YmPjkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037247; c=relaxed/simple;
	bh=fkJsC9v2/HHdG848Kn8W2kx0I0i2mWBcnyq3yuINecs=;
	h=From:To:Subject:Date:Message-Id; b=KDvu8zBQg/fnROopbYZzQ1p4fAfgqUoXgsPjcV4Xil6ieyfuxY5xsPLoLNEyoXYw/pWz4mLiKwfr4i7u7Fr1Wbtudsfi+b7a0qqjhVRgMfZDGRaMxm2AkZq5L/Fs4iw8ijiKzaBOR8AfdOXpEf/mDkQlk4ylekrs9Qf4AXD9cHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E00C1A0D88;
	Thu, 30 May 2024 04:47:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0306C1A1885;
	Thu, 30 May 2024 04:47:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A494D180222C;
	Thu, 30 May 2024 10:47:20 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: p.zabel@pengutronix.de,
	abelvesa@kernel.org,
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
	shengjiu.wang@gmail.com
Subject: [PATCH v6 0/5] clk: imx: clk-audiomix: Improvement for audiomix
Date: Thu, 30 May 2024 10:31:13 +0800
Message-Id: <1717036278-3515-1-git-send-email-shengjiu.wang@nxp.com>
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
Correct parent clock for earc_phy and audpll clocks.

changes in v6:
- fix type for "correct"
- fix coding style for " * adev"

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
  clk: imx: clk-audiomix: Correct parent clock for earc_phy and audpll

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


