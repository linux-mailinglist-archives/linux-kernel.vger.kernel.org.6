Return-Path: <linux-kernel+bounces-214490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8847908579
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955D8281CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7492618309C;
	Fri, 14 Jun 2024 07:59:16 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C614A09F;
	Fri, 14 Jun 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351956; cv=none; b=WNgVNy+3fL/ZoK53iWN4PENEdzs6392pLgz357ZKEaWuiJZ5Ndn6N2l3c9ZwVdq2lF7Pxlqp+eyTyIpAIDNEU1Kcgq8yHN9ytNFggdjbB+NVknGbVSCkYniPJIGpwkbvABk7CTkzZRouBCWRZZvobYFZNRMdcw2R/DMcZuWPEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351956; c=relaxed/simple;
	bh=UDi/xLchEAReJ8v4YHO8XkJpGZBWpDf54LawHbbLkwk=;
	h=From:To:Subject:Date:Message-Id; b=bKSoW8UYAT+ECGwZWr4NheI5aebppynGr0vJxdSjMHThwB2Scikr34gbMYCoW4ohn2vo3Ekq95pOneb1LoKUay8R4+2c/FXtAjhZ6BVtXCYgrez9EY8w1YC25ihSp9gJaCphDlF0VGV5/M0AIaBkhqaTV2MGyaQio1TOLJYAatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 382991A0599;
	Fri, 14 Jun 2024 09:59:07 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ECEC01A184A;
	Fri, 14 Jun 2024 09:59:06 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 963EE180222F;
	Fri, 14 Jun 2024 15:59:03 +0800 (+08)
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
Subject: [PATCH v8 0/5] clk: imx: clk-audiomix: Improvement for audiomix
Date: Fri, 14 Jun 2024 15:41:58 +0800
Message-Id: <1718350923-21392-1-git-send-email-shengjiu.wang@nxp.com>
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

changes in v8:
- drop '_priv' and add 'to_imx8mp_audiomix_reset()' in reset-imx8mp-audiomix.c
- update to 'select AUXILIARY_BUS if RESET_CONTROLLER'

changes in v7:
- add property "#reset-cells" exist check
- change the reset driver to be specific for 8MP-audiomix
  remove the design for general usage.

changes in v6:
- fix type for "correct"
- fix coding style for " * adev"

changes in v5:
- fix miss header issue reported by kernel test robot
  https://lore.kernel.org/oe-kbuild-all/202405201844.zf7UkDmq-lkp@intel.com/
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
 drivers/clk/imx/clk-imx8mp-audiomix.c         |  86 +++++++++++++-
 drivers/reset/Kconfig                         |   8 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-imx8mp-audiomix.c         | 106 ++++++++++++++++++
 6 files changed, 199 insertions(+), 6 deletions(-)
 create mode 100644 drivers/reset/reset-imx8mp-audiomix.c

-- 
2.34.1


