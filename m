Return-Path: <linux-kernel+bounces-265001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0775993EB05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2678C1C21344
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172C77F1B;
	Mon, 29 Jul 2024 02:15:59 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC701B86D6;
	Mon, 29 Jul 2024 02:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219358; cv=none; b=NZEB6W+1hCyhhUg7Am+Ebc9a33vW6l8pW/mWumh1Wjiye4WKtexUpvJ3jrxhrarGHfNqeucZWVhY2IBCofoOcnXQQpAzmXN2CxzloyV6ZvWovHLyzQ9FnMpEn+GmfAd8tPYYtk9GkwjQCTh+NxPKHiGQg2f8EdQdVgoNNMi9Ep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219358; c=relaxed/simple;
	bh=Yygjjch5RxNLMsFABYMV2qU8EOneDWH6X2XkoLWMVog=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cW3wdzEuduSA2+s02vtoIgDnX105D6RWFPNTI1pp2U+GNb7o/O8+aJK+KdqQti0iO1EmagY22cQRSVnkol8nBgI1Vh2zleumUvFRH8uMnMaKngijX2oxUHSvs86h5JQGdoRlFaz0jEUb/Qp1E6jNKWsAjj1iD6YB/j3Q6g8wC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B19351A02F8;
	Mon, 29 Jul 2024 04:15:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7AD2F1A0262;
	Mon, 29 Jul 2024 04:15:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CE326183AD44;
	Mon, 29 Jul 2024 10:15:53 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	l.stach@pengutronix.de
Cc: hongxing.zhu@nxp.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v4 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Date: Mon, 29 Jul 2024 09:56:41 +0800
Message-Id: <1722218205-10683-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

v4 changes:
- Add Frank's reviewed tag, and re-format the commit message.

v3 changes:
- Refine the commit descriptions.

v2 changes:
Thanks for Conor's comments.
- Place the new added properties at the end.

Ideally, dbi2 and atu base addresses should be fetched from DT.
Add dbi2 and atu base addresses for i.MX8M PCIe EP here.

[PATCH v4 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu"
[PATCH v4 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for i.MX8MQ
[PATCH v4 3/4] dts: arm64: imx8mp: Add dbi2 and atu reg for i.MX8MP
[PATCH v4 4/4] dts: arm64: imx8mm: Add dbi2 and atu reg for i.MX8MM

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 13 +++++++++----
arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  8 +++++---
arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  7 +++++--
arch/arm64/boot/dts/freescale/imx8mq.dtsi                    |  8 +++++---
4 files changed, 24 insertions(+), 12 deletions(-)

