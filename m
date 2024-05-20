Return-Path: <linux-kernel+bounces-183456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E5F8C9946
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9188F281C65
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BBF1B970;
	Mon, 20 May 2024 07:29:33 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867A0E576;
	Mon, 20 May 2024 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190173; cv=none; b=PWsiKfgg5LPCWcvEcCj9OUmoRWROX62NumQqDEHmLQ6ib8e+c4gOt1NgeRZM10agD2QldE0bzJY+8KE9v2Pa2S/yAn/r5ceedorRtjjQIHJeSfcuccdKXdGwWAugP0tOmMwBsJzl1KFv1Z4kKHjm4U168l/rVq628cmhT81+9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190173; c=relaxed/simple;
	bh=nztgN3dFfNb0xDuxLkAdkVrN2aHy/VlgXSSIl1Fc6FI=;
	h=From:To:Subject:Date:Message-Id; b=dZsNBp9El00YXQUxVhNKeF71t/6RNhAvY7oAWWbFeZewJqMKswOFXn+7l48Cryti4BVdbu9fHdg+OLyjmsowddZqUtLNJlbz8UEJcJbONWkRUF5d002bkQYanC8PcE6Ogou8z6eTtjVaZtzH7XKNuYMUsvpnmql+yJHWsgqsFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BF9FF201943;
	Mon, 20 May 2024 09:29:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7350E201965;
	Mon, 20 May 2024 09:29:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 10F4C180226C;
	Mon, 20 May 2024 15:29:20 +0800 (+08)
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
Subject: [PATCH v4 0/5] clk: imx: clk-audiomix: Improvement for audiomix
Date: Mon, 20 May 2024 15:09:18 +0800
Message-Id: <1716188963-16175-1-git-send-email-shengjiu.wang@nxp.com>
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

changes in v4:
- use auxiliary device framework for reset controller driver.
- drop syscon and simple-mfd related changes in v3

changes in v3:
- separate reset driver to driver/reset/
- add binding doc for reset driver.
- modify imx8mp.dtsi accordingly

changes in v2:
- add more info in commit messages.

Shengjiu Wang (5):
  dt-bindings: clock: imx8mp: Add #reset-cells property
  clk: imx: clk-audiomix: Add reset controller
  reset: imx-aux: Add i.MX auxiliary reset driver
  clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
  clk: imx: clk-audiomix: Corrent parent clock for earc_phy and audpll

 .../bindings/clock/imx8mp-audiomix.yaml       |   3 +
 drivers/clk/imx/Kconfig                       |   1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c         |  84 ++++++-
 drivers/reset/Kconfig                         |   8 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-imx-aux.c                 | 217 ++++++++++++++++++
 6 files changed, 308 insertions(+), 6 deletions(-)
 create mode 100644 drivers/reset/reset-imx-aux.c

-- 
2.34.1


