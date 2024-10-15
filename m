Return-Path: <linux-kernel+bounces-365285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA0E99DFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68241F21BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDCF1B4F0A;
	Tue, 15 Oct 2024 07:57:43 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276951ABEB8;
	Tue, 15 Oct 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979063; cv=none; b=dkokxHBNbHHAYtjjgCXkzgJEIdPpFicW0bM/aHFQtCrUjsrxnXGqzFmCE4uKNZ2L3T36YSvGpQnri+hVgzh1URoiDtfLV+X17E5DsSozWa/iyClXlxpDfUTnRSLvr4PzZRT8wrnx/G23yLEMP4wrKV1r93doQdq8UXASMtJMCPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979063; c=relaxed/simple;
	bh=gJbvZ4ihg9NU9ggA0FMT/mLb35qajlrUSUmtskjYl1Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=msGeUBkKAThw5KuJ6Egb78/b28v1LapVlsp39pSj/FzmQLBWiUZrtncAmVwsboM0PRVfYgkcS5sA/JczZev8vjUtkYsFandfGPxJid2e0ar8GykNm+1cXgFVhyujg9a5xP7giRHi5XmDpJ3pwNDIPaOUANxNHa1G+cBitETJVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 707E0200C6D;
	Tue, 15 Oct 2024 09:57:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B0DE2005A4;
	Tue, 15 Oct 2024 09:57:35 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2D503183DC03;
	Tue, 15 Oct 2024 15:57:33 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: hongxing.zhu@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 0/2] Add one clock gate for i.MX95 HSIO block
Date: Tue, 15 Oct 2024 15:34:02 +0800
Message-Id: <1728977644-8207-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

REF_EN (Bit6) of LFAST_IO_REG control i.MX95 PCIe REF clock out
enable/disable.
Add one clock gate for i.MX95 HSIO block to support PCIe REF clock
out gate.

v5 changes:
- Rebase to v6.12-rc3.

v4 changes:
- Correct typo in commit message of #2 patch.

v3 changes:
- Squash first two dt-binding patches into one.
- Add Krzysztof's Acked-by tag, and Frank's Reviewed-by tag.

v2 changes:
- Correct the compatible entries by alphabetical order
- Include all necessary To/Cc entried reminderd by Krzysztof.
Thanks.

[PATCH v5 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible
[PATCH v5 2/2] clk: imx95-blk-ctl: Add one clock gate for HSIO block

Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml |  5 +++--
drivers/clk/imx/clk-imx95-blk-ctl.c                            | 20 ++++++++++++++++++++
2 files changed, 23 insertions(+), 2 deletions(-)

