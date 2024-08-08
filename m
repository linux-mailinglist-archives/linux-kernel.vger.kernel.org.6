Return-Path: <linux-kernel+bounces-278972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8256394B745
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438542829D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B59189F59;
	Thu,  8 Aug 2024 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kOoz4VOr"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A22188CDE;
	Thu,  8 Aug 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101112; cv=none; b=hJPmvUt++LhKfhuxWX2yzC2gqo7gyBxGp4oIYjz8Tr7AUC+1idkk8EtCYeh6VJh9SmeVOUzeYX2tVRTHYF777glXqYvua/vte+MfcUtOZbzs9d3MRPb7EyQSlKKbZt29CM9vdG4K07wjQgBb4FAz2poqiaVhoKBi1vH/tUDxRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101112; c=relaxed/simple;
	bh=hTzato8cKaoO4hbl5oUIJo38WLktHOkgo5DHuEApC2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHPQLtK7GULHqL3t/E9bxz6H+s4jEfGw3bVT0eIz5dU6aDEOLyzbCojlSu/JVdShJL95TjVjP0NyEJqrO/kwQqbj9CAM3g5lgaYWUjxL2DknjVSy9x1PBuZOAWrBwP2+5Zho3svPqTVbBQHCEOgtQEIEAPdeDXtTq7f9vB4dcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kOoz4VOr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E6863C0017;
	Thu,  8 Aug 2024 07:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dyUVFs5n9icwfFDf1qikeUi9uMwaDds5yIaZ8cg5fuI=;
	b=kOoz4VOr+fQPScZvExImHIkbNbbQp48YiwIY+ybND/w/ygFQd+P48w+KoUDUHZ2tNy+bYX
	C+v+oYEJAXxhoUw1+O5aRhC0/moDm/33O8s7B/CZVetduPEAAFIAv7PG6GFNEupeY90afk
	RpYu0mbvra2+1QHFUM2uiPyToLOSf25G7CfcdRCI5M5YBiIQ8pe7DyWmjFAeTwHdlTbDg5
	IfF27I5I4L9GdUpwLRyoO1PbOhfizLf1BELokUGwyAqfSQocXUyTHEOv3FegJrjer/ZF04
	q4OLsEEVKgRtzNzTKg7c/AaV200R7jABVVGaAu+v4nnDXf/HcRhQZQig6+JoAw==
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
Subject: [PATCH v2 13/36] soc: fsl: cpm1: tsa: Introduce tsa_version
Date: Thu,  8 Aug 2024 09:11:06 +0200
Message-ID: <20240808071132.149251-14-herve.codina@bootlin.com>
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

Current code handles CPM1 version of TSA.

In order to prepare the support for the QUICC Engine (QE) version of
TSA, introduce tsa_version to identify versions. This will enable the
code to make the distinction between several TSA implementations.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 48a176cece86..297721a0d2b6 100644
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
+	tsa->version = (enum tsa_version)(uintptr_t)of_device_get_match_data(&pdev->dev);
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


