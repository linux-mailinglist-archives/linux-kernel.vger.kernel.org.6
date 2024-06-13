Return-Path: <linux-kernel+bounces-212478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F8490618B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3062E28461A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8341C381B0;
	Thu, 13 Jun 2024 02:08:03 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D212A1D1;
	Thu, 13 Jun 2024 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244483; cv=none; b=DmbLiIp79cCBkcZBY0B2E54F3FeYzXCsjEkB/D5wupBWvYdy++Um5TjA6CW/pcpU5u89SqYTuQpaoWlHTzJwqBtSWxIbLrrLHz/fYDyVoMCWYNPJ6Jr8UbJrrGIR2s5uNoC8FkqmCIfnFSohptXuGW+JIrL4T+lLYzXcHjQ8q/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244483; c=relaxed/simple;
	bh=ChQvBI+Er4xZh0kIrCud60Pm6ajfJzZQKAnf67VYDCg=;
	h=From:To:Subject:Date:Message-Id; b=RaT2lqdxTIYrOhAbjHrWC+a23eOc+preU8/KZLS2DnZx8XtXLlh8O9q3tT6Oq+W0lSQVJlEB8PyRo5J2ACMBNBIvAALvd+OmSXun2MfE4RMe5eqfibbd8bjxan0CTnQvvhqoM8kCjTv69pIjQww2GSKp0+dFCWt/lQqqJov/b/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AAAA7200A5D;
	Thu, 13 Jun 2024 04:07:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 550DA20012D;
	Thu, 13 Jun 2024 04:07:59 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7F9D71820F76;
	Thu, 13 Jun 2024 10:07:57 +0800 (+08)
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
Subject: [PATCH v7 0/5] clk: imx: clk-audiomix: Improvement for audiomix
Date: Thu, 13 Jun 2024 09:51:17 +0800
Message-Id: <1718243482-18552-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Some improvement for audiomix driver:
Add CLK_SET_RATE_PARENT flags for clocks
Correct parent clock for earc_phy and audpll clocks.
Add reset controller for EARC function, use the auxiliary device
framework:
https://lore.kernel.org/lkml/b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org/

changes in v7:
- add property "#reset-cells" exist check
- change the reset driver to be specific for 8MP-audiomix
  remove the design for general usage.

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
  reset: imx8mp-audiomix: Add AudioMix Block Control reset driver
  clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
  clk: imx: clk-audiomix: Correct parent clock for earc_phy and audpll

 .../bindings/clock/imx8mp-audiomix.yaml       |   3 +
 drivers/clk/imx/Kconfig                       |   1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c         |  86 ++++++++++++++-
 drivers/reset/Kconfig                         |   8 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-imx8mp-audiomix.c         | 103 ++++++++++++++++++
 6 files changed, 196 insertions(+), 6 deletions(-)
 create mode 100644 drivers/reset/reset-imx8mp-audiomix.c

-- 
2.34.1


