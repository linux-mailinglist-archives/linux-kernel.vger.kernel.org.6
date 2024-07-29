Return-Path: <linux-kernel+bounces-265914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 458C793F7A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDCB1F2263B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FB01850B6;
	Mon, 29 Jul 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T87FFSHG"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B615B980;
	Mon, 29 Jul 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262890; cv=none; b=YMOOSEsG2rniI1ZnnmluD7leGGjCCmx2laJvyeX+bWacGtnzKHEvnv2B4BebUZ61uSuSbpMSG3ZkTymHFw/GzEn1R1bwX97a1OOX3nHb2zqFUkQGG753VUmKStuCE1F/Gbq2mJ/Wuy+9enOwLDIv1wmIxIk3Wa8N9oSSf45qI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262890; c=relaxed/simple;
	bh=/isJqhX0wc1gBoR8hJcc/nq5Quca5I5XRhWcTftG2TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEx2x3Y73axy8kUZbn6C2gcDxzR8h28ml5WLG5Xhj1f+3sdTnegx1iENYnhaqZEO96rLT0o2gytD10kFyQYXYr+vt3hnbDz0zTOpe8zzEO25N7UIYVOadpfnSQrE/dc7hyhYw4pHtrUxb7Z/HG7RygMn5XdGd5/VIEc7VxDpnHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T87FFSHG; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 319E424000E;
	Mon, 29 Jul 2024 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAf7s/eP3L8mn/lGwD5+87QN5e2WmIXtMVVg3YPEXOQ=;
	b=T87FFSHGw01O03BzCFNWmLxnA04y+TUXnRmHIkC42hQyIPwfhOOVx/YtqivY7C3kFuipkY
	ZlufrM/JuG7wHm+P4yaGyH1dtD0y5HQIIWZIBP7GCChJSIblMxN0w22geiysW23qqbNhie
	pZQI7xeOQmHvXo4WJQpO7PeFPBtZYb652UOIHEHixSiplj3oSWL5nmMWVQAe1/HgVNlBh7
	073TBU+3iiXul+d/jF5XyJHjbXACUATXJNPH72wZEjX66gKIFgpSCRMT8qTDg/BF5QdzRA
	1Ntyxp8Wak6Ah83PdQCIt0zxGAWNXpszCC3qwLP9OZ93IduMsQd+Kl6dFxPjsQ==
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
Subject: [PATCH v1 16/36] soc: fsl: cpm1: tsa: Introduce tsa_serial_get_num()
Date: Mon, 29 Jul 2024 16:20:45 +0200
Message-ID: <20240729142107.104574-17-herve.codina@bootlin.com>
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

TSA consumers in CPM1 implementation don't need to know about the serial
device number used by the TSA component. In QUICC Engine implementation,
this information is needed.

Improve the TSA API with tsa_serial_get_num() in order to provide this
information.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 56 ++++++++++++++++++++++++++--------------
 drivers/soc/fsl/qe/tsa.h |  3 +++
 2 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index ffbca329a226..beaa0d3524be 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -231,6 +231,39 @@ static bool tsa_is_qe(const struct tsa *tsa)
 	return IS_ENABLED(CONFIG_QUICC_ENGINE);
 }
 
+static int tsa_qe_serial_get_num(struct tsa_serial *tsa_serial)
+{
+	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
+
+	switch (tsa_serial->id) {
+	case FSL_QE_TSA_UCC1: return 0;
+	case FSL_QE_TSA_UCC2: return 1;
+	case FSL_QE_TSA_UCC3: return 2;
+	case FSL_QE_TSA_UCC4: return 3;
+	case FSL_QE_TSA_UCC5: return 4;
+	default:
+		break;
+	}
+
+	dev_err(tsa->dev, "Unsupported serial id %u\n", tsa_serial->id);
+	return -EINVAL;
+}
+
+int tsa_serial_get_num(struct tsa_serial *tsa_serial)
+{
+	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
+
+	/*
+	 * There is no need to get the serial num out of the TSA driver in the
+	 * CPM case.
+	 * Further more, in CPM, we can have 2 types of serial SCCs and FCCs.
+	 * What kind of numbering to use that can be global to both SCCs and
+	 * FCCs ?
+	 */
+	return tsa_is_qe(tsa) ? tsa_qe_serial_get_num(tsa_serial) : -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(tsa_serial_get_num);
+
 static int tsa_cpm1_serial_connect(struct tsa_serial *tsa_serial, bool connect)
 {
 	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
@@ -271,26 +304,9 @@ static int tsa_qe_serial_connect(struct tsa_serial *tsa_serial, bool connect)
 	int ucc_num;
 	int ret;
 
-	switch (tsa_serial->id) {
-	case FSL_QE_TSA_UCC1:
-		ucc_num = 0;
-		break;
-	case FSL_QE_TSA_UCC2:
-		ucc_num = 1;
-		break;
-	case FSL_QE_TSA_UCC3:
-		ucc_num = 2;
-		break;
-	case FSL_QE_TSA_UCC4:
-		ucc_num = 3;
-		break;
-	case FSL_QE_TSA_UCC5:
-		ucc_num = 4;
-		break;
-	default:
-		dev_err(tsa->dev, "Unsupported serial id %u\n", tsa_serial->id);
-		return -EINVAL;
-	}
+	ucc_num = tsa_qe_serial_get_num(tsa_serial);
+	if (ucc_num < 0)
+		return ucc_num;
 
 	spin_lock_irqsave(&tsa->lock, flags);
 	ret = ucc_set_qe_mux_tsa(ucc_num, connect);
diff --git a/drivers/soc/fsl/qe/tsa.h b/drivers/soc/fsl/qe/tsa.h
index d9df89b6da3e..da137bc0f49b 100644
--- a/drivers/soc/fsl/qe/tsa.h
+++ b/drivers/soc/fsl/qe/tsa.h
@@ -39,4 +39,7 @@ struct tsa_serial_info {
 /* Get information */
 int tsa_serial_get_info(struct tsa_serial *tsa_serial, struct tsa_serial_info *info);
 
+/* Get serial number */
+int tsa_serial_get_num(struct tsa_serial *tsa_serial);
+
 #endif /* __SOC_FSL_TSA_H__ */
-- 
2.45.0


