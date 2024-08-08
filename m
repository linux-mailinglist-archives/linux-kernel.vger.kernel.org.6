Return-Path: <linux-kernel+bounces-278993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B394B776
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE1D1C20A23
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C4518FC87;
	Thu,  8 Aug 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F2HfDV1a"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F30F188CA5;
	Thu,  8 Aug 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101126; cv=none; b=aegiPpW1LtzR/sB2AhIOg01pPS3a50Xkab+TEzTZ7n4ZV8pbAVIvSwIS4RihdrcNgCvVzdjzx0YZnfEVTiewFcwcia2JjmOgg6smqmGI4bvBCUW/Cgq+9TErPKzkwjFlSy1mAQhgrrwm0pyy0CLj81XZzlOyI/NhEbzgZA18esk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101126; c=relaxed/simple;
	bh=8ksQKBK3nAiioJdXAHF0iPGZ2MhIMi5zRV7/4DTbtl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq5DG/OSem4sqKJfIYnHoKZ5U5hX5O2uJpdkUFGt18MXkNXi8m1nefNssMqHNs7ZwHFdIcwVWN7iAeWRM0oPULrEuG7+mHj0HYf8QHoFaKPOb0AOY3c/qBZundtoEpTVhW2T1Y3KbhtvDOKwGp2pwedJcS7ZeoXcp56ao8j3d1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F2HfDV1a; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 12F83C000F;
	Thu,  8 Aug 2024 07:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhHLsIpdGYfQTXJIMda4RgH3fpRoHJARlbP68m37GfE=;
	b=F2HfDV1aMLgVp9USrt4xyRvAxNi+WmT/GCYwPZKFa5IXuICsmo7yX1sOzAY5UStRRUn8Qe
	A7xgey18Ja9dy+uKjjMolLUFGL0ZuYCnEayVv+qj0j7h5YTOiMV0ppqGxhvfFNkWo2rERk
	3jXOhY5yZN3WSWcb7qnItecJItOl3UKXK+mUkQQaVP4jOVY0BZShg+PkyD6LRSidyfyHbV
	S3XuQLGvaR3GHofAs+nFsOz5JCLS9o00O9XJLRE5DJmClXNUSepG0og53NTGICiNmdSoD3
	t1LMbZNBcwsr+v810M6inH+qWothRuxeDqWoiIdANkgWzeAgnY149LEhRUM3oA==
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
Subject: [PATCH v2 30/36] soc: fsl: cpm1: qmc: Rename SCC_GSMRL_MODE_QMC
Date: Thu,  8 Aug 2024 09:11:23 +0200
Message-ID: <20240808071132.149251-31-herve.codina@bootlin.com>
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

Current code handles CPM1 version of QMC. Even if GSMRL is specific to
the CPM1 version, the exact same purpose and format register (GUMRL) is
present in the QUICC Engine (QE) version of QMC. Compared to the QE
version, the values defined for the mode bitfield are different and the
0x0A value defined for the QMC mode is CPM1 specific.

In order to prepare the support for the QE version, rename this bitfield
value to clearly identify it as CPM1 specific.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 63af2608c3cd..062477b7426e 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -27,7 +27,7 @@
 #define SCC_GSMRL_ENR		BIT(5)
 #define SCC_GSMRL_ENT		BIT(4)
 #define SCC_GSMRL_MODE_MASK	GENMASK(3, 0)
-#define SCC_GSMRL_MODE_QMC	FIELD_PREP_CONST(SCC_GSMRL_MODE_MASK, 0x0A)
+#define SCC_CPM1_GSMRL_MODE_QMC	FIELD_PREP_CONST(SCC_GSMRL_MODE_MASK, 0x0A)
 
 /* SCC general mode register low (32 bits) */
 #define SCC_GSMRH	0x04
@@ -1642,7 +1642,7 @@ static int qmc_cpm1_init_scc(struct qmc *qmc)
 	qmc_write32(qmc->scc_regs + SCC_GSMRH, val);
 
 	/* enable QMC mode */
-	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
+	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_CPM1_GSMRL_MODE_QMC);
 
 	/* Disable and clear interrupts */
 	qmc_write16(qmc->scc_regs + SCC_SCCM, 0x0000);
-- 
2.45.0


