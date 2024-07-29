Return-Path: <linux-kernel+bounces-265911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCB93F79E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB571C21E32
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAD316B725;
	Mon, 29 Jul 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jIbxCO4o"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5D156F28;
	Mon, 29 Jul 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262888; cv=none; b=aFPHiN4XYQWY9x8xjYBvg+qsAe17qCM//64GSS0I2BEBaLbPD60O+b/ARmCseVPndLr5NBRRcU5Pe9/26NlT6e0RcvnA6p0cNTkXT08t8XNjb5CsT+H1k9kkjomq8dU7rHvrRngj+z3veBAPEyugr4vDiVPmsAQVuTVtCMK5f8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262888; c=relaxed/simple;
	bh=kd43P/38ytu5wXQxYv6vHhlOQQQ+T3B67xz0MWKPER4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otWqTC2IIPaR//NGKjTTDqYfoFn0rQs96j3ZlY4NjVl7t2Mkmn3xscDCYxez8quuMy+dmtGjCT2wCs7MjMLuL9/Sao7rp+arLp8xaJkCwnP3KrQ+lt1P4xdGVnZw4PIR7okEkl2bnAhanPZbtH1gohh0edNKw1ubOidD0uZ6oYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jIbxCO4o; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 09396240017;
	Mon, 29 Jul 2024 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lnsu/Wi7dGj1nJVAQ+x0DLiP3zgedc4tHolE2i3TsXs=;
	b=jIbxCO4oG7wm2lbIMUDqM4FGW33R5m+Wx+bt9eT4XSej5NCngci4tYAd1K1lbnlnMPOvoy
	NxEdfrKdNzlHlK8ZyGo2NdnyhzMggftF8RiQUjzIZtjswTtDansXOwhhvod562UT4hZHri
	E4T9A/octqZV7WkA85rSXEHnlnPDzCePegDF+Hfq6tfTwhDU0EyWbBL7VdYAMWORyhfznS
	lyW3MGNHAlP4+xGYlfHv6dPmlXG7tDl4Vf1PCaKSx+/BcH4Hz98y5jPs/q0Dgiy39TK3Du
	efUP8E/CfpJcxrGQITKMNwoml/sHhQutWrogYxHICyLAioxqBKT/NvifQJfXKQ==
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
Subject: [PATCH v1 13/36] soc: fsl: cpm1: tsa: Introduce tsa_version
Date: Mon, 29 Jul 2024 16:20:42 +0200
Message-ID: <20240729142107.104574-14-herve.codina@bootlin.com>
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

Current code handles CPM1 version of TSA.

In order to prepare the support for the QUICC Engine (QE) version of
TSA, introduce tsa_version to identify versions. This will enable the
code to make the distinction between several TSA implementations.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 48a176cece86..3b7c9766e25c 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -114,12 +114,17 @@ struct tsa_tdm {
 #define TSA_TDMA	0
 #define TSA_TDMB	1
 
+enum tsa_version {
+	TSA_CPM1 = 1, /* Avoid 0 value */
+};
+
 struct tsa {
 	struct device *dev;
 	void __iomem *si_regs;
 	void __iomem *si_ram;
 	resource_size_t si_ram_sz;
 	spinlock_t	lock; /* Lock for read/modify/write sequence */
+	enum tsa_version version;
 	int tdms; /* TSA_TDMx ORed */
 	struct tsa_tdm tdm[2]; /* TDMa and TDMb */
 	struct tsa_serial {
@@ -685,6 +690,15 @@ static int tsa_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	tsa->dev = &pdev->dev;
+	tsa->version = (enum tsa_version)of_device_get_match_data(&pdev->dev);
+	switch (tsa->version) {
+	case TSA_CPM1:
+		dev_info(tsa->dev, "CPM1 version\n");
+		break;
+	default:
+		dev_err(tsa->dev, "Unknown version (%d)\n", tsa->version);
+		return -EINVAL;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(tsa->serials); i++)
 		tsa->serials[i].id = i;
@@ -746,7 +760,7 @@ static void tsa_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tsa_id_table[] = {
-	{ .compatible = "fsl,cpm1-tsa" },
+	{ .compatible = "fsl,cpm1-tsa", .data = (void *)TSA_CPM1 },
 	{} /* sentinel */
 };
 MODULE_DEVICE_TABLE(of, tsa_id_table);
-- 
2.45.0


