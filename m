Return-Path: <linux-kernel+bounces-265929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA96193F7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7DD282B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F3D18E753;
	Mon, 29 Jul 2024 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M7aatnDV"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43018C321;
	Mon, 29 Jul 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262900; cv=none; b=TqImGUCiSzUg2Rv+MGjdite3i+tgz9krhlTM7fMrukxBbsBLBBBuNsaZndoSHmE10mjwnHZhqq6hmNjOL556rzMN3VsWcdosR5/rVBoaAepp2g4iQS4hL2g+5wbpkfwI/qfYzAZleihOY621xUP4wQdmJpZ0KGwI9Qc5EOpGpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262900; c=relaxed/simple;
	bh=dsTJ1S3yhsqYp275wkxGLuUovjtRCpXmJEUREOSsXjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEuPtZD+fn5lyE81IiVn0V9VSCjWZwiliF4fTymAQYTaM3ncXDjOr8f4dr05i61cABi8ta+Ow0RpXw8Yrg745x3039N0fTdDAiMAnqh2495V/olL26i9aNDx2WxX7su2QlZbbPQbjBiUteRS45aTXsdjOkeIInflLcaCtnQe6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M7aatnDV; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DAD6D240006;
	Mon, 29 Jul 2024 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IzmZXaq6Zk77+veQvHZ6jM6c509VDBLoarFwqEQ1ao=;
	b=M7aatnDV9KC5qxCyIWEBIqo/rW7TFUyCMDBSlevvDa51ZH8pbkolLR1iADrQRp7sovN7nM
	NhNUuEdZFUd1VoAtLS1MKMXkVF/T1Aa8Lz2bzPaAT35xlUP7Mbu53Qnm9MIp+BlzVdPC1D
	MgJuYJvTyQdbveSrYJno0oZodfgrtwUbXyiSrpYNWnFrVRbHAMPzCjQL9Y5OV/BFv393S4
	jtXGa7o3JxyQiBWM1kSjy8GNxMeOyZksMhdHdpsfu0OqWiHtbOX6jbiafrTxgn6Vqy5cno
	Dx7WzUoKXPc37qrNPnyfXSUmtJstZ+ZzNefPyCfpg2+PX2wvDR3lJGllv4Y2uQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v1 31/36] soc: fsl: cpm1: qmc: Introduce qmc_version
Date: Mon, 29 Jul 2024 16:21:00 +0200
Message-ID: <20240729142107.104574-32-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240729142107.104574-1-herve.codina@bootlin.com>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Current code handles the CPM1 version of QMC.

In order to prepare the support for the QUICC Engine (QE) version of
QMC, introduce qmc_version to identify versions. This will enable the
code to make the distinction between several QMC implementations.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 062477b7426e..8ff7eaaa4c50 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -215,7 +215,12 @@ struct qmc_chan {
 	bool	is_rx_stopped;
 };
 
+enum qmc_version {
+	QMC_CPM1,
+};
+
 struct qmc_data {
+	enum qmc_version version;
 	u32 tstate; /* Initial TSTATE value */
 	u32 rstate; /* Initial RSTATE value */
 	u32 zistate; /* Initial ZISTATE value */
@@ -1811,6 +1816,7 @@ static void qmc_remove(struct platform_device *pdev)
 }
 
 static const struct qmc_data qmc_data_cpm1 = {
+	.version = QMC_CPM1,
 	.tstate = 0x30000000,
 	.rstate = 0x31000000,
 	.zistate = 0x00000100,
-- 
2.45.0


