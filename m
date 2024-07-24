Return-Path: <linux-kernel+bounces-260609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D26893AB89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 05:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9DB6B22A44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A871CAB8;
	Wed, 24 Jul 2024 03:23:10 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648418EA8;
	Wed, 24 Jul 2024 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721791389; cv=none; b=qSTHa5rd6StkG+fSBxho1ierwCQaWBI9bE1rqMBWmqBl8NhKy5w/Lr1bsI+kfe5Y2B3Mu3jdUYzsONV+vdhOOG3d1yR3wEdT2IbsEeNKDPYer9am9/Zc3ppI4+J6RK0yNOJBDY7SuSN99cl7mo7aZQKo0CVMX+BYN1jyy9jTCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721791389; c=relaxed/simple;
	bh=D8QDJ2ojO7FAUPA5rx7ivu8QpNZQ6Bv860bh4GVgg3w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mx3ksxBFW/9As4zrDnzqpTF6FqF7+Zt219o3CqlHfswSnUFSv5RrvEaEhN8FaXIdVALkRnlzuKJATT1/Cl8jl4/J9dJ1EwY3VbetBIpFnc50DfbcHKOF95hH8wWhyodCFB6UaTowtAPEfbANqFcqY/IBEGSCEzn4j7SrODsn2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DF2F201294;
	Wed, 24 Jul 2024 05:23:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 461372015B2;
	Wed, 24 Jul 2024 05:23:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DE9071802183;
	Wed, 24 Jul 2024 11:22:58 +0800 (+08)
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
Subject: [PATCH v2 0/4] Add dbi2 and atu for i.MX8M PCIe EP 
Date: Wed, 24 Jul 2024 11:03:52 +0800
Message-Id: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

v2 changes:
Thanks for Conor's comments.
- Place the new added properties at the end.

Ideally, dbi2 and atu base addresses should be fetched from DT.
Add dbi2 and atu base addresses for i.MX8M PCIe EP here.

[PATCH v2 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu"
[PATCH v2 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for i.MX8MQ
[PATCH v2 3/4] dts: arm64: imx8mp: Add dbi2 and atu reg for i.MX8MP
[PATCH v2 4/4] dts: arm64: imx8mm: Add dbi2 and atu reg for i.MX8MM

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 13 +++++++++----
arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  8 +++++---
arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  7 +++++--
arch/arm64/boot/dts/freescale/imx8mq.dtsi                    |  8 +++++---
4 files changed, 24 insertions(+), 12 deletions(-)


