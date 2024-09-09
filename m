Return-Path: <linux-kernel+bounces-321341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7249718FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12122855B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360671B6551;
	Mon,  9 Sep 2024 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F8eAawXj"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FCB1B6541
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883912; cv=none; b=jw5USj4KKskSe3m5wQcHBuhiyFo2CfjyekmTaTIUm8pZOnpI7UZqpMHgrZsvZAgYlzJ0DcKN9eI7udPTqSx6gDV6cmirHKFnVq67pUrcXapiBXpvRZricbOnGhfC/0MNPj/TPR4Rkl/mWt2qNWCEtKaxIDQT7D9OVDepL5hOsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883912; c=relaxed/simple;
	bh=PaZ41nueg92VJgHd8zhu4eNdScyhn/qDQyKFNSPnfAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oD3sRsHD90YXGDyyDw+ELPRjRwZfub7xa/W5RhOFvqkhy6YfkY74bcrnjsrfkrk+ddUdpVsNIKZa6vbrzFzW/G8Q9P/GiddRPV51yXKrvO94ApYoMoDgwRMpve6YvH4Zmc7YXjQeNiYcjAygGjZSvP0lX3oBQBgzpnvFmkIdQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F8eAawXj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 72AA81BF204;
	Mon,  9 Sep 2024 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725883902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=afjW2HbfOkKhSUvBb1KpugqYFb+VlNLEMmHfBzTMbUc=;
	b=F8eAawXjVdvdQglkIS1te66pz6gB4LnLU6IVQ7BflkBY8Sywmw90NfiQrJQsf5x6Apeyfv
	iP9OPhLI6eB+kS4EwyLIih814oi+98l5SL1XegBNbmzDxCJqxGUzh42Ioi9oPg695+aroL
	tlr5COqF68sniaFyQDGmzHKHpEbO4sK0U/foqB7ZpP1V9auuBY3Bos/Oif2PTSqBjdFxY8
	iJr/g7X1xsOOAM3uQqY9iv4Nn0urhotGwsZvcrka8xg9Tz+Q1EZ8myVeytOJbUoD/SrGlM
	8J9KDv18ChOOZdxBNMBbMbJE8pRUwIN1X7xSVW246FIOwnyldvU+aDLKf0GCwg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: fsl: cpm1: qmc: Fix unused data compilation warning
Date: Mon,  9 Sep 2024 14:11:29 +0200
Message-ID: <20240909121129.57067-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

In some configuration, compilation raises warnings related to unused
data. Indeed, depending on configuration, those data can be unused.

mark those data as __maybe_unused to avoid compilation warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409071707.ou2KFNKO-lkp@intel.com/
Fixes: eb680d563089 ("soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementation")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 3dffebb48b0d..5e38be6530f9 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -2056,7 +2056,7 @@ static void qmc_remove(struct platform_device *pdev)
 	qmc_exit_xcc(qmc);
 }
 
-static const struct qmc_data qmc_data_cpm1 = {
+static const struct qmc_data qmc_data_cpm1 __maybe_unused = {
 	.version = QMC_CPM1,
 	.tstate = 0x30000000,
 	.rstate = 0x31000000,
@@ -2066,7 +2066,7 @@ static const struct qmc_data qmc_data_cpm1 = {
 	.rpack = 0x00000000,
 };
 
-static const struct qmc_data qmc_data_qe = {
+static const struct qmc_data qmc_data_qe __maybe_unused = {
 	.version = QMC_QE,
 	.tstate = 0x30000000,
 	.rstate = 0x30000000,
-- 
2.46.0


