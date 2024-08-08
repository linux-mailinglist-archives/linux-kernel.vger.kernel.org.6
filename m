Return-Path: <linux-kernel+bounces-278992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4D094B775
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89CD1F227B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4B18FC67;
	Thu,  8 Aug 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hvepbCkQ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80718EFC5;
	Thu,  8 Aug 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101125; cv=none; b=KMla9E1G+xPIIHm8L/uLssL+HcNAsldVTcnpgl4RvuLQExTE+2nWFg0VnrhE30/PwCpT/3jfQNTKioBssZWUpHxvALopGawIAVwhX1zSyh95vhcHzQrw8el09UgagBhaLsqJirTxNIlEHuJjCVUgfvtCfCNwGZFfUGz3oh4TWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101125; c=relaxed/simple;
	bh=dsTJ1S3yhsqYp275wkxGLuUovjtRCpXmJEUREOSsXjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRdvY9ZuQv81hTv6rWbuKsKq/Mc0q7nVEW26eHykFdLnCdFR0LLwHwr7fV1tYXluVLNvJPzBe5BaKoeLIS2UARjTfrMjs1UmgRC7k1C2mA/gOlPip33RU6XfWs4x7INaS3fQlWfwInVTls0CsUASLjFuASnqSrmehxQMLsQu8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hvepbCkQ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C75C6C000A;
	Thu,  8 Aug 2024 07:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IzmZXaq6Zk77+veQvHZ6jM6c509VDBLoarFwqEQ1ao=;
	b=hvepbCkQ7oSGTEO6ZfBdodE0nTf1EG9o6FhSpQ51QNEexBTTr8ecNc5g4LeZW7iAeJ4yWO
	qqkvmgYp/ZKhOM62AoFx206ThnIh4QGGJQv3tY4BPIVroO9jsD3mSSk2uVr4t83XNoYCtS
	muCHNFWKkDKfBsus/Yk/ZDvfSQM+jfcoK/mpcVFE5A2Y+TCklXdtepGsjFnkUaPDeDA8JX
	MTI+vM+GaYhOlhSzJqqtTV4/UkoTsaWLVj3Q2i2dUwXKi0rOJJZMiSy51IhtxULcKi3LQj
	DKmG9e/LwaAmqvrAbVTdIsltx48oGdeD+duhYMk4ca9HAxGfMwax72B2hVgaSQ==
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
Subject: [PATCH v2 31/36] soc: fsl: cpm1: qmc: Introduce qmc_version
Date: Thu,  8 Aug 2024 09:11:24 +0200
Message-ID: <20240808071132.149251-32-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
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


