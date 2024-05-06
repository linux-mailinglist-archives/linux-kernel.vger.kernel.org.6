Return-Path: <linux-kernel+bounces-169295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C1B8BC672
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EF21F21EF5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174BC4654B;
	Mon,  6 May 2024 04:17:44 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357883C489;
	Mon,  6 May 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969063; cv=none; b=VfH9xldQbERjqmCPErf7ctx/NISecnq0r+JHx8Z9iddscfTBiBDiegNVTtwCM3hogCiShRREC82LofuFsvpU898gj8j4faGzaUcFlpvnlEl31ADR3N8EAnAMl3fmOJZ9dkuUbez0aQ71k1MXEAdKFRggG/RpNgXzd4bOrU7RyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969063; c=relaxed/simple;
	bh=jPC00p1hMApSqlmVKIqvgtihLa/1Ufo32EI+Ro3c2Ko=;
	h=From:To:Cc:Subject:Date:Message-Id; b=njZCwPVQe8+xyBiB9mXbuJx+ZgHK+jfvX3lshTz67qz3Otrb4RRul9l9/WQtY7O8/wYrmt6xG+NpdGxJpwY1kk7dnLxzhd8ET/z14Xu7ZqlbPyKk2DHAZbpA1/KbqhJ2HS7h7h0h+/RfqH60WRrdHI5TadMpPyblxnrbHPSOTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CEA6200311;
	Mon,  6 May 2024 06:08:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 50579200370;
	Mon,  6 May 2024 06:08:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 00838181D0F8;
	Mon,  6 May 2024 12:08:12 +0800 (+08)
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
Subject: [PATCH 0/4] clk: imx: clk-audiomix: Improvement for audiomix
Date: Mon,  6 May 2024 11:49:15 +0800
Message-Id: <1714967359-27905-1-git-send-email-shengjiu.wang@nxp.com>
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


