Return-Path: <linux-kernel+bounces-316227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF94D96CCD2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59FF1F25C68
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2914601F;
	Thu,  5 Sep 2024 02:52:36 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1C14373F;
	Thu,  5 Sep 2024 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504756; cv=none; b=DYAACB4p/LOxFlAK5BhBgPkfD381x/nGS/ibYxD7HJNZsyXdIGNqCzpcoYBcN9KEFssSRpf3Mf5o7lI+MQkM3G9iUh5K08S1H0X0ZLPtXvNcrjmt9k0iiCDD9r5D1yfpFyYm4qan/gVMQb0kjJQM1YX7iRuAYf8KJVCLh8W59bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504756; c=relaxed/simple;
	bh=n7APKeBGGWFbAdvhp7+FCKRmctVpABQlAOcDveym8x0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZTLuM80fv2p01NjRFC2Ky5jEgFb8O/lr1tMAIFWirfwCPQVhBWMza+WWWXop17HP8Gn3Hoz9x4JE4AnUuaVBY1ddrjjGVPEKTY7vtZ+k/9vZQlDPdSMNocYwISWayNiJnOT2Y4CE0tDSHf+tYT1fNQPsQDCFQNhNgCkC2FhaJN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 71CF91A0593;
	Thu,  5 Sep 2024 04:52:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 382F21A0595;
	Thu,  5 Sep 2024 04:52:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4C1151834898;
	Thu,  5 Sep 2024 10:52:25 +0800 (+08)
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
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v2 0/3] Add one clock gate for i.MX95 HSIO block
Date: Thu,  5 Sep 2024 10:31:05 +0800
Message-Id: <1725503468-22105-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

CREF_EN (Bit6) of LFAST_IO_REG control i.MX95 PCIe REF clock out
enable/disable.
Add one clock gate for i.MX95 HSIO block to support PCIe REF clock
out gate.

v2 changes:
- Correct the compatible entries by alphabetical order
- Include all necessary To/Cc entried reminderd by Krzysztof.
Thanks.

[PATCH v2 1/3] dt-bindings: clock: nxp,imx95-blk-ctl: Correct
[PATCH v2 2/3] dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible
[PATCH v2 3/3] clk: imx95-blk-ctl: Add one clock gate for HSIO block

Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml |  5 +++--
drivers/clk/imx/clk-imx95-blk-ctl.c                            | 20 ++++++++++++++++++++
2 files changed, 23 insertions(+), 2 deletions(-)


