Return-Path: <linux-kernel+bounces-222280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F98C90FF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4546C1F2322A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560AE1AAE11;
	Thu, 20 Jun 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BYraRfk7"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52019FA6B;
	Thu, 20 Jun 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873003; cv=none; b=iqkVTaGmmPF0PXnLhz66uQxgezpeOVJXXMQhnZc/XIyAA921HjyvtAJE2QRO68z//selrkE1XsNvT9LXSL+oUcJZCkMb7XXEsCq/UTjHsxwDxPXjtiedmrInFGy9IxHJxdmZzkYAx1yzvTllhtmr39nI2w9dGRtRHQE2JcRCqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873003; c=relaxed/simple;
	bh=/gkMygh09ZpiD7BTBSHMvPXyxlus217LmQzwwIIdnOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8CoR246Wt7boWwvPwg7uTnRX1s/2rpxc+CWttzl4kne5+WRwaB0G714rfDJsElLX9K1RZvcQvy34eeGl0qRWSEoauAbf8vvj1Du3WKwSMPd9nAsY2/SESSPeocP4ki+aEsFNrX9ameVp5oADhUeuZC/b/57yQWRzwtnP32mcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BYraRfk7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5E33D20012;
	Thu, 20 Jun 2024 08:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718872999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDLRcTY0BkTaFAdlLFjztJqIMTmDai9TLYinXM16row=;
	b=BYraRfk7fEz5L1838NbMQUtgasaGC3yafWba1AA59mzifxKYEytwkNwf8SyIWpTY3kgf6B
	XVylMtJ5iP8zPd51l9KZueVKs9oinG3sl6rbBmqPv7N/6EmTdGrluo/VNLTg6qjw1NVJ5K
	FxI9ONYG7CI54wUSXtP8pOp/P6Q7OuDTS/4XCYA8fJ3iZ5xX/HN37b9QFIO0OqRZskePlB
	L91Bt6v+i5rN5HUE8T5+kkQFZ0M0AKz8O/Spdg6uN9XAhBPsCZbP6cwciBfrvrhyDFvpEf
	ggReD1B+0vtfuCPOfKDWeEOU4Tr4aTq27ArjK8IYP4XQs5WublUbr+biTu74ig==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 08/10] soc: fsl: cpm1: qmc: Introduce qmc_chan_count_phandles()
Date: Thu, 20 Jun 2024 10:42:55 +0200
Message-ID: <20240620084300.397853-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620084300.397853-1-herve.codina@bootlin.com>
References: <20240620084300.397853-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

No function in the QMC API is available to get the number of phandles
present in a phandle list.

Fill this lack introducing qmc_chan_count_phandles().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 13 +++++++++++++
 include/soc/fsl/qe/qmc.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index e23d60018400..76bb496305a0 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1777,6 +1777,19 @@ static struct qmc_chan *qmc_chan_get_from_qmc(struct device_node *qmc_np, unsign
 	return qmc_chan;
 }
 
+int qmc_chan_count_phandles(struct device_node *np, const char *phandles_name)
+{
+	int count;
+
+	/* phandles are fixed args phandles with one arg */
+	count = of_count_phandle_with_args(np, phandles_name, NULL);
+	if (count < 0)
+		return count;
+
+	return count / 2;
+}
+EXPORT_SYMBOL(qmc_chan_count_phandles);
+
 struct qmc_chan *qmc_chan_get_byphandles_index(struct device_node *np,
 					       const char *phandles_name,
 					       int index)
diff --git a/include/soc/fsl/qe/qmc.h b/include/soc/fsl/qe/qmc.h
index 0fa7205145ce..294e42ea8d4c 100644
--- a/include/soc/fsl/qe/qmc.h
+++ b/include/soc/fsl/qe/qmc.h
@@ -16,6 +16,8 @@ struct device_node;
 struct device;
 struct qmc_chan;
 
+int qmc_chan_count_phandles(struct device_node *np, const char *phandles_name);
+
 struct qmc_chan *qmc_chan_get_byphandles_index(struct device_node *np,
 					       const char *phandles_name,
 					       int index);
-- 
2.45.0


