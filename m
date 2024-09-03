Return-Path: <linux-kernel+bounces-312462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DD69696FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAED1F24D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB5520FAA8;
	Tue,  3 Sep 2024 08:27:10 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1890205E08;
	Tue,  3 Sep 2024 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352030; cv=none; b=Eczqfky/isJwD41yG/3dtVg5N8m54GjtqCdaKOUXRM4g8ymsgFcj7DvSxjWSC6+5L7t3Ub30va8hoWMDv2orBUAlF3kxOkm7ouyv9BgQUXiCXrBRdFxApybxog290fKcd1N9b2Dm5WESrt7o0ploSiEhlwvKRSb7Y25F/WjV9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352030; c=relaxed/simple;
	bh=V/Y9uWmAFHRHcbE31X4SMswDzaIn6dznwVn8iiZkxFo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sU29pNQV+O2yHgOaXI7AZjOoyA2JPHBkN3bmJXVYkwOEZXwRbNcr0cXn9U4tv9FWe6jaWItgrEVbOIJpg1elMtDK4/zoW8eT2Gh9Dc/aa+v2C9RnuwbqwtwO4MDV2pOvTx2vkYU5CiOphTa8w5hpNR6jNqPUQCTUfeFRIiitgrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 557741A31B5;
	Tue,  3 Sep 2024 10:21:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 256471A31B0;
	Tue,  3 Sep 2024 10:21:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 72D87180031E;
	Tue,  3 Sep 2024 16:21:08 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v1 0/2] Add one clock gate for i.MX95 HSIO block
Date: Tue,  3 Sep 2024 15:59:55 +0800
Message-Id: <1725350397-19527-1-git-send-email-hongxing.zhu@nxp.com>
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

[PATCH v1 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible
[PATCH v1 2/2] clk: imx95-blk-ctl: Add one clock gate for HSIO block

Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml |  1 +
drivers/clk/imx/clk-imx95-blk-ctl.c                            | 20 ++++++++++++++++++++
2 files changed, 21 insertions(+)


