Return-Path: <linux-kernel+bounces-316677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F596D2A6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CE428158B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EE4196D8F;
	Thu,  5 Sep 2024 09:00:22 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A768F66;
	Thu,  5 Sep 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526821; cv=none; b=MHi5jGSGdkj1wXMi/qr5LXcJFD+CPo+7KolQqN85A6ZlXrAQ/1LMQOnd3Y//OvxVSGdG81na2Et7GX6G/+t0idRkPlz5ENS5YLqGHMJcytPdnEIjdIvL0+1cEn2oXLhjlLsWf49BYJlkk4gaAspNphHNSKG9VeUM8HmwZivFXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526821; c=relaxed/simple;
	bh=AKgKjIn31Ungx9gGBJeP+TPt0S1fD8k6qBlckelFmDI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IYkHsOdUAqMxWpbLU6IIM7fER1VNoHZmwKLaF6Iq3HFKpFNZ5CcPPdZqmIdXFasJ9QHDpt/dEzitRAcdLL2By82RZ7FC5fjwcpMeYh3A4I6MDk75zHzhps4+pbGSh7S0e/vrdx9Nge/+73YgdUQ7q406mzBPXJmHOrcleppwOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DCD1202357;
	Thu,  5 Sep 2024 11:00:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4320E202348;
	Thu,  5 Sep 2024 11:00:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 43203183AC0A;
	Thu,  5 Sep 2024 17:00:15 +0800 (+08)
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
Subject: [PATCH v4 0/2] Add one clock gate for i.MX95 HSIO block
Date: Thu,  5 Sep 2024 16:38:53 +0800
Message-Id: <1725525535-22924-1-git-send-email-hongxing.zhu@nxp.com>
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

v4 changes:
- Correct typo in commit message of #2 patch.

v3 changes:
- Squash first two dt-binding patches into one.
- Add Krzysztof's Acked-by tag, and Frank's Reviewed-by tag.

v2 changes:
- Correct the compatible entries by alphabetical order
- Include all necessary To/Cc entried reminderd by Krzysztof.
Thanks.

[PATCH v4 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible
[PATCH v4 2/2] clk: imx95-blk-ctl: Add one clock gate for HSIO block

Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml |  5 +++--
drivers/clk/imx/clk-imx95-blk-ctl.c                            | 20 ++++++++++++++++++++
2 files changed, 23 insertions(+), 2 deletions(-)

